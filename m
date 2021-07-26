Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33308C432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 17:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1194860F6D
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 17:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhGZRNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhGZRNl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 13:13:41 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3682DC061764
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 10:54:09 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 184so9717266qkh.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=4mFvoJgwiZKyFDIOKw7lgCpCoIuXVX1nBUjw/J9jk48=;
        b=q2hfSngQH3JkAuKCb+4hVE87eZnEGaOSaiZNhb8+BxPWAn9FGSP0G+xYaRjtI2wXiR
         o6K13kQAsGAhKedAraVJxiDuJ14DfeaqV8z+kSz3UUUl4dnHuCijsZpgCT5ELf8IVg/V
         EGKH1lHNWDw9/Z7OrQiEAITJPz7dWk59HabwN7SeqG41WCkrCgf/EwiH1BfHNUwHS49O
         dzzUZhU5Y6cybVpk/bPU/+m5wdIExXl6cIymG7wD+S9CvvrFmMNXpo88atGm35b/Teaj
         fDXSmbLCvT4Rvo/DNw1DirSo2BlKrwCDrauVTSR8virFx+Z9PQKWq4x5osmrNx75WvrW
         goZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=4mFvoJgwiZKyFDIOKw7lgCpCoIuXVX1nBUjw/J9jk48=;
        b=WZRsAjMT8udEoBnw9aD/2OKx+9fFvg6icKi9M0+C90ExTQaPFa2WXplKPZfRFPlY/1
         P3qa6t90W8KY1dc6tmsRZ6RdIbQrxyPAYpEcDVPbZDvFQIX7cCX/CfoByw+KtNJBowLA
         Nx0jbxsU8eYjvennYFsf/J2lOFERN384qSo6jTQxSson4z0ukOdtiVDX0/Aou2aAVpCK
         35+ZYzt3SI4307q2PUNZm56JwBWOeT16GXlvouDywNP5JEeKICdaHuZUDob5+/wmD3SU
         J05JFLAZaOrEQ/S64DDZhXdaipPrtJv4IKaFZuhD7Z4kwcBdrzoFFBIFEQZSCuypbxef
         JPcg==
X-Gm-Message-State: AOAM530RjlEjp/27FiPYDY7hQ2fhTugXPk84SQEhnNkor9mslmDn3Cfn
        A/VioOIH8JwSBVerK0G8p0+wBe0aao8ANg==
X-Google-Smtp-Source: ABdhPJwC/1lccm69+k7Eoj4PLWOygPNR/vFHIvIg532RsuyU55Oa4TkSaSkIx4fwKxTY2GB6RIvkJQ==
X-Received: by 2002:ae9:ee18:: with SMTP id i24mr18147513qkg.394.1627322048029;
        Mon, 26 Jul 2021 10:54:08 -0700 (PDT)
Received: from smtpclient.apple (host-68-169-160-88.MIDOLT1.epbfi.com. [68.169.160.88])
        by smtp.gmail.com with ESMTPSA id f12sm287904qtj.40.2021.07.26.10.54.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 10:54:07 -0700 (PDT)
From:   Evan Miller <emmiller@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Exit code 255 after large clone (32-bit PowerPC)
Message-Id: <D3C1583B-8CC8-434B-8AF5-B9827A7FD037@gmail.com>
Date:   Mon, 26 Jul 2021 13:54:07 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

$ git clone -v git@github.com:macports/macports-ports.git
Cloning into 'macports-ports'...
remote: Enumerating objects: 1223319, done.
remote: Counting objects: 100% (685/685), done.
remote: Compressing objects: 100% (341/341), done.
remote: Total 1223319 (delta 289), reused 608 (delta 252), pack-reused =
1222634
Receiving objects: 100% (1223319/1223319), 244.46 MiB | 1.09 MiB/s, =
done.
Connection to github.com closed by remote host.
Resolving deltas: 100% (702052/702052), done.

What did you expect to happen? (Expected behavior)

A successful clone.

What happened instead? (Actual behavior)

$ echo $?
255
$ ls -a macports-ports/
.    ..   .git

What's different between what you expected and what actually happened?

Exit value was 255 instead of 0; no regular files (only .git files) are =
visible in the cloned directory.

Anything else you want to add:

Other repositories have cloned just fine; however, this repo is =
considerably larger than the successful cases.

This is a 32-bit PowerPC machine.

[System Info]
git version:
git version 2.32.0
cpu: Power
no commit associated with this build
sizeof-long: 4
sizeof-size_t: 4
shell-path: /bin/sh
uname: Darwin 8.11.0 Darwin Kernel Version 8.11.0: Wed Oct 10 18:26:00 =
PDT 2007; root:xnu-792.24.17~1/RELEASE_PPC Power Macintosh
compiler info: gnuc: 4.2
libc info: no libc information available

