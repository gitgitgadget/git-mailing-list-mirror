Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E92C3A5A9
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 11:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD11522247
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 11:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYuGJ/Dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDSLA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 07:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgDSLAx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Apr 2020 07:00:53 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B19C061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 04:00:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w11so3564690pga.12
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 04:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/iIC+RfNtM2nBfaunyyEkosnjXnZ1WJMSW2uGFkbE24=;
        b=XYuGJ/DqgKpNod+6S+/a6SNQmjx8ObzV/21yEfq8N5xao3z5+RExpj9a6NwaQWz3el
         inX9SqxtWSWSngZ5z2gcgABgnDTbFu6qRj8qCZzuacDnIH2/ghjaQW2nZQJ+BLkbgK4/
         IVpOnjZs7r0imx5Kaf6tKZbtpyk8tbN5Av3Qn8kZMIGmF2VPr06vcP+ILjAJPyLXHkqO
         WE3+JuYOu8iKXNYXDuL9VUYZcg5nV7FkzFaYlCPmz/eamU/c4OlHI1iaRkwIZXshFKK9
         ubHVOA/7lzIb/SlLjN1tUfmCJdr2Xgy61UZvz3ZWoEq0nrq0uZL9G2Etxe8MZSW2cOzn
         ZgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/iIC+RfNtM2nBfaunyyEkosnjXnZ1WJMSW2uGFkbE24=;
        b=rGIARqv57chAzhk8lnfQruuxySjSmp7/QNPxAqyklsug8r41Hp61ehYg6GMAA9S7Ds
         QZoYwYhLil4OwxiK02XFRFqiCLtTFtp+9K1lLQcK4ry0/gjPCUu50isddHLmYh5QT4jg
         tUxIHZwR5UlFQTCvS9ATV4oNQ63hy26RLvnm3D1ncQR4yV2QQAvRTNHUsKfgEuwAevnk
         q9yhY3oKL54BblfkYLwUV8Z1eucQ2k/UCPUIbdECZoP3JpZo4aMgn8JrXP4R1pEEeQFD
         jyqq2CRz6aDTTJDqnYmFyP5dbi/gBA2LsCawtB5KbmcNQH+wd/DOLO2A/w1OxqWPRHQl
         CXxA==
X-Gm-Message-State: AGi0PuYg1wxQPCee959M1Qbzq+1ze2o4emRDa1xzRz023haTS3TdJ/zY
        gV+XPSGrJmE54HZdQpsrpKhAlu/p
X-Google-Smtp-Source: APiQypLkvEl1zZRJHVpm1nCIvFvxs8cJF5XaSQUfhbeaSl6aHhsrz6awSnaBsv2mJpF0qlH21+lvjQ==
X-Received: by 2002:a63:1d4:: with SMTP id 203mr11124868pgb.74.1587294052782;
        Sun, 19 Apr 2020 04:00:52 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id b20sm361692pff.8.2020.04.19.04.00.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 04:00:52 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 2/3] mailinfo.c::convert_to_utf8: reuse strlen info
Date:   Sun, 19 Apr 2020 18:00:41 +0700
Message-Id: <e3e542d38818b762f8d6d6b50bc42e01b070772b.1587289680.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb
In-Reply-To: <cover.1587289680.git.congdanhqx@gmail.com>
References: <20200418035449.9450-1-congdanhqx@gmail.com> <cover.1587289680.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're passing buffer from strbuf to reencode_string,
which will call strlen(3) on that buffer,
and discard the length of newly created buffer.
Then, we compute the length of the return buffer to attach to strbuf.

During this process, we introduce a discrimination between mail
originally written in utf-8 and other encoding.

* if the email was written in utf-8, we leave it as is. If there is
  a NUL character in that line, we complains loudly:

  	error: a NUL byte in commit log message not allowed.

* if the email was written in other encoding, we truncate the data as
  the NUL character in that line, then we used the truncated line for
  the metadata.

We can do better by reusing all the available information,
and call the underlying lower level function that will be called
indirectly by reencode_string. By doing this, we will also postpone
the NUL character processing to the commit step, which will
complains about the faulty metadata.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 mailinfo.c            |  6 ++++--
 t/t4254-am-corrupt.sh | 44 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 742fa376ab..0e9911df6d 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -447,19 +447,21 @@ static int convert_to_utf8(struct mailinfo *mi,
 			   struct strbuf *line, const char *charset)
 {
 	char *out;
+	size_t out_len;
 
 	if (!mi->metainfo_charset || !charset || !*charset)
 		return 0;
 
 	if (same_encoding(mi->metainfo_charset, charset))
 		return 0;
-	out = reencode_string(line->buf, mi->metainfo_charset, charset);
+	out = reencode_string_len(line->buf, line->len,
+				  mi->metainfo_charset, charset, &out_len);
 	if (!out) {
 		mi->input_error = -1;
 		return error("cannot convert from %s to %s",
 			     charset, mi->metainfo_charset);
 	}
-	strbuf_attach(line, out, strlen(out), strlen(out));
+	strbuf_attach(line, out, out_len, out_len);
 	return 0;
 }
 
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index ddd35498db..98cda32d0a 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -3,6 +3,36 @@
 test_description='git am with corrupt input'
 . ./test-lib.sh
 
+write_nul_patch() {
+	space=' '
+	qNUL=
+	case "$1" in
+		subject) qNUL='=00' ;;
+	esac
+	cat <<-EOF
+	From ec7364544f690c560304f5a5de9428ea3b978b26 Mon Sep 17 00:00:00 2001
+	From: A U Thor <author@example.com>
+	Date: Sun, 19 Apr 2020 13:42:07 +0700
+	Subject: [PATCH] =?ISO-8859-1?q?=C4=CB${qNUL}=D1=CF=D6?=
+	MIME-Version: 1.0
+	Content-Type: text/plain; charset=ISO-8859-1
+	Content-Transfer-Encoding: 8bit
+
+	EOF
+	if test "$1" = body
+	then
+		printf "%s\0%s\n" abc def
+	fi
+	cat <<-\EOF
+	---
+	diff --git a/afile b/afile
+	new file mode 100644
+	index 0000000000..e69de29bb2
+	--$space
+	2.26.1
+	EOF
+}
+
 test_expect_success setup '
 	# Note the missing "+++" line:
 	cat >bad-patch.diff <<-\EOF &&
@@ -32,4 +62,18 @@ test_expect_success 'try to apply corrupted patch' '
 	test_i18ncmp expected actual
 '
 
+test_expect_success "NUL in commit message's body" '
+	test_when_finished "git am --abort" &&
+	write_nul_patch body >body.patch &&
+	test_must_fail git am body.patch 2>err &&
+	grep "a NUL byte in commit log message not allowed" err
+'
+
+test_expect_failure "NUL in commit message's header" '
+	test_when_finished "git am --abort" &&
+	write_nul_patch subject >subject.patch &&
+	test_must_fail git am subject.patch 2>err &&
+	grep "a NUL byte in Subject is not allowed" err
+'
+
 test_done
-- 
2.26.1.301.g55bc3eb7cb

