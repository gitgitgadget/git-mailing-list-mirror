Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205B2C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED04760698
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhGNTdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhGNTdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 15:33:46 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DE8C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:30:53 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id k16so3522910ios.10
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GzycJk/gGsUXUNFqMDsVAuk7fTsHE2HX9tuoW2o2KRk=;
        b=h20PlfgAqCytjNp1WKA514LNYCIKYLbBBuuS8HDPXSIp48+HJJcmeXlfMXRatHftNV
         mKens4cLC1PIxy6Mwr4WSOWbPhPT8gwVLwuj8JOd26WoAlntYq4/rLw63XdpOI8uROXy
         UQWNAc4rRGV1dd6Z4ocFAfcO45W55TCnTI/yGN2KOJKOzg0yqeBJtEdvuTStrI0gRc1D
         cjZz8pe8fKi3TmnWkz1J74s/9YiO3uAWmad7/ypTiWz4rCt/l5qtvoQBPWaqRdP1EqQz
         HQ3SHyKQu0VnPheOgEx02CngFfxgDv4jdeYCY6+nZTmb26qN6c0HcbQ/b05DSHYoNsuH
         WDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GzycJk/gGsUXUNFqMDsVAuk7fTsHE2HX9tuoW2o2KRk=;
        b=KpSappJWjDFa/io3VUkHf2UMHkJoa2I/90UefNRsY5n84OdmSc1jLWVNs4P3fDAaoD
         z+HKjLs2vxmLmLxmfJJFxptm/UizC0JpoSjtdt22im4cblEiZT4owrynKkW5utr5gpEg
         ax2GzM2ZU3AAcvQN10HLPaIThvG1DD1NYL2rIUf5kMOKexuiCeNF3n0tcgtOY74qLL7P
         oIrIi81waxw1sj5ZDQhWynhCfsgNA1pZjXx23QYa2hKF7f2kBT4NysfT9nrVv+FBrk7L
         6g+1L/PZo1tbNSr0IesyvliSWGJtrjTUtNxXIHdEUrjQ+SXlmxDOtg4TMJ+FG+XsmL74
         Ol8g==
X-Gm-Message-State: AOAM532YP488zpmZdL6iUJ0WFb6vOEqXN8Yuu/r20B2e0TgJQNAzegT/
        Ecwno6xx3SFYqh8ws24JICq6mA==
X-Google-Smtp-Source: ABdhPJxWy7HFErEHFjxPaMds9xw3Ww9Q3LGozIaLnpktUiCWGEfBLsb/ZRwKKniUniRD1nyTBXSn7A==
X-Received: by 2002:a5e:a908:: with SMTP id c8mr1105894iod.116.1626291052580;
        Wed, 14 Jul 2021 12:30:52 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3f15:e25d:cd63:d019])
        by smtp.gmail.com with ESMTPSA id a10sm1816727ioo.9.2021.07.14.12.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:30:52 -0700 (PDT)
Date:   Wed, 14 Jul 2021 15:30:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <ttaylorr@github.com>, Sun Chao <16657101987@163.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
Message-ID: <YO87ax2JpLndc5Ly@nand.local>
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <87wnpt1wwc.fsf@evledraar.gmail.com>
 <YO5RZ0Wix/K5q53Z@nand.local>
 <ACE7ECBE-0D7A-4FB8-B4F9-F9E32BE2234C@163.com>
 <YO8XrOChAtxhpuxS@nand.local>
 <877dhs20x3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dhs20x3.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 08:19:15PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> The reason why we want to avoid freshen the mtime of ".pack" file is to
> >> improve the reading speed of Git Servers.
> >
> > That's surprising behavior to me. Are you saying that calling utime(2)
> > causes the *page* cache to be invalidated and that most reads are
> > cache-misses lowering overall IOPS?
>
> I think you may be right narrowly, but wrong in this context :)
>
> I.e. my understanding of this problem is that they have some incremental
> backup job, e.g. rsync without --checksum (not that doing that would
> help, chicken & egg issue)..

Ah, thanks for explaining. That's helpful, and changes my thinking.

Ideally, Sun would be able to use --checksum (if they are using rsync)
or some equivalent (if they are not). In other words, this seems like a
problem that Git shouldn't be bending over backwards for.

But if that isn't possible, then I find introducing a new file to
redefine the pack's mtime just to accommodate a backup system that
doesn't know better to be a poor justification for adding this
complexity. Especially since we agree that rsync-ing live Git
repositories is a bad idea in the first place ;).

If it were me, I would probably stop here and avoid pursuing this
further. But an OK middle ground might be core.freshenPackfiles=<bool>
to indicate whether or not packs can be freshened, or the objects
contained within them should just be rewritten loose.

Sun could then set this configuration to "false", implying:

  - That they would have more random loose objects, leading to some
    redundant work by their backup system.
  - But they wouldn't have to resync their huge packfiles.

...and we wouldn't have to introduce any new formats/file types to do
it. To me, that seems like a net-positive outcome.

Thanks,
Taylor
