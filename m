Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340BCC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243559AbiBWRyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbiBWRyO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:54:14 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F7D2674
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:53:46 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id f2so4436762ilq.1
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/GlptKnYAlAomx6vUPcANldjw0CbVa5JaTurlyuj948=;
        b=hcoVAKMP3P5SVC6QTVgjZuS/NpP4EYz95cH0aehoLmKBnsypDcIDkvL8KjqmuON3e7
         pVs/KoC6uZuMkReIZltktzOkvS9lHjS/sUGY9sdEID7DI+hIPUY6/JJi39NbK7FUdGio
         KZW/l0yBgUWgmvsAzzvsX7nxrSRSGGen1IjaEJ/Wm4ETzfujU4zmqnlbibR/c+d3SvQp
         nwRshM/bqlGZvBNPZsk4KebR8wnZndtxUXSVGmCWXx59dr/yGaSj+v9fkIc/ydyvDCug
         OnERatgjwCm+ClLUVq/lD8oDZWQCozYSiIysz8T7BXWYK1L14zomVBmmgvBdabe8JTE3
         fTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/GlptKnYAlAomx6vUPcANldjw0CbVa5JaTurlyuj948=;
        b=8AYa9fU/W1aoeMjhAZBBuvJJGxlHF5Be7EEyzjzQX0p3XFRSqcejkm1qFtWIjiSfpN
         6BiRGVqAK517dhzKxBeiJagGEHnEogMbZklwcs88is7kSkovQdVQzAGV6xOe1n8wVfEC
         e6trU8ogq8g1NmqbwKO1LeRKPtk675hwVttjPKdtNYoh1m7/VW7ux8cpq1q4MQ+0n7Ge
         gnySKuamW33egobk1TttFwX5exjY3c1PuE/I0ICqw5dNdqhUSUm+riqibFAwzcALDQ3f
         QBDSj7FIH8zY+2S8K/YbZofWf3XFdYD7SeQeLEvPNl2MkVPvAq/vVwnmU7Cv56nC5BzQ
         HUTw==
X-Gm-Message-State: AOAM533AHt1AvpBEZQj7TI96Ivq1SyQn5TG4/CYNEFxDUiwule0NusT5
        r34Gvc6b4O3Awq1brj6F9wsnC1Ox/+cEhUfA
X-Google-Smtp-Source: ABdhPJww6koIIyuyTu+B7j6hWry7OWB1pCpnv52KDTjDfGbcZgS7pWVI96WExuoYGA6SjrHCT+blrA==
X-Received: by 2002:a05:6e02:54e:b0:2b8:b9af:731a with SMTP id i14-20020a056e02054e00b002b8b9af731amr647082ils.205.1645638825941;
        Wed, 23 Feb 2022 09:53:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s15sm160984ilq.66.2022.02.23.09.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:53:45 -0800 (PST)
Date:   Wed, 23 Feb 2022 12:53:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, avarab@gmail.com
Subject: Re: [PATCH v2 1/2] t0001: avoid pipes with Git on LHS
Message-ID: <YhZ0qOwtY1vUVTiN@nand.local>
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220223115347.3083-1-shivam828787@gmail.com>
 <20220223115347.3083-2-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220223115347.3083-2-shivam828787@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 05:23:46PM +0530, Shubham Mishra wrote:
> Pipes ignore error codes of LHS command and thu`s we should not use
> them with Git in tests. As an alternative, use a 'tmp' file to write
> the Git output so we can test the exit code.

This patch does preserve the existing behavior. But I'm hesitant to
recommend that we apply this patch, since our test suite assumes that
commands like find will work, and so we aren't concerned about squashing
any potential error codes when it's on the left-hand side of the pipe,
since we assume that it won't fail in general.

(That's notably different from the second patch in this series, where
the thing on the left-hand side of the pipe is a git invocation. In that
case, we really _do_ want to avoid having it on the left-hand side of
the pipe, because we don't have the same error-free expectation there,
and want to know when it fails).

I think that Ævar gave a nice summary of the above in [1]

Thanks,
Taylor

[1]: https://lore.kernel.org/git/220222.86pmnf6ket.gmgdl@evledraar.gmail.com/
