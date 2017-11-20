Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F168D202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 21:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbdKTVah (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:30:37 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:42317 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752739AbdKTVaf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:30:35 -0500
Received: by mail-io0-f195.google.com with SMTP id u42so17232221ioi.9
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w7ccXAaeBiNoa+C6YYsjPqn/90chYCGWPaNZe2m0y9w=;
        b=gxqeTtup7eCoM4iBan0HxqP1390gaVCTF5QzHG2bG0GCwaLghnSSZUOAxfnZRtbvYS
         CkOyym0WY/89wDVlTKRSniDRfQQ7ObR6Tg6ET0nsJ30Z9JTvfh9DCV5NCgXBXrpUWrx3
         eiyoP1VElmguxG8EBlyZj4fpfaQluHwTAorNQWK8kENBgylTTuw80Y0z/nPpJ13JHqu+
         4MFw/tqAgWLgW7k6RrHsSpFYhxmbelhi5Ao7PNpnlk00+WXUpoRz5+XGEwirosqn5IUv
         KLgETdVYI1bCpuzXbnNw62J/g/Pzv1JKDVVjQzO3+Sx3yxem+qR2gyM0/Qk69M08hUcp
         9qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w7ccXAaeBiNoa+C6YYsjPqn/90chYCGWPaNZe2m0y9w=;
        b=JaCpqyV1PFrkBsOUZMpMVUBk9VG98uw9/rgZrVyH6yHN1J9FD1w7P8I76wDPA66BC1
         56DAWMJhBlzKHIz820LzCrYEEOZLOL0Aew55T6XvGdUNDEqPlbSY08q3ZmfGRzgNTpIT
         T4Ju+J9Nb9tjxLWJZLz+hSV+OjpLQkCs17IuO8jEl1/39+HSNstW1n2wXGCoWS/omK24
         q9GTMztHshYhwLMAynPCdxGQZba9L3B56KfNAUXkvTAuMl3GFBbZncEXrBVgi2+0hyJL
         LtCqnGVsHlCE4sEMcSyhCCrCUE9eK3OF12jfPSveDBYx/2ZTqPwT8P7Gp/dc/LAhDy+7
         43Yw==
X-Gm-Message-State: AJaThX5yhv4MV0wmwDPsMspY+gNGE2DF7bLGJdsMbJsxUDqSopmosur3
        IVpwoanuX0wI3QTpYjrN1xsp/Ff5
X-Google-Smtp-Source: AGs4zMblu38hcMrFupVtxdaf2vyPMzuaDt5FQJvJrLXFU1+AOtLWNx4POB3G+3Szt24htfUXmzjhXQ==
X-Received: by 10.107.82.12 with SMTP id g12mr17359944iob.122.1511213433109;
        Mon, 20 Nov 2017 13:30:33 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l195sm5465293itl.0.2017.11.20.13.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 13:30:32 -0800 (PST)
Date:   Mon, 20 Nov 2017 13:30:30 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: [PATCH 7/8] ssh: 'simple' variant does not support -4/-6
Message-ID: <20171120213030.ya5kxw7vldgid34g@aiede.mtv.corp.google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user passes -4/--ipv4 or -6/--ipv6 to "git fetch" or "git push"
and the ssh command configured with GIT_SSH does not support such a
setting, error out instead of ignoring the option and continuing.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Stefan Beller <sbeller@google.com>
---
As before.

 connect.c        | 25 ++++++++++++++++++++++---
 t/t5601-clone.sh | 12 ++++++------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/connect.c b/connect.c
index 455c54a2ec..be106d1868 100644
--- a/connect.c
+++ b/connect.c
@@ -938,11 +938,30 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
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
index 209e2d5604..ad910ae9fa 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -364,9 +364,10 @@ test_expect_success 'OpenSSH variant passes -4' '
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
 
 test_expect_success 'variant=auto picks based on basename' '
@@ -375,10 +376,9 @@ test_expect_success 'variant=auto picks based on basename' '
 	expect_ssh "-4 -P 123" myhost src
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
2.15.0.448.gf294e3d99a

