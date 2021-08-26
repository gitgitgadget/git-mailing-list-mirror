Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21F9C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 08:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F83D60F11
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 08:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbhHZI52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 04:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhHZI51 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 04:57:27 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76F5C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 01:56:40 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id x6so1214400uai.11
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tPWAZEzqS26Q7SwSvxALrSClu647OUTHd+4z8gBL36E=;
        b=ej6gU8U57EJNh/RA7CyyCiHkGkICVYvURx7XoT8x2vsuHNjZCWVy9TOUK+5tEHdnNQ
         VhFj6g2vXc1mTqKY5SfVEdMfTqbkeJTezjZeUp8BdAnRWKJ+HrMDK6dX36v/95KUU8/A
         kGUGZanFAhAM/e36bf6oUuxDtLbnktuWKrxlNzrjXBD9DzjSPtDfxKaEdCMAoHnH/u+w
         Gh61+LVs/D3+qRVY+vd1M/Lg04WT8pmCUd9huFAi6h5eIjCVk4mcQqIHgFvEUA1Las3t
         E2NQMQHm0SA0TjrGIdr6l4oKS4V5XaorIRxfmVcuueSPgEubON0y47A62wIGLRvGJ9SY
         VPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tPWAZEzqS26Q7SwSvxALrSClu647OUTHd+4z8gBL36E=;
        b=YPpjvR8H/JgAy+iYUWPXtBSSpPpK65ei+fSOHUahuftJubcOCLADQio7CRALRoR3/1
         BYcdhqMqx2YooUN0RSRJHQ3ZU8BjnQH2Fsu84GO4j1QWEbWrWMefDA+T+CXHJhMMnZEk
         0SWVIVeR12M60ADX4DMeedgX8GLoqyzvUmtK82+2g8CWnRD5zSd5UTTYqJZ92nbGlUc+
         ngCbVdNUI2b9fN+WEFdD/8if1B4qAKTPh2kMbBYWd2/ClN7yBW0fgHy4qk/WXOJ3lEn9
         LVUVsZlwnw3CXyLoL5974Z8c+4R3h5YKmqlIy4lVX51YIxbEtQdAzbD9U1v2qc3H/zSC
         aJ2g==
X-Gm-Message-State: AOAM533dJgqeYc57JjEKyLWsb6xsPq5yPJCL297jyBDxaTdYD2QgppI7
        UhwWhTag7j0RPr8ufL6OMo5+Li/JQeM9sfLT7vHrLw==
X-Google-Smtp-Source: ABdhPJxcvhyMp/kjbtgVe2ycN2AZ6HIpFuIwvs+R7k2ncmJWDGv5uvNjnTR2sTkZEnusCz9Oz662Sevvd+D9i8EJYg0=
X-Received: by 2002:ab0:76d0:: with SMTP id w16mr1313003uaq.15.1629968199959;
 Thu, 26 Aug 2021 01:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
 <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com> <xmqqfsuwha5p.fsf@gitster.g>
In-Reply-To: <xmqqfsuwha5p.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 26 Aug 2021 10:56:28 +0200
Message-ID: <CAFQ2z_NBmKrVMeuTb=qeG_VSBWC7287-gGB9GhpokLZrmNiC0A@mail.gmail.com>
Subject: Re: [PATCH v4 00/28] Support reftable ref backend for Git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 10:39 AM Junio C Hamano <gitster@pobox.com> wrote:
> > For Han-Wen's v3 of this see:
> > https://lore.kernel.org/git/pull.1054.v3.git.git.1629207607.gitgitgadge=
t@gmail.com/
> >
> > I've got no desire to take over the reftable topic in its entirety,
> > but think given the rationale in
> > https://lore.kernel.org/git/877dgch4rn.fsf@evledraar.gmail.com/
> > (summarized in
> > https://lore.kernel.org/git/87y28sfokk.fsf@evledraar.gmail.com/) that
> > having the refs API fixes I noted above wait on the still-unstable
> > reftable doesn't make sense.
>
> Of course, you and Han-Wen are in much better position to judge the
> relative merit to decide which one should go first than I am, but I
> had an impression that the errno thing was even less stable, with
> API churn that deliberately broke the other topic in flight, which
> appeared to be just irresponsible.

The bottom part of the errno series that I contributed has had ample
scrutiny. It's a cleanup, and all-in-all much less experimental than
the reftable work.  However, because it changes a calling convention
in the ref backend API, it causes difficulty with other topics
(notably: reftable). I would be in favor of graduating the series upto
"refs: make errno output explicit for read_raw_ref_fn" early to
provide a stable basis for other patches.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
