Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 216101F453
	for <e@80x24.org>; Thu, 17 Jan 2019 15:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfAQPWN (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 10:22:13 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:42311 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfAQPWM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 10:22:12 -0500
Received: by mail-lj1-f172.google.com with SMTP id l15-v6so8877209lja.9
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 07:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=1RyFj6rVUoynli4/G1fJFt6bEbXW5PeiQ/c1ZDCe6tk=;
        b=Wyy0dCK1ksndWcNc/3oOLlXfR3dlTwohjym4Ep8nbItTl2MC9X9avTHyeKGj2pzfCf
         AEHWVOivtZeZw41j7PxKgJStx9SUG7MIE2jPvIlAAfiT4X6+LYSco8M7UlAmYLFiEFgN
         6ys0Q1s1wUMf2rXKOz+246/BIgC/gp/edklDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=1RyFj6rVUoynli4/G1fJFt6bEbXW5PeiQ/c1ZDCe6tk=;
        b=JKilVZR1mbTfWCnk+J9S/+uSNpDqr0dIw2hkWPnbngPtzEYHmfSUIlRNfzIrrXwYxD
         EHbcAEAtXo++9JNYE3ZcI0yMCtKCU3TLQ4YS1Q9b0zF++5C0CUqfezIpM/ncAMPkSRE/
         4JC7uD9jTsqDu6UUdWAETHW4egdnGRrbN6N2C0hMff2GeHS3slSgnhtgQ67Z1Br2gRvy
         NtoJm1BcLidc6OwX+NN1PPcMYT8ub7gwMEQqb0zUCIgAWwvmQPJr4H0jJRzXneuFUamh
         3a5HB1ZUThrfSlLzIIMQn9z8uWLoEyQ7wy0X1WoR0OAq2BJqoO85q80Vl0x4xDgKYh63
         yX9w==
X-Gm-Message-State: AJcUukcPEY/P2oRqOu77IWYk0fYIVsFsfYFOFITlOCIkWFYIQ48N4yiO
        2U0IqbC4i1rl2GO02rfLiWDInw8rp34=
X-Google-Smtp-Source: ALg8bN4IQCzWSQqjSYQdUtB66rFLJjeHzBqJykJbWm3F/cx/lBYYhX09rpu55thcCyVFDufoocmY6w==
X-Received: by 2002:a2e:b1ca:: with SMTP id e10-v6mr10735074lja.16.1547738526700;
        Thu, 17 Jan 2019 07:22:06 -0800 (PST)
Received: from unit-1225.labs.intellij.net (notify.jetbrains.com. [80.76.244.118])
        by smtp.gmail.com with ESMTPSA id u11sm332718lfb.85.2019.01.17.07.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 07:22:06 -0800 (PST)
From:   Dmitriy Smirnov <dmitriy.smirnov@jetbrains.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: =?utf-8?Q?git_add_=E2=80=94ignore-errors_causes_--renormalize_?=
Message-Id: <401130AF-056B-40BF-8001-8492223B8A6B@jetbrains.com>
Date:   Thu, 17 Jan 2019 18:22:05 +0300
Cc:     Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
        Aleksey Pivovarov <aleksey.pivovarov@jetbrains.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.100.39)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Calling `git add =E2=80=94ignore-errors` appears to be equal to calling =
`git add =E2=80=94renormalize`:

Main.java is saved with CRLF in repo
git config core.autocrlf =3D input

$ src  git:(master) echo line >> Main.java =20
$ src  git:(master) git add --ignore-errors Main.java =20
$ src  git:(master) git commit -m "Ignore errors"                        =
 =20
[master cf24b3b] Ignore errors
 1 file changed, 13 insertions(+), 12 deletions(-)


The reason appears to be wrong bit mask usage

#define ADD_CACHE_IGNORE_ERRORS    4
and
#define HASH_RENORMALIZE  4


Looks like a regression since 2.16.0 - =
9472935d81eaf9faed771878c9df0216ae0d9045=
