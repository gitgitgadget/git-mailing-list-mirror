Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF21C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4093C6100B
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbhFINNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:13:47 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:41559 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhFINNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 09:13:47 -0400
Received: by mail-pj1-f51.google.com with SMTP id go18-20020a17090b03d2b029016e4ae973f7so250770pjb.0
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hQN6KCtkxzuyGhpYrTXX3V6hLCWovNo5RTFMn8EZ6/Y=;
        b=O5/1k3G8jeLI22F/+qMOKUFdxkNL5X+IAuYxuNzfAfh4lF+Rk1uMM4/jw3fHgMu7PX
         mlS3GyxXx1Gujpmpa+cW7isdOttfJPZWzLCu7WJUyPbif7cVJ9OwrG4p1BBJW1F9ZUoK
         mxguBwaSnkD393Hh8ggrJYrgdxA+aKP3vyUTb4zlF4psUsW4LI+Vgtqfi42xBMU+oYOk
         Gdi5c25BZNQ9HB6dqP/WRY9NzOlePsHuEY9GxCn2F9IM9lL7bbeFISWQtGbE+4tvSPXZ
         6zRh5d1Yo/JnPR4wapWVriKIBnPzh8a7GKj9gulbYO15EGH5bvp25HEV/DNMzASz28Bz
         4Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hQN6KCtkxzuyGhpYrTXX3V6hLCWovNo5RTFMn8EZ6/Y=;
        b=KsETVaoRlBHNvK3gbKiVButsiJzszOxxhl8Ku/stwHfI2sNlW74wlN0N4GcIeJrsfh
         uuPiUuplYIgsV2i/d2hbdxxfdHhto1Atv9edywBlyktnm0wds0FkghrfZbq6PjUANo9T
         b9yzQ2qEg9B9Msc8mg3YLlv5mGx6fZxmWm+/FBbUMC66p0ZKdEf+3AL0buzvEpyvBmDj
         fi6PO8se1YLCopXnOXCAUkUvWHIC8wA2qFg13Wi1o9jlTqBMXDKZFAANNGCG4TxFgfhM
         2HCBzaml7G1Q7+skDcjVn9Uu4Fqyq3IcIdNszWCnrrknw5y0mOhrNnTqcW7kK0PEaDOQ
         tzkA==
X-Gm-Message-State: AOAM531x1mETZRHUTpZRalmwKm0LsbH2wdgA+MG9nUAjWCNHX3rJ/CdU
        WnyUtKBLjMUINl6YmH3ArUQ=
X-Google-Smtp-Source: ABdhPJwMJeAOfmBDj06DWD/BN1nuzYAs6g0OY1UFYPjGEX1L9l0xtbDS2PWT5liWlOi6HEEdAnX4Dw==
X-Received: by 2002:a17:90b:38ca:: with SMTP id nn10mr33038393pjb.127.1623244252545;
        Wed, 09 Jun 2021 06:10:52 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id w21sm9448159pfq.143.2021.06.09.06.10.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:10:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC] [PATCH v2 1/2] submodule--helper: introduce add-clone
 subcommand
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <YMC8upoajZm0QQ5G@danh.dev>
Date:   Wed, 9 Jun 2021 18:40:48 +0530
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <05339721-1CD6-4866-8A5E-368C9B379679@gmail.com>
References: <20210605113913.29005-1-raykar.ath@gmail.com>
 <20210608095655.47324-1-raykar.ath@gmail.com>
 <20210608095655.47324-2-raykar.ath@gmail.com> <YL9jTFAoEBP+mDA2@danh.dev>
 <3B9B2CD5-2B99-4BF3-B348-5766F1CEB6D7@gmail.com> <YMC8upoajZm0QQ5G@danh.dev>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09-Jun-2021, at 18:36, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh =
<congdanhqx@gmail.com> wrote:
>>>=20
>>> Overral I would replace the block inside capture_command with:
>>>=20
>>> -----8<-----
>>> 	char *nextline;
>>> 	char *line =3D sb_remote_out.buf;
>>> 	while ((nextline =3D strchr(line, '\n')) !=3D NULL) {
>>> 		size_t len =3D nextline - line;
>>> 		if (strip_suffix_mem(line, &len, "(fetch)"))
>>> 			fprintf(output, "  %.*s\n", (int)len, line);
>=20
> Fix-up for my suggestion:
>=20
> To be bug-for-bug with shell implementation, it should be:
>=20
> 		if (strip_suffix_mem(line, &len, " (fetch)"))

That is very subtle, and I would have definitely missed it.
Thanks.=
