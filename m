Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D414C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 12:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06FBF60FC1
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 12:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhHBMsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 08:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbhHBMsX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 08:48:23 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DCC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 05:48:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ec13so23780147edb.0
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=uysrQoYfluUtLuTF2eZQ1aeHVpqnCe46TRP/MM87lSM=;
        b=ld8oACJZPn7revYk2FKtNkKLQn2uYLrYieV87AhIqZaWpdhAviZHU3zJBSgbn4/PIk
         Zt4xMmEiEG4Plkz+5cWjMBq3EKMnbZ6Q4zmmOQYj8SA5DSyEe+Y49Xa7rTCsJxLR0ac+
         WfU0G/kABawlfceCTB4s95K3J/tJGz2U4SFcUIC3T7gLsM7mcT8AvjlDwvBKQn8MDFZW
         bsMfa15z0pz/AOd7qjzQnUE5jYykZTsXQDB3py2YGGrbEjO4+SjRGM4XVqfhwOQrRVdE
         oSKgVHtokWyaCmzpO0iXyfqP7gzCDwG7pK8ufpoN93BFUdWDXdD14NYWWp8Sud0heqWr
         bb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=uysrQoYfluUtLuTF2eZQ1aeHVpqnCe46TRP/MM87lSM=;
        b=KvjRTu9iZVatKug3LpvZgz2MLTgncDiGhezICK9ZLDt6UxTi6vhott6erbuqUDoxBJ
         gZzcA72bsyIO3gUIg3ui4zOVu5VSf5NS3253vWiWLTuaFNqsMu5eqUnoEKhJSA8R7WY9
         kNvVV4fXEai0QHPag5+guj+P70gMOWz3vYqAoI+q9n8WYJsgoWzIusPql4+rDJz6GzH6
         uUPBBdkodoz45tkx1tpb8PAwGmD5DiG5BvgBy4jr75UsHnpZxVTTMDkSf3ZRB88ZkKMx
         4FzzlzcrKjEFxYLhXLoETbNhYNmA6YsS0xiYU/wClTxWJFNEJplfpH1aYhWTQcuamNMu
         PFYw==
X-Gm-Message-State: AOAM530wIUsDaeBvZ7GqJBZpHQT9ircvRUNyVWYUAyikd0QZGQU22EPB
        X1uy+z6ofT4XeaMs1gs9RD4=
X-Google-Smtp-Source: ABdhPJw7Lw+YS+Spu3DHOiRx3EpPjBaZqcY4xp4boAQJ0LGIwVMbl7bdXxOhVdyhFejoiM4HFnnCuA==
X-Received: by 2002:a05:6402:3507:: with SMTP id b7mr19478365edd.293.1627908491195;
        Mon, 02 Aug 2021 05:48:11 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s10sm4502365ejc.39.2021.08.02.05.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 05:48:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tr2: log parent process name
Date:   Mon, 02 Aug 2021 14:47:13 +0200
References: <20210722012707.205776-1-emilyshaffer@google.com>
 <20210722012707.205776-3-emilyshaffer@google.com>
 <87o8agp29o.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <87o8agp29o.fsf@evledraar.gmail.com>
Message-ID: <874kc8ovw5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 02 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Jul 21 2021, Emily Shaffer wrote:
>
>> Git for Windows also gathers information about more than one generation
>> of parent. In Linux further ancestry info can be gathered with procfs,
>> but it's unwieldy to do so.
>
> Having read the win32 get_processes() implementation and read proc(5) I
> don't get how it's unweildy to do so on Linux? Perhaps I'm missing some
> special-case but this rather simple patch-on-top seems to do the job for
> me. This includes the unrelated enum/switch/case change I suggested.
>
> I can submit it as a patch-on-top with SOB etc, but maybe there's some
> subtle reason it won't work properly. It works for me, I get e.g.:

Just a note[...]:


> +	strbuf_addf(&procfs_path, "/proc/%d/stat", pid);
> +	fp =3D fopen(procfs_path.buf, "r");
> +	if (!fp)
> +		return;

I think this is mostly ready, but is still clearly in POC state needing
polishing, e.g. I didn't bother to close "fp" here, but a final patch to
implement this approach should of course do that.
