Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295DB202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 21:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbdKTVbI (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:31:08 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:39554 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752980AbdKTVbE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:31:04 -0500
Received: by mail-it0-f68.google.com with SMTP id x13so3586373iti.4
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VoUeClrfGDrgHCcsjFOOv+0ValKCpG1sD4umX8tKbk8=;
        b=a1SKRLdvmb12BGZKVwp/OIoCAjH4k/aKmHr5K8wZZ4Jl0LymWuowPMyTApGa6NerbJ
         6RV1BoMzKwRXxzkxYgo7ZlHIKb0HMCYxpTzxTlEVMP3FSTUk7NLucy9Ix+3itTL+nzuO
         Xz91I3K2issbklBsMEBP7Q/KXpWfIfJVE+tp7zxu1xsLcYLetMwWZf8RByrCC+TJOZg8
         Kp8Zwsz345LyhOnRwjWe/ziBdgJ/aorAXZz7k1G52s2r/T4QoI4il1qwWWYy15oABLuG
         Ap5d0kCVMPU6n+rLoiFTCdrC9SbGWEXUJ6+YVlhuVYSRCdVnny/ZXESXTLmjJ+brZgRF
         lcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VoUeClrfGDrgHCcsjFOOv+0ValKCpG1sD4umX8tKbk8=;
        b=sKt3tP6eIxDSEEH16c4ypS8BEUOAffvdVd3t5g9ho71t/iaKhXyQP5kaa82F2/zSH7
         TEcADXvzcZdOcQi4gFREqeJX3gwExBH3hUzKu9sWjbGz/jmPc4NUsjzlkG+j71w6Cdh7
         ZX2+HvTrUPe/M++Hd8XzDZZzA7coEcu7QbNB/IXJe4fnjMGE9sbT/U/g1EtctU2aJu1F
         uTB7ZyKSv8KoVmtLdCcC2IIkHocvudZr6Tum6d/PC3rV/hWKGvMXbWsXtIgEugrww/YZ
         xQY8Vramong+DbwLPYhDvFWpkDKbZsTjofHTzvktaSJcJfaXnxrunCrIegL8pHRX+H9t
         OmfA==
X-Gm-Message-State: AJaThX4YaohSVCrQF4knyWsvzqLeucOckbUD9GTE0zPS/HQleoZtDKWm
        qr6n3muaNSzpnO1rQoe3XUsnpevz
X-Google-Smtp-Source: AGs4zMaC6x+5r/eB0aup5WyOihrKgcTEAfHmtQpJ39BIUWAqAV63dHh672iKzSV2Oc26ZqkVhNj/SA==
X-Received: by 10.36.124.197 with SMTP id a188mr20310803itd.63.1511213464017;
        Mon, 20 Nov 2017 13:31:04 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 85sm4824864ioi.83.2017.11.20.13.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 13:31:03 -0800 (PST)
Date:   Mon, 20 Nov 2017 13:31:01 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: [PATCH 8/8] ssh: 'simple' variant does not support --port
Message-ID: <20171120213101.yquv2ywyjajjtr5x@aiede.mtv.corp.google.com>
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

When trying to connect to an ssh:// URL with port explicitly specified
and the ssh command configured with GIT_SSH does not support such a
setting, it is less confusing to error out than to silently suppress
the port setting and continue.

This requires updating the GIT_SSH setting in t5603-clone-dirname.sh.
That test is about the directory name produced when cloning various
URLs.  It uses an ssh wrapper that ignores all its arguments but does
not declare that it supports a port argument; update it to set
GIT_SSH_VARIANT=ssh to do so.  (Real-life ssh wrappers that pass a
port argument to OpenSSH would also support -G and would not require
such an update.)

Reported-by: William Yan <wyan@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Stefan Beller <sbeller@google.com>
---
As before.

That's the end of the series.  Thanks for reading.

 connect.c                | 15 ++++++++++++---
 t/t5601-clone.sh         | 10 ++++++++--
 t/t5603-clone-dirname.sh |  2 ++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/connect.c b/connect.c
index be106d1868..20ed1d9574 100644
--- a/connect.c
+++ b/connect.c
@@ -967,11 +967,20 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 	if (variant == VARIANT_TORTOISEPLINK)
 		argv_array_push(args, "-batch");
 
-	if (port && variant != VARIANT_SIMPLE) {
-		if (variant == VARIANT_SSH)
+	if (port) {
+		switch (variant) {
+		case VARIANT_AUTO:
+			BUG("VARIANT_AUTO passed to push_ssh_options");
+		case VARIANT_SIMPLE:
+			die("ssh variant 'simple' does not support setting port");
+		case VARIANT_SSH:
 			argv_array_push(args, "-p");
-		else
+			break;
+		case VARIANT_PLINK:
+		case VARIANT_PUTTY:
+		case VARIANT_TORTOISEPLINK:
 			argv_array_push(args, "-P");
+		}
 
 		argv_array_push(args, port);
 	}
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index ad910ae9fa..78dab81d87 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -378,12 +378,18 @@ test_expect_success 'variant=auto picks based on basename' '
 
 test_expect_success 'simple does not support -4/-6' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
-	test_must_fail git clone -4 "[myhost:123]:src" ssh-bracket-clone-simple
+	test_must_fail git clone -4 "myhost:src" ssh-4-clone-simple
+'
+
+test_expect_success 'simple does not support port' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
+	test_must_fail git clone "[myhost:123]:src" ssh-bracket-clone-simple
 '
 
 test_expect_success 'uplink is treated as simple' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/uplink" &&
-	git clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
+	test_must_fail git clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
+	git clone "myhost:src" ssh-clone-uplink &&
 	expect_ssh myhost src
 '
 
diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
index d5af758129..13b5e5eb9b 100755
--- a/t/t5603-clone-dirname.sh
+++ b/t/t5603-clone-dirname.sh
@@ -11,7 +11,9 @@ test_expect_success 'setup ssh wrapper' '
 	git upload-pack "$TRASH_DIRECTORY"
 	EOF
 	GIT_SSH="$TRASH_DIRECTORY/ssh-wrapper" &&
+	GIT_SSH_VARIANT=ssh &&
 	export GIT_SSH &&
+	export GIT_SSH_VARIANT &&
 	export TRASH_DIRECTORY
 '
 
-- 
2.15.0.448.gf294e3d99a

