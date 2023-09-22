Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DCACE7A88
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 23:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjIVXNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 19:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjIVXNs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 19:13:48 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F786194
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 16:13:42 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c43334badcso26606285ad.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695424422; x=1696029222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=08Cyedgg5sUEYGC6tBltFmRntABvOET2Ok0hiAWYVaE=;
        b=yscvg6vVMAgWU821Ck8xnS6lHoKtDazW/G42XuILNDtntMSdoRWPQqfNzzKjrPh7Au
         CMy/gWxN9k2bxxaZMIbxY78Et4toG8GTFRCuywWiBfwRirvHQRDjspaAS+5bbnAUP4xZ
         fdBU+JMA4ZUwj2Z7R3PtpzkSXruv0d96gWNFGuky9RcWaDO7xEcM8QXWHadXUtv2gpHA
         3qHVlngLlQvEICEkAvqpgtD/J21nXOFHbHVfDwDP7aovv2cloGaxlJNqmXkUWL02a6qw
         YHGFxOkHaTmtITASLTwU7UJcdlbcMepBXEVb6/7ujB1jioyC/jyV4bFvooVQz6/6dzVJ
         PimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695424422; x=1696029222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08Cyedgg5sUEYGC6tBltFmRntABvOET2Ok0hiAWYVaE=;
        b=uiyIIERUPDdGBvY3XRzQrIIDaJ5EFenaRhfdGOKtVWo7got76OEE4EsgQWBfG4ewe+
         jeoZE5ngqsPDKeqGLL2tI+ndlMwPgyiRo7JTc02xiqp82MtITkazVHUZxBScldkqeQeG
         GRaSObn3riyY4geZxRFZfYmYCdqui0SEECvLwUkkYJdQxvLT52+F5stmPwO/Fr7zS7Vg
         KF63A/7VI2moIokT8+JeXmjVTvHVOnNav+8CKokcaN6JTyTUrPAtJcKzLNYMv2KgRrjp
         MNpX2MuQ5+Rbh7QZCXSY6Rd4t5eb9LFojwumcQOVyMru/gUukRXDYLGihfS5ALj9R4Je
         N31A==
X-Gm-Message-State: AOJu0YyC3nTTG6EzYPLzgGG7aqcseJiieZeoU0C/nQ7jgloa5S+EOTJy
        hjhpySl3xnpawcB9fdsGyB7wXst8mfM=
X-Google-Smtp-Source: AGHT+IG8RHLSn1+QJuLwL9QxUoYIlqrAkKFu3WjjnJ1HSWjrss5Azul9n9AZ7ky+tITYm8SFGK++KIlHVWg=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:e80a:b0:1c5:be45:ca00 with SMTP id
 u10-20020a170902e80a00b001c5be45ca00mr9767plg.6.1695424421682; Fri, 22 Sep
 2023 16:13:41 -0700 (PDT)
Date:   Fri, 22 Sep 2023 16:13:40 -0700
In-Reply-To: <xmqq8r8xyge6.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
 <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com> <xmqq8r8xyge6.fsf@gitster.g>
Message-ID: <owlyzg1dsswr.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 0/9] Trailer readability cleanups
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> These patches were created while digging into the trailer code to better
>> understand how it works, in preparation for making the trailer.{c,h} files
>> as small as possible to make them available as a library for external users.
>> This series was originally created as part of [1], but are sent here
>> separately because the changes here are arguably more subjective in nature.
>> I think Patch 1 is the most important in this series. The others can wait,
>> if folks are opposed to adding them on their own merits at this point in
>> time.
>
> Hmph, as we discussed, these changes have already been cooking in
> 'next' for some time:
>
>     13211ae23f trailer: separate public from internal portion of trailer_iterator
>     c2a8edf997 trailer: split process_input_file into separate pieces
>     94430d03df trailer: split process_command_line_args into separate functions
>     ee8c5ee08c trailer: teach find_patch_start about --no-divider
>     d2be104085 trailer: rename *_DEFAULT enums to *_UNSPECIFIED
>     b5e75f87b5 trailer: use offsets for trailer_start/trailer_end
>
> and I thought we agreed that we'll park them in 'next' and do
> whatever necessary fix-up on top as incremental patches?

Ahhh yes! I completely forgot. So sorry for the noise...

> The first
> three patches in this iteration seems to be identical to the
> previous round, so I can ignore them and keep the old iteration, but
> the remainder of this series are replacements that are suitable when
> the series was still out of 'next', but they are no longer usable
> once the series is in 'next'.

Right.

> I could revert and discard [4-6/6] of the previous iteration out of
> 'next' and have only the first three (which I thought have been
> adequately reviewed without remaining issues) graduate to 'master',
> if it makes it easier to fix this update on top, but I'd rather not
> to encourage people to form a habit of reverting changes out of
> 'next'.
>
> Thanks.

I totally agree that reverting changes out of next is undesirable. I
will do a reroll on top of 'next' with only those incremental (new)
patches.
