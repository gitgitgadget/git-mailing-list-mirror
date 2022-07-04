Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB69C433EF
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 08:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiGDIV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiGDIVy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 04:21:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AB51172
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 01:21:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z19so10671161edb.11
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 01:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=GJw2koxuhpYeiKSZDn79e5gEvOPB7cFud8va6WA0y0k=;
        b=GKLo2aReRBj/Od4xkX/ZOtQem4LuzwyTcX8h0au/mRjztCB6Oukq/8YCzG2y52238u
         5+SVeepYa+lNg4IfqUugkJmgzO8i1RGpJbMjk7MBm4wK6DMxl99FErPUCaXwRrRg9nkS
         5+aewkuUf6XzncsgJxII94off9kT+SCyXEWs1paB81HN0auDmNBZqeqRKvBiLPIxlfEZ
         yucKfiGqVjs6xW/2Zi8qUlS8bos09QCCZVCnza0XBoBBL10aLXEJ+sDLV8Ufl9Kmfnpk
         i/Kny+izhFd2smCvwK3xIEuSisoB7FS8mIkTb1DLkhHIq3sLrDxMBfzsDmsQIzy+GbEC
         zBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=GJw2koxuhpYeiKSZDn79e5gEvOPB7cFud8va6WA0y0k=;
        b=Etrq0mdIfJ9PAxz5wNtZKwskd9IWg8Kfz3C7JU9puXiQ0e1R0JSzKIaSBT6LE/glyt
         pc1F/nAEh0u/fm9fhmTnV9HAHL6VPTRd3YLe6BeLYSzyGDtxM1+VIlgO3xU75K838TVT
         JhCQb6teo7Zux/wFaZLSnex+S4JOTyUqQCHo9cP2Fq26GAezu6AZ5IiYMQ8026XlBOxk
         s3SFp/7EnY/0ZwzKUNtKzR3MCZ55V5cAFL9LQYekAsGNJI0WiTwyVrD8NrNxYvbKvcIJ
         tg8dyBq4ZXTNhyNFAfwCR6KmtSvj097RQeCTBF+d27rfEedsh6uZJHX0Sh5OCphuJ+9C
         T1Mg==
X-Gm-Message-State: AJIora9jG3Ozkum4/ewj42KUg0hJLbTMqBeo1hGohITqvELMxCTtWhF7
        dP9GyUIEL2HS5QdYxxk4AjY=
X-Google-Smtp-Source: AGRyM1vcRCLXdItF3TWTSeubCFc5ZgT9K5wDLiH+Kv8J/DXwKZKi6gi8HDdX0W+54k+cmJDjZmH9GA==
X-Received: by 2002:a05:6402:4507:b0:43a:5b42:2be5 with SMTP id ez7-20020a056402450700b0043a5b422be5mr4427992edb.392.1656922912274;
        Mon, 04 Jul 2022 01:21:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ed12-20020a056402294c00b0043a2adb7a8esm2407750edb.71.2022.07.04.01.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:21:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o8HL4-003I17-V2;
        Mon, 04 Jul 2022 10:21:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: gc/submodule-use-super-prefix & ab/submodule-cleanup (was: What's
 cooking in git.git (Jul 2022, #01; Fri, 1))
Date:   Mon, 04 Jul 2022 10:12:19 +0200
References: <xmqqo7y85t44.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqo7y85t44.fsf@gitster.g>
Message-ID: <220704.8635fhb84h.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 01 2022, Junio C Hamano wrote:

> * gc/submodule-use-super-prefix (2022-06-30) 8 commits
>  - submodule--helper: remove display path helper
>  - submodule--helper update: use --super-prefix
>  - submodule--helper: remove unused SUPPORT_SUPER_PREFIX flags
>  - submodule--helper: use correct display path helper
>  - submodule--helper: don't recreate recursive prefix
>  - submodule--helper update: use display path helper
>  - submodule--helper tests: add missing "display path" coverage
>  - Merge branch 'ab/submodule-cleanup' into gc/submodule-use-super-prefix
>  (this branch uses ab/submodule-cleanup.)
>
>  Another step to rewrite more parts of "git submodule" in C.
>
>  Will merge to 'next'?
>  source: <20220701021157.88858-1-chooglen@google.com>

[...]

> * ab/submodule-cleanup (2022-06-28) 12 commits
>  - git-sh-setup.sh: remove "say" function, change last users
>  - git-submodule.sh: use "$quiet", not "$GIT_QUIET"
>  - submodule--helper: eliminate internal "--update" option
>  - submodule--helper: understand --checkout, --merge and --rebase synonyms
>  - submodule--helper: report "submodule" as our name in some "-h" output
>  - submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
>  - submodule update: remove "-v" option
>  - submodule--helper: have --require-init imply --init
>  - git-submodule.sh: remove unused top-level "--branch" argument
>  - git-submodule.sh: make the "$cached" variable a boolean
>  - git-submodule.sh: remove unused $prefix variable
>  - git-submodule.sh: remove unused sanitize_submodule_env()
>  (this branch is used by gc/submodule-use-super-prefix.)
>
>  Further preparation to turn git-submodule.sh into a builtin.
>
>  Will merge to 'next'.
>  source: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>

Thanks, with regards to gc/submodule-use-super-prefix that series gets
my enthusiastic (if it helps):

	Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Likewise the ab/submodule-cleanup parent topic has Glen's:

	Reviewed-by: Glen Choo <chooglen@google.com>

Per [1] and [2]. I.e. the latest is the v4, but the Reviewed-By was
given to v3 in [1], and [4] notes on v4 that the one remaining concern
was addressed.

Thanks both, it's great to see us this close to getting rid of another
*.sh built-in. I plan to submit the migration to the builtin/submodule.c
after these two land, possibly after some memory leak fixes to
builtin/submodule--helper.c.

1. https://lore.kernel.org/git/kl6lh74aivc6.fsf@chooglen-macbookpro.roam.co=
rp.google.com/
2. https://lore.kernel.org/git/kl6l1qv8ivcs.fsf@chooglen-macbookpro.roam.co=
rp.google.com/
