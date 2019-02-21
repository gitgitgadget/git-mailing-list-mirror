Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FEAF1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 19:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfBUT3G (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 14:29:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38167 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfBUT3F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 14:29:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id v26so10383671wmh.3
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 11:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0Q+QAff76GfhL89YDmI0kJqjN6CgmIygA79rwBjInM=;
        b=o+qNul56Aw1bumaa8uRmwr1IX7pjTIVnHLnimr2waWlM0+c5uYeeBXM0as4otweqtB
         ErP90wfGJId3Hl0AvgktlamkCPkKATV/Dh8n229r42Pi18s6ZNzKdEA0ixfHXnTQqKni
         a1ujE8r4jh6ErVIT+F3kLVrIcINxhnBR31nDyuy/zBAx9glHsdaFqX330dmV3NWIoqhg
         42YvPZvj8A8zETDsyFtziRNxgFuxTeORumhbuDwefx3F4gkfuZdIecj1tbjiGzWlPR1I
         S/JS7mqEM21XBawyy7b5ySdPB7eXkw4+W00ToR81fSzEXeuyExRP/UOZYtORQvW0n7tT
         GxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0Q+QAff76GfhL89YDmI0kJqjN6CgmIygA79rwBjInM=;
        b=jXCmrlhq0kagOeWl+i8NtwpVwzMh/D/4pGE6HGXERKryeOjZPsFCfs5GJwdN067VGj
         3GAW5yIfu1mVrEy4RFyEoGfEwEPZjY17XpOKL7sgM+A+++hCmek/CaJ8qj606b1PGeVW
         TuHu+4R+xGttnH9SpJorUpUS2HeymHfrJmgvuQQtCElMskoGynWWEjZ5FcigqVXXs51R
         eR7ZwEihwDAj/odRD6XM+H5QaIc5SMxjtqMP5IWyywgiTdXP0IH78XLpq0Zvaqk/zSEO
         cUlaCbxNeBkywnaTsr25jU4kGuMaRi3f1vB8F6px8vXlssR9QP8XyqJcnpN8M5PY3PT4
         9Z3Q==
X-Gm-Message-State: AHQUAubrdIDGJJiirXo9kHsc7Ub4Ttl1C8PYjlrtwuq/czVSIZSxOOd/
        xNHqujZiF1L5DQZ+F+74RMqVMFZw
X-Google-Smtp-Source: AHgI3IbLcHdl0wmxk0DszvsdGqApXCoS4H0i79/VfY+MthM7kFyX+qo+8p7SitoruKU1QHEvycWAeA==
X-Received: by 2002:a1c:f406:: with SMTP id z6mr57759wma.107.1550777343812;
        Thu, 21 Feb 2019 11:29:03 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm35237429wrq.58.2019.02.21.11.29.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Feb 2019 11:29:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sebastian Staudt <koraktor@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] commit-graph tests: fix cryptic unportable "dd" invocation
Date:   Thu, 21 Feb 2019 20:28:49 +0100
Message-Id: <20190221192849.6581-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an unportable invocation of "dd" that truncated the
commit-graph to call Perl's truncate() function instead.

In POSIX it is unspecified what happens when count=0 is
provided[1]. The NetBSD "dd" behavior differs from GNU (and seemingly
other BSDs), which as left this test broken since
d2b86fbaa1 ("commit-graph: fix buffer read-overflow", 2019-01-15).

In POSIX the truncate(2) and ftruncate(2) functions are
portable. We've used the latter since 271421cd34 ("Update partial HTTP
transfers.", 2005-09-30), but the truncate(1) command-line tool is
GNU-specific. Thus let's use Perl's version of it. We could also just
introduce a "test-tool truncate" in the future if we wanted to avoid
shelling out to perl.

On Linux and NetBSD we don't need the "if -s $ARGV[0] > $ARGV[1]"
condition I'm adding. We never have a $zero_pos longer than the file
being truncated. But let's have that condition to future-proof the
code, and because "the behavior is undefined if LENGTH is greater than
the length of the file" (perldoc -f truncate).

1. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/dd.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5318-commit-graph.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d4bd1522fe..d99bea6cce 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -382,7 +382,8 @@ corrupt_graph_and_verify() {
 	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
 	cp $objdir/info/commit-graph commit-graph-backup &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
-	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
+	perl -we 'truncate $ARGV[0], $ARGV[1] if -s $ARGV[0] > $ARGV[1]' \
+		$objdir/info/commit-graph $zero_pos &&
 	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
 	test_must_fail git commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err &&
-- 
2.21.0.rc0.258.g878e2cd30e

