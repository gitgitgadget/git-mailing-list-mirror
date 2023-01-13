Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E64C3DA78
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 20:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjAMUsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 15:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjAMUsY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 15:48:24 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5826425F1
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:48:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so1673437pjg.4
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RimUk0q3MvEw/1M110drERT/TJVcLG1BnMlE2pYPTs=;
        b=pxfDLcDoqvPl0pz5ojkADax5F3w/qKknyTV+XNDCNB0AUSYHXvWzvuSSi0fN1jvGXT
         yqI5Ijd0ikqXXPSX0z3nK/WeiFvVhCwko2Lss3gCHrO/fOTVOxiwVFcikRxcn+Mv1qH1
         6RXfY4lZKZVKSZ4pQpdRZt8mOH747TRGgFaWr8HTL2ywrnA5FoeFjdjKJnR3PVkhir2P
         Ay/g9CLpVmlnYUc6Rzp5vunUbrP1arvjp4a8vWKAddP2vI/4+O7vZw6kpddVV4rVrc2E
         0vA14fLh9Paqnfm//AVRg7ma7F+lVfEBa567OaRspel5q3xXwWr673HAurkWatq7vakY
         OcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RimUk0q3MvEw/1M110drERT/TJVcLG1BnMlE2pYPTs=;
        b=JQa92T7EqlYJjzt1vJxQIa0M+QhZdHCXpTL/cm0cgiSwl+deQBaVvnftpZVF1xaaIM
         Gq+Tnwn7JyduS5OUEzWkCxxyBnVrPDtQ96cVFBy7V1affpVHlmeq1TK4ffXnRWzvemB+
         LtLcdHjHLmR7WBYKoR+Igv8N0ak3YENPpPjXRh98SoccFSsGV6FaX5OoqoH0D5+xSPpL
         PYPeVRoehT6WC+dnRsq/3gZQQ29bFVgmoJtzZd89EPZlbmzUrJ/jcEQygx8UYm5e909U
         Zt39wjIOTcyp8Jo2w29QpODM1+OsA8Ogpbqol7bFTp18ClXtCybvKGPNJxtyiSLF7gkq
         KAHw==
X-Gm-Message-State: AFqh2kqYgMTyJzzNl+hMHiCXdkSFaYOu8MSAccs04FVGSRAR2lgIC/9h
        INujOggP61VTFpt5izrOK5e9ubNR65w=
X-Google-Smtp-Source: AMrXdXvNtD1PuSXfjPLywZoJFZzN7afrYvGabaWCsjB5f+ZlLCVED+krH8fAP5MJQuhj4pw28fxPnQ==
X-Received: by 2002:a17:902:8c89:b0:193:62a:80c8 with SMTP id t9-20020a1709028c8900b00193062a80c8mr28110650plo.45.1673642880666;
        Fri, 13 Jan 2023 12:48:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b001926bff074fsm14534660plg.276.2023.01.13.12.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:48:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 0/9] sequencer API & users: fix widespread leaks
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
        <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
        <e1722673-b444-2dcf-4087-46d2d15b9331@dunelm.org.uk>
Date:   Fri, 13 Jan 2023 12:47:59 -0800
In-Reply-To: <e1722673-b444-2dcf-4087-46d2d15b9331@dunelm.org.uk> (Phillip
        Wood's message of "Fri, 13 Jan 2023 10:45:38 +0000")
Message-ID: <xmqqedry17r4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Ævar
>
> The code changes in this version look good modulo a couple of minor
> comments, however some of the commit messages need to be updated to
> reflect the (very welcome) changes you've made in v2.
>
> Thanks again for working on this

Thanks, both.  Perhaps third-time a charm, with a bit more care on
the presentation ;-)

