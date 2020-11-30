Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22346C64E7B
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 16:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9D720789
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 16:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5S5oa7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgK3Q5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 11:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbgK3Q5i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 11:57:38 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B6BC0613D2
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 08:56:58 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id y74so14850891oia.11
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 08:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cGId0xLNGi2YsyrWGE6qsp5smDwZBaApN8q+/nBF9DQ=;
        b=k5S5oa7hhCJ553keovtjy41vEJ2E+KeIPgpb8BNFtu2IkXSfXvLTKcW2Q57Jr+8jrQ
         y10Taftn+DMahKvwgRF+rZZGEYMXeXxLvCt1ocv7qvgW9Mpam2JXwSjWj48fbvZjuVNr
         MfEfI74V6/M4L6uzRV/szjQK1nTkxtAjoKb6xmx/ywTAwns1wAoMfI1PM/61vqSMVAoq
         xyTTgMTh/xzsj1qmPxaKLU9pDg1vGf3Rm7tRrcSZ+kPvNRFwlTZRu556QmDHTkYZaVSa
         VGC3kAFg7dujjaxMzFlvlPh086HSPem2xcwf/KS1DKhIjf1AWBcXWrxPn3PrSfUk2QmO
         y66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cGId0xLNGi2YsyrWGE6qsp5smDwZBaApN8q+/nBF9DQ=;
        b=NA9e2Sh4Ej8KmQygJkf2cbgH+DXg298y9qB6y4eVDf844oHDLw7Qa9MnXqjRZMz/W6
         mRIQGdLYTUQP1BYKJ3m5J/jA2Uux9RYeIkiTdix+t8UEMtVooYgNgcXX9ohgEolXBw0A
         yoRHtOZkzdriZAFswgavhOiIaZ6XYhmBykA3hWWWa0XfSQrbBLSZO/eY+eKbOesbQbnu
         LYV94dDzLLgHPVkAtBzhS+wD1NSKDVui4vdq9pMzbJJ6br8sdAoElYF63Fad3HpEZDAq
         J+fbCTAWeL43fh2MSBBtPxBwZhB7mR0zsCdL10JJVd9T+nPAmU9VsQnI2YjiqtdCB7wu
         VL9w==
X-Gm-Message-State: AOAM533UP0wainELEL/aaPOfLqJk3CoyRXQ2nPhiPLmm+lsHaSlOVyZQ
        sLq26jXYhRoSC0yIncW8rKUsP9BENMM5wAMpUtQ=
X-Google-Smtp-Source: ABdhPJxoP4lCRcpL8L7U8mX38GIQ8KmNEdElfxnep2zLDLzzncIgV3uXeGQsrBLFKV/01jueEIXqMrg0zqHvlzArqG4=
X-Received: by 2002:aca:49d5:: with SMTP id w204mr15139814oia.167.1606755417799;
 Mon, 30 Nov 2020 08:56:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
 <91516799e46ebbc91fb6b1811164fe7c9a15a3ad.1606635803.git.gitgitgadget@gmail.com>
 <87im9ojwbd.fsf@evledraar.gmail.com>
In-Reply-To: <87im9ojwbd.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 30 Nov 2020 08:56:46 -0800
Message-ID: <CABPp-BGEL1mTgfa8KzD=r+3UwUikU6ZyCSfxgpbanNuqmrzGqw@mail.gmail.com>
Subject: Re: [PATCH 05/20] merge-ort: add an err() function similar to one
 from merge-recursive
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 29, 2020 at 2:23 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Nov 29 2020, Elijah Newren via GitGitGadget wrote:
>
> >  static int collect_merge_info(struct merge_options *opt,
> >                             struct tree *merge_base,
> >                             struct tree *side1,
> >                             struct tree *side2)
> >  {
> > +     /* TODO: Implement this using traverse_trees() */
> >       die("Not yet implemented.");
> >  }
> >
>
> Looks like this doesn't belong in this patch & should instead be
> squashed into "[PATCH 02/20] merge-ort: add some high-level algorithm
> structure".

Indeed, and Derrick pointed out the same thing but when I went back
through all the emails to try to make sure I covered everything, I
somehow missed that particular piece of his comments.  Anyway, I've
fixed it up locally along with your two other suggestions.  I'll wait
a bit more for other feedback before sending the next re-roll.

Thanks for taking a look!
