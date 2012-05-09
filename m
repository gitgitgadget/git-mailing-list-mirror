From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 4/4] allow recovery from command name typos
Date: Wed, 9 May 2012 23:06:59 +0800
Message-ID: <CALUzUxpF0zn0V89BcayavbVs6muuXPv4+eYWgCWJn90hj6s6hQ@mail.gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
	<1336287330-7215-2-git-send-email-rctay89@gmail.com>
	<1336287330-7215-3-git-send-email-rctay89@gmail.com>
	<1336287330-7215-4-git-send-email-rctay89@gmail.com>
	<1336287330-7215-5-git-send-email-rctay89@gmail.com>
	<20120506082130.GB27878@sigill.intra.peff.net>
	<CALUzUxqXrsB8XfQL6vOiQo1pLHNRjxRUxJLRiK_mcSU8fvTSCg@mail.gmail.com>
	<878vh4con4.fsf@thomas.inf.ethz.ch>
	<7v62c77uss.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 09 17:07:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS8Tt-0007IL-HQ
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 17:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757975Ab2EIPHB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 11:07:01 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33154 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab2EIPHA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 11:07:00 -0400
Received: by wibhn19 with SMTP id hn19so435025wib.1
        for <git@vger.kernel.org>; Wed, 09 May 2012 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=onHyYF2r9A+vL1aguoJ7MoNJHFeffcztHQC2ad+7rls=;
        b=Y2QeoI1yyan1lN5GZ/XbxugWKASxXIem098BALVJ45tlCCxPy11dX76dJvRMlgNc4l
         q0FHvu6aHhP4LzdZG976qUY5WhegsAIWSSSuINvGzvBQvhHG06fPbU3GWWOoEYyzleD7
         /ft1PAuZmuKbAHY6gcStmgPm0d80qctg8CGRAjAp1NsyNiWqOqUpovHjUqVY/Qe8NgUe
         FLYwxsjQq7nB6gWr2WLVPNXrj7pH1A3ytolSEyDG0zJktMNpYhAhxHnoGD3ukPmtCkWo
         YZAmCC3H3A3gV55AKdkgJ3cHFxZfM5945wBubQAXlk+FW2pmkEX69BsOUgTZgduCx7ZA
         RjXg==
Received: by 10.180.83.38 with SMTP id n6mr1200537wiy.4.1336576019544; Wed, 09
 May 2012 08:06:59 -0700 (PDT)
Received: by 10.223.156.136 with HTTP; Wed, 9 May 2012 08:06:59 -0700 (PDT)
In-Reply-To: <7v62c77uss.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197475>

On Tue, May 8, 2012 at 1:41 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> By the way, does anybody actually use the deciseconds grace period to=
 ^C
> the process? =A0I know I was the guilty party for suggesting it, but =
it
> strikes me that it is rather a dangerous option. =A0When checking out
> another branch with great difference with "git chekcout foo", you wou=
ld be
> asked "did you mean checkout?", and if you hit ^C a bit too late, you=
 may
> not kill autocorrect but end up killing a lengthy "checkout" in the
> middle, messing up the working tree with a mixture of files in old an=
d new
> branches, needing a "reset --hard" to recover. =A0We might want to up=
date
> the documentation to warn about this, even though I personally do not
> think it is worth removing the support (and going through the trouble=
 of
> having to deal with "why did you remove the useful feature" complaint=
s).
>

Actually, I've never heard of that feature, until I was reading help.c.

However, it's listed on Progit [1], so I'd imagine there'd be *some*
users in the wild.

[1] http://git-scm.com/book/ch7-1.html

Personally, I think it's a little dangerous - imagine your script has
a typo'd command that just runs anyway if help.autocorrect without any
chance for user intervention. Perhaps there should be a isatty(2)
check to guard it, like the prompting patch does.

--=20
Cheers,
Ray Chuan
