Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190181F453
	for <e@80x24.org>; Mon,  4 Feb 2019 16:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbfBDQMb (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 11:12:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33644 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731679AbfBDQMb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 11:12:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id a16so471374wrv.0
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 08:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qik/U4xYZOmq72waFSZ8nn12m9PW6f6tbflsjfS4Axs=;
        b=U8K5H1PUcLO53kM3FWiQ77VLaL2iA0hif1IakM5ltMakyEwIfp+JHLKBP+vHxuUn6E
         YerzEMTGE02RfGUMjTMhxSh+7rphsUbcCaBO+D2Plhoc9CQcxu5S+bdOkYbTGO97MiMp
         zfWOSpKzVpUazZPFOu4zvRHzpUOxSPU1fTIG8zLpsVvUB4kcSo0sxDi14qDVPBd2t5UJ
         OoMcrVMM2OGnhdAA9137sRU4abCyQIpwrQs/DA/9bWLX7TiksQckDkunFBkg98+RXAnu
         LB4MW0R790xYqL85fY9p/o9/mhRz3sOweVaPNKrxFT1nm8GTQuDWSzWKCME5znUE1ooa
         oRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qik/U4xYZOmq72waFSZ8nn12m9PW6f6tbflsjfS4Axs=;
        b=ZETpCKO8FnPFR4aaDZbWMFQoTm8PF52t0QHORiZrdEMqH25JZI/QB7YGfzW2aTW0Qw
         HHydrkN2UqsyMDBRjKuwvJQpGV67JWREFan7u2zv5uCAuoSADy7l4bC+9S2GY++f7Z2g
         ZSaKj7jKC/2xlCp/y04M2PDVGE0RpkFzBWbGqGOOQjUas2xzLsJz+SFQTWdefW/0JrOn
         fFqYVN7boRUjgTvN756nSyvy293RTNXYgLjlsNkD9HkUOgv2L6L2hjZEm4yADYfdb3Yx
         eHmFS/rVHieyiEx1SNWYrm6xNFYj/3HMGrhqu6iR/nxrKjsJydyDlTzgVUz34s6qfItq
         Jzpg==
X-Gm-Message-State: AHQUAuZVF8kSTC4ApD2Swe7Zn94KOXQNuLUBVqvSMeq4+PK9zZX93/Wm
        omJmhRYYFKisP0CG+zrZzczaUxbrOYo=
X-Google-Smtp-Source: AHgI3IYw0BAnj4wFWiMIDq441fhzFBTgRtrTRVy0mEmnlO9IW4onBYgwy+iMyt9pRezJsXaIbP2vKA==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr114395wre.94.1549296748240;
        Mon, 04 Feb 2019 08:12:28 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b14sm13347636wrx.36.2019.02.04.08.12.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 04 Feb 2019 08:12:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH] core.abbrev doc: document and test the abbreviation length
Date:   Mon,  4 Feb 2019 17:12:17 +0100
Message-Id: <20190204161217.20047-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1
In-Reply-To: <20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net>
References: <20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The algorithm we use to pick the default abbreviation length as a
function of the approximate number of objects is described in the
commit message for e6c587c733 ("abbrev: auto size the default
abbreviation", 2016-09-30), as well as in and downthread of [1], but
it hasn't been documented.

Let's do that, and while we're at it explicitly test for when the
current implementation will "roll over" up to values of 2^32-1 (the
maximum portable "unsigned long" value).

1. https://public-inbox.org/git/20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
This is a patch from the middle of a series I'm currently working on
re-rolling. See
https://public-inbox.org/git/20180608224136.20220-1-avarab@gmail.com/

What I'd like to get here is commentary on the phrasing and accuracy
of the doc patch I'm adding here.

This patch assumes that we have a abbrev_length_for_object_count()
function, which I've added in an eariler unpublished patch. It just
exposes the length picking algorithm found in find_unique_abbrev_r().

 Documentation/config/core.txt       | 17 +++++++
 builtin/rev-parse.c                 |  8 ++++
 t/t1512-rev-parse-disambiguation.sh | 74 +++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 185857a13f..2175761833 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -599,6 +599,23 @@ core.abbrev::
 	abbreviated object names to stay unique for some time.
 	The minimum length is 4.
 +
+The algorithm to pick the the current abbreviation length is
+considered an implementation detail, and might be changed in the
+future. Since Git version 2.11, the length has been configured to
+auto-scale based on the estimated number of objects in the
+repository. We pick a length such that if all objects in the
+repository were abbreviated, we'd have a 50% chance of a *single*
+collision.
++
+For example, with 2^14-1 is the last object count at which we'll pick
+a short length of "7", and will roll over to "8" once we have one more
+object at 2^14. Since each hexdigit we add (4 bits) allows us to have
+four times (2 bits) as many objects in the repository, we'll roll over
+to a length of "9" at 2^16 objects, "10" at 2^18 etc. We'll never
+automatically pick a length less than "7", which effectively hardcodes
+2^12 as the minimum number of objects in a repository we'll consider
+when choosing the abbreviation length.
++
 This can also be set to relative values such as `+2` or `-2`, which
 means to add or subtract N characters from the SHA-1 that Git would
 otherwise print, this allows for producing more future-proof SHA-1s
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index d0d751a009..e7bf4375a2 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -773,6 +773,14 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					return 1;
 				continue;
 			}
