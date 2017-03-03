Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C50D20133
	for <e@80x24.org>; Fri,  3 Mar 2017 15:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbdCCPlE (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 10:41:04 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:36585 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbdCCPkS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 10:40:18 -0500
Received: by mail-ua0-f175.google.com with SMTP id 72so118947074uaf.3
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 07:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Aw4HEPO1M3CMWfSYG88mnX8CojshsZZ8EebTy2K1T/4=;
        b=fbFkxmyy6og2LuPzjK/25ktAO2uJzzi2aerLjq0N73JsZ6LSbSVDr8HRlYeKHsIuaj
         mTtGu2ASnq60vdu/9ryVKxc1RxEJm5QmOtf26Q9jzunHY2/kBl246u06C7tP1bnhEMzd
         UfbWmda89pllqn5IY9MXc1nCt1ZUG2+8fbBo4WazcCOve+svIzz9m3KVDVRB3fWGxFFT
         rcBWtrwVszT2fB740AoQr2ykyd1osU0YS2ipgvtEtI2Xgk1aP3ZosKeE3aYHsHKvbh6X
         mzpD+yE63VEzGqIapFk3Bt7Le54b5+3HSCRz+tU7J+bE4FDUr9eZDYs304W6YmZsRXpM
         NdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Aw4HEPO1M3CMWfSYG88mnX8CojshsZZ8EebTy2K1T/4=;
        b=hode/yJ7nPjPjUIHjfaeLcBPJ14KmQ2fMCMgf8CpI4PFQ+iWiUmvo/S2rMu7oe50IV
         UPQ+3TYQYj2BMzzJ23j0QbbJi2RiVoHH5IP29hLY2a1NnTeQolv/HZ2xUlREyXv8cs4s
         LsDaRYcqU1XYuBk8CJCPKtgsclxMSefb8A5UErIOHNDVVZRN7aYkgpiRdNEgJCFGO/cU
         8Qn/g+V998+i72h9gIa6Vf+EnRFForsc+apUCBifnlUk3hYJ80QJeDglpU+5+18G+UhA
         6W4UW/DPqjL7sTfzQ/lhcfqq1rHefY8mNvZVj/fJjMEQkLP8E6Fg609kpZwKEsluqL1U
         DzGA==
X-Gm-Message-State: AMke39mfgqSqzRA/Wp7eO8qjg/aZAp1mQsOMPlYWNKl8+FtB/Jk78giy3PLegm8LJdcUG/NgrI3YSP0QS4dBkw==
X-Received: by 10.159.53.105 with SMTP id o96mr1080801uao.113.1488555604478;
 Fri, 03 Mar 2017 07:40:04 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.82.136 with HTTP; Fri, 3 Mar 2017 07:40:04 -0800 (PST)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 3 Mar 2017 09:40:04 -0600
X-Google-Sender-Auth: Dm1YdkVU-4EXgHwh-UAJkaq7fjQ
Message-ID: <CAHd499CfJnPtLmi8qzr=_jrfCgMw85MOUv-wPKmAHFUyDFXhRA@mail.gmail.com>
Subject: Finding a tag that introduced a submodule change
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a repository with a single submodule in it. Since the parent
repository represents the code base for an actual product, I tag
release versions in the parent repository. I do not put tags in the
submodule since multiple other products may be using it there and I
wanted to avoid ambiguous tags.

Sometimes I run into a situation where I need to find out which
release of the product a submodule change was introduced in. This is
nontrivial, since there are no tags in the submodule itself. This is
one thing I tried:

1. Do a `git log` in the submodule to find the SHA1 representing the
change I want to check for
2. In the parent repository, do a git log with pickaxe to determine
when the submodule itself changed to the value of that SHA1.
3. Based on the result of #2, do a `git tag --contains` to see the
lowest-version tag that contains the SHA1, which will identify the
first release that introduced that change

However, I was not able to get past #2 because apparently there are
cases where when we move the submodule "forward", we skip over
commits, so the value of the submodule itself never was set to that
SHA1.

I'm at a loss here on how to easily do this. Can someone recommend a
way to do this? Obviously the easier the better, as I have to somehow
train my team how to do this on their own.

Thanks in advance.
