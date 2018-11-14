Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D41FE1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 18:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeKOEK0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 23:10:26 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35409 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeKOEK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 23:10:26 -0500
Received: by mail-io1-f67.google.com with SMTP id u19so8158397ioc.2
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 10:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lD0pfuETnZmRF1cXw6eOxaC/HYsl9Ra8/fn9ydFaRuA=;
        b=Vzt3mDqYUQ1N5Z297UVJA0xaSJiV/BlSai8oKCmGxJLdeHD6aXAIagPMli6qX/scFz
         Yo3bPsGcs/gEMrpAqBcr/woMi5C6LyQLDP29+5O9+PWVwpNsXMIEmt67Tj+w3VRn6/d9
         hBQLL3ZLdIuhaSnMlVpmOsarr62qe6H9u9rP1sW5TnkO5E+oBnJVlU622oEpDpPKrUUK
         Y2zbQM29qO3XjmF9p/R4iiOBPOjWe9l2YnFoZjuekg6cGUGZo1Xon/veDA04PjJJ2V2a
         UMZkFdI0Ry4ZcGCJWk0liqiwRBs4nhtd50g+RL0UQCqRaokuU6LV+r7KaDgYzOBctsbc
         CAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lD0pfuETnZmRF1cXw6eOxaC/HYsl9Ra8/fn9ydFaRuA=;
        b=CYIjM6YjHUQ767ozmrz67fcdtHMuSX66po30+auIC0H+AWpkN6BGEr4RsR7zzaWK4w
         pGu/S00CkAS2UJ/MIOcK87/0e8SAhPWAdWqSecERRdNsjH3eSC9bF/W909bBVvS28PKX
         s/JcjaFxpe7lisfXJ9ww253Wr1+fxbPBKbhKPFfG7Clj7ytICbeclYsx43BIDcFhqhZ7
         NccRyd1A4Ia+V7EL+MQt9rneX5ctTITxm2bom1edm6t+5XgixLSko5Os6BOi0SSKN3Ir
         05NW03e/8ETrCbqiP53/28arfCfug+AO2XsfFVrtgNCc7ZHg7Rwzlo5TI5KyytspWFZy
         xmlQ==
X-Gm-Message-State: AA+aEWZghIgpzMSG8ZsicOiMQH4/fh0S/116dRFnnzMoc6nW8sHHeGhr
        SBgUvHfLtbWSrYDMh270bPM=
X-Google-Smtp-Source: AFSGD/UpHWEjPcLNnZ0BngEtJDRk2fXZosYC6jKJUI779Lhm9y3BE7feMW2s3fx5bUHnAcs0LdzHYg==
X-Received: by 2002:a5e:9817:: with SMTP id s23-v6mr2033777ioj.4.1542218771877;
        Wed, 14 Nov 2018 10:06:11 -0800 (PST)
Received: from archbookpro.localdomain (wn-campus-nat-129-97-124-6.dynamic.uwaterloo.ca. [129.97.124.6])
        by smtp.gmail.com with ESMTPSA id n198sm240154iod.76.2018.11.14.10.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 10:06:11 -0800 (PST)
Date:   Wed, 14 Nov 2018 13:06:08 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] commit: don't add scissors line if one exists
Message-ID: <20181114180608.GA2299@archbookpro.localdomain>
References: <cover.1542172724.git.liu.denton@gmail.com>
 <1c16b9497bd630f0636aa7729082da7a90ba42d9.1542172724.git.liu.denton@gmail.com>
 <xmqqwopgm6bb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwopgm6bb.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 05:06:32PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > If commit.cleanup = scissors is specified, don't produce a scissors line
> > if one already exists in the commit message.
> 
> It is good that you won't have two such lines in the end result, but
> is this (1) hiding real problem under the rug? (2) losing information?
> 
> If the current invocation of "git commit" added a scissors line in
> the buffer to be edited already, and we are adding another one in
> this function, is it possible that the real problem that somebody
> else has called wt_status_add_cut_line() before this function is
> called, in which case that other caller is what we need to fix,
> instead of this one?
> 

In patch 2/2, I intentionally inserted a scissors line into MERGE_MSG so
this patch ensures that we don't get duplicate scissors.

> If the existing line in the buffer came from the end user (perhaps
> it was given from "-F <file>", etc., with "-e" option) or --amend,
> how can we be sure if it is OK to lose everything after that
> scissors looking line?  In other words, the scissors looking line
> may just be part of the log message, in which case we may want to
> quote/escape it, so that the true scissors we append at a later
> place in the buffer would be noticed without losing the text before
> and after that scissors looking line we already had when this
> function was called?
> 

With the existing behaviour, any messages that contain a scissors
looking line will get cut at the earliest scissors anyway, so I believe
that this patch would not change the behaviour. If the users were
dealing with commit messages with a scissors looking line, the current
behaviour already requires users to be extra careful to ensure that the
scissors don't get accidentally removed so in the interest of preserving
the existing behaviour, I don't think that any extra information would
be lost from this patch.
