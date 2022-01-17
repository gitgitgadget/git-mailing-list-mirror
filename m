Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23210C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 06:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiAQG2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 01:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiAQG2B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 01:28:01 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AC6C061574
        for <git@vger.kernel.org>; Sun, 16 Jan 2022 22:28:01 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id u6so28724236uaq.0
        for <git@vger.kernel.org>; Sun, 16 Jan 2022 22:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+I4zE2uHzAeGwH72xNc2+Al2NlM5qk/slRFLJEdQCI=;
        b=lQ9pX6JtCB7TSuodv96n/5686aP+HPRm3ksAlaoy4rkrz75/UESrXRPl2aVBAc1mUu
         iSZ0pbPwBF2oln45jl1yFOkQ6qUnnkQ+lpHF0WhLWIPHmBUXemGV9Bl3bJvavWyexJMd
         E7RD1IA7/3cGcs9y5/wgi18RB8nTJYkAJCFufvZPiGR84eT1zl9ipolh51QSpNMZydUG
         GgLdfskEdYrwcbEtVjMNe4gXiLE3DnQIsmliawfW2HqR/Ocoz7IJwZCOc9AbLapdu3Rl
         7o0t6Nqf4GEYQeXSI2inXF/whj1FG158nmoNMFR6u0g6xqMW5QTSCVs9DctOPrLjgzCy
         ia4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+I4zE2uHzAeGwH72xNc2+Al2NlM5qk/slRFLJEdQCI=;
        b=sc6Rgr9yHRTvGGb5s/77/bVINUELtuhv9RC2wG45Jgx5vOa5PGNPDnNTiP1BqvDD3R
         eUFCicX/yUQauX9IfS3Fris7rd6YGZEEOTF6rPRBI+JU3sA/b3JeZVjm18NuVClNNUGc
         hGE4blqEXAM1Q8rsIG6VsvSoBNs77PyPQ2PgdygwhbrGgerwTqBv+WFSbRynoDm6FA1v
         kghJeDG7Ox03ZP/gk6kBOTsSOtyDLostERcoziGdIgGbp3XqrLKzeYko9jSeCswpubKl
         AhbLzMTjaZxWHWjxuTO56tn/F8AKKcla3S5RFbp94FJpK5Y/G0DqbSMBN1+0q5KfDL8a
         nyTg==
X-Gm-Message-State: AOAM532btKPd8gsrVAtk4zisbmATom4tugPlj2KjekDqeYbceHWuy/T3
        my3ErIrVOKCPLrvFOJUOwz4mplGeKsNpA7H5TUHjo7yizlvru9wYKCU=
X-Google-Smtp-Source: ABdhPJy2HCm9etxpiUjeyjsjzblqozgx6Pecfi9/zfaxvl0l3h2dpULAUoy0OXt0l/dh3xa50IoaANydLHgYPEZtuK0=
X-Received: by 2002:ab0:4927:: with SMTP id z36mr7322084uac.29.1642400879947;
 Sun, 16 Jan 2022 22:27:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642129840.git.dyroneteng@gmail.com>
In-Reply-To: <cover.1642129840.git.dyroneteng@gmail.com>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Mon, 17 Jan 2022 14:27:48 +0800
Message-ID: <CADMgQSSprxWTQF+knZVOFgdOtV56UaHD9bG4jDbC2z_=bXmuRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        sandals@crustytoothpaste.net, tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 14, 2022 at 12:24 PM Teng Long <dyroneteng@gmail.com> wrote:

> So I sent this patch to try to figure out if this was a requirement of the
> original design, or if it was something that could really be improved, or if
> we can find a better way to deal this issue with compatibility.

I really appreciate your comments and explanations.

Now I've cleared that up, personally. It's not a bad thing that there are some
conventions for use, the point is whether the rules are clear to others. So,
after that, I will try to modify a little in "git-cli.txt" with a new patchset.

Thanks.
