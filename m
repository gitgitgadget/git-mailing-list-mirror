Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C06CC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 06:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E655F613E4
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 06:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFCGbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 02:31:47 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:43626 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFCGbr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 02:31:47 -0400
Received: by mail-io1-f50.google.com with SMTP id k16so5131573ios.10
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 23:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=upMUHosu2WmBL2CFHs1Vyk3VF1gN+K3j6KpUQEzQe78=;
        b=QTQ11sm2luayTIc6IuZ5ZZ8oFveNF0fAbESmaBfn5mU7J7w8LmBpmqU55i6ci6Jv7S
         hWZm5bdNF8ZlVn2lDzofWcFedW1O/CzFfx+mM5t4hsfzofz9EZlJzD4WyCKcJsJElPbf
         QY2Ynw+NrAp0agLqPAYPxBdj7FjPNPt15gIraQOqqBoMeTAMFJWlMM22xnCtxhHbDXO4
         VuIT2n7RUvEccns6kHnSGCGH83b3mVYJ/B+Y3MwEceoaWcmScBX8/TKV0nMcsLEvfbrS
         +6pkvqKnIiZWp12sm6fpwrnt3NWR6kA/LoYi36Afjx3+5op9hRAShjEYjxl1B1VVWz+X
         PlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=upMUHosu2WmBL2CFHs1Vyk3VF1gN+K3j6KpUQEzQe78=;
        b=q+bpj9arHRWIOyZ6EJOtrvLa2NafOVmdJ25QYkxfkw6uVhmriB05OPofpuBBNztOUT
         /AKai5xvSdphTGk6uG0ly3elXwtM4awmoJy2eAArRmDpowQJHHRHMZJ3z2h7n30iLfFA
         fWnkkQ+EvWB3F9r9NzaThaE8dcjOjxVBlTa7OEuJJPqZ3Y6PU2iny0zHLbwT1SmPUodH
         XwL0CVSZcPimBrCLKJB3ua9IAxfrNGdCJRfLJxCUK/+ofiIqYZwugKM6rQaMGJx6uNMU
         K5NZAUGU4OrE+4Iewg47nFnA1DFlBBf1DLHlkLp0AG/bQOtojORGQYAxzBZ195crdyTT
         Gf+w==
X-Gm-Message-State: AOAM533yrh8BCgk+Ukj0v1adxGk7IScv8Qd2VKnioeGfUWK5Ofi3bgz2
        FRSxQl/xRbSmRNGxXfjfidZdYQ8+1GbWJqyz1CY=
X-Google-Smtp-Source: ABdhPJzii6enoBuDsrL675KppYEkpFEgSQ0newO9PtH7zQpnQxk/2UuVle88tb0mbFtFg9QE0ysTnAyf8VjPdlOOGPM=
X-Received: by 2002:a05:6638:144a:: with SMTP id l10mr18351887jad.50.1622701732497;
 Wed, 02 Jun 2021 23:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
 <495cd90dbaf43e957d03edd2fdc7449b39eee53a.1622558157.git.gitgitgadget@gmail.com>
 <YLZXyBJ5YgGfmkKv@coredump.intra.peff.net> <CAOLTT8SCeKy74cVO3K5zJ5n=0s=o9zk2ipV5wM6CHQPzRoMi5Q@mail.gmail.com>
 <YLfjexczp1/HILWj@coredump.intra.peff.net>
In-Reply-To: <YLfjexczp1/HILWj@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 3 Jun 2021 14:28:41 +0800
Message-ID: <CAOLTT8QHm5xXPJ2fb70f9gH2Hk2gjbAHCHyvm94KB5n1beCE8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] cat-file: fix --batch report changed-type bug
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B46=E6=9C=883=E6=97=A5=E5=91=
=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:01=E5=86=99=E9=81=93=EF=BC=9A
>
> I don't see any inaccuracies there. I do think we could explain it a bit
> more succinctly. I'll give my attempt, and then you can pick and choose
> which parts to include between ours. :)
>

Yes, you wrote it more concisely. I don't need to write out the details of
those variables. I just need to tell the reader the introduction of
skip_object_info will break the assumption of --batch that we have found
the object type.

>   Subject: cat-file: handle trivial --batch format with --batch-all-objec=
ts
>
>   The --batch code to print an object assumes we found out the type of
>   the object from calling oid_object_info_extended(). This is true for
>   the default format, but even in a custom format, we manually modify
>   the object_info struct to ask for the type.
>
>   This assumption was broken by 845de33a5b (cat-file: avoid noop calls
>   to sha1_object_info_extended, 2016-05-18). That commit skips the call
>   to oid_object_info_extended() entirely when --batch-all-objects is in
>   use, and the custom format does not include any placeholders that
>   require calling it.
>
>   This results in an error when we try to confirm that the type didn't
>   change:
>
>     $ git cat-file --batch=3Dbatman --batch-all-objects
>     batman
>     fatal: object 000023961a0c02d6e21dc51ea3484ff71abf1c74 changed type!?
>
>   and also has other subtle effects (e.g., we'd fail to stream a blob,
>   since we don't realize it's a blog in the first place).
>

s/blog/blob/

>   We can fix this by flipping the order of the setup. The check for "do
>   we need to get the object info" must come _after_ we've decided
>   whether we need to look up the type.
>
> -Peff

Thanks.
--
ZheNing Hu
