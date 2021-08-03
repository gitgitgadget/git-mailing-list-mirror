Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE7EC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 09:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F0160F8F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 09:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhHCJjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 05:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbhHCJiv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 05:38:51 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6F8C06179B
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 02:37:16 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id o10so8003335uaj.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M91dYjRxPotOYEVRrsuPciYm69pZdDItVR3dg+O9yr4=;
        b=fN2EZu6qdFoWuzE1Ho1CrsblDPjFwQdNmEUMZjBj+bAOzg2+ZPsNysee/lZte/zPFk
         9/0JTSkDM2hO42bE/byYchJr7LYtQclwicPuUf79GvoTKU5QUpTPD+DmtqPLzExgfCQJ
         4n1DalbtPPHRE8Ina9ZYG6HAKJH6ovJsL2KrGArsxPP6rjCVRffuvOv0CqHdeagP1mvw
         WvGJk/NDj9sq2MtXA3VmTlMh87kKLNXVgmCPKIC9GjHriRHM7j/r28VZtd+doEGTo4FL
         NfTmdbNV5s3Nlkfb0RcxpajdBnnpRNYpw4WQtIf+tJfg9rmJK9Rk1HCjzKPNvALyygTP
         +WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M91dYjRxPotOYEVRrsuPciYm69pZdDItVR3dg+O9yr4=;
        b=I7bcHJK9ri9TFDtDT0RC9jmrc/7CTdPJ6AUbTmiu/9LG6rL+8iMdMz1x3Rqp+kvL0Q
         oj6QLnKOSZo/Vev1c9NLnMK0a2Iq9OzTkMFL4SeHHvxklD8b/8Fm2iaLmNojwBuXhGd8
         X5s98khWzBHPX+0KlYtv0IoapGGpku411hGjI/LXo4oG/Ct7KqbHue/M9VYeYvwB77Uq
         jNIGk08YHk0hHRi3bskMPjUYsPyv3AJdyjqyi8dGZgx2ac4xdYzoVgXpz8Wc3efQ5mI7
         GaQ/zG8NAwlBAmqLJ3O8MMWQsw5an5W+jVpKI714k0UhNkA+7A/AA92jm3aGKPizM0H+
         eWNg==
X-Gm-Message-State: AOAM533HhaIDOW2TjiI2vLAJhGBuaiZwuqHRKAPrFkXBU+kzASoQ+kg4
        evuZy7TQWOFM6ElX/IC7/U3vu/1kkg+OPGANvxTMZw==
X-Google-Smtp-Source: ABdhPJwlHPJGnL9EB1u/J6JGwCC/usC9OOY3GhHn6AkM87/hfobY084IZ0e3kNRwHuo7Lc1IFSrs/BzlmkaJmuqvhwk=
X-Received: by 2002:ab0:76d0:: with SMTP id w16mr13859733uaq.15.1627983433295;
 Tue, 03 Aug 2021 02:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
 <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com> <xmqqsfzrvcex.fsf@gitster.g>
 <xmqqo8afv8gn.fsf@gitster.g>
In-Reply-To: <xmqqo8afv8gn.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 3 Aug 2021 11:37:01 +0200
Message-ID: <CAFQ2z_PALayJYY=cjhae25jimvF_xevLdYQw-w_cZ4D3nBswmw@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Fix direct filesystem access in various test files.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 2, 2021 at 11:32 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Unfortunately all of these are already in 'next', so I'll revert the
> > merge(s) to eliminate what has been in 'next' and queue this round
> > to 'seen', hoping that we can merge the new one back to 'next'
> > soonish.
>
> Sorry, but I changed my mind.  On the day for -rc0, I do not have
> time to deal with this right now, so I'll keep a bookmark on this
> round for now, but will keep what has been on 'next' there for now.
>
> Will revisit this new round of patches later.

No worries: I'll fix up whatever is necessary once the changes hit master.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
