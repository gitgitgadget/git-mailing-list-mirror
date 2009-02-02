From: "Raimund Berger" <raimund.berger@gmail.com>
Subject: Re: Newbie question regarding 3way merge order.
Date: Mon, 02 Feb 2009 19:15:30 +0100
Message-ID: <87wsc8aenx.fsf@gigli.quasi.internal>
References: <871vulda2r.fsf@gigli.quasi.internal>
	<slrngo6eat.s1d.sitaramc@sitaramc.homelinux.net>
	<7vskmyt127.fsf@gitster.siamese.dyndns.org>
	<871vugc2c8.fsf@gigli.quasi.internal> <49871ADA.4080905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 19:17:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU3Ly-0003KZ-Mc
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 19:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbZBBSPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 13:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbZBBSPg
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 13:15:36 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:36666 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbZBBSPf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 13:15:35 -0500
Received: by fxm13 with SMTP id 13so1686551fxm.13
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 10:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:references
         :mail-followup-to:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=cS7z6iZPrDJD1klRYLBax4kigfqds9lO8CiUzLQJjk4=;
        b=ryM8SjdOisHj5hIlj+hDf6dlV1x9swR+ukC4YOLzekhjWIbwzZJGNQy3McgGu1iWaO
         c9hkE8YMqZ9HqJCEx89gt2phLYyW9fLes31Fm8JrN3Sm9L1Ivl31SuOldGq5vFxH/gVH
         SjeqCmzqqz2rSIc19AwvjZrElphDPGYovHdM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:references:mail-followup-to:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=FVb6MyjlZPb9fGVO2jBtkbrXBRffIlIxkndGg80HpjpiEd360WtbETDZyxspNVtjhN
         2YNAf2gqAt8pVrYxHEF6cAvZp+x2oASbv7Yy37oW3tdetxjchXXNIbIJhh453CX7ZkaJ
         4eKIpA/VbMK17YHeCKYujvtWpiSGvPNEXD7yw=
Received: by 10.103.5.14 with SMTP id h14mr1153700mui.108.1233598533412;
        Mon, 02 Feb 2009 10:15:33 -0800 (PST)
Received: from gigli.quasi.internal (p5DC33A7F.dip.t-dialin.net [93.195.58.127])
        by mx.google.com with ESMTPS id s10sm4839257muh.7.2009.02.02.10.15.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Feb 2009 10:15:32 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <49871ADA.4080905@viscovery.net> (Johannes Sixt's message of
	"Mon, 02 Feb 2009 17:10:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108102>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Please don't set Mail-Followup-To: here, and keep the Cc: list.
>
> Raimund Berger schrieb:
>> do the following conditions hold
>> 
>> (i)  A+B == B+A for all commits A,B
>> (ii) (A+B)+C == A+(B+C) for all A,B,C
>> 
>> where "+" designates the standard git 3way merge?
>
> I don't think that (ii) does holds in general.
>
> [ In the examples consider each letter/symbol on a line by itself; this
> saves vertical space. ]
>
> Start with this (the merge base):
>
> 	f(a)
>
> and there are three topic branches growing from here:
> A makes this (rename f->g):
>
> 	g(a)
>
> B makes this (add another f):
>
> 	f(a)f(b)
>
> C makes this (renames a->c):
>
> 	f(c)
>
> Then A+B is
>
> 	g(a)f(b)
>
> A+C is
>
> 	g(c)
>
> B+C is
>
> 	f(c)f(b)
>
> (A+B)+C is
>
> 	g(c)f(b)
>
> but A+(B+C) is ambiguous:
>
> 	g(c)f(b)
> or
> 	f(c)g(b)
>
> -- Hannes


Are you sure you're not making assumptions about "obvious" manual
resolutions? E.g. I can't quite see how A+B, which is

      g(a)----
     /        \
 f(a)          g(a)f(b) or f(a)f(b) ???
     \        /
      f(a)f(b)

would not be flagged as a conflict regarding f(a) vs. g(a).

Now, you may assume that because B leaves f(a) as it is while A changes
f(a) into g(a) that both, that change and the addition of f(b) in B,
should survive the merge. But the actual algorithm couldn't possibly
know and decide that. Same goes for other merges you do there. In fact,
in strict terms of how I defined equality, you didn't give a counter
example because neither (A+B)+C or A+(B+C) automatically resolve. It
would have been if one of them did.

And that's why I specifically "limited" my equality relation to
automatic resolutions, to simplify the discussion and deal with kind of
minimum requirements first. I didn't even mention that originally
because I felt it was so obvious.

So only the next step would be looking at how manual resolutions play
into this, and while that might be fairly intuitive in the A+B == B+A
commutativity case, associativity of course is kind of a different
ballpark. Although I'd expect somebody intimately acquainted with
merging techniques capable of maybe giving a hint or two even in that
case.
