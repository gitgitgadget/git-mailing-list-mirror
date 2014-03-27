From: Johan Herland <johan@herland.net>
Subject: Re: Possible regression in master? (submodules without a "master" branch)
Date: Fri, 28 Mar 2014 00:27:29 +0100
Message-ID: <CALKQrgeLY2ziW2jOoWgNcsBR6EE4rnmkYN6Z1iiGXDtiECE8og@mail.gmail.com>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
	<20140327155208.GM4008@odin.tremily.us>
	<53345E85.7070205@web.de>
	<xmqq8urvebok.fsf@gitster.dls.corp.google.com>
	<5334AC59.7010605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	Git mailing list <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 28 00:27:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTJiJ-0006Ua-CU
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 00:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757409AbaC0X1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 19:27:50 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:63979 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757398AbaC0X1e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 19:27:34 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WTJhs-0005ZZ-RT
	for git@vger.kernel.org; Fri, 28 Mar 2014 00:27:33 +0100
Received: by mail-pd0-f169.google.com with SMTP id fp1so4037987pdb.0
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 16:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oP1zP9TIfGsyZManuE3nUeAeGB9QLS+vcyIMaZp6Frk=;
        b=hSZoMG2OFVXbJJRyLFij9GxQUxcnZAg7j1SpU95jEmfqXfME4WHMpTChRaSQwz+T4M
         Wh1dCGMNGndn9BTgOfsk1uiXc2t3pjbtKfgTvtifIdgoY75MZV8iXT529jo3KjqhCU7o
         +4IB/1wbnJlIAwhgWLQUS6BWFETmh65MmnmOUdaHcl39i2e8HVKOkSxjHYKeS7gjZeST
         k3yzZq55mF/UCgJozsLTEWMFwI9sTufMM/KJvA2QpK4Lj4s6U8DxDwG3wyjfSciVsPJz
         lZTyX3QWbacMqfM0NtCvhb1EHXW3aCZ08dJWeRiMIR8ZGrnRpjXjldVFeuLguvP+AQdi
         yEDw==
X-Received: by 10.66.156.4 with SMTP id wa4mr4761184pab.49.1395962849324; Thu,
 27 Mar 2014 16:27:29 -0700 (PDT)
Received: by 10.70.48.232 with HTTP; Thu, 27 Mar 2014 16:27:29 -0700 (PDT)
In-Reply-To: <5334AC59.7010605@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245340>

On Thu, Mar 27, 2014 at 11:55 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 27.03.2014 19:30, schrieb Junio C Hamano:
>>  - For a repository that does not have that "branch" thing
>>    configured, the doc says that it will default to 'master'.
>>
>>    I do not think this was brought up during the review, but is it a
>>    sensible default if the project does not even have that branch?
>>
>>    What are viable alternatives?
>>
>>    - use 'master' and fail just the way Johan saw?
>>
>>    - use any random branch that happens to be at the same commit as
>>      what is being checked out?
>>
>>    - use the branch "clone" for the submodule repository saw the
>>      upstream was pointing at with its HEAD?
>>
>>    - something else?
>
> Good question. Me thinks that when a superproject doesn't have
> 'branch' configured and does set 'update' to something other than
> 'checkout' for a submodule it should better make sure 'master'
> is a valid branch in there. Everything else sounds like a
> misconfiguration on the superproject's part that warrants an
> error. But I may be wrong here as I only use 'checkout' together
> with a detached HEADs myself. Comments welcome.

I believe unset 'branch' and 'update' != 'checkout' is somewhat
analogous to unset branch.<name>.merge while pulling. I.e. "you have
told me to merge/rebase, but you have not told me against which
branch, therefore error out".

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
