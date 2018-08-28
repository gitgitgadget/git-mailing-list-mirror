Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34C2C1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 19:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeH1Xbt (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 19:31:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39113 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbeH1Xbt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 19:31:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id o37-v6so2619246wrf.6
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/CWEV3QqHeR/d8h6g9AWtoEtq1rGAXrKO0ijJSOZUdk=;
        b=ToaUUR9bc7dXD2mNw3r7JZTActsUsvaBNxZd6Gy841PktUmjtS7B6XwKsSjzENN+aw
         LOLTdzTCcoUexHKv/Z4KvOLGXdpGUTKP8muHgWf6GoLbqo2fjK+tR0DU1NTcaEfKPfSF
         kAwYY3hvSW23b7gqMQuLmYxurTIfhvG6nFPxtwmtRQs2pwgcet5pHDNWKeGPOHX1YW9q
         HhIyfvstrHiLtkZFJF2kKIUtPbGxdaZ0PzlInLB1h894wVIvcO14OmU5uDQfzHbQk1yL
         2JEjAqiu6gbGPdJIUX31HsAQ/UU5SjDe8+T8zmgwDwMQcTrwKrsNn5YOLq07igB+nQ1p
         GPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/CWEV3QqHeR/d8h6g9AWtoEtq1rGAXrKO0ijJSOZUdk=;
        b=pZ7nduloSvubBiBmMca5l/jcDY2WNAhKZCEygws88qLT27GBJQmTxq0zb4zLad1tdR
         1n4371FGmhn3HuKD2JyV1n6P1Al7NvX257VX5fDDmm1FvqPhyOIa7v6xWeW27fa+PY9p
         QiQy1z23iXyjhGYgZPUxOcB+P5myUPm7w4dViG87dQAfDVFfnm38NXtbIphLrO4R3DqZ
         HuyOQ24KklNGTUQUhMUapJsuFHrvvoj+ayUcpr6bzcZ4I9CE+st/oiOrfVS+53sdTHLO
         UvgwRu0jlIZI1mdejeauXH6Kwfdv31XqfaQ9hU133R8HiGn9SdzTt7biOM6DtXDHuo3D
         74dw==
X-Gm-Message-State: APzg51APfKfJVcQr8Etg9LId6AY+CpUXl6aSDhRaDFBwO2P6rUem8Ct+
        vnXYsTARzBEaou66JMycILGRyp4k/iE=
X-Google-Smtp-Source: ANB0VdZVUqqjWI+OINepJBd0WKPI5ygGarzMt67p/UEcamS6IOVYUfSEEge3TQgSBq6Aj1acuvIFNA==
X-Received: by 2002:a5d:68c9:: with SMTP id p9-v6mr2122370wrw.108.1535485120569;
        Tue, 28 Aug 2018 12:38:40 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 139-v6sm3436938wmp.4.2018.08.28.12.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 12:38:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Ann T Ropea <bedhanger@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] tests: fix non-portable iconv invocation
Date:   Tue, 28 Aug 2018 19:38:27 +0000
Message-Id: <20180828193827.8648-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180828193827.8648-1-avarab@gmail.com>
References: <20180828193827.8648-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The iconv that comes with a FreeBSD 11.2-RELEASE-p2 box I have access
to doesn't support the SHIFT-JIS encoding. Guard a test added in
e92d62253 ("convert: add round trip check based on
'core.checkRoundtripEncoding'", 2018-04-15) first released with Git
v2.18.0 with a prerequisite that checks for its availability.

The iconv command is in POSIX, and we have numerous tests
unconditionally relying on its ability to convert ASCII, UTF-8 and
UTF-16, but unconditionally relying on the presence of more obscure
encodings isn't portable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0028-working-tree-encoding.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 12b8eb963a..b0f4490e8e 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -203,7 +203,11 @@ test_expect_success 'error if encoding garbage is already in Git' '
 	test_i18ngrep "error: BOM is required" err.out
 '
 
-test_expect_success 'check roundtrip encoding' '
+test_lazy_prereq ICONV_SHIFT_JIS '
+	iconv -f UTF-8 -t SHIFT-JIS </dev/null 2>/dev/null
+'
+
+test_expect_success ICONV_SHIFT_JIS 'check roundtrip encoding' '
 	test_when_finished "rm -f roundtrip.shift roundtrip.utf16" &&
 	test_when_finished "git reset --hard HEAD" &&
 
-- 
2.19.0.rc0.228.g281dcd1b4d0

