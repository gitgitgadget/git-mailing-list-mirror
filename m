Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C934C636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 15:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjBVPjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 10:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjBVPjV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 10:39:21 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F186EBC
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 07:38:48 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bo30so7619524wrb.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 07:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nj4/MiZHhVQx88G/RxsanV7c7tjx42FWqb9h6+3Tvg=;
        b=gwrGWfazz4NCz41M8vXHUs4W1HQ5Ke8Byo2FS7CHorcShFr2PTQBbsd00ARfBbMckl
         ssBj27/+2j33nIJb8m5gKu8dtJELSkqBAyZC+8f343Oho4Z48VdefwJcUvGLTQAmwI66
         IiPQHLosEDrQs/Tsdyl5/x5p/K45JISgv2rD6jEzPVot/8sVEtjPoZamyeLv+s0sF2zd
         uCmIEDSZfN72kruDluIApYG1EqgNFp3Ko7CPgEQMNvgsAR2sO9LUOrQgxh0f2p+sWa5m
         6KdlqgvxXk4ONBHzcfiIQss0OMx4TcWHppHr/uVd6gODZz76zYtemoKEQ8pgB/G/K5MQ
         UKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nj4/MiZHhVQx88G/RxsanV7c7tjx42FWqb9h6+3Tvg=;
        b=IWSQO61o6F0agRR5EdyQXpFrjuBMK3I+MttN0P5WOF1MLiGkc4U6djnFnZuZyP5rd9
         He1UuytZvHS5zKr9RGXNDl8pQ7jOGySi7lHa+Cz22zrOFdQcVKCPC9M5z5uZ3uCoiiSI
         yYnnm+3EASrLCTbfrqKmSbwr5/xP7zEWD/vOrU63tqgOYaeaRlP2RnmgQ6VhFebRXTza
         1cjfHp31aUHPEzxnJuHC5ODqjQim6zP66pVH8yxB7j2PxIdblB7Cl+QtvCq2dC8e3N+b
         HSSVMYOZ7jn2xP9fTASDX56BlT8Uh8CamSTAxAHu3ZwI8cBzR32buUaiVlYWXjv3YvAb
         sE4w==
X-Gm-Message-State: AO0yUKUmlEfssHsBnNJJpuQKUJ6Ee1KjfnQP/n5gpj6Uy9/nWYshPpe/
        8VlszGkNGJHTmzwXUzUwBzA=
X-Google-Smtp-Source: AK7set9XiLmQkzLDOAHe/HXYnpQEcD/4ka8zsvGUtj+arVqpofF+Cn88PSQHfa0U1KQNwNRn5Kl85A==
X-Received: by 2002:adf:e242:0:b0:2bf:c0e4:1bc5 with SMTP id bl2-20020adfe242000000b002bfc0e41bc5mr8207913wrb.56.1677080326069;
        Wed, 22 Feb 2023 07:38:46 -0800 (PST)
Received: from localhost.localdomain ([105.111.236.31])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d4d05000000b002c55551e6e9sm6109435wrt.108.2023.02.22.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:38:45 -0800 (PST)
From:   Idriss Fekir <mcsm224@gmail.com>
To:     gitster@pobox.com
Cc:     cheskaqiqi@gmail.com, christian.couder@gmail.com,
        git@vger.kernel.org, mcsm224@gmail.com
Subject: Re:[PATCH v3 1/1] trace.c, git.c: remove unnecessary parameter to trace_repo_setup()
Date:   Wed, 22 Feb 2023 16:38:35 +0100
Message-Id: <20230222153835.9794-1-mcsm224@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <xmqqttzeeqlk.fsf@gitster.g>
References: <xmqqttzeeqlk.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/21/23 21:00, Junio C Hamano wrote:
 > Idriss Fekir <mcsm224@gmail.com> writes:
 >
 >> From: idriss fekir <mcsm224@gmail.com>
 >>
 >> trace_repo_setup() of trace.c is called with the argument 'prefix' from
 >> only one location, run_builtin of git.c, which sets 'prefix' to the
return
 >> value of setup_git_directory() or setup_git_directory_gently() (a
wrapper
 >> of the former).
 >
 > The former is the wrapper of the latter, though ;-)
Oh sorry about that, that's what i meant but wrote it in reverse.

 >
 >> Now that "prefix" is in startup_info there is no need for the parameter
 >> of trace_repo_setup() because setup_git_directory() sets
"startup_info->prefix"
 >> to the same value it returns. It would be less confusing to use "prefix"
 >> from startup_info instead of passing it as an argument.
 >
 > ... but for commands with neither RUN_SETUP|RUN_SETUP_GENTLY bits
 > requested, the prefix is set it to NULL by run_builtin(), and
 > setup_git_directory.  What value does startup_info->prefix get in
 > that case?  If we know it will always NULL (and I suspect that is
 > the case, but I haven't followed the codepaths myself to find it out
 > lately, so you should without taking my word blindly), saying that
 > at the same place you mentioned the return value of setup_git_*()
 > functions in the first paragraph would make the reasoning perfect.
 >
 > Otherwise, very nicely done.
 >
 > Thanks.
 >
I did check if startup_info->prefix is *always* set, that doesn't seem
to be the case, but for trace_repo_setup() this doesn't matter as it will
never be called if neither RUN_SETUP nor RUN_SETUP_GENTLY are set
("if (run_setup &&..."). I also think there is a typo in the comment after
that if-statement, it should be "/* set_git_dir().." instead of
"/* get_git_dir()...". I have a question, why isn't startup_info initialized
with default values in setup.c?


Thanks a lot for your valuable feedback.

PS: I'm so sorry if this email has been sent multiple times, i thought it wasn't at first.

Kind regards.
