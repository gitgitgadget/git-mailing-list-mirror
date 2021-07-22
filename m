Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7ABC63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 11:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF2E61260
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 11:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhGVLGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhGVLGw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 07:06:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700ECC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 04:47:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ca14so6431931edb.2
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 04:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Ixeuir2m01ifIu2qgAfG5uo1WNsh7u8/a1ZP362XkA4=;
        b=UBmAaJWa1aWOWmh5dY2mix2v0F9jJBAUrYeyJFgbuqB01awbXHVdmDnvn+jUqb+9Nw
         hLf22d9fYJMz7jka8SfUSiyZwDHphRVF2TpW3tmyAZDPPsm97Brx3DpnGw5EG6bn/QgU
         tZsOtffHCergwaFBUyXiPxBbHSvQ77TQH/kkQWwevD5EMtJm9YZI1SwkdbtjO144Ft/R
         oW4Z1ncZAujxorloyWhY0JlL54puHZCv9VH7Y10bfT+jLSFowQetfrbeRoJfUuFUEIM0
         NOUxkPSvN1354zauHbEPBZVIO77KP/JK5LL6E6qPqr4kXhil2t+nz3JRwz09elyUOnpm
         Wnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Ixeuir2m01ifIu2qgAfG5uo1WNsh7u8/a1ZP362XkA4=;
        b=i9/KwQnv/yf7md03xrHKwyEv1uhAWmsLS8T835dvJ+RjpFnX+VL7pOEc1XBmmQxaGz
         CmKElfJL6no8v9x4iucp3Wc8x1uFme34MNUsmn4gPBWDJxIUnJDJGuRF9321LM6bnqrc
         489LE4koLVvuHN5oIFwd68+eUwDR1CW8bfax/Mhb/so3vkjIlGapjMIsRiYhYawfmQxs
         QsuEqu7UYZLp/PuAkik+Z0EIv6A/vsvra5rfaOUxITohSgGOfjA8OAGWTxf+ZCs49KC+
         QBuIAdegECqlNGPaHTr79Iwjz4q6+fF7Be9Qy67XAPm2+lz12zIQyNlQHH0ALVhbaEnl
         DIvg==
X-Gm-Message-State: AOAM531nr/Yzw3dxU0z1r4Q8XY4603Yp+1w19Km1IfzKtp7i9y6EapEv
        n+wB1KEU+5bXVj+wnouHQ3M=
X-Google-Smtp-Source: ABdhPJyz/n8KVdn0N4D8yxFifJxzYu6hqK3SeemJqW7bwKLc4OgdJz9gEnQd0UgQm9iBGkFIGl15xw==
X-Received: by 2002:a05:6402:2213:: with SMTP id cq19mr53870628edb.320.1626954445029;
        Thu, 22 Jul 2021 04:47:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j18sm9356316ejs.114.2021.07.22.04.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 04:47:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/3] bundle doc: elaborate on rev<->ref restriction
Date:   Thu, 22 Jul 2021 13:46:58 +0200
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210720T141611Z-avarab@gmail.com>
 <patch-3.3-6d66d4480ff-20210720T141611Z-avarab@gmail.com>
 <xmqqo8awhh5z.fsf@gitster.g>
 <68ea4cc0-b9d3-a7fb-7c22-fa828f9dc52f@iee.email>
 <xmqqim13eh9z.fsf@gitster.g>
 <27ad38c9-699e-0a9b-1bef-3c5d2950cd02@iee.email>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <27ad38c9-699e-0a9b-1bef-3c5d2950cd02@iee.email>
Message-ID: <87v952tvrz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Philip Oakley wrote:

> On 21/07/2021 17:57, Junio C Hamano wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>> Should the `list-heads` option be mentioned for investigating existing
>>> bundles?
>> I think 'list-heads' has been listed in the options section.  
>
> True, it's why I was suggesting pointing at that route for the extra
> details that are beyond just a set of refs.
>
>> I
>> however may encourage people to use "git ls-remote one.bndl" over
>> "git bundle list-heads one.bndl"---they do the same thing, no?
>
> It is good to provide both directions to the user. The formats may be
> different but the content is essentially the same, and redirecting users
> to the more core command is useful.
>

I'll work those suggestions into a future update of the docs I have
queued, but for now I think talking about list-heads v.s. ls-remote
doesn't have much directly to do with this particular series, correct?
