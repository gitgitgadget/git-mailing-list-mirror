Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC55C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE8F61216
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352476AbhI3RDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 13:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352479AbhI3RDg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 13:03:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD638C06176C
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:01:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id r7so4636677pjo.3
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YVbJ9jnvgsvfNkzebOvnWIRfVgI6Qul6aa559+zbb30=;
        b=CeKq5vOEl7o0WoXJmsA4ckVxKw4xge0+OPSeQY7kh8BPOimWgb5DXBSYgfxhHdxWz9
         WQmk+NDJG8pIHzpsvgMze1ZwixEakibnaI74dE+CLTWqiNZ2m9ZscvNhzAI5S3+08qiL
         TGEtEYMKJLZBhdMOnsBae7qf9JStj3zKh+grYSlirkv3YjUcfw0+QF8/VMyCMHn4f0VO
         l/YUx76nvOfM4tPYMAI0cYR03uL0EpiWxaOThB660ZBSRYyj+4UAZ7gkZYChzaznBk/D
         fjtypN/QbIk+knABHF6x435wyveF28EtM1U0TPJW3S3H9biT3zb3FcECp+VCgaUr1xjA
         H9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YVbJ9jnvgsvfNkzebOvnWIRfVgI6Qul6aa559+zbb30=;
        b=s6yJmLA3QiuPLLgRYkRKuXAjZW6MJ1pY6msUBVtIWrs2HZOHuQJES5C/fWV5zXe6Eq
         BCgOQjsgeuhM5kM7kmIIZy8hX9T+tt1vwfU2MytXCrVnhTvRDZS4kgy1WU2bzHoYvS6H
         u7BwVRRn7IBafhZkW34lk4snRpEDQqtxairS/zJdfJKxfnll+DDYiTnIBijms7t/s7Jo
         mE08A5H4EuawdTiiUdaOSbOFwYZvf/riGjvvaBcb2SsH8mmkPazmwFoheToZII0EoYew
         3ZarW/W+YquZE13rQ4nukxxY4DxX+tIR/IF3rRxx1e2fIymKGrgGR7k6Z5dWtkfylgNY
         X+gQ==
X-Gm-Message-State: AOAM531UrbcZf4ZjyBhMB/bG9hWE20gZ4fUwH8FsxCOjUNTCWq3EPk3T
        2D64RrsQm98pFFwYd6w2H1dbmFl4zAs=
X-Google-Smtp-Source: ABdhPJwuq0KKd5BGPnDtROBJqwXI+ixLiMTXlc4wBErIS8lxSc1TdTWu6Y2N351oiRx12LMy9lUx5A==
X-Received: by 2002:a17:90a:718c:: with SMTP id i12mr14380399pjk.182.1633021313073;
        Thu, 30 Sep 2021 10:01:53 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id p4sm2740678pjo.0.2021.09.30.10.01.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Sep 2021 10:01:52 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 3/5] difftool: avoid returning -1 to cmd_main() from run_dir_diff()
Date:   Thu, 30 Sep 2021 10:01:44 -0700
Message-Id: <20210930170146.61489-3-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.887.g8db6ae3373
In-Reply-To: <20210930170146.61489-1-davvid@gmail.com>
References: <20210930170146.61489-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

difftool was forwarding the -1 result from error() to cmd_main(), which
is implementation-defined since it is outside of the 0-255 range
specified by POSIX for program exit codes.

Stop assigning the result of error() to `ret`. Assign a value of 1
whenever internal errors are detected instead.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch addresses the note from Ævar about returning -1 to cmd_main().

 builtin/difftool.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index fdaaa86bff..e419bd3cd1 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -447,7 +447,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 
 		if (lmode && status != 'C') {
 			if (checkout_path(lmode, &loid, src_path, &lstate)) {
-				ret = error("could not write '%s'", src_path);
+				ret = 1;
+				error("could not write '%s'", src_path);
 				goto finish;
 			}
 		}
@@ -468,8 +469,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			if (!use_wt_file(workdir, dst_path, &roid)) {
 				if (checkout_path(rmode, &roid, dst_path,
 						  &rstate)) {
-					ret = error("could not write '%s'",
-						    dst_path);
+					ret = 1;
+					error("could not write '%s'", dst_path);
 					goto finish;
 				}
 			} else if (!is_null_oid(&roid)) {
@@ -487,15 +488,16 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 
 				add_path(&rdir, rdir_len, dst_path);
 				if (ensure_leading_directories(rdir.buf)) {
-					ret = error("could not create "
-						    "directory for '%s'",
-						    dst_path);
+					ret = 1;
+					error("could not create directory for '%s'",
+						dst_path);
 					goto finish;
 				}
 				add_path(&wtdir, wtdir_len, dst_path);
 				if (symlinks) {
 					if (symlink(wtdir.buf, rdir.buf)) {
-						ret = error_errno("could not symlink '%s' to '%s'", wtdir.buf, rdir.buf);
+						ret = 1;
+						error_errno("could not symlink '%s' to '%s'", wtdir.buf, rdir.buf);
 						goto finish;
 					}
 				} else {
@@ -504,7 +506,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 						st.st_mode = 0644;
 					if (copy_file(rdir.buf, wtdir.buf,
 						      st.st_mode)) {
-						ret = error("could not copy '%s' to '%s'", wtdir.buf, rdir.buf);
+						ret = 1;
+						error("could not copy '%s' to '%s'", wtdir.buf, rdir.buf);
 						goto finish;
 					}
 				}
@@ -515,7 +518,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	fclose(fp);
 	fp = NULL;
 	if (finish_command(child)) {
-		ret = error("error occurred running diff --raw");
+		ret = 1;
+		error("error occurred running diff --raw");
 		goto finish;
 	}
 
-- 
2.33.0.887.g8db6ae3373

