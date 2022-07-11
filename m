Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90246C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 11:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiGKLYv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiGKLYe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 07:24:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D36620BF3
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:53:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id va17so8211687ejb.0
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jEqllwLx3byvrSm3RAVZxel5iYUOUUGGVsNHITyoAek=;
        b=eydMokrg2A2y1tXxEgBa9TtSdPl2728E7TOdvhaDWL93ppUKSV3xE7Zg/C2aPzZK1D
         EFXu1dK/htjzzzZXPe5bB8o0o+mOS8jedxkNxefbT3bChvMRWFymAl+7yMZB1M+HN78R
         bhFsL4Roy5lzHzW5M7RFCBd5iKLUbUEIlPhbDimrVGsYRQysJcRcv0ecmIr0ZWYAM+TE
         Pb1i1CFkXmBOcJu36kUQ3rKSaapK7DXWXY62PCVkcCRo+Sr5vKe6hUEH+X9sws7jiSN+
         /aitpdDHiTH5ISaWANq141JcHERWHeM3xA1hhLz9Tf7QdltzuQmn7v96a/dw8HxnQ1Yn
         YhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jEqllwLx3byvrSm3RAVZxel5iYUOUUGGVsNHITyoAek=;
        b=sVVTSE4EJjsg3qbUS/+6WDlZEUHHlwnf9vJWIYmlV4VXb5Rx7XQdOn0TPVrglwi0wp
         MZICn8gS9EA9/gd/CuM8tInrPdd0bfpCvHjZNtM7BO01XBeQUvcUxTMKZntvwJGB//L2
         hm23/0tSnHkaeRSziLjCZPXgn0gG1WsZ0Rvjm+4AHBuga11wi5HdVutC6FFiAvV+indH
         Z+p5/s2S+ES4XWFuiEyQJOwFihMzrnLQGWaQCVR06fi2sXdp8LRrahPXrdsdycq0oYCH
         RmSKtUN/rr21pmzCZfOk3gtBOUuKLFhffqC5rRKBqr78yeDBoLlZy8TP5mTGoTCXMqJv
         nJag==
X-Gm-Message-State: AJIora/TcYHOKPITPbmdVfTWoUCMHOQCNGyYRaJAsLDAZxcg/IEB/Xv3
        9wXKpf45CYPeZINeEW9metQ=
X-Google-Smtp-Source: AGRyM1sXkjptvFNvrOXazHpQBrDUGtBDKIFfVcr0iT2RvyVueaPuShNiouw9pqfBm0tEvoNV2PdDhA==
X-Received: by 2002:a17:907:2723:b0:72b:5af3:5a11 with SMTP id d3-20020a170907272300b0072b5af35a11mr3190193ejl.584.1657536829125;
        Mon, 11 Jul 2022 03:53:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ej24-20020a056402369800b00438a13508c4sm4113457edb.51.2022.07.11.03.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:53:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAr2x-000myl-98;
        Mon, 11 Jul 2022 12:53:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/7] xdiff: use GALLOC_GROW(), not XDL_ALLOC_GROW()
Date:   Mon, 11 Jul 2022 12:48:47 +0200
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-5.7-3665576576f-20220708T140354Z-avarab@gmail.com>
 <c2bc5c79-e71b-f9dc-ba97-261d3454e150@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <c2bc5c79-e71b-f9dc-ba97-261d3454e150@gmail.com>
Message-ID: <220711.861qur9ays.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 08/07/2022 15:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Replace the recently introduced XDL_ALLOC_GROW() with invocations of
>> the GALLOC_GROW() from git-shared-util.h.
>> As this change shows the macro + function indirection of
>> XDL_ALLOC_GROW() is something we needed only because the two callsites
>> we used it in wanted to use it as an expression, and we thus had to
>> pass the "sizeof" down.
>> Let's just check the value afterwards instead, which allows us to
>> use
>> the shared macro, we can also remove xdl_reallo(), this was its last
>> user.
>
> I don't think this expression->statement change is an
> improvement.

I think the use-as-statement is prettier too, but I think the uglyness
of having to pass down the sizeof() & re-implementing the macro version
of the alloc-or-die variant outweights that.

> This change also removes the overflow checks that are
> present in XDL_ALLOC_GROW()[...]

We end up calling st_mult(), which does that overflow check. Do you mean
that the POC shimmy layer I showed in another reply for libgit2 doesn't
have an st_mult() that detects overflows?

That's true, but as noted downthread of that we can & could ship that as
part of the shimmy layer, but that's unrelated to this change.

In your pre-image you use LONG_MAX instead of UINTMAX_MAX & I don't see
(but maybe I haven't looked at it carefully enough) how it does the same
dying on overflows. Doesn't it just fall back to LONG_MAX?

Part of this is that it's not clear to me from your commit(s) why you
need to rewrite alloc_nr() and rewrite (or drop?) st_mult().

> and fails to free the old allocation when
> realloc() fails. It is not a like for like replacement.

Yes, we should have a free() there. Wel spotted. But again, doing that
as part of the "gently" branch seems preferrable to have duplicate
versions for expression (non-fatal) v.s. statement (fatal) variants.
