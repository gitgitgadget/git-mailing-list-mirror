Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0808FC4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 17:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiKORee (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiKORec (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 12:34:32 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE9B1C13D
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 09:34:29 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id p141so11204385iod.6
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 09:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=plpDdO/WbqZo7aDYcmsdu8vGff7Y65sdkwAT+2YJk3Y=;
        b=KhypHeipYnCotH4NPr/szLa4y5Y+rsA4Mwco1GDt8lpESJqHAMMBJGTzc+xegWxjNk
         asleQ15cFcfWtmG8SlzFShSgD4BvmHRLUbgxmnz2zKM50yN7TJnpJRorhxKfIF++ond/
         Ib0PJc25kHbYd/BxV+7iBoD1KWACKrhmfJmobsWXevO8ljPh4UJzBRygametzOFXqcwP
         VoIih8g1HlJeTI6Ip+h9i6epDQC2FwYtmI3l3xgaongNEEO6yZwlLZ/b/VA5T8aJUnzI
         Y1VJQnEe5+6TSVwDygjVhaNlG+sKtd28iXmeVk07TXt6BNKnyWpBw6pj8E7TUJVkVoGp
         CXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plpDdO/WbqZo7aDYcmsdu8vGff7Y65sdkwAT+2YJk3Y=;
        b=tJFGhHsBU+aAUbmiGEWlt8UVAgG8CDHdfh1l2fxtnIWObI28GgOAUG3Ob+bkIhwpfC
         1o/NXB3sbCKNGN9Xl8fEgSCQJxNfVhC2Um428f9jJnfmTpnf++NMhAS/F8pZidKzEld6
         PqzlsL0o2L4oZ8PzqPDKF49as71EUWqxuKG9zpaQuAKY0CNaxDQHRcUiUUQIWtYgYixZ
         vf2P9u7ZGCL12WcvkMeJjmVS6RwqVZcF0PKtqO5kwKCfJF2+e88CO0k+KQx5s851SyVb
         z0CyVXNQeRbm7ZRaO5SyPU+ovlGGUnYUbEJ3K/KBP95rp+HVUs4q+599HeITVagS38Im
         Z+JA==
X-Gm-Message-State: ANoB5pk0zC/UldF994n9cMYjdhtI1cNiUJvfUlDVrivK8jmvi+3cI8S5
        loJC8zS5tph2FwvNHgW+IXJFJA==
X-Google-Smtp-Source: AA0mqf5v0GShstCnQSThZuh7F2cWvv1bLtmf3xN50XjZu0mixYM2EYClhhKc6+hd2XVB6Ls8gxd0GQ==
X-Received: by 2002:a5d:9e45:0:b0:6d1:f042:c307 with SMTP id i5-20020a5d9e45000000b006d1f042c307mr8449165ioi.165.1668533668554;
        Tue, 15 Nov 2022 09:34:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p2-20020a056638216200b003755c84f596sm4807259jak.9.2022.11.15.09.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:34:27 -0800 (PST)
Date:   Tue, 15 Nov 2022 12:34:26 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Ronan Pigott <ronan@rjp.ie>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] maintenance --unregister: fix uninit'd data use &
 -Wdeclaration-after-statement
Message-ID: <Y3PNolwofKgbkLh5@nand.local>
References: <patch-1.1-54d405f15f1-20221115T080212Z-avarab@gmail.com>
 <patch-v2-1.1-f37e99c9d59-20221115T160240Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-1.1-f37e99c9d59-20221115T160240Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 05:04:27PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Since (maintenance: add option to register in a specific config,
> 2022-11-09) we've been unable to build with "DEVELOPER=1" without
> "DEVOPTS=no-error", as the added code triggers a
> "-Wdeclaration-after-statement" warning.
>
> And worse than that, the data handed to git_configset_clear() is
> uninitialized, as can be spotted with e.g.:
>
> 	./t7900-maintenance.sh -vixd --run=23 --valgrind
> 	[...]
> 	+ git maintenance unregister --force
> 	Conditional jump or move depends on uninitialised value(s)
> 	   at 0x6B5F1E: git_configset_clear (config.c:2367)
> 	   by 0x4BA64E: maintenance_unregister (gc.c:1619)
> 	   by 0x4BD278: cmd_maintenance (gc.c:2650)
> 	   by 0x409905: run_builtin (git.c:466)
> 	   by 0x40A21C: handle_builtin (git.c:721)
> 	   by 0x40A58E: run_argv (git.c:788)
> 	   by 0x40AF68: cmd_main (git.c:926)
> 	   by 0x5D39FE: main (common-main.c:57)
> 	 Uninitialised value was created by a stack allocation
> 	   at 0x4BA22C: maintenance_unregister (gc.c:1557)
>
> Let's fix both of these issues, and also move the scope of the
> variable to the "if" statement it's used in, to make it obvious where
> it's used.
>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Thanks, both. I could have sworn I picked up the right version of this
topic when queuing, but apparently not.

I pushed this out to 'next' and rebuilt jch and seen based on the new
version. The result now should be OK. Thanks again for noticing and
working together.

Thanks,
Taylor
