Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563EAC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbiFJCBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242371AbiFJCBt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:01:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77BDC5D8D
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:01:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o8so6798242wro.3
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ChJ0UWGnKWNAzJEGuVJvGlHsRUoBcHgWoK5/26y+PJk=;
        b=TwVG16mBwv20S0yQZHwVcfLqBJ61i40QuT99lgQcDGe/C6+zl/58//LYvV928I+x78
         KD8LoZwzhhqa6ULnlR7A08kxqw7EMPSLUKkY3yA7J5TU0Ehg1klOgO0GLQIB2vErPBvI
         p7sHGovnl3qqftQix5TS48ZeSKJRA2aJqjQyKYMBZva9Ticsn3Exi0nfOpsg9OSyKyMc
         h6k/1e3n/LBdbIx3psQHjy1IvoanColv0m8IZqaCOapiVpk3k7tWLLw6MpM6DBiQ2CbG
         n3+phJ5ilWB5xjVuVGu9ZRp2TJrd4OJUtfpCvjaQwv7FwTRUW0p2F1oWcGxlSihYbAJT
         75ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ChJ0UWGnKWNAzJEGuVJvGlHsRUoBcHgWoK5/26y+PJk=;
        b=zeWRzCHpeVcljBN2Z5W8b9jkruyREKORvmlrzQy8XmXiFSJH6S7q5toznNtsRIxDgp
         l/oiGuri8WaPI1s/Qr6KAo6fCQL/UaHx+D91R3Ry/UdLNhxvY/hQ89ou5r56v8X2oA8a
         mKouDSEkxZ/ToFR48Jlvmw/KH8gnAeez/ymcCxhRyyyv8KxF01NlWneRyp0b4NL0fLZu
         u5afuXeIUX+lMYnsBA1t+W44PUyBbSoez95/J5L2o8V7q4gI8VsouoS+0Oaf3odukp7x
         Ese+Kk7xxSCLJCOiZ5lWfFYLqsxO9TAd/fjnG1xAmg0KBeosMcBYE56mS9vwWz7v+Maz
         RSvA==
X-Gm-Message-State: AOAM532hYTnwhMKEXQUvFI/Gid3P9F4qh9VCiHy5LUnrKpePV5PTMfm6
        WzKpgBhb614Ryksclg5+DQaSUjr88nvWXQ==
X-Google-Smtp-Source: ABdhPJxfAKjqiaRx/Gc+VmV4le4hgo7BykU3uVjs1suHqq0BjmYnND6gEUM5QG/lfJ7POsC6eDiGaw==
X-Received: by 2002:adf:fd0f:0:b0:210:32d7:4cb5 with SMTP id e15-20020adffd0f000000b0021032d74cb5mr41437194wrr.565.1654826505935;
        Thu, 09 Jun 2022 19:01:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 02/20] git-submodule.sh: remove unused $prefix variable
Date:   Fri, 10 Jun 2022 04:01:14 +0200
Message-Id: <RFC-patch-02.20-8fcd832e58f-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the $prefix variable which is never set, and never resulted in
an option being passed to our "git submodule--helper". The
--recursive-prefix option to "git submodule--helper" is still used,
but only when it invokes itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bc436c4ca47..53847bbf6e2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -41,7 +41,6 @@ files=
 remote=
 nofetch=
 update=
-prefix=
 custom_name=
 depth=
 progress=
@@ -127,7 +126,7 @@ cmd_add()
 		usage
 	fi
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
 }
 
 #
@@ -189,7 +188,7 @@ cmd_init()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
 }
 
 #
@@ -346,7 +345,6 @@ cmd_update()
 		${init:+--init} \
 		${nofetch:+--no-fetch} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
-		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
 		${dissociate:+"--dissociate"} \
-- 
2.36.1.1178.gb5b1747c546

