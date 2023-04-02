Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2879C6FD1D
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 01:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDBBad convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 1 Apr 2023 21:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBBab (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 21:30:31 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E1124419
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 18:30:28 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id u15so8002195qkk.4
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 18:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680399027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqIBCRGHIf169otKc6m1q4dPkRSCI5QgYZj45NeoSpU=;
        b=et/lhgz0HZy7o6tpGk5ooOo4hbWC7520vUZrrDsdFq5rVVdnwJZTixdvLG3vKVxNS6
         yNFb0f65+Dx/HWMBtsIcvAuY+HCYCkJqr6FCQNjxE4H00L0ULTeXlnORnm0H/oxEK69R
         uX2hyoHYVNPDFd983TwBnmFKEPqt312u8qDbVJvEx6oZ3lGRmZhBg1qVKBKmGztUFF5r
         5ZSILzleZSehj8B34WSdWmPNCFc7dsUjtSRvQgJNNaHRzPDP7RoH5NgBaL5n1kJACCd5
         XJT64qRFcCZ1dYmlkKxZTaoC18yAxighL3XEwjDuCmxRt/uv7PxKmTPJhkcqbDT4mY6Q
         DRmQ==
X-Gm-Message-State: AO0yUKVkyvEv+BspqCIafSAbG/pZYilEWYVPhvPZY8SJnHQREIznf9Oo
        V34AvX5Q7kltU3b9sp2XubeVpndQBagYCx2rwuI=
X-Google-Smtp-Source: AK7set/IYZEwCD0wJ/LowPIvK1qrJ4/4H64LZLbRXWTZ/w2UPNgL+1BXTfxFgp43s6Y12l+3+EIaJ6d1NfQGdGzvXIM=
X-Received: by 2002:a05:620a:22a2:b0:746:8b1a:1e4e with SMTP id
 p2-20020a05620a22a200b007468b1a1e4emr7717371qkh.8.1680399026744; Sat, 01 Apr
 2023 18:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230401212858.266508-1-rybak.a.v@gmail.com> <20230401212858.266508-2-rybak.a.v@gmail.com>
In-Reply-To: <20230401212858.266508-2-rybak.a.v@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 1 Apr 2023 21:30:15 -0400
Message-ID: <CAPig+cR0itJ3x9zmfTG-4MPSfRAenO__yYZ4OVMLYT1qgsKKcg@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] t0300: don't create unused file
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin Stenberg <martin@gnutiken.se>,
        =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 1, 2023 at 5:34 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> Test 'credential config with partial URLs' in t0300-credentials.sh
> contaisn three "git credential fill" invocations.  For two of the
> invocations, the test asserts presence or absence of string "yep" in the
> standard output.  For the third test it checks for an error message in
> standard error.

s/contaisn/contains/

> Don't redirect standard output of "git credential" to file "stdout" in
> t0300-credentials.sh to avoid creating an unnecessary file when only
> standard error is checked.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
