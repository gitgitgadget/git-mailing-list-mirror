Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA31C433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 18:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBD4610A7
	for <git@archiver.kernel.org>; Sun,  9 May 2021 18:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhEISr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 14:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhEISr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 14:47:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887E3C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 11:46:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x5so14284352wrv.13
        for <git@vger.kernel.org>; Sun, 09 May 2021 11:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BArTjYhJBH05d95w8TfUZ0TPrZ+CupBjl8QuYZ/4TSE=;
        b=PVS9v+HdNXRYTUKevdHQGX7i0n5qQYVNseoCl4uPQR2kS36PBwwMN3fRFhkOUuyl1T
         DuQN7O7fMpkPZoelT7pnGK4cWF+4nmEugygDPrnVkT6HTG3PDkHjMgeouafrYxEAXrfS
         SVq77ZJjH8HUQDtUJKYO5WhUMxc/JrmfPlx/D9v98WAHaVtlGPaVZJ6wwlYciAcyhbY+
         9cWZdj5JwNHky34sIrLT5K2CX1RY4k9JUfE9c2z6W+M2PISd9MKAad5S24ZeJEmRFOAL
         d3Smk/KAjnhnh3wBfdXHJskQ+ew+Gl1u3YWv2/jUjXgNzOR1LI/w0FD4v7U5ZoIaVdPv
         gFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BArTjYhJBH05d95w8TfUZ0TPrZ+CupBjl8QuYZ/4TSE=;
        b=QSgO67uaUM2Tjen81ObfCWweK1MoiLT5TQCNukugQDlpKG0hxVjNdjjteqP2MB6T61
         Nq9BHIhlJmm0Zwkcdbk+iunsw3aLGZHRavWI4XjTm0GVaNVOwQUy7iQLmWtXDOMBHWyd
         H/klX4Il7YQz40YaB1d+S7SXXCoILbDR+eXlbluBWX7+yz2Q77+bIcDGRpIQcNDuiTaH
         UQPUgRB477C9lIGM+a4i0Ln2D9toPUnWEhgMPdbvaT/eZclTZZFg737vwrvwa4j8/Qn+
         WHu4+HOf+xs7tPagIPCOewC0I29mc/p1/1Ld4TazcMK0gtTLIn7BVK7i2h92DTkiESR8
         ss3A==
X-Gm-Message-State: AOAM532HoGF+lKNhmrGHZZMOMaqkF7/fni6Spghtepnh6Qfzn/xVqHUL
        SjTli8IH/8pAZqZ7xcqd48upvRqJzi2wQFMyH6WR3wkgs2g=
X-Google-Smtp-Source: ABdhPJyKNNUGK1w84eAVRNB+tR8i24CdDVOFxUeRFieEwF3JI2MiDnEwgfVsM5wHQ6Ia5F6NBfEG+E/xxCYk5ToHeaQ=
X-Received: by 2002:a5d:638f:: with SMTP id p15mr26306802wru.255.1620586010270;
 Sun, 09 May 2021 11:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net> <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
In-Reply-To: <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 9 May 2021 13:46:39 -0500
Message-ID: <CAMP44s3wagd6pk-YfnYV3QoRbZ5cRA0MBU4=Mdxerbdx80J7hw@mail.gmail.com>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 9, 2021 at 3:26 AM Martin =C3=85gren <martin.agren@gmail.com> w=
rote:

> I think what I'm arguing for is
>
>   1) switch the default to asciidoctor,
>   2) enable optionally using it without xmlto,
>   3) figure out what broke and fix it, and document which is the minimum
>      asciidoctor version we're going to bother with for (2),
>   4) lather, rinse, repeat (3),
>   5) switch the default to not using xmlto,
>   6) drop the xmlto way of generating the manpages(?).

Are there some minimal requirements to say; this documentation was
built correctly (as far as we know)? If so, maybe we can add a
checker, or perhaps add a test under t/.

Cheers.

--=20
Felipe Contreras
