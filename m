Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C58EC43381
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010C564E85
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhBRMY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhBRKTT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 05:19:19 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD48C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:18:38 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m22so5654370lfg.5
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=q6cmxIVJzosaiOSmakdxX6z8/VSByxE9kkPyeLiko0k=;
        b=NklAKq5PzUxdcFpZWTQcwyMRhiXzXaJ8A+WWWo6ceZ8XSpe2N9yGkWnF7JhN9AVZ87
         qUBUEkx9/9PDfkuXqP9Nu6UbAWzZewE3VMIhQuPwIpeB6cPRylKLUVrZJmscfnv/68NP
         tqcbcO94UQPjqxesIcbH4h07lkG9As4gsZwoHuUC0O1BKFKp/cc05iJdnitZQTCeROjS
         noYDOqkigcY10I7/H3BGpIOYqph8SzWsyncub0LPPwT5VPoRdDzLn++4G3QCrERkVxMv
         AtwxvgGV2H33i8xSaeIlqi+LQJf/8sDHYwdk9Xj3Yy3yu+F/vguWg8QjLgWMLEpKe5kT
         uPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=q6cmxIVJzosaiOSmakdxX6z8/VSByxE9kkPyeLiko0k=;
        b=nS1c/ly6WkQwKGX8+NcYjJLHhUv5K7p9mGNeNr3EzrWNXKNOkhcyxVS5gI73VYcIvs
         bDUn0AIAChpKCtLUpUWB7CAZMUfgvLZqfYaQ8sd5sDQqEiyGbqpD6iIIGFQPfxG+vgYQ
         7pg8I8a7+hpYaqVXYE8r4qT0KmNMh0cQYGZ6/PjdY4ow4akBiH2aKeoEGeiOBDiNemL9
         n+ZkqhvaG9wxOt3gaoHb0JJh7RZK47LRJG/ufMda7BJpCfGFKCbwCaa+xKD2nW8+Q7WO
         Fi1MolMRUnEVIkW055tzvhUlB0x8Gj9JbT3LVsIux7dB/VpnOzm3RTy3vMcI1GJfmFDT
         2YFA==
X-Gm-Message-State: AOAM530VwV+ly5Up/aKAOi7qixM1vYLv/fpMmqY00HsKApofEUkhlwag
        4ML+DPa6E1NMBpnoqx4FcOuxOHSUstKaYFvjMJs=
X-Google-Smtp-Source: ABdhPJzESkiqtuU2t9Fe1zc2DRhxaZ//vza2HT8TniKdPr4NLQ+ulYekZ2Opwvh5MVHrPrDyk2x373NNowESIKenOfE=
X-Received: by 2002:a05:6512:388c:: with SMTP id n12mr2086688lft.357.1613643516812;
 Thu, 18 Feb 2021 02:18:36 -0800 (PST)
MIME-Version: 1.0
References: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
 <xmqqo8gksqr4.fsf@gitster.c.googlers.com> <CAG+K25NbifB9k9ugU5ZjLAOKxLyfEZcphfZXNS9_Whi6gZcBLA@mail.gmail.com>
 <xmqq7dn7rgi4.fsf@gitster.c.googlers.com> <CAG+K25NC3H7L5TpxmR_kCvmqR8GPdCEdTt740F34ON4TWoPCpg@mail.gmail.com>
In-Reply-To: <CAG+K25NC3H7L5TpxmR_kCvmqR8GPdCEdTt740F34ON4TWoPCpg@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 18 Feb 2021 02:18:25 -0800
Message-ID: <CAPx1Gvf1pXCp9YVQSQ1_-w3-A8qYZD7tsFV80njsXD-+Jap6Xw@mail.gmail.com>
Subject: Re: git-send-email: smtpserver in $HOME
To:     =?UTF-8?B?SmFuIOKAnEtoYXJkaXjigJ0gU3RhbsSbaw==?= 
        <khardix@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a small point here:

On Tue, Feb 16, 2021 at 2:17 PM Jan =E2=80=9CKhardix=E2=80=9D Stan=C4=9Bk <=
khardix@gmail.com> wrote:
> Well, unless I'm missing something, shouldn't the tilde above be
> expanded by the shell before actually being passed as argument?

Maybe.  Some shells do and some don't:

$ echo foo=3D~/foo
foo=3D~/foo

bash$ echo foo=3D~/foo
foo=3D/home/torek/foo

for instance.

> So I actually did my homework and skimmed through the relevant RFCs
> (RFC952 and RFC1123); as it turns out, no, it cannot
> =E2=80=93 only ASCII alphanumerics, '-' and '.' are valid characters.

Right: tilde and slash are both verboten. (Underscore is too, but
that one does get used and some programs allow it.)

Chris
