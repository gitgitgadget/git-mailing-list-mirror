From: Alangi Derick <alangiderick@gmail.com>
Subject: [PATCH] fix a translation error in diff-tree
Date: Mon, 4 May 2015 12:22:33 +0100
Message-ID: <55476653.e33ac20a.753d.ffffc3cc@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon May 04 14:30:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpFVq-0007sZ-T8
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 14:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbbEDMaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 08:30:15 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35105 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbbEDMaN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 08:30:13 -0400
Received: by widdi4 with SMTP id di4so119520464wid.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:subject;
        bh=o/VRZnUVRJT5CyG8i9HMBeNrqCz/qf+4l9X7Wlis1KY=;
        b=dPvdYfN8Oq9bmrYlXzGVGvGgLltHhC64KQudLxrFvZVWFQAer1+nPIZ4bvtCII2qsi
         b3mpphBmwodzKThOHWKaLt8Nkriji2FubsrFIUkUIxJ1rXKCFsME6nPPi3/WUsyzLRak
         53w04lyXlAeMOiiJA6d2DDq/X9Hx9SqXPnCoxE7S2fbeRXWiHbQaA5ucNktTfyFLxdE3
         373vOdg01Xg4wxM7hVUGBS2Ht/4mIVfwOoETOmup2EQ8jl3liEKqrofhwTc1C8QgaWaA
         jJFvxqZiy3WR7QSvZtxHjEAnp7rQxZr3XuR8JU1xapL/otBPP67ZBD2/FDmI0NswIGTl
         H7bw==
X-Received: by 10.180.231.4 with SMTP id tc4mr19382392wic.27.1430742611921;
        Mon, 04 May 2015 05:30:11 -0700 (PDT)
Received: from localhost ([195.24.220.134])
        by mx.google.com with ESMTPSA id u3sm20410805wjq.36.2015.05.04.05.30.07
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2015 05:30:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268313>

Signed-off-by: Alangi Derick <alangiderick@gmail.com>
---
 builtin/diff-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 12b683d..602b5f9 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -45,7 +45,7 @@ static int stdin_diff_trees(struct tree *tree1, char *line, int len)
 	unsigned char sha1[20];
 	struct tree *tree2;
 	if (len != 82 || !isspace(line[40]) || get_sha1_hex(line + 41, sha1))
-		return error("Need exactly two trees, separated by a space");
+		return error(_("Need exactly two trees, separated by a space"));
 	tree2 = lookup_tree(sha1);
 	if (!tree2 || parse_tree(tree2))
 		return -1;
@@ -75,7 +75,7 @@ static int diff_tree_stdin(char *line)
 		return stdin_diff_commit((struct commit *)obj, line, len);
 	if (obj->type == OBJ_TREE)
 		return stdin_diff_trees((struct tree *)obj, line, len);
-	error("Object %s is a %s, not a commit or tree",
+	error(_("Object %s is a %s, not a commit or tree"),
 	      sha1_to_hex(sha1), typename(obj->type));
 	return -1;
 }
-- 
2.4.0.5.g7a7787e.dirty
