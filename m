Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C21AC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 22:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhLIWUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbhLIWT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:19:59 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F51C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 14:16:24 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id s16-20020a170902ea1000b00142728c2ccaso3041083plg.23
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 14:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KoD4wcn2byoVhmtRPYLVHlBbejJtNZSCLd+YHph76a8=;
        b=IHUnfGTN/YCxdPDrxB7E+IOLTn07ImolzMB5xvHyQGkK+zz+NEaE6vVRNcX+0nF+FT
         7prILxGsfo2wB7fTf/CTsfTtEST8xvLb5Eos4TsoFI1NmBIpyBwi7eHHG37NxLPCFqwi
         9SoeGmT1+8csjC9ej7F57HsRJ84ORxQnwQ1VxSmUWjpYxaGibbfbaJqWf/Xv0K2mLAMs
         +u/XkLzyJZmxY3h9COPKxa+0GrEotZ4pvHP9MrLYJpthBhKxUf388ncu9BLAqkerHlew
         BbCBGvzw4D6ChsDZl1yQB4IDc4rYVn7JyBe34k46Nle70dR2MxnSbChbtT5NpkvPscBt
         BE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KoD4wcn2byoVhmtRPYLVHlBbejJtNZSCLd+YHph76a8=;
        b=DRdyZ2ziqBGM5dL6MYiRk3MIoHVLu1UX9zwgZnrRK+Tq7gVVVOTLVr/u/dUvpAypIs
         hwUubBc3ebtEyJr2+V1NntoyLOezYM+rJdO3NZEC1oUu/hbaW1JIGkMhZxYauTW89Niz
         ZssAttS7dS4HWNrYyRXQ/VPN1a+Q8ChkJmEWd0lGjecsxScacJFLWgZkUnuHvTx3yzw8
         qmsW7ElbV+VCZPU5eSzGOqZstP+r05WJ1yNXTNBq9GS03Fc2a4ScQ/QvtByifQDsiWMW
         TWGzY+KlTp8lFs7FmxwbSKBb2xQ2flbEk/PMHRICnXzXvMTcuBvPBJtzvKVQCj7U2+zN
         14hw==
X-Gm-Message-State: AOAM530jEYoMnMP0hkcwzQVNb6ZYOlNdekN0zhr38kz5sSrmquttIXAA
        kFlHjBr6graYZzr0RuFwlmsaa/NM+8wqW1aN5lSp
X-Google-Smtp-Source: ABdhPJw8O8UVqn/rqKAdyZMaJy1nqA2K3N6PoZhOQ+y4WNmLAp673HXRHWwVjvMFZWAg8fmVhhFNPKnlHMPnBDpEC+N6
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:bf4b:b0:143:aa96:f608 with
 SMTP id u11-20020a170902bf4b00b00143aa96f608mr70114119pls.23.1639088184239;
 Thu, 09 Dec 2021 14:16:24 -0800 (PST)
Date:   Thu,  9 Dec 2021 14:16:22 -0800
In-Reply-To: <kl6l35n2c3ay.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20211209221622.510369-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <kl6l35n2c3ay.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: Re: [PATCH v6 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> Minor nit: it looks like we don't need to restore inc->fn conditionally,
> so instead of:
> 
> 	if (inc->opts->unconditional_remote_url)
> 			inc->fn = old_fn;
> 
> we could just have:
> 
>   inc->fn = old_fn;
> 
> which (purely as a matter of personal taste) looks a bit more consistent
> with the unconditional assignment of:
> 
>   config_fn_t old_fn = inc->fn;
> 
> 
> 
> No comments on the rest of the patch; it looks clean and
> easy-to-understand :)

Thanks for taking a look. This is a good suggestion - I'll use it.
