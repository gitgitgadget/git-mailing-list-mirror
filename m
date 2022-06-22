Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E043C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 16:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359339AbiFVQri (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359441AbiFVQrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 12:47:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276E840900
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:46:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f16so15085074pjj.1
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4ReMp9q/CEQLuFCdgexKdfmeN/knMhGiCgX2ZA8E4U=;
        b=aGhMua0NoeNl2Y3wpIQFUuT1X7noIXMvfiyeEsW0poxP0VUkMfT8JXPHBUSOZmlddU
         FNHj371UKUKVfvbOwV2HFuwl4bnFsTBM6+YXOK3Tk+XuOK3P+2N+rNtzJD2FQjQMaQhd
         AHQqTEeb1pJZ4G7/tejilmmKkWATdoz14eQkzV3KjXjkgHQY0wdc4pskhvTz0KFKmEBF
         hh/tWWHH7amARlk0cfo0pSNvOYf4LuMO4h/qgl69fcGyOiTTPqAKK6CB2w56Qhje8Ks8
         BRchOT9jptlIzxjb5DGC4IF/VoqmEs/UdXSqBh0LdGt+82TKJQ/CuzxrG1DfjFVIstdz
         mAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4ReMp9q/CEQLuFCdgexKdfmeN/knMhGiCgX2ZA8E4U=;
        b=wjUiCyp2ny7DGQoEOhOeRcrBP7n3jVKriRLOrcIRxaCyoZ4CGFU3MHmqVreEEYSnqt
         lrScdJN1CLRhnKGMjmMIR/IDIiE/8xrO492C2qpDtj7QxOG2LASizQZw+APPt/AHuUnY
         Gmf3c+jxMRCeGGo8qcpQJYt+PRCOuNXaGUwT9ltFroTtmx+aIk/Tk6Ve3OBf2g5LB1Al
         KlcH+i9YqMTHkvKvpGBwfX1aM0u8Pr6hICvKAVZdSvPYxnehmHYp4oYkv2uEvDewN89+
         10JltAIFrjg1X8gMMAZnqNXGChXMlBh8pODOdqyr1DnZCn7xlUKY4Hg2tuDv8OhSTs0F
         0i9Q==
X-Gm-Message-State: AJIora8vqfvNZzzv+JXSAA6pDd73pkImEyaxmDY4vhRrVr+A+dDX8PHR
        +UTf1mU/CkSbzlbeXr1ytit3bwLhsCk=
X-Google-Smtp-Source: AGRyM1sBrhh9Ab54FXdk5PYezyZ9IXo7ER/1cf/AXh9wZZgoSZPaMN7Pal3T/WX06O7mVsYKyc9VbQ==
X-Received: by 2002:a17:90b:3557:b0:1ec:cd27:1ca9 with SMTP id lt23-20020a17090b355700b001eccd271ca9mr9404846pjb.148.1655916381452;
        Wed, 22 Jun 2022 09:46:21 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.21])
        by smtp.gmail.com with ESMTPSA id bb10-20020a170902bc8a00b0016a4a2ea92asm1826171plb.255.2022.06.22.09.46.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jun 2022 09:46:20 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/6] Documentation/technical: describe bitmap lookup table extension
Date:   Wed, 22 Jun 2022 22:15:23 +0530
Message-Id: <20220622164523.46256-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YrNDZMixyt8xNAvS@nand.local>
References: <YrNDZMixyt8xNAvS@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> It should be negligible relative to everything else, I would imagine.
> The function that converts an index position into an object ID is
> `nth_packed_object_id()`.
>
> > I still have a feeling that there is some way to get rid of this
> > list of commit ids. But at the same time, I do not want to add
> > extra computation to the code.
>
> I'm hoping that the additional complexity is minor. And if we can save
> some extra bytes that aren't necessary in the first place without
> compromising on performance, I think that's worthwhile to do.

Ok. I will look into it then.

Most of the reviews has been addressed. Hope I will be able to submit
it soon.

Thanks :)
