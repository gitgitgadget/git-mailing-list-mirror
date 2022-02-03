Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742F2C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 14:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351173AbiBCO3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 09:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbiBCO3y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 09:29:54 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6402FC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 06:29:54 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id b16so5514960uaq.4
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 06:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0upiRTdIQUViawZd8VxT1EWFDN4gEUT6todjuiuMoSc=;
        b=eVe9e0t9n1hKu99APR9SkfqrtubdQ75SwjOQUAoskUtaPVLntOtIeY7NSYSq0bHarg
         cEXh586RMKxvKDev5LN5SGaQEgiQEhlnSkfkXmXisbGYommbwojezfpcmmE1vjZCci8d
         zmVCU5qtMVu3WX3TJAvbz0ctJ6qx2cdcU3qiDAPnempuQjy9wkw64LnjUJvApjDK30sN
         FdjUD13VpdLO1ZpmBIPhyDOaqotk0PttTI4MfaHZQwCeY3vXRcFreGGsJLPQZUVCcauH
         DiVoSYTEuM8IU7MBop0rF1/YDm0Jp6UlqwXjS0nYkNXvqxjTmedq341DDc73qGQsVkl/
         0ZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0upiRTdIQUViawZd8VxT1EWFDN4gEUT6todjuiuMoSc=;
        b=MHzDiV4K1WBqd+eXMGfeTYb9sUgEZwlEMngKbNclmYlHe+cqR1r0B+xbSNkSQ+KOhU
         893oG0IoMiA3E7D1L1UYZFg3pA+MTSr8c0sdT21hPR5l8O4F1dF5gX/8iqVxEYJ71fIT
         CmzjRXTvVZBDdsE5T5MeHJdtWnoH48JnyW8mni2RDJ/vQb3++rEzq4W4FBmemlzGwJIa
         Wu6pVS9YvOI4kovMkwEMjb7GfvT8zE698o2WzC7DGFI933YYIrCfPwQqNzgCG1mhV6ka
         CQzJWMqtvpiT0zqlbdivTrkls/dFpjlcNwFy10UiyhNFaUpVEWRlpoacEwkUf+vWuwFo
         4L0g==
X-Gm-Message-State: AOAM531jvjqgg4Lv0w0F8wgOVpndt8lacwRSRJmRDCD8RGkovRM+ESIl
        Pct8tOXNcfYN9qdSi+UPKAp2msWTNjQeQICH+xr1VA==
X-Google-Smtp-Source: ABdhPJypqzDSjyUwIqy061J4YEGOAbtIptUFSmdgprdYPzgY2qx/96GjiYdg83L1xQndg/0g1AyhTKJJDqxQx+DlqjI=
X-Received: by 2002:a67:e096:: with SMTP id f22mr14338094vsl.8.1643898593442;
 Thu, 03 Feb 2022 06:29:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
 <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
 <220201.86ilty9vq2.gmgdl@evledraar.gmail.com> <xmqq8ruub35i.fsf@gitster.g>
In-Reply-To: <xmqq8ruub35i.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 3 Feb 2022 15:29:42 +0100
Message-ID: <CAFQ2z_Oxq67XO20oG7Tokk48wm5ZzHRR3GDi4PG5wg7FMJ89aA@mail.gmail.com>
Subject: Re: [PATCH v2] refs.h: make all flags arguments unsigned
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 12:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > The post-image LGTM, but I'm also a bit "meh" on the churn just for
> > signed->unsigned, especially given the conflict with my in-flight
> > ab/no-errno-from-resolve-ref-unsafe. But it's not too bad, and if Junio
> > hasn't complained about it...
>
> I won't complain myself.  I'd still try to help newer developers,
> but my intention is to make it the responsibility for individual
> developers to make sure their topic works well with topics in
> flight ;-)

I'm sending v3 based on seen.

> Between "enum" and #define that is stored in "unsigned", neither
> gives us much type safety in C; "enum" may be somewhat worse by
> giving a false sense of having a type safety that does not really
> exist, than "unsigned int" that is more honestly defeats such a
> false sense of safety.  So I have no strong preference either way.

Neither gives true type safety, and I don't know if an enum is kosher
at all; shouldn't the value always be one of the enumerees, strictly
speaking?

I proposed both options because a distinct typename lets me jump to
the definition of the flags easily through ctags.

Another idea is to mark the type of the flags by its name, eg.
transaction_flags, resolve_flags, reftype_flags etc. This wouldn't
help with ctags, but it does help with readability.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
