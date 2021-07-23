Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E42C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 15:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC85C60EB5
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 15:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbhGWPQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbhGWPQa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 11:16:30 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6500DC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 08:57:03 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id o20so2243462oiw.12
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NaRdqY2MUL80CuFgYMRU3i+gqstPPA7Sl16MyTtVjSw=;
        b=sCD73iWrvoRwCP3OejZ+jiywC3ovIMcHztGOfDraeuD4XekW9L0PE0wM0zcX0TPzyE
         lB5EFPQ7WaGMrVoeTVNqRvrR3hNBrl5ewcDvJ6luXXjpugvYOprIBFF2Wk/d3Zp+QXLy
         VhCseWZOVc9B43WrvYm2qJEFmCG9RpYR/bXAuuaVkb0O/41pwNrxBngwUwQ/YHsjp0yT
         uEMYVj50XdYIaXzbjDCjVJyweKZEuL0hj0e64SUsVDB8zdv7iKMnMat63jUjETSGpumW
         cLjv9o+5yIf8GeWo4IA6FKI3qdcHbmYwxvHXUy4qZD+/gZcytNMbgbD1FP7MhNYUflBK
         wtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NaRdqY2MUL80CuFgYMRU3i+gqstPPA7Sl16MyTtVjSw=;
        b=X/Q+9I1KSP0tjikDbgbIEmA2aO+wqkNemdt0WNxAaxvo8Sfd48BKMcYDteQnaEQR7q
         a1NjlYfvT01/IRRSUpT8lID78E0bDPWmug+Q+Hu3kE2cx5JCmDRT2WGG5YJhP4Xft8BQ
         47IE/k26lTORdjHwBPSQUnbjoFQwqYbTDB3EBlt/ZPC0AZ8FqObS1x0S28bXOvqu75VF
         GGAaNsK22S1aLqHA0vquIp6qczgJs6pxVtEjCSRf3pKYgqnLomxNvef3sghzxIptAVMY
         pACgZCEafQExIayvXQf4iWrR8Cus/jIR7VcT0cm2KH6MFyjNoe0zxO4HbNns+J5vrr/j
         21EA==
X-Gm-Message-State: AOAM532m2TifDl39bG92Y7HOAS39qQjk8dHgKiz9cBfx94cBamCDcs9g
        rRhd3V3ECkmn0MtyfJbNnHo=
X-Google-Smtp-Source: ABdhPJxuxvcxRc2FhqgeoADD0V72tz44oCTrEDkcUk8Mlf75xehAoyoIuhg9y+2tRKmfOfQvSVod+Q==
X-Received: by 2002:a05:6808:c7:: with SMTP id t7mr8895189oic.151.1627055822763;
        Fri, 23 Jul 2021 08:57:02 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id w16sm304626oiv.15.2021.07.23.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 08:57:02 -0700 (PDT)
Date:   Fri, 23 Jul 2021 10:57:01 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <60fae6cdadd2_defb20872@natae.notmuch>
In-Reply-To: <85016e679eb77cbb17edc9b6849251893a5e9ec2.1627042470.git.gitgitgadget@gmail.com>
References: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
 <85016e679eb77cbb17edc9b6849251893a5e9ec2.1627042470.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 1/4] merge: add missing word "strategy" to a message
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1715,7 +1715,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	else {
>  		printf(_("Rewinding the tree to pristine...\n"));
>  		restore_state(&head_commit->object.oid, &stash);
> -		printf(_("Using the %s to prepare resolving by hand.\n"),
> +		printf(_("Using the %s strategy to prepare resolving by hand.\n"),

Obviously correct.

-- 
Felipe Contreras
