Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5B1C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 07:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344933AbiCUHfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbiCUHfS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 03:35:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A08FA94E5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gb19so12347023pjb.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 00:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=waTYiZ0ViPTkz6ea+O0CLBHGhMB38eJFC+nBA85V2oM=;
        b=XgRsiVm2dBWmXPi3x41Kl0qlCOahygS3oMUm46TOUnd3R+cJMBIc++iQvPcJ27Y0KD
         P71oes7JD/tHzhT8WgC5rDdLZ9Er1bc3ThwlRiAErMbtD0r2wPXIj9BH3+EHRjgUxWSz
         GvNVFTnF8M3fE6234CESrahFnLRckgrgRl84k9f2X1tZaSjHxDRp0bKw1gjlnB1+imb6
         DqmKqne5xMm+nwGcyQtmYkhasUtcRAHNH1PKe/EZMw1kxK22j8MyO7Hyman2AWz9CHXo
         3ntgsQFeZ1jYETxneiwtO/OTHgaOjmF1HhOpsXW0skS1T0WknJydcd2jXhfi7CW+IlH5
         OcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waTYiZ0ViPTkz6ea+O0CLBHGhMB38eJFC+nBA85V2oM=;
        b=UrvgOWFKOrTkey2oDarj8jLdKJ0plwIZvMDCngE0oecEXU65lBuxFtqlL7GiLg56Rc
         Gmjf+4ogkDPVJrZK/nEnDXEiSIkg/1GhLqMAyWhwrZE5HC7RB45+yeJ95bKdAGTJgDdR
         BA48g5Fx5cOTmdg8UrcUf4+1aj/rz+7R0sqG9D/p/H3usyo/8i/VyxY/togA4UIsbrhP
         toGyc6RFI3P/cJNj5NX8Vbhwo+YdM6VPzxy1gIymoGLdrXVZlZX6mJLv6JjRYY48GLqd
         RWhOQb7QeFX5auYCOIrvq4iLyVGStaPnJ0FCZfyCwT6hOsNSio2jabkCAcXDmJ1ujlWE
         3PUQ==
X-Gm-Message-State: AOAM532d0BUtuyBgjyNZNHDCYWpnsY6n9SP4Ft/PmjFIdur31wvoatiV
        cw/OdqzYz6tuU9Bthc9SkGU=
X-Google-Smtp-Source: ABdhPJx6hpzDFp0Gxiupt68CgPBvIKrvtqL0g4+1kKxyC8UXVD/4HU6bW+AZ5tKvIHyDJC7va0qt+g==
X-Received: by 2002:a17:90a:ba15:b0:1c6:7873:b192 with SMTP id s21-20020a17090aba1500b001c67873b192mr24384962pjr.76.1647848032002;
        Mon, 21 Mar 2022 00:33:52 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.46])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm18914422pju.8.2022.03.21.00.33.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 00:33:51 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v13 05/16] ls-tree: rename "retval" to "recurse" in "show_tree()"
Date:   Mon, 21 Mar 2022 15:33:19 +0800
Message-Id: <99e6d47108308b0bbaf406b439170de04e375c56.1647846935.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.406.g2e0e55130e
In-Reply-To: <cover.1647846935.git.dyroneteng@gmail.com>
References: <cover.1647846935.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable which "show_tree()" return is named "retval", a name that's
a little hard to understand. The commit rename "retval" to "recurse"
which is a more meaningful name than before in the context. We do not
need to take a look at "read_tree_at()" in "tree.c" to make sure what
does "retval" mean.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index eecc7482d5..ef8c414f61 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -64,7 +64,7 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
-	int retval = 0;
+	int recurse = 0;
 	size_t baselen;
 	enum object_type type = OBJ_BLOB;
 
@@ -72,9 +72,9 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 		type = OBJ_COMMIT;
 	} else if (S_ISDIR(mode)) {
 		if (show_recursive(base->buf, base->len, pathname)) {
-			retval = READ_TREE_RECURSIVE;
+			recurse = READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
-				return retval;
+				return recurse;
 		}
 		type = OBJ_TREE;
 	}
@@ -109,7 +109,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 				   chomp_prefix ? ls_tree_prefix : NULL,
 				   stdout, line_termination);
 	strbuf_setlen(base, baselen);
-	return retval;
+	return recurse;
 }
 
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
-- 
2.34.1.406.g2e0e55130e

