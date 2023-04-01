Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F69C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDAIsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDAIra (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:30 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21271D87A
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:01 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17fcc07d6c4so11578876fac.8
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN6l6aoWwNZ205R8J1LlSn2kSK2ZuQL7AA/f5iPR8j4=;
        b=BqlyiipGw5yJsIwf6G2KKSStP3QDFVr1APvLYfvOUN7PcrWoHyliwBPhYEGN+g0MJV
         gCBMObibiyNznpRWSF+aV8Vy/K37Spz3GtFTJUaKCenYe4rbsAt3UYQId9LTuzPm61rD
         5LieyrVVY2xMULIfU9yYN9hcxAh/4adnsPg0jUd4OR33wMgXhkImVnatIqFiQKvBY3Ks
         Oe09g7i6FZzFWWWD4YraNruBvfiEgZhJ0WFkgIItfGHXvtjGnAwI2yDcvMkN+fOhWby3
         atLcbT64Uox2qgOrkPYmxeTGnOSnrQGs5jPLBH6k8uQRsCj7rkK0e6Zb+oVHpOKLvYSu
         S/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nN6l6aoWwNZ205R8J1LlSn2kSK2ZuQL7AA/f5iPR8j4=;
        b=rLPrVgDERxsjUZGV+7VlwC/eXUYNZakHxNQg2GcYvwZFuYNvbeQF69EPrLDEWwNj/1
         AvzChdLhmmwsw0AQcZUXSzYbs/tiGPjjSSYpuBgZtURaSgzi3+dFx7OdOMSTUVVtKhwJ
         kD1+m4Pw3pzXsQfpiub1DuIN+WOIGPpp/Ar3Vf4Manwl6IVlMeL17voNRNTfUJT1/Umr
         Qx8ta/FKKDwdhU7LWHyI4WXgvJkO/G3bS7ZOtDUMGejMRDWwUspm4lxeka9TSD1ZFqeS
         +mtZwMOoZ00qpDhfqpmoTXXbo7opZCMhCczVgujUbxxP7UF0mQkblsy1rbuA6ChpMzzw
         LPLA==
X-Gm-Message-State: AO0yUKWCMLb7unCNAHFB45f7nJcPVVERxHpQsDXYDg2Upq+T7bJzTuJ7
        hc8oUczMeQaB4cCCx9I79GfHXDoo/WI=
X-Google-Smtp-Source: AKy350bqfJmo6BlgdYrCnol+t20h21FEkGV4zWgrtN+PlwKst4OrVG5K6NMLSQWthDXQ6Wlsd9pr4w==
X-Received: by 2002:a05:6870:c6a4:b0:16e:8edf:42be with SMTP id cv36-20020a056870c6a400b0016e8edf42bemr19837845oab.50.1680338821162;
        Sat, 01 Apr 2023 01:47:01 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id zq42-20020a0568718eaa00b0016b0369f08fsm1736454oab.15.2023.04.01.01.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:00 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 24/49] completion: zsh: fix extra space on foo=
Date:   Sat,  1 Apr 2023 02:46:01 -0600
Message-Id: <20230401084626.304356-25-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
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
 t/t9904-completion-zsh.sh             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index a7a5efbd13..038ab30869 100644
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
diff --git a/t/t9904-completion-zsh.sh b/t/t9904-completion-zsh.sh
index 1b18bf5363..4355552434 100755
--- a/t/t9904-completion-zsh.sh
+++ b/t/t9904-completion-zsh.sh
@@ -1097,7 +1097,7 @@ test_expect_success 'git -c - section' '
 	EOF
 '
 
-test_expect_failure 'git -c - variable name' '
+test_expect_success 'git -c - variable name' '
 	test_completion "git -c log.d" <<-\EOF
 	log.date=Z
 	log.decorate=Z
@@ -1119,7 +1119,7 @@ test_expect_success 'git clone --config= - section' '
 	EOF
 '
 
-test_expect_failure 'git clone --config= - variable name' '
+test_expect_success 'git clone --config= - variable name' '
 	test_completion "git clone --config=log.d" <<-\EOF
 	log.date=Z
 	log.decorate=Z
-- 
2.33.0

