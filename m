Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0D020248
	for <e@80x24.org>; Fri,  1 Mar 2019 13:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387923AbfCANqX (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 08:46:23 -0500
Received: from mail-yw1-f52.google.com ([209.85.161.52]:42162 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387620AbfCANqX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 08:46:23 -0500
Received: by mail-yw1-f52.google.com with SMTP id v201so13995913ywa.9
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 05:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=publicis-com-do.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jsJswuWfl4AhmGYNBuvLD0P1kOvj4NYFI9x4G4fVjvI=;
        b=vNsKjx8GoSP1GGNKeaMjq+CIBbLhU8bDFg0/Z35E92t/iDxzVPCDGb23BmYdbTl2/x
         KybFBUvmjXz2fDVSXtY0BcLjEWo0+r7JmKidWem8nzDjf3vXQ29LAXLSSrnm79NVsmGj
         B5o13sRCf8peQZR9NAvFKKYfZiDZ23L2HQsBIL7/ez3aEJweE4Yq5lRxV4AG/JlT9eCH
         kHhwjxBt+gLvHqt1kbPlHXQBg42q73+IMJy3r2HhPLdy2o/W3pitg078R5D6orAogxuz
         zs2p3a8Zflixo/zdqhaRjO9spctsTxy6JYTxFAbalD2jRzGuxdonKbLYpGASY63yXepj
         QMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jsJswuWfl4AhmGYNBuvLD0P1kOvj4NYFI9x4G4fVjvI=;
        b=RQ+Mi7nVoqPpTPC0k57bqbnZGFiP+yNy5RgiLAZIw/6EiD9RLDMo3xfX2XYgUvfjwc
         j15S//Wd/eqIDEkItCy8ENYDU/bpm24vbF8wGSvz7BhsCRcRLczJkLcuMxdDh8YMT8XW
         /P1uazFNN6jmmuIss18k2b2fcO4Qx4LSQlyBLGJTQ/SOPTffy3VEUVXdRWvTKMQwGab/
         wBHotQ7fXbEdAQCCyLuRjVqnlzY4HGEyOcHHWJBy1TNnZf4l1ukKkdlSbCF3VMaRkUzP
         IE7cZWkrItNg6URaxRJjnOoqSh1xgdJF2CNJq7GPkeahhmF2+09dwr+dwesYg2gbPWnC
         t1Kw==
X-Gm-Message-State: APjAAAWuVVTSYlCadxIxNq6MthKtDgKhLmF58W3i7xUUDcRB+ajRzhxY
        LpJeoQdSQxHA52Iayh+4WQiyGEWntGE=
X-Google-Smtp-Source: APXvYqzm/6PIVuObP7Ji2qziim0LbgqsL1JtB8hGMNc7FgqipjyH2o1bg/i4IOH7mODmkzFm0pGomQ==
X-Received: by 2002:a81:77c2:: with SMTP id s185mr3548100ywc.399.1551447982293;
        Fri, 01 Mar 2019 05:46:22 -0800 (PST)
Received: from [152.146.78.37] ([190.167.211.66])
        by smtp.gmail.com with ESMTPSA id y16sm14939152ywy.90.2019.03.01.05.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 05:46:21 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Prevent reset --hard from deleting everything if one doesn't have
 any commits yet
From:   Manuel Guilamo <manuel.guilamo@publicis.com.do>
In-Reply-To: <d1b34077-1c0e-7a2a-d2c7-da013dd56cd9@kdbg.org>
Date:   Fri, 1 Mar 2019 09:46:20 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <11C5FB4E-A4FF-430A-9305-E5BDA6A11049@publicis.com.do>
References: <15568DDA-F501-48C9-A1C0-97C72C29DA23@publicis.com.do>
 <d1b34077-1c0e-7a2a-d2c7-da013dd56cd9@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh yes... I did. Sigh

Regardless,

wouldn=E2=80=99t be nice to have a confirmation in cases like this? =
considering git isn=E2=80=99t only used by experts. It would=E2=80=99ve =
helped me A LOT, that=E2=80=99s for sure=E2=80=A6 and I=E2=80=99m 100% =
sure I won=E2=80=99t be that last person in the history of git that =
would suffer this.

Thank you for your quick reply.



> On Mar 1, 2019, at 2:56 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>=20
> Am 28.02.19 um 22:43 schrieb Manuel Guilamo:
>> I accidentally executed git reset =E2=80=94hard in a project that =
doesn=E2=80=99t
>> have any commits yet. git erased everything, everything I=E2=80=99ve =
worked
>> the past week, I believe this is not a desired behavior, considering
>> I=E2=80=99m not able to undo that action, because git doesn=E2=80=99t =
have any
>> history whatsoever.
>=20
> I tested this, and it does not happen for me as long as I do not `git
> add` anything.
>=20
> So, I assume you did `git add` your content and then you did a `git
> reset --hard`. In that case, I'm afraid Git behaved as designed and
> "doesn't have any commits" is a red herring.
>=20
> -- Hannes

