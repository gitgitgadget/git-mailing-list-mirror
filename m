Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7F9C4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 06:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E446C6101C
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 06:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhHGGcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 02:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhHGGcU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 02:32:20 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77205C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 23:32:03 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e186so14297379iof.12
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 23:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+24yVhY8iyI1okx3s4+nm39u29Q6Cn9zVAUXNEX3xrA=;
        b=sK6Dhoiyt3049CMBQcofu8hoNTOk6KuR3cM+5GFEG8P9RTtQ97kmA8bcGKZ4D+u6uP
         KD3CGxNFWIcdAxTxf3r51CpO2nwtzPxBlpB9gYzRaWLMGkt0Az8CRV+1blU2ECBQic6i
         FfTLTxMTSMvHmJs8A+UVNLer+iWJEvHZKxk2NpGbNuwAwwlrZ7/b3VthOuQ4gWJuHdqH
         fNCBm0SH9yXJ/wLORZraZXL/swz8sgPUNTOwfUlNEIPQ61FC8SSNNuw6zAsPr3M1ijwF
         j7reYcr4+MUMU5PAugq7BIVLVcGjN9OrvN4rcAmX7nNvobGYWCVf3QMBh1QmroSQrUeY
         nsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+24yVhY8iyI1okx3s4+nm39u29Q6Cn9zVAUXNEX3xrA=;
        b=JHhOimDrcdDa1diw/vR0Eu0vvjXMX7hmNzc7EQie/aJ0/QngI5lm0jp/I4r1wfb+Xf
         /k18SA3vtOyTxEUnOX3xUdDKmdnQ+lbYutOyBFxQuX3Ili/UBw+3l0MjW13CK7JmUfSp
         fNA4lyltDclud5+5kYXhExPd8cQK9xrIkbQ32PfGDS8CCy3ZFyAxLd/EwznBUE+x4rpb
         k6WwRxwFVoKEZYPJ+UZ9RHKRsD6TEymOfgRZLbUYgexbYChhwc5P8qVPegoFl5mZn41s
         cReY9SpVYf/UZGdU15zu9610Qbb6BTSy3eqApp0bDFFLmiyT2oCdNEEWsjc7VkTkJbSO
         RAGQ==
X-Gm-Message-State: AOAM53286PlA6cWHmFbS0Fxrn4SA9ruOhT4WC4U36US+65uj7fi3kBRr
        hzaYVFTzRzbuP/eA3ZYygeHpYZ4oUPvj1fZNXRg=
X-Google-Smtp-Source: ABdhPJyeV3O/VCJVGVuWcwjzoKkSzBaXAgn98ZSBrdL7JGhWMebQ9MTIvPQKYKoK22mOZvmg3VQ5FLUJIpKigsLlucA=
X-Received: by 2002:a05:6e02:190d:: with SMTP id w13mr66052ilu.53.1628317922906;
 Fri, 06 Aug 2021 23:32:02 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 7 Aug 2021 14:32:51 +0800
Message-ID: <CAOLTT8Q8BEKCVwPDypW1w66P9_xP7QC0T-CnLqamqAL4haGzwA@mail.gmail.com>
Subject: [GSOC][QUESTION] How to parse the properties of the object at once
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys,

parse_object_buffer() which will call parse_tag_buffer() and
parse_commit_buffer()
to parse object data and store in `struct tag` and `struct commit`, which can
directly obtain the parsed data later by something like grab_tag_values() and
grab_commit_values().

But parse_object_buffer() will only parse part of the object data, so
that we need
some additional parsing like grab_person() and grab_sub_body_contents() in
ref-filter. It is a repetitive parsing and will affect performance.

So I am thinking if we can add some members in `struct commit` or `struct tag`,
so that we can get more different types of data in the parsing process.

At the same time, these parsing are optional, which means that we can set
several hook pointers to decide whether we need this type data, like
oid_object_info_extended() does, in this way we will not bring a lot of
performance loss when we don't need them.

But I find in commit.h, there is such a comment:

/*
 * The size of this struct matters in full repo walk operations like
 * 'git clone' or 'git gc'. Consider using commit-slab to attach data
 * to a commit instead of adding new fields here.
 */

This means that I shouldn't touch the content of struct commit. So I see the
code of `commit-slab`, it seems that it is doing additional parsing.
But what I hope
is that let parse_commit_buffer() can parse commit data only once.

In addition, I am thinking about whether to build a huge "struct object_view"
to store the parsed objects' properties states and results.

Any good ideas?
--
ZheNing Hu
