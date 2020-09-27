Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22178C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 21:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC17A23A01
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 21:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukwVweY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI0VQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 17:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgI0VQa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 17:16:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7ABC0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 14:16:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gx22so5647813ejb.5
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 14:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9pbI6YVCgsF0uOAkyEf07nbL+h/YwzsaQ6KexeKUZI=;
        b=ukwVweY+maHOHRshnA9AvUKOHEZryPLKk4omIUD4iRB+ECkwCkvc8iuw0EO4FpRiBD
         AGIG5AnV0p9qfNHyyVTrjy7KemLrU4Zcr9HMYW046iqny2Q9pSaNR0rsvyUd0FWOMuxL
         c+G722V/1lkTUKhOoGsUYXzf9FmyXogqsga/V9YEsi/8KYw4N6wsSz4BtUaILG2rRbVv
         e2ZPVOiqPHuKzkR2OkT/GjTOxAxcjb3RilEx/kA1fOeJT/aMUXCTas7btyYApYj73ekd
         ngQOjzTzKSGAzpDSET9mg2RfH4WRtciPiHJJJaKPHmbND4mjwwwgnPmgq55eYE+7+O1y
         Dh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9pbI6YVCgsF0uOAkyEf07nbL+h/YwzsaQ6KexeKUZI=;
        b=InWHehxOhGy5WL2BDj7I8F1x+juhImeCozR62AFr1CqhdfbidYlmUOlRPa5HE3ru41
         bWV/SCl6pCb1lqWgHexj6AVreK7KLUjXZZS6fNPmPWb15z4iYG6X5iBjH9Q0+3Ztfi2J
         F2q8AS79W1BtcdqkWRWtENGbdXRPj2KnLUrDtfCc1fwOmyjiz+JzrUVHSW0Y9eE/bAFV
         XEiCFBQEu8d3FwkN21aoxJYtURtRkLKraJk+Njph3RrCzjb5fJ3kFitdZ49wUl00gPFx
         SZZfumLzs9efbghyRx9FJEQa86cPfUtk6RSZLIvBEk4gkZfTOACVRAIoaQ5a8FNKec0C
         a+jA==
X-Gm-Message-State: AOAM531JwxaKduiwuKEDLVwM5OwEC8gGwdsz8KvTtLUm0DPNQZJ/hDSF
        X9kdmdKWz7J489C+iSShmgDXe2uG3LRaAuQOrYJOGzcOnH0=
X-Google-Smtp-Source: ABdhPJx/FIMRYOirgu0N89l70A36UZoICd0LaW9x5IRC9NbbihdUAYvBEtfn34gt3uOiw5Op78LfJ8FtHf53ykzp19Q=
X-Received: by 2002:a17:906:68d2:: with SMTP id y18mr12791120ejr.197.1601241387800;
 Sun, 27 Sep 2020 14:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2009020558550.56@tvgsbejvaqbjf.bet> <CAP8UFD31B9YgninC2Fyb=0+OVY7E4SW7LGBbx9E7CrgSn+95BA@mail.gmail.com>
 <c6367303-dc40-e896-4ed7-19f9d75b73df@gmail.com>
In-Reply-To: <c6367303-dc40-e896-4ed7-19f9d75b73df@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 27 Sep 2020 23:16:16 +0200
Message-ID: <CAP8UFD1Qvp010Ugd=CyEpYragy-t_xt0D8JbcB_4VHJMHf9F9w@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic,

On Sun, Sep 27, 2020 at 6:59 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 16-09-2020 14:31, Christian Couder wrote:
> >
> > - Accelerate rename detection and range-diff
> > (https://github.com/gitgitgadget/git/issues/519): ideally I would
> > co-mentor with someone a bit familiar with the suggested algorithms.
>
> I just applied to be a co-mentor for this project. I'm not familiar with
> the suggested algorithms right now but I hope I'll be able to get
> familiar with them over time. If someone else more suitable for the
> project could volunteer, I wouldn't mind stepping aside :)

Thanks for volunteering!

In the meantime I have asked GitLab if they could fund one intern.

Best,
Christian.
