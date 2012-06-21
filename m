From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v3] diff-no-index: exit(1) if 'diff --quiet <repo file>
 <external file>' finds changes
Date: Thu, 21 Jun 2012 11:07:12 -0400
Message-ID: <CAFouethNTzcWq_YKzGz+jRTeCjKZEC2ZYMZuQxkF+5AOTC=x-A@mail.gmail.com>
References: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
	<7vr4tc2xhy.fsf@alter.siamese.dyndns.org>
	<CAFouethcrw3vOF7SPwHxjH4ABmF8U1df0MfyzcUGq2yTYxs4ow@mail.gmail.com>
	<20120619135814.GA3210@sigill.intra.peff.net>
	<CAFouetgRq1qkqJmThJJeu=Mdx9jS0c9dw7NPSwuJUOSpskCY2A@mail.gmail.com>
	<CAFouetgXkqJPYwjr5ob5ed_ooL-D56zXyjnOAWrVPdt_eZqw7g@mail.gmail.com>
	<20120620160607.GA12856@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 21 17:07:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shiyi-0006Rq-I7
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 17:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759207Ab2FUPHP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jun 2012 11:07:15 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38112 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758948Ab2FUPHN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2012 11:07:13 -0400
Received: by yenl2 with SMTP id l2so551343yen.19
        for <git@vger.kernel.org>; Thu, 21 Jun 2012 08:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SIUt1COUO2+1wzxS5+8eL88cLg7Z0RChw7wn6CkuVP8=;
        b=GlhwXmExVDBstUJT0gWKxAfLnbnEmH7OByYYnlwbBeQkVemojSClZfq2DvVYz6O8+X
         VEoCSyhxG4F3JpKrA+UtZ73wcTlpsnaaFgiTTFcrMj4QyMZM+BPkWQheCDNjLE9K1j3g
         RqqkvO4pGgU5oFBxloRHmukwWDjtcyfA16Ic724V4ec2v7fdAloEwIFWECTap74/V86b
         ABAMk69QqPJIqKOKynamEGZ+ewtH83Wlq5UEmGrv2EsAlOonxgCQb+xoiEBY/IZDpbc/
         Frx1FW55PwfsWUhPwI6evIipjBu1jKg1+mkhIHTiSoF2p2RFmDRDIOD4ceAt22zBjC2j
         7CHA==
Received: by 10.42.80.6 with SMTP id t6mr8593401ick.15.1340291232737; Thu, 21
 Jun 2012 08:07:12 -0700 (PDT)
Received: by 10.231.84.147 with HTTP; Thu, 21 Jun 2012 08:07:12 -0700 (PDT)
In-Reply-To: <20120620160607.GA12856@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200403>

On Wed, Jun 20, 2012 at 12:06 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 20, 2012 at 09:38:15AM -0400, Tim Henigan wrote:
>>
>> Are you planning to send this patch to the list? =C2=A0If not, can I
>> include it as 1 of 2 before my patch? =C2=A0If we go that route, I'm=
 not
>> sure how to properly show you as the author...
>
> I'd probably get to it eventually, but I haven't touched it since I s=
ent
> it. If you want to include some tests and package it with a commit
> message, that would make me very happy.

Thanks, I will do that.

It looks like the best place to add tests is t4010-diff-pathspec.sh.
The only cases not tested through other means appear to be:

    git diff <file in repo> <relative path outside repo>
    git diff <relative path outside repo> <relative path outside repo>

Other pathspec variations seem to be covered extensively by other
tests (mostly as a side effect).  Am I missing other variations that
should be checked?

In both cases shown above, we are simply verifying that giving a
relative path to diff does not cause it to abort.  So it may be
sufficient to only test one of the above.

The tests that I added to t4035-diff-quiet.sh already cover both of
the cases listed above.  Is it worthwhile to duplicate some of those
tests in t4010?
