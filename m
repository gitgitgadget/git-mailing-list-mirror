Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B729C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 12:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiDFMvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiDFMum (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 08:50:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805F184268
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 01:54:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bg10so2843130ejb.4
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 01:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=dycLZeYDtAS8Pmqb6jbd6EICs7j3zunSoCa0S5G5wCw=;
        b=h0jey8R8wj27VtTyQ5zucwbWM63j9Sh34O/gL348oDvjvoPt4fmUx0l3ZmNqdCUfqU
         L18bWsS84PB/ZeMH//gshff1iGaOx5bcTaQf9kqyvH1uBniYuFgPjhOj/+FrllOEhlmj
         Kv4TWIOFLk4eUxY15fl9ITv9HsdeBWzP4cx5JYR0e9vMk60yewyIyNdrQSY4YaCQbPgs
         TBEUQHWtoA86EnDK1Na/MoQ5AJ6oNREs0MfMLCPc0W2oL3r56DDZOcxlEzUxC6+Ld+XZ
         +eNSorf0bH9++x7yX3Vz7WNJjossYuObRTs+N98KWdQMFF7DyE+2ik4jrPZJ74JrsEaV
         veFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=dycLZeYDtAS8Pmqb6jbd6EICs7j3zunSoCa0S5G5wCw=;
        b=XnaGDpbkdoTQgRYNfjLDuZDffh4SsD4BE+Xv7u+xC4sjwRT0gdUcLGacelohgIOqgR
         APNEGD4tklR/xFUfs0+Ju5FUL4jSXEg9+dh+VUpPrwd4gI06mJQlg9Mo/k4eNyiWmSXR
         5lzNXt1oFETU6nLOitXcDri0ONgDNDihzUzv/5YetSYi07afywxZZhkjHwggxakUtWGO
         P6cSr7tVbzbCdsU4Ee72O3oP6HThp9Ue2i/JeLZeWfYYbYQ1J7pwC//uWK79Ha0coh3j
         morbGVMlARFcy7jYegcDJ9fgYIKgxPPLbMMIu5MdjJA1543csANB+EFQIMlvZoIsI2+b
         k3zA==
X-Gm-Message-State: AOAM531nM6q3V5TRefvcYTaKv6/smP+PgudpdMASNFIDrywKcjIaKzo5
        cEfVRX6AA+f5cRG64rEvpdQ=
X-Google-Smtp-Source: ABdhPJygRT8zFERxdoOF6IsSk/PM0jSf8rqI8wrHs6a8mL25kJ7WU574/3/VFcbfNH4hKyMxZLvivw==
X-Received: by 2002:a17:906:40da:b0:6ce:51b:a593 with SMTP id a26-20020a17090640da00b006ce051ba593mr7383262ejk.604.1649235245728;
        Wed, 06 Apr 2022 01:54:05 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e11-20020a50becb000000b0041b64129200sm7939311edk.50.2022.04.06.01.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 01:54:05 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nc1QS-000aVX-A0;
        Wed, 06 Apr 2022 10:54:04 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     COGONI Guillaume <cogoni.guillaume@gmail.com>
Cc:     derrickstolee@github.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Subject: Re: [PATCH V1 1/1] contrib/vscode/: debugging with VS Code and gdb
Date:   Wed, 06 Apr 2022 10:47:16 +0200
References: <6f4b924d-0a13-b267-6766-a3620936b686@univ-lyon1.fr>
 <20220405224502.38544-1-cogoni.guillaume@gmail.com>
 <20220405224502.38544-2-cogoni.guillaume@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220405224502.38544-2-cogoni.guillaume@gmail.com>
Message-ID: <220406.86sfqqegnn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 06 2022, COGONI Guillaume wrote:

> +Using the integrate debugger can be particularly helpful to understand how Git works internally.
> +It can be used to isolate some parts of code, with this you may be able to ask more precises
> +question when you are stuck. (See getting-help sections).
> +A script that creates the configuration files is available in contrib/vscode/init.sh. Useful links
> +and explanation of how to use the script are available in contrib/vscode/README.md.
> diff --git a/contrib/vscode/README.md b/contrib/vscode/README.md
> index 8202d62035..f383c95e1f 100644
> --- a/contrib/vscode/README.md
> +++ b/contrib/vscode/README.md
> @@ -6,7 +6,11 @@ code editor which runs on your desktop and is available for
>  [Windows](https://code.visualstudio.com/docs/setup/windows),
>  [macOS](https://code.visualstudio.com/docs/setup/mac) and
>  [Linux](https://code.visualstudio.com/docs/setup/linux). Among other languages,
> -it has [support for C/C++ via an extension](https://github.com/Microsoft/vscode-cpptools).
> +it has [support for C/C++ via an extension](https://github.com/Microsoft/vscode-cpptools) with
> +[debugging support](https://code.visualstudio.com/docs/editor/debugging)
> +
> +To get help about "how to personalize your settings" read:
> +[How to set up your settings](https://code.visualstudio.com/docs/getstarted/settings)
>  

The upthread "How did you generate this patch" question from Matthieu
still seems to apply. I.e.:

>  To start developing Git with VS Code, simply run the Unix shell script called
>  `init.sh` in this directory, which creates the configuration files in

This context is something that's not there in the file on "master".

I really don't mind having some guide for VSCode in our developer
documentation, but I think if we (as a free software project) are
recommending proprietary software we should put that in some context
where we explain if/why it's needed, and if free alternatives are also
suitable.

I haven't used the VSCode integration you're documenting, but from the
diff and the "gdb" mention I gather that this isn't using some "native"
debugger of MSVC/VS's, but just using the VSCode editor as a wrapper for
gdb?

If that's the case wouldn't it suffice to link to some generic getting
started guide for debuggers? And e.g. recommend the GDB manual, maybe
there's a better online reference (I read it locally), but e.g.:
https://www.sourceware.org/gdb/current/onlinedocs/gdb.html

Then if we're recommending GUI wrappers those are a dime a dozen,
e.g. Emacs's GUD mode:
https://www.gnu.org/software/emacs/manual/html_node/emacs/Debuggers.html
