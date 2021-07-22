Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20D2C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 11:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5FD46100C
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 11:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhGVLAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhGVLAn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 07:00:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD83C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 04:41:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p5-20020a17090a8685b029015d1a9a6f1aso3370131pjn.1
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 04:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=slrWZ8lwtdyE7wuojjyG87zf4xWPBa8KOhaOPtt62Cw=;
        b=bAqDbNMwGUyVGuzH6V+VUDAzCIzFeU3laDxWS48i1p9zCFc+g2e404q5M7pBjfO0RL
         yKTyOhHXd9p4fZD2Z/A74CqucmSebeWM4XgM8txfLLpUJvVffZ4wTUfe7Ajv8LyJ/7Un
         4DCrGLgT2Y7nPhfYuJiE6C+pZ7sTXH6LGcLOsnTQXLKD4iSg3/ifeidkfJu8DDkV+r6a
         xVz9UylHW02DSi0NIrHrrQQpt9LIev9nz6XMUaBfGfvV4cJmbWzKafiWn/ijC4Ccd6jF
         NFe7Qp/ANOLEvjt6GS4s3JaUhHRdgDwiJaFg1On8qCsx9HRHyMEfQAd5XZpZlejpc1GI
         jtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=slrWZ8lwtdyE7wuojjyG87zf4xWPBa8KOhaOPtt62Cw=;
        b=AL7gmeaP8L2ruA1iBDMq7wWfC3J+bKybEIOacQnsJRf+RlqRkKCWb3z98EFf+yKUWD
         i/Jorv0Icx4iPxNWEFYLCr5J8uIyHr6g92asCewgKtBW6WXXxadUF+SopCUD/I+e4Vei
         NDzJYlnggJIktRy33QIzAFJvfXgToTAjOc4IDb9wgCOCP7ChtJu1I2nrwAXc6tyjtc9x
         o5qjmjbF1uaI8uYT6PbWJp3j78+7+QWzI5VQ1/+OxQmUSXMJH06Q8Hb4wOSsDnFmrGsy
         PROB1+NpiaYdGAmxQOC9zzZGGaTzE2lAlUhznetOPtGCu/uPo8PfhPmigCKah6SzP95+
         t1iA==
X-Gm-Message-State: AOAM532I6NlCX//JEUA9iYOZpp+OMZ3d5BVcLyzb+nK+jIZFX/0++D5T
        vDNNHK33WFIhHYN4gCmI2E5FdxQsWHTMWvk9
X-Google-Smtp-Source: ABdhPJywy4Gt4P51oUB5nt5oZGHPJfsMPjzOwvghaHvPNzVpDigJllkoSBt/wD9BTgfHbVv/HGtG3A==
X-Received: by 2002:aa7:9626:0:b029:32a:f13b:7ab3 with SMTP id r6-20020aa796260000b029032af13b7ab3mr41497908pfg.43.1626954076854;
        Thu, 22 Jul 2021 04:41:16 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id z15sm33942218pgc.13.2021.07.22.04.41.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jul 2021 04:41:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [GSoC] [PATCH] submodule--helper: introduce add-config subcommand
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <20210722112143.97944-1-raykar.ath@gmail.com>
Date:   Thu, 22 Jul 2021 17:11:11 +0530
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE4FABF8-574C-4D01-872A-CE13E3975AD0@gmail.com>
References: <20210722112143.97944-1-raykar.ath@gmail.com>
To:     Git List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22-Jul-2021, at 16:51, Atharva Raykar <raykar.ath@gmail.com> wrote:
>=20
> Add a new "add-config" subcommand to `git submodule--helper` with the
> goal of converting part of the shell code in git-submodule.sh related =
to
> `git submodule add` into C code. This new subcommand sets the
> configuration variables of a newly added submodule, by registering the
> url in local git config, as well as the submodule name and path in the
> .gitmodules file. It also sets 'submodule.<name>.active' to "true" if
> the submodule path has not already been covered by any pathspec
> specified in 'submodule.active'.
>=20
> This is meant to be a faithful conversion from shell to C, with only =
one
> minor change: A warning is emitted if no value is specified in
> 'submodule.active', ie, the config looks like: "[submodule] active\n",
> because it is an invalid configuration. It would be helpful to let the
> user know that the pathspec is unset, and the value of
> 'submodule.<name>.active' might be set to 'true' so that they can
> rectify their configuration and prevent future surprises (especially
> given that the latter variable has a higher priority than the former).
>=20
> The structure of the conditional to check if we need to set the =
'active'
> toggle looks different from the shell version -- but behaves the same.
> The change was made to decrease code duplication. A comment has been
> added to explain that only one value of 'submodule.active' is obtained
> to check if we need to call is_submodule_active() at all.
>=20
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Based-on-patch-by: Shourya Shukla <periperidip@gmail.com>
> Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>=20
> This patch depends on changes introduced in 83913dd5b6 (t7400: test =
failure to
> add submodule in tracked path, 2021-06-18), which belongs to the
> ar/submodule-add (2021-07-12) series[1].
>=20
> This changes in this patch are no different from the one in my first
> submodule-add conversion series[2] which has already got some reviews =
before.
>=20
> [1] =
https://lore.kernel.org/git/20210710074801.19917-1-raykar.ath@gmail.com/
> [2] =
https://lore.kernel.org/git/20210615145745.33382-4-raykar.ath@gmail.com/

I forgot to mention, you can fetch this change through:
git fetch https://github.com/tfidfwastaken/git.git =
submodule-helper-add-config-1

