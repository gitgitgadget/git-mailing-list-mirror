Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A42F202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 21:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbdKTVW2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:22:28 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:42673 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752855AbdKTVW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:22:26 -0500
Received: by mail-io0-f195.google.com with SMTP id u42so17210246ioi.9
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z9lfPOUBnykXndrh41SwS/KU5nkfx5f2ninzcXtII3w=;
        b=JcCt/TQ/nzBpthgw4cs57fFQ9BnkT8A1on9gUgrXz2ki0onaOhiEL+hnmiVzp+fQTM
         eZKTtUp9nUfuaEDHvBH/VCcdrVkDtMGXBUK0tnBVDjlsr2qFwIoYUlU3dz4xZ/h4+H1J
         DCpbH4femiQEcuU1YtQZs4leZZaXGCqiRFJn6R3DaKOl+nE35Cq1bVUFfeU2pe81qLMI
         Wv6+YNpyDXGNn4Y8JvMRuiPKJrlS8rL20IiT668/9sdwzutXdrlcI10dQHsDPEXU5kdy
         Ubddf4DtZgaMdQPDnax7jAXkm0L8edT5F5yujML5Lax8pFq+1TDdohl9COez1YIRicdr
         si3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z9lfPOUBnykXndrh41SwS/KU5nkfx5f2ninzcXtII3w=;
        b=TVl5kSTfxkMys8DDXpQmm753yaShzMa0N/aXNlr3oQRczjTHRThfPmMZfcDN9BO9aW
         /JKIZwPB9H51czKTlCsyUlZ5oWbsRa0R0o0bAXIdeNGUplDmr89BIkJEMlbQYfmGV7JK
         ApfYlVa4k8lpTASy+uZxBlHNacu6vNJ14pA0fP28W7uytO8+Lpwm51NwCW6Uh1kZLCbE
         h83zMmF9e+UyGaim+Su0jDBkEBhZNWCIi2z6GmA6zub7ZKCd0dbtF//EQInBY+Z4ddVT
         Ah0jNm+xTEl57gVR4vyyseTcSeXHEGFx2LseHZ7lJsoP7dMp9dU/di42xysM/2qJDW9y
         W/Sw==
X-Gm-Message-State: AJaThX6ck5Ky+9WDzf4enqkZ4tzua74bg6oXNlf/Rc+/Q24x5p/NA14g
        UdkD5Cq5JoH77NmBKqbkl6txzKw0
X-Google-Smtp-Source: AGs4zMbaJwmrviL7bAdXhachFVeVh2D/UreIpBPrKYVykJHCOaU8vsbDgYlQKJffL+d/sSsLdCbiYg==
X-Received: by 10.107.30.76 with SMTP id e73mr1603154ioe.60.1511212945753;
        Mon, 20 Nov 2017 13:22:25 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i76sm5474339ita.21.2017.11.20.13.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 13:22:25 -0800 (PST)
Date:   Mon, 20 Nov 2017 13:22:23 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/8] ssh test: make copy_ssh_wrapper_as clean up after itself
Message-ID: <20171120212223.wquyxbmz34foynrk@aiede.mtv.corp.google.com>
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

Simplify by not allowing the copied ssh wrapper to persist between
tests.  This way, tests can be safely reordered, added, and removed
with less fear of hidden side effects.

This also avoids having to call setup_ssh_wrapper to restore the value
of GIT_SSH after this battery of tests, since it means each test will
restore it individually.

Noticed because on Windows, if `uplink.exe` exists, the MSYS2 Bash
will overwrite that when redirecting via `>uplink`.  A proposed test
wrote a script to 'uplink' after a previous test created uplink.exe
using copy_ssh_wrapper_as, so the script written with '>uplink' had
the wrong filename and failed.

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks to Dscho for tracking this subtle issue down.

 t/t5601-clone.sh | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 86811a0c35..9d007c0f8d 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -306,21 +306,20 @@ test_expect_success 'clone checking out a tag' '
 	test_cmp fetch.expected fetch.actual
 '
 
-setup_ssh_wrapper () {
-	test_expect_success 'setup ssh wrapper' '
-		cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
-			"$TRASH_DIRECTORY/ssh$X" &&
-		GIT_SSH="$TRASH_DIRECTORY/ssh$X" &&
-		export GIT_SSH &&
-		export TRASH_DIRECTORY &&
-		>"$TRASH_DIRECTORY"/ssh-output
-	'
-}
+test_expect_success 'set up ssh wrapper' '
+	cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
+		"$TRASH_DIRECTORY/ssh$X" &&
+	GIT_SSH="$TRASH_DIRECTORY/ssh$X" &&
+	export GIT_SSH &&
+	export TRASH_DIRECTORY &&
+	>"$TRASH_DIRECTORY"/ssh-output
+'
 
 copy_ssh_wrapper_as () {
 	cp "$TRASH_DIRECTORY/ssh$X" "${1%$X}$X" &&
+	test_when_finished "rm -f ${1%$X}$X" &&
 	GIT_SSH="${1%$X}$X" &&
-	export GIT_SSH
+	test_when_finished "GIT_SSH=\"\$TRASH_DIRECTORY/ssh\$X\""
 }
 
 expect_ssh () {
@@ -344,8 +343,6 @@ expect_ssh () {
 	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
 }
 
-setup_ssh_wrapper
-
 test_expect_success 'clone myhost:src uses ssh' '
 	git clone myhost:src ssh-clone &&
 	expect_ssh myhost src
@@ -432,12 +429,14 @@ test_expect_success 'ssh.variant overrides plink detection' '
 '
 
 test_expect_success 'GIT_SSH_VARIANT overrides plink detection to plink' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
 	GIT_SSH_VARIANT=plink \
 	git clone "[myhost:123]:src" ssh-bracket-clone-variant-3 &&
 	expect_ssh "-P 123" myhost src
 '
 
 test_expect_success 'GIT_SSH_VARIANT overrides plink to tortoiseplink' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
 	GIT_SSH_VARIANT=tortoiseplink \
 	git clone "[myhost:123]:src" ssh-bracket-clone-variant-4 &&
 	expect_ssh "-batch -P 123" myhost src
@@ -449,9 +448,6 @@ test_expect_success 'clean failure on broken quoting' '
 		git clone "[myhost:123]:src" sq-failure
 '
 
-# Reset the GIT_SSH environment variable for clone tests.
-setup_ssh_wrapper
-
 counter=0
 # $1 url
 # $2 none|host
-- 
2.15.0.448.gf294e3d99a

