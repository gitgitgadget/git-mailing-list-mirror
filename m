From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Thu, 2 May 2013 02:34:01 +0530
Message-ID: <CALkWK0nL+UvjsUKh6v4x_MaWJmsU6Uh_gh82iE7UT0UE-ZMt0g@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-2-git-send-email-artagnon@gmail.com> <7va9oe5y6k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 01 23:04:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXeCl-0007vj-Au
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 23:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757217Ab3EAVEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 17:04:44 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:43797 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756740Ab3EAVEm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 17:04:42 -0400
Received: by mail-ia0-f171.google.com with SMTP id r13so1714279iar.16
        for <git@vger.kernel.org>; Wed, 01 May 2013 14:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=44bdlqkILBwZgmV+aQuSMVb9vC/mkJ7tMQRILdZX2Ho=;
        b=lrW07p0jag4EjiW1J7L0uEfpm/OGciPdq96RpZGLY0aDtLbEzLiAXoFfaiLITvrHtP
         hJdQPOoEqzDQHM+Orj36lCwd2/jiRAcX5BiDLL1Jlfv8Opc51rHI3D76eiEtNxWfkTKG
         Xz3iLgqb6iIYbUm87dhc2RPiWQ5HxyxPOjeLNvIdPgL0WHjexHIU6QSLnAumAOblkZX6
         n+eQBEt/zPuqLoYaTKHqh0rdV9nX8T22mIAFa1LRSNh8MCNTDXGSf6eS9WR0hmZaiVBV
         Hv2LmNEvrOWkIeqfs57cxUcxqVW1nc0jpasLeRsJix9Zyw7KJuR5bkd1HNdYFBMEPiv3
         eaoA==
X-Received: by 10.50.3.38 with SMTP id 6mr2628546igz.44.1367442282167; Wed, 01
 May 2013 14:04:42 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 14:04:01 -0700 (PDT)
In-Reply-To: <7va9oe5y6k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223144>

Junio C Hamano wrote:
> Just making sure.  HEAD@{$n} and @{$n} for non-negative $n mean
> totally different things.  @{0} and HEAD@{0} are almost always the
> same, and @{1} and HEAD@{1} may often happen to be the same, but as
> a blanket statement, I find "Since HEAD is implicit in @{}" very
> misleading.

When will they be different?  I'm looking at this from the parser's
point of view: when the part before @{} is missing, we dwim a "HEAD".

> As you and Felipe seem to be aiming for the same "Let's allow users
> to say '@' when they mean HEAD", I'll let you two figure the best
> approach out.

I've solved the problem in the general case of symbolic-refs and made
"@" a special case of that.

> One productive way forward might be to come up with a common test
> script pieces to document what constructs that spell @ in place of
> HEAD should be supported,

It's sufficient to test that symbolic refs work properly.  @ is a
trivial implementation of a pseudo symbolic-ref (see [5/5]).

> and much more importantly, what constructs
> that happen to have @ in them should not mistakenly trigger the new
> machinery.

At the parsing level, @ can only ever interfere with @{}; I've added
tests for those.
