Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C4B1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 09:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeH1Nng (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 09:43:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36832 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeH1Nng (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 09:43:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id m27-v6so968845wrf.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 02:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Owbr1eeoPkI5z+Nv4cWhYtIQPcf03HxcramcfGIuqRU=;
        b=h/KmFEVjftbdpI5se+fEvBMpHHa2to+yyjCMvaRrurwWkUUysIx/Fv2AI9QMhM+y6a
         0jI2VhCXlGd5aHxw1KkqTBkzP65wkPBUXjUZ6QcnTSv1MwyMPEf4m9WM0q/97aBB+8Pn
         OtdQ8DSdsphKGpOWcwguBWHis3zMd89BkwhgeRY54QIPV1L6BS0pLZy3zux3Q8jUvzTB
         Tg2wFwcPyFDsoMdA5qoZLwi4dR+hMGinRY1kVJh483upriYpF0pVX88RuqqgkNGwvvfw
         X9ojDjSpFVTjE/p0Xgx8t6L3Q8jydKfNqhd0JZQ7ipp5KEZUapdLT3NrleSY6kG5zW+a
         MLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Owbr1eeoPkI5z+Nv4cWhYtIQPcf03HxcramcfGIuqRU=;
        b=LKNMjsG8a+y8lOi8a/41uy4MU+lenJZKlkJ8g2jPPkuXoEkO8lih9SncL0J0XYryAM
         hf38e3hVx7JUmBZs6clQhKFPyL32AZu/ceGdVs+0DUUgkhzkF+eAvI6hIg7cRZSuriNU
         2a8Lsaakz4LsI/wS/LP0HoJL/L7X9cmyziOlUjecPqftI9kzMCMxBzM+R2jyIQAh0hGM
         o6XB8+d1yAGyQJ9huHPxSfhat3WLK+uj55rzLFgDmFUyzZFrdxEj+8bI+uGY6K8p5IT/
         uCq2f8KXGKfCLvdmR2JSqfIjWanvqtuGFCIaWfL+79v3uUESId8jfiG0IuT0BnOBQ6dV
         X/Sw==
X-Gm-Message-State: APzg51Bk+n10Bu8BV64PamskOSFfZ947rwu844hre6mux7g2FatGDBFB
        X0H2atc682+zmSZmXaHuIC22NEnRIh0=
X-Google-Smtp-Source: ANB0VdYe+VI1QlchLv9x4S3za8Tf6Ho3XIkvYx0WBMUC3MJKrr6Gx/OSw1GGoKEqIy+HODIvAwks/A==
X-Received: by 2002:adf:fc44:: with SMTP id e4-v6mr629046wrs.9.1535449963282;
        Tue, 28 Aug 2018 02:52:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a37-v6sm1572238wrc.21.2018.08.28.02.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:52:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 8/8] fsck: support comments & empty lines in skipList
Date:   Tue, 28 Aug 2018 09:52:19 +0000
Message-Id: <20180828095219.23296-9-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <87lg8refcr.fsf@evledraar.gmail.com>
References: <87lg8refcr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's annoying not to be able to put comments and empty lines in the
skipList, when e.g. keeping a big central list of commits to skip in
/etc/gitconfig, which was my motivation for 1362df0d41 ("fetch:
implement fetch.fsck.*", 2018-07-27).

Implement that, and document what version of Git this was changed in,
since this on-disk format can be expected to be used by multiple
versions of git.

There is no notable performance impact from this change, using the
test setup described a couple of commist back:

    Test                                             HEAD~             HEAD
    ----------------------------------------------------------------------------------------
    1450.3: fsck with 0 skipped bad commits          7.81(7.42+0.39)   7.72(7.34+0.38) -1.2%
    1450.5: fsck with 1 skipped bad commits          7.75(7.36+0.38)   7.66(7.26+0.39) -1.2%
    1450.7: fsck with 10 skipped bad commits         7.81(7.43+0.38)   7.70(7.30+0.39) -1.4%
    1450.9: fsck with 100 skipped bad commits        7.85(7.42+0.42)   7.73(7.31+0.41) -1.5%
    1450.11: fsck with 1000 skipped bad commits      7.81(7.43+0.38)   7.84(7.46+0.38) +0.4%
    1450.13: fsck with 10000 skipped bad commits     7.87(7.47+0.40)   7.86(7.46+0.40) -0.1%
    1450.15: fsck with 100000 skipped bad commits    7.77(7.39+0.38)   7.83(7.48+0.34) +0.8%
    1450.17: fsck with 1000000 skipped bad commits   7.17(6.92+0.24)   7.11(6.85+0.26) -0.8%

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        | 4 ++--
 fsck.c                          | 2 ++
 t/t5504-fetch-receive-strict.sh | 6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ebaa044689..824634c412 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1712,8 +1712,8 @@ will only cause git to warn.
 fsck.skipList::
 	The path to a list of object names (i.e. one SHA-1 per
 	line) that are known to be broken in a non-fatal way and should
-	be ignored. Comments ('#') and empty lines are not supported, and
-	will error out.
+	be ignored. On versions of Git 2.20 and later comments ('#') and empty
+	lines are ignored, but will error out on older versions.
 +
 This feature is useful when an established project should be accepted
 despite early commits containing errors that can be safely ignored
diff --git a/fsck.c b/fsck.c
index 4c643f1d40..589548308a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -190,6 +190,8 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 		die("Could not open skip list: %s", path);
 	while (!strbuf_getline(&sb, fp)) {
 		const char *p;
+		if (!strcmp(sb.buf, "") || starts_with(sb.buf, "#"))
+			continue;
 		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
 			die("Invalid SHA-1: %s", sb.buf);
 		oidset_insert(&options->skiplist, &oid);
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index c7224db3bb..a1bac164d1 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -169,20 +169,20 @@ test_expect_success 'fsck with invalid or bogus skipList input' '
 	test_i18ngrep "Invalid SHA-1: \[core\]" err
 '
 
-test_expect_success 'fsck with invalid or bogus skipList input (comments & empty lines)' '
+test_expect_success 'fsck with other accepted skipList input (comments & empty lines)' '
 	cat >SKIP.with-comment <<-EOF &&
 	# Some bad commit
 	0000000000000000000000000000000000000001
 	EOF
 	test_must_fail git -c fsck.skipList=SKIP.with-comment fsck 2>err-with-comment &&
-	test_i18ngrep "^fatal: Invalid SHA-1: # Some bad commit$" err-with-comment &&
+	test_i18ngrep "missingEmail" err-with-comment &&
 	cat >SKIP.with-empty-line <<-EOF &&
 	0000000000000000000000000000000000000001
 
 	0000000000000000000000000000000000000002
 	EOF
 	test_must_fail git -c fsck.skipList=SKIP.with-empty-line fsck 2>err-with-empty-line &&
-	test_i18ngrep "^fatal: Invalid SHA-1: " err-with-empty-line
+	test_i18ngrep "missingEmail" err-with-empty-line
 '
 
 test_expect_success 'fsck no garbage output from comments & empty lines errors' '
-- 
2.19.0.rc0.228.g281dcd1b4d0

