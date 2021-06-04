Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07909C07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 11:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4F26141A
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 11:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFDLCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 07:02:16 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:35379 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFDLCP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 07:02:15 -0400
Received: by mail-io1-f47.google.com with SMTP id d9so9577037ioo.2
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uOmmderSsmYq7v40c6oYPQPgZ2V45LSwxmy8Tw9HUz8=;
        b=C8yOAP4U2gyQCYA2Bc/rr9oh0OxKzr2KMBwjlReQhgbO4V3Nv+LOzoxM30cEi6GKZ2
         kfqZfk8Ry7C5j+NmMUFLIvwTiQRuezhEf8LlQmVbH2jwN/2SiQEQuoe2kSj7WXAN4sUe
         cwkyVJsCc4sirGPMIn7vmk0gCc/DizZVxtx/JxfWaDT8MtX1jK20Ng2dSOjk9IKPj+4H
         OFFEtwwnxS1op/2pcWmd3K/EDSv11iMC03pnul/NzwIS61MwDYgF2VEoBidus7fJ1Anc
         KpFl4XfJ2ddpVRVlYGHhJDOlMHvtvTmQvj0Stz55E3VdAflNSO5pgzpvtM1Y+ultgLhZ
         Q33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uOmmderSsmYq7v40c6oYPQPgZ2V45LSwxmy8Tw9HUz8=;
        b=p/rH0V7vb03z9PAq830qn2PW6glhC1lf/h7lYHUXSqNXp2qQEez1vAVKTiaA6QBmem
         9JyJluYMmSq3zILp5DGjdZX/E19RmJgLsIammCqGv4Hb4hzC4jjNd5CI3D4cVM1Odxat
         WvC58mSUxoJJHTakseL8JFZ1dvart51XiWOc50bZgZcpz2jmZ39MRw38O0ijBplGX3+r
         cJy4sWhrXPmLs+lRpgIsWsWE6O3jHqLxKT6d6zuZoeb4q+MqoGA+H0ViGRBtlaCqc8eq
         TJ3U6FpdVYULfTabhGWgPki2fx4bWpzSHbRefHiqSEfxSHqkTNVkRINmsYXp0SwBo2TR
         ObHQ==
X-Gm-Message-State: AOAM531naEZmF9oCiNaCkkxS/53xkHu6w9w9BklmqlQrZDooQ5rWsW1k
        TBlgCq6VzA7J9FF8jVF5ntdKP12+oCmhd0xsmVQ=
X-Google-Smtp-Source: ABdhPJzJjht1IiquV2BsU3G6yvl6sxf5KOJrJ48v5linQDfJbOK9izbMU/IY5YyuWA5McHEEUvZIjKJxAynCl783PbA=
X-Received: by 2002:a02:647:: with SMTP id 68mr3481529jav.29.1622804353642;
 Fri, 04 Jun 2021 03:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
 <5a94705cdbc101169488919e35613d723e6ec581.1622558243.git.gitgitgadget@gmail.com>
 <xmqqsg1z65b8.fsf@gitster.g> <CAOLTT8TiyAtJfcrPoBF6SECfaKOTKt24NSOtTmf84JwHrU8g1A@mail.gmail.com>
 <xmqq35ty6391.fsf@gitster.g>
In-Reply-To: <xmqq35ty6391.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 4 Jun 2021 18:59:02 +0800
Message-ID: <CAOLTT8SX-Ae-WrnXkGQPXA4dVdfX1VDKC=411L__DUkJc77d-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] ref-filter: add %(raw) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=885:35=E5=86=99=E9=81=93=EF=BC=9A
>
> The point is that you can piggyback existing string comparison
> (which is called "parsing") and use the parsed result (i.e. if you
> can compare with ATOM_RAW instead of adding another strcmp(), that
> can be a better solution).
>
> That only says using parse_sorting_atom() and relying on the check
> in the function is still too early, and does not necessarily support
> the posted patch that redundantly runs strcmp().
>
> After parsing all the command line options, we have used_atom[]
> fully populated and we know what host language we are quoting the
> result for---and that makes a good place to check for comflicting
> requests.
>

Alright, I got it: we can perform related check in verify_ref_format(),
after parse_ref_filter_atom(), It is a good checkpoint.

> > After all, the reason why this must be done here is the ref-filter
> > original logic
> > has not considered rejecting a format atom and an option.
>
> That is something you can fix to make the code easier to follow, no?

You are right. ;-)

Thanks.
--
ZheNing Hu
