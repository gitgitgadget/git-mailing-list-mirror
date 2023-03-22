Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97145C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 23:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCVXil (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 19:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVXij (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 19:38:39 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095B119B1
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 16:38:39 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 16-20020a056a00073000b006260bbaa3a4so8806299pfm.16
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 16:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679528318;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQCMLug4ROfv3clyE0e5N0SZxRnbGEiquyE3JPv9MMk=;
        b=td2rByPSCEaksCWGc1ih/5y4OLjtVCH31bPTDbv/j+UtpDIstraT2fMB5a+FX1FLRO
         5J1+J6yZ6fQ6n6hQ+xfqVCkpUi445ccAc9auTVs7If+U9hd/fKn4obqFiYFSIU+4EinB
         bXCmb1zoHfeZjHHArzvk4kUvzTUGTQ8PtUHTa0XxHj1nVTl2bEkn9zbdEAoSbeGV35Yg
         6PE7JR1SqIuGt47zHgb8sXlgqaqMeEXmMedxKPWa9dX+VWQKzUApLmKs3Mr0TKql09A2
         6i/VNfK7Dq3vIu38RGiQfo9vkP/Bse/jB8oDMMoj0lBsuzNb+TLt1jDfV1WwHfh0m3Cy
         1gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679528318;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RQCMLug4ROfv3clyE0e5N0SZxRnbGEiquyE3JPv9MMk=;
        b=1hqM9OmA6MRAwnSth1U20BuzLAhVD+tTCILqO3HuSFrSwvGpfEVCRxGurgza7fSAE6
         Q5BoNLCzdBaWAx4JQ9agQM+jiBZUwCj8aABJZxRBG8oAF/Q4exwtASQ8pu3PqTjOyasJ
         ZxpI8ltBVX0VL5WcAaZzXOvuY3VmSMLGmO5bCHGTV4eWce1db4bZntBueR77q8PTgR1f
         aLroUyd0W23+6g3zXB9QBL6JbL8J/2fyRJyOl4HjdHHT4R22obu79lAiuZ2UDQRIa4bK
         s0pUZeeeYC+d/u2E+0KifVKv3wq74nfbV2nbSiqL6TtHW3FhBxQD3vLeOndDIlrJEQr3
         4Lpw==
X-Gm-Message-State: AO0yUKULzNdV7PZVtnr7FRyOcCGQ+iuWfmrZlc0xKqOdE0E8qZks6ESn
        o68ZcS0MePb4L1aEp3neffnebdG4OGzFIw==
X-Google-Smtp-Source: AK7set849EFsUscCGVQXoCdQ5sWKDT8aMF+kHtuNKnhm+54QQ9ZapM4OikpBxD1e9mgI/UXkRT4t0mU7JJ9Qtg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:e984:b0:1a1:9015:4d5c with SMTP
 id f4-20020a170902e98400b001a190154d5cmr1697097plb.3.1679528318097; Wed, 22
 Mar 2023 16:38:38 -0700 (PDT)
Date:   Wed, 22 Mar 2023 16:38:36 -0700
In-Reply-To: <patch-15.17-c8ff241844a-20230317T152725Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <patch-15.17-c8ff241844a-20230317T152725Z-avarab@gmail.com>
Message-ID: <kl6l8rfoe4qr.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 15/17] cocci: apply the "revision.h" part of "the_repository.pending"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:

> diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/co=
ccinelle/the_repository.pending.cocci
> deleted file mode 100644
> index 1190a3312bd..00000000000
> --- a/contrib/coccinelle/the_repository.pending.cocci
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -// This file is used for the ongoing refactoring of
> -// bringing the index or repository struct in all of
> -// our code base.

Now that we've deleted this file, I wanted to get a sense of where this
series lands us in the the_repository migration. ISTR that we'd consider
ourselves "done" when we stop referencing "the_repository" in
non-builtins, so presumably we aren't there yet ;)

Inspecting all of the ".h" files, we can see that the only remaining
function/macro of this sort is "the_hash_algo". Because you expanded the
search to cover cases not in "NO_THE_REPOSITORY_COMPATIBILITY_MACROS",
you've actually achieved more than what your CL says. Hooray!

We can't go so far as to say that we've removed all implicit references
to "the_repository", though, since we still have functions that
reference "the_repository" in their implementations. But, I don't think
this ".cocci" file would help us with those cases anyway, since this was
targeted specifically at functions/macros that were passing
"the_repository" to functions that accepted a "struct repository" arg.

Thanks for the cleanup, this is great!
