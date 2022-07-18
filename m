Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3DDC433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 18:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiGRSt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 14:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGRSt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 14:49:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8C92CDF8
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 11:49:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m13so6413764edc.5
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QB6C6UaHYTygNoOusGz48kX1vGK7P52h8v3HxUQ8Yz0=;
        b=XeYzJlN3uRVbSGcWOAl/Zy7EEko6Ss2cj1lvat7/jWIPfXNcZp/U4FHNFSm9C0j2JH
         vxG93jUlLnIys5/DtdSRNZLNPm9eHmEU91RNl1g6YT8jvB+tFlwhZtSvwJbMAC36OM18
         Ffb4qlDxH9iVX/1VYQ+gbAUQSlDVu7ZxT43o/f+x5J03b3pCbGWvMuzf9irdvT9qmilw
         Ldd+KbJ6LVmnxp5RunQFVSezG0aDDn7QS52g9mvU/V/54JUmSb4vV1ZGba+V3TqjeHgg
         w0A6U8JlnY3J51tOfGxwPTAsP73oK8pfxbRBpOkoyP4vrQPbDNDuhBiTvy0O+lZC93+K
         Fiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QB6C6UaHYTygNoOusGz48kX1vGK7P52h8v3HxUQ8Yz0=;
        b=oJbuikHp5m0DvhjFuAz0Qh/Vn+CDsT8rp44FePomLbBIg7Z2z/Xv+M96vngCy5PFn4
         r4KWHm6z8Qb4xaU/Tm/23dgFZ+uGt5R5FIFIGo1Z6iLeqUt5OxxU8nQYdxYpI8iuAWIN
         TXz2XYoSVZkkww6h1+1Sucl8r/OOzsOQONSjAzhVS+HNPoIH/gPf7egHe4dg/rqDDLg6
         YCyc4+8ZkGjYo2EW70VoPXJMkjR93YxR5vsBMrx3vNq1pUvbHJHWjFYwNWaLcqRc723i
         vomqJdqi6lmf7dS7wpFokRWQWDHjuKh6/8jECzhuXPWmGq1uVkjZfWpCYlujRULn4LlA
         gF2Q==
X-Gm-Message-State: AJIora8kALrDXUq40/qWotbnOflMhh2Q6NH0zbXR3f1ee5apbjrGkz2S
        lVADXZj3pqVCwAx0Dt++72U=
X-Google-Smtp-Source: AGRyM1vz4KQankczZ7ap54wYcI7d5PSU3xfxbxkWhk0+KJg28MLAYAMIXj/SFTOaQEvKggorsDEHSw==
X-Received: by 2002:a05:6402:1d54:b0:43b:1795:d3c with SMTP id dz20-20020a0564021d5400b0043b17950d3cmr34987308edb.236.1658170194372;
        Mon, 18 Jul 2022 11:49:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7de9a000000b0043a7293a03dsm9017059edv.7.2022.07.18.11.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 11:49:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDVoW-003JzE-Be;
        Mon, 18 Jul 2022 20:49:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v4 2/8] git docs: split "User-facing file formats" off
 from "Guides"
Date:   Mon, 18 Jul 2022 20:41:39 +0200
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
 <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
 <patch-v4-2.8-883c483d4e7-20220718T132911Z-avarab@gmail.com>
 <xmqqlesqqr1v.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqlesqqr1v.fsf@gitster.g>
Message-ID: <220718.86mtd6w90v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> We take a wide view of what's considered a "user format", it's not
>> just a file format, but e.g. githooks(5) also belongs, since the
>> layout of the ".git/hooks/" and the placement of hooks in it is
>> something the user might be expected to interact with.
>
> I am afraid it is a bit big a stretch.  Other documents that fall
> into the user-format category all have "format" the users must
> follow while writing the "contents" in the file.  ".gitignore" has
> certain format and syntax and the document describes what effect the
> file has, based on the contents of the file that follows the syntax.
>
> A hook can be written in any language, even though our UNIX lineage
> makes our samples all in written in the shell, so there is no
> "format" for the users to follow that we should force upon them.

The "format" I have in mind is the "shape" of the configuration,
i.e. that a hook goes in .git/hooks/<name>, not the contents of that
<name> itself.

So it's introducing a bit of a neologism, but I couldn't think of a
better one. Suggestions welcome. There is "gitrepository-layout(5)", but
calling this a "layout" seems odd.

I do think that things that users are expected to interact with on a
file-level (gitignore, gitmailmap etc.) and on the FS arrange in such a
way as to interact with git (gitignore) belong together under one hat.

So it's not perfect, but I think it sucks less than calling both
"gitmodules" and "giteverday" a "guide", which is the status quo.

> If we can come up with a word that is more appropriate than
> "format", it would be great.  If we do not place too much emphasis
> on "format", I agree that both "gitignore" and "githook" fall into
> the same category, because they define how the contents written in
> these files affect the operation of Git commands.

*nod*, another word would be most welcome :)

I do think that if we have --user-formats or --user-X it makes sense to
have to have that match the --git-X. I.e. the "format" of say the
commit-graph includes how we arrange those files on disk, just as is the
case with the hoks.

>> -With no options and no '<command>' or '<guide>' given, the synopsis of =
the 'git'
>> +With no options and no '<command>', '<guide>' or '<doc>' given, the syn=
opsis of the 'git'
>
> At some point, we will have enough <doc> that it would probably
> become meaningless to treat <guide> as a separate class, no?
> Guides, user-supplied customization files, and implementation
> details of on-disk files that may help reimplementations of Git, all
> will become <doc>.

Maybe I should just use <name> here?
