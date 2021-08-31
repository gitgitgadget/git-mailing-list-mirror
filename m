Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334BCC4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E99860F23
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbhHaUYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbhHaUYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:24:12 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B07FC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:23:16 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso728868otp.1
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g222yJajUlR7UbZ45XabrRTKFNB/doWPvY2QgAskeTQ=;
        b=Kiz376X3TkFEdRhntQAEg/pJORUrNHD5j3LGxu32S8/vNdI7OYII0ZEGSYyb4cAGQG
         tx08CeKWGl8L5pTkfHsC9oPKCWXEuqUhbkyyDcjDgsPxjjVcwdDIXc2q8JJeumhAPbxa
         YncIbqU0n97NX8l+/3OvFPQaPPi4Dgx7H1QTkmpCoYB03e0DM3k2K86Za2R+SLbg9yms
         bTCsqH+cTkWG8LszQYpvPy5BGFDglho+KOZokU66NqfPc3JmkNNOoObWRwRZcl4TGCOa
         qqqnWgt8kr0bGhr3lxEVbkD3FLFm+Z39iA25ofnJhvV2gxDLE1L4U6D+W3G4LHoVJtEB
         bIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g222yJajUlR7UbZ45XabrRTKFNB/doWPvY2QgAskeTQ=;
        b=P7qQxCM+qD3PZj43Amu6dcFo7t0bQ/FSivhgWBYkYdSNMSO+4tD7E02YZPQNQQRnmU
         WHkmfyoD6st94S5oBwMTqmnMV8yQORLDVAeTsvSNwxg9ih8IsXZ8nu3IUvmxdENA1Xtu
         rn28an8ue5MIA6GPpcPpxHrabi2m/XoMXNQvqPdTwNeekVTaJD1EugLd2DQRmyxy5bXB
         cRo1QgSxQWg9sCu3Nc2yIu0FUz7WJGeRnQkvLjV1yPtdgSpD9NGijATmeFvxZK3BmZAo
         9CvQ8zjMAmajzD5kyJFR8KErbvaXiiPfcBMDxh1DmU79WuKzjhYkxACvP40pqk9+geKX
         12nQ==
X-Gm-Message-State: AOAM530+MX3/8qKbR/gK60h0+vCAzlTRUl3fePJyFzrjNP6vcmbew0Lf
        dNT7l/TveyL9W3a5PiI8wZ8jp2qkaETacdokMZ0=
X-Google-Smtp-Source: ABdhPJwZ7RRL+pynWMrLVUVLNatcHmjbcnBSKtUNyfcEm512L5+QI2AfvXfYRDPtTR15lRzdFQCVVeYXRabEAx3ykmo=
X-Received: by 2002:a9d:630e:: with SMTP id q14mr25337555otk.316.1630441395950;
 Tue, 31 Aug 2021 13:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com> <xmqq4kb5tm9f.fsf@gitster.g>
In-Reply-To: <xmqq4kb5tm9f.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Aug 2021 13:23:04 -0700
Message-ID: <CABPp-BHjpNLXeGA1=KniL=vVuH32c59_LphPZcqnM30GPerCZw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add a new --remerge-diff capability to show & log
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 1:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Here are some patches to add a --remerge-diff capability to show & log,
> > which works by comparing merge commits to an automatic remerge (note that
> > the automatic remerge tree can contain files with conflict markers).
>
> Excited ;-)
>
> >  * This new option does not (currently) work for octopus merges, since
> >    merge-ort is specific to two-parent merges[1].
>
> Unless you do so manually, the native "octopus" backend does not let
> you create non-trivial merges anyway, so punting on them should not
> be a big loss.  Falling back to --cc might be a usable alternative.
>
> >  * This option will not work on a read-only or full filesystem[2].
>
> OK.  I am not sure if it is worth doing the "temporary objects"
> trick, though---would it risk repository corruption if somebody is
> creating a new blob that happens to be identical to the one that is
> involved in the remerge operation at the same time, or there is no
> visibility of the temporary area to these "somebody" outside so
> there is no risk?

The temporary area is only used by the process running --remerge-diff,
so there's no risk of corruption.  If you have two `git log
--remerge-diff ...` processes running at the same time, they each have
their own temporary areas.
