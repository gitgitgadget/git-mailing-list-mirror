Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57F222022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbdBWXtK (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:49:10 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35755 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdBWXs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:48:58 -0500
Received: by mail-pg0-f53.google.com with SMTP id b129so2725277pgc.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j3AuqP3W9SRPQciySCZKlceMUoWuoXAzXGOwOP20c6I=;
        b=Ft4Rzby6p8F2gvtA31ISQMng5RIEk65jqDbRG/3jLX1od5cDgbztK5bRiVSMxbYKuZ
         u+LYBz0ITjCXWSe2QOWP9vFJWBWSwx7hu8mOt5D/a77JPlw4pJ3ai2W9oEDgg63CIpW4
         QUIYUGWiPy9PX0FO7faZ8X7dmxYuehy00fAEY3QvWyHKEhSkJwaNdjjjkaxJ/GreOGtt
         LB5LE3UsEInR+rzIhWnIpN/o6f6qH3o5G8PPzfndo0TrAxbAZs1jBd1eL0aqSkFC6i1z
         4Vsp95tmJJmqDezjAcPPpGwt4aKAcXeGHHSkqTZko4MvFMaKls9Zn/2eibbyjnde926n
         6t/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j3AuqP3W9SRPQciySCZKlceMUoWuoXAzXGOwOP20c6I=;
        b=nh/EojQO5Uqg5ayQLd36q8HrvlIaC0DYomPMTEIyo22oeM9ZBoif1Cv1cYitHcKiq9
         /OGE5uCJsUBehBHz/onuubqhtfM0fKo+/KCDJ2otF8EeQfhmik6JO5MQr/77w9QCc8g4
         8v2Mm5dgKaXWydp6GXvvDl5HxzPPV+6p0uhweEh1VUpog1QY4vqPnCRttaQXaQ8397NE
         bbTH/0/rTc8MBrJgUVq3WlYZ5Gx8YTyLZzwi62XKTFZaQEWXWWOHAoD7C1ABdOuPiTqD
         gbuYWKKjVBbyjgWtn7fEc6VgAeyJJZMVo5pDOwCGQcru7d7Wg7vb7ynyd/hmTZh6K+Iv
         Qo2w==
X-Gm-Message-State: AMke39naL22y61LXN2Lg/cp4YkutAPmr3GmwNskyvhuyUMsU7dWzUkZ0o9klWcDV3tebKdJ4
X-Received: by 10.84.191.165 with SMTP id a34mr16363964pld.62.1487893669157;
        Thu, 23 Feb 2017 15:47:49 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r74sm11660300pfb.67.2017.02.23.15.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:47:48 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 07/10] submodule status: use submodule--helper is-active
Date:   Thu, 23 Feb 2017 15:47:25 -0800
Message-Id: <20170223234728.164111-8-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170223234728.164111-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4633a4336..f8adfb179 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1026,14 +1026,13 @@ cmd_status()
 	do
 		die_if_unmatched "$mode" "$sha1"
 		name=$(git submodule--helper name "$sm_path") || exit
-		url=$(git config submodule."$name".url)
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 		if test "$stage" = U
 		then
 			say "U$sha1 $displaypath"
 			continue
 		fi
-		if test -z "$url" ||
+		if ! git submodule--helper is-active "$sm_path" ||
 		{
 			! test -d "$sm_path"/.git &&
 			! test -f "$sm_path"/.git
-- 
2.11.0.483.g087da7b7c-goog

