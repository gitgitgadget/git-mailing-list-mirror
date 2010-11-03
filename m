From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] builtin: make commit_notes function private to notes.c
Date: Wed,  3 Nov 2010 02:47:24 -0200
Message-ID: <48613a1a105a7dc6ed1fa76ac3cdae2ed2a859e4.1288759498.git.tfransosi@gmail.com>
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 06:01:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDVTw-0007hL-5S
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 06:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab0KCEre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 00:47:34 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34138 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab0KCErc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 00:47:32 -0400
Received: by ywc21 with SMTP id 21so193222ywc.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 21:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=rkfX5aNmcDblg8eM92NxgH6fu48bBRf/gRgkXjWkVFs=;
        b=OiNobHodW02Vta9NhYrl5yq+1nZHe/q2VOOuJI3gwueYsMebU5P8QQv1xFMG5C0Pqt
         c1UtEKysOZUWgUlW/xcj/IAxmYPsJnSPUegiuDwpk/ejuvTTYKqUlOj1rwYE3CXMtsRw
         cWB1ONBZQW1egxQPTHfQUbXatlPge6Y8WwsbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mdJEZAw8DwdzvGIm8XEGG+zoK2Za01MlDbIpOnKqLid2S5ffrbHIJhrErsGssLGAfk
         3pyWU3dBO6dx5TYbstDB8ryPZcGT56VbAPYwwfhjQ7EafXFEJPppQAxjtSu5NahtG3Ye
         H6mHG2mkJMNlXSgR6pI/uiNqMLMWdg9WiPmR4=
Received: by 10.150.52.9 with SMTP id z9mr515106ybz.86.1288759651867;
        Tue, 02 Nov 2010 21:47:31 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id r6sm230865yba.23.2010.11.02.21.47.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 21:47:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.90.gd4c43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160576>

This function was exported in builtin.h but is only used on notes.c.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin.h       |    1 -
 builtin/notes.c |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin.h b/builtin.h
index f2a25a0..8017ade 100644
--- a/builtin.h
+++ b/builtin.h
@@ -16,7 +16,6 @@ extern const char git_more_info_string[];
 extern void prune_packed_objects(int);
 extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			 int merge_title, int shortlog_len);
-extern int commit_notes(struct notes_tree *t, const char *msg);
 
 struct notes_rewrite_cfg {
 	struct notes_tree **trees;
diff --git a/builtin/notes.c b/builtin/notes.c
index 6d07aac..89fe169 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -271,7 +271,7 @@ static int parse_reedit_arg(const struct option *opt, const char *arg, int unset
 	return parse_reuse_arg(opt, arg, unset);
 }
 
-int commit_notes(struct notes_tree *t, const char *msg)
+static int commit_notes(struct notes_tree *t, const char *msg)
 {
 	struct commit_list *parent;
 	unsigned char tree_sha1[20], prev_commit[20], new_commit[20];
-- 
1.7.3.2.90.gd4c43
