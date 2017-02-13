Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 771241FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 15:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbdBMPUi (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 10:20:38 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:32973 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753160AbdBMPUh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 10:20:37 -0500
Received: by mail-ot0-f195.google.com with SMTP id f9so11896251otd.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 07:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=keMfYvQQqxB/4858o/qea5jKGfRTlmdzJX91VRlDtGk=;
        b=jalk/Ikxk8nPUsz0yY0+NfQclee/cxDj5gWxVZ8iHBUVbe1bMZ2e84muW5WBq1EH0T
         loUSiHlUoEquTEDE/wLRouMEok+nvn7+0iTqjMC29ABCRLMvX+FKksfABFshpexAcFi/
         Ez/QpTGfRWLNeGLerfbEhtTYJw8i3qALf6sMj55E4RpNBstrwsHUPX/8+Lnit8rmyqRW
         LmUOE2x92M07No1gOJiQVsSO7zym4O/oHcjN31oMwBuVHopItVNdikunKfB0kVP7pd+m
         RgFcAbytwoJMiTuTC6ExFWuAl7t2x6LhL+b4WzidHud4V0Xjw6Kb9cFP/+atQAshrtr+
         /vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=keMfYvQQqxB/4858o/qea5jKGfRTlmdzJX91VRlDtGk=;
        b=lY/07UwZ4zV9KK/afErRtxl+uKJDak92tlQot9wL7EtE8ZiHpxUognandGRTK5eBjw
         mzyXtW68kYUN0GH+QYo9S0bjh+V17aBr7R0S8tevbv2nLC8IsKEMvbQOAsVDlP7Cm4ba
         uUUVpaWqN71oy0XFMkPcUvD039jsKIi5Jief9aDynwyUO5XB132DEYulUcqw/IE/KzBD
         Ltf1wK0AZfgvWg2OPWQBBr0ea20pdJKUQN0+aEgporiECAzhjX7WtpHkJUNXsVsyOy2M
         EqqQs7pxtuhhDys6PAxls5i6vXn+P+7a2mD3owCrXDx4vNlUFDLnGf/akSpZ/MA46Ngv
         VHCg==
X-Gm-Message-State: AMke39le+THKgqSDVxG7G3z3K1lWR21xnH8z6IETmOYuY13rpSCI3AWWsHt6HNKmhxAMYQ==
X-Received: by 10.98.48.66 with SMTP id w63mr26073785pfw.179.1486999236096;
        Mon, 13 Feb 2017 07:20:36 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id r8sm21681578pfi.82.2017.02.13.07.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Feb 2017 07:20:35 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 13 Feb 2017 22:20:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/11] files-backend: add files_path()
Date:   Mon, 13 Feb 2017 22:20:03 +0700
Message-Id: <20170213152011.12050-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170213152011.12050-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will be the replacement for both git_path() and git_path_submodule()
in this file. The idea is backend takes a git path and use that,
oblivious of submodule, linked worktrees and such.

This is the middle step towards that. Eventually the "submodule" field
in 'struct files_ref_store' should be replace by "gitdir". And a
compound ref_store is created to combine two files backends together,
one represents the shared refs in $GIT_COMMON_DIR, one per-worktree. At
that point, files_path() becomes a wrapper of strbuf_vaddf().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6582c9b2d..39217a2ca 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -169,6 +169,9 @@ static int files_log_ref_write(const char *refname, const unsigned char *old_sha
 			       const unsigned char *new_sha1, const char *msg,
 			       int flags, struct strbuf *err);
 
+void files_path(struct files_ref_store *refs, struct strbuf *sb,
+		const char *fmt, ...) __attribute__((format (printf, 3, 4)));
+
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
 	struct ref_dir *dir;
@@ -930,6 +933,23 @@ struct files_ref_store {
 /* Lock used for the main packed-refs file: */
 static struct lock_file packlock;
 
+void files_path(struct files_ref_store *refs, struct strbuf *sb,
+		const char *fmt, ...)
+{
+	struct strbuf tmp = STRBUF_INIT;
+	va_list vap;
+
+	va_start(vap, fmt);
+	strbuf_vaddf(&tmp, fmt, vap);
+	va_end(vap);
+	if (refs->submodule)
+		strbuf_git_path_submodule(sb, refs->submodule,
+					  "%s", tmp.buf);
+	else
+		strbuf_git_path(sb, "%s", tmp.buf);
+	strbuf_release(&tmp);
+}
+
 /*
  * Increment the reference count of *packed_refs.
  */
-- 
2.11.0.157.gd943d85

