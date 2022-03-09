Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5D8C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbiCITWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbiCITWh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:22:37 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE15113DA3
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:21:11 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so4069389ooa.10
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 11:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uwAxMxSiHuvz6lwgamwM2tNP/RXb7mhiuW0uKm98bZU=;
        b=MV4am1FnX/IE04tf70qNtJp+ogu+a/LZXlK6BWym4uw2rxcNo9doCnYXJImpdEWj0+
         SlaL08iEBDMT8DyEHpDwtS4gVoYC2/CmbJ7eCQXJ/6rA5WJGCY0SDpPspp7vIct1Eitb
         UHEK/rQaE44ylV2uLxAmNPq7AbzN8FCVAheVog0sL65BbdOLDwpK+DnI7yge16TDn9AI
         IiT+4sc92CSaf7O4h972DkySGWAB+aNhav2sLPJzGpOOcGIOKZnieleFpROuie8LmCSv
         GD+daMy+tSmCaiaFy4YLDX/n9sPbBWIvx0LM1hP9h2Ii4qai9Gvz6llA2tBIUuL+mWsc
         emeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uwAxMxSiHuvz6lwgamwM2tNP/RXb7mhiuW0uKm98bZU=;
        b=rhXHTU+LnnuhOrOiflHmZAdZVUMeedm9Km77En/sHT36bHPZCe+adZ9us1xGg6kqzg
         lKYpz0uQj81uoZukXjsWnULM3mhu9LJHqpFnml89u3U/pST2dQUNKjn+Hk8X4xPNJBfj
         VeIN0hAbyJBxcTUqyQYtXX8QJhnpw7nsUXTzx6UBpSsQp6tRn4yTJSrWQ84adhr2B+6p
         ilIn+o0FlxFeqWKhn986Znvt36ki4bOBTVvAno7JhygQMpbDQbimJH01hHnH1XV8vlHJ
         kV25EHyyF4VgPMTHpKo9c+S6pT1uysJ/6Q6sCBspDyX36MCIEVrDRXmVBbfq2Lp5rhAa
         zQgQ==
X-Gm-Message-State: AOAM530aKGHkfYvwGN5hzkfpDnQorwXyvSGuvoTmYZPsCOkC9WSPlEk5
        XitewHOpNcY8WXm10H8skifX
X-Google-Smtp-Source: ABdhPJxLQu5SWdicq9r2UFFv/PtjR96+BlQr4k1CupGycpMw1iqnUDyeDjpnDhma6aekBa/G9WAkGg==
X-Received: by 2002:a05:6870:4182:b0:da:b3f:322c with SMTP id y2-20020a056870418200b000da0b3f322cmr632540oac.220.1646853670732;
        Wed, 09 Mar 2022 11:21:10 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y17-20020a056870459100b000d75f1d9b88sm1296082oao.53.2022.03.09.11.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 11:21:10 -0800 (PST)
Message-ID: <625c3868-60c9-009b-b01b-f186710d4d08@github.com>
Date:   Wed, 9 Mar 2022 14:21:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 20/24] revisions API: clear "boundary_commits" in
 release_revisions()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-20.24-fa53e81c7c0-20220309T123321Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-20.24-fa53e81c7c0-20220309T123321Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 8:16 AM, Ævar Arnfjörð Bjarmason wrote:
> Clear the "boundary_commits" object_array in release_revisions(). This
> makes a *lot* of tests pass under SANITIZE=leak, including most of the
> t/t[0-9]*git-svn*.sh tests.
> 
> This includes the tests we had false-positive passes on before my
> 6798b08e848 (perl Git.pm: don't ignore signalled failure in
> _cmd_close(), 2022-02-01), now they pass for real.
> 
> Since there are 66 tests matching t/t[0-9]*git-svn*.sh it's easier to
> list those that don't pass than to touch most of those 66. So let's
> introduce a "TEST_FAILS_SANITIZE_LEAK=true", which if set in the tests
> won't cause lib-git-svn.sh to set "TEST_PASSES_SANITIZE_LEAK=true.

This paragraph perhaps belongs a few patches earlier in "revisions
API: have release_revisions() release "cmdline"", or else there was
some swap of order here.

Thanks,
-Stolee
