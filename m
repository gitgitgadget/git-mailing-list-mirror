Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DE1C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 13:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0737D61430
	for <git@archiver.kernel.org>; Mon, 10 May 2021 13:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhEJNmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 09:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240406AbhEJNAV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 09:00:21 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B407AC06123B
        for <git@vger.kernel.org>; Mon, 10 May 2021 05:51:26 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a11so14636180ioo.0
        for <git@vger.kernel.org>; Mon, 10 May 2021 05:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wc/Gsw9D+rs9dx0lulqtXRFPHDGWHdyFL2sZQJ/i6/I=;
        b=L+9N1yvBFRIl6XJGi73EMXz1coqaepiaSiMgEQGYJJevGb8J+l7wXNEpvd74o+qYKq
         PSfYUT7J8VwEyrmlp3AWEj0Jj4xbqviwJrHNBRuEKCx5YYF23dRdceg8ObUjRgwbgamH
         8LDOb8l3fZiAUF7OEEvnBy1BRmkCZPN6oZQFAiwaqdb+rb4rizpQTswrnb20wiZ/brFk
         THAqP4Z3GpLffEDItd+yZOZcsKu5tCKsIO6IOm/adEGZTVf9BUi6thGqwElHq4h3Z1OM
         YIztK5wsD1dLWQMNFGoP5NSStp9zywmuqedDHAPayf8ePLOI3aXspnYvkSct5ROCXPr4
         M2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wc/Gsw9D+rs9dx0lulqtXRFPHDGWHdyFL2sZQJ/i6/I=;
        b=rQ8O2hnebUH7FbrhyluPW0kmVupPk7/xGn1S/nRLar5Uu5hCaGkEYNoA3dNtiDCIwg
         Y0BUoZ09u1doVbKm9G4OTImEAgV40gJa1lI2pe5YIBYUsOORNeKNLjSWr4EPAgX0il1b
         m1B3GLjhw3f/RVpN5PSoiTC2Cr1MALEJTv2HRJLQTmOJHDgonK/RMWl/YwLtk9FVqEds
         zsE/DmICLhOG/QSPR9TJfsaV4/OB/+Wjb0GkXBNRBwovbchzL1mqHBaRaY54mDVS0U1n
         txHcs3P1QyFQCcd720Gyqe71KgSNe2U3o9vcitwUJmn6ba5Mnj3ERfP6Wl1kXSXiIg7F
         TyKA==
X-Gm-Message-State: AOAM531hotriWqnxKylgomNIF2cDnWXr9M/ztpvRlnNi+BTPXANIO3bK
        W0Jdh/dd23Mk4coJE9ynYABwJdJb7jixXmUnmQc=
X-Google-Smtp-Source: ABdhPJxQvF5o+MWDVQ6tCABWEIUn9loQIcNJb7NB0enqfOPEocDn5RkL9IgoNSR7zC36teYlkHbJYerw3JCAZ7Gyvw0=
X-Received: by 2002:a05:6638:2410:: with SMTP id z16mr21594734jat.130.1620651086188;
 Mon, 10 May 2021 05:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.949.v2.git.1620318676776.gitgitgadget@gmail.com>
 <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com> <xmqqcztzqc9j.fsf@gitster.g>
In-Reply-To: <xmqqcztzqc9j.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 10 May 2021 20:51:10 +0800
Message-ID: <CAOLTT8R3ys5ohujVRKiQa3vijrzdGzLThU5hsG-estiyUgOqhQ@mail.gmail.com>
Subject: Re: [PATCH v3] [GSOC] ref-filter: fix read invalid union member bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Just a final sanity check.  Is this a recent breakage or was the
> code introduced at cc72385f (for-each-ref: let upstream/push
> optionally report the remote name, 2017-10-05) broken from the
> beginning?
>

Well, The trigger condition is very special, but the bug was introduced
at that time. Let's see the "bug" example below.

> I am wondering if it is easy to add a test to cover the codepath
> that is affected by this change.
>
> Thanks.
>

Well, because this bug must require that the seventeenth bit of
`used_atom.u` is not 0, it took me a long time to find this bug.
in `used_atom.u`, only the member "color" and "contents" which
size is bigger than 17 bytes, but "%(contents:trailer:only)" only fill
the 16th byte of `used_atom.u`.

"Fortunately", I found it.

git for-each-ref --format='%(color:#aa22ac)'

I will add test for it!

Thanks!
--
ZheNing Hu
