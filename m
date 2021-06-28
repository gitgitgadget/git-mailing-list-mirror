Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E46EC2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 07:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70304619C4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 07:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhF1HiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 03:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbhF1HiN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 03:38:13 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595FAC061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 00:35:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t9so14726931pgn.4
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 00:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f10tXb2or/EVta24haAfqSyTvpkEHxVf0SLYkzhymBk=;
        b=SQ0ZEcUOKsYMI049KC9vIV8kWu8f8NMdIXEP1RqmY1EbBGx/1KAlIKW0vmg2j6Hgm5
         BYNhBl6TE6IUThHbCVLEbVwLzPogNTlfyTvrph71UpXEeEkQOIcuSmxrlNpvUXWTYItz
         WP465gSzsIe0KCHnuwjUUJGhZfvb0/HK7sgDa+JQcrb5TEKp5U8O8g351+vkYfevshlL
         dijuRTO7c5jqDcjU48N/k/s4YyZ+KP+W4Z+zI0iFS6mXiQOkMTEiz8A9Qn5TOMDPs92g
         YmZ69k/pYMJr3BlkIZUVj74D1VXg6q5ByPgWZnpii2DEbkC1DnpZAwTNk8T4PeAAhDUu
         vuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=f10tXb2or/EVta24haAfqSyTvpkEHxVf0SLYkzhymBk=;
        b=QYNNeSPoHmsfiDBEwx2GlIEFmvCiSFYEy63aQhNNC/N1HVTeM6DSqaqel5uzLdwHvj
         uk8YwGsIUBSQvzU4lUsPhzy+XLt+vOdGOlURzs6vCL3BCvr6xRyPBHKYrQr5EG/AWxns
         wAdwZ5780HPd1j32G3CYFATYYiz0D3Hd57nTuaaxIhccrdbWJgCHrW8GZdcxLnZXOraZ
         53nGXeIlqlPg6jPk6ZovvdgrzXW/kEADEQQJc5kYVNriMDJiTaf1kxYivfpR/qSpNCqV
         ojvdBr3bZ2fSYQyJmoccwQhx5w0msQD4K05QgcpqgOA8qdLJ6KZarljWg5nsK0k7id14
         LJ6w==
X-Gm-Message-State: AOAM533EelGRRreYVjsNVCZJCYg9AnyjF+gd9Q5JCD2rR8pN3E+eD0r3
        jKR1OW0WgiMvnLKf6losHTU=
X-Google-Smtp-Source: ABdhPJzTt6ZeLUqE8j8L13EOYCYU/87aS+5g2eCrMTgEElqSB+m0GHJYSEjKK0XS3Y1FTsAHKxu7XA==
X-Received: by 2002:a63:471f:: with SMTP id u31mr22248626pga.85.1624865747913;
        Mon, 28 Jun 2021 00:35:47 -0700 (PDT)
Received: from smtpclient.apple ([119.82.122.143])
        by smtp.gmail.com with ESMTPSA id x17sm7208986pfa.26.2021.06.28.00.35.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jun 2021 00:35:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: =?utf-8?Q?Re=3A_=5BGSoC=5D_My_Git_Dev_Blog_=E2=80=94_Week_6?=
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <60d8aefdb7f1a_ba9f3208ca@natae.notmuch>
Date:   Mon, 28 Jun 2021 13:05:44 +0530
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6305ED7B-0C92-4C14-9F75-2EC3B24A6D2F@gmail.com>
References: <4E38928E-A98D-4F57-8866-8A237B31DDE0@gmail.com>
 <60d8aefdb7f1a_ba9f3208ca@natae.notmuch>
To:     Felipe Contreras <felipe.contreras@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27-Jun-2021, at 22:31, Felipe Contreras <felipe.contreras@gmail.com> =
wrote:
>=20
> Atharva Raykar wrote:
>=20
>>  * Reflections:
>>    - How does Git even start?
>>      =
(https://atharvaraykar.me/gitnotes/week6#how-does-git-even-start)
>>      This was just something I was curious about, not really =
important
>>      to my project. If anyone knows the answer to what I asked in =
that,
>>      section, it would be nice to know!
>=20
> They are not all linked together.
>=20
> Take for example shell.c, which will be used to generate shell.o, =
which
> is used here:
>=20
>  PROGRAM_OBJS +=3D shell.o
>=20
> PROGRAM_OBJS is used here:
>=20
>  PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
>=20
> This means shell.o will be used to generate a program called =
git-shell.
>=20
> But the "git" program will not use PROGRAM_OBJS, therefore it will not
> link shell.o.

Thanks, that explained a lot of things for me, and I noticed
'git.c:cmd_main()' does indeed call these separately created
executables (like git-shell).

I'll try to update my blog post with this explanation when I get
some free time for it.

