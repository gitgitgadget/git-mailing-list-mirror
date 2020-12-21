Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F7DC433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 12:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810A622582
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 12:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgLUMk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 07:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLUMkz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 07:40:55 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7182C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 04:40:15 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id s42so3245935uad.11
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 04:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KcIpez0zgun8j2n9CeVX1xYo/+EtXwjKuzZnQVP0EY4=;
        b=AKC2Ltb/4XdmqjJWfs6laV/I/yVnnLYve6TmHzV5B7oQKmaYIbSsuj92Apk8Fq37vW
         vFRoExQKK0T7nqienuTI3HgPkOAptPCZPuPQGCjIVKVHoaDAtSq91TN9x9ukqFBpufMm
         UBktdvhW7l7agiEwGkFe1yC0xgmd7WUZLVPXEdfqVL8+lKxqFlsmpmsHMTUg5akNQT6F
         4pri6zOL9m7mCXfxwW9fQUKWzZ52yrdLNGF0JOwOdVW7e1WoYxejP3gPjkDawSX3rpFv
         VFKe7lXA2/ve01uaBY7UccYTLd/xkVJbVp3gxX8veXRb7JdNMNmd9SqNhop9kLKjdPnx
         i/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=KcIpez0zgun8j2n9CeVX1xYo/+EtXwjKuzZnQVP0EY4=;
        b=fLDB9RlhYzHFLHHSKLZsUShobMDpkP7nNbfIyE6xe+6KYxYQfVkhA9anvcShCJqgoi
         LNpUYZslRXLMOFb4YSeH53IPf4wiwWCnCXir0Z82gQFQ6JsqqfgkxEc18NElY47hWuNJ
         9/gDoGKpQ0cfYu3SB27b1tnvgU1TlXfZVq18LFb+VpwtgiO91lfRhkcIFwMlXjKnIl0q
         101ndg1v9Y6MJKynasQpECXe7O1Pf2a5ge5QirFyEHwd3aveggBk0QZjPEmpB2dpqZqd
         ld7c1Mpzl7LrI7I29qbJlvS2M9hUHXAxEdmDbZEugjXxVeWNg3xFiwsvVMsybXrhmKqi
         7WtQ==
X-Gm-Message-State: AOAM530P/OmyIG5ucSC55C3ME0KrPL7wxlaozHms4qnVSRKxyg7K8FFQ
        Olfhrox4OvRI71/bejhngi5D06S7jb/2aV0hkQdM0Q==
X-Google-Smtp-Source: ABdhPJyuyLWef0Uz1Y/SvPDfIUHtR9toYG+PKNj9rCXroIaQ9ncPjInQIElSQz6u0tlXcHtTezwYck5cPljqHjIAn6g=
X-Received: by 2002:a9f:2628:: with SMTP id 37mr9824477uag.87.1608554414443;
 Mon, 21 Dec 2020 04:40:14 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 21 Dec 2020 13:40:03 +0100
Message-ID: <CAFQ2z_MtpPNSpL9=OoyPfDRfkFxnCO19qBDnY9bnZiEEGtuMsQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2020, #03; Fri, 18)
To:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 19, 2020 at 6:36 AM Junio C Hamano <gitster@pobox.com> wrote:

> * hn/reftable (2020-12-09) 15 commits
>  . Add "test-tool dump-reftable" command.
>  . git-prompt: prepare for reftable refs backend
>  . Reftable support for git-core
>  . reftable: rest of library
>  . reftable: reftable file level tests
>  . reftable: read reftable files
>  . reftable: write reftable files
>  . reftable: a generic binary tree implementation
>  . reftable: reading/writing blocks
>  . reftable: (de)serialization for the polymorphic record type.
>  . reftable: add blocksource, an abstraction for random access reads
>  . reftable: utility functions
>  . reftable: add error related functionality
>  . reftable: add LICENSE
>  . init-db: set the_repository->hash_algo early on
>
>  The "reftable" backend for the refs API.
>
>  Ejected for now, as it has been breaking the tip of 'seen' for too
>  long.


Can you provide more information here? The PR at
https://github.com/git/git/pull/847 passes all tests (except for the
VSBuild, with errors that seem unrelated.)


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
