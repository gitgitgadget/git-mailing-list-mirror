Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAE8C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 17:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D585360E09
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 17:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbhJGR3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 13:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbhJGR3I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 13:29:08 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C93C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 10:27:14 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id s137so3037451vke.11
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 10:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KbSKgjGBdf4KEOeXodSJcKs8T6ae/17ktfaWjXxlBJ8=;
        b=A35/d1hKtGHWHYF4R6lfqS1lEhxnkZPiyMrpDmKjQY/6eqHrCqPfo47OvXP2HApwzn
         p4QEK+BIR9nJwtsGEzx/WIYlMF4opkEdVW+8SowjF+84CAtblQVQvW1kGlS30pXbWXmH
         /JmQku2gYkb4wopFsNSS8Xmlxi9pFbYyikA0AEr7X4UwKz4OKIItvFpRAuLTvUN9GWYy
         BRTEBv18WfSMOlw4R7X5T3Fa2aqDA7Y0A6Cr8kWWG9NgVCJW1XTzmjWx3SnSDUmuXRjc
         XOTeLglIIsHBlhs8G3oM0lkUrn5vYRQfqZAYv052/s185bSPojrDqw/bpzUO22Dx08rF
         lL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KbSKgjGBdf4KEOeXodSJcKs8T6ae/17ktfaWjXxlBJ8=;
        b=Lb2Tj5ZQCTATGGFmUoOaEVwXcHAPBRfHSCQADC4JbSmKSlQ7oTvE5JzxcC1R4lVeip
         UrM+WYC8Xp4kaer1JYCtGgTgFajMUX3pTg0dDiR72IcY2fx8CIO8jqjLo+pejA2f3e7U
         WLP3dJAlc2FGamCwFd0rYeu00ySLbHRrqqNN7Hl+WskNZthttj1B3HJyoeldNnRMuSI9
         oG050y/xw5jgduBb0zBeH6i26lP6Q4a1OhFlBX22SPrelIrOMH48gK9NTRSU7olRKCUP
         oVzFM4ErBiCwbSMZMvzTmgNMCy1lwRX7aYFflFKqy2d98oGCBvJOz5QgYpyBZXlXyxMe
         V+hA==
X-Gm-Message-State: AOAM531TLAxz2LrVrrk5wdKIGaF7gtTDZdsDrRJ3cf4JNJgF6WlwnT1b
        XXYe1FhkPNuxYBKuYh1fzwOOW0Xcm4wbbB0ipLn0QQ==
X-Google-Smtp-Source: ABdhPJxm2hW6nb+D3mwZkaqgzCMj0wUpyApf9sWh3AsrG0FdNuL+hckoIMWtRXOHY2SyPi9ocnzjqjvcCqcP2Z70IDo=
X-Received: by 2002:ac5:c922:: with SMTP id u2mr4882514vkl.9.1633627633202;
 Thu, 07 Oct 2021 10:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqv945ng61.fsf@gitster.g> <xmqqtujkwsu0.fsf@gitster.g> <bc387e32-321e-4726-2a02-2e6cf6ed5250@ramsayjones.plus.com>
In-Reply-To: <bc387e32-321e-4726-2a02-2e6cf6ed5250@ramsayjones.plus.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 7 Oct 2021 19:27:01 +0200
Message-ID: <CAFQ2z_N6+cCSD=h989K=W+EF-PPmfx8E=j4zPLma2kXrSKsK=A@mail.gmail.com>
Subject: Re: Giving priority to the reftable topic (was Re: What's cooking in
 git.git (Aug 2021, #06; Mon, 16))
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 21, 2021 at 12:08 AM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> Just a gentle reminder that this topic tickles my 'static-check.pl'
> script, like so:
>
>   $ diff nsc ssc
>   ...
>   88a91,98
>   > reftable/generic.o  - reftable_table_seek_log
>   > reftable/merged.o   - reftable_merged_table_hash_id
>   > reftable/merged.o   - reftable_merged_table_min_update_index
>   > reftable/merged.o   - reftable_merged_table_seek_log_at
>   > reftable/publicbasics.o     - reftable_set_alloc
>   > reftable/reader.o   - reader_seek
>   > reftable/reader.o   - reftable_reader_seek_log_at
>   > reftable/stack.o    - reftable_stack_auto_compact
>   ...
>   $
>
> Which is to say, all of the above symbols are defined (and called) in
> the '.c' file corresponding to the given object file, but not called
> anywhere outside that file. I have not even looked at those functions,
> but (with the possible exception of reftable_set_alloc()) they don't
> strike me as 'public API functions'. So, maybe they should be marked
> as 'static'?

They're all public except reader_seek().
I added some more coverage, in v4 of the library topic.

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
