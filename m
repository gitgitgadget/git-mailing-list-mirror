From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Tackling Git Limitations with Singular Large Line-seperated
 Plaintext files
Date: Fri, 27 Jun 2014 13:13:57 -0700
Message-ID: <CA+55aFyaQJDq4dvPyS3oLJp57J_zEmqbXA5UxzL8fdgAaHpJOA@mail.gmail.com>
References: <CAJoVafc1LMxmvCiWci3N+AuAZBsABR3Wb3c6c3stw93OJZ7Scw@mail.gmail.com>
	<CAJo=hJtJCy96SRYmOxEpEMoEVcaegv0SCG0_AH2u0=bSrHZi_A@mail.gmail.com>
	<xmqqegya2qgu.fsf@gitster.dls.corp.google.com>
	<CA+55aFx6vFyZvpyQot_3Ym7wsCZ06abjNx_hEKkza-N856jMnw@mail.gmail.com>
	<57F015EB50E54211BF29FE1F6DE05CF4@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jarrad Hope <me@jarradhope.com>, git <git@vger.kernel.org>
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Fri Jun 27 22:14:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0cX5-0008Fs-Da
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 22:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbaF0UN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 16:13:59 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:42461 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbaF0UN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 16:13:58 -0400
Received: by mail-vc0-f176.google.com with SMTP id ik5so5557111vcb.35
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XJ02y3XDLDGivlSlfhmjzfXuJgesbWwrg/OozB2rPhI=;
        b=puumAPyNZnDob6/IwB5VYPJpclCgUzB6rv9NDwnNQHLY8tp2gDajRA36r5733S2tR6
         I5lsInRJBIpmOIYqXkChGX7zydAY+dimDc1RrfGMCsHow8BngC+vnpWKsmtEijK4XCme
         pxHFj+afVUr7LE8AVnCZsXKd48rJTS8lCdUE0C4FGMxA5zUPw/VxOilfTydPOE9AdIBP
         RUwPzGOLcbtSfbO8JdynLBSJ+DnqOHZgkoMv8tVoStIwmjl25a3+z+Ffz/KglaJYmgjM
         yDmGBpTZzl3/rp/xnmpjdM4JjJDMwVmUuyzFfjCLZ1tOZ4D9AAQ/UVEoqzvVSbs/Nhmu
         5RtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XJ02y3XDLDGivlSlfhmjzfXuJgesbWwrg/OozB2rPhI=;
        b=PtnWLyHFlPxmY1cF5OeaVHnLbkUAnBEjBatbGIWAjeVdLXle5pROfHdxg+p9udyYXo
         2dWcbPZbkQDB5WeAceJEFh39Ao5KJOjAS7gQyItyCqQ4rKsW7dSNiSCD527cbYPvnLTS
         CDcO9So6H3FT2dPQcGXdJ6GiwTksVUQBuJusQ=
X-Received: by 10.52.75.202 with SMTP id e10mr2584912vdw.54.1403900037763;
 Fri, 27 Jun 2014 13:13:57 -0700 (PDT)
Received: by 10.221.58.77 with HTTP; Fri, 27 Jun 2014 13:13:57 -0700 (PDT)
In-Reply-To: <57F015EB50E54211BF29FE1F6DE05CF4@black>
X-Google-Sender-Auth: vsMuPok4acwsDxiySOOnuu5SPo4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252578>

On Fri, Jun 27, 2014 at 12:55 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
>
> The issue will be, if we talk about changes other than same length substitutions
> (e.g. Down's Syndrome where it has an insertion of code) would require one code
> per line for the diffs to work nicely.

Not my area of expertise, but depending on what you are interested in
- like protein encoding etc, I really think you don't need to do
things character-per-character. You might want to break at interesting
sequences (TATA box, and/or known long repeating sequences).

So you could basically turn the "one long line" representation into
multiple lines, by just looking for particular known interesting (or
known particularly *UN*interesting) patterns, and whenever you see the
pattern you create a new line, describing the pattern ("TATAAA" or
"run of 128 U"), and then continue on the next line.

Then you diff those "semantically enriched" streams instead of the raw data.

But it probably depends on what you are looking for and at. Sometimes
you might be looking at individual base pairs. And sometimes maybe you
want to look at the codons, and consider condons that transcribe to
the same amino acid to be the same, and not show up as a difference.
So I could well imagine that you might want to have multiple different
ways to generate these diffs. No?

               Linus
