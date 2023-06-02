Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F59DC7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 13:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbjFBNOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbjFBNOn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 09:14:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F68AE56
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 06:14:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2567b589d3bso885596a91.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 06:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685711613; x=1688303613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fkKH2gxhTTRjbMage8iHjpmt3ICUqi+NUScXK1W2N+E=;
        b=ckID5LcBjj9bn4Hx6vcN41HPKGeF3wnDq8ZTYYffdFmpzKFoVI7YXeHjSvKU2rssIn
         aXFP2WZUtdZ0TUK6r1JDaYszwEi0pK7lv3gh93yDPBWhVyeKErf4/fZktlYCgyEDEM9A
         ySoKsHFf28RENV1j2B6FIAN2zvcofDJI/eM0BxZKIP4UWb4cn8vCeYgXabiztmw9QR9X
         jWBWPtfWejVmGXRM8w13XMGPnTQuI/G346hX1qK/AmfNwe6JSrSaudJIXHVEvJtlPyS0
         szAa7SLscaHC2GLAlh5PwoLYcAabu7G0fl1lNnuldKhd0F5BBFmmVkQr1o8Dsgz4bYtc
         hpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711613; x=1688303613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkKH2gxhTTRjbMage8iHjpmt3ICUqi+NUScXK1W2N+E=;
        b=f/UXmfFa9qmxCbgg1sMWMz+lCPUALFlppBRRk2dGvK1pgnUIyyzR+OvVDrLF1M+E7j
         f6zy8aiF/oRxzKJeb6YbwboYALS15HaO3SNhOhP24axL5aUp3ZbFwsC2udDO/is9uUqX
         YjVbjvPnD/2m+6h1EOxfz4Qjkhtk/bgiITx2E58HdTfgSmERFzwc9wecEttHlXnYwTa7
         npecUyvaMbCsA/wrI7Y4uaQUV1tAA8km5KPdnkn0MVGIvVAJPTMzG9rhQlq7UNlMjAco
         7I2QiXGuSVpUPDVzjl75Q7PmLnbwehSQOxifkSXxukXy9+J5Mr1+tfth+jX0D0sEqi7I
         1S6A==
X-Gm-Message-State: AC+VfDwGwkdLW17f7N4FeMOi2ERtcMQrXFg/BcTCidqyQ3cgvLo9rq/Y
        xfKTIS9u9SD8BBx3W0b1mm8Zwo3WGMjJ9+Qx
X-Google-Smtp-Source: ACHHUZ6pHV+G0NhHaIjJh6pHz6/K19WbO214/x45XzIXu6EIkNDRwpbAqxQKTu+K2VfcCkheV3Y16w==
X-Received: by 2002:a17:90a:1f84:b0:258:9f25:f25f with SMTP id x4-20020a17090a1f8400b002589f25f25fmr1357622pja.17.1685711613438;
        Fri, 02 Jun 2023 06:13:33 -0700 (PDT)
Received: from five231003 ([49.37.144.109])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a13c100b00258f9597e9fsm27023pjf.45.2023.06.02.06.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:13:33 -0700 (PDT)
Date:   Fri, 2 Jun 2023 18:43:29 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add new "signature" atom
Message-ID: <ZHnq-e0YAJSlAi9k@five231003>
References: <20230529192209.17747-1-five231003@gmail.com>
 <20230602023105.17979-1-five231003@gmail.com>
 <xmqqzg5i8gpt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzg5i8gpt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2023 at 04:29:34PM +0900, Junio C Hamano wrote:
> Kousik Sanagavarapu <five231003@gmail.com> writes:
> 
> > I have also rebased this to be on top of v2.41.0, the previous version
> > was on top of v2.41.0-rc0.
> 
> I am still feverish and feeling weak so no real review from me yet,

Please take care and get well soon.

> but there is one thing that immediately jumped at me.
>
> > Range-diff against v1:
> >
> > 1:  5c97d11b79 ! 1:  87465ef1a8 t/lib-gpg: introduce new prereq GPG2
> >     @@ t/lib-gpg.sh: test_lazy_prereq GPG '
> >      +  test $? != 127 || exit 1
> >      +
> >      +  case "$gpg_version" in
> >     -+  !"gpg (GnuPG) 2."*)
> >     ++  "gpg (GnuPG) 0."* | "gpg (GnuPG) 1.*")
> 
> The last '*' being inside double-quote would not be what you
> intended, I suspect?

Yeah, that was kind of a typo, thanks for catching it.

Thanks
