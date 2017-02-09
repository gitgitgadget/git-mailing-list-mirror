Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8471FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 17:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbdBIR0U (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 12:26:20 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:35313 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbdBIR0S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 12:26:18 -0500
Received: by mail-it0-f51.google.com with SMTP id 203so130429039ith.0
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 09:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YLoZ2dcJGoTxkCHjWDPIHzNyk8V8ycXDhx/gdvu3m+k=;
        b=YY2+70QyBwLBo96kGT2kuhmzLLTUFj9yeNH0MGfOtBDS9ITV3Zs/EcuhzIGyp0nD3v
         qsTFSol8vU5zxyZDadQCSUfMLV1NGjCttGK2PI9u8YZcnrPmMryyPFBhoGXStnFrLqry
         phbA3Vb/KGo2oSoQ4wU5o0Kn8mHNMdyXIfA4bnAnQqO8Zp5pBwaKqgBQz9eFj4wYOQK1
         LbX/SIqzbBJ7vTQKulgp65aw13xIy3yKY76LfiaGJIN2sKwvYzFeeX3/KNQ72OKcIOfo
         amuaB2BbG3zq0hUVmsDDiqUUK61UpnKknLMLrjLfiBuED0ehp0e7GUQZPdg5mh34SO89
         CElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YLoZ2dcJGoTxkCHjWDPIHzNyk8V8ycXDhx/gdvu3m+k=;
        b=mcddodYTulMeL2qc06ns5zBMQYxFK6Ckq8A2uqnXUZ3oomvNKf5ipSnLPEsru2LoY4
         Q9Q7u6ViE44FvAYyX8a9Pd9ZoTw0h/vRknaT96Dx0fanXXiQZxgm4f/vvaGPjQMLPRLk
         6q3J5HBPib8zmXiOgPdg8o/bVV3mjASNOuicXpzP2ovZNTI3edFl4iqy0LN4+wpf5Jfy
         YQzyUXbEUlOmSI+vh6KY6i3+dMzU250Ay//hwrsEpGtKZtP2RReM9a61SWh0cGYMyZPv
         BULvfN9ZoX5grW4Xj2awbjGzjcr+xcO0xPyUJFfeWFtQekz/XCTCax/c7gl+6Fblgqv7
         n1FA==
X-Gm-Message-State: AIkVDXJqW2ocOU4SUo5zblKSxLiTay4gKJ3VFfozQ8xETVpgVNz5XkhnBYmFUuHJukWfmyq3N77tABs6gUxZLPa1
X-Received: by 10.36.40.198 with SMTP id h189mr23138378ith.114.1486661120876;
 Thu, 09 Feb 2017 09:25:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 9 Feb 2017 09:25:20 -0800 (PST)
In-Reply-To: <111d663c0fd3e9669e7c28537f581833488ca4a6.1486629195.git.mhagger@alum.mit.edu>
References: <cover.1486629195.git.mhagger@alum.mit.edu> <111d663c0fd3e9669e7c28537f581833488ca4a6.1486629195.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Feb 2017 09:25:20 -0800
Message-ID: <CAGZ79kaWFmutihZ-7_xUOB2K3TR6f4Ap9z3LC8s=3YpxOOd5DQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] files_ref_store::submodule: use NULL for the main repository
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 5:27 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> The old practice of storing the empty string in this member for the main
> repository was a holdover from before 00eebe3 (refs: create a base class
> "ref_store" for files_ref_store, 2016-09-04), when the submodule was
> stored in a flex array at the end of `struct files_ref_store`. Storing
> NULL for this case is more idiomatic and a tiny bit less code.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Makes sense!
Stefan
