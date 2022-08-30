Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C645AECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiH3JdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiH3Jcc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:32 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0A4DFB7A
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:21 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so15328252fac.12
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZEvynSs2hSAJBxY5Z1n8aBnLEOJKjM1ygizJX+kjujY=;
        b=CHNZ+A4AWxyEuQZnvXnNaX07xEA8e58ykAubV1xZGCjWMyyq2+MgP6MnhvOOq/r0hk
         AwY3V76rEi8lEbvxzpT5jnZ1QrF63C0wA2Iq1tZ80cowMUtgGbMZWZF76553fwIC1EQR
         sJBnQSvaalVzP6obJHJ/YRjVG3j+IOI3iEdzV+YI+kW4xH7NVkhXI/78rVqKkhobqqDH
         JwMC6+B/QMt8ta6oC1eQjSRUz5Sc1pjw4bJSEH7RzIvDJ2K24GKMhW4KJ4AooejguoMO
         /NfcU5+OrYeFnniaiO5PoSLB5BHxgv+y0jxZYtHcKNyj3DNiVZcZ0p1RWW44pfz4RVGO
         vbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZEvynSs2hSAJBxY5Z1n8aBnLEOJKjM1ygizJX+kjujY=;
        b=VV+tIlNiSD0lEFq1DFkHQ7UCSf2GH7+SW0SwdaJMDWgSZIlHaj6wUBiHbF9qmuRMi1
         Jbq93RRdfVWaxcTWkncD8cFUoFMjRIxGl2qfRh8oJx2e8RbGhQN30JOrGAOQFFYppOWC
         GEi2IjYDazeZO1q5rKchkUhtyDm+Wnrv/xjBykHEIY2KiXdvpmXZXO7UY1+WBf5GOv9+
         ReqeoeQlWRl+aelm5mfv9Wfn7KNBBqox0FqqWAIVe0OBEt2vpLPa6cfvjp9SfaN2icbh
         qE23OLF5FC338GB1NPaR9zsyYTg7GQ5S8Dmfbd1M9cmTuykHruBhvmCjjFaJhixm/Ydk
         Z9zQ==
X-Gm-Message-State: ACgBeo3sBueJei08VfxYHrD4XP/NHAa/g7V6/zJyeBkbFxbl3wrmJmz9
        ctUU2bVmermFtoyMblGEWcpkMOWABz4=
X-Google-Smtp-Source: AA6agR6fnaFPYxvmZ6lq8JxZwYXDBx/aoOkhxZbFjHJqqnHrUvTEIfVQykD8HAhsD3LwqwpEup1mNg==
X-Received: by 2002:a05:6870:d291:b0:11d:25d6:e521 with SMTP id d17-20020a056870d29100b0011d25d6e521mr9848659oae.198.1661851941308;
        Tue, 30 Aug 2022 02:32:21 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v6-20020a4aad86000000b00448a3ecdc9dsm6386317oom.22.2022.08.30.02.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:20 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 24/51] completion: zsh: fix extra space on foo=
Date:   Tue, 30 Aug 2022 04:31:11 -0500
Message-Id: <20220830093138.1581538-25-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Upstream commit e1e00089da fixed the issue for Bash, but not for Zsh.

When we are typing configurations an = at the end signifies we still
want to type the value.

Can be tested with:

  git -c log.d<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 t/t9904-zsh-completion.sh             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index b062090a13..f732881958 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -87,7 +87,7 @@ __gitcomp ()
 			fi
 			c="$c${4-}"
 			case $c in
-			--*=|*.) ;;
+			*=|*.) ;;
 			*) c="$c " ;;
 			esac
 			array+=("$c")
diff --git a/t/t9904-zsh-completion.sh b/t/t9904-zsh-completion.sh
index 4c7cf4234e..7283af3342 100755
--- a/t/t9904-zsh-completion.sh
+++ b/t/t9904-zsh-completion.sh
@@ -1078,7 +1078,7 @@ test_expect_success 'git -c - section' '
 	EOF
 '
 
-test_expect_failure 'git -c - variable name' '
+test_expect_success 'git -c - variable name' '
 	test_completion "git -c log.d" <<-\EOF
 	log.date=Z
 	log.decorate=Z
@@ -1100,7 +1100,7 @@ test_expect_success 'git clone --config= - section' '
 	EOF
 '
 
-test_expect_failure 'git clone --config= - variable name' '
+test_expect_success 'git clone --config= - variable name' '
 	test_completion "git clone --config=log.d" <<-\EOF
 	log.date=Z
 	log.decorate=Z
-- 
2.37.2.351.g9bf691b78c.dirty

