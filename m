Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501F3C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEE12068D
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3WUv0v7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKWUfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:35:47 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:42697 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWUfq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 15:35:46 -0500
Received: by mail-qk1-f171.google.com with SMTP id i3so9364970qkk.9
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 12:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LH1LoCoLwKp9cvV+wZCaIUiwGjgdIMuJOheFx8lwG7Y=;
        b=Z3WUv0v76+RUOhjuLK75hWfq6H0NgB1JimSC9jCLRihShXbbsVReSkPawB/Vtc2fbe
         j1D3yoZEukJIrTKlN3v9aAX1OFsRDei551zE2OHlHfojeUFW0joPQtDFsoIMEwASVbby
         aSC5ZT1wHa0nAlclfp0JXuAQBR9xCDyGKx11ATdKBM6X/HNjHMk6+wtJ+UOtMSMBozc/
         TYh/+lo7PQ+6uYJHURdndA/xBJFHXAZfXWrDszyqtr4niMVqX28fcEixhViybbmVccTj
         ExeNdgfXzp/cSSchAAln15eSz0w4dFyqlD1588wf7hc24SrH8g3MR1x95J6qhIzZYKeV
         9j8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LH1LoCoLwKp9cvV+wZCaIUiwGjgdIMuJOheFx8lwG7Y=;
        b=R9f0phDDiqoLMNK4Zwl6zlFKwMWDkIgfE830Otr7H32uYAS/evW4U6Bg++qEGEmWXM
         9H6sAJGriSyrEVj5j5aXR001p9wc2q0nNHBCNZ6u4F8uHbkkR7JOsTaPXFisG1n1nM+f
         3TlvOqUhLW6IqjQPcZk0CGrigPgp6yeoi7l1TnTjLlg4U2QF4PVJh9RraYffxk3B4qYv
         1bw0VgwXjxlmsucVprFOViRIQT6zAIcHwqlyeW3A9jMd/53c6L3RB7XLY/kYXvyv1mXw
         KTYx/DdXohWgedtBWvcN1IgL9+IbeUE8FFvmOZUdL+yh2vAnLzg7OIovykVMwK2Xzemx
         ASUw==
X-Gm-Message-State: APjAAAV4mN3B+9LqbEnj4GSbVAPEaBRNN/ENRKBElMG49KfGR1P+8GLa
        OU8uWmUmF4tXTII5ywR2QQxZrHum
X-Google-Smtp-Source: APXvYqz+B0FR0+wBm7g4QO1bV4joeK/gFEPo91ukdmx8Nz5AFVpmyslWY/yCnuUpWJDsk4N2hb3gTg==
X-Received: by 2002:a37:6643:: with SMTP id a64mr20489847qkc.144.1574541345731;
        Sat, 23 Nov 2019 12:35:45 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id g188sm861607qkf.105.2019.11.23.12.35.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Nov 2019 12:35:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Nov 2019, #03; Tue, 19)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 23 Nov 2019 15:35:43 -0500
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <583211F0-7B22-4E39-8C2A-A5568EF91E37@gmail.com>
References: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I think the last sentence of the merge message should be "This has been =
corrected." instead of "This has been correct.".

Philippe.=20

> Le 19 nov. 2019 =C3=A0 02:05, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> * pb/no-recursive-reset-hard-in-worktree-add (2019-10-30) 1 commit
>  (merged to 'next' on 2019-11-19 at cdfb0643e9)
> + worktree: teach "add" to ignore submodule.recurse config
>=20
> "git worktree add" internally calls "reset --hard" that should not
> descend into submodules, even when submodule.recurse configuration
> is set, but it was affected.  This has been correct.
>=20
> Will merge to 'master'.

