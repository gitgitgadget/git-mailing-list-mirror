Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BCFB20437
	for <e@80x24.org>; Mon, 23 Oct 2017 23:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdJWXTS (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 19:19:18 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:54989 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdJWXTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 19:19:17 -0400
Received: by mail-io0-f195.google.com with SMTP id e89so21917727ioi.11
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0jfS64FPQeV70qIZHQFjDLPHAW2dSCC4KlAJrkR+YS8=;
        b=mIuJIom8AJw00HT0zyTSKklwqO3Q51pNDOeikTvj1i3CWHKeX+Cbgvr3fBEws/xlR8
         1BAIXYw993Be6V3BRPCF6lhkQWdEph7nAbenh+opFoLcISWCKTLV7qHedoSXj4HusWAn
         PbTEMbEzMH/+fi+IRBkAqZor4+sv8xKNm7UXvTxE3DWBt5HJgnQ2CDHsiezd1C2BNxFi
         iAH7RBbfkYG0ST9Hw8XQEz5bpGoIqEUKBkiArQr/F1Jtie2w8zsW/4l05RZ+nc80zd/O
         kgZpBpfpgy98voZiilNMvDUb1/jRqac+nLuqAPm0oYvb4XKit6ZWPp1LUqXB5nfO9mTR
         nFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0jfS64FPQeV70qIZHQFjDLPHAW2dSCC4KlAJrkR+YS8=;
        b=NT/8hY2FROiRz5HutecLVeWodrsRm163p+PbXuXlqyRea8t+mtJ4YMD5ft+pE6WGhO
         zwfmHTB0le2KQctIXZe/oQ5Ox+iGb1+DTY/B4UGVBTaw292RB8zPJ8JI/MgF05z9xZzM
         hFilRhk9La18JLWLxXooNc2WDKnJwdwqgOIX808PjFRxuMYLtqtO7UgIKGRhqJ+UZTjh
         2/fkTGhWThvdpEhXQKuPgseuqVo2px9bTPdt2kezM9lTNt+YWVbuNf4MUBm01uOvXUuA
         FvKypETVVi28FiYEhTiHP8DyjJAQoYqGj9U5mBhxogVdnrccRoDQSZcfrPt18nHeFh/U
         Ts6w==
X-Gm-Message-State: AMCzsaUfIIhnM/dx/78TaISqTMYJM4UeJBQGtS05K4tKHiEaDCLkhyXt
        DitZgugaWtQn3+rZC+9ph6s=
X-Google-Smtp-Source: ABhQp+Sq2GeBCfz11Wf+9+mzitzpHEMdV4Ey1RYKnqsIhX+3DeRwllUGkO8VvkLQ3I3CXN2LSouqjA==
X-Received: by 10.107.69.7 with SMTP id s7mr20013065ioa.108.1508800756825;
        Mon, 23 Oct 2017 16:19:16 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l123sm55932itl.3.2017.10.23.16.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 16:19:16 -0700 (PDT)
Date:   Mon, 23 Oct 2017 16:19:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, sbeller@google.com,
        William Yan <wyan@google.com>
Subject: [PATCH 4/5] ssh: 'simple' variant does not support -4/-6
Message-ID: <20171023231914.azmri2cjahmc7obe@aiede.mtv.corp.google.com>
References: <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
 <20171023151929.67165aea67353e5c24a15229@google.com>
 <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
 <20171023225106.GA73667@google.com>
 <20171023155713.5055125d7467d8daaee42e32@google.com>
 <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
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
As before, just rebased.

 connect.c        | 25 ++++++++++++++++++++++---
 t/t5601-clone.sh | 12 ++++++------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/connect.c b/connect.c
index 0441dcbacf..9c64e8155a 100644
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
index df9dfafdd8..ea401cec1f 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -367,9 +367,10 @@ test_expect_success 'OpenSSH variant passes -4' '
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
@@ -378,10 +379,9 @@ test_expect_success 'variant=auto picks based on basename' '
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
2.15.0.rc1.287.g2b38de12cc

