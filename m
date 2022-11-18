Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF25CC4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 18:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbiKRSWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 13:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242682AbiKRSWF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 13:22:05 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78607970B4
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 10:21:58 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i5so2899298ilc.12
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 10:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QkS7/L5cZHo/drBo+RzLk6bbZk3J08FKad/aeCjcxR0=;
        b=TIGYQpgINjit4/qUD5CWKghwfjtOjO0EMiv0myJFTshYd6E3FB6SNhciDNnYY9N1Z+
         zVUTYuWwn9stpzbQ4Btffy3oE8mFSdZqTdcsseDGEW7XG95qRlf8PyBBSWbDsNU/P7zm
         LQshUbjtZYy6eKh7Tv+E/QUADgLbewH4P1LVTXqaswytZlVjlPO9mcHiTcsl/tmjR4eV
         WdyGcVCMSnjU3gFap9QhOrzgEiUXfgCr1r3vKxiZ8hCKI3urS6vcZ3hW5pYknhximJkN
         BRoBCwaEM05m0Q01gF/UTSReonoSZ5pQCjDOiS2zx4+wHLoWVNZj1aKMBN0H9OR5Qa8R
         HaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkS7/L5cZHo/drBo+RzLk6bbZk3J08FKad/aeCjcxR0=;
        b=QGzqvrIjOVl+QWGU0UZM0snGLdVrpbUKkGPUdo1yBpnzsc4vXOMxc7V7snSh2nVdfc
         ShLvLqSYX2uqFw5CVYcgFXBO8+SRbfolPnhOGZRQpVqJubGaCEEL5ljt13rN/YWcs8h9
         ZHsPGds5LHbxO35EWz38S6qAqHzHCVCtF86K7ge2N5iW8POAsFbeip3oEc4U+1tpnErc
         cjQTElbBInhzh4KqXJ9te4wp+TCsBggRYaykopjq071uKyThLWk+h36N0af9v84VwOCr
         NlNGTuSa25CTTcvBwGTOXjLaPVZtG1xb1PwUD8UtN86BV6jtXmIO0Er1pZ5CdzC8sJwe
         gFZg==
X-Gm-Message-State: ANoB5pkQJHcI3FKoznZp10bjawN/MFxkBm7gJMqGqSoLvLBjN4oA+Pnl
        VHUMvGyzKNengf3SJ4GaoxN5gQ==
X-Google-Smtp-Source: AA0mqf65KUe3714oqT9zH0GfLDWiV2shFh2qJ8ZPGaap6lKfFOIwRqX6UN+VAjIWuStrU6RY5XZ4mA==
X-Received: by 2002:a92:d602:0:b0:302:912f:7ac7 with SMTP id w2-20020a92d602000000b00302912f7ac7mr3806025ilm.75.1668795717856;
        Fri, 18 Nov 2022 10:21:57 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b21-20020a056602331500b006ccc36c963fsm1525914ioz.43.2022.11.18.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:21:57 -0800 (PST)
Date:   Fri, 18 Nov 2022 13:21:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] am: Allow passing --no-verify flag
Message-ID: <Y3fNQ9ysAeOsyOSQ@nand.local>
References: <20221118132743.3525725-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221118132743.3525725-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 02:27:43PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The git-am --no-verify flag is analogous to the same flag passed to
> git-commit. It bypasses the pre-applypatch and applypatch-msg hooks
> if they are enabled.

The patch below looks reasonable to me. Is there a way that we could
test this easily? It looks trivially correct to my eyes, but I want to
avoid the possibility of regressing here in the future.

Thanks,
Taylor
