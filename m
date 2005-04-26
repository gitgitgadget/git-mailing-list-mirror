From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: git "tag" objects implemented - and a re-done commit
Date: Mon, 25 Apr 2005 22:44:45 -0400 (EDT)
Message-ID: <1524.10.10.10.24.1114483485.squirrel@linux1>
References: <Pine.LNX.4.58.0504251213530.18901@ppc970.osdl.org>   
    <Pine.LNX.4.58.0504251318290.11481@sam.ics.uci.edu>   
    <Pine.LNX.4.58.0504251339020.18901@ppc970.osdl.org>   
    <Pine.LNX.4.58.0504251442480.12019@sam.ics.uci.edu>   
    <Pine.LNX.4.58.0504251505260.18901@ppc970.osdl.org>   
    <Pine.LNX.4.58.0504251530480.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Andreas Gal" <gal@uci.edu>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 04:39:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQFzE-0000sH-1G
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 04:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVDZCou (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 22:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVDZCou
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 22:44:50 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:41715 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261289AbVDZCoq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 22:44:46 -0400
Received: from linux1 ([67.71.124.169]) by simmts6-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050426024445.ZFDS1597.simmts6-srv.bellnexxia.net@linux1>;
          Mon, 25 Apr 2005 22:44:45 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j3Q2ih5h010220;
	Mon, 25 Apr 2005 22:44:44 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Mon, 25 Apr 2005 22:44:45 -0400 (EDT)
To: "Linus Torvalds" <torvalds@osdl.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
In-Reply-To: <Pine.LNX.4.58.0504251530480.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, April 25, 2005 6:39 pm, Linus Torvalds said:
>
> Ok, for the intrepid users, you can now test to see if you can pick them
out. fsck should make them totally obvious, and here's my public key in
case you also want to verify the things.
>
> Of course, since I normally don't use pgp signing etc, it's entirely
possible that I've done something stupid, and I'm now sending you my
secret key and my full porn-collection.
>


Linus,

Looks good:

$ gpg --import torvalds.pgp
$ gpg --edit-key Linus trust
gpg --edit-key Linus trust
 1 = Don't know
 2 = I do NOT trust
 3 = I trust marginally
 4 = I trust fully
 5 = I trust ultimately
 m = back to the main menu

Your decision? 5
Do you really want to set this key to ultimate trust? y



$ fsck-cache  --tags
tagged commit a2755a80f40e5794ddc20e00f781af9d6320fafb (v2.6.12-rc3) in
0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
tagged commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 (v2.6.12-rc2) in
9e734775f7c22d2f89943ad6c745571f1930105f
expect dangling commits - potential heads - due to lack of head
information
dangling commit b453257f057b834fdf9f4a6ad6133598b79bd982



$ chksig.sh 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
gpg: Signature made Mon Apr 25 18:27:55 2005 EDT using DSA key ID 76E21CBB
gpg: Good signature from "Linus Torvalds (tag signing key)
<torvalds@osdl.org>"



chksig.sh:

#!/bin/sh
TAG=$1
cat-file tag $TAG | sed -ne '/BEGIN PGP/,/END PGP/p' > .tmp.sig
cat-file tag $TAG | sed -e '/BEGIN PGP/,/END PGP/d' | \
        gpg --verify .tmp.sig -
rm -f .tmp.sig



Sean




