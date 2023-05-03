Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BA9C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 21:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjECV0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 17:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECV0d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 17:26:33 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF1F30EF
        for <git@vger.kernel.org>; Wed,  3 May 2023 14:26:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso7267103a12.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683149191; x=1685741191;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7Q/QhtU9my/UDt4mWr7NiMYj6Am9nt6/zjekp5k+NU=;
        b=YURySFrZZ4HOKwjDhRpBe5i4sAASOUrsE/wUajvE8ESV2GQBthuE9wAETQ/+f87+CJ
         GnDEiwHYCFp3Fj5XV1TUWflUoLrPhR4UKu9XqfJUONBPs11YzJoA4toxxvb1qDPRo++5
         A2WAgRcNlywlgFCd/8vUCjozeUW+CET3yVoDIQ2SqF9wN7kJWPYh2iTUk20Qf7o/xdco
         EXOSN3m3ugw/1miDxEmpkjVlKMhmMbSZUl8NbrpqJPTVvMZizgxiZErZNuJQY2dNZYwj
         /vqGljbBcSmnLOcw9Z1+om6UCOB46TKVdieomugz3vLs4njLWGSMk00s80b48N/KIYEz
         OFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683149191; x=1685741191;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7Q/QhtU9my/UDt4mWr7NiMYj6Am9nt6/zjekp5k+NU=;
        b=VGk8gK5V/cN2ES3GNUXEB4e1bBoSYUfvBpgJWpg9ETXvFcrphITXffs6k8uLVZwIxm
         WcX52deOfCBQNCeyatfttcr4i+3jaTIgcfA818ITETM7lseb3iCpCjxO5HTJEWEkwb+B
         9DMB7j+oLXNhZc5ECKq5pUVc8LGJLitn5ibtBnYu9JeDN0uHnQsUscIN4ViEYXI+AVKz
         uC8xetLjXFl7YXxoqKYBdQ/AqZ3wlTWZ1bpvW5A5vONMeTGwkA88E8JtjF4EVtCJ8y3O
         YkRMNJjKKleXQirtBBVsCAy5WU6WYN95IGAKf3ppP6zZF13WXSdnecx5/RuniKPwxb2S
         gMZg==
X-Gm-Message-State: AC+VfDyA2lIr8TuYw44anTrA0eVJUbUjvqlQsOr0nYdM+zX/dX24m854
        5Qgc90E4X0dpnDtFcC5T3raOTQStkHM=
X-Google-Smtp-Source: ACHHUZ4uE/UaD6qief5Da04bqNsPttWLfu0oax/Mfx2Nz7qqetCkgKLoIBCU5K7DeUzwIlFI4qOhKg==
X-Received: by 2002:a05:6402:327:b0:50b:c50c:8bd0 with SMTP id q7-20020a056402032700b0050bc50c8bd0mr9942796edw.28.1683149190579;
        Wed, 03 May 2023 14:26:30 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:515:f01:c45c:4d31:96d3:b3ce])
        by smtp.gmail.com with ESMTPSA id s12-20020aa7c54c000000b0050bc041d2a8sm1109643edr.15.2023.05.03.14.26.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2023 14:26:30 -0700 (PDT)
From:   Lukas Tenbrink <lukastenbrink@gmail.com>
X-Google-Original-From: Lukas Tenbrink <lukas.tenbrink@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: git diff -U0 header off-by-one error when deleting no lines
Date:   Wed, 3 May 2023 23:26:17 +0200
References: <B097ECB7-1976-40FC-B91D-A60D648F973B@gmail.com>
 <xmqqednxp0ys.fsf@gitster.g>
To:     git@vger.kernel.org
In-Reply-To: <xmqqednxp0ys.fsf@gitster.g>
Message-Id: <7F1955DC-0296-470F-96F7-7BB96860D4BD@gmail.com>
X-Mailer: Apple Mail (2.3731.500.231)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This might be unintuitive, but it is specified by POSIX. =20
>=20
> Open
>=20
>  https://pubs.opengroup.org/onlinepubs/9699919799/
>=20
> and look for "@@".
>=20
>    "@@-%s+%s@@", <file1 range>, <file2 range>
>=20
>    Each <range> field shall be of the form:
>=20
>    "%1d", <beginning line number>
>=20
>    or:
>=20
>    "%1d,1", <beginning line number>
>=20
>    if the range contains exactly one line, and:
>=20
>    "%1d,%1d", <beginning line number>, <number of lines>
>=20
>    otherwise.
>=20
>    If a range is empty, its beginning line number shall be the
>    number of the line just before the range, or 0 if the empty
>    range starts the file.
>=20
> So a patch that adds lines to an empty file would look like
>=20
>    $ diff -U0 /dev/null test1
>    --- /dev/null   2023-04-29 22:24:54.395999895 -0700
>    +++ test1       2023-05-03 14:02:27.718960038 -0700
>    @@ -0,0 +1,3 @@
>    +A
>    +B
>    +C
>=20
> just as specified.  Note "-0,0" that says "there was no line before
> this hunk before this change".


That is indeed fairly unintuitive, but I appreciate the detailed =
response. I shall adapt my scripts.
Thanks and best wishes,

Lukas

