Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047F9C433E0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 18:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4ABE225AB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 18:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgL1Sfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 13:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgL1Sfi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 13:35:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0493EC0613D6
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 10:34:52 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lj6so90809pjb.0
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 10:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QTbe3C8I8sH6NuC0Ju1kjWy/MR23MJfVcyRpY7NxXU8=;
        b=Gz0PYtLFJa0TrOVPwIPuNkiO2GfF3wDzo5Ec02POs4u4dL3bkkDHE/S2tjO0nEclI6
         h8DFnOiVS8ne/vBRJ6szua1bKaM69gmCV8IaR294DUTdcBPMptLI74ecPRNj4201sK3F
         0PxGXy9Rt2n1d/+xYAHXxE4LNlbFoq7uPopTxdtPXVhH3LOBKuTzK8g0bcA3Yh1mHmMM
         Vgs36rUnIe1ljzun5JoHJw3DuiB2LCvMWS3iDqpaZUaPaBlcUO5o9d+GR5QCNBGzVDFq
         mmnzrysdVigeqj3v7zc4UrXJF+KgeqCke/MHOa7iXi25iszdthcc2Ccr9HtqAFN1OH+e
         mdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QTbe3C8I8sH6NuC0Ju1kjWy/MR23MJfVcyRpY7NxXU8=;
        b=FrEAMOpvIH8B9UBTac5SpiZT8Hoj7+19XzLMFU7HCrpw4PgmXybjvPlbySz7txt9tx
         FeviakBrwHkRxdlhQlNB8QXEjrnsH2ifPAu5khIS/0YGM+V7Lk/fAc3muuR+9eF09TlJ
         tiwCGwPHC2bzlYxbPQeAqUHTiUiXOmpIUqGTrE3mSgANTsLG0HLxmoKylLRE6iAZIpyb
         efDxl/f99jfSMu1AHlLSO1zLo/iDdGxzsvV66EG1wJoCS2c5/kDF/5wm8pBC1QMjzlGv
         PGlkIUPJFfLX/uIB8YW/JZtDDnQirDC5Tzod+QfV3J4+KkvG8039H9il9tFp/qy6X0Zc
         o7Sg==
X-Gm-Message-State: AOAM530zEqcOAR/GAxn4wGbRTiZFZ1Nqdg0pYAa4pFN3Wabz+p746RQz
        nx6BvIPcE5Hfs4vastDtHPz/7w==
X-Google-Smtp-Source: ABdhPJy4G/ONZfv4EmJMyFWm6aQj/28NdsBGZ4bjJRWXRS8wuvXitYwlxv1IhHFYn8KUNgK/XZr3pg==
X-Received: by 2002:a17:90b:3018:: with SMTP id hg24mr221765pjb.20.1609180491318;
        Mon, 28 Dec 2020 10:34:51 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id i2sm114383pjd.21.2020.12.28.10.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 10:34:50 -0800 (PST)
Date:   Mon, 28 Dec 2020 10:34:45 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 00/17] propose config-based hooks (part I)
Message-ID: <20201228183445.GJ3783238@google.com>
References: <20201222000220.1491091-1-emilyshaffer@google.com>
 <xmqqft3yk2ti.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqft3yk2ti.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 21, 2020 at 06:11:05PM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Since v6:
> >
> >  - Converted 'enum hookdir_opt' to UPPER_SNAKE
> >  - Coccinelle fix in the hook destructor
> >  - Fixed a bug where builtin/hook.c wasn't running the default git config setup
> >    and therefore missed hooks in core.hooksPath when it was set. (These hooks
> >    would still run except when invoked by 'git hook run' as the config was
> >    called by the processes which invoked the hook library.)
> 
> Thanks.  Queued both series (it probably is easier to think of these
> as a single 34-patch series, as long as they both are in flight at
> the same time).
> 

Do you want me to send them as a single thread for next version?
