Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C27C77B70
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 17:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjDKRBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjDKRBT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 13:01:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2883D5FE7
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 10:00:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ga37so22448819ejc.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681232453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsaYaRrUR5v6Y07nbAWXWZSZzs58yaDO5HPbbnfQ4pw=;
        b=S1mWt6KvXQ1HAboJUxCT4f/vqPBxCJrL2knmb/Y1oXH3HWVl931OQySNz1VbRGGKZN
         JGy/1TSGSKYr9ft/KQfRwMBhCR0kMDXzRHfPn4UDgHByegwFWewCQxmXrxcW179psAQ9
         iFOCBjGGM0PhZYZd10LNFfDS656buHjOk/CM70Eypli0ZR3ZqxQAPWk/WlZ95gaIdfP4
         SYS/T9XTlL/52dHYIpLIS6Lj3oWVna8LjFxzpj67toWz9j5A/2pt/AyxoWfch2b7qqsg
         AvygBVn+Mpfrb8VaCwPtPDw2lpStDsbmAts+43DcuNeDlv2BVm3Ylta3NGUQRTARAVM0
         tORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsaYaRrUR5v6Y07nbAWXWZSZzs58yaDO5HPbbnfQ4pw=;
        b=zEn7zwxjVklh5INd/m6YyPIS1BmK+1p6Ohgi1J+NVCQ9Y6uZug38Ef98Mdups1T+Jw
         EVO4zIOLV5KoARyc398auvRxdWjRHGzpJ0dyLZfxC5UHQZJjDeHXSfCH98Bqks6wYBSE
         mT+FlWn54ZQli19mJCz1Urvcpe+YMt3XISGo+XdZr4FUjWLYgZEaG782D0pSFx000y6i
         yfsaJeemLuZMeQPI9OaJzvQPtCT9H624909DueBkfbUBuTd3E4DFG/2yD2ox7r2M7WEU
         cqhHwbFfrJ1wwUBjFPBCB+tWcByr4to2l7a4EthhmIvJyRHf4MCYXc8Omq0yNlNQOeWP
         /86g==
X-Gm-Message-State: AAQBX9epPBBgT9xB/Q+eYgLRnCu5mvVbsgXvkDy29UwPHsuGvifKbNQW
        uhEgFUHatBoQ4Tbc++8ApQqgJLZJysK9A1ifjLQeix3zIOLTzXXUVK4=
X-Google-Smtp-Source: AKy350b+nz/LBUV/qJMDEDcdXi8Kf/X3Y1cSdQU+UZBUkaFWBQ7ewvn7fkC5ngdKfhiBYe4AmYqWykUzup5EVRHnBQU=
X-Received: by 2002:a17:907:c316:b0:93d:1b82:3c13 with SMTP id
 tl22-20020a170907c31600b0093d1b823c13mr5830768ejc.7.1681232452851; Tue, 11
 Apr 2023 10:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <3352350.44csPzL39Z@takeshi>
In-Reply-To: <3352350.44csPzL39Z@takeshi>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 11 Apr 2023 10:00:40 -0700
Message-ID: <CAJoAoZ=VdHy0gTCGiWnRw==Wbmfst2Gpg2Tf498_P+batU1ixw@mail.gmail.com>
Subject: Re: Bug with git-config includeIf
To:     Matthias Beyer <mail@beyermatthias.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 9:32=E2=80=AFAM Matthias Beyer <mail@beyermatthias.=
de> wrote:
>
> Hi,
>
> please keep me in CC when replying, I am not subscribed.
>
> I experience the following (seemingly) bug in my git setup:
>
> I have three files for my git configuration:
>
> * ~/.gitconfig -> ~/config/git/gitconfig
> * ~/config/git/gitconfig_private
> * ~/config/git/gitconfig_work
>
> The gitconfig_private sets my email address to this very email address, t=
he
> gitconfig_work sets it to me work email address.
>
> The gitconfig file has a `includeIf` directive:
>
> ```
> [include]
>     path =3D ~/config/git/gitconfig_private
>
> [includeIf "gitdir:~/dev/work/"]
>     path =3D ~/config/git/gitconfig_work
> ```
>
> That means, from my understanding, that all git repositories in ~/dev/wor=
k
> should now have the work-related email address set.
>
> If I go to ~/dev/work/somerepo and `git config --get user.email` it indee=
d
> shows the expected email address.
>
> But if I go to a subdirectory in that repository, the very same command s=
hows
> the private email address, and commits get written with that private emai=
l
> address.

One thing that can help a lot to debug is to run `git config --list
--show-scope` from this subdirectory where your config is misbehaving
- that will help you understand which of _private or _work is being
included in the parse, in which order. It could be there is another
stray config overwriting here.

>
> Did I miss something obvious or did I discover a bug?
>
> git: 2.38.4
>
> Best,
> Matthias
