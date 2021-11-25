Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B47C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 16:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349812AbhKYQRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349779AbhKYQPV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 11:15:21 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783EAC0613D7
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 08:00:32 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id d130so4237434vke.0
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 08:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gxkAEJuOjnh17NPk+VgPDTacoq+RD2r664gnDPbGx78=;
        b=rue3cly5ECG/N7KxF7rrXtiHpCj8jCxZnXUC5vAx54OZdUeOFRrqMWWz8gvPrTspNF
         o3pyQXf8hy6lu7oFCgiASP0/mhTglvJXzEvGdDpE1Tz8qaDEA0jltbE98Lq40hUui2qd
         lZ/hNzKZRggrimS6RKrlRnXZc9aN0MvNnFBKTuY9jRRBwunQC70D3I9PesK84h+Vbp7/
         LeBiZ1PDdEXcFbQ+o9GciTTQPSf+CwoLZg/RMv78IAmZoJqc6LIuxb9tNfeCpfSB9+O5
         voiX2r+VDKiG2iO2+0ZBex1xUjXntiA2EBoXX4mn90mpztZTuMXf+ShiE8j+PmJw72JE
         ty/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gxkAEJuOjnh17NPk+VgPDTacoq+RD2r664gnDPbGx78=;
        b=CSDu2cb7Eqz5V9qW2v+uAlvpcyuUUD2srThBHZXLIVf/pwZD9sAUV/JCOQGM4Rq5yx
         ibE115Zqwj4uhdkZGRMLpNuQa2d9tqcRVmBTxHaBYTiU3MKPEG/89lslbBy6xyyod7Sc
         aadkQhizsc5vC7/HrAgglLsTyEPE5Up2htEEMuqrx3ql3/Rbcijv/6oM5xCh8ECM8ckn
         zGm5lYQWDeDPrQvmj1bo13Kvvca0e4cx5nGkor7Pv1hfVwSBZkH9gGF139zGAQz5iQk9
         DAo771vTWUgia5iFFtPaGvZRstlIYLAtTbI1YVKwCpj1g5JtlXbECBgaZ37C5Lzy7AuP
         xKnQ==
X-Gm-Message-State: AOAM532amfNeQ9zL4c50EboaFmjWgRtZn8HpFkFJw1UUmnzo3MKavs8x
        7TPOlFcirtWQCAXhtg64CKxRPE9zNL8Tm8mBPnBHPw==
X-Google-Smtp-Source: ABdhPJwO6f4y523nHh4YzaIxhDkorPa8D/pl/p+LT20JgIr7JwcvK1p19bhMKE9XqUhYhP28hHTV/Oif7U07bQnmAno=
X-Received: by 2002:a1f:2b4a:: with SMTP id r71mr7819428vkr.37.1637856031504;
 Thu, 25 Nov 2021 08:00:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
 <xmqq35nnddw7.fsf@gitster.g> <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
 <xmqqczmqajdk.fsf@gitster.g> <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
 <xmqqzgpu7grv.fsf@gitster.g> <CAFQ2z_Mb+NzQfXfMhdQoPs09p2j1AWRAdXcX3JSznn+H9+T0Bw@mail.gmail.com>
 <xmqqpmqp2xmz.fsf@gitster.g> <CAFQ2z_PqgwYy+RxQm7d7WDQYvQQ2vVE0cXHdDKNwQJm3Xc+NFw@mail.gmail.com>
 <xmqqtug1z32j.fsf@gitster.g>
In-Reply-To: <xmqqtug1z32j.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 25 Nov 2021 17:00:20 +0100
Message-ID: <CAFQ2z_N-XY6MrvYjKvkH-vNz1824p12aNeiHj8m8VPzPD0JxEA@mail.gmail.com>
Subject: Re: [PATCH 2/4] refs: trim newline from reflog message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 9:55 PM Junio C Hamano <gitster@pobox.com> wrote:
> Ehh, let's step back a bit.
>
> Is there anything in the common part and files backend in ref API
> that needs to be changed to fix some bug?  I do not see anything
> broken that needs to be fixed by "assert that the string ends in LF
> and doesn't need to add LF itself" or by "always add LF".

Clearly, you and I disagree about what is logical behavior here.

I've reworked the series to fit with your opinion on the matter. PTAL.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
