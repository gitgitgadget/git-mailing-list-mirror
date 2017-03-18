Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFAF220323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdCRKee (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:34:34 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36473 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdCRKeN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:34:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id l37so12174849wrc.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QQGOR9JzPrGeT1/41apSLiWfJkhk3i89vI2tZ9CB7w=;
        b=Q91TXPOag/yTbG5RVWzWR25T22pHyU7bKIPIJh2ciFP/iMlLnU293WfXcF8l0lTG9l
         ImeiFoOuUqMj3on32QRT1tVYtDO2pyzqnNaxNb5MtzPu334XEb0+HkSOY70FLzi1Xuvi
         u4y1PCWCTBDX+Kgxaf+q5G8bL6co27qmGQf0UcA0mVm0ms0zGdSPWJxcO04OfaEaZiOF
         uAVTGIQyafsbH8FTer28As2zmqqWbVMTYcGx8KWKrnHD80JEBcWBliEr4LUlVEjJH3bL
         S08pU5nk7sRQwGnybgwPY441CED4SiVsl/tnUCjF+yiLaNapbv5IS+N4O/I8VEp0iJ7r
         WDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QQGOR9JzPrGeT1/41apSLiWfJkhk3i89vI2tZ9CB7w=;
        b=m/da+fLfqk5aGZlwnOQqQc62vzwVe50vTa1yZOiLhg0PpL9nRlIO8J3bvfgx5Hmq9g
         LtdQjGXSTTPKzBUXDeWYTZ8fbXpl5fl5aXVyZ5yr9Sb0tMWhiymmkSbmjj+AdDh43Ox1
         GgOJcBp5Fn3akC4hQsUMXsEzF5ZgoPm/TEI1UG4DGcG0CSFy/g5NTwMGXOP21Ech8RCz
         uR7z37n9TH+V7ruzkaMNTCK/KGCvhQrDKJYdPFySJh/rNMLkKZtCaVG+GcRCOxfs98Fd
         VkWqPIn0BOgOPyI2m/vJ+5LOmJYiY7ai5t7TChC0HW1fP0NO+uNRndGnjMNSPowR5HoA
         yifA==
X-Gm-Message-State: AFeK/H2aXsVM78/5f/buHglNXKOcEWTfz2JW0U/ibzBxi5EX9R2QYmKL4WU7+iSxmj3uPA==
X-Received: by 10.223.157.38 with SMTP id k38mr14310510wre.156.1489833238519;
        Sat, 18 Mar 2017 03:33:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j34sm13007928wre.7.2017.03.18.03.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Mar 2017 03:33:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/8] tag: Change --point-at to default to HEAD
Date:   Sat, 18 Mar 2017 10:32:56 +0000
Message-Id: <20170318103256.27141-9-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318103256.27141-1-avarab@gmail.com>
References: <20170318103256.27141-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the --points-at option to default to HEAD for consistency with
its siblings --contains, --merged etc. which default to HEAD. This
changes behavior added in commit ae7706b9ac (tag: add --points-at list
option, 2012-02-08).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 3 ++-
 builtin/tag.c             | 3 ++-
 t/t7004-tag.sh            | 8 +++++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index d0b506f120..1d66348b6a 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -136,7 +136,8 @@ This option is only applicable when listing tags without annotation lines.
 	not specified). Implies `--list`.
 
 --points-at <object>::
-	Only list tags of the given object. Implies `--list`.
+	Only list tags of the given object (HEAD if not
+	specified). Implies `--list`.
 
 -m <msg>::
 --message=<msg>::
diff --git a/builtin/tag.c b/builtin/tag.c
index f91ae171b7..300f831fb1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -433,7 +433,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			     N_("field name to sort on"), &parse_opt_ref_sorting),
 		{
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
-			N_("print only tags of the object"), 0, parse_opt_object_name
+			N_("print only tags of the object"), PARSE_OPT_LASTARG_DEFAULT,
+			parse_opt_object_name, (intptr_t) "HEAD"
 		},
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f7ff4e034b..112d96b4ce 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1601,7 +1601,8 @@ do
 	"
 	test_expect_success "Doing 'git tag --list-like $option <commit> <pattern> is permitted" "
 		git tag -n $option HEAD HEAD &&
-		git tag $option HEAD HEAD
+		git tag $option HEAD HEAD &&
+		git tag $option
 	"
 done
 
@@ -1613,6 +1614,11 @@ test_expect_success '--points-at can be used in non-list mode' '
 	test_cmp expect actual
 '
 
+test_expect_success '--points-at is a synonym for --points-at HEAD' '
+	git tag --points-at >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--points-at finds lightweight tags' '
 	echo v4.0 >expect &&
 	git tag --points-at v4.0 >actual &&
-- 
2.11.0

