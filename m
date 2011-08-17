From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] stash: Utilize config variable pager.stash.list in stash list command
Date: Wed, 17 Aug 2011 11:04:23 +0200
Message-ID: <4e4b8418.068889fb.bm001@wupperonline.de>
References: <4e4a58c2.48d6f6ce.bm001@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 11:06:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtc4r-0006pR-Di
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 11:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab1HQJGQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Aug 2011 05:06:16 -0400
Received: from smtp-a.tal.de ([81.92.1.9]:46667 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187Ab1HQJGP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 05:06:15 -0400
Received: from point.localnet (mue-88-130-126-093.dsl.tropolys.de [88.130.126.93])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id 36AED11E3756
	for <git@vger.kernel.org>; Wed, 17 Aug 2011 11:06:09 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1Qtc4f-0wd-00 for <git@vger.kernel.org>; Wed, 17 Aug 2011 11:06:09 +0200
In-Reply-To: <4e4a58c2.48d6f6ce.bm001@wupperonline.de>
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179505>

Usually it is annoying that the pager is used for stash list output,
so the config variable pager.stash.list will be utilized now and is
a way to control stash list's behavior.

Signed-off-by: Ingo Br=FCckl <ib@wupperonline.de>
---
 This is the 2nd attempt, now checking for true and false.

 git-stash.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index f4e6f05..3712a17 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -264,7 +264,10 @@ have_stash () {

 list_stash () {
 	have_stash || return 0
-	git log --format=3D"%gd: %gs" -g "$@" $ref_stash --
+	l_config=3D$(git config --get pager.stash.list)
+	test "$l_config" =3D "true" && p_option=3D--paginate
+	test "$l_config" =3D "false" && p_option=3D--no-pager
+	git $p_option log --format=3D"%gd: %gs" -g "$@" $ref_stash --
 }

 show_stash () {
--
1.7.6
