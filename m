Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CB6C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 12:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiLFMTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 07:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLFMTE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 07:19:04 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB70028707
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 04:19:02 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 136so13211678pga.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 04:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVWTMQ9+CpSbPfK3JDiGUMtXw5DUWvalZDVLZ2NBo4Q=;
        b=OsabsqtxqYgQHhpNQbkZVGHwTpdEyHb3Q1obXhU5untCXxSMRXOEsUMwCLC+fzo9aw
         TOPX+PTIk5w83nV2Ziy3MviHf89Tgyfz0rJtAnIxg3xKoxFWsOIMJnwYZJmYfEVCK4lh
         FeqG5m8IQPKOBaLh7Y1vvZpGA99PGQ6ARChWhXDe7V33GLxyHyDP1TYvvn38zrrbC1Bn
         mc8oMLAdkQ80YpANcTicd5gu0fKJmLnnE03I4OJonIeeIUfbaLxiLJDnX0sVq/rZktqc
         L+1eBAISUbVFikYTIWVjfhwFKS/1/RXWgaOtZcs1726fJXCNQGTFIPfrW6iks+2qq4CZ
         8UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVWTMQ9+CpSbPfK3JDiGUMtXw5DUWvalZDVLZ2NBo4Q=;
        b=xaKIMTwmvsnsFNj7wWWeNiBZ1eM3q8S7wqo92935PrmRtugqxWunB0jZOr0fEkc2Ou
         ywHHEehonWMzufLPu8YYPFEblDaOxiY/71h0Mhstr/revfsOfsdW8vyOx6UO3iR7edf4
         7smfg1G7q7HJeQwv9WvN0Oj/yug5C2li7dCiH08NFxJO1Rc8oA5ZOIAG5qDjfOkb+NaB
         c9uIUZ91gi8pYss0kXNKVB9ZdZF/EsqZCnJr8hJOxI41TfHsy55tBbY4LrwtI1snOFCI
         Pfwdz6v+M372WGw0zQw2E1xhZyz3TPrrawELiZp8UcaShn5QSxHSywHDtgYt4xQKFVv2
         T6dg==
X-Gm-Message-State: ANoB5pnmK6Ek7KbhwgkUyPLoCSu20qAt3Fbew7mIZEqMsRGkGoytmbNi
        V1lIsrzxVU+sapctgYvQFtE=
X-Google-Smtp-Source: AA0mqf6xrrd6AePy+Hd1aAse5v5PDs4zeR+zc6jeDAs6a4IfLaZEdPVC60ra1iquXgelQG74OUGMYQ==
X-Received: by 2002:a05:6a00:4501:b0:56b:b049:6c6c with SMTP id cw1-20020a056a00450100b0056bb0496c6cmr73545758pfb.22.1670329142082;
        Tue, 06 Dec 2022 04:19:02 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.53])
        by smtp.gmail.com with ESMTPSA id r25-20020a635d19000000b0046b1dabf9a8sm9775835pgb.70.2022.12.06.04.18.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:19:01 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     adlternative@gmail.com
Cc:     --cc=avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 1/1] push: introduce '--heads' option
Date:   Tue,  6 Dec 2022 20:18:53 +0800
Message-Id: <20221206121853.69819-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.0.rc1.5.gad6de9d3003.dirty
In-Reply-To: <CAOLTT8QcvPfXKap2aa6iyi0jq-cySL=XjDP2G2wG8m57=u0aGw@mail.gmail.com>
References: <CAOLTT8QcvPfXKap2aa6iyi0jq-cySL=XjDP2G2wG8m57=u0aGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > '--all' was introduced for a long time, meanwhile, git supports to
> > customize the storage location under "refs/". when a new git user see
> > the usage like, 'git push origin --all', we might feel like we're
> > pushing _all_ the refs instead of just branches without looking at the
> > documents until we found the related description of it or '--mirror'.
> >
>
> "--all" sounds like it will include all things: branches, tags, but it only
> includes branches under ref/heads/, which does cause a little confusion
> for users.

"under refs/heads", right （^ヮ^）? But The overall is nice to
me, I'm sure I will use some to revise.

> Maybe OPT_ALIAS() will be better?

I think it's suitable for this if there is no misunderstanding for
'OPT_ALIAS()'.

Thanks.
