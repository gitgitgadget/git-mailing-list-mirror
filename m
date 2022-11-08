Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ADCC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 00:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiKHA5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 19:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbiKHA5d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 19:57:33 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8E11DC
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 16:57:31 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id p184so10332291iof.11
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 16:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1MrTBMDmAND8zKaksciVR1/4IAZLnksS26/VQePDBI=;
        b=nXbHGIlkBPW3ngq3M8gUEC/HcD9PTet8K1cr1AIZXS3WqV/q7fa+ibWUImPQlAniOe
         uublLN2dRiZUEaxoKFF0FRgmhDvs3JeqMP8/6y2Yyb3/b5bPn1jFGgv154zaEHYqf6Te
         Ohh/mHt4u5JB9vpITG1vv4zRfbhiNWRya6SjMPN5h3fXfgpY0d5Oj+8xl1rxtYJRU5ht
         tTlMvXismbUVNVlJ1cj5ojEWCSW0MluD/u0UOX7VieXBjzI2hXihPSaLS5/IqjgWVgxa
         r5QJL6hTj0G/HZO00IHPycjVJ2AIhpm/lX5WJgKmwfXx2pdbZuOzio/2euppkDg8OQQj
         vXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1MrTBMDmAND8zKaksciVR1/4IAZLnksS26/VQePDBI=;
        b=EHuX2RZENXLPbzbWN5yzihvd3fh9gByzo8fbRWyskyzddYkfA/v12SL5EMmOkyP2pC
         v9pem50PF1fm8S+7HZSd0ZqvhxV+tMSsj4/K4wRr6cy+IUy14xNsodk+kIY5r0yaabNG
         r79SkBJKg3CDWCcmklAZ0axwq6F74mqi/+FaC/h0mq+00wgoyw+qt8mfPX0NfqfjA32C
         2bUneiePa48yORawo8Bp8TROov92IB6ndIXWQpGJR7elTQ4VmsYL5WZcW14thrpYHi9o
         XOeNZEkI5CvrYnFRIyQbLS5310wxZNVuVDQbpAIoiD3qMvRPXjRVYaZS0c53YfXmDMmf
         Ua8g==
X-Gm-Message-State: ACrzQf0n+zpmdmFK8S9UGd+blUsm505HtFmuyuCHNyxBbjHCQN4U+cDF
        ZDnU2bCl4y7WGus55q+PeyZWLg==
X-Google-Smtp-Source: AMsMyM4Tc/hwMCSSC4BoAc/kgsfDLoqiKDr/m55jpOF8Ju5qsvJkSQy1irKHfACyX6Cfv46Lo9Hq7Q==
X-Received: by 2002:a02:c767:0:b0:375:6143:bcca with SMTP id k7-20020a02c767000000b003756143bccamr25945999jao.35.1667869051249;
        Mon, 07 Nov 2022 16:57:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k8-20020a056e02134800b00300c5a4f014sm3337979ilr.39.2022.11.07.16.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 16:57:30 -0800 (PST)
Date:   Mon, 7 Nov 2022 19:57:29 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/6] revision: add new parameter to exclude hidden refs
Message-ID: <Y2mpefFJspp4QnAz@nand.local>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
 <de7c1aa210c2df9bdbbb6c19f44f72c37f56c5da.1667823042.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de7c1aa210c2df9bdbbb6c19f44f72c37f56c5da.1667823042.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 01:16:35PM +0100, Patrick Steinhardt wrote:
> @@ -195,6 +195,13 @@ respectively, and they must begin with `refs/` when applied to `--glob`
>  or `--all`. If a trailing '/{asterisk}' is intended, it must be given
>  explicitly.
>
> +--exclude-hidden=[transfer|receive|uploadpack]::
> +	Do not include refs that have been hidden via either one of
> +	`transfer.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs` that
> +	the next `--all`, `--branches`, `--tags`, `--remotes` or `--glob` would
> +	otherwise consider.  This option is cleared when seeing one of these
> +	pseudo-refs.
> +

Hmm. I thought that part of the motivation behind this round was to drop
the 'transfer' group, since it's implied by '--exclude-hidden=receive
--exclude-hidden-uploadpack', no?

Thanks,
Taylor
