Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802F7C433EF
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 03:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD1260FD9
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 03:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhJaD0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 23:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhJaD0O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 23:26:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DB7C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 20:23:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u11so29412926lfs.1
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 20:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sExYR1JVJGn7qhffAEdWEbLPRQgsPqB+K/6oIkTc1Ss=;
        b=mHAcZgBHZCRzHeBcl+qlfdvsX/o2GS1ducGCjGs5Ib5nNOr5ZTunU9QRJz4hHBfNY7
         J0qtWBtoNWEUy73z/xUn8bSKEb7zE8qqhRJ68Rfd0KkQETTlQIcPEX9ncxoWNvjJzINg
         ycCGnoosuj72JiG64LEvvbJcnovfLANllZxx8tVrOtoQ2sM3Pyau2eboEz6Tuq7dk9of
         GpmSNMCJCP4MRMmdYoTr6Lo1WPQjjAlSw77sBfZsgQlW+Byt7NwfpvyYmEBRaA0lVSRg
         ctMfiby/n5idQyesuer9jSAT2i8aqn7aaYh6Yq0LpfDfgUIG6gQG//O84J+lU3IpeRjs
         CQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sExYR1JVJGn7qhffAEdWEbLPRQgsPqB+K/6oIkTc1Ss=;
        b=CQ6E/ea108EZKq/7Nhlylpmzj2wBdtfAuYdZabMGljEDsVQOc1kDdoZzoDxQ3CIZxs
         7trbreGTOI1CY45KF5OUAvEgnFOs4RtWT/iFAUs6G7QDqWZGU6ccpRVS7Xg3N/rri2z1
         4LfLJu23I/icLa3VjB3EI/YAoDbYI/ImDCW5HpSWrxfVw2yUf1Lqr9/pjF1Vem3tzVfC
         PB1+zz2AinWo06LxAm27M6dEozS245Dsrx8eepNxFuePicg/RW6lO72c5LC0n3Zx6NnY
         Q93FxDSHbJMXD0kck8narpfyPjx5PcmU6y0A7CMRz60mHKZG2pq0Qb0igT17EdYj+wXo
         IFDA==
X-Gm-Message-State: AOAM531SNSAHk/YX3oz3maNmc3vlDt+m+Hd01/fma0Tqqj81cmmPjsYL
        GQYzeq1azopltnVApYbo70hXi8gQ8DDFlhn9HXixhgLG81cyCg==
X-Google-Smtp-Source: ABdhPJx6nsPw43ujmS5dc/wFIlMWNmeeoBwSfjFchoaiUWSXlKEwwRpgKHz8GpG6j6YLH+LDMtUozNGU82K1cQxEP9s=
X-Received: by 2002:a05:6512:21a2:: with SMTP id c2mr19539192lft.28.1635650620665;
 Sat, 30 Oct 2021 20:23:40 -0700 (PDT)
MIME-Version: 1.0
From:   Dongsheng Song <dongsheng.song@gmail.com>
Date:   Sun, 31 Oct 2021 11:23:24 +0800
Message-ID: <CAE8XmWpK0ubcTXOaxBKGKh1qU+73Rr181wMAM7KAAX_A5PEYOw@mail.gmail.com>
Subject: timezone related bug of git
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi=EF=BC=8C

 I found a timezone related bug in the git:

1. git log 11990eba -1 --date=3Dformat:%s

commit 11990eba0be50d1ad0655ede4062b7130326c41f (HEAD -> trunk,
origin/trunk, origin/HEAD)
Author: rillig <rillig@NetBSD.org>
Date:   1635604878

    indent: move debugging functions to a separate section

2. git cat-file -p 11990eba

tree 5d62150f5e2bafd3db76641450ca5d902302a039
parent 892557a74bd49983fac28366b772b53c9216ca73
author rillig <rillig@NetBSD.org> 1635633678 +0000
committer rillig <rillig@NetBSD.org> 1635633678 +0000

indent: move debugging functions to a separate section

3. conclusion

The unix time stored in git repository not same as the git log output,
then there must be a timezone offset bug:

1635633678 - 1635604878 =3D 28800 =3D 8 hours (local timezone offset)

Best regards,
Cauchy Song
