Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CC9C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 11:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbiCRLJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 07:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbiCRLJx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 07:09:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D50B129247
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 04:08:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j13-20020a05600c1c0d00b0038c8f94aac2so294777wms.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R9fxoC/JCFMYvFQNVHwIEjk6s6Z+sZyMpT8kE7Ie4Nw=;
        b=FS/dqTaG8NGXj1QEPpmdRZHtW4sEupoHfjZ8x2ir/3K2jeRIZ9ahf8lPZExQ/bq6t4
         rjkj5nt/eAMd5ZMN0F/zYVws1VPz17tG2rXWv3VQAFoWdYdCPNc/yazj8cFFiSukvmAJ
         59Ubs8rF2Kkn6WIotvzbR8j4Tei8HBkaNm0H68FDztyL3vxWZ/Wqgbhdaubzs0/aRh0P
         OwZb6m8mPTDIvvxkjg260mlpLpWezz1t2cXJ7dx0qLnMVEqI7MgeOaQL/KQpIpr2H6kP
         aoDlymmYryTR9ix252l7swOSksDNzQHvstF9juIMr1zL9wqWEhxMMmpGwmDbO42sbqij
         7S8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R9fxoC/JCFMYvFQNVHwIEjk6s6Z+sZyMpT8kE7Ie4Nw=;
        b=y28TaCN3UVXOGER6qX3UTEjGHMVtOAlhirQIJGClLUawtIPa1qsTw9ZHqe9CNuhr7J
         GTtnMQtP3dklFgvZhwylBXutIryGxzkAiI/HysLX42dyBIr80LGx4IEI06b4XF2rCNoK
         H0S/jhgeOp8ZsSt4LM6s3JDq8ZabDXxJ/3UGt7VlHrLNBB+Hc0DeIxNdvp5CDPJmzKrD
         Fl3s5PW/YfCBZb3lti/sITev0eprfEMjNYAaFGcfgb3q4WarTXsB3+Qoee4P1R2z3AaG
         n8SP3jJMwrV/xyufu9vEP/AY1rcpCNw+hBklTC1HbR3oHkoudm1oP3Y2kSc/YIuFQEfE
         ze6g==
X-Gm-Message-State: AOAM530UMbeUsFsP8fXIqLDuhEhMF3JQoSZqzC5owvbKF7P/KtnxReuS
        A/lzt0m1qDGcRN3Ric6p5go=
X-Google-Smtp-Source: ABdhPJyon9i6V0jR9tvr/puL1C3sXRd+LZ4ZptrNWQi++jePQ+e5kghZLv6C+UM1d7XD3C4/2W8ZKg==
X-Received: by 2002:a05:600c:4fcb:b0:389:a82b:8f8a with SMTP id o11-20020a05600c4fcb00b00389a82b8f8amr7516995wmq.167.1647601713527;
        Fri, 18 Mar 2022 04:08:33 -0700 (PDT)
Received: from [192.168.1.201] (31.107.7.51.dyn.plus.net. [51.7.107.31])
        by smtp.googlemail.com with ESMTPSA id 14-20020a056000154e00b00203f8adde0csm1129435wry.32.2022.03.18.04.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 04:08:33 -0700 (PDT)
Message-ID: <80a5f411-2ddb-177f-4139-1dfff436deda@gmail.com>
Date:   Fri, 18 Mar 2022 11:08:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/5] reset: introduce --[no-]refresh option to --mixed
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>
References: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
 <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
 <101cee42dd6d5a4e5f12da647eafab9334d69a2d.1647308982.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <101cee42dd6d5a4e5f12da647eafab9334d69a2d.1647308982.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

[replying to v3 rather than v4 as gmail still hasn't delivered that version]

On 15/03/2022 01:49, Victoria Dye via GitGitGadget wrote:
> +	/*
> +	 * If refresh is completely unspecified (either by config or by command
> +	 * line option), decide based on 'quiet'.
> +	 */
> +	if (refresh < 0)
> +		refresh = !quiet;

This keeps the current behavior of not refreshing when --quiet is given. 
I wonder how disruptive it would be to take the opportunity to get rid 
of that hack and go back the the original behavior of refreshing when 
--quiet is given. There are a couple of assumptions that make me think 
it might be acceptable

1 - anyone using a sparse index wont notice as refreshing the index
     should be fast for them

2 - the large repositories that are affected exist in managed
     environments where an admin who reads the release notes could set
     reset.refresh in a central config so individual users are not
     inconvenienced.

Best Wishes

Phillip
