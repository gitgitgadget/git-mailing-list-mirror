Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CD3C2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 01:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37616610A0
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 01:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhFWBjY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 21:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFWBjX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 21:39:23 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910CDC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 18:37:06 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s23so1527421oiw.9
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 18:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=u3ALSnvLeFKuCJf917xCWekYHE6O8GmLvlexvCs53no=;
        b=QZR0XbUvozngCafRCJeDKL2mKTD3tt/AgZE9mjHty81912uRaiG1GMCdB6BLm200QI
         ace4j0U7DmbOldRSA/OhPAUwss05FENqHtP6A9OpO6hpxypCaZiRUxTavZgcDDnr6xIZ
         oQNq9v2vKGiD0rgVXW+rojVml4DWsb+9wLMkhMz+VF1n/J/qmPDKcyPjQGu/9mLDo1+M
         1SguNvcn2bjFIpDCFjP2PKLzvLGasHnb2cALTU3HvnZZ0zL7NIbZJsEZt7nTEEwbQXN7
         YWliFS0/V7uZFaJeJt9CM/YJZFVnzS1ENEVdff6ocmnlXZ+u8LYpvR0HnZJw4Xr3JYVC
         9kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=u3ALSnvLeFKuCJf917xCWekYHE6O8GmLvlexvCs53no=;
        b=OC7coAHYErUV2fqb/MCTh16ybOva/5dnM/bHd3IhH+ATr+gSRvJUSqzz5C21Jqc00R
         x4LXe/6xnmEu1mrdVNFfHyxA7DgQWCLEkCIF/vQmqbClSdUb2yJiF/LJqxqJdYAhmmo+
         yyl30Y9W/39+60fdMiZ2UjbjLOHS06NUVkoNAA3IYTJB2vtvjFBi+mQMBKJ6yqwId9TO
         6JGlRQtSD3s3Bz+fZnQULPJLv4CfQD+i0sAXFMfsNwyTNI15UH5KBfYb9i47WRSVb+1z
         k7df8O0uR4PMARq107QMq43n5xkppO3KAjKUWCocfDDlFlX3XOG1eTVhLvOnBr/uyv5I
         US5w==
X-Gm-Message-State: AOAM531ix6F+gXVFi/Z+OTSu2emNIXTDE+X3WFNqJqIAyvALn61MIxK0
        Mhv9TMtmo6CpS/t58iyhJzs=
X-Google-Smtp-Source: ABdhPJzBEkug5ia3JlfrH6gj/Nlh8/baZUGzoHESiDyAP0yVTRY11GvTfBSCpVegHwMJN4htibsaRQ==
X-Received: by 2002:aca:c3cc:: with SMTP id t195mr1287606oif.119.1624412226003;
        Tue, 22 Jun 2021 18:37:06 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id c7sm266726otn.7.2021.06.22.18.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 18:37:05 -0700 (PDT)
Date:   Tue, 22 Jun 2021 20:37:03 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Message-ID: <60d2903f59f39_3122087c@natae.notmuch>
In-Reply-To: <f660c96f-cc30-6a18-00ba-82a2673aa3bd@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
 <f660c96f-cc30-6a18-00ba-82a2673aa3bd@gmail.com>
Subject: Re: [PATCH 00/23] doc: cleanups and asciidoctor direct man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 21/06/21 23.30, Felipe Contreras wrote:
> > I already sent the first part of this series separately multiple times,
> > the last one is 4 simple obviously correct patches [1], but since the
> > maintainer has admitted he has no problem ignoring valid work
> > entirely due to personal animus [2], I'm sending the whole chain.
> > 
> > There's no point in carefully selecting multiple series of patches to be
> > merged one by one when all of them are going to be ignored. So I'm
> > sending all 3 series at once.
> > 
> > Hopefully by sending it all at once some people will be able to realize
> > that:
> > 
> >   1. They are valid
> >   2. They are helpful
> >   3. They make the code more maintainable
> >   4. They enable new features
> >   5. They enable the new features to be easily tested
> >   6. They reduce the doc-diff of the new feature, as well as others
> >   7. They are superior to the competing series currently in seen
> >   8. They include work of multiple contributors
> > 
> > Any fair and impartial maintainer would attempt to pick them up.
> > 
> > Cheers.
> > 
> 
> I think the next step after this patch series is to add asciidoctor 
> direct man pages generation option to ./configure script (maybe 
> --enable-asciidoctor-manpage?). But before that, we need to add 
> --enable-asciidoctor option, which sets USE_ASCIIDOCTOR=YesPlease.

Maybe. I don't use ./configure, so perhaps somebody that does should
take charge of this.

-- 
Felipe Contreras
