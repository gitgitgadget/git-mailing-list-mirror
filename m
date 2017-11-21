Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0EF6202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 01:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbdKUBtX (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 20:49:23 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:43614 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdKUBtW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 20:49:22 -0500
Received: by mail-it0-f67.google.com with SMTP id m191so125710itg.2
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 17:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=02ArWBmkrw/LUf8LOAX9tGPQAob+AS1FU3ciQm26Ck8=;
        b=mWLJ7c2BVL3EOhAA5Vh44eqnb8Jn7LaUgbfmzzUnD2FYT16l5ATMw0W/H1xC08NtuX
         c2qFWNSRjRlt9cCKg30aRy3EAGymHNutW/2Z0mEJl9g1+MbLBASOvtXxE5MeZe4DPtf+
         GgkBNyEQ1TAQU1sDcQVjjBg3DsDq1BQ/uB+dJMOv7J5tO2L0vZ0hTGS0Xzgoty7G6cSn
         E80FnOJAerUMJivbzustcNDZbinpd2hgw0eRsm+zyNj/JJxqiz+k0PAGy7QtsipHV3lO
         /5miF7CWbNGOnJt9Nkq+K3qpK2qe1Tbq1vlQrMFkopEPAcSeJ2ZgroEB9P73FynCHaFi
         IIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=02ArWBmkrw/LUf8LOAX9tGPQAob+AS1FU3ciQm26Ck8=;
        b=MDZ7vmG3iybSwPwNMc+n8bAnlzPOJQayitfBeM+c9Gtrhuq0TWA6M5jwBIa9WsIMRn
         JzHyLYFqqBfgx3Ij2pW83zZzYW9WiWcOw/AjYim5l42KmZC/Mhmhbbf9O+kjmw5t+6K1
         LM//QQceHPEnAvfWVtT7Tiw1eBJzb8YU5LaJoyMn4mncMh6z/UJnBXxRrJSFzbkabMzR
         DLao95/jrGJXrrfhsgc+Pqg7avBHpO1EkN9FZd0zANt9zaIhzmXLZdAegRf4aFB14u+5
         IB9Etv84ncAgGmhMA3cuiZWrmjpE5Ea2SsR+NeenL892icfTSeWHCK/C+soQptJ2JtTg
         2glw==
X-Gm-Message-State: AJaThX5vbJwudW13B0Dq4Jnib7Tx+iox0bJfJjoB4FAHCiStRFVRKxPw
        PpTJsLJ3z5zOjSC8/TMncZB/eTGI
X-Google-Smtp-Source: AGs4zMYpe0kunJO12a0MB6Y34p9Cs66Y+46G7keDSYEoy6XxKSQutBnyeOZRhuTVLVkgWt6owtHVJw==
X-Received: by 10.36.92.14 with SMTP id q14mr11861876itb.79.1511228961947;
        Mon, 20 Nov 2017 17:49:21 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c36sm2709437iod.11.2017.11.20.17.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 17:49:21 -0800 (PST)
Date:   Mon, 20 Nov 2017 17:49:19 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/8 v2] ssh test: make copy_ssh_wrapper_as clean up after
 itself
Message-ID: <20171121014919.p4cl5esf7evptzbk@aiede.mtv.corp.google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
 <20171120212223.wquyxbmz34foynrk@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120212223.wquyxbmz34foynrk@aiede.mtv.corp.google.com>
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
Acked-by: Brandon Williams <bmwill@google.com>
---
Jonathan Nieder wrote:

> Thanks to Dscho for tracking this subtle issue down.
>
>  t/t5601-clone.sh | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
[...]
> +++ b/t/t5601-clone.sh
> @@ -306,21 +306,20 @@ test_expect_success 'clone checking out a tag' '
[...]
>  copy_ssh_wrapper_as () {
>  	cp "$TRASH_DIRECTORY/ssh$X" "${1%$X}$X" &&
> +	test_when_finished "rm -f ${1%$X}$X" &&

I noticed while looking this over again that it is not exactly right.
$1 is likely to include spaces, causing the "rm" command not to delete
anything.  Removing the "-f" confirms the bug.

A small tweak fixes it:

 diff --git i/t/t5601-clone.sh w/t/t5601-clone.sh
 index 9d007c0f8d..4a16a0b7dd 100755
 --- i/t/t5601-clone.sh
 +++ w/t/t5601-clone.sh
 @@ -317,7 +317,7 @@ test_expect_success 'set up ssh wrapper' '
  
  copy_ssh_wrapper_as () {
  	cp "$TRASH_DIRECTORY/ssh$X" "${1%$X}$X" &&
 -	test_when_finished "rm -f ${1%$X}$X" &&
 +	test_when_finished "rm $(git rev-parse --sq-quote "${1%$X}$X")" &&
  	GIT_SSH="${1%$X}$X" &&
  	test_when_finished "GIT_SSH=\"\$TRASH_DIRECTORY/ssh\$X\""
  }

 t/t5601-clone.sh | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 86811a0c35..4a16a0b7dd 100755
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
+	test_when_finished "rm $(git rev-parse --sq-quote "${1%$X}$X")" &&
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

