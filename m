From: "Raimund Berger" <raimund.berger@gmail.com>
Subject: Re: Newbie question regarding 3way merge order.
Date: Mon, 02 Feb 2009 15:58:47 +0100
Message-ID: <871vugc2c8.fsf@gigli.quasi.internal>
References: <871vulda2r.fsf@gigli.quasi.internal>
	<slrngo6eat.s1d.sitaramc@sitaramc.homelinux.net>
	<7vskmyt127.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 16:00:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU0Hh-0000H1-IZ
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 16:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbZBBO6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 09:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbZBBO6z
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 09:58:55 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:60669 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbZBBO6y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 09:58:54 -0500
Received: by fxm13 with SMTP id 13so1541627fxm.13
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 06:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:references
         :mail-followup-to:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=HeaREFpTK4NIT2PFDyLoLLC/iv+zqg+5M1rtqdTOCkI=;
        b=b+9gTXyBH568uLr50O6jpIEEnC2iMoGnx+U657keF1ChLfEPA+4LhGKCjI0OzvsPgV
         2coOndId/9DVFpelL+FyVVl2/ZavpINoXFi7NiSlZ5JJcImu178ogR8FheG9Nl+uzLqW
         7IvzmPyQae8tV9rLCmpCVj10b48rgJtzs5E6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:references:mail-followup-to:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=DTLLiv1Py/eI0pO9TlRCXM4wnqCWEBBaJCtQRY7nrRq4P2XejBFjXF+rs9Una5jW+1
         OcEU2WG4cybUV94g1xM1j/orjc2MwUMnT2X731OE9td/UnqlpU8V1j1yJS0SWx1It2kg
         NcgaxuRUjETgLsS0G//kX0LCw5WITcUBuHTN8=
Received: by 10.103.228.19 with SMTP id f19mr1931236mur.18.1233586731662;
        Mon, 02 Feb 2009 06:58:51 -0800 (PST)
Received: from gigli.quasi.internal (p5DC33A7F.dip.t-dialin.net [93.195.58.127])
        by mx.google.com with ESMTPS id 14sm1391319muo.9.2009.02.02.06.58.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Feb 2009 06:58:50 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <7vskmyt127.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 01 Feb 2009 11:22:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108095>

Junio C Hamano <gitster@pobox.com> writes:

[snip]

> This is where you need to use the tool right to get the most out of it.
>
> You could do this in addition to (2).
>
>  (3) Because B is an independent bug, you can have its own topic to fix it
>      and merge it to the test integration, planning to merge it later to
>      mainline independently from feature A topic.  But you already know
>      feature A depends on bugfix B to work correctly, so you merge the fix
>      to the feature as well in advance.
>
>       ---o-------*---*   test integration branch
>         /       /   / 
>        /       /   o     bugfix B
>       /       /   / \
>      /       o-------*   feature A
>     /       /   /
>    o---o---o---o---o     mainline

You seem to suggest that juggling merges is possible in the exact way I
was inquiring about. So let me ask again:

if M1 and M2 are merges and I define equality of merges (M1==M2) to be

- M1 resolves automatically (on the textual level) iff (if and only if)
  M2 does
- if either resolves automatically, the tree produced by M1 is the same
  as that of M2 (the tree SHAs are the same)

do the following conditions hold

(i)  A+B == B+A for all commits A,B
(ii) (A+B)+C == A+(B+C) for all A,B,C

where "+" designates the standard git 3way merge?


[snip]

> If you end up merging A first and then want to merge B later (or the other
> way around, merge B and then A), and if the second merge to the mainline
> causes huge textual conflicts, you can instead merge the conslidated topic
> A+B to the mainline.

One could imagine (corporate) policies though which might try to map
organizational "entities" (tasks, teams, according responsibilities) to
branches. I.e. contexts where conflict resolution through merging might
not always be desired and they'd rather be sought on a branch, i.e. by
producing a commit on either branch which resolves a possible
conflict. That's why I asked how rebase compares to merge and whether
the merge machinery underlying the former is exactly the same. I seem to
understand by now though that it is not.
