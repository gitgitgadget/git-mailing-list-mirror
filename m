Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE6CC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 17:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiGURWf convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 21 Jul 2022 13:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiGURWb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 13:22:31 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE86D743C0
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:22:28 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-31bf3656517so24305237b3.12
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 10:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/OfU5n+3e/NMoeOunVatIs8I0XixPJZFtDKuLuHEimM=;
        b=Pmv1SfEaeH2nHDnoESB8yIq8nqeVKeKCLz4jAXsqoKAQnZ+skEpBlBtfeU4O5MC+xv
         XTKPFIP12uAzgqDQozT9R8wapfJcSVCc4iTcpZt/j3Oz6rA/ae3wD/ixaUcZZBl/8IJV
         VFPSal4TC36a0G9XhY30hqKqTwby+xE9//63iYHqY/odJdJWpRBTsJfO03uZD2AtIPWV
         SrwwdvUjvzhDoDnPJFbuCbyUrQOIiVXZHC7UAM7/H+UOp1IKHBdHJ5ODGsHaCMV8l+fr
         fx8I8OhWOYA4xYtSSIokcPmV1byygkAMzglgOFFXQdBzO3huczWYBXC8lWsgsOcNcuMA
         DgFw==
X-Gm-Message-State: AJIora+yUruC30EYtHr20FUbQHWbm3k1I9lxCs9WQvvkGBkrpq8CllOT
        MhyFQ0R3zNcBPggS+qc1Z3qnAFJl6WQa0XG7WwE=
X-Google-Smtp-Source: AGRyM1vaOyUtS0fHrDeHVRf96e6q72JBtkGJX/qDxCZal6buAZE6yiPj4sqfQPjwv8DkfnkEbK4BEtDd2tOkJsFhZRM=
X-Received: by 2002:a81:4a89:0:b0:31c:cd9a:c875 with SMTP id
 x131-20020a814a89000000b0031ccd9ac875mr48962730ywa.411.1658424147855; Thu, 21
 Jul 2022 10:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com>
 <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com> <xmqqbktj3ct7.fsf@gitster.g>
 <220721.86ilnqtq8f.gmgdl@evledraar.gmail.com>
In-Reply-To: <220721.86ilnqtq8f.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Jul 2022 13:22:17 -0400
Message-ID: <CAPig+cTAnVjk9gepW33AW9SSpCTJ7FpNSaB_7M-wV+tTe6D04A@mail.gmail.com>
Subject: Re: [PATCH v8] ls-files: introduce "--format" option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 12:07 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Jul 20 2022, Junio C Hamano wrote:
> > "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > It's been quite many iterations, so I'll just comment on the range-diff.
> >
> >>      -+                      usage_msg_opt("--format cannot used with -s, -o, -k, -t"
> >>      ++                      usage_msg_opt("--format cannot used with -s, -o, -k, -t, "
> >>       +                                    "--resolve-undo, --deduplicate, --eol",
> >>       +                                    ls_files_usage, builtin_ls_files_options);
> >
> > Looks good.
>
> Although a nit I didn't spot before: missing _() & this should be marked
> for translation, surely...

Probably also want: s/cannot used/cannot be used/
