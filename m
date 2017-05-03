Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00146207D6
	for <e@80x24.org>; Wed,  3 May 2017 09:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbdECJqh (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 05:46:37 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34303 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752355AbdECJqf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 05:46:35 -0400
Received: by mail-oi0-f65.google.com with SMTP id w10so5463692oif.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TB3ovdUaQGN09JDEIZufZ74+BnAs/5tYsAhwNiKDKnw=;
        b=YpUXHFB1N4E72PC6ce6oVyou0Ly0IGEXBAm2pAt6OSjisIwJSWNIKBYSzhOe/1fx5o
         fIALiDf6XkAr+cNS4Qa/JyQUTY8QWhULRyPrgDaMnRQOCEC4TYRYTwfD3XK6hzTl3acu
         +9dZrhfRAEuIfVsGIJu1XY/iLnWXJx3nFNWS9cbuhZj5m4+2FVdEDAFARJn0UtWSnJ/7
         FGT4IGlzK2sKbvfE8gsliJLhLs6yol0BPsxdWNqh/viHOfIb78yssJvk1FazeXgIb7Fy
         urVBXaQmRprtlyYmmEz5hwABfPrkfwUa3NXHWfL8Gz8LNIyTFvz2ujx4jLjy6YnH7e2e
         whZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TB3ovdUaQGN09JDEIZufZ74+BnAs/5tYsAhwNiKDKnw=;
        b=h29snZVXmfi5gde3sDXZK0s1GVkNlSWmILgpoGUIzm2dEQLomLKPJbINMppEsGiXDw
         qBFOa0UPBu3X+jgzFXlK8iJOgzQex47gv2Xoy7TytoWTk/0Dzh7Hz+3Sg2P08pKXUq2b
         dIN4rCATBsNJjdDjm+AyokP7gjJBfENIi4M7Xk9amk3rIEGbsTVsbqWQgztndtyZbGG3
         BgW9/pfTd/XPbcvQJ/XriuiOnQ4js2K0Xrr2+uSLleaPgwUggxm/T2qD2hJcl9zk6c4x
         3VjnhKZ9aavkNuE5t0tCI3aDHY0GePZmWrx/ynJ7d+wktSHfxGuMboqd6lITakWJS5NA
         f0Hg==
X-Gm-Message-State: AN3rC/7XjDj7EvxchMIBtsn71sJuRvsUvvD0C0rXIqWitTJMgFwG+8Ca
        uHReTXC9YJPDWMbbq5nVn1MRsYNrbA==
X-Received: by 10.202.84.205 with SMTP id i196mr6232037oib.145.1493804795151;
 Wed, 03 May 2017 02:46:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.145.140 with HTTP; Wed, 3 May 2017 02:46:04 -0700 (PDT)
In-Reply-To: <20170501192212.xy5o72tinb2hy2a3@sigill.intra.peff.net>
References: <20170421184617.lc5bioa5px6ninrj@sigill.intra.peff.net>
 <CACsJy8AAtV5KJHBqWvnYb3Mw9CVzEdG3M-UJA+jd5MR5e-UMsA@mail.gmail.com>
 <12c3312c-30a1-2cb1-8f05-63bb663bd0a0@web.de> <20170501192212.xy5o72tinb2hy2a3@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 3 May 2017 16:46:04 +0700
Message-ID: <CACsJy8CdjLySD+UEKE2NkbYqEoVOQtvydFBui6UbbnFLo8U1Ug@mail.gmail.com>
Subject: Re: [PATCH] cache-tree: reject entries with null sha1
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 2:22 AM, Jeff King <peff@peff.net> wrote:
> On Mon, May 01, 2017 at 01:23:28PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Am 24.04.2017 um 12:39 schrieb Duy Nguyen:
>> > BTW, I ran t7009 with valgrind and it reported this. Is it something
>> > we should be worried about? I vaguely recall you're doing something
>> > with prio-queue...
>> >
>> > =3D=3D4246=3D=3D Source and destination overlap in memcpy(0x5952990, 0=
x5952990, 16)
>> > =3D=3D4246=3D=3D    at 0x4C2EACD: memcpy@@GLIBC_2.14 (in
>> > /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>> > =3D=3D4246=3D=3D    by 0x545D05: swap (prio-queue.c:15)
>> > =3D=3D4246=3D=3D    by 0x545D72: prio_queue_reverse (prio-queue.c:25)
>> > =3D=3D4246=3D=3D    by 0x4CBC0C: sort_in_topological_order (commit.c:7=
23)
>> > =3D=3D4246=3D=3D    by 0x574C97: prepare_revision_walk (revision.c:285=
8)
>> > =3D=3D4246=3D=3D    by 0x48A2BA: cmd_rev_list (rev-list.c:385)
>> > =3D=3D4246=3D=3D    by 0x405A6F: run_builtin (git.c:371)
>> > =3D=3D4246=3D=3D    by 0x405CDC: handle_builtin (git.c:572)
>> > =3D=3D4246=3D=3D    by 0x405E51: run_argv (git.c:624)
>> > =3D=3D4246=3D=3D    by 0x405FF3: cmd_main (git.c:701)
>> > =3D=3D4246=3D=3D    by 0x4A48CE: main (common-main.c:43)
>>
>> I can only get gcc and clang to call memcpy instead of inlining it by
>> specifying -fno-builtin.  Do you use that option?  If yes, why?  (Just
>> curious.)
>
> I do my normal edit-compile cycles with -O0 because it's fast, and
> because it makes debugging much easier.

Same here. My CFLAGS (without lots of -Wstuff)

CFLAGS =3D  -g -O0 -fstack-protector

Maybe it's -fstack-protector then? This is gcc 4.9.3. I think Gentoo
does not add any distro-specific patches on this particular version.
--=20
Duy
