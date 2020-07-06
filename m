Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A14C433E0
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 15:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B829720715
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 15:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tiRY3VC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgGFP4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgGFP4x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 11:56:53 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6241BC061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 08:56:53 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id b205so8409281vkb.8
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TcMiMdDFCLKVVE9svjSxL1unoWnOuZRVzzx5cJuCRfE=;
        b=tiRY3VC9cdG71Nx/ikl+AIy1QDb2cXOF3dpjXyLfb2mbDX7xmsI24KiIQe69hP7hfw
         +k3P/Uc+oe0AoBjFz5wWhJomZ81xrZebrX7BjMDBrzahYpMw2hgCJw0rqY40ApNyFDuG
         fSdWdrg5DAH+/nkESaVZX4hVFWfmWCM9tmZYcOVdinoxpAI1tUmjNyjSbUvhJ0tESsRQ
         uIJezL1peeyGdC7tbTRJzWI0wwWZIxDlhjUaxuPsCB1FG6HWy/45/iYfvdzeoS+jhGax
         oW8sLtIFtf82lIWLslKVskLxKBKTUgOPGoEga3fh/VL1gQl3siBOMe4eK8KFxuYYVMzU
         Pd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TcMiMdDFCLKVVE9svjSxL1unoWnOuZRVzzx5cJuCRfE=;
        b=A2SnH4J6cmz5sAA6kYVX0YPkT6xiCUfiA+wvVJ/DukUKfHlYS5KUC071n2IRiXDw0T
         Cxioy1Ia66aRkSN79TlbpxtkCHf4rS7yFSsZ7i4FIx1ThdhFwvAATGgPkRsgpfH7y8n4
         hW9Z//cTr39RgvwjDbIGfZMijuCEt7g1fMrGb1jU66mL3vi6MFaGxPscRBGA4seViQM4
         L0NtS/ghTiVlGLSRvE4ouPDeFYUvhrqvzwie+aJWAYm8lbtHv37KhiRXzgwEvvsg3vPJ
         dT1yVU/nQIoEhdjtzoq0vdVg3D6qGZu/5WinOwPMqpz3IiTaTZKMFAFVj06KwiS2Xj8k
         8N8Q==
X-Gm-Message-State: AOAM533yP46mXhELZG/dwW31aVBGpEumL/nH35QhpI51TG2rXKLNN7Cp
        OacontrJ1Mr2exOwfAQOkzHgSfhEugQhDBlJ8mgHAA==
X-Google-Smtp-Source: ABdhPJwKc95qjuG9f4rEwinL47jIcMm4ibDSVumeumwA1+MXFGk2F+NmKu1pXeWSoBjcJJ2YLBmZoS/5h9Zspneg1Y8=
X-Received: by 2002:a1f:2302:: with SMTP id j2mr35449037vkj.64.1594051012330;
 Mon, 06 Jul 2020 08:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
 <pull.539.v19.git.1593457018.gitgitgadget@gmail.com> <125695ce92218ca2ddb9868880db542acb0d2a79.1593457018.git.gitgitgadget@gmail.com>
 <xmqqmu4lfxet.fsf@gitster.c.googlers.com> <CAFQ2z_MuD0e+a_r0_-GMpjr1mV==hdh2=0gyVrT7f8tDbXC6xQ@mail.gmail.com>
 <xmqqftacds2a.fsf@gitster.c.googlers.com> <CAOw_e7bcfUyumKkQRubf=zg6zso4pOtiC8-6d8qQiVL7vyfCog@mail.gmail.com>
 <xmqqr1tvc7el.fsf_-_@gitster.c.googlers.com>
In-Reply-To: <xmqqr1tvc7el.fsf_-_@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 6 Jul 2020 17:56:41 +0200
Message-ID: <CAFQ2z_MEEUHu-NnAgg-8ZV5mgOTFDvo4OApRwuCo7=3H9DQc6g@mail.gmail.com>
Subject: Re: Re* [PATCH v19 03/20] checkout: add '\n' to reflog message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 1, 2020 at 10:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> In any case, a patch that moves the existing "squash SPs and rtrim"
> cleansing from the files backend to the generic layer may look like
> the attached patch.  We can add reftable backend on top of a change
> like this one and then we do not have to worry about each backend
> cleansing the incoming reflog messages the same way.  Nice?

Yes, very nice!  Will you merge this, or should I make this part of
the reftable series?
The reftable code already has normalization for reflog messages, so it
doesn't really make a difference; either way is fine.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
