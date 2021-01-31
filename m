Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7D9C433E0
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 01:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D30C764E11
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 01:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhAaBqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 20:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhAaBqW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 20:46:22 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF5AC06174A
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 17:45:41 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id n8so1364277qtp.5
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 17:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7H196SwQYbupbt4mWcLZroNZGUWx58L3iBRp1jBUu1Y=;
        b=0bzbbbkLpVS+T4G+oKecoOhh5Y9IQbqusmrBW8kHqYS1GL/OeeemGP6L101FqbwnYw
         0n0TWPPfNJZvz/5aP9DvtrxnLk5IgewDeSsKETbPFbfm8JHWY2+CILFTJpTRYqVFDOPB
         pPFgQwJ/fpZ1mPw/lVkaBNMfAVDVW35l9tXiYy4FaPKuI7R+BlEhhLCIhv7Klg7dvgcb
         VT67/4v9ICSG7yWJ3NVY7/uSWOH463MzsrP5a06MhY7bfjpmwZM7fX+K1sWDf69aMGiF
         MbrCgHTr33uhllHMK8HzYmdPsalpjqxCPfPaWNJxfp4Ntk+Oz+znormUfD+dB8CTUwYW
         wRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7H196SwQYbupbt4mWcLZroNZGUWx58L3iBRp1jBUu1Y=;
        b=pb2904r8L4K172Qb/PAJOwUB2qxIYgLgHIXx/nFjghtCa+35t37r1qXF3JnFVdvAdL
         1130WFEyhpsYcC8LG288sWQkAuDkj6Aczd/4nJTfjbzondDOC6KqkkNHLlB+6ocYPCNp
         b2L37GOkNrEfQd7mQEff3fORevAEcNErOamq4RItU9ElQQ7ltxNbwPnaKAZI7M1xgCRd
         /sX0NjAXbSRt34RnUWNp+yHKBh17u0f+6AfYDNunC8YTWRDvkoKHi1b3D3CMgFH5jH0V
         5uWPPUY79htDO3cf0kA/TW1t7Oez1XCLNxQzvX1cyfgw6ZDqtyIsYLQLkOMOhdplB2qP
         19Mw==
X-Gm-Message-State: AOAM533K4upOa269Nl+0ax1j7vlGMl9kTArQ6QglR1H08+UfjJYFyJJ8
        ngntDU4TcLsa2Mvfh9vglt1dhjE7wio5jA==
X-Google-Smtp-Source: ABdhPJyre/07Ik1m4n/WRWOgLNbXgrb3cHpUzSRdq/JUEMvAsfISsM4Nh7pHqH6bEc8ng4fdsNepOw==
X-Received: by 2002:ac8:5156:: with SMTP id h22mr10350772qtn.176.1612057541250;
        Sat, 30 Jan 2021 17:45:41 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:cb6d:aba9:e3c2:e996])
        by smtp.gmail.com with ESMTPSA id s129sm6256541qkh.37.2021.01.30.17.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 17:45:40 -0800 (PST)
Date:   Sat, 30 Jan 2021 20:45:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     20210127000454.GA1440011@szeder.dev
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, jnareb@gmail.com, me@ttaylorr.com,
        stolee@gmail.com
Subject: Re: [PATCH v6 11/11] doc: add corrected commit date info
Message-ID: <YBYLwpKdUfxCNwaz@nand.local>
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
 <e571f03d8bd0b2def8e16df68f6cc53ffcf02082.1610820679.git.gitgitgadget@gmail.com>
 <20210127000454.GA1440011@szeder.dev>
 <YBTuoTsrnbzLtX0j@Abhishek-Arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YBTuoTsrnbzLtX0j@Abhishek-Arch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 30, 2021 at 10:59:05AM +0530, Abhishek Kumar wrote:
> > You might want to take
> > https://public-inbox.org/git/20200529085038.26008-16-szeder.dev@gmail.com/
> > as an inspiration.
> >
> Alright, the suggestion makes a lot of sense and the patch introducing
> documentation is the perfect place to justify the introduction of new
> chunk format.

I don't have any strong feelings about Gábor's suggestion itself, but
note that there isn't any work for you to do in this series, since the
patches are on track to be merged to master.

Thanks,
Taylor
