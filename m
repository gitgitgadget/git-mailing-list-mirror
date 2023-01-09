Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E567C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 21:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbjAIVlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbjAIVk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 16:40:28 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5242763C0
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 13:39:12 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so23652788ejc.4
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 13:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiV9TwO0x9fUnUdSaT2hIjwlEgKCsQlTI1BUEYucR4w=;
        b=ERXM3xSBngKFSCZbKRwZy4twL4Wyip9UqGeVH9cYA4SH9pQWHUFz2pSoNfHVY5AWhn
         zaNHpCrpGToaC8foi/3Kh1q04b+/WfQw3U7mvCQ0X7lnNyaXhXiZ6vjzmjmBOSSGzMF5
         3SRsBJ9MJtlQSIwkiWER2xsh0xfQ9uNipYKWMiz4gkhgHExtyfiM0Iz85UsnQUIPgArE
         4tuhtJp3k3squxUycQNajpHRJLv+cQMvcljvXLgsTfUirU4MOM5OgCtp0wHnbFGad7aW
         t6R+xuRhA51yNcv54kpK1WSkFwlh3R+0ZnT/wpSuRjeTCXTrqHmrH56SoPebJgX8bJiC
         dJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiV9TwO0x9fUnUdSaT2hIjwlEgKCsQlTI1BUEYucR4w=;
        b=ayLraMk/Vyv64PwjO0pVn4IqoTXLS/pMLLtFeXwycGDwH0HCWtSJLLP1LEHEPvgXc+
         qxGx3GKP2X3ZLEW38rhke1W9i6XW8nFClVtf7tiQqQz6fa9v6EaLreYLXCskjSETr2N4
         7Hymz9G0We91pqbMWTSh+LBfbdwgQBwSNeScxhMilqcW6+LSve6NUTwYUt4qhlozTg6c
         2CcnZaceOkrIylluvsQ+c0bP+4A5UBibNz7N2xNC9kK2rXhJymyEgu8sW198Hze9dvBb
         kXQ/or54+yspv2PwGrzn+iQbFBer9ZE5AgXSBbjHafGiMOovXIcpUhxc8zF7FdEZAZuD
         8KWg==
X-Gm-Message-State: AFqh2kokr3Vht2p+tAzJMQzrniBficYJyCaqq80Mn1P5xAK0skByYcZm
        7+jdEYTTaBwICWDtFBm1CAQphVc+EyQVwr02MGMahC55Yx7zqQ==
X-Google-Smtp-Source: AMrXdXvP8jg8SpfG5p9+w+MBEHcUFUcjnewZkSy/cFCJKWoRs9ps4qw/GugqOyvZOySniHhDgPAsudaYsTiTYP9vBYo=
X-Received: by 2002:a17:906:2896:b0:7ea:5ba6:e773 with SMTP id
 o22-20020a170906289600b007ea5ba6e773mr6663571ejd.506.1673300350844; Mon, 09
 Jan 2023 13:39:10 -0800 (PST)
MIME-Version: 1.0
References: <CAEg0tHSLyaewkgGs0dEXfwQhKmbiO65bXZVU8t7Kn4WwJ1p0Fw@mail.gmail.com>
 <xmqqfsclzlqx.fsf@gitster.g> <CAEg0tHT5PD4K89E3fcNq_WbaLPHozLi-PsJFDsQrzkGi7Na9jg@mail.gmail.com>
In-Reply-To: <CAEg0tHT5PD4K89E3fcNq_WbaLPHozLi-PsJFDsQrzkGi7Na9jg@mail.gmail.com>
From:   muzimuzhi Z <muzimuzhi@gmail.com>
Date:   Tue, 10 Jan 2023 05:38:59 +0800
Message-ID: <CAEg0tHQtf9G0N24Xfe-gvRM1AFaiS_ApcuQ8hZtsZAeMhhVWAQ@mail.gmail.com>
Subject: Re: [PATCH] doc: fix non-existing config name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Clemens Buchacher <drizzd@gmx.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Somehow My last mail failed to sent to Clemens Buchacher (drizzd@aon.at):

> 550 5.7.1 <drizzd@aon.at>: Recipient address rejected: mailbox not found

I found two lines about Clemens in `.mailmap` (see below) [1] and
drizzd@gmx.net was used last time when Clemens mailed to the current
mailing list in Feb 2019 [2].

    Clemens Buchacher <drizzd@gmx.net> <drizzd@aon.at>
    Clemens Buchacher <drizzd@gmx.net> <clemens.buchacher@intel.com>

Thus I added drizzd@gmx.net to cc.

yukai

[1] https://github.com/git/git/blob/a38d39a4c50d1275833aba54c4dbdfce9e2e9ca=
1/.mailmap#L45-L46
[2] https://lore.kernel.org/git/B168DCB1-7A69-4729-89C7-B513464DD468@gmx.ne=
t/

muzimuzhi Z <muzimuzhi@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=B8=80 12:18=E5=86=99=E9=81=93=EF=BC=9A
>
> Replace non-existent `branch.<name>.fetch` to `remote.<repository>.fetch`=
, in
> the first example in `git-fetch` doc, which was introduced in
> d504f69 (modernize fetch/merge/pull examples, 2009-10-21).
>
> Rename placeholder `<name>` to `<repository>`, to be consistent with all =
other
> uses in git docs, except that `git-config.txt` uses `remote.<name>.fetch`=
 in
> its "Variables" section.
>
> Also add missing monospace markups.
>
> Signed-off-by: muzimuzhi <muzimuzhi@gmail.com>
> ---
>  Documentation/git-fetch.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> index 63d9569..fba66f1 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -251,10 +251,10 @@ EXAMPLES
>  $ git fetch origin
>  ------------------------------------------------
>  +
> -The above command copies all branches from the remote refs/heads/
> -namespace and stores them to the local refs/remotes/origin/ namespace,
> -unless the branch.<name>.fetch option is used to specify a non-default
> -refspec.
> +The above command copies all branches from the remote `refs/heads/`
> +namespace and stores them to the local `refs/remotes/origin/` namespace,
> +unless the `remote.<repository>.fetch` option is used to specify a
> +non-default refspec.
>
>  * Using refspecs explicitly:
>  +
> --
> 2.39.0
