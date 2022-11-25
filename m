Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68B8C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 03:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKYDhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 22:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiKYDhG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 22:37:06 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721C42AC7D
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 19:37:05 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so5242177wmb.2
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 19:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7mTeI2kSpnBWdNgjilNkbd0hoDQrcEyVClzYqvCa9U=;
        b=k9kAQnTzITYB671WUf01Av2LJHmFjoNP4xaD5kL0nqAMzOTQtxc0EIET7Y5Aq/sbBA
         Iv3TR+IiDTUqA5JnC9jiGvPzu5Tgv4ayPDtsxVBWBNvyQ+fQnXQQW9qbFZMagpMlCFb0
         PRLD6P4aF49Hag/fiUq1wlTAXsLZa146R9WzKftMPu7dtVIMm2KVRfz/3ywUFy7K2QbW
         0cFr4kIVCx6EilFZODlD8tfGc+S1ZDMgaFbLn/GPCLXVFBiAUoK5MK6gdkkAzZ9TmvmD
         a1MvzlSfE5//RMMWJ9JkEgtPDlHqpZ/cEPqmNgO4IaP/5gOesIbAuwLw3veJ9dzena72
         Rt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7mTeI2kSpnBWdNgjilNkbd0hoDQrcEyVClzYqvCa9U=;
        b=c5tFGSwmnh4JEtoVNGmWi2rbVaFXx8W0b5cs+rfKSWXXtrQVt4rlLJqv+5HgkZ/Uxu
         lL0XcBtsrmiEw+oPPjl7ieNVFxx5SP0VZ99GVt2EgX6QOoAQNr4TEC8lX0d+rBjRiNVf
         vmBQrS4lekXfFaVG3hvpJ7NBNmq4d3CSbjHaCXmujkRGpY2Q/bcVikbC5gbHxAKwCKnz
         nOwT2mYxsmoDkSxGfnSfk7Prh3N5rf5YR0goD9ZFSk3GzytB9z2yLZeVrozDSyAIT8I4
         x/N672gezS2BYwDaOukyBz1VHAqA/mISi9lsUJ5NCJSlpIg33Q9Pm/0VBcLpbAQYvkqK
         dmSw==
X-Gm-Message-State: ANoB5pn/ODb00Y2T+QpnkDblmZCAbPWcclIOR0KDS2JbPik7fRuq+O3K
        1YK58aVMGjKRKQ1JJqVhU0vyfvDuNQo=
X-Google-Smtp-Source: AA0mqf4EhPtzv3Y/9holWxHz2d+AbdnwrjHBJqo1zKppid0pFn5Zf5noSeT5Taw+Hg/gOhv1n9742A==
X-Received: by 2002:a7b:c8c3:0:b0:3cf:b49e:1638 with SMTP id f3-20020a7bc8c3000000b003cfb49e1638mr15502073wml.50.1669347423680;
        Thu, 24 Nov 2022 19:37:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b003a2f2bb72d5sm9430914wmo.45.2022.11.24.19.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 19:37:02 -0800 (PST)
Message-Id: <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
References: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
From:   "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Nov 2022 03:36:58 +0000
Subject: [PATCH v7 0/3] git-jump: support Emacs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an optional argument 'stdout' to print the quickfix lines to standard
output. It can be used with M-x grep on Emacs.

Detect emacsclient by GIT_EDITOR and invoke the function. Tested with
EDITOR="emacsclient" and EDITOR="emacsclient -t".

Jeff King (1):
  git-jump: move valid-mode check earlier

Yoichi Nakayama (2):
  git-jump: add an optional argument '--stdout'
  git-jump: invoke emacs/emacsclient

 contrib/git-jump/README   | 10 ++++++++-
 contrib/git-jump/git-jump | 45 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 4 deletions(-)


base-commit: eea7033409a0ed713c78437fc76486983d211e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1423%2Fyoichi%2Fgit-jump-emacs-support-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1423/yoichi/git-jump-emacs-support-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1423

Range-diff vs v6:

 1:  446777d300d = 1:  446777d300d git-jump: add an optional argument '--stdout'
 2:  972d51888ba = 2:  972d51888ba git-jump: move valid-mode check earlier
 3:  446d39f62fb ! 3:  d8233f96175 git-jump: invoke emacs/emacsclient
     @@ contrib/git-jump/git-jump: EOF
      +		#
      +		# Wait for completion of the asynchronously executed process
      +		# to avoid race conditions in case of "emacsclient".
     -+		eval "$editor --eval \"(let ((buf (compilation-start \\\"cat $@\\\" 'grep-mode))) (pop-to-buffer buf) (select-frame-set-input-focus (selected-frame)) (while (get-buffer-process buf) (sleep-for 0.1)))\""
     ++		eval "$editor --eval \"(let ((buf (compilation-start \\\"cat \$1\\\" 'grep-mode))) (pop-to-buffer buf) (select-frame-set-input-focus (selected-frame)) (while (get-buffer-process buf) (sleep-for 0.1)))\""
      +		;;
      +	*)
      +		# assume anything else is vi-compatible

-- 
gitgitgadget
