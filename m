Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF13C433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 00:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355C061002
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 00:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbhJ0ADQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 20:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbhJ0ADN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 20:03:13 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58609C061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 17:00:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x192so2222498lff.12
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 17:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IRF2K36h/Mm8Xp1DkSq66tpIyHo+WPrfUP9rFh9Htys=;
        b=lVBtzVapFhkLUeT8dsAQpyD3bPUoNJOlj27j4u17aJN7l4ymu10dPPCnBRhry0IQv/
         sy/I3ptOHeEWKu1kXMazAtbx59zkeh1MXI1DLcJSpn/Mug6mnoeim4J0cKQy6J882RrL
         5hRqaYa2iTDk0y3QIv17mPCbrhML+BfgHkCg6G6rBAGnUSGjQj0s67BfU1Inv6QRYO/c
         KMrvUNlFZYRTZBg3vJRtj0sCi/nQeMsmK7g9cfz+qB6spwC9NjVE+CxXb5+hrdytz1ur
         vXs7CBcaIlkaVi17tRmMbBcnezuDrVqFWdY9jpYZ3Kcc3xlFW852HhLV++IicwC5J9Dd
         Xjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IRF2K36h/Mm8Xp1DkSq66tpIyHo+WPrfUP9rFh9Htys=;
        b=nKwhAY+zg7qudA37SoZQKAvJ5JOkj938m5U6Ka3Z/FFuNrmKpKp0Zqvw7xJofLwb6j
         2EdLUrgqsDEFzFjdODMR+57QcZYqtnKjbjXZq2W1Bt0sYVXJcf8P3jJDO1t8aFVH7Vae
         u27PQ9Eu8nB5+if5Q9RB+jnADCEKCdy21bhlOrHati6l48ygoqAWCEm5CaLHv45o15qz
         4jPGsGZT36zdyvKguNgUC5o2ooVpn+2KlMT80u6AQqpgR6VLJArGZ0kdqtPfuVY3mTXG
         Ui8PpfyozHH2hhm2My32nIda8I3qNFzn0nhCkowq7hxGGyi48nXjRiYBcs+TQiECKjVI
         M+Qw==
X-Gm-Message-State: AOAM530eUNMxubyZP3KKlY1w5pCYMRjB2+IKJISaOEBwZwLh2giOqkKQ
        M8HrTIDQEPvJ7seuBP+M8Iuvc6++kKYu1ip+l83VTw==
X-Google-Smtp-Source: ABdhPJx0g9U3/d5+R1lolKQlbA5CdlIdSTyTeJdG/J14oHQP756yzVTeigz7vFdGU8JXhUtpUCv2zsL6wS6TKgDoBtQ=
X-Received: by 2002:a05:6512:3c97:: with SMTP id h23mr7170996lfv.640.1635292846624;
 Tue, 26 Oct 2021 17:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
 <ca1c6a86-23ab-57ae-b1ca-64a9851d72db@web.de> <00a67af9-da41-6df4-afc0-5ae7c7714bfd@gmail.com>
In-Reply-To: <00a67af9-da41-6df4-afc0-5ae7c7714bfd@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Tue, 26 Oct 2021 21:00:35 -0300
Message-ID: <CAHd-oW7P9uOFzm27BCx7vZarLNL8JtSf15oTD9Lwmyvg7wUtQQ@mail.gmail.com>
Subject: Re: [PATCH v2] add, rm, mv: fix bug that prevents the update of
 non-sparse dirs
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 4:04 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/26/2021 12:22 PM, Ren=C3=A9 Scharfe wrote:
> >
> > slash can end up one less than path.  If path points to the first char
> > of a string object this would be undefined if I read 6.5.6 of C99
> > correctly.  (A pointer to the array element just after the last one is
> > specified as fine as long as it's not dereferenced, but a pointer to
> > the element before the first one is not mentioned and thus undefined.)
>
> I also see the specification saying this is undefined, but I do not
> understand how any reasonable compiler/runtime could do anything
> other than store "path - 1" as if it was an unsigned integer. There
> are a lot of references about "the array" that the pointer points to,
> but these pointer arithmetic things are not actually accessing the
> memory allocator.
>
> > Do you really need the ">=3D" instead of ">"?
>
> I think the only case that would be of any interest is if the path
> started with a slash, which would not be a valid worktree path.

Agreed.

> I believe we could use ">" for an abundance of caution with the
> undefined nature of subtracting from a pointer, but it is non-
> obvious that that is a real problem.

Yeah, I think it should be fine to use ">" to be extra careful.
