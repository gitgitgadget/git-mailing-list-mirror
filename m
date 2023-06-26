Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F79EB64DA
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjFZQ0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjFZQZL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE54519A5
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa99f6a4a1so10063025e9.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796707; x=1690388707;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ylvcv9ph5muheYB0XJs4nEYBaWd2d9YNUw9G4BLICwQ=;
        b=oavB+6HrwGFQb8zqzsqttT8cNjs4QNDB4AjC2wWJ+SckBsQJtKHIoivg9nO1Uc2ILh
         v4A5oBaMrbSZUFSSdqoDpinwpdvV8DXn/2ylfYlXEv5c2X3pc1df7kHRCMlUaVkYfcHV
         Yau3QA1cqgrYxEi3r8ak+CPBDkdAfdyZcwdBOWSxGN/VZaFFNcjb5gGsTDDhTrxPW3NT
         B+QPq/BxZiIaKAuKM+oW16YyYpWrQEYoDlOPbp+awXj9GE1gxt/Frbe+X4F/UWd7SPdP
         g1xD7YH3/Jz1PCyA+26rAX+FkchHxKhaKpfum2oL/V9v+izzv9SC66J8VifWXHOnAnrd
         AiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796707; x=1690388707;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ylvcv9ph5muheYB0XJs4nEYBaWd2d9YNUw9G4BLICwQ=;
        b=Yjo+MGCAhXWnhYmcGMHUz9GPETE9QTfesJh7AX91/vtKfpSzNqHP3Jh4aebKNobmUh
         VCQhY/yHq2IfgUTmQ4f9j/UMShdCMyAVfC320naObWG9Sy+eftw90x5uFM1v6o95+/p1
         VTduqoEK5w4zH33Lq7K1D3c7A3Ma6HN9BAbc51WjItkzxbQtR90nKYRaz7yeUWgNQbxO
         4sMkg9T7kdWIJ8S5O5+aRTyXtTepbUIHTh0blv6kqSA+P6RXtNjr7yCOwIOe7YDCr0TE
         RuWRKWHanrNeEv8JO+iXx0mAcmDrmagXEcZ3BsMHlFzNFnTJwPllBkNfRFUATJFbFQWx
         SCbg==
X-Gm-Message-State: AC+VfDyqI43NZCkZnT12iegWfF7pHjhUZ360yMsv94QN2pxPeB7i/MhZ
        CXdSOgESsOCwxTIawN/N83qXe+MyKgU=
X-Google-Smtp-Source: ACHHUZ5BVu/s7u0YNIS8ZzMZfpO1nWjz2dfD3IcSQX0kv1i6K1uoI93775rPSN+MOpIDgET0fjju8Q==
X-Received: by 2002:a7b:c3d0:0:b0:3fb:1b78:38d2 with SMTP id t16-20020a7bc3d0000000b003fb1b7838d2mr1403572wmj.4.1687796706921;
        Mon, 26 Jun 2023 09:25:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4106000000b0030c2e3c7fb3sm7825083wrp.101.2023.06.26.09.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:06 -0700 (PDT)
Message-Id: <eda4d407ded2f2189d9a7ea26fd49775afff5df0.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:45 +0000
Subject: [PATCH v3 21/24] completion: move --pickaxe-{all,regex} to
 __git_diff_common_options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The options --pickaxe-all and --pickaxe-regex are listed in
__git_diff_difftool_options and repeated in _git_log. Move them to
__git_diff_common_options instead, which makes them available
automatically in the completion of other commands referencing this
variable.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9de33ed05da..5b8e7b810c8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1763,10 +1763,12 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--irreversible-delete --line-prefix --no-stat
 			--output= --output-indicator-context=
 			--output-indicator-new= --output-indicator-old=
+			--ws-error-highlight=
+			--pickaxe-all --pickaxe-regex
 "
 
 # Options for diff/difftool
-__git_diff_difftool_options="--cached --staged --pickaxe-all --pickaxe-regex
+__git_diff_difftool_options="--cached --staged
 			--base --ours --theirs --no-index --merge-base
 			--ita-invisible-in-index --ita-visible-in-index
 			$__git_diff_common_options"
@@ -2115,7 +2117,6 @@ _git_log ()
 			--expand-tabs --expand-tabs= --no-expand-tabs
 			$merge
 			$__git_diff_common_options
-			--pickaxe-all --pickaxe-regex
 			"
 		return
 		;;
-- 
gitgitgadget

