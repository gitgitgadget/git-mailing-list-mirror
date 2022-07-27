Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A005EC04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 09:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiG0JPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 05:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiG0JPB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 05:15:01 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0DC422D5
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:14:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o13so5643458edc.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=oFHcvwQ3QXYvFl4Vq/TC2BEmgQpLI3dvcjz1ZdZ+TLY=;
        b=a+FvgkrX9lq86V0B7Zc5D2gEnwjCExOzOFTI/Nd/KrJZD1jZRq2/Y7EfXpk3jM+QPt
         8AFsYvHaUxuIFn+w3fZOgtA85tEe70Yl+vxLg81alejYL9pY8gFXVMrHaeybGrWuvaES
         spp6h1hoLRn8JpAs1DQw7EfQqW/XskCDRyzOdf5/5y6+5F047tw99oT8MqkKaGDDJN3Z
         NALs6VO+0XGcMYeNXr8BPELtDZ2kvOVkPRGcCJDAWVWM9st1VRa0XVA4axQJelzR0kqf
         zuUa5dboH8OuEz4/XeP04FK3kzh0bgOgqOsGBLsN9x0L/25kg4eVTA6llFYhKXFOE74g
         gl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oFHcvwQ3QXYvFl4Vq/TC2BEmgQpLI3dvcjz1ZdZ+TLY=;
        b=FeYYScsKxfQEE3j0BYZhSUXnWHy40+h7UVL1YXspVQ/Uahx+mAsA1pCrtLg7NpjY/6
         K96gNVFnmApZG6xgJ5miRT24bmDDd8ty/uECEcw42oAB4NDfBP/Zq2HVeNBFATgOGJ1n
         K8sNPE+EYMnsYZRV9okUe7f7pbRmSs7Jgab9PDE6Trl6GsX+nPwtiNP7I5PDA+noFNrY
         dyYgZHE48N2xNuMj7/BDOVgbPqYlk4CmK4YGCArK16SpErQtTOpjy9QUI8QzClPAKvZO
         HNTDXBxApELPwA2yMoI1wW8QN+5Sg+DxinEqqV8WvIXIaA8TxhqCmAqiKxdDibgj7ErN
         vfyg==
X-Gm-Message-State: AJIora+Sw48ChJZHlrLlXv7FrL4k1f06uDVxgZu9BqGwD5QmBeq9+B9i
        B+3UwbaIhPOiVhAhQX3qAnA=
X-Google-Smtp-Source: AGRyM1vMx+fvV3hddnuK1QNRLGHCg7ntVOjY5QsSsIcEX7CPQ53fWdAq+jqsOLXslUnsDbtOeK803g==
X-Received: by 2002:a05:6402:4148:b0:43b:7f36:e25f with SMTP id x8-20020a056402414800b0043b7f36e25fmr21759505eda.407.1658913291716;
        Wed, 27 Jul 2022 02:14:51 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l10-20020a170906938a00b006f3ef214daesm7454337ejx.20.2022.07.27.02.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 02:14:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGd7y-006b5I-KK;
        Wed, 27 Jul 2022 11:14:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>
Subject: nonnull v.s. BUG() if !x (was: [PATCH v2] config.c: NULL check when
 reading protected config)
Date:   Wed, 27 Jul 2022 11:12:22 +0200
References: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
 <pull.1299.v2.git.git.1658874067077.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1299.v2.git.git.1658874067077.gitgitgadget@gmail.com>
Message-ID: <220727.86v8rilxx1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 26 2022, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>

> +	if (!filename)
> +		BUG("filename cannot be NULL");

Looks good, but as an aside I wonder if we wouldn't get better code
analysis with "nonnull" for this sort of thing, but we can leave this
for now:
https://gcc.gnu.org/onlinedocs/gcc-12.1.0/gcc/Common-Function-Attributes.html#Common-Function-Attributes
