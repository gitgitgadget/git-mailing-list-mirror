Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98752C54EAA
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 10:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjA3KGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 05:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjA3KG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 05:06:27 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193CE30B1A
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 02:06:24 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id kt14so30181262ejc.3
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 02:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2EOYWDbs1Jgg2rd6cYxAZTjF2avrg2v1IkdzDcr56sU=;
        b=oNqrHCATDMsWQrR/jGOZsFEiQxPbfIlw15TbdQoNqHF/MslNvp6Vvw4Y+cpwpJ7lUT
         4irxQR2xY7mk5f4eQv0O83Bp3LceEkY1RCGd3o9xi7XGirSaY3YuBloQSaMlePOk+6Qb
         5zuzQoPg/a168yZBNSuz4e2jMIOZO+nxhRP9U8I9bB0YznHU7TeWvtxbx/RnFf5ElAIt
         LCEYR87QjlT0l1qal29NiYGsuhiF4/Ucwv9t+GZoJvmmu3Dwx8H4t15VA4YgzhZc3yX7
         FRs+xccCxijb72RjJHn/2TLn/3zMIOOmodj58yxgyzMykyKSvI65PDjXI/N5nri+FjMt
         ylIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EOYWDbs1Jgg2rd6cYxAZTjF2avrg2v1IkdzDcr56sU=;
        b=h3LXNIf5/vnY3Liew6NuBt3ksorDVNmuxJYwVMgtKVx3v+5/94/vrW1jEjL6lqLGO6
         DyeeCakfkxFoo8VO1zTZKCOtjvKFJtO1+MrZk9+tfk1MwzHhXi8P8YSV2KBi6mhy0Hlf
         EZVGb730O1BMKn/Tjckc7TqVHOW8sFgZqHfGwKFH7DeXSm2vtRl0LDVB2jFrUJvoGf6E
         4uoh/paVA903TH2ifgSGUJl3O7ZgQnhfP18quY9N2c8rsJBmUcMV770PLzNdeijHsbNi
         8axH5AgKG5JklyXuQ+GyOTF4XOMf+RKmWoZzP02TacN7AsYmvLnBBgPor+I+xr8laVvb
         wX5g==
X-Gm-Message-State: AFqh2koaPz6RDsogQO5rMBc3jAyuDAbTJOmTFT0QJ1LLEd+uamBCD5ex
        HO9qnZDgx+h0eehQTsYUvV48Pp57Z45w7A==
X-Google-Smtp-Source: AMrXdXtqJbHQGo7SRZMMzAiFHoFiWi/owOl5dWz4WXUTkkrYG2Cc5adIDE2zd5OoCbJlv2tRCbbsnQ==
X-Received: by 2002:a17:906:583:b0:7c1:65f5:7b95 with SMTP id 3-20020a170906058300b007c165f57b95mr50001333ejn.26.1675073182643;
        Mon, 30 Jan 2023 02:06:22 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906380900b00878130e170bsm6577566ejc.131.2023.01.30.02.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:06:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pMR3N-001huo-13;
        Mon, 30 Jan 2023 11:06:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v15 6/6] fsmonitor: add documentation for allowRemote
 and socketDir options
Date:   Mon, 30 Jan 2023 11:04:46 +0100
References: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
 <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>
 <af7309745f759532fdb79794289d9e02de0e035c.1664904752.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <af7309745f759532fdb79794289d9e02de0e035c.1664904752.git.gitgitgadget@gmail.com>
Message-ID: <230130.86k014s5eq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 04 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
> [...]
> +include::config/fsmonitor--daemon.txt[]

We tend to name these files after the config namespace, not the name of
the built-in that's (mostly?) using it.
> +
>  include::config/gc.txt[]
>  
>  include::config/gitcvs.txt[]
> diff --git a/Documentation/config/fsmonitor--daemon.txt b/Documentation/config/fsmonitor--daemon.txt
> new file mode 100644
> index 00000000000..c225c6c9e74
> --- /dev/null
> +++ b/Documentation/config/fsmonitor--daemon.txt
> @@ -0,0 +1,11 @@

So this should be just .../config/fsmonitor.txt

