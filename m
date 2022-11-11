Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0C3C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 15:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiKKPHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 10:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiKKPGg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 10:06:36 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A98FB858
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 07:04:22 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bj12so13065891ejb.13
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 07:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k42XQOlITmh9pD4Y3vJVdMyKOTJ8yXzsdykg4X8Cv6o=;
        b=Sdi2mPrKE8/9wjz0UHZ+ZeQuBQmPp5hq2bNJ25AJ9NFIBN/kt59sZScfo2PQNddlV9
         BVyxzyWsTEIKJ/bO+ymIv/BI56TvyzyOHz2gR1g9QUr9T8I/fetSVwPYxCjApItKo11C
         /Rwr2v66T6zYIWBdmvZ9wZpEOmfxy6vNDLd2hQYWnfjHIRr+B1Z/SdDLku3kvZOW1j06
         o7fgAYYInjVl+khX1Zd5UY7eq1cOufEx9DgjgwA/V7/6k1mbO1vhN0dAE+IGDse7X2x/
         DJJ7xPVeJ12pILWK1uBlo+12URNyd4BUNY37scKRu/sauVBx1PamSycUtD5A+KcgTobU
         jRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k42XQOlITmh9pD4Y3vJVdMyKOTJ8yXzsdykg4X8Cv6o=;
        b=NBmprQOemb/KNyaQeJiW+rfBzJrnvQC200RaY7qBVAYCdClgdPeDFe/kHsTFWtoIh7
         yygv4bgSbqqToHBufNy8830IV+btykoE3GNYyapjLXPG/rT+6LEONF1/2Jwix0qtvAZu
         vagFUE/24ZHnDOn2748nLWlY6OrUQZt/EAa3peZ2nQoxb+vDkLt7C4HTuUgsPYIu+Gzi
         83ZbE645XO6pNxRWbXosE3EA6uXW2VP990h1Kp1a8Ri2nlW+070MO3PkQdcppFH8mgBo
         5m8gh8+5WC5pogZsdVdCqqY+k5apeVkd/ovxrwOOl0UzRcirWWA8xT2+GZMM9V0rc8XB
         mK9g==
X-Gm-Message-State: ANoB5pm2rNMa1u2ZU9aSpH5MxqEcs6n4RWQssHsRbzt+kl+vOaYjkBMk
        2Poo9mr4TNLY6pUNFlyR82E=
X-Google-Smtp-Source: AA0mqf4uRD2X0l7ydYREAPISy3l4q9P0x8DsQCU62ol1sXGTEaOyYRlpLnG21EIIgv3wLfWpgxw6dQ==
X-Received: by 2002:a17:907:9949:b0:7ae:6746:f270 with SMTP id kl9-20020a170907994900b007ae6746f270mr2154199ejc.728.1668179060371;
        Fri, 11 Nov 2022 07:04:20 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id fg15-20020a1709069c4f00b0078d4ee47c82sm944275ejc.129.2022.11.11.07.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 07:04:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otVZr-001wiL-0X;
        Fri, 11 Nov 2022 16:04:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/3] chainlint: emit line numbers alongside test
 definitions
Date:   Fri, 11 Nov 2022 16:03:01 +0100
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
Message-ID: <221111.861qq9o7m4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 09 2022, Eric Sunshine via GitGitGadget wrote:

> This is atop "es/chainlint-output"[2].
>
> (Note to self: Fortify against =C3=86var's nerd-snipe blacklist evasion.)

My only regret is not asking for a pony :)

This looks great, thanks. I read over the v2 (just commenting on the v1
CL for the above comment). I left a note about a potential follow-up
about the color detection, but that's aside from the main change here,
so I think it would be good to just get some version of your v2 as-is,
unless you're super keen to spend more time fiddling with this...
