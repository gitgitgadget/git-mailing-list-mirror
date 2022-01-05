Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D3CC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 16:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbiAEQpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 11:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiAEQpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 11:45:09 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B19C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 08:45:09 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id o63so70135074uao.5
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 08:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ez8+O9mjGAXYlCrHYqlr9SHZkJUeUvB2lFkGwvEBSQw=;
        b=XcVpYiFOcQU1xpOGzIaq74mF7N+WMNhx5O9npcBo2bTydKAVCRDYJq2mQ8k81WUzME
         yvdNRnVZzuIt/EO7BgfvoLU1FyuVPivGJYj1bh6rWbQpnYbqNykoM9ez9eTlx6aolU7H
         F/dsMb5LsDr6Eww/V1NQ3OtPFHqKrh5xsMgeprisCsGwkAGv5YLINQGCUq5+PJWZSdc7
         LFzEUfVSAHB4jTLdCmgPcZYcnWiqwKGNHlMaIqgmxH2RKMiDTssHUUShIbkElwV98C+o
         VF07apwAo+iTm7XIQLSv0RdvChkk7sTLze9p4iLceXrL41yxyVT1bQH8ZmxZQ86FA/G8
         U8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ez8+O9mjGAXYlCrHYqlr9SHZkJUeUvB2lFkGwvEBSQw=;
        b=GrtFW0Et5SqXk/PXlYt+peqKm7UeyidFJDiZq2wI17oze4cWZWJS3WJXKEYwE9oHCW
         AXNAimpvbtvmJE3GRGufxo6TrcFJepo5ubtpJSPrLFrLXlaqjyLSu8gB2ThptzrqO9Vy
         TQ/Wc0uCAR0pvy9+3yad7tQSjKvFACW39yhCWs6fHJbZ2k47anzj6okBxEnLsoB+nJmr
         qn8ALNX5bhPBDwuKCiuHG5ueojqlsEFr4HpjpShDCJ2U7v36/gS6nVteSKV9k0ulJ/JJ
         5Ltnd//B9onq1oRAFk/EozKQRtVTTiOpJgffQMIWohsD8nPH6mlUynUlqAJKArj36+IZ
         jk6g==
X-Gm-Message-State: AOAM5320fwYgbLHjgJckYXzBayraZrFzIy33oslLGe1a2anv0s3LmIDD
        1FRJkLuZGiOFwigCqzeifMKwYPi0B90/o46bdoM=
X-Google-Smtp-Source: ABdhPJy0k0UGuzr6Wuj4wHTsPNo3fYgUO/sQ/vzUvDpsMrYawRgdC5u591sGgahROeMZKtbuNct67V+b0qZyM/oSY7s=
X-Received: by 2002:a05:6102:6d1:: with SMTP id m17mr15660114vsg.8.1641401108280;
 Wed, 05 Jan 2022 08:45:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641043500.git.dyroneteng@gmail.com> <e0add802fbbabde7e7b3743127b2d4047f1ce760.1641043500.git.dyroneteng@gmail.com>
 <nycvar.QRO.7.76.6.2201041533540.7076@tvgsbejvaqbjf.bet> <CADMgQSSjoxqzBDyGXiNC4wHqYGK7z4O0SG0zai85D-DtDHem=w@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201051348050.7076@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201051348050.7076@tvgsbejvaqbjf.bet>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Thu, 6 Jan 2022 00:44:56 +0800
Message-ID: <CADMgQSRxko6nC0zfDiVVfL2ZkdQVbBq0s59Er+6Nmg9vz4uJKQ@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] ls-tree.c: introduce "--format" option
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 9:09 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Ah. I misremembered and thought that `"% 7s"` would do that, but you're
> correct. See below for more on this.
>
> But first, I wonder why the test suite passes with the `strbuf_addstr()`
> call... Is this line not covered by any test case?

Definitely, me too.

> About the `%7s` thing: The most obvious resolution is to use `"      -"`
> with `strbuf_addstr()`. And I would argue that this is the best
> resolution.

I agree that's a quick fix in that way.
Can you feed me more info about why you think it's the best
resolution?

> If you disagree (and want to spin up a full `sprintf()` every time, just
> to add those six space characters), feel free to integrate the following
> into your patch series:
>
> -- snip --
> From a390fcf7eec261c7f0e341bda79f2b1f326d151e Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Wed, 5 Jan 2022 14:02:19 +0100
> Subject: [PATCH] cocci: allow padding with `strbuf_addf()`
>
> A convenient way to pad strings is to use something like
> `strbuf_addf(&buf, "%20s", "Hello, world!")`.
>
> However, the Coccinelle rule that forbids a format `"%s"` with a
> constant string argument cast too wide a net, and also forbade such
> padding.
>
> Let's be a bit stricter in that Coccinelle rule.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/coccinelle/strbuf.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.=
cocci
> index d9ada69b432..2d6e0f58fc8 100644
> --- a/contrib/coccinelle/strbuf.cocci
> +++ b/contrib/coccinelle/strbuf.cocci
> @@ -44,7 +44,7 @@ struct strbuf *SBP;
>
>  @@
>  expression E1, E2;
> -format F =3D~ "s";
> +format F =3D~ "^s$";
>  @@
>  - strbuf_addf(E1, "%@F@", E2);
>  + strbuf_addstr(E1, E2);
> --
> 2.33.0.windows.2
> -- snap --

I appreciate the input of 'coccinelle' and the commit.

The current relevant rules of 'strbuf' was added in commit [1], the
purpose of it
seems like to forbid some inefficient use cases and chase the performance
profit as much as possible.

I think "<SP*6>-" and "%7s", they both with the same result, the former
benefits in performance, the later benefits in readability. So let's do a s=
imple
performance test under "linux", then think about which is better for this c=
ase:

    Benchmark 1: /opt/git/ls-tree-oid-only-addf/bin/git ls-tree -r
--format=3D'> %(mode) %(type) %(object) %(size:padded)%x09%(file)'  HEAD
    Time (mean =C2=B1 =CF=83):     387.7 ms =C2=B1   8.8 ms    [User: 357.6=
 ms,
System: 30.0 ms]
    Range (min =E2=80=A6 max):   377.5 ms =E2=80=A6 399.5 ms    10 runs

    Benchmark 1: /opt/git/ls-tree-oid-only-addstr/bin/git ls-tree -r
--format=3D'> %(mode) %(type) %(object) %(size:padded)%x09%(file)'  HEAD
    Time (mean =C2=B1 =CF=83):     388.9 ms =C2=B1   9.0 ms    [User: 362.7=
 ms,
System: 26.1 ms]
    Range (min =E2=80=A6 max):   373.4 ms =E2=80=A6 399.8 ms    10 runs

It's with a slight performance difference between the two.

So, I decided to integrate your patch as a new commit in the current
patchset and
is it ok for me to mention it's from your guidance in the commit message or
a "helped-by" something like this?

Thanks.

[1] https://github.com/git/git/commit/28c23cd4c3902449aff72cb9a4a703220be0d=
6ac
