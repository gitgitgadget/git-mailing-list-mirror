From: =?ISO-8859-1?Q?Ingo_Br=FCckl?= <ib@wupperonline.de>
Subject: [PATCH] stash: Utilize config variable pager.stash.list in stash list command
Date: Tue, 16 Aug 2011 13:47:09 +0200
Message-ID: <4e4a58c2.48d6f6ce.bm001@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 13:50:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtI9k-0007gk-Pg
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 13:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab1HPLt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 07:49:57 -0400
Received: from smtp-a.tal.de ([81.92.1.9]:44163 "EHLO smtp-a.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416Ab1HPLt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 07:49:56 -0400
Received: from point.localnet (mue-88-130-93-036.dsl.tropolys.de [88.130.93.36])
	(Authenticated sender: ib@wtal.de)
	by smtp-a.tal.de (Postfix) with ESMTP id 8D97B11E3664
	for <git@vger.kernel.org>; Tue, 16 Aug 2011 13:49:53 +0200 (CEST)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1QtI9Y-6Cp-00 for <git@vger.kernel.org>; Tue, 16 Aug 2011 13:49:52 +0200
X-Mailer: blueMail/Linux 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179439>

Usually it is annoying that the pager is used for stash list output,
so the config variable pager.stash.list will be utilized now and is
a way to control stash list's behavior.

Signed-off-by: Ingo Br=FCckl <ib@wupperonline.de>
---
 git-stash.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index f4e6f05..29702ab 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -264,7 +264,8 @@ have_stash () {

 list_stash () {
 	have_stash || return 0
-	git log --format=3D"%gd: %gs" -g "$@" $ref_stash --
+	test "$(git config --get pager.stash.list)" =3D "false" && no_pager=3D=
--no-pager
+	git $no_pager log --format=3D"%gd: %gs" -g "$@" $ref_stash --
 }

 show_stash () {
--
1.7.6
