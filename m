Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA241F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfKOBBF (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33868 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKOBBE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id n13so5485754pff.1
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sAOVtsmEgzRWCTJ/CHwqxE5je/Gt8viLuSR0eJaLVq0=;
        b=MrJaQJIvuKuebaRTfTvXPcbeE3kSxvg1tBrIg1oIKrmWFO6eDd4Vi0DHKw5g99+wm7
         jypRs3JGaqFvnkarZ/K4heiBmpykGfknMW3cSrcVAXMJKNCy+YQYDgnFkTNOniWheYdQ
         kS2ffvHv1kyONJuT4yHo1BNJUkPL17mhfpBbRdJL7fV48C92irl+hMyQviEvzOyAPDK6
         R9RSb/kYE6VOYAMMpJe0Fh4Fkmz1IOHbjKy142iZvRypSC48qnYElKrDbX4L478Wg1r9
         3Qqo4UEobuvrdKhY1drwpluK35PdHjZGuYd5VTof2lmIHjNCRr9jdZQ9MjAX4YSW8S3U
         bMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sAOVtsmEgzRWCTJ/CHwqxE5je/Gt8viLuSR0eJaLVq0=;
        b=N0fDca88/N9a0VQMaTv9pGI0i7cfv1JH8EDpnS4VozGuHzm8XJVXuk72wjJkFTAuLi
         T6kd4XRprhveh14aMUwEvo1rwv7ujMnN3moUdhaMBfw3UZSMGuqXZ0xj2f70h+NckQge
         tDsENrhZ+jczJQlO5VzypUqbVqKbmrLCDBtW0SrbeY0LwZguhXaxkra6MD57fzSIfvDW
         qE4cdnkJiifT9jERpAdev/c2Pb+uWrxlyGOj8iYwbZRjY61dumQiA3o9pT6KgPZlQ6QV
         9wlvsQOY7OS6JnPx5f/GsQ5LoEQ6bvIireCljy1Cn2h3HwOxcBsk++qXWxrtyT3zq8ST
         19Vg==
X-Gm-Message-State: APjAAAUHoatVACC9w+4DTwC/cl44cVkw4WtZ02zH9lnDEYewnodMrmT4
        W3d9oKrxzKXC7O/6k4ERmwx0OzE9
X-Google-Smtp-Source: APXvYqzSnKekSqy3GfFJqfGvG2WPTQ9OpPU5mpYWPIwe5X8QiEB043wx4hBiJEoIIckjO0ydV2UZbg==
X-Received: by 2002:a17:90a:cc18:: with SMTP id b24mr15399377pju.141.1573779663560;
        Thu, 14 Nov 2019 17:01:03 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id k24sm9351966pfk.63.2019.11.14.17.01.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:03 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:01 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 13/27] t5703: stop losing return codes of git commands
Message-ID: <8fc59e67d74faabf43965a5eac1a4147124c56d5.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there are two ways where the return codes of git commands are
lost. The first way is when a command is in the upstream of a pipe. In a
pipe, only the return code of the last command is used. Thus, all other
commands will have their return codes masked. Rewrite pipes so that
there are no git commands upstream.

The other way is when a command is in a non-assignment command
substitution. The return code will be lost in favour of the surrounding
command's. Rewrite instances of this such that git commands are in an
assignment-only command substitution.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5703-upload-pack-ref-in-want.sh | 52 +++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 3a2c143c6d..9f6d837720 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -18,14 +18,16 @@ get_actual_commits () {
 		p
 		}' <out | test-tool pkt-line unpack-sideband >o.pack &&
 	git index-pack o.pack &&
-	git verify-pack -v o.idx | grep commit | cut -c-40 | sort >actual_commits
+	git verify-pack -v o.idx >objs &&
+	grep commit objs | cut -c-40 | sort >actual_commits
 }
 
 check_output () {
 	get_actual_refs &&
 	test_cmp expected_refs actual_refs &&
 	get_actual_commits &&
-	test_cmp expected_commits actual_commits
+	sort expected_commits >sorted_commits &&
+	test_cmp sorted_commits actual_commits
 }
 
 # c(o/foo) d(o/bar)
@@ -75,17 +77,19 @@ test_expect_success 'invalid want-ref line' '
 '
 
 test_expect_success 'basic want-ref' '
+	oid=$(git rev-parse f) &&
 	cat >expected_refs <<-EOF &&
-	$(git rev-parse f) refs/heads/master
+	$oid refs/heads/master
 	EOF
