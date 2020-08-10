Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA84C433E1
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 14:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1B82078D
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 14:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="btxcQcxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHJO1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgHJO1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 10:27:24 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11055C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 07:27:23 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id i20so1899364vkk.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PJTDaOCh2CqXme/gDDU8KbouVTpcd5MKcarmT1ekhCY=;
        b=btxcQcxinh5DXMUWX3aXJXw2jXCwVaPqQMGP4I1wML9DCd157nmq+JKIjmju0xSSYz
         JzlDDbypmj4sD2tZAabEZYjFatXWyZXdkrsL0Be3xQrk0OqeNAczY9JN6inpj9b/tk3I
         /M5LKuHOkMJKX90nE/QoI6zqYhbf5SQ/MkGVl4goV5Wk3niZHzHOWniARnVabE/HAqaO
         R9n9e1PLi9CCU/CAUKXnu5lunoiTFio/wvWXooSLo74MRiJZFSZhtYhgMQb4T6AZFR4D
         Ozj0rsxRJga2XPPjfn2kMFpHkmNSwj0mxgoPl5VTKZosKefesm4MyVpVSQIZ9JHCloXX
         8EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PJTDaOCh2CqXme/gDDU8KbouVTpcd5MKcarmT1ekhCY=;
        b=hIWYcEG1tpy5EMEVpD4x9C47siB1KwnPf6BvpImQeLjn1mB8A3NtgfNs8dOxHBWQVH
         WibMOHQcNcIKPqDLKJsG+8Ek/5skBYwgedGF/dpKL++T1B0jZWUVmtjQX3gBq1vwhEw2
         8DsNLRPW//Pyq+8wNZXnJQZv1N4dVaMMCdmvUdlLX+daHXFENQFLppIP8q/TX+8GbbJG
         +401suwvl0UC5Yyu+JCatb42AIf0Vx9iJGAmIloXRT+Dzfkv6oB7WN9WQj6Oe//PJhRj
         uW8lKMBLvykWHSOPBNevwCp7q8J6dnwGOrVW/sRqnZp4fEVa68jy72q852ODE2KZxu/H
         nFQg==
X-Gm-Message-State: AOAM530l0SxfXWISA1kSVspBq6ewzz1Dpdla6Y7NLR/o20bSDng3CRo9
        vqOwSL43BZEIVwEVvWAyEOAqtUkJLRdXLK6kzGwYnFmw
X-Google-Smtp-Source: ABdhPJz93PfCTpcwSH1yGDClh9+F3z3LLiJdjiIR6H3lqukAhlfkyR1SmXahGnYmf1M2z3CVLXrTywooeHO3VQa9aQA=
X-Received: by 2002:a1f:a0c3:: with SMTP id j186mr20021072vke.76.1597069639138;
 Mon, 10 Aug 2020 07:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
 <pull.673.v3.git.1594925141.gitgitgadget@gmail.com> <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
 <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com>
 <xmqqpn8hgca7.fsf@gitster.c.googlers.com> <CAFQ2z_O1sRm-_SNP=-GvgNLqB+qgf6k9YVfbF1XCAmFWdeX6Ew@mail.gmail.com>
 <xmqqh7tjv6hb.fsf@gitster.c.googlers.com> <xmqq1rklrhle.fsf@gitster.c.googlers.com>
 <CAFQ2z_NU4=WcUDvVY9PNs+p-WU4u5=QY+=DHonGyK29numhWoQ@mail.gmail.com> <xmqqk0ydozqe.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0ydozqe.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 10 Aug 2020 16:27:08 +0200
Message-ID: <CAFQ2z_OgNQKZ23gNB9=LqPn2M=WKL2vPQQpxm3drRWeN1sxH_A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 5, 2020 at 5:54 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> All of which means FETCH_HEAD is special and we may not want to
> >> burden the special casing of it to newer backends.
> >
> > Can you confirm that FETCH_HEAD is the only thing that can store more
> > than just a symref / SHA1 ? Based on the name, and a comment in the
> > JGit source, I thought that MERGE_HEAD might contain more than one
> > SHA1 at a time.
>
> No I cannot.  I do not think MERGE_HEAD is something I added with as
> deep a thought as I did with FETCH_HEAD.  If it mimics FETCH_HEAD,
> then perhaps it does, but I somehow doubt it.
>
> As can be seen in builtin/merge.c::collect_parents(), we do special
> case FETCH_HEAD when grabbing what commit*S* to merge, but all
> others are read with get_merge_parent() that makes a single call to
> get_oid(), i.e. anything other than FETCH_HEAD cannot have more than
> one object recorded.

Understood. Is there anything you'd like me to do with this patch
series so it can be merged?

Dealing with FETCH_HEAD generically isn't possible unless we extend
the API of the ref backend: the generic ref_store instance doesn't
offer a way to get at the path that corresponds to FETCH_HEAD, so we
can't handle it in refs_read_raw_ref(). In the current reftable
series, FETCH_HEAD is dealt with in the backends separately.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
