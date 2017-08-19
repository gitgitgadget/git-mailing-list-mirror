Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6321F667
	for <e@80x24.org>; Sat, 19 Aug 2017 12:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbdHSMpq (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 08:45:46 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38770 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbdHSMpp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 08:45:45 -0400
Received: by mail-wm0-f50.google.com with SMTP id l19so17446779wmi.1
        for <git@vger.kernel.org>; Sat, 19 Aug 2017 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=Pj6zrzAvb6uGfSBEPQh7x81dwOhu1tMka2+v74nfLKQ=;
        b=axmHHLtM2OCJSQHfOvSoD5aV7Z210q3VHYVOxvti7fBTptI50ugB0ZehGoRk2ZavX7
         16u/tKWXavg2iox4irfgf5rItq6Ew45BuOwUzQegG2i5cXSPQ/S9CAUwbr4o0VldaHR0
         +oU4MkF76fH6giQGbSC+g0ETNG/9Cy2ON0lkpDnXewE+MD2edf7nQ+06Y9VIWfLVQC1U
         3QS/n/lJCwC389GQLKuOD3P1CGyupqKjeZdQt1S6Te+3DxX6Ja7enMZA47c+C8mhrchf
         kkss0dAedBj0QyBUlj0hdLw1EVH5DUXUD5kyLNVgiGJpQXZpHQC+pOdcTuJWer1zeRlW
         6Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=Pj6zrzAvb6uGfSBEPQh7x81dwOhu1tMka2+v74nfLKQ=;
        b=DRM3zULsKtdEgI3Gi/x8jLx7QRVa5D/zL2GNUoxpMkNcc1tFjuv4HB2XiMe9VOgSYp
         38DmTawmCaK06UXBpbf5acZSWXcxRPDK+A77TMOAxsAGKRl+DCN3MYQgHMzOS9Y6oASr
         aT5EWVblGESK7H/l62w/ZKIekU/rwRB1B6pkiGUIk9DFtdxGEd8gy3hlhmCT0qVYAi5F
         Y3FV6V0GwcaJyPqPlAQOdTqWTQ2Gx89lWTAMuCSTk1SMl/X4/I0PaWCaAEpaSa3vwtX5
         H9SEyoea124/zoBFsystkgxPkLnAYzD8lXYHyOcD+xe5a2k9lqJMYREXwdf2A4rfTzC5
         HztQ==
X-Gm-Message-State: AHYfb5hX2uEpsZq7kptlCBMk2iNQ6KnpO8l8IkmM3ZF4NbwfUpYUhr/b
        Z5x7G4m2/7rB09mg5Pw=
X-Received: by 10.28.109.217 with SMTP id b86mr3040866wmi.34.1503146744248;
        Sat, 19 Aug 2017 05:45:44 -0700 (PDT)
Received: from [192.168.2.105] (p5091C6EE.dip0.t-ipconnect.de. [80.145.198.238])
        by smtp.gmail.com with ESMTPSA id t135sm3610871wmt.26.2017.08.19.05.45.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Aug 2017 05:45:43 -0700 (PDT)
From:   Jan Teske <jan.teske@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: git-svn: Handling of branches created from subfolders
Message-Id: <1ED00C5D-177C-4F95-8261-BFB7345B7C08@gmail.com>
Date:   Sat, 19 Aug 2017 14:45:58 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I=E2=80=99m trying to do a one-time conversion of a large SVN repository =
to git using git-svn. Unfortunately, this SVN repo contains a =
substantial amount of non-standard branches created from a subfolder of =
trunk/. Users that only need to work on part of the code inside the repo =
usually create such branches to avoid having to download unneeded files.

A toy example showing what I=E2=80=99m talking about:

trunk/
    - subfolder1/
        - =E2=80=A6
    - subfolder2/
        - =E2=80=A6
branches/
    - branch1/ (initially cp=E2=80=99ed from trunk/subfolder1)
        - =E2=80=A6
    - branch2/ (initially cp=E2=80=99ed from trunk/subfolder2)
        - =E2=80=A6
    - branch3/ (initially cp=E2=80=99ed from trunk)
        - =E2=80=A6

While in my experience, git-svn is able to correctly handle =
branches/branch3, it fails on branch1 and branch2. By "fails" I mean =
that it still performs the conversion, but any relationship to the trunk =
is completely missing. Instead, in the resulting git repository it looks =
like those branches have a completely separate history, starting from =
nothing.

Is there any way to fix such branches from subfolders in a way that they =
integrate correctly with the converted git repository, without losing =
any (or at least too much) history? If this is not possible with git-svn =
directly, maybe I could prepare the SVN repo or post-process the =
converted git repository somehow?

Thanks!
   =20=
