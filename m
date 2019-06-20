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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D94F1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 12:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbfFTMAC (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 08:00:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34023 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfFTMAC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 08:00:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so1327273plt.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 05:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTDCc1+Nv6uTYAXedQfRcEBJ/kjYrKgB96Kim/18/1Q=;
        b=Np4+JQk5+4zwBU1dte7ZsjgpzCh1/9R1alGI8NYG9PNZfSTFJwcUB3iWp/IESK5DS3
         vz47Yy3/XOOB3SXkAHVWSZuR1J3BOW7e71sRbP8uV4F6Z4znOIFydxv8lVc3q0/nlUFI
         +zk1XJj8v5of15CE9ZMDKHGWkkeOMTqbsyx00ScAY/svdLBcKUIXiSHn92ZkIkRB6zV0
         Tm+utKcF5+EqfuyRqiyCX7TZMeuDGZbLSuJK/LUivpsmlSIsskUYk5EE3/rnGI2nEOl6
         vr18sk5ZEpV6FOtgDIJY5v1qAXsQvXfGovLMQmRP91DS52h2K9KVvfRooGMujPDzh0RB
         jPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTDCc1+Nv6uTYAXedQfRcEBJ/kjYrKgB96Kim/18/1Q=;
        b=AxW9gQYlIYKNI49AOwh3t4EqSKq1QaRQg2J3CPm3NkZdm7CfYONIn7n38ZOgFoBosd
         qY9PhVUBj/H2ZmmAXL58/rPlIbnxEoZpmMU/XmwESFmO1uA4ha7kt/5gZWQmt7uk3Wpw
         a8m8NGLd0a9jacxXUjgaungKu4AEr5YplAnN50efoz+NGg3c2o7YOm9S4guZvsGJHj2X
         c7+k7deCdYRVmqsBzi1Jdn+BHWzOlA1OGzep+joHUZtkqDOJW7liT0d2WVaCO3SxRyND
         l61qTchziwJPehHNeleE/aSaieJZs57fuUiBEyp3QAxFSq2+dlYshlAmZZ/D/R/DJljD
         vELg==
X-Gm-Message-State: APjAAAWe3Xo4StpGHTBagFuN9b/cNTTlpeO4NTyRGyxAXBRGExIw6Rfd
        ISZphIO7rEudUq8IjrBg7F0O9hms
X-Google-Smtp-Source: APXvYqwcNFraXTgt316ABGymyans9xCIBcCoi7yhywCQalUVf67+bYqn6i1ccQ1MG+V2PpQ8qAF6PA==
X-Received: by 2002:a17:902:b098:: with SMTP id p24mr34324643plr.146.1561032001362;
        Thu, 20 Jun 2019 05:00:01 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id e16sm28317566pga.11.2019.06.20.04.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 05:00:00 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Jun 2019 18:59:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/3] fetch-pack: print all relevant supported capabilities with -v -v
Date:   Thu, 20 Jun 2019 18:59:50 +0700
Message-Id: <20190620115951.13629-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190620115951.13629-1-pclouds@gmail.com>
References: <20190620115951.13629-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we check if some capability is supported, we do print something in
verbose mode. Some capabilities are not printed though (and it made me
think it's not supported; I was more used to GIT_TRACE_PACKET) so let's
print them all.

It's a bit more code. And one could argue for printing all supported
capabilities the server sends us. But I think it's still valuable this
way because we see the capabilities that the client cares about.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 fetch-pack.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 0532029f2c..de935f8776 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -902,7 +902,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
 
-	if ((args->depth > 0 || is_repository_shallow(the_repository)) && !server_supports("shallow"))
+	if (server_supports("shallow"))
+		print_verbose(args, _("Server supports %s"), "shallow");
+	else if (args->depth > 0 || is_repository_shallow(the_repository))
 		die(_("Server does not support shallow clients"));
 	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen = 1;
@@ -935,11 +937,17 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		print_verbose(args, _("Server supports %s"), "allow-reachable-sha1-in-want");
 		allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
 	}
-	if (!server_supports("thin-pack"))
+	if (server_supports("thin-pack"))
+		print_verbose(args, _("Server supports %s"), "thin-pack");
+	else
 		args->use_thin_pack = 0;
-	if (!server_supports("no-progress"))
+	if (server_supports("no-progress"))
+		print_verbose(args, _("Server supports %s"), "no-progress");
+	else
 		args->no_progress = 0;
-	if (!server_supports("include-tag"))
+	if (server_supports("include-tag"))
+		print_verbose(args, _("Server supports %s"), "include-tag");
+	else
 		args->include_tag = 0;
 	if (server_supports("ofs-delta"))
 		print_verbose(args, _("Server supports %s"), "ofs-delta");
@@ -959,15 +967,19 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 			print_verbose(args, _("Server version is %.*s"),
 				      agent_len, agent_feature);
 	}
-	if (server_supports("deepen-since"))
+	if (server_supports("deepen-since")) {
+		print_verbose(args, _("Server supports %s"), "deepen-since");
 		deepen_since_ok = 1;
-	else if (args->deepen_since)
+	} else if (args->deepen_since)
 		die(_("Server does not support --shallow-since"));
-	if (server_supports("deepen-not"))
+	if (server_supports("deepen-not")) {
+		print_verbose(args, _("Server supports %s"), "deepen-not");
 		deepen_not_ok = 1;
-	else if (args->deepen_not)
+	} else if (args->deepen_not)
 		die(_("Server does not support --shallow-exclude"));
-	if (!server_supports("deepen-relative") && args->deepen_relative)
+	if (server_supports("deepen-relative"))
+		print_verbose(args, _("Server supports %s"), "deepen-relative");
+	else if (args->deepen_relative)
 		die(_("Server does not support --deepen"));
 
 	if (!args->no_dependents) {
-- 
2.22.0.rc0.322.g2b0371e29a

