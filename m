Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C46C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 10:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6689F61177
	for <git@archiver.kernel.org>; Thu,  6 May 2021 10:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhEFKkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 06:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbhEFKkb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 06:40:31 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08878C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 03:39:33 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e14so4321186ils.12
        for <git@vger.kernel.org>; Thu, 06 May 2021 03:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yAQ+c1q9SRhi7G6foXu4+G3/QLaprk6o3sKnxngLN3E=;
        b=S2mi/Nl51ZJDcdHGCAwIQrAs1YZbT3J4SNHozOGwAm8LH63+PJ1X0bPKu+83lVE2I3
         HwSPlcyy1yv0vzcFdrssSCwqMDvKVskdZCOgcpEQpCNWhPM180fkur1zIp76cQtQREA8
         DjL5uFRswtafBbGZnrgLUiNBGYl5JYI/d0k6oYc9yTSn2wiSMyREROxUUUkUr+s2HUWk
         3gKZEMP9ztr5rK7Q0aw3BRhvVvM0pENdT0zaKXYBp9x1OgH6NVpzBoCyW2pcGwV0IjPR
         3Q8P18M6VobLztc3p3alTbILnzY55LJrMwVWmqOIUTgNEpOTJMNOmtKGG3OkSRpZ887G
         l7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yAQ+c1q9SRhi7G6foXu4+G3/QLaprk6o3sKnxngLN3E=;
        b=W2np5DXHzbXLz66ufwHI5kfLttTbHSbasSn10czkefS/ahPQn70SZaIazkQhuTq3OQ
         A/VQTck5PMaTgOFwpAbtNUY/omVWd3Kyix3hUsNp7FY/XsrVFex74toiLMB1nj//w3v2
         SKlkobU39ky535enGJRhFZaHYYpnRtz/oyMhhmKBZKZcey6L49iuI8TOSc4yUB4rAOz1
         oQWrndgEPwLxrQTtXRT0VGS0KVriX+NvltM3oXwxdQUDmoGYSWA4ng2aTZ/w8t7FOjR8
         hrZA0ces0LkgOF+GtdxVfWL42qUw5a5g7+uzG7KADXzVUyPb1+fyim2PVvtlatOdqLHx
         6Wug==
X-Gm-Message-State: AOAM531Ngi/nSdwx15RqWdvUwpBM2D4dVCRJn0s8SSgggd07tiY1oEmU
        xYY0/zwf/WAuxPUJdiEGKqAx1AyPYOtg56pwI7+ihzlRr1wvwe6iy+qAuw==
X-Google-Smtp-Source: ABdhPJxgD5IX9reV2sdhr6ozzDR7j7Kk4kyOx8WKvznV5zjmBpv7bwdg2aW+waXbKECi+pcQE8cdKMRlyzVirubsG88=
X-Received: by 2002:a92:c7a6:: with SMTP id f6mr3539844ilk.17.1620297572506;
 Thu, 06 May 2021 03:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.949.git.1620228664666.gitgitgadget@gmail.com>
 <xmqqfsz01vc2.fsf@gitster.g> <CAOLTT8SmvRaohV+v2C9eFXyc8O+di5PfZJeWNinmm8X=Ckdveg@mail.gmail.com>
 <xmqqk0oczao3.fsf@gitster.g>
In-Reply-To: <xmqqk0oczao3.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 6 May 2021 18:39:17 +0800
Message-ID: <CAOLTT8S9TbRWGPeGKR9=cDnaw2RMukawV48dPEK1KL0X_87udA@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: solve bugs caused by enumeration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This time you avoided the word enumeration, and it made it clearer.
> The word commonly used is "condition" where you said "judgment", I
> think, and wit that it would probably be even more clear.
>

OK.

> used_atom.u is an union, and it has different members depending on
> what atom the auxiliary data the union part of the "struct
> used_atom" wants to record.  At most only one of the members can be
> valid at any one time.  Since the code checks u.remote_ref without
> even making sure if the atom is "push" or "push:" (which are only
> two cases that u.remote_ref.push becomes valid), but u.remote_ref
> shares the same storage for other members of the union, the check
> was reading from an invalid member, which was the bug.
>

Yes, that's what it means. I got it wrong before, of course used_atom.u
is not a enum, it's union.

> So the fix was to see what atom it is by checking its name member?
> Is starts_with() a reliable test?  A fictitious atom "pushe" will be
> different from "push" or "push:<something>", but will still pass
> that test, so from the point of view of future-proofing the tests,
> shouldn't it do the same check as the one at the beginning of
> remote_ref_atom_parser()?
>

I think it's not necesssary. Before we call `populate_value()`,
`parse_ref_filter_atom()` only allow user use atom which match
 "valid_atom" entry fully, something like "pushe" will be rejected
and process die with "fatal: unknown field name: pushe", so it didn't
pass this "starts_with()" test.

        /* Is the atom a valid one? */
        for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
                int len = strlen(valid_atom[i].name);
                if (len == atom_len && !memcmp(valid_atom[i].name, sp, len))
                        break;
        }

        if (ARRAY_SIZE(valid_atom) <= i)
                return strbuf_addf_ret(err, -1, _("unknown field name: %.*s"),
                                       (int)(ep-atom), atom);

> Thanks.

Thanks.
--
ZheNing Hu
