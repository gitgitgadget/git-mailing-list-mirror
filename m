Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE4E202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 21:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbdJWVcj (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 17:32:39 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:46227 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdJWVci (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 17:32:38 -0400
Received: by mail-it0-f65.google.com with SMTP id f187so7659305itb.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Z1FrNgcbTTRs/BCzCftsyf0rfriMEmGhvoFlnXwrtI=;
        b=ps/5w7jsZKrNYnuJ+1i7UpvxbRyTjw3p5hob/YXchMqbkCWqFQpcPI8u0mOMzu4w3i
         WLWzgvcmIECBqAasVQddSUXLXGn46TP7daXwVvSA8BGB4EshX7a9neXYPMH4Xy65uwEi
         bXJgZbFjK42f8mif9Y9JiMuolKdosLA/JyhjkFj6u53vGBUgFR81Gyv0gCzaFO+YBqLW
         MPqtsjM+90kFBFdgkcH3BYM8htV+Ajvdd+lNT99e7waQGgZpjOKkWZpVPlgixZrL72cu
         dQSxlYNjq3kYj10R/AHD6J79Mrg6WP8xsX9zGjFUybmwJYp+je8htMlc4t0mUMlgVRA2
         PnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Z1FrNgcbTTRs/BCzCftsyf0rfriMEmGhvoFlnXwrtI=;
        b=VwXVGlMKHtO07yqKFfsDwGBhYpIuw/EA0IigocdQeteu5Y0OFzLyzkmBnGP0VeSdQ0
         Y99DZe6FJfV70pcElaVyPPBUjv4mcBDka/mRIcW5QufHyIWmsfhhf67VS6zFL/WEW501
         U5X7SSX62GFqqq/XX2aWG/Ha4FkVL3/JnIZ74MKwsphxfkNOVAo+9MBiTWwvu/sXdlk8
         bsXK2wQy8cb20fPZyg05ozXoCqTiZ0QiYip22drYLT4+EXMYbV8YAp7sjX1IPT+4Idjl
         rUdsecamJXkPR6ulsSO91GTMG87V1a3vh2C+yYkewlUGeChkRxI3b4oRVp8f8H+KuTK9
         F4vQ==
X-Gm-Message-State: AMCzsaUf3IZ6hIO59tBd1Ch3cvHgNtO4umRGb5w4ty5tXABCOp8Tu3a4
        07MThmZO7EvDi4cbn3ToNpI=
X-Google-Smtp-Source: ABhQp+TLHC2gRxtIg11e4BOHlEuvKpH14+CbQfPgtfuVEjxuQb0kfqfayHWjQQOA6wHAcr41AcgycA==
X-Received: by 10.36.105.65 with SMTP id e62mr10689669itc.16.1508794357450;
        Mon, 23 Oct 2017 14:32:37 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s81sm2811798ita.19.2017.10.23.14.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 14:32:37 -0700 (PDT)
Date:   Mon, 23 Oct 2017 14:32:35 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jonathantanmy@google.com, peff@peff.net,
        sbeller@google.com, William Yan <wyan@google.com>
Subject: [PATCH 4/5] ssh: 'simple' variant does not support -4/-6
Message-ID: <20171023213235.btjysimp6a6hdzql@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user passes -4/--ipv4 or -6/--ipv6 to "git fetch" or "git push"
and the ssh command configured with GIT_SSH does not support such a
setting, error out instead of ignoring the option and continuing.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 connect.c        | 25 ++++++++++++++++++++++---
 t/t5601-clone.sh | 12 ++++++------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/connect.c b/connect.c
index 2dc9554b30..a1c0ba1b3a 100644
--- a/connect.c
+++ b/connect.c
@@ -923,11 +923,30 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 				 get_protocol_version_config());
 	}
 
-	if (variant != VARIANT_SIMPLE) {
-		if (flags & CONNECT_IPV4)
+	if (flags & CONNECT_IPV4) {
+		switch (variant) {
+		case VARIANT_AUTO:
+			BUG("VARIANT_AUTO passed to push_ssh_options");
+		case VARIANT_SIMPLE:
+			die("ssh variant 'simple' does not support -4");
+		case VARIANT_SSH:
+		case VARIANT_PLINK:
+		case VARIANT_PUTTY:
+		case VARIANT_TORTOISEPLINK:
 			argv_array_push(args, "-4");
-		else if (flags & CONNECT_IPV6)
+		}
+	} else if (flags & CONNECT_IPV6) {
+		switch (variant) {
+		case VARIANT_AUTO:
+			BUG("VARIANT_AUTO passed to push_ssh_options");
+		case VARIANT_SIMPLE:
+			die("ssh variant 'simple' does not support -6");
+		case VARIANT_SSH:
+		case VARIANT_PLINK:
+		case VARIANT_PUTTY:
+		case VARIANT_TORTOISEPLINK:
 			argv_array_push(args, "-6");
+		}
 	}
 
 	if (variant == VARIANT_TORTOISEPLINK)
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index fd94dd40d2..a672fc1e08 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -367,15 +367,15 @@ test_expect_success 'OpenSSH variant passes -4' '
 	expect_ssh "-4 -p 123" myhost src
 '
 
-test_expect_success 'variant can be overriden' '
-	git -c ssh.variant=simple clone -4 "[myhost:123]:src" ssh-simple-clone &&
-	expect_ssh myhost src
+test_expect_success 'variant can be overridden' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/putty" &&
+	git -c ssh.variant=putty clone -4 "[myhost:123]:src" ssh-putty-clone &&
+	expect_ssh "-4 -P 123" myhost src
 '
 
-test_expect_success 'simple is treated as simple' '
+test_expect_success 'simple does not support -4/-6' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
-	git clone -4 "[myhost:123]:src" ssh-bracket-clone-simple &&
-	expect_ssh myhost src
+	test_must_fail git clone -4 "[myhost:123]:src" ssh-bracket-clone-simple
 '
 
 test_expect_success 'uplink is treated as simple' '
-- 
2.15.0.rc1.287.g2b38de12cc

