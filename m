Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B041F406
	for <e@80x24.org>; Sat, 13 Jan 2018 00:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965422AbeAMAJn (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 19:09:43 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:45965 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965312AbeAMAJm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 19:09:42 -0500
Received: by mail-vk0-f45.google.com with SMTP id o16so4577270vke.12
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 16:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osmialowski-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=MJkJsQFoJ3KCPoo3F4i681q2VT7toqRBF0D3K4/f50M=;
        b=Kdd4Xa7wBLj4zJvwxjRcRA9pig/Zm/4W6t3vKLBRv5DNx873OGVm1jAva3tjssEgkL
         ps9ZlTZ0Zbo/pWe7SHdkyxYDvaxkNVpDftnhiLwFBBmaVIgAF2bJdoo5+QzX0ZG2B4Bc
         xBBw78+olaNlWGlV5KTCMevwLplsVPytgOYr/actpwjlEqANA747otqeRvdH9uVaJe0n
         Xp89rCZEYxuik+3ht0iqNWvqws9OIpD8BDO1Tjdi3NsqUvtrtx6IFnwigOKmpdcMA4to
         DPKen1+HXj6PXKA2VS/qHBJKW+V2hpgYB7RStEHT4oqnFbv1B6UzjbtabINTxmrk7nKz
         ZGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MJkJsQFoJ3KCPoo3F4i681q2VT7toqRBF0D3K4/f50M=;
        b=qn+0NmKx732vswfEDYADKvowbgPRPSPbGrIaAiwfHm1S1rCNMuQn7jCQrlitfpG3ZX
         CQODhEFFhXI0fcB6fMiOUCstxJwoCU/L2HD6jwU+QPR0cVpPoZvrSqoPIoKwDMHNgxyT
         k40Zx6oPFbBHO2ZEIs1kermFKAeVOFsHFk9PAlJOXyzYpf3Vuu3JjQAXmipzCiB1px5H
         /J+yhQI4asZQxQDSrO1MqBwbqawn8EGmf8CsqIMShNfCflVQhN+NfQcyiiqvl/tOtz2q
         SIg/vUlJ+CtFw+/8LT6P6zeuOzFjvmKzOzGxjzfvFS4AFOmG98vRhUdqUm1QMqQJ/ztx
         7NRA==
X-Gm-Message-State: AKwxytctGxfmdIFxUnK+DxeVsSnvzb8ejYzsbp8/MJRqyy8Qg1zA2O08
        A7Wm5B5Eqovf4fr66o10iqb0L3lPa0aY4his5tHfY8DX
X-Google-Smtp-Source: ACJfBovpkXDlEVOWsu14i/lAPWDshqKm13A/aOrFLlDHRhFHcm3KUwqL54/nUZB7D6VD29Cf2z/NsRmZmh34VtkGw74=
X-Received: by 10.31.172.22 with SMTP id v22mr1544612vke.54.1515802181245;
 Fri, 12 Jan 2018 16:09:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.61.70 with HTTP; Fri, 12 Jan 2018 16:09:40 -0800 (PST)
From:   =?UTF-8?B?QW5kcnplaiBPxZttaWHFgm93c2tp?= <me@osmialowski.net>
Date:   Sat, 13 Jan 2018 01:09:40 +0100
Message-ID: <CAHLNBdVp0VTqtxHQ_cQ2XPMMDhqnQG5boj0M2JrT-iECaFUFZA@mail.gmail.com>
Subject: Git uses wrong subkey for signing commits with GPG key
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have an issue with git and signing commits with GPG subkey.

My setup:
- master key used for certification only
- subkey for my main workstation
- subkey for my mobile workstation (a notebook).

Both subkeys are used for signing only.

I've configured git to use my specific subkey however it does not
work: git config --global user.signingkey = KEYID. Every commit is
being signed using the newest subkey. I've verified the same behavior
on three systems (although with the same setup). I've tried to use
--gpg-sign=KEYID flag, but it does not work either.

Environment:
OS: Archlinux
Shell: ZSH
GPG: 2.2.4
Git: 2.15.1.

Is there any other info I shall provide?
