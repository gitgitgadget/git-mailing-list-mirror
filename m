Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0B9C32789
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 18:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345543AbiHRSpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 14:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345077AbiHRSo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 14:44:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2050ABCC18
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 11:44:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x21so2994863edd.3
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=/lc+EHTP9hwfZ0FryosE3e23YhxjMHNP/xTOLqADTbU=;
        b=YDUVKGORfNiXDHlyij/XTxE5m62iCyhryA6xTgqeVq/OZ7j56rW6Y1i+sMM3OPyk0/
         tqB3yhsI7MF1Wx/n2XsRbf3Kgyf9U4r/cXXuoRjFR8FuCqrjzaUHsM5LWYESIK1HY51e
         +v7pyEYaIcRd0jyEt2RqJGoYry1Z7AOXu8rTse4nck0aNwIh6YhiRQ1e9gsUfu3c3J/m
         wARBbc1RsdYbcpOiC6ddxv6t0ApRAXEJvmpEhUccvgHtXDJT6FICwCtDI0Z2ABQ8l7fG
         V3bHOkun4Gs+nxlPRWzBj3Lfyxx2dZnr2nrQ/lRFKLH+ArrOrJcIwDUngsitUQuS7eFY
         e94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/lc+EHTP9hwfZ0FryosE3e23YhxjMHNP/xTOLqADTbU=;
        b=q6Gyo9NPM6enyZySyuB5260g+WkmNO6BrnP9II4a5toDcDtN/pyuDpIO/NUJeC7Cuq
         08aM0GMb9Y3uByLxrwZ3PA5H6+1gTjy3CfgE+Z6+atlgED/10upaeeHjJ7GaW1mu7qgS
         6LnnW3WXw1QX6WyrjKKwLrh5JEVI/L1TkJYbfm+JN2WZAsE4NOjfWS0llH03/fRVgpGf
         Wb48rGUv5qbdMyIp91mBFXH1mgCicUK2YlB4PDrjDPpqMIm7PjKaQ9c7K6s2rJuMo2wu
         QoxoOSUkwajrcscZAcS/1yfh+bF+uttX5F0/i7BxSmbUZDqrNa5Gfd5iThJ7RrCelK6t
         E3DQ==
X-Gm-Message-State: ACgBeo0MQqr0V0NK53b6rpPE7HwfX3hO8kHbA0PZD6TLTXqRUUO5kn2Y
        55iy0UJzqxQYqytHbZMgiQk=
X-Google-Smtp-Source: AA6agR5V7GnWvc9gaH00BaDDccF8KdLMCNeS1QcyiijN9jycjWX9gp8WJYqmXVBSnCiL2zD8KPf+XA==
X-Received: by 2002:a05:6402:254a:b0:43d:a634:a0ab with SMTP id l10-20020a056402254a00b0043da634a0abmr3221315edb.298.1660848264589;
        Thu, 18 Aug 2022 11:44:24 -0700 (PDT)
Received: from gmgdl ([109.37.153.249])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709061db100b0073065767404sm1191409ejh.34.2022.08.18.11.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 11:44:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oOkVB-000Nbu-0b;
        Thu, 18 Aug 2022 20:44:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v4 07/11] builtin/diagnose.c: create 'git diagnose' builtin
Date:   Thu, 18 Aug 2022 20:43:22 +0200
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
 <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
 <b58d13325b2eaef32fac89fb2be8e29004560c45.1660335019.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <b58d13325b2eaef32fac89fb2be8e29004560c45.1660335019.git.gitgitgadget@gmail.com>
Message-ID: <220818.86edxd8k8q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 12 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
> [...]

This is correct:

> +'git diagnose' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]

...

> +	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>]"),

But this is not, it's missing () around the short v.s. long option, and
we should have a space surrounding the "|" as well.
