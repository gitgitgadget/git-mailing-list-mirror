Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0EEC47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F102075E
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KT/YCqYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgEKLlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726068AbgEKLlr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:41:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83D5C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:41:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so10539976wrx.4
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yu8D0X1ybODQSvM4muOeFwqIfrUjeoX59D7EghnttJU=;
        b=KT/YCqYluTmTLPclLXJW7hQciqA+oVByZsRGkd/PT7w0S5r9tTnRERKNn3+mX0AaEU
         3RAtOoRnoitmS9vGKIe7aMFh9hYpo3qbRPFpGCLPh3jclj0BYWV/xRzS/7GsEjxaMQZU
         V3LB+TGttMfrMpj94+4iJswUKP1M6eoB569/CHMhcZbVhHCMpKPS7Eje87Yao8uR2MSm
         JfJdJA2o+JH+cOyUidZbAmqKYcH4X8F1Q8fHlX/k7SH7J6jXXp1F5SCKeUtHguVpUJcp
         xG2jUGwv/4Kv3brZAP4ZCMPqT7hacJ7L804W2l9qtEFPXtzbJ06slU+pqotMoC1tObTf
         Q/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yu8D0X1ybODQSvM4muOeFwqIfrUjeoX59D7EghnttJU=;
        b=iJ1uBgLujexlUOyNt0LJN5Z7aTmfw4bGVLoi9K9X26uONwFat72C72EfNuKbCuTHVW
         FN/LlY0Z1+xvgCJYM+jDdWxuLwyBCY5ZweSfyM4f1kkQ/gpABEiJYBMeQlrCZX1ySjBL
         Op0E30Ermum66SNm+3ROGqlOVDNnOhxDuT3T9y7MAhjD/Ewo9OMKK+DTRuraRSIjY8PV
         F9BaJSU9xd0vsI8dWPH6pr+FBF5I4jC+BhRvQYfHafpI/sKXAqT/Ow/10WF1H969aaUr
         GDEQRzQCstubh5VM3JE/01fhXXTnpx3cO9R9qq8FIa4r6OAokxwbcBQrGK9DOewP+VfF
         HHhA==
X-Gm-Message-State: AGi0PuYLxmzY0RLFe2YWJrjmRYD5H0vxHZHP1U2F7R2u4ZpWBe8OH6aW
        FaD9iEnjk8YB4Y+aDyk8G4yho/1ahGyDm3InHup+YVCm
X-Google-Smtp-Source: APiQypIGYhfG0jEmN2YMu/UVkDWEDVCfVW8HPkuymQuIAHlre1eoVPzsHJ4qOOXVJfjBpWly9EfDHtLQHu4sjeS3NFU=
X-Received: by 2002:adf:aacb:: with SMTP id i11mr18719509wrc.6.1589197304311;
 Mon, 11 May 2020 04:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
 <pull.539.v12.git.1588845585.gitgitgadget@gmail.com> <340c5c415e17a957b8a38932215b1179fbe68dbd.1588845586.git.gitgitgadget@gmail.com>
 <xmqqh7wqxnns.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7wqxnns.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 11 May 2020 13:41:32 +0200
Message-ID: <CAFQ2z_OZ96xiVAM=kVX0KLXq1AinT=fxH1J=_6FOmO_2qvjncA@mail.gmail.com>
Subject: Re: [PATCH v12 02/12] Iterate over the "refs/" namespace in for_each_[raw]ref
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 8, 2020 at 8:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > This happens implicitly in the files/packed ref backend; making it
> > explicit simplifies adding alternate ref storage backends, such as
> > reftable.
>
> Makes sense.

It makes sense, but I'm not happy with this yet. I think the more
consistent thing would be to have pseudo refs be integrated in the ref
backend completely. Then, there could be a INCLUDE_PSEUDO_REFS flag
that could be supplied to the iteration to decide whether or not to
produce these refs.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
