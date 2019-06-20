Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FD831F462
	for <e@80x24.org>; Thu, 20 Jun 2019 11:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfFTL76 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 07:59:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44936 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfFTL76 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 07:59:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so1463806pgp.11
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ww/AXNAK8fipsyArODHlIhJ4jQKXHRMg6Vsw0ZOx+0A=;
        b=ErjAetG2saKgT84tEqDs2qdZMWDG0vvvG2vK/671ryFrZppYXXnqlxlAGExIwGQ03v
         u/X+91HgA5c5+o0BQgpj0ZfD0/Kq8Xrxhoel0A5v5Lx5lTUb8p5/EcQrqCiUly90gaNT
         cvjUOqFzgCG6gUud/aT4sUJdodgb5N8mgD4LSONNTKm+cZ1QZKU3AUBJsAMonV5YQWdy
         x90AYW3twu7+mgmfh7Yw2Dgo+9Ge+2+dsMeXVnWe8ytWlHk/mZFKaROisP5n8zZCYP4E
         FiWNhv9BA8ewDfUxuV3rT3seSqIS+kJPql6vHSluZpHl22oYnvzAItAD84/yLsPEeHGA
         yPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ww/AXNAK8fipsyArODHlIhJ4jQKXHRMg6Vsw0ZOx+0A=;
        b=FprSMTZVVUvV0G4dOZjB5MfpiEESN6109xSHlNNyJVwQzmIZa8cgDiDsxcZup0c28H
         jXDT/P/Lhjyppa3vVFMr0Lb6rj8QOPA+T1/i0DJc29PniDUBkmcTht+W4MB1PJsW63jh
         wxmnyVWkwpIp9rimycn2e/k9+dCBLJKM7KEYUMsHKSjg1G6OjLyBIPhgKsLwpaFM6VP/
         JFthsTPEDOMvCzWlElBrmBIkhDroMBjNQI1nxhCgcJ+kDRXLaZxMwuC/S9NyAybUuRKx
         IVfWmEQWHL4mHQ2giXYzcnsCJcdluLin7Iq1MufmPihWR41VwOkACEzZaNgjqxhVup9A
         SjOg==
X-Gm-Message-State: APjAAAWiD/FCcX9WEUnqtYPyA9erhsRYH95a5DmuNm7qyjptTFRPcM2M
        LVfXnnaQ8LyOu5jigEJRWKthL1Zf
X-Google-Smtp-Source: APXvYqygFfiQ+SdSLKP2nuYUZg4EEQzbMzbZQT6WBDohqvdA52AvOiGcMA9yh4BQemE2hRC68VLZhA==
X-Received: by 2002:a17:90a:778c:: with SMTP id v12mr2557173pjk.141.1561031997208;
        Thu, 20 Jun 2019 04:59:57 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id l194sm22842329pga.57.2019.06.20.04.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 04:59:56 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Jun 2019 18:59:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/3] fetch-pack: move capability names out of i18n strings
Date:   Thu, 20 Jun 2019 18:59:49 +0700
Message-Id: <20190620115951.13629-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reduces the work on translators since they only have one string to
translate (and I think it's still enough context to translate). It also
makes sure no capability name is translated by accident.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 fetch-pack.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 1c10f54e78..0532029f2c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -907,32 +907,32 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
 	if (server_supports("multi_ack_detailed")) {
-		print_verbose(args, _("Server supports multi_ack_detailed"));
+		print_verbose(args, _("Server supports %s"), "multi_ack_detailed");
 		multi_ack = 2;
 		if (server_supports("no-done")) {
-			print_verbose(args, _("Server supports no-done"));
+			print_verbose(args, _("Server supports %s"), "no-done");
 			if (args->stateless_rpc)
 				no_done = 1;
 		}
 	}
 	else if (server_supports("multi_ack")) {
-		print_verbose(args, _("Server supports multi_ack"));
+		print_verbose(args, _("Server supports %s"), "multi_ack");
 		multi_ack = 1;
 	}
 	if (server_supports("side-band-64k")) {
-		print_verbose(args, _("Server supports side-band-64k"));
+		print_verbose(args, _("Server supports %s"), "side-band-64k");
 		use_sideband = 2;
 	}
 	else if (server_supports("side-band")) {
-		print_verbose(args, _("Server supports side-band"));
+		print_verbose(args, _("Server supports %s"), "side-band");
 		use_sideband = 1;
 	}
 	if (server_supports("allow-tip-sha1-in-want")) {
-		print_verbose(args, _("Server supports allow-tip-sha1-in-want"));
+		print_verbose(args, _("Server supports %s"), "allow-tip-sha1-in-want");
 		allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
 	}
 	if (server_supports("allow-reachable-sha1-in-want")) {
-		print_verbose(args, _("Server supports allow-reachable-sha1-in-want"));
+		print_verbose(args, _("Server supports %s"), "allow-reachable-sha1-in-want");
 		allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
 	}
 	if (!server_supports("thin-pack"))
@@ -942,13 +942,13 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (!server_supports("include-tag"))
 		args->include_tag = 0;
 	if (server_supports("ofs-delta"))
-		print_verbose(args, _("Server supports ofs-delta"));
+		print_verbose(args, _("Server supports %s"), "ofs-delta");
 	else
 		prefer_ofs_delta = 0;
 
 	if (server_supports("filter")) {
 		server_supports_filtering = 1;
-		print_verbose(args, _("Server supports filter"));
+		print_verbose(args, _("Server supports %s"), "filter");
 	} else if (args->filter_options.choice) {
 		warning("filtering not recognized by server, ignoring");
 	}
-- 
2.22.0.rc0.322.g2b0371e29a

