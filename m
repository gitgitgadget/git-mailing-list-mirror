Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA392047F
	for <e@80x24.org>; Sat, 30 Sep 2017 18:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbdI3Sqm (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 14:46:42 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:57012 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdI3Sql (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 14:46:41 -0400
Received: by mail-pg0-f46.google.com with SMTP id n1so549810pgt.13
        for <git@vger.kernel.org>; Sat, 30 Sep 2017 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YUO3dGUrWpX3fL+wX6zLM4JPVfIkbgkgp9xP/uMU3D4=;
        b=iZNLbbcQXNEzAw1rJa6KZ3/zWjuzXy22s7pM7Zov0SHDOVoMHXUtFYdJj0tmNdibSC
         wNLDTes9uvP5TGO68G/6AyiJ07PCo5Je9pyIIGhRAZxuYr6puXcRQv4su1hn/kqm5Kit
         Ry8CUFZbP2pHcZy6Zg48WVXKfRhbd0vnKSBhiMc2faP5oAVzAkCaqLZQ6oltZxurC8aH
         iQaYQMwJs9k1e0GuwvslNeWiSiYehPdeeQBIJ6ZK+6Ib5p7is4AXTwuqFfQ8jTU4AyLz
         mTk896HveTafReHkJ+LuUBHkFFo89puGe/JxG55nd+E1VeLmM4qy6mUpXsTaXhJzFhmW
         bZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YUO3dGUrWpX3fL+wX6zLM4JPVfIkbgkgp9xP/uMU3D4=;
        b=TMcq7RcC+f9dyuvW8n4IyHjE5TswdVzYiSzUWYPXQo00Zb6gjSqyJZPafcKPTcqVT3
         xCQBK+D3iOMJ6S3pCqUw+qtD0JHvZbSXFdY7CkZULgoSt59vNMZKQvmB5LvxHj8f2t7p
         y0HPXD/wVCaJtQPwqTtI+JYrnmq6+sngSaP5PAI8GrNW8lr+sM5TwCFdjSZi/KKXMo8o
         ftt/nTRgm6ZjdoekNpL67bWu4ncVBfP8yDiAcwAbCLPcQ2jxkmAcA+cZosjj093/d7hg
         XSsuXYCajXcOSE63ONCpZTxe667MGJBQd+rHOmfcO8ujOVSekToOppaZwzj+Bcxf42B7
         pLug==
X-Gm-Message-State: AHPjjUgx+j0x4VV7ya/NELhPF67gDykLtFLslXY450EihApTtlCTDehW
        QAoFbEPfLTc4rJmQ910onjrW8viHkEQ=
X-Google-Smtp-Source: AOwi7QDKU9A7heCsbdPH4LFRoLeFdosTJRiuUo1XpHC/Uh0yxcfG3YfxYJn09P0XLUTlSQggv/8dHA==
X-Received: by 10.101.93.145 with SMTP id f17mr8697096pgt.50.1506797200487;
        Sat, 30 Sep 2017 11:46:40 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id r3sm9297760pgf.48.2017.09.30.11.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2017 11:46:39 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 2/6] t6300: refactor %(trailers) tests
Date:   Sat, 30 Sep 2017 11:46:25 -0700
Message-Id: <20170930184629.75900-2-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20170930184629.75900-1-me@ttaylorr.com>
References: <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
 <20170930184629.75900-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently have one test for %(trailers) in `git-for-each-ref(1)`,
through "%(contents:trailers)". In preparation for more, let's add a few
things:

  - Move the commit creation step to its own test so that it can be
  re-used.

  - Add a non-trailer to the commit's trailers to test that non-trailers
  aren't shown using "%(trailers:only)".

  - Add a multi-line trailer to ensure that trailers are unfolded
  correctly using "%(trailers:unfold)".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t6300-for-each-ref.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 834a9ed16..2a9fcf713 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -592,18 +592,25 @@ test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 cat >trailers <<EOF
 Reviewed-by: A U Thor <author@example.com>
 Signed-off-by: A U Thor <author@example.com>
+[ v2 updated patch description ]
+Acked-by: A U Thor
+  <author@example.com>
 EOF
 
-test_expect_success 'basic atom: head contents:trailers' '
+
+test_expect_success 'set up trailers for next test' '
 	echo "Some contents" > two &&
 	git add two &&
-	git commit -F - <<-EOF &&
+	git commit -F - <<-EOF
 	trailers: this commit message has trailers
 
 	Some message contents
 
 	$(cat trailers)
 	EOF
+'
+
+test_expect_success 'basic atom: head contents:trailers' '
 	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
 	sanitize_pgp <actual >actual.clean &&
 	# git for-each-ref ends with a blank line
-- 
2.14.1.145.gb3622a4ee

