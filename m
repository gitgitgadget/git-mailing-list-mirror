Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9064DC433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676192070B
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 13:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWiOFLI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgG2NpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2NpY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 09:45:24 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AF9C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 06:45:23 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b14so20480127qkn.4
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ehpn7zot4/yd1CosMlMVDPuSME5x3LH42dBIyHCozNc=;
        b=XWiOFLI4i7A51emmMtvzEGiKC/hNYpIVCZPrNusLCOU+OKbYlFgAGMf4OIox2wm0lU
         rzbMAhoTL6sLVRu8KUfHvFd/MexByOCUtM/HAHAMPOBzlKqwd7WoE+hSHmiLGTIwfpBE
         JFY1Jzm44LJLhWRby80p6YUn+Lw9Yl4m6CcCsLAvvjppXLOORONJXlHyeXOWjj3qeLRE
         prtIOG+1qx0yg+b0xZCQXRilu0EmSwlscW5CI1C5azlxu02/skCgfFAbwwVKJVm5HodF
         6RcPPhPzy6SdmoK48Zy+aRWWfGEfMKGTYKgp0HGrRbZ66c/xlLK/7ofM3rq6VC4cv5/T
         mmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ehpn7zot4/yd1CosMlMVDPuSME5x3LH42dBIyHCozNc=;
        b=dMBcobMYST0SnyK92yo5NpzUfLUuKSi4Rd2RmXgntXoFUyT0MNy5GpRLpU3N3cIycO
         swwKuBpwFGLm6DduY9wvzfDi1vsoRSJk4Tnn/HVcEcdfZlDFPG1gpZWN6Ge5QY+g9MMW
         /rfEfrZ3Z5hAjsvaZv2Iy02dbw3+7yQwMhYBgcNkgpyZahrk4RYVH6gSqNGqy6qpJ/iy
         9zJJCA3dLhwINp/4/lvWZw+QUrq3JlJxcapeP55fZ9kTRL+0LdQJS5vcU/qNI3IU0/dQ
         C3lZsq+JXRS7kCDHlflNX4igs0xRFevzR6uMfKkr9OgYaZAI7iZ9D0rNwbDtU8MvH1be
         2zbg==
X-Gm-Message-State: AOAM532SKI28kyQNZasdL3+S38fOA2wQ6raS3rN4UHqy5JOy+JI6IP8R
        4VnBYQSzRKL4QnjP9UE0Z9jDfD6mRps=
X-Google-Smtp-Source: ABdhPJx+c++dsKwRWXRg5oY2C9y/c+BwXbgBKMwdagdoAyFBh2/FuFWG0Ak4IMptMv78rDXEhFgM/w==
X-Received: by 2002:a05:620a:2ee:: with SMTP id a14mr205264qko.42.1596030322873;
        Wed, 29 Jul 2020 06:45:22 -0700 (PDT)
Received: from Derricks-MacBook-Pro.local ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q198sm1663465qka.51.2020.07.29.06.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 06:45:22 -0700 (PDT)
Subject: Re: [PATCH] comment: fix spelling mistakes inside comments
To:     Steve Kemp via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Steve Kemp <steve@steve.org.uk>
References: <pull.685.git.1595993608886.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <571792b3-e65b-e6e8-34b9-56a87a47de8d@gmail.com>
Date:   Wed, 29 Jul 2020 09:45:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <pull.685.git.1595993608886.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/28/20 11:33 PM, Steve Kemp via GitGitGadget wrote:
> From: Steve Kemp <steve@steve.org.uk>
> 
> This commit fixes a couple of minor spelling mistakes inside
> comments.
> 
> Signed-off-by: Steve Kemp <steve@steve.fi>
> Signed-off-by: Steve Kemp <steve@steve.org.uk>

Double sign-off? Perhaps keep the org.uk version, since that
is the email you use for authorship.

> -			/* abandonded */
> +			/* abandoned */

> -/* Print a cell to stdout with all necessary leading/traling space */
> +/* Print a cell to stdout with all necessary leading/trailing space */

> -		 * currenty thread-safe and might be racy with object reading,
> +		 * currently thread-safe and might be racy with object reading,

> - * 1. Only a single level of inderection is obtained, we might want to
> + * 1. Only a single level of indirection is obtained, we might want to

These edits are all positive ones.

I'll leave it to more experienced contributors to comment on how a
comment-only patch fits with this section Documentation/CodingGuidelines:

 - Fixing style violations while working on a real change as a
   preparatory clean-up step is good, but otherwise avoid useless code
   churn for the sake of conforming to the style.

In my opinion, this change is not harmful, but also isn't super
necessary. I could go either way.

Thanks,
-Stolee
