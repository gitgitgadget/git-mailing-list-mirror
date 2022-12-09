Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7262AC4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 04:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiLIEqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 23:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLIEqG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 23:46:06 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF0731A
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 20:46:05 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o12so3646346pjo.4
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 20:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4jbwM5pjFby3k4r1oGEDHq65VPV3qQvu3QJY812Z6U=;
        b=Px/aLUBaZQ1Dc794afgCy5/97O8eoUulakCzORSv/szUWfIyWyiFky8rMhCdGkW0LY
         gvRHYW8oincLG+4/jTMNzB3cO+SZYcTnoAAPRHxQYgwuEMfEpkOYnRpdhLsyXQTFaX6h
         WYIcSG54Aj54J10IkSbT9/kX0pHx3DD/rHAvDESTwXDun+q3PBHtMtBqL1aYy92S9M4n
         OxDGctMdRQ9rb8NP+lDIeNBYrzIxhQIuHtsDxHo4jGyYgpv1XZHh+jO2G30szPZGLgQv
         wsrgyhhykzromh+NlYFh5DnNr/ddC5giFheG9lJvs34RaYBPg0Oh85e2vhlWzoVnyU0K
         C73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4jbwM5pjFby3k4r1oGEDHq65VPV3qQvu3QJY812Z6U=;
        b=3Dd+8CEEvR8KJCcubMq9NvOKDhzeMjCS9rt0DmyvT/EpG0FvUzB41lXKlA75EArWVc
         6AyYOWovRoPT4Rm5VQCWWA4UYCCWz+T55Jb9FkCPRE8T4Yuv+CfGpmjF4Gz47lbOAFCn
         znwYfyLqmEbsZ/iGmvWuXFSGRoiGkM5CaWNhxnvHQ088b13eTWl2cnVYjp1T2GoH4uxh
         j8nNsHGMd0C2dpWbPZ6HA8OTczn5t+grNQb39qGvfqF4EgA39X8D1PIjambGFJw1qzHB
         /CzaqbY7CaYDqyJaBd19vjkljVjQB2PUYVjP/grpUl3gJCgZiDsiWtRhx3Y+6dAn3ry4
         khcg==
X-Gm-Message-State: ANoB5pk0gNudmO+eV5Vqy4nAnoKaX1zXqaHJICQff43QlV3Oyv8s2HqK
        Jvfel3PxnTB3Qyz0QV6IX+NeKS+hRhUEoQ==
X-Google-Smtp-Source: AA0mqf5pA9aDEDPeJ95MF0I75z0d2mOxuhZiJ7/oKN5vuUn0+HXw+FhW6/LHf+bIGH0Yj/ESHzleNg==
X-Received: by 2002:a17:90b:264d:b0:20d:bd60:a0de with SMTP id pa13-20020a17090b264d00b0020dbd60a0demr4453214pjb.15.1670561164827;
        Thu, 08 Dec 2022 20:46:04 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a030500b00212e5068e17sm276681pje.40.2022.12.08.20.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 20:46:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: "test_atexit" v.s. "test_when_finished"
References: <pull.1425.git.1668999621.gitgitgadget@gmail.com>
        <97ada2a1202190776ce3989d3841dd47e2702316.1668999621.git.gitgitgadget@gmail.com>
        <221206.86ilipckms.gmgdl@evledraar.gmail.com>
        <CAPig+cSfvgu8XjvmmAkFWe1G1VDRgrcx5GjUhr4xSDqoJ4cZOA@mail.gmail.com>
        <n2586428-1r80-9s29-8345-7p2opnor5086@tzk.qr>
        <221208.86fsdq6nci.gmgdl@evledraar.gmail.com>
Date:   Fri, 09 Dec 2022 13:46:04 +0900
In-Reply-To: <221208.86fsdq6nci.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 08 Dec 2022 14:14:39 +0100")
Message-ID: <xmqq5yel18xf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On failure we'll skip the cleanup for the current test that just failed,
> but we're not distracted by scratch files from earlier tests, those
> would have already been cleaned up if they used the same
> "test_when_finished" pattern.

Yup.

A big benefit of using test_when_finished is that the knowledge of
what cruft needs to be cleaned is isolated to the exact test piece
that would create the cruft.  Instead of test_when_finished, We
could use the other convention to clear what others may have left
behind to give yourself a clean slate, but that requires you to be
aware of what other tests that came before you did, which will
change over time and will add to the maintenance burden.  And to
some degree, the same downside is shared by the approach to use
test_atexit.

