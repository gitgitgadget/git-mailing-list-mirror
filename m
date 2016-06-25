Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02D21FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 08:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbcFYIIj (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 04:08:39 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34484 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcFYIIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 04:08:37 -0400
Received: by mail-lf0-f66.google.com with SMTP id l184so23915709lfl.1
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 01:08:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Hv3Qj8wO68oKP6vwOF5SlaQoEEegAeG0q/pZQU9oo0=;
        b=FhK+/HV0ppzsKrbEjvBgPFNHsvMIO+NxBOJtaTbC1l0HCPA6f2SEtCyeywyPB/kU+Q
         OUDvtr9LpsrLz4EgHhQvT0QRnGbLnAf8g3WFnN10BUBMyZwVRn8Aoyuc3l0EUlRgh2Qu
         tbJhyYp9USrbArjo0oM8dhrkOKzZFxy+0d9pKXQuzZwB3RpPUvZfcn+ncf6VymTXg7AF
         6IUidnuLpG2XnTi+Z1ZLWGsEFzAJsLtz2buG5cYe9Jn+zm8MuiE1wTLxqgV5Jluq1rbz
         VYOGu30LnMLEtv9gotVRcnr9TUM4IoyMBgj9eeS2WXlmhVo67bB0Lchjd9YisMc71uyT
         H70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Hv3Qj8wO68oKP6vwOF5SlaQoEEegAeG0q/pZQU9oo0=;
        b=gF97GL0yWlqmNsLP5GDPB9VA5M+KVDKp4mQpxxhjF94mP0m/JgOFWt2mgWIoo9OC6q
         n/6icTfPxmUI83WPpdSDPdt8swtJwe7RHv53obFD5gFAUo32C4Rn2unCvBEgjl72xlxj
         A21RnUvtMrofSK/dKZ9EG4+dyRh/404ZpDWPlHpeL7iG4EiZQQyPSX1AhKdP1pV04ZsS
         m6RwqfYItL0b0grxE4XzrvQk61BGQg2RRXZPKXSHrZ+mJQQlAVmXBX8bA2oOsSeuYyAK
         6rqHuoq61YXu96XgAjRu+S25BXA70Kg+eN3Bq3Ety6g+mO1Jm5mY+Wtsn3I5Dh010kkJ
         QcBA==
X-Gm-Message-State: ALyK8tJMqPXvTH+pxPTMrBy3uSdegnc+UAwrFJuWLR0Jwaicp5z7xIxrOF22RQiZuszJUg==
X-Received: by 10.25.141.135 with SMTP id p129mr2203005lfd.194.1466841289129;
        Sat, 25 Jun 2016 00:54:49 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g79sm1536122ljg.26.2016.06.25.00.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 00:54:48 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/10] worktree move: accept destination as directory
Date:	Sat, 25 Jun 2016 09:54:32 +0200
Message-Id: <20160625075433.4608-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625075433.4608-1-pclouds@gmail.com>
References: <20160625075433.4608-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Similar to "mv a b/", which is actually "mv a b/a", we extract basename
of source worktree and create a directory of the same name at
destination if dst path is a directory.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5d7ca27..443a5ae 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -541,7 +541,13 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	strbuf_addstr(&dst, prefix_filename(prefix,
 					    strlen(prefix),
 					    av[1]));
-	if (file_exists(dst.buf))
+	if (is_directory(dst.buf))
+		/*
+		 * keep going, dst will be appended after we get the
+		 * source's absolute path
+		 */
+		;
+	else if (file_exists(dst.buf))
 		die(_("target '%s' already exists"), av[1]);
 
 	worktrees = get_worktrees();
@@ -558,6 +564,17 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	if (validate_worktree(wt, 0))
 		return -1;
 
+	if (is_directory(dst.buf)) {
+		const char *sep = find_last_dir_sep(wt->path);
+
+		if (!sep)
+			die(_("could not figure out destination name from '%s'"),
+			    wt->path);
+		strbuf_addstr(&dst, sep);
+		if (file_exists(dst.buf))
+			die(_("target '%s' already exists"), dst.buf);
+	}
+
 	/*
 	 * First try. Atomically move, and probably cheaper, if both
 	 * source and target are on the same file system.
-- 
2.8.2.526.g02eed6d

