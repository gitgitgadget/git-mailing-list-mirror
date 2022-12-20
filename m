Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE2EC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 14:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiLTOfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 09:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbiLTOfS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 09:35:18 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355BD1C116
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 06:35:11 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id jo4so20730907ejb.7
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 06:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWytHnZnIbSJgdB+lPkmy2vA23U7UdZ6jrPYtiECPcA=;
        b=BBpTLPuxPh/UgbE+lVszFLL+OHGyRkyx/Lhzi6wL1mawHeLsL5r5kRpf6R2wZq3alD
         c/yGaLkGhioe+4Kzphd9un0SwXPeMKXDgi+HmVXTuZ4Zhy7TjTWE+NfI8C9fM1sVsbKF
         qKrVLjrtO4p77WF2G92YSGcc3Hrhc4SQ4400kBH8tLehka/hwPQVS58QSDRd+cgu1aSj
         LOc4NmGMdhdELHPPB5a4nnH9UnWumlCkkwAn0cBG3w+aUBAjT0qUv73qYeQbbTLtqBgX
         LsvS/scCrQC20XDr9/1XRCT7NORU+qA3HCQwcs7WL7WsxvDD+NUqiwtWl2HRMzwccYQe
         mvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWytHnZnIbSJgdB+lPkmy2vA23U7UdZ6jrPYtiECPcA=;
        b=8G6XNmqe+htjBcG23ZgsNIurAbf/f8rdXrLOmHNjgLtdFHH5tn0oBp51LJgVDC4qpd
         tOzcQP2tiKXsCozWmmTHI4bXzllETX0qeDMo/KAu4ciDqnOu/LF1y9Zkf1FFdQ/AV1Dv
         CoBMG4fyDq2AyRGQUMXNi+iUfvYO87wAPz9ITnYlM/QrlH0LWlJk/MlGMpZWc7HjYyJN
         P6YylQd75ujpdIsXImDlljNheCrKv0uvWCtf5j4D9aDam0NaANz8cyTvgvT8G5DLHc3e
         mWRld06GEIzV1hRUrCAJtfL08unrheMW4pm493StnsCMTjcatqG57Iv0IaB94mcx/i3d
         S/pQ==
X-Gm-Message-State: ANoB5pmFY+cH+DOX6KYAr5OuGUfsUrKGhxT1UjwXPrX6LDlTQ4vATElh
        zU2pvoqRYKSwmy+E5fnp9kBFlQHwOg7pdg==
X-Google-Smtp-Source: AA0mqf4uK+E0iawrfqGdS3vOaemETv0xluEnZ+pcCXDdUgOLWe8sL9MXvR5/L+z4R6RgrIqyD0BBYQ==
X-Received: by 2002:a17:906:2458:b0:7c0:9a2f:ac93 with SMTP id a24-20020a170906245800b007c09a2fac93mr36893790ejb.31.1671546909757;
        Tue, 20 Dec 2022 06:35:09 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kw4-20020a170907770400b007adaca75bd0sm5896605ejc.179.2022.12.20.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:35:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7di0-007Lwz-2s;
        Tue, 20 Dec 2022 15:35:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, William Sprent <williams@unity3d.com>
Subject: Re: [PATCH] dir: check for single file cone patterns
Date:   Tue, 20 Dec 2022 15:33:51 +0100
References: <pull.1446.git.1671546459151.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1446.git.1671546459151.gitgitgadget@gmail.com>
Message-ID: <221220.86sfhaw3c3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 20 2022, William Sprent via GitGitGadget wrote:

> From: William Sprent <williams@unity3d.com>
> [...]
> +	if (!(given->flags & PATTERN_FLAG_MUSTBEDIR) &&
> +	    !!strcmp(given->pattern, "/*")) {

Style: We use !! to convert 123 to 1 or whatever, but here we just care
about "not matched", so we can drop this !!strcmp() for strcmp().
