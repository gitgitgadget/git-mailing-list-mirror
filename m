From: James Pickens <jepicken@gmail.com>
Subject: Re: 'git clone' doesn't use alternates automatically?
Date: Sat, 31 Jan 2009 14:43:13 -0700
Message-ID: <885649360901311343r2a9bd1b5l5f8226218000dbe8@mail.gmail.com>
References: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com>
	 <20090131071238.GC3033@coredump.intra.peff.net>
	 <885649360901311208s4bc17ae3me2062b07b302291e@mail.gmail.com>
	 <m3tz7fw5ek.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 31 22:44:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTNds-0007bx-P1
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 22:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbZAaVnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 16:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbZAaVnQ
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 16:43:16 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:36351 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbZAaVnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 16:43:15 -0500
Received: by wa-out-1112.google.com with SMTP id v33so460758wah.21
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 13:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XTY4W3w9ez3SrwuHVsexgPUS+puh2XmCTmbj7oYqR4I=;
        b=V3iM2J+090AAF4YZRFs7gLQrSxK0wf3uvEugdJKW2FXwmwLMK8O7Mlm34balSTcZi4
         cNtb+ZJ24Yhoi8yonBdfCykPKndmEQZ9JF9hAlELvvvnCs7YKxaL6/XWRLyvURGqRC8M
         OMOlzBvUEn7aCDlKvSkGE3bbIVA8U9It9QaaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HC7VeSlKNsWkK0jU0fPEa4aq5iaHMon6Xa7oQt7ZJXwVgE6afjpY9xgi9EEZf57ruL
         piOzsEwAprIo1Q8IvMK2B91KWZEQzXNUdQfkEWcz375jxYt/R3MAqejca4iOqzJjrTXX
         qlSR6JwsaKR0H324WaU6rhEjbHBMniS/PlzLw=
Received: by 10.114.193.15 with SMTP id q15mr623599waf.199.1233438193783; Sat, 
	31 Jan 2009 13:43:13 -0800 (PST)
In-Reply-To: <m3tz7fw5ek.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107941>

On Sat, Jan 31, 2009 at 2:08 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> James Pickens <jepicken@gmail.com> writes:
>
>> So, is there any reason 'git clone' shouldn't automatically use
>> the alternates that it copied into the new repository?  I might
>> look into writing a patch if nobody objects.
>
> Alternates are fragile with respect to garbage collecting in the
> repository you borrow objects from.

I think that's irrelevant in this case.  The scenario is that I
clone repo A, which is borrowing objects from repo B.  So repo A
was already assuming that it's safe to borrow from B.

The current behavior is that the clone of A also borrows from B
automatically.  What I am asking is whether 'git clone' should
take advantage of that to avoid copying redundant objects from A
into the clone.  They will get deleted the first time I run 'git
gc' in the clone anyways.

James
