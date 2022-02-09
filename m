Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71119C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 22:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiBIWoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:44:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiBIWoL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 17:44:11 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B4EC0219EC
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 14:44:13 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id jf17-20020a17090b175100b001b90cf26a4eso2750743pjb.3
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 14:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=y8P9vUx23XG7NU9NcFPzfk3uZWgYBGlzWe1gZaK5V0M=;
        b=XpwIbbZ3p1g0gSGD+vvJzU8UGdQh36vLU3ohYinr2CS3jYZn7Iv/X/9D4if/hxcMLK
         FGVFhWaHeP1wrfG4N6cv0oDw4gFBCE1gciGRMjmw/1Zh4P0ToGBboSs4Ed0/h4TS7gmt
         NsKoMnfe0/QJtKcnERnV92sl3Gzsl+E5Joj19aBpk4ErunWSXYHnUjE/wvLL/kCKlk/k
         Rf6Wf1YINMtdqGh0xDCQRMJxy1lYzmL0c1igm7LRuB+IJri/IT8pLXiDQCXmjbGilejc
         wLfMQjnFHLXIUwpID6qM5kRhQAwn0ApXTFPRzLbMZqyV6w857eBSbb5Mbo623GYfSDYt
         6rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=y8P9vUx23XG7NU9NcFPzfk3uZWgYBGlzWe1gZaK5V0M=;
        b=ZZdB2sfMzZq06l+B/pefSUlotvsuoefOstn1HlEXUX5G2og+B7owZQG+3FA5fNuN+A
         nbRpzP1JetmKPsodI969XmcRMkNTnLPZz3rOobR56rY8OKdHOU6/9ywOb0a6V7Agt9oK
         mSgB4X6ml/3uPgdWC+nQp2eAFzR4RoVQ5jUEdyOjC806f9jfTOKwzZZ3Ou4FEr9QpguD
         Pm2AhTlALKLntR/J0ZM4KkZr9t96ISmKVAJulqTwb4bA0GebGigaGTfEiXUI8wT5M6Km
         zsmsOLh2CfqNnqBnjwWDX0sG4v9ZPFkAuv0ZINaEpJgZU9okMDEjSo9CcRhEtSYGHnnV
         SDzw==
X-Gm-Message-State: AOAM532nkQFlW1XMHyU0eeBtoLOMZ+SHw8UU5CCJftKEG/4aI3n4xZdK
        rwTwwbxVcAQUap/YujfnmkJn/AeHz42OlOljEMLl
X-Google-Smtp-Source: ABdhPJy2y004xBa6gTkkhuy7pMAw6C5K2tVEYUHnSdeQPZ04XXWpVjq/EdKB46czkKs/5yu3v2Q56Q5hOIIkjbg4See8
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:e40f:: with SMTP id
 hv15mr67689pjb.1.1644446652851; Wed, 09 Feb 2022 14:44:12 -0800 (PST)
Date:   Wed,  9 Feb 2022 14:44:06 -0800
In-Reply-To: <690d2316ad518ea4551821b2b3aa652996858475.1644034886.git.steadmon@google.com>
Message-Id: <20220209224406.495563-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: Re: [PATCH v3] clone, submodule: pass partial clone filters to submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:
>  Documentation/config/clone.txt     |  5 ++++
>  Documentation/git-clone.txt        |  7 ++++-
>  Documentation/git-submodule.txt    |  6 ++++-
>  builtin/clone.c                    | 36 ++++++++++++++++++++++++--
>  builtin/submodule--helper.c        | 30 +++++++++++++++++++---
>  git-submodule.sh                   | 17 ++++++++++++-
>  t/t5617-clone-submodules-remote.sh | 41 ++++++++++++++++++++++++++++++
>  t/t7814-grep-recurse-submodules.sh | 41 ++++++++++++++++++++++++++++++
>  8 files changed, 175 insertions(+), 8 deletions(-)

Thanks for this patch. "clone" currently calls "submodule update" in
order to perform the clone in the submodule, and "submodule update" then
calls "submodule--helper", so I would expect changes in all 3 files.
Looking at the summary above, that indeed is the case.

> @@ -544,4 +544,45 @@ test_expect_failure 'grep saves textconv cache in the appropriate repository' '
>  	test_path_is_file "$sub_textconv_cache"
>  '
>  
> +test_expect_success 'grep partially-cloned submodule' '

[snip]

> +		# Verify that we actually fetched data from the promisor remote:
> +		grep \"category\":\"promisor\",\"key\":\"fetch_count\",\"value\":\"1\" trace2.log >/dev/null

No need to redirect to /dev/null, but probably not worth a reroll on its
own.

This patch looks good to me.
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
