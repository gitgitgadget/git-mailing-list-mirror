Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B76C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 14:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A85E61186
	for <git@archiver.kernel.org>; Mon, 31 May 2021 14:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhEaOsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 10:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhEaOqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 10:46:11 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE8AC07E5E6
        for <git@vger.kernel.org>; Mon, 31 May 2021 06:56:19 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id d14so6630855ual.5
        for <git@vger.kernel.org>; Mon, 31 May 2021 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fnkMDG56MWAKpZXw8P1X6D36lhz+BuqKEIeZPFAbu2w=;
        b=ijZ7zTGD0XDvAWBONxbymzDQdTI7DR5hU1STJw2NxZBR5pkir6Xkhz3wAoqobKjoAR
         9Dv0XmqHwZHpVpUkVI1klqW/MDrS+YZbFn1WkEOWg0KfKwbl/nkynzDDFHWiOpZUbUY3
         UiMsJZUkodLTA8WjkgYMvA2K24yf3C+kG8jSkkEkDiQlLWlXpzCk92aJWiOhunvyf0yW
         jf3B1Q3IRnDWvvob6og82YO9qKzln1z+ymPJfH1XHNnkCt4vo+5c/4TK0eDAq+Z2cotW
         qO1X1pvYnXwoU//0zZ6htB+WjwVSD81ImnDKQzj6uhhRB1sFaqxTSV9ujMaJ5A08Eqtu
         nPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fnkMDG56MWAKpZXw8P1X6D36lhz+BuqKEIeZPFAbu2w=;
        b=eDM2UL/1S4x0eGqdb1/Stjaw1RdvBkby9OJwILP7JbvyqLlTRdTCnnoCG1YTQ2icp3
         FFWce2n2F+6GrGK6uSPUmWSZz4zR69K9O14VOBkIIg1D8R/k+uiPsJoijQfQqfsB9WZU
         ANWcGsPHmS6/zkSGo4ObIESfyJY/pHsFSWt6WtddOdIePOF/ahpSLvC2tGU2PtZO49HI
         zdo76SlQ4ZeXnEtBwBqOorW7GHOsYAt0TwEgX6nCyXMfC/Ku6W3I4HZLHz6h03Pn7Ywn
         tROnK6aA6kKxgWnpOVpUlhR8kxkWegAWbce9TZ2ZrT+dn7zpRX+x2psv1BSchbZXKYdc
         MotQ==
X-Gm-Message-State: AOAM5305/F7LGyXwPM88Adl2n8pTyOI9jskXfCiubwhm9MExRUgLxhKl
        UImcJnt0+pplnpxDF/2lls6zFGBe5Xym44v3f0LVqg==
X-Google-Smtp-Source: ABdhPJx4WqWuJK47cvyun77oHf47rsRvKEoKEBTP7CRG5nh7QEA9qWhs7xk969QxRaP9vRu+BjgMqjYZszypuTy0f7w=
X-Received: by 2002:ab0:6f90:: with SMTP id f16mr2505967uav.112.1622469378392;
 Mon, 31 May 2021 06:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com> <e67b90847c4eb78fff786944c04413f8a02cffb4.1619519903.git.gitgitgadget@gmail.com>
 <87v97dpgtf.fsf@evledraar.gmail.com>
In-Reply-To: <87v97dpgtf.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 31 May 2021 15:56:07 +0200
Message-ID: <CAFQ2z_NJwS+jvBZO0Ox22C26sGX4kOAJ5oiE8PSp-kOmH7K+Mw@mail.gmail.com>
Subject: Re: [PATCH v2 08/21] t5000: reformat indentation to the latest fashion
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 5:26 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Ditto subshell etc. on one line, can't this be git -C bare.git archive
> HEAD >b3.tar?

yup, both done.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