-	git rev-parse f | sort >expected_commits &&
+	git rev-parse f >expected_commits &&
 
+	oid=$(git rev-parse a) &&
 	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
 	0001
 	no-progress
 	want-ref refs/heads/master
-	have $(git rev-parse a)
+	have $oid
 	done
 	0000
 	EOF
@@ -95,19 +99,22 @@ test_expect_success 'basic want-ref' '
 '
 
 test_expect_success 'multiple want-ref lines' '
+	oid_c=$(git rev-parse c) &&
+	oid_d=$(git rev-parse d) &&
 	cat >expected_refs <<-EOF &&
-	$(git rev-parse c) refs/heads/o/foo
-	$(git rev-parse d) refs/heads/o/bar
+	$oid_c refs/heads/o/foo
+	$oid_d refs/heads/o/bar
 	EOF
-	git rev-parse c d | sort >expected_commits &&
+	git rev-parse c d >expected_commits &&
 
+	oid=$(git rev-parse b) &&
 	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
 	0001
 	no-progress
 	want-ref refs/heads/o/foo
 	want-ref refs/heads/o/bar
-	have $(git rev-parse b)
+	have $oid
 	done
 	0000
 	EOF
@@ -117,10 +124,11 @@ test_expect_success 'multiple want-ref lines' '
 '
 
 test_expect_success 'mix want and want-ref' '
+	oid=$(git rev-parse f) &&
 	cat >expected_refs <<-EOF &&
-	$(git rev-parse f) refs/heads/master
+	$oid refs/heads/master
 	EOF
-	git rev-parse e f | sort >expected_commits &&
+	git rev-parse e f >expected_commits &&
 
 	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
@@ -138,17 +146,19 @@ test_expect_success 'mix want and want-ref' '
 '
 
 test_expect_success 'want-ref with ref we already have commit for' '
+	oid=$(git rev-parse c) &&
 	cat >expected_refs <<-EOF &&
-	$(git rev-parse c) refs/heads/o/foo
+	$oid refs/heads/o/foo
 	EOF
 	>expected_commits &&
 
+	oid=$(git rev-parse c) &&
 	test-tool pkt-line pack >in <<-EOF &&
 	command=fetch
 	0001
 	no-progress
 	want-ref refs/heads/o/foo
-	have $(git rev-parse c)
+	have $oid
 	done
 	0000
 	EOF
@@ -211,13 +221,14 @@ test_expect_success 'fetching with exact OID' '
 
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
+	oid=$(git -C "$REPO" rev-parse d) &&
 	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin \
-		$(git -C "$REPO" rev-parse d):refs/heads/actual &&
+		"$oid":refs/heads/actual &&
 
 	git -C "$REPO" rev-parse "d" >expected &&
 	git -C local rev-parse refs/heads/actual >actual &&
 	test_cmp expected actual &&
-	grep "want $(git -C "$REPO" rev-parse d)" log
+	grep "want $oid" log
 '
 
 test_expect_success 'fetching multiple refs' '
@@ -239,13 +250,14 @@ test_expect_success 'fetching ref and exact OID' '
 
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
+	oid=$(git -C "$REPO" rev-parse b) &&
 	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin \
-		master $(git -C "$REPO" rev-parse b):refs/heads/actual &&
+		master "$oid":refs/heads/actual &&
 
 	git -C "$REPO" rev-parse "master" "b" >expected &&
 	git -C local rev-parse refs/remotes/origin/master refs/heads/actual >actual &&
 	test_cmp expected actual &&
-	grep "want $(git -C "$REPO" rev-parse b)" log &&
+	grep "want $oid" log &&
 	grep "want-ref refs/heads/master" log
 '
 
@@ -312,9 +324,11 @@ inconsistency () {
 	# repository appears to change during negotiation, for example, when
 	# different servers in a load-balancing arrangement serve (stateless)
 	# RPCs during a single negotiation.
+	oid1=$(git -C "$REPO" rev-parse $1) &&
+	oid2=$(git -C "$REPO" rev-parse $2) &&
 	printf "s/%s/%s/" \
-	       $(git -C "$REPO" rev-parse $1 | tr -d "\n") \
-	       $(git -C "$REPO" rev-parse $2 | tr -d "\n") \
+	       $(echo "$oid1" | tr -d "\n") \
+	       $(echo "$oid2" | tr -d "\n") \
 	       >"$HTTPD_ROOT_PATH/one-time-sed"
 }
 
-- 
2.24.0.399.gf8350c9437

