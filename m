Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F03C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 02:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350907AbiASCgu convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 18 Jan 2022 21:36:50 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:42661 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbiASCgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 21:36:47 -0500
Received: by mail-lf1-f43.google.com with SMTP id e3so3157309lfc.9
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 18:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ayIDCtuNKuPjf4F3dNRe12CbYgf8StEn3k5W8SG2738=;
        b=Y9wclHN50CdhWAiJx4AkbWkxhFKvb6qy3qGgaGN9B0a+GGl/boU50H26Cx9VHTcjNa
         ej2k0JWrtVXjosWQQHgOQv1+a2tiJP5Narmtok3zLKjPIfn3v1pIM/aFF+NltKuZCxmV
         8AF0G+YYEXBtjNZ/fSyko9mpBtNdu1kMPvcG7xbDAEJTobOScRcohnXfE1f1FohGI7Pb
         813d2g2XOE5Kp8Nrd8aP3eM5G/YNUppzltK8FqhU2NDeYCtP1CXltR6iohFYh+VWC5qN
         kx58dXiUXt03P6O0oIMdi2vpOtd2lendNz3JJywhEws9jtPSM30Ees376HgYlvvMRvlQ
         8tRQ==
X-Gm-Message-State: AOAM533kh3HG2LJAVeAEW2IftwEWISu9SiMLdVWfM/UWbbGGjIG+cUgk
        VQBQxdYJ8BD6UyjTV+7SPBRBJa0A8jhmV7xxTcA=
X-Google-Smtp-Source: ABdhPJwgbbqexVAsbjJ3X28UjPKZQmkzk5fbvaWFfbsiL/Uy7oQUVsAE4rQqXfVWjCchmO+Qks2YkdoRbVZdj0pjoV4=
X-Received: by 2002:a2e:7205:: with SMTP id n5mr15951982ljc.409.1642559806226;
 Tue, 18 Jan 2022 18:36:46 -0800 (PST)
MIME-Version: 1.0
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g> <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <20987dc6-e0c7-6ca2-19fd-2b323b3f6d9f@web.de>
In-Reply-To: <20987dc6-e0c7-6ca2-19fd-2b323b3f6d9f@web.de>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Tue, 18 Jan 2022 18:36:34 -0800
Message-ID: <CAPc5daWWq3KPt9hXXK8DKSFUgL3kdSeSoRcePQy8-sFuMOQ8WA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] bisect--helper: double-check run command on exit
 code 126 and 127
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Christian Couder <christian.couder@gmail.com>,
        "Miriam R." <mirucam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/bisect.h b/bisect.h
> index ec24ac2d7e..748adf0cff 100644
> --- a/bisect.h
> +++ b/bisect.h
> @@ -69,4 +69,7 @@ void read_bisect_terms(const char **bad, const char **good);
>
>  int bisect_clean_state(void);
>
> +enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
> +                                 int no_checkout);
> +
>  #endif

https://github.com/git/git/runs/4861805265?check_suite_focus=true#step:4:65

In file included from bisect.hcc:2:0:
bisect.h:72:48: error: ‘struct object_id’ declared inside parameter
list will not be visible outside of this definition or declaration
[-Werror]
 enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
                                                ^~~~~~~~~
cc1: all warnings being treated as errors
