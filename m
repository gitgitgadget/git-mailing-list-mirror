Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998E9C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 17:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbiHVR60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 13:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbiHVR6W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 13:58:22 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E61D5FF3
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 10:58:21 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id y4so8711692qvp.3
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=b5Y7usx4a+fiIt/4BuvYHKbRrFqe6ZK7a1Pr8TYGe+w=;
        b=b+NDy6186mBn6j60asEQj3IrXI0uFzfcX2jIkIF7CdT5mNHI3/O6RVfeiLDcVPPEUE
         9i37rPOrDlnJf2gZPwFJC+0saFMGSvtf6pcM6q9jAbw3QdY1jZC1pTb84H2GukWyIhxa
         4xGuRQULh3gpTPtGQIYTKIFHsQB2mgSVTpf/BVJsCRbZpyt/2202SL5C41JtvFTaHsWt
         k/Ss8Bya0VpDfeoztzqjrahrMI9l4NXd+kanenTD4d0uZXjnPAH29CIigjppSsKz9SSM
         m5VV/chVPdpR6gq1lx+Um46SKwu0shr/mwl6+hDrQC5QMOC65o9DEgE2jAZBMXTHxIfn
         Y1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=b5Y7usx4a+fiIt/4BuvYHKbRrFqe6ZK7a1Pr8TYGe+w=;
        b=fWMRhJpuHaCT++vaUi/3rJceg/HYMWQd3sf+1jDuRWMCmfPcP9xyph7gG1MNlvCqkn
         HzYkmyIJYnWVQc1lpYtsGIWbdMtiVocwRAOkfMLYTAKhENvLoUyx9Vig702X30ghHSbD
         j+PAxv+yPDKBV/L2HZGnD2yyr/s6YXyJhkMsnB2DspeWt0bRFlo6iXqgODLYdac2hjCz
         tWhR1quzsRGMTjG3dsD7JYpsDATc4L28ChdlCmMEdLLmG++k44EoqBkKrUbdL2aIj7qb
         opcrYnh8cqXEmDNj+Y94knM0zrMkeQzalcdY8kkeyh29s1gE2dn0yemyHff09GVz+VWM
         0MQg==
X-Gm-Message-State: ACgBeo3pfbRExJYtcLjLN4t9DR4EEoVoQjt0BFvUewifyj3r1pwPCOMe
        WaUygMExSmANAWui0XHZpK2Ffg==
X-Google-Smtp-Source: AA6agR6lBUJorcxkOHXy4WWQWXzcYFKZMmNHSbuCaG++AdLCo8BQ4/+m4fWvwErLbr4/t3O0w7vGGA==
X-Received: by 2002:a05:6214:260d:b0:495:48bb:7e8c with SMTP id gu13-20020a056214260d00b0049548bb7e8cmr16313406qvb.41.1661191100292;
        Mon, 22 Aug 2022 10:58:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n18-20020a05620a295200b006b9593e2f68sm12185984qkp.4.2022.08.22.10.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:58:20 -0700 (PDT)
Date:   Mon, 22 Aug 2022 13:58:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        jonathantanmy@google.com,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 2/6] t/lib-bitmap.sh: avoid silencing stderr
Message-ID: <YwPDu4GRp38ZgXXM@nand.local>
References: <cover.1660944574.git.me@ttaylorr.com>
 <053045db1459812a1baec8771ff22dcac6f9ad47.1660944574.git.me@ttaylorr.com>
 <CAPOJW5zSGOY4zryCiMc02HW73nyzzKVopuHgPevgSjeKkt+6zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPOJW5zSGOY4zryCiMc02HW73nyzzKVopuHgPevgSjeKkt+6zg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 20, 2022 at 10:14:03PM +0530, Abhradeep Chakraborty wrote:
> On Sat, Aug 20, 2022 at 3:00 AM Taylor Blau <me@ttaylorr.com> wrote:
> > diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
> > index a95537e759..f595937094 100644
> > --- a/t/lib-bitmap.sh
> > +++ b/t/lib-bitmap.sh
> > @@ -440,7 +440,7 @@ midx_bitmap_partial_tests () {
> >                 test_commit packed &&
> >                 git repack &&
> >                 test_commit loose &&
> > -               git multi-pack-index write --bitmap 2>err &&
> > +               git multi-pack-index write --bitmap &&
> >                 test_path_is_file $midx &&
> >                 test_path_is_file $midx-$(midx_checksum $objdir).bitmap
> >         '
>
> Thanks Taylor! I would say this is a very good change. It might have
> been there for some reason when it was written, but that was resisting
> us to debug what was going on ;-)

:-). I was probably doing something with "err" when I originally wrote
this test. But I likely dropped whatever assertion I had written and
forgot to stop redirecting stderr.

Better late than never ;-).

Thanks,
Taylor
