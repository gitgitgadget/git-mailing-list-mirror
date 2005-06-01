From: =?utf-8?q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: [COGITO PATCH] Heads and tags in subdirectories
Date: Wed, 01 Jun 2005 14:59:22 +0200
Message-ID: <87is0yi66t.fsf@ifae.es>
References: <87is0zginw.fsf@ifae.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jun 01 14:58:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdSmd-0004K9-4N
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 14:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVFAM7r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 1 Jun 2005 08:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVFAM7q
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 08:59:46 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:44937 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S261203AbVFAM7X (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 08:59:23 -0400
Received: from bela (ifae-s1.ifae.es [192.101.162.148])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j51CxKZ11215
	for <git@vger.kernel.org>; Wed, 1 Jun 2005 14:59:20 +0200
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <87is0zginw.fsf@ifae.es> (
 =?utf-8?q?Santi_B=C3=A9jar's_message_of?= "Wed, 01 Jun 2005 00:00:35
 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Teach cg-init about the origin directory.

Signed-off-by: "Santi B=C3=A9jar" <sbejar@gmail.com>
---
 cg-init |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/cg-init b/cg-init
--- a/cg-init
+++ b/cg-init
@@ -29,8 +29,9 @@ ln -s refs/heads/master $_git/HEAD
 if [ "$uri" ]; then
 	echo "$uri" >$_git/branches/origin
 	cg-pull origin || die "pull failed"
-
-	cp $_git/refs/heads/origin $_git/refs/heads/master
+	uribranch=3D$(echo $uri | cut -d '#' -f 2 -s)
+	uribranch=3D${uribranch:-master}
+	cp $_git/refs/heads/origin/$uribranch $_git/refs/heads/master
 	git-read-tree HEAD
 	git-checkout-cache -a
 	git-update-cache --refresh

