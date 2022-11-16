Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AD8C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 01:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiKPBU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 20:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiKPBU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 20:20:56 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340F82A243
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 17:20:56 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id o13so8397288ilq.6
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 17:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia95Ui65X0DVDgoxiYcmIicuw/BbAAJGQEfljnorZRU=;
        b=tRrFAm633OfMd2y1gG7GtlcxeN6IRYyh+eNilKnxwwpfks56VyfVbAwI2W8+awrLYn
         A07dLsmP0lhNAK6fjJL+Oi7YAEFoGmRXjbw0hdV0gTmj6AmzC5lyUvJD9TEmW9lPXlIb
         TKL0ZuYW2HqVM+0KEArCvn26L0sJ5WTa8f8lB87mtm2cAMuOZlPCkiBDMXsVTUCC15eF
         HJe7G/YHqp9bq3BnJW5RKeGeSmP6rEFCPLxBn3bg1u3JjKaEc5MTXl51DYgNKdCeyvMj
         kWGBYoEneem8/gSIYAp+mcpRZp4OQnd70gqhn0heDY78odIU9dcE5KoC6aPMjb82TvBX
         b/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia95Ui65X0DVDgoxiYcmIicuw/BbAAJGQEfljnorZRU=;
        b=2GNK0R+EsrivWMFF6zq9vFEUZGpHp22zoGtp+SaixRtmb8LU/UONFb1RoPDZllIvxH
         rECu8k/rGydMZABnHT/JBgXXXJntyP0l8tlrNwT7OQZ3g5sjSuAbnOiUe8wSbjTsXCJ2
         7yYwOHXJsmvMnnHlnzw8DXi8ZFzZ/RLcF/pKg/KFfsyBfvExuDszEeo24F07JoUqtuPs
         SmQZv8bWFRnDpk4PiCCzMUnKPZWD63mh/PmAFLBnhgQvOYiNxsUihaoGS7gQWsxN5Pnl
         M5xysnNs+IdjDfLj44Ef3WCxZ8QEule4W3TW3ANkXmDinoL/yAPfuy7Fbkb+vmDETz3X
         rvCQ==
X-Gm-Message-State: ANoB5pnUzloNkZ5Q4pMotjPWts+6oES9+Qf+rH7yi2K7ZNnqYloBucm1
        QgIiTvWdhJW+hI5OqVtO3SSF8w==
X-Google-Smtp-Source: AA0mqf5XNDTkZB63mNKvYZfKpXFPxT+eCk3O3fCgieT+WkuCOTr1MOM9B8TIoCXzlw+Bo544awsomg==
X-Received: by 2002:a92:ce44:0:b0:302:7dd3:a0d3 with SMTP id a4-20020a92ce44000000b003027dd3a0d3mr2087647ilr.95.1668561655538;
        Tue, 15 Nov 2022 17:20:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ca9-20020a0566381c0900b003754394cc3bsm5174862jab.114.2022.11.15.17.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 17:20:54 -0800 (PST)
Date:   Tue, 15 Nov 2022 20:20:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Subject: Re: ms/sendemail-validate-headers, was Re: What's cooking in git.git
 (Nov 2022, #03; Mon, 14)
Message-ID: <Y3Q69UlrmyCXLCsY@nand.local>
References: <Y3Mag8qG2D3qjlmg@nand.local>
 <4p90qnq3-580o-9n59-34n0-rs3pp635908o@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4p90qnq3-580o-9n59-34n0-rs3pp635908o@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 03:04:29PM +0100, Johannes Schindelin wrote:
> Hi Taylor,
>
> On Mon, 14 Nov 2022, Taylor Blau wrote:
>
> > * ms/sendemail-validate-headers (2022-11-11) 1 commit
> >  - Expose header information to git-send-email's sendemail-validate hook
> >
> >  Expecting a reroll.
> >  source: <20221111194223.644845-2-michael.strawbridge@amd.com>
>
> I see this mail, but no replies. Is it really appropriate to label this as
> "Expecting a reroll"?

Thanks for spotting. I wrote this one from memory, but in retrospect I
think I was thinking of a different thread [1] between the patch author
and brian where there was some discussion (but no patches).

> A more appropriate label would be "Breaks t9001", I would think, and the
> reference should probable be <36s0r4s9-n21r-pop9-o7rn-q0qrq487p831@tzk.qr>
> instead (but I sent that out only a couple of minutes ago, so I would
> still be curious why it was marked as "Expecting a reroll").

Yes, let's keep this out of 'seen' since it has seen no review and
breaks t9001. I'll update my notes accordingly, thanks.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/87czcm7maf.fsf@amd.com/#t
