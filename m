From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: BUG? in --dirstat when rearranging lines in a file
Date: Thu, 7 Apr 2011 15:59:33 -0700
Message-ID: <BANLkTi=cAOduobWXfd=EeVgE4fHo=G-DTg@mail.gmail.com>
References: <201104071549.37187.johan@herland.net> <BANLkTinEipewx2+Cx7Us0BSoSbjjU9uE6A@mail.gmail.com>
 <7vsjtt65t9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	tutufan@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 01:24:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7yZ1-0008G6-3A
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 01:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757159Ab1DGXY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 19:24:29 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43641 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753038Ab1DGXY3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 19:24:29 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p37NOSp0002462
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 7 Apr 2011 16:24:28 -0700
Received: by iwn34 with SMTP id 34so2947703iwn.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 16:24:27 -0700 (PDT)
Received: by 10.42.140.8 with SMTP id i8mr2308757icu.470.1302217193124; Thu,
 07 Apr 2011 15:59:53 -0700 (PDT)
Received: by 10.231.11.4 with HTTP; Thu, 7 Apr 2011 15:59:33 -0700 (PDT)
In-Reply-To: <7vsjtt65t9.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-102.985 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171095>

On Thu, Apr 7, 2011 at 3:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Speaking of that logic, I've been wondering for about a year and a half if
> this "if (permille)" exclusion was intentional:
>
> If the user sets dir->percent to zero, with an expectation that it will
> disable all filtering, shouldn't we show everything?

Hmm. My gut feel is that you still don't want to see directories with
no changes. In fact, doesn't the whole "avoid even diffing identical
directories with the same SHA1" logic end up meaning that even if you
were to disable filtering, you'd _still_ not show the 0% case?

But hey, I dunno. If you want the semantics to be "not identical, but
not damaged enough to be even 0.1%, so show it", I don't think that
would be _wrong_ per se. I just don't think our current "ignore 0.0%
files" is wrong either ;)

                           Linus
