Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1F3C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 03:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiFXDOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 23:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFXDNq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 23:13:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F862BF5
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 20:12:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s194-20020a252ccb000000b00669b5702413so1113864ybs.22
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 20:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=YQlJmfsfqi/fOInL7PBhD7GZkLQJvbEEDSQD2p74E+w=;
        b=TLxudVB4MEbpQNy6bcp8CgdOOaagOv5I5cQhkb7hEz++EaUNShNQpf9BpiY3+v3oea
         1SH+DjMPN2EvpRQVeYzzqz/Abg1rVaqCLx+yOCSFjSvp8NJQqzdsq5Ctjg2Dls6A3kKp
         qo7X7OMEyoHSucRloQ1jvCelSlIAcH4r/cLMTvNUu86NNUqlKV0Frq2Uk2mclTDzm1PM
         EDNFIRWnGGxP00KlRSEDhBQIqJs4mTwsR/xmuvEfEpthQ+2a8uzFEVYF/mU/mXEsDXa5
         uyECubx6zPZCtexOL3hGNvPtf/X9kRKLs1p3Vn+gY1fHFe9Ewix2ZGVgTj04AjUjcSdo
         ds0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=YQlJmfsfqi/fOInL7PBhD7GZkLQJvbEEDSQD2p74E+w=;
        b=Zs4lzJLqAaI0+VV7mos7Tkp5GbUAUmAD4giwc3n7i4QjDyvsIeb8jyNNylR0hTLYSG
         yka4FL9foru5m3m2/ZTIbObommhXZzoYiXhkaqU0MVAdpMpalrHhaTESGD8v80sLmion
         2Z6jBsPmoakIZW9xEkHFByYksGSR0nsPC1vvYp+EE10n2ionyajlB4+dYmPTpZOoVMti
         D2ISlIdT5a21ZEzsYWMatVisz2r/CtoWIjqIXQScXR9NdslCrKwg+IiMEfSaI28aln4v
         si3TPoh4JC4K0HwweAs0TuBOmwd/Ad4B8FrgoUtLB4ket11+WxD3EJCH0bZOh/CiAwc0
         Xr4Q==
X-Gm-Message-State: AJIora/7hnviObo0lo3q3PZ7fCfS2pfoMUXnyAuDxKrerm9s/5Pr3kBS
        1bhjDN9k/7QzwvY8AaxEAlcoYdTowwAJiw==
X-Google-Smtp-Source: AGRyM1tq2FgzRus90HsPjDgaIdeLg6ZUg8P5x5MrMttjYIhYC5GRxESrIbfQXn2FKQNGjrcaTZl5d3uIRKWLNw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:4688:0:b0:300:3205:ff1e with SMTP id
 t130-20020a814688000000b003003205ff1emr14205928ywa.162.1656040371271; Thu, 23
 Jun 2022 20:12:51 -0700 (PDT)
Date:   Thu, 23 Jun 2022 20:12:44 -0700
In-Reply-To: <xmqq7d584hqb.fsf@gitster.g>
Message-Id: <kl6lk096iwk3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqq7d584hqb.fsf@gitster.g>
Subject: gc/submodule-update (was Re: What's cooking in git.git (Jun 2022,
 #07; Wed, 22))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/submodule-update (2022-06-15) 12 commits
>  - git-sh-setup.sh: remove "say" function, change last users
>  - git-submodule.sh: use "$quiet", not "$GIT_QUIET"
>  - submodule--helper: eliminate internal "--update" option
>  - submodule--helper: understand --checkout, --merge and --rebase synonym=
s
>  - submodule--helper: report "submodule" as our name in "-h" output
>  - submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
>  - submodule update: remove "-v" option
>  - submodule--helper: have --require-init imply --init
>  - git-submodule.sh: remove unused top-level "--branch" argument
>  - git-submodule.sh: make "$cached" variable a boolean
>  - git-submodule.sh: remove unused $prefix var and --super-prefix
>  - git-submodule.sh: remove unused sanitize_submodule_env()
>
>  More work on "git submodule update".
>
>  Needs review.
>  source: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>

I think this is worth renaming since 1. =C3=86var has taken over this and 2=
.
it is no longer primarily about "git submodule update".

Maybe "ab/submodule-cleanup" and "Preparation to turn git-submodule.sh
into a builtin"?
