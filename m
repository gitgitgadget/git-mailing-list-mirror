Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58007C77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 22:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbjDSW2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 18:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjDSW14 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 18:27:56 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B706C1025E
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 15:26:17 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-63b62d2f729so352372b3a.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 15:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681942771; x=1684534771;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/X/nF7Vde7FJwtwXu1KmXjMYKydCWvcUctKQ6skQOY=;
        b=Kxjk3z8pgaJ8eHxbeHL94UzAE/OA3WPezJRgpiiugLS9+uCt3izQmIvtRHB8USOdd3
         QooTUqpD0MkEp6dAc1MYt4xW9sV/neY1M5zlHRJ5rssGtaEPFW3LH+iH75GMIdtIlKuY
         8FLIKyNx5P83ncSxCF02Hp+hLlra/JRcf7FMBsS3EH0wP/+SwiQCXsf/ZXHaZXyHUPZb
         cVN3KYf/hKvbVJHkRDbPW89ukok/pErJYqYsGSDY2z2M1h/qeN9fhvh8Jpw73dApfQjB
         hdHhJpVESGHYJZEuN38Rrc9zZqs1I+sN8F0HMLTb16rEZlzgsbHiiVmC3eb5vcQDTYhg
         83zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681942771; x=1684534771;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V/X/nF7Vde7FJwtwXu1KmXjMYKydCWvcUctKQ6skQOY=;
        b=jCyaRuORiQYtEcews4GIvGgZt3C6vF/MYUJK2cRhfIaS1eYsOht5YNjvgD5dAbpERP
         2ffw/LqKeQRWOhzkSOTxgFvNF9WaCzAZaMQpdk5rrz7936r58LKWUttRjCRs6lW2fufm
         27XCEshki4+JYc/rT47jS5EfAkaT2SICn4spGxAiZfX9ZRXhbphSJH0QBOSEBOLIYrhS
         ynoNXwkygGEBGrEeoVzoanlp7Ouhjcri3YG3TCS6FoC/VQ9nf1+EBRtaX4CJJgA98IrE
         oQmZDVIhCJxhPZTXP9f5W5ivnIQTxCuDsSVzes4Ym0m31korMm2E0i/a5dCzFOX50AkO
         11Zg==
X-Gm-Message-State: AAQBX9eeu84BSHGOqX6Adrbz3y2ZgemfFj9d4lFmfuckrlo5BdtbxDcH
        i/9TfQ5memxSjA9iYcJjAyLX2OOsWIM=
X-Google-Smtp-Source: AKy350b+XNmxwp+qV9YRVcfjTO9Gdb3lcapANrShtdbaX9YnwDY5//W0gPsMIot46NXYnUGUflwpMQ==
X-Received: by 2002:a05:6a20:3c8d:b0:ee:6c12:6c95 with SMTP id b13-20020a056a203c8d00b000ee6c126c95mr109394pzj.21.1681942770832;
        Wed, 19 Apr 2023 15:19:30 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id a19-20020a634d13000000b005134fc049d7sm10915504pgb.31.2023.04.19.15.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:19:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 10/10] repository.h: drop unused `gc_cruft_packs`
References: <cover.1681764848.git.me@ttaylorr.com>
        <cover.1681850424.git.me@ttaylorr.com>
        <c67ee7c2ff9456eda1c5468cf68ddb1b83d37c85.1681850424.git.me@ttaylorr.com>
Date:   Wed, 19 Apr 2023 15:19:30 -0700
In-Reply-To: <c67ee7c2ff9456eda1c5468cf68ddb1b83d37c85.1681850424.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 18 Apr 2023 16:41:00 -0400")
Message-ID: <xmqqlein7bwt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> As of the previous commit, all callers that need to read the value of
> `gc.cruftPacks` do so outside without using the `repo_settings` struct,
> making its `gc_cruft_packs` unused. Drop it accordingly.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  repo-settings.c | 4 +---
>  repository.h    | 1 -
>  2 files changed, 1 insertion(+), 4 deletions(-)

This is in line with the current design of repo-settings, and it is
a total tangent to this topic, but in retrospect, if we structured
how "what's experimental" is determined in a more distributed way,
we didn't have to have this patch.  That is, instead of saying "ok
we are in a repository with experimental setting turned on, and the
set of features to be enabled are centrally described in this
settings structure", each opt-in features (like the code that reads
"gc.cruftPacks" by calling git_config_get_bool() to override its
default value) can select their default/fallback values by seeing if
the experimental bit is set.

In any case, this patch looks good and we have one fewer such
centrally managed bit.
