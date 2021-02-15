Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD06C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 23:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D5664DD4
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 23:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhBOXuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 18:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBOXuB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 18:50:01 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37FBC061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 15:49:20 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 81so7984061qkf.4
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 15:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FWSHhcszUN79xUObmYHDADOkt4TDQs2jn23uDh5+Dwk=;
        b=ODpb11Ju71FNYTI1tkjosPEqnF8Ep7A3oNUfLsFlrP1XR3BO4MD2fRzksIMatp3W9K
         3hJ0JWzSUgx4vlzdb9jBJ7JrvRmKoLmu0FWHoHWb3ctXrecamtkJwo45Q2zJ+ER+bBwA
         zEqRY2NQqsI7ZQG1A2QrJivbjomzkKdke5LpiFvhag5OBcFVZU3dX/qQ4ULmw4dOEic9
         ZHgIGRptNTB6rRRnDcT6OcmO2DQPlUJtL7/wfC0BI/HGcvpkeOi1Aqyh3RQ8pE/dF0Rz
         0nYyqHAaNmVhHcDtMpj7t8NN3aKqchS844ZO5wAT05lMpJymUOsz4llU0rtvQclo99tn
         +Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FWSHhcszUN79xUObmYHDADOkt4TDQs2jn23uDh5+Dwk=;
        b=rxORqfRf/Zn1/NsOUBVk3r7z4VkxBZy7JcwVo8cDOUuWHaQjLjQWj+FVzzDDQ+ZMVQ
         lbO6y0QTZWwECxxJK9ET1DAFFXpYnpjqDYxP8sJ2O8hYOT0G5Pc8357mzM49TeYT+4Jx
         wd4/Uotth7biSiRXL827+7UOJVuES4p20cJxS0WuY+BodAu7YN5klj8bQz1nbYObX+4v
         dUL1NCISQVrNCGaZTpol1UvKRyC/eiKZ2xXsW8RTYMCgVsZqHj7/YEQIFGvbKKD8Gg3b
         3u/23r7qrMWI/OZJAu/ad5VxO+159vcTOmsNLbwndAAGuyoVHyxsKzCOGTBwfBfjG/xk
         pFZg==
X-Gm-Message-State: AOAM532c/JHk0JpG8fFr+xMiCMpu42ncJpxuJdhTN/F621Ri+geArDpI
        ik2qll3yHrq/4OsBXoSc3ljFGw==
X-Google-Smtp-Source: ABdhPJwNF6To5tnShhtPTWZrg4iBCn/6FQpTP6TZcwKP5xrOxGZG3sq2AeDEJ9cqtuLUZO9MtaxnHw==
X-Received: by 2002:a37:6116:: with SMTP id v22mr17548870qkb.38.1613432960128;
        Mon, 15 Feb 2021 15:49:20 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:c1ff:146e:b5:8cba])
        by smtp.gmail.com with ESMTPSA id m5sm10859868qtu.41.2021.02.15.15.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:49:19 -0800 (PST)
Date:   Mon, 15 Feb 2021 18:49:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, szeder.dev@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 4/4] builtin/multi-pack-index.c: split sub-commands
Message-ID: <YCsIfbgaA+NwHZOS@nand.local>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <cover.1613422804.git.me@ttaylorr.com>
 <16f33e41388ed431f70e09ef68717bd30fbee67f.1613422804.git.me@ttaylorr.com>
 <877dn9atew.fsf@evledraar.gmail.com>
 <YCr3DY5gawPC+G38@nand.local>
 <874kidapv7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kidapv7.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 12:11:08AM +0100, Ævar Arnfjörð Bjarmason wrote:
> > I split this into two patches: one to move the trace2_cmd_mode() calls
> > around, and another to replace the final 'die()' with the usage text.
>
> Thanks for picking it up.

Of course. This has been quite a fun digression :-).

> > Like I said in my review of your patches to the commit-graph builtin
> > here:
> >
> >     https://lore.kernel.org/git/YCrDGhIq7kU57p1s@nand.local/
> >
> > I don't find the 'if (argc && ...)' style more readable, so the second
> > patch looks like this instead:
>
> *Nod* FWIW (and this is getting way to nit-y) I don't disagree with you
> about the "argc &&" being not very readable,
>
> I just lean more on the side of getting rid of duplicate branches,
> you'll still need the if (!argc) usage(...) case above without that
> pattern, or some replacement for it.
>
> But we can have our cake (not re-check argc all the time) and eat it too
> (not copy/paste usage_with_options()). Isn't it beautiful?

Heh; I'm not sure that I'd call adding a goto "beautiful", but I
actually do find this one more readable. I dunno, honestly, I'm happy to
squash it in to the last commit on top, but honestly I don't really care
strongly one way or another ;).

> > Is it OK if I use your Signed-off-by on both of those two new patches?
>
> Yes please, should have included it to begin with.

Thanks, and no worries.

Thanks,
Taylor
