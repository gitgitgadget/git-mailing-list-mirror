Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79FDC6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 21:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjCXVam (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 17:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjCXVak (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 17:30:40 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6AB19C52
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 14:30:40 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536af432ee5so57551837b3.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679693439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Up30ZFKJjGV/MsqHY4LoWSLF3/cfwJhLylvlb6CGOY=;
        b=ZTtqrP+s55YZrA3dPP4VN2rk8t3J0edx2ivQbkgFT6uiGsQ1qRVrsvggd8ZPusGwuq
         L5RnjGu5myCwpUSnqa5PxAOkeYlFjLIfuo2gwUloW508OG1OVS+em0Rni4Y9OCadZQIi
         9OtHk+M6aXd/uAy6gv0/iIVKxJP1obKB7Zg4tcKjKr1use5jaEIjZFA/WXlj/oTW0fAK
         YPs8UBBLvjVzh/mVGmxfgBUqzzgQjM7GoiuulSKWGNZOoarp46xHpqmlFVJSQcEU2zX3
         /TuE2BhrKx7nWb7Lg7EneSEN21lO4gyEQbWJNbQUKjKC/X4WB32n/YbDEezaylCQeLC5
         AvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679693439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Up30ZFKJjGV/MsqHY4LoWSLF3/cfwJhLylvlb6CGOY=;
        b=ujszxQxDkOh6MB4e7W/M8G/6f4qeKIdNaF/konPlWbUG4B99V4wGJxJxBBQYfviMFs
         D0+BXSjFpnbhnp09uCtjM73CW6KtiLZsbS6B8HOR7AmYECIJTb9TZb2dCCVpL5BhFBwQ
         TZr1HBDtj2XhrhFHIOARin3+DN2Bc+7YtmawNP8l7SVQ/Ya59AjYW4g8eLoX2gTTPXg6
         jltcmCDjkk5siGfGho9aL8oqRBbE63aH9zXRvWbaj/AAttViQP0E3SLYhBIO9wycmZMr
         MB9026kTsiMu5aDsJfb8iIMgh2049cEQJW/9sXfVvg3Apv/J4WDwae9TAAU6TUrprcEw
         u2iw==
X-Gm-Message-State: AAQBX9cS+vhRht3upmNiC/VXdZNciPEdaDuaE690ZkXeFcGJFCj4RSPl
        wTnO9We9W8SRcrD0Z0faH0fYjOA8jDFvJm34Wl0SPT4YH4w=
X-Google-Smtp-Source: AKy350ZL6EYCfMtve5UTFZab7w92VVhW9VgYvFJr7HAUT1BDg+dCwqclZPpH0ews6iXbhfbpFu9D3KIK/Y0UYN9fgbU=
X-Received: by 2002:a81:b647:0:b0:534:d71f:14e6 with SMTP id
 h7-20020a81b647000000b00534d71f14e6mr1684791ywk.9.1679693439167; Fri, 24 Mar
 2023 14:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAEeqB6=D_=qo1iHS2oJzFBJsgitBAeEJgWVFXX0jk1VpL0mb5A@mail.gmail.com>
In-Reply-To: <CAEeqB6=D_=qo1iHS2oJzFBJsgitBAeEJgWVFXX0jk1VpL0mb5A@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 24 Mar 2023 15:30:28 -0600
Message-ID: <CAMP44s0DDBX9O4e0K59mib2pazUKRuANdtL6QOf2MLvmp8MSXg@mail.gmail.com>
Subject: Re: Is it possible to set the similarity threshold in configuration file?
To:     Utku <ugultopu@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 8:16=E2=80=AFAM Utku <ugultopu@gmail.com> wrote:

> Is it possible to set a value for the `find-renames` option of the
> `status` command in `~/.gitconfig`?

There doesn't seem to be such a configuration:

https://git-scm.com/docs/git-config

--=20
Felipe Contreras
