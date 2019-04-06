Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE93B20248
	for <e@80x24.org>; Sat,  6 Apr 2019 16:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDFQgd (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 12:36:33 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:36502 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfDFQgd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 12:36:33 -0400
Received: by mail-qk1-f178.google.com with SMTP id k130so5666796qke.3
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 09:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=S1mpwKVellxHm2aSPwQVmERINrr5JeziIKf6iOS2/NY=;
        b=mV9qRHWbvZsFk5L0QNxf1dRkbKsdWlkvOUJlfpIeDdXazbdbI8CaWtt0BlMuj5dwh2
         fMAcNoT7k9qOHeMFQp37dQvf0XXe48rHVmOjTgseKM4qj3f3Eipfr4AjyYTTxIrpuz6K
         ZCPUZty8lNykH5b4Iz9GEp5z+zISv92ywrnjBalirUScZh0Zcf7PRS7ptzSXg1CW4WWz
         /uuQfhm8eA8H4JrYv+WCS4Am8ckoO5FxLZjO+SM21hiB7/tVzBwqo/6iDoixqrFQy7vc
         83z1uu8yIEUVqyyFRMvuDso2nQhyj/J0ivnmvL5RaCRCzO/PZMUxC+wmB5YxRSQtPjVL
         ikCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=S1mpwKVellxHm2aSPwQVmERINrr5JeziIKf6iOS2/NY=;
        b=dkN2gIzK3pB5/bvC5UAEW8B6VGS4FvgxXdFPLDEckWokDeBxkMBZZyADVOcHSyovmx
         qA8Rfdo9ExFWug18I8qhwU3UBpG0Nrm+tEqYM02AmQpgkHuTS84W06XI9IDNxhKCJK/q
         6tbPX3yNKcm0qBLmq9Tl5C7J/yJP+yheJ9SF8fFb3cImTh/B56/eiSGTDm8HIExLMb8W
         75holc6pbtj9/Kr4jamg7TGhvr391apIFztYJ6/Bh4iAmQlSS76+JSnNNL5eN9RmuwPP
         FIhPM3cKBGJ5qu/I/fIk2qeYg03/dD2JaO5p6qpQGJ2HSwdzsYRhbvDvSnh+NOgS1Cmn
         lzFw==
X-Gm-Message-State: APjAAAUmMVyjKUTu3pTdyt61YPuZUbdJPeHXYknltFKtuK3pKITk2OYR
        QT4xtOk5VTUaEP0mXKWWNX2wSESosvqTOw==
X-Google-Smtp-Source: APXvYqxOq5vZbCBsUFke9NAvTQG4mo3aH1PFve7hzqw299baplqXxWB60xJEM5WdUinAAoih2SwzZg==
X-Received: by 2002:a37:9c91:: with SMTP id f139mr15607818qke.48.1554568591603;
        Sat, 06 Apr 2019 09:36:31 -0700 (PDT)
Received: from [10.0.1.7] (cpe-72-231-3-212.nyc.res.rr.com. [72.231.3.212])
        by smtp.gmail.com with ESMTPSA id k3sm17142484qtf.28.2019.04.06.09.36.30
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 09:36:31 -0700 (PDT)
From:   Paul Schreiber <paulschreiber@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Bug: subcommand autocomplete fails on 2.21.0
Message-Id: <E4A677E6-E624-464B-9BC6-AAAE0A77EFFE@gmail.com>
Date:   Sat, 6 Apr 2019 12:36:30 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With git 2.21.0, tab completion no longer works for subcommands.

STEPS TO REPRODUCE
1. install git 2.21.0 from https://git-scm.com/download/mac
2. source /usr/local/etc/bash_completion.d/git-extras (manually, or =
update your .bashrc/.profile and start a new terminal)
2. git clone https://github.com/tj/git-extras
3. cd git-extras
4. sudo make install
5. change directory to a git repository
6. type "git del=E2=80=9D and press [tab]=20

EXPECTED
line is changed to "git delete-merged-branches"

ACTUAL
[beep]

CONFIG
macOS 10.13.6 (17G5019) and macOS 10.14 (18E226)
git 2.21.0
git-extras 4.8.0-dev

REGRESSION
Works as expected with git 2.17.0.



Paul=
