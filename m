Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448C5C7EE2E
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjFJUWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjFJUVm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867213A87
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30aebe2602fso1966717f8f.3
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428495; x=1689020495;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+/f/RVZomTkapsMngxop6R26fwIFTVcMJ/LWQ406iE=;
        b=ov7X11x4opCUa6gXX3qwJgPm0Bztqycmkpp4k3fGvmk6hethyBD5vp/0O5cgVTPtSW
         ViM4MY3HYYt5ACCKy095X+jYWYdibrvxKTn/GBsalkzR6anNYl2p4U9Du8Y09ulWd99w
         zDllOxb6g2HSqgHCjd4rHSGke5RCYZrzQUD7rS0g6z+3g7YPu+y2pn7HlcWWPbwSkvWi
         OoeT4B8itDyRpXeIZg4T187uZmEnht+ZkLkvqD4VRVWSQjcnfbPnDXix7y7gg9uAo/nx
         hBoBI+aHhOO+VpCD1ygQ5gDXvitPnGa1OU55LCtI4G9dPUMtCnqiUbp7GFJGtOeUKq/6
         6bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428495; x=1689020495;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+/f/RVZomTkapsMngxop6R26fwIFTVcMJ/LWQ406iE=;
        b=VmfelViqw4VF5MCwZEEh7tcGSfgd+rI3N7HPVZPxsUoUtQgh1rcA6dbKGzIpTSq7GK
         ljaOaZJC6/PJbj+jCJ5H7MfJthS1nZzxt3vtTa6UefKpp9OGxVUkLTOQGIfNABMKLwhg
         4QQHMJDESDr/eDOBcm+6fZAgxtthe00AfB0ZttjPfA5tQ41R//iRy7T5d9uxmOmJ0ybY
         bGzj+xmZg/saDGgPQg543UdNkyZPjzltdkTIZ2yIVIrwSORv6DannEklhgi3M9+xD216
         LqpImxKAkpyYQWWTeSD57ymXrQXaQSZVOxQjZLOXBfTGRqlcB4uEDcdnf6PxmqYJfP7A
         JUJw==
X-Gm-Message-State: AC+VfDyRZvuRA39FYKIwzNCvPkFgtRnyv7vPp0UMEXM4UeSdSu7WRv+0
        yGBoxltGp7RtWrRulgBvOg1FbzmHpYQ=
X-Google-Smtp-Source: ACHHUZ4F0pJoegTySViGv9wcnecWIw2UXzxKSp78y+n8Nrkn2kRFrqEbM92fZ6CwUq39cErD7cmfZw==
X-Received: by 2002:a5d:538a:0:b0:309:4e06:ff0b with SMTP id d10-20020a5d538a000000b003094e06ff0bmr1331671wrv.27.1686428495710;
        Sat, 10 Jun 2023 13:21:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18-20020adfeb92000000b003093a412310sm7854211wrn.92.2023.06.10.13.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:35 -0700 (PDT)
Message-Id: <560ad1cd0179f8615dadd8b252b5c3f8cef6822e.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:13 +0000
Subject: [PATCH 14/25] completion: complete --line-prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7246ced14ad..13d6730f33d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1757,7 +1757,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--textconv --no-textconv --break-rewrites
 			--patch --no-patch --cc --combined-all-paths
 			--anchored= --compact-summary --ignore-matching-lines=
-			--irreversible-delete
+			--irreversible-delete --line-prefix
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

