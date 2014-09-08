From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] fetch: better alignment in ref summary
Date: Mon,  8 Sep 2014 14:40:02 +0700
Message-ID: <1410162002-15608-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 09:40:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQtZ3-0008NV-Bq
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 09:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbaIHHkh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2014 03:40:37 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:44566 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbaIHHkg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 03:40:36 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so582759pad.9
        for <git@vger.kernel.org>; Mon, 08 Sep 2014 00:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=g6tbc1no4ovsaWoSP47AgiouJYKWEocxV+3z7R8l9cE=;
        b=PwZ6KXfENRRY1KNrXBRHlDyXaayDCiUZ5SsOQZMpkgUNRDp3AwAX1k33ghaHFzNdtL
         PfQtzbGt89sqUHcVvWz0t9oVm9/iJNcZl+IVxyjTrCTt5ESZjMNNbk8LItXwBrS+WMRS
         Wkfa4g/eq/kLhcFkymPkU6Ub7EF+LCUItaGSs89vAGPuiMWRydS+F2Gt6sbPV9t/1FB9
         PpSIFVNa8Gll21mWVJZDO6NjUMwcmV8h5pG3HuvzRE+7a5RRirPYOeSSMQtd5NCLVrXh
         TIetHWbgbQNIs6OW8lPONOPr/CBijdxCOzLO16DBBz7mkwX0oKd1qUCAu4M0KhrEb7X2
         Rnmg==
X-Received: by 10.70.126.99 with SMTP id mx3mr31817706pdb.52.1410162036409;
        Mon, 08 Sep 2014 00:40:36 -0700 (PDT)
Received: from duynguyen-vnpc.dek-tpc.internal ([14.161.14.188])
        by mx.google.com with ESMTPSA id df5sm8086541pbb.8.2014.09.08.00.40.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Sep 2014 00:40:35 -0700 (PDT)
X-Mailer: git-send-email 2.0.2.841.g8f98430
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256634>

Currently fetch hard-codes the "remote" column to be 10. For repos
with long branch names, the output could look ugly like this

=46rom github.com:pclouds/git
 * [new branch]      2nd-index  -> pclouds/2nd-index
 * [new branch]      3nd-index  -> pclouds/3nd-index
 * [new branch]      file-watcher -> pclouds/file-watcher
 * [new branch]      inst       -> pclouds/inst
 * [new branch]      large-file-fixes -> pclouds/large-file-fixes
 * [new branch]      ls         -> pclouds/ls
 * [new branch]      master     -> pclouds/master
 * [new branch]      multiple-work-trees -> pclouds/multiple-work-trees
 * [new branch]      mv         -> pclouds/mv
 * [new branch]      read-cache-daemon -> pclouds/read-cache-daemon
 * [new branch]      split-blob -> pclouds/split-blob
 * [new branch]      split-index -> pclouds/split-index
 * [new branch]      status-fast-fast -> pclouds/status-fast-fast
 * [new branch]      untracked-cache -> pclouds/untracked-cache

This patch makes the output a bit better with minimum code change

=46rom github.com:pclouds/git
 * [new branch]      2nd-index  -> pclouds/2nd-index
 * [new branch]      3nd-index  -> pclouds/3nd-index
 * [new branch]      file-watcher -> pclouds/file-watcher
 * [new branch]      inst         -> pclouds/inst
 * [new branch]      large-file-fixes -> pclouds/large-file-fixes
 * [new branch]      ls               -> pclouds/ls
 * [new branch]      master           -> pclouds/master
 * [new branch]      multiple-work-trees -> pclouds/multiple-work-trees
 * [new branch]      mv                  -> pclouds/mv
 * [new branch]      read-cache-daemon   -> pclouds/read-cache-daemon
 * [new branch]      split-blob          -> pclouds/split-blob
 * [new branch]      split-index         -> pclouds/split-index
 * [new branch]      status-fast-fast    -> pclouds/status-fast-fast
 * [new branch]      untracked-cache     -> pclouds/untracked-cache

To make all "->" aligned, we may need to go through the ref list
twice, or buffer the output and let column.c align it. Either way
needs a lot more work than this.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Maybe good enough for other people as well, I don't know..

 builtin/fetch.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7320395..84e47dd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -436,7 +436,7 @@ fail:
 			   : STORE_REF_ERROR_OTHER;
 }
=20
-#define REFCOL_WIDTH  10
+static int REFCOL_WIDTH =3D 10;
=20
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
@@ -447,6 +447,10 @@ static int update_local_ref(struct ref *ref,
 	enum object_type type;
 	struct branch *current_branch =3D branch_get(NULL);
 	const char *pretty_ref =3D prettify_refname(ref->name);
+	int len =3D gettext_width(remote);
+
+	if (REFCOL_WIDTH < len)
+		REFCOL_WIDTH =3D len;
=20
 	type =3D sha1_object_info(ref->new_sha1, NULL);
 	if (type < 0)
--=20
2.0.2.841.g8f98430
