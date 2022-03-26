Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53BCC433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 14:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiCZOM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 10:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiCZOM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 10:12:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163F14F9CB
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 07:11:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id pv16so20450555ejb.0
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5DvMOACbsHxKDlrFvXlzONBHy478c1/v7MQNDIpDKT8=;
        b=FBIB/aW1rEzDCa481q5EGW1FiX9UK/SvHulGJ4GORUf/dJhUdgsoNAP9B6+IjX1AD/
         9pVTuBAcX7dZeT+gZhppTszyNcAftdQZt+nLOwyaIQSZVpc5x75/J/1ONSuG1RSKejpk
         Sk1Luc/XhaxPkGiFrN3qgMK5WasgeFq4w3szo+MkkJ7V0dK2f7L3P9ntp+aiH80orsvV
         Pu/oxX7YSLYsi/AnXcECASZObxaMpFNyaEnLLRhh+kI99vmSNNPPxrTR/1RlIzBamGS1
         rsqrSrbj+5kHLidXLTCwG9QzEBAG+J3kdK/IsP1V/PuAugHtZfGeaufR/q96crAsHpi3
         zOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5DvMOACbsHxKDlrFvXlzONBHy478c1/v7MQNDIpDKT8=;
        b=3/eg6ejWsYt5w8pg27TG/ggVhVbsjS+V8m8a+xYNXkVbnY5enK49Z/9yWszqeKnJOy
         Cy0TTmeyiWmk6hG4n10nlVFI7GU2xiA/fyMg1BuIW+Kt7DLYzJTya1rL6XYxVm3usMYw
         PaMOLHX1LW1ARkvYmz+tnx2oPAhIrO/Is3LZAS8SYx7gwDzNQHHJPtNqeZYOmJ9O04tp
         LGE/ElB1IujS8SkUUGW/tCAFtX+zbCj/OHBNW9GjF9Euy+xiHVLQHU+vfKUjBXZALPvh
         jlRofLOAWzzMKgp0o2MQyKB53oQJWK6Ek1sb8XFs8NKk5bvPiuzlprSy9bovEre3enrm
         Mv+A==
X-Gm-Message-State: AOAM532DjZ2T8Fbi/UMnklB9033an5HlD8R76UHU/UCe2NsxVHk/+yZ+
        RRJZYJD7bFpAyOa8HMij9D7+IJW44QVCMLOlV4Y=
X-Google-Smtp-Source: ABdhPJwB+MYVkHhqaV/LjBrSwcSjuwccNULg8FR0ZRsnbgRND7ehqbAb+rzio0BAAtbOruYU9/iuhrggliuYNR/LOm8=
X-Received: by 2002:a17:907:3ea9:b0:6df:f197:81ae with SMTP id
 hs41-20020a1709073ea900b006dff19781aemr17966015ejc.402.1648303878619; Sat, 26
 Mar 2022 07:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <CANteD_wDSRmwLQiYV1x133WEtVaRK__c584E3CbXN1tPOquitg@mail.gmail.com>
 <2a7eecb4a0b247ef8f855f1c4fb5d510@SAMBXP02.univ-lyon1.fr> <7a522ccc-0a45-47fa-509c-a7a8b159041d@univ-lyon1.fr>
 <c1f255d7-6637-b6ac-0a64-1f64404a6f6c@github.com>
In-Reply-To: <c1f255d7-6637-b6ac-0a64-1f64404a6f6c@github.com>
From:   Jonathan Bressat <git.jonathan.bressat@gmail.com>
Date:   Sat, 26 Mar 2022 15:11:07 +0100
Message-ID: <CANteD_yZ8de2i54EUWW=d6eVzpiKm5NNHGVEKrXOmo5KXnXUVQ@mail.gmail.com>
Subject: Re: contrib/vscode/: debugging with vscode and gdb
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Cogoni Guillaume <cogoni.guillaume@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/2022 2:27 PM, Matthieu Moy wrote:

> I couldn't understand what exactly the option was supposed to do. If I
> understand correctly, it should launch another window to show the git
> program output, but I don't know which window actually (xterm?
> x-terminal-emulator? a terminal program that isn't installed on my system=
?).

In VS Code settings, it seems to be x-terminal-emulator.


On 3/25/2022 8:01 PM, Derrick Stolee <derrickstolee@github.com> wrote :
> >> - "externalConsole": true,
> >> + "externalConsole": false,
> I'd actually remove the line completely, to mean "let VSCode decide what =
to do", i.e. either VSCode's default, or the user's configuration ("launch"=
 section in settings.json, see e.g. https://code.visualstudio.com/docs/gets=
tarted/settings ). If some user has a > non-broken externalConsole: true VS=
Code and likes this behavior, then the best place to configure it is in a u=
ser-wide config file IHMO.
>
> I confirmed that deleting the line works just fine.

Yes, we agree with both of you, remove the line completly is better
because it let the user choices his preferences.
And it also work for us.

> Reported-by: Jonathan Bressat <git.jonathan.bressat@gmail.com>
> Reported-by: Cogoni Guillaume <cogoni.guillaume@gmail.com>
> Helped-by: Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
> contrib/vscode/init.sh | 1 -
> 1 file changed, 1 deletion(-)
>
> diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
> index 27de94994b5..f139fd86444 100755
> --- a/contrib/vscode/init.sh
> +++ b/contrib/vscode/init.sh
> @@ -271,7 +271,6 @@ cat >.vscode/launch.json.new <<EOF ||
> "stopAtEntry": false,
> "cwd": "\${workspaceFolder}",
> "environment": [],
> - "externalConsole": true,
> "MIMode": "gdb",
> "miDebuggerPath": "$GDBPATH",
> "setupCommands": [
> --
> 2.35.1.138.gfc5de29e9e6
>
>

https://code.visualstudio.com/docs/editor/debugging
https://code.visualstudio.com/docs/getstarted/settings
Maybe, It would be nice to add these two links in
contrib/vscode/readme.md, this may be relevant to
help new users that want to use vscode debugger. And add some explanations
like "How to use it".

Except that, your patch sounds good for us.

Thanks,

Guillaume and Jonathan.
