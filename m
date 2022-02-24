Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F207AC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 23:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiBXXF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 18:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiBXXF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 18:05:57 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B1270241
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 15:05:27 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id m15-20020a63580f000000b00370dc6cafe9so1725879pgb.5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 15:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=EcJL7/c5/f6W8fFGh52ofMk25CZJ6vVUMFyKoDDERGE=;
        b=TmPdS6yaCQkVwYDIjBaZ1I2LGktcmmdyOXYQqBGOHs795i/DAG0/TZ9dUUlctDet4E
         ozJvga3mSvtejOWqoNSqRwOdm9ySy+Endw7j9HYID168/E1bfHjUBUkm5AjhmfhIyLaw
         K/Asicctz4I2VVY1VhtXyu6BS8MCjiJDY/06oNc0igSln+Dm7BsNz/yYRhKDKahVbWdp
         IOwKlJd6+JSVopMBIumORS1jvgIwcJqocPFyLEL5zqhGKnir1XeyWU71q6GIp/yBRJt8
         t35dHAvG3O9e9UEjwstM3919z2EC6v5SMK1qyq2qlAxC8qBgWpkqfzVPbli128b3PV4e
         m6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=EcJL7/c5/f6W8fFGh52ofMk25CZJ6vVUMFyKoDDERGE=;
        b=yAWOyi5bF8c6AiPoRR952j/cPuUohy+W+ZkgKFycYmYZap+YOyxkGwHRL3qrgHIsp/
         njpX+Jg5/VKrdaohYYltND9W7LiLTW6bXVNnwTxDZEf13RBsuaPnSte5NxzPVmgd5QBJ
         17aZcmAP+hj4nRSvjsonYRIaT8eQqUkPLQgYFDEDjjOnZUPaw6Gf/kIM2A8cn8zw6yhr
         8CUNtX2scwB03WL03tDTodXQM5zS1YbPnIzPkFD4HSU5slLPwwzj6TudrOiN7voEnzvG
         gDA5z7o0Txqv0HfRBWpKg+NuBUee3UddbsjxZpieqmKIjyf+K9n24KUoqqYlFxmoi+nu
         EfDQ==
X-Gm-Message-State: AOAM532OxJaIRE7599tNY4J0NVdGU5FmGPHDaa00E77H+5Uunq39LbrD
        S2LtNwh2KsiS7r2QXYrDYVlb5dJxDNPcAoX6MShr
X-Google-Smtp-Source: ABdhPJzhuKMt+ZiEABX0jGPCdBgNyZJG/VRB8m7MTIuiIBHpjar8FpLlXXfDFsRHkpc3zmtptlUlwy/Mxw/f1AMtMCvI
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1c8d:b0:4f1:2ab2:b524 with
 SMTP id y13-20020a056a001c8d00b004f12ab2b524mr4701460pfw.41.1645743926591;
 Thu, 24 Feb 2022 15:05:26 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:05:23 -0800
In-Reply-To: <20220224100842.95827-3-chooglen@google.com>
Message-Id: <20220224230523.2877129-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: Re: [PATCH v3 02/10] t5526: stop asserting on stderr literally
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 0e93df1665..a3890e2f6c 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -13,6 +13,32 @@ export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
>  
>  pwd=$(pwd)
>  
> +check_sub() {
> +	NEW_HEAD=$1 &&
> +	cat <<-EOF >$pwd/expect.err.sub
> +	Fetching submodule submodule
> +	From $pwd/submodule
> +	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
> +	EOF
> +}
> +
> +check_deep() {
> +	NEW_HEAD=$1 &&
> +	cat <<-EOF >$pwd/expect.err.deep
> +	Fetching submodule submodule/subdir/deepsubmodule
> +	From $pwd/deepsubmodule
> +	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
> +	EOF
> +}
> +
> +check_super() {
> +	NEW_HEAD=$1 &&
> +	cat <<-EOF >$pwd/expect.err.super
> +	From $pwd/.
> +	   OLD_HEAD..$NEW_HEAD  super      -> origin/super
> +	EOF
> +}

These don't do any checking, but just write what's expected to a file.
Could these be called something like write_sub_expected etc.?

Other than that, the patches up to this look fine (besides the comments
left by others).
