Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84346C433DB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 02:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 472B461976
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 02:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhCTCz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 22:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTCzC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 22:55:02 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F47C061761
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 19:54:50 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w70so6856091oie.0
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 19:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NaBxrPcv6rmq5iE98LqpMzSIQez2gQzLm0E2/M8ykso=;
        b=mVk6Y4AqxCLdhT1bsJeKDBtffqNp4Dwk/jtRXljlBrTNrFMB68VRoXYZUPYF4rTasf
         ZYTpAGeumkxqIWPuHYhXFckcr6ObIpBexdLKZMs2my8POYq+e47SM2KW7Dy3ulkZpJ4T
         LUC7Zcy6jc8nCfoNQRP795lXdh1v4FlXDnk6jF7NrWCYlGlv7Va+MF0GgxJo1guU3w5c
         +pnA5cYozG5B1MTPdHN7/q8RUhAXSCeIptNlIvmz+AVovvdBfKExoeFLHZwXr8NCqoUX
         6Adv/d7k+poZ8t2KOXIROG2HSrlTjspsrwVq7yDLVZhcqDFmwa8m8mpgdQ6AzsU9UZ89
         8qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NaBxrPcv6rmq5iE98LqpMzSIQez2gQzLm0E2/M8ykso=;
        b=QjQO5dpOqw7ykjeR4ev0YvPD8coZFArtN/B5Scja5GFDP5DpCM6EEhr4H0xQ1xFQ0O
         c4XhfT27llsHrQ7Yp6FJb6UR+68KViBUX32JO4nLfRxyqoxkRZjfbJEiHevjZ6WHdUP+
         gE/DpkL0k8rwI14FQc8aCRsHcOAbs1+8ro3+pbe/6jXPKCAeQ9tXZWJ5FhdeJEQWf1ol
         AnMDvxzzvk9jaPNptha51H8+g9K9JNR39BVHCjmS7jRt+Ww9KblOhZYypWc2mJO0EdNl
         cvFNYxN+sDMz7iWaxR1Xz32lQf+P6tzXgzWxEgghCGfrs0MGrcp10BvICAYs8muzkizc
         wU3A==
X-Gm-Message-State: AOAM531Iyze4I73o/t0m+elIFWP5LtaC7rKN09XXhckle4ybb3CSg3/v
        WVReBrXqtrtwTzGI7g97p0QQeyTrTyHg4cHLckSLdfln3lUXJQ==
X-Google-Smtp-Source: ABdhPJw9jlErsRcf2h3In/A9xjMqvskyDEnqV1XAPbWkzXG6jEcmeCcBmk8Osqxs8hznrpppOXnzvcnCKPJXMRl7004=
X-Received: by 2002:aca:d68e:: with SMTP id n136mr3187396oig.179.1616208889872;
 Fri, 19 Mar 2021 19:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
 <pull.901.v10.git.1616066156.gitgitgadget@gmail.com> <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
 <xmqq1rcctgj7.fsf@gitster.g> <CAOLTT8RzvQzD0baWPdJzRLK3Q+WeJR_HNA4RVHMxRmwHeym9QQ@mail.gmail.com>
 <xmqq7dm3p344.fsf@gitster.g>
In-Reply-To: <xmqq7dm3p344.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 20 Mar 2021 10:54:38 +0800
Message-ID: <CAOLTT8TQdT1PkdfuOk92U89Lgk9o_YhdeMyHb6SrE7GW+6PQJQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] interpret-trailers: add own-identity option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:36=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > If `--own-identity` is mouthful, is there a better name?
>
> I originally had "perhaps XXXX?" in the message you are responding
> to, but I hoped that the message, especially the examples at the
> end, would be sufficient to make you realize that the option itself
> is not such a great idea (an additional ":@gitster" in whatever
> syntax used would be even shorter than "--own-identity", and
> obviously more flexible in that it can name other people).
>
> If you really want to have this option, perhaps call it "--self"?  I
> still do not think it is a good idea, though.

Fine, If this option is really not particularly useful, I am willing
to give it up.

I am looking for how to extract each author or committer from the log.
I just know I can use:

$ git log --pretty=3D"%an %ae" | sort | uniq

get all unique author <email> from a git repo.
Is there any function in the source code of git to get them?

I notice =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason mentioned `.mailmap`, I hav=
e seen the
 `.mailmap` under git repo. Would it be better to extract the author
or committer
 from  the .mailmap than to extract it from git log?
If so, the operation of the trailer may depend on the contents of `.mailmap=
`.
If there is no `.mailmap` in the user git repo, then the identity in the tr=
ailer
cannot be parsed.

Thanks.
