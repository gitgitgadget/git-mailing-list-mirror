Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BE8C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 13:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiGRNhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiGRNhF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 09:37:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2321A3B0
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:37:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id os14so21296975ejb.4
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=g7XMpxpqhGMN3V53kO3eOq2M11las+jbXPE2tamoyhw=;
        b=STHn4xlHh50inyi/KSQzCumvLLksZ3a1VX9q2Yahy1oHi9e5Zlgywb0ca8UL2EiANO
         VDmlvlVthjZicgVp1agLSbtf1nlyPQCgf2ianAx16YO+phPKK1g5XkCairoarGpl8RTk
         tReatVCO7puBsgYOt23q8XXyCviFo85PsWpV0veEVJbj5cOFNiE+pyovcYjk8oXiWKTl
         /QPl5MYF1E/9ebb5E4l0ajj2xYC/TlvkZiLnOP5tINcb2B5JCELZg9l4bplhKNmX2gNT
         pQZLMt3AvWhBOwM/m0AFxWVp+dyRYoKinQkDGUoIGkYz6Ht/VEbmf5xhWBLMiQ2mhhQw
         XDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=g7XMpxpqhGMN3V53kO3eOq2M11las+jbXPE2tamoyhw=;
        b=QBhXjVGCnRIprXm0xw5gdmqR533/zySxhfGAv9sv0eg/KGPr3riLcO9TTXbC2+wiIS
         ZYs8U+D/Bm0JoaeGBTx2ItHnzWCa+CH8JyNzOzIEVB8VkJ8KX18MpC2hxzMlqOfgigIK
         1k+94xpOkmqcdB12EQgsIh04zhLq1RVgH2c9u6mc7bUGeQECRJk9gKQgHRChTcXKQckn
         wvRHiqmVnS6cA/3La7Vc5eejIl3gmgkXSQbicDphzZK+cBcNO497VILEij6Gte7EkhX8
         B37JiwZuY5mEHSvhL6dK8mfxRFMWzH2P04pp51Vbph5U+tMCJ1oivwBQGEFpfpFl0B5Q
         6pgw==
X-Gm-Message-State: AJIora8g1KMw1U9UfglXveWAfZsy0aZKoy5jxkCgq2z4kh44r/yJHOFt
        r/bG7kBtru8CH2qMMxYx+/Ra+UU4RZOrOQ==
X-Google-Smtp-Source: AGRyM1uRL4Q8f++nS5vb0P/GdAFUh0dRMS0t5qANL+GHHiXR/3L5WHsvmL/9VsVc2M8YVHY27VBCPw==
X-Received: by 2002:a17:907:1dda:b0:72b:31e2:905e with SMTP id og26-20020a1709071dda00b0072b31e2905emr26059946ejc.183.1658151422798;
        Mon, 18 Jul 2022 06:37:02 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ky25-20020a170907779900b0072f112a6ad2sm3308359ejc.97.2022.07.18.06.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:37:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDQvl-0039Q3-OE;
        Mon, 18 Jul 2022 15:37:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] index-format.txt: remove outdated list of supported
 extensions
Date:   Mon, 18 Jul 2022 15:35:24 +0200
References: <20220718085640.7395-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220718085640.7395-1-szeder.dev@gmail.com>
Message-ID: <220718.86cze2y22q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, SZEDER G=C3=A1bor wrote:

> The first section of 'Documentation/technical/index-format.txt'
> mentions that "Git currently supports cache tree and resolve undo
> extensions", but then goes on, and in the "Extensions" section
> describes not only these two, but six other extensions [1].
>
> Remove this sentence, as it's misleading about the status of all those
> other extensions.
>
> Alternatively we could keep that sentence and update the list of
> extensions, but that might well lead to a recurring issue, because
> apparently this list is never updated when a new index extension is
> added.
>
> [1] Split index, untracked cache, FS monitor cache, end of index
>     entry, index entry offset table and sparse directory entries.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  Documentation/technical/index-format.txt | 2 --
>  1 file changed, 2 deletions(-)

Note that there's a conflict with my series to move this to
gitformat-index(5), although the conflict is easily solved:
https://lore.kernel.org/git/patch-v4-6.8-858ce9c6999-20220718T132911Z-avara=
b@gmail.com/

> diff --git a/Documentation/technical/index-format.txt b/Documentation/tec=
hnical/index-format.txt
> index 65da0daaa5..f691c20ab0 100644
> --- a/Documentation/technical/index-format.txt
> +++ b/Documentation/technical/index-format.txt
> @@ -26,8 +26,6 @@ Git index format
>       Extensions are identified by signature. Optional extensions can
>       be ignored if Git does not understand them.
>=20=20
> -     Git currently supports cache tree and resolve undo extensions.
> -
>       4-byte extension signature. If the first byte is 'A'..'Z' the
>       extension is optional and can be ignored.

I wonder if we should instead say : git currently supports various index
extensions, see <asciidoc syntax to link to section below>.