+			if (opt_with_value(arg, "--abbrev-len", &arg)) {
+				unsigned long v;
+				if (!git_parse_ulong(arg, &v))
+					return 1;
+				int len = abbrev_length_for_object_count(v);
+				printf("%d\n", len);
+				continue;
+			}
 			if (!strcmp(arg, "--bisect")) {
 				for_each_fullref_in("refs/bisect/bad", show_reference, NULL, 0);
 				for_each_fullref_in("refs/bisect/good", anti_reference, NULL, 0);
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 265a6972fc..0e97888a44 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -450,4 +450,78 @@ test_expect_success C_LOCALE_OUTPUT 'ambiguous commits are printed by type first
 	done
 '
 
+test_expect_success 'abbreviation length at 2^N-1 and 2^N' '
+	pow_2_min=$(git rev-parse --abbrev-len=3) &&
+	pow_2_eql=$(git rev-parse --abbrev-len=4) &&
+	pow_4_min=$(git rev-parse --abbrev-len=15) &&
+	pow_4_eql=$(git rev-parse --abbrev-len=16) &&
+	pow_6_min=$(git rev-parse --abbrev-len=63) &&
+	pow_6_eql=$(git rev-parse --abbrev-len=64) &&
+	pow_8_min=$(git rev-parse --abbrev-len=255) &&
+	pow_8_eql=$(git rev-parse --abbrev-len=256) &&
+	pow_10_min=$(git rev-parse --abbrev-len=1023) &&
+	pow_10_eql=$(git rev-parse --abbrev-len=1024) &&
+	pow_12_min=$(git rev-parse --abbrev-len=4095) &&
+	pow_12_eql=$(git rev-parse --abbrev-len=4096) &&
+	pow_14_min=$(git rev-parse --abbrev-len=16383) &&
+	pow_14_eql=$(git rev-parse --abbrev-len=16384) &&
+	pow_16_min=$(git rev-parse --abbrev-len=65535) &&
+	pow_16_eql=$(git rev-parse --abbrev-len=65536) &&
+	pow_18_min=$(git rev-parse --abbrev-len=262143) &&
+	pow_18_eql=$(git rev-parse --abbrev-len=262144) &&
+	pow_20_min=$(git rev-parse --abbrev-len=1048575) &&
+	pow_20_eql=$(git rev-parse --abbrev-len=1048576) &&
+	pow_22_min=$(git rev-parse --abbrev-len=4194303) &&
+	pow_22_eql=$(git rev-parse --abbrev-len=4194304) &&
+	pow_24_min=$(git rev-parse --abbrev-len=16777215) &&
+	pow_24_eql=$(git rev-parse --abbrev-len=16777216) &&
+	pow_26_min=$(git rev-parse --abbrev-len=67108863) &&
+	pow_26_eql=$(git rev-parse --abbrev-len=67108864) &&
+	pow_28_min=$(git rev-parse --abbrev-len=268435455) &&
+	pow_28_eql=$(git rev-parse --abbrev-len=268435456) &&
+	pow_30_min=$(git rev-parse --abbrev-len=1073741823) &&
+	pow_30_eql=$(git rev-parse --abbrev-len=1073741824) &&
+	pow_32_min=$(git rev-parse --abbrev-len=4294967295) &&
+
+	cat >actual <<-EOF &&
+	2 = $pow_2_min $pow_2_eql
+	4 = $pow_4_min $pow_4_eql
+	6 = $pow_6_min $pow_6_eql
+	8 = $pow_8_min $pow_8_eql
+	10 = $pow_10_min $pow_10_eql
+	12 = $pow_12_min $pow_12_eql
+	14 = $pow_14_min $pow_14_eql
+	16 = $pow_16_min $pow_16_eql
+	18 = $pow_18_min $pow_18_eql
+	20 = $pow_20_min $pow_20_eql
+	22 = $pow_22_min $pow_22_eql
+	24 = $pow_24_min $pow_24_eql
+	26 = $pow_26_min $pow_26_eql
+	28 = $pow_28_min $pow_28_eql
+	30 = $pow_30_min $pow_30_eql
+	32 = 16
+	EOF
+
+	cat >expected <<-\EOF &&
+	2 = 7 7
+	4 = 7 7
+	6 = 7 7
+	8 = 7 7
+	10 = 7 7
+	12 = 7 7
+	14 = 7 8
+	16 = 8 9
+	18 = 9 10
+	20 = 10 11
+	22 = 11 12
+	24 = 12 13
+	26 = 13 14
+	28 = 14 15
+	30 = 15 16
+	32 = 16
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
-- 
2.20.1.611.gfbb209baf1

