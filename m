From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/7 v3] bisect: use "--bisect-replace" options when checking
 merge bases
Date: Sat, 8 Nov 2008 08:52:37 +0100
Message-ID: <20081108085237.a5df712e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 08 08:51:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyibW-0008P8-L8
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 08:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbYKHHuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 02:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbYKHHuR
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 02:50:17 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:36495 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbYKHHuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 02:50:16 -0500
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 9316B19707;
	Sat,  8 Nov 2008 08:50:15 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with SMTP id 1E1EF19733;
	Sat,  8 Nov 2008 08:50:15 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100388>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 1daa81c..87e186f 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -401,7 +401,7 @@ check_merge_bases() {
 	_bad="$1"
 	_good="$2"
 	_skip="$3"
-	for _mb in $(git merge-base --all $_bad $_good)
+	for _mb in $(git merge-base --all --bisect-replace $_bad $_good)
 	do
 		if is_among "$_mb" "$_good"; then
 			continue
@@ -436,7 +436,7 @@ check_good_are_ancestors_of_bad() {
 	# Bisecting with no good rev is ok
 	test -z "$_good" && return
 
-	_side=$(git rev-list $_good ^$_bad)
+	_side=$(git rev-list --bisect-replace $_good ^$_bad)
 	if test -n "$_side"; then
 		# Return if a checkout was done
 		check_merge_bases "$_bad" "$_good" "$_skip" || return
-- 
1.6.0.3.619.g9a6a
