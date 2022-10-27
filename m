Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7066FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 18:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbiJ0S3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 14:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236584AbiJ0S3B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 14:29:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CBA7CB69
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:29:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3691846091fso20785437b3.9
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m6T7iUMYs0d1ijC9hzCHx41UFxX/xNH8XK8V7Sg+nh0=;
        b=sRBVo9gBUFSsAu6HGF8SQEITPWUYXpLO28kg7zvXJPJYC+yEwNt84F+jP6ZXLT6gpR
         locMlnygxNZ7WPqtTPosSCro+hTU1cTYvVJEj743Aes54+3PNH6BcfWVQ8p1lGr0Gjki
         GhvaDYMYUeY0CyaCSHPQxQS7euoG4Hy7zpWjoLzAjwy37zjUFhTZvpunKrMwZv+7OJm5
         BJ6pTIDbb/SJKj1iKdcVEVjKwhN/taWbti1m+hvDKLJfLR1VlCP0/jkX56UPc37viruN
         6zain5Xy0Hwwj2lMJ6Kp5oVFD4yy2hHY3iksY0BQc4VMXv5KFDYuzHPBWWBC8eqRONQQ
         wC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6T7iUMYs0d1ijC9hzCHx41UFxX/xNH8XK8V7Sg+nh0=;
        b=h5cBRNIBusSogSsLEtFtxwmYf9RQehSv4y5ewufGFyny+z0AL7tVpx7WrdG0kfPlns
         IPpRV1hyZTSLfwfIZwI1ew+bAxKwCsLi519LuPhDvGjcnH0YqyHLjupx71eH1jh3viQY
         tYIvb0PW/wxsGlAQ6SqwNf+SAmmG2/aW6LL4BhkNGREqYZALvr04RClJAKTYmI18+9F2
         Mbu7/4VnMOJiZagGkuWoNaL7tV2Rm8WOLJeT+cL1HEGtlcP3USUBni8PSln9FcnRJ/c2
         ohFsTW3TM9gbysMyetbdTpmj9rEuDOz2kFHyPKGgaRfe3hQ3sDo2oKixOCj9rJ9kVFTX
         Se3w==
X-Gm-Message-State: ACrzQf3mIJPIOE/ZfVbilC6cPJiOdmpq/3TSJpQGo/MN1LB1LZPnI1PN
        wAjwjERdnzy60Ybk/79u991pfGPdT08phGv8eid2
X-Google-Smtp-Source: AMsMyM5S7qa/3z/6+i6FgwHmo5BKN7sD68e5Q0favfRGzmJxbdWKOfPJmQaowwudJ/keIAtiY2DRq0bqwFjbplDlbojD
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:7cc7:0:b0:6b0:156f:cbaf with
 SMTP id x190-20020a257cc7000000b006b0156fcbafmr4ybc.192.1666895340103; Thu,
 27 Oct 2022 11:29:00 -0700 (PDT)
Date:   Thu, 27 Oct 2022 11:28:57 -0700
In-Reply-To: <9a07c6932f4c7ef844df1fc4f5b6b9feb1810135.1665973401.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221027182857.1839448-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/9] tree: increase test coverage for tree.c
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com> writes:
> +	setup_git_directory();
> +	repo = the_repository;
> +	assert(repo);
> +
> +	parse_pathspec(&pathspec, 0,
> +		       PATHSPEC_PREFER_FULL,
> +		       "", argv);

Here, the repository is hardcoded to be "the_repository", and the C 
code allows the pathspec to be varied but the shell test code always 
specifies "." as the pathspec. Given that one of the main points of 
this series is the repo varying, could the repo be taken in as a CLI 
argument? The pathspec can be left variable, but if it's not going to 
change, you might as well hardcode it in the C code. 

The existing test cases of a basic one and a recursing one is good, but 
it would be good also to have one where the repo being passed into the 
function is not the repo whose directory we're currently executing in 
(that is, different to the_repository). That way we can test that the 
function works for arbitrary repositories.

 
