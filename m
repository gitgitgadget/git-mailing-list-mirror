Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE5FC07E9B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 07:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE3A6113C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 07:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhGUGuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 02:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhGUGsp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 02:48:45 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A22C061787
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 00:26:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u126so1560356pfb.8
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wfRY9neLw/Lx+LLbzqH93rFm8fOh2ZUsK5n5UqrOfqE=;
        b=rupiJmKcs0SsYnIVaq+dLCTXAGkuKpyO/caFHOlhS3Hf6DM9K6aJiza4Fto6f7/UVE
         ezLDC2K2k6QAoCoYRdTwwySHuLPy0a42fjp6eSEXYZFWmmUxf2nK34pJEfZ1MSKFosCg
         m04Rl+UJYxBvWTN9Muw7+JftuenMYxlFMnSe1nOWSq0DSWDCK7fR+lWDXS4v38URYVW+
         s/yQ/xPpXz7UuIinESJU/oNi9AFVkJpWgzkcKI/1dCKYswUtSWXKm92GliVLb/SbT3st
         0Ta4SDhmkXGaV2ChydGjfWQyMojm8OjWpf6ac5tNmsK4lkOmBo37kgWb/vM1forryIkU
         nZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wfRY9neLw/Lx+LLbzqH93rFm8fOh2ZUsK5n5UqrOfqE=;
        b=cyvxhBrW+SYkXQzNtiz2G4tS4xBwXIBl1SKAfw0tojCosq3s0KuBLCcX7UfQEZHAyd
         oZ2GGyH5+pEKyA7oMgiPxWQMJ+xM4YI+iySunWbAJHQPDSGIBQ3FkaeJE0ThdKVwu4QL
         O/pf2b9ffX9mlepaYS2iqUpv5LWzr7ek5vtiXV+k0ZO0TqycA7BJB7xPEP1TKeVa6fFT
         xxTOKHAOWrIRoWcqsqOUb4m/WYFECtDKLrWbSLizwRS6bwZFX6MFw5+z+gcQbiHPc6pj
         LKBjXl+yVRlJ+5JK88gBY/ith+G5Hjt9WtDlhIu1c1s0A/gzFf9lOCb6LGQ0efQd9stk
         mqjw==
X-Gm-Message-State: AOAM530CXTto1qwKiJLou4QKLwhIhMzQkGAgwgLjEUi3tQCsKMNeWgJl
        1Wr+usyB6dqSUmhinB1aY3U=
X-Google-Smtp-Source: ABdhPJzvtwJu8ig0GkNhMyOQugTgyK42i/qFfDRRuHiGXZ/Xmt44HQN1kf5a1+LxYgwVc6UdeG+jXg==
X-Received: by 2002:a63:df14:: with SMTP id u20mr34596078pgg.348.1626852378335;
        Wed, 21 Jul 2021 00:26:18 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id t1sm5237432pgp.42.2021.07.21.00.26.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jul 2021 00:26:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Why do submodules detach HEAD? (was Re: Incorrect and inconsistent
 End-Of-Line characters in .gitmodules ...)
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CANt7McHrYhSe3JsS8UKX8NgsUajwxQY4h9KTtXkEXdd0Be_+yw@mail.gmail.com>
Date:   Wed, 21 Jul 2021 12:56:14 +0530
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <46F5B91F-4DBE-4F34-9395-7CC808FAC359@gmail.com>
References: <CANt7McFAu5gAFcgd+dejQjDQDxfcnyhz=BxSAejXGMMtGQzO_w@mail.gmail.com>
 <YPHgUuxqmKFkbEku@camp.crustytoothpaste.net>
 <CANt7McHrYhSe3JsS8UKX8NgsUajwxQY4h9KTtXkEXdd0Be_+yw@mail.gmail.com>
To:     Rostislav Krasny <rosti.bsd@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18-Jul-2021, at 02:52, Rostislav Krasny <rosti.bsd@gmail.com> wrote:
>=20
>=20
> [...]
> I would like to take this opportunity to ask: why cloning a repository
> that contains submodules sets this repository branch to its default
> (master, main, whatever) but all submodules are set into a detached
> HEAD mode instead of their default branches? This is actually the
> reason I started to check what happens with the .gitmodules file. What
> is the point in such an inconsistent behavior? There are a lot of
> questions about that in Google and it seems most of the users expect
> different behavior.

Submodules are cloned along with the parent repository only when
'submodule.recurse' is set to true, which I assume is the case for
your configuration.

A git clone that recurses submodules is equivalent to running
'git submodule update --init --recursive' right after the parent
project has been cloned.

The default mode for the update command is to checkout to the
revision that the parent project expects the submodule to be in, ie,
it checks out to the commit hash directly, and detaches the HEAD.

Why not checkout to a branch? This is because branches may change
which commits they point to.

For example, if you had a submodule 'foo'. I go into the 'foo'
folder and amend the last commit.

Now if I run 'submodule update' in the parent repository. If it had
checked out to the branch instead of the revision, I would be on a
different commit in 'foo' than the one that was registered by the
parent repo!

We want to have idempotence, ie, for a particular revision that is
registered by our parent project, we want 'update' to give the same
outcome every time, and not be dependent on whatever the state of the
branch is. This way we ensure that for a particular commit in the
parent project, the submodules will be in the same state for every
system in the world, after an 'update' is run.

I hope that makes sense.

(Anyone more knowledgeable than me in submodules, feel free to add
to what I am saying and correct me if I made an error!)

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

