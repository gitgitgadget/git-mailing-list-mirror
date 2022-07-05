Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F285C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 10:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiGEKbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 06:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiGEKar (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 06:30:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800C315735
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 03:30:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n8so14742678eda.0
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 03:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oUA/utiacTqBvENsm/1HDO7ZvtJjyIlan4u4jQRzI+Y=;
        b=bbKw/RoYRAjw3aNPoRrcGF6ag3FVC/vsXdYYmItA7WdlVpuPTDA8sZNdvUd/pQfZxx
         1IiCk1kGrEiiMosIhKs5urfWkzXxL/0Yyw5YikKCutAuoZMYPsu+7V90ykeQpz82yj0l
         Z08pijInkWCMSubZ/DCqn3pQuxgGuXTZRdLSIYYTAybW8l6WocDp7sPx5lS9DgcVwbhp
         ASlI+QBBTWDCsbayZbt9rpXg3SrLRJwu/KVTBK9x2SS/pSdXaxO6TKcQyBdNgJKGEzWa
         L5F8M+hSu+Ej+av/nGNyt6t5paLdCYDwyh4tGPiK3BAtotWNQt/6Cxoev7fHUmwLS/NZ
         Qg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oUA/utiacTqBvENsm/1HDO7ZvtJjyIlan4u4jQRzI+Y=;
        b=abMsi7TQbGw2VotaJfYlhhcWOISyaNCxw72g2LY5lcUpZEp7KKXH7h2NW/s+E8nMEq
         EK0+QwAxpwBfhyHWs1v288kLkawkf9YABajfV0axGwa2QcuQmLDBg/Q2Rf0JhNJMaUBs
         b8vI2iv3MtVoTr63K4HF07HBUShCp4aJ5u5dkgRPA2V+PFH8DXELsrKgxTw9uHUQ0qdb
         ZDs2l4G8RuOrFqZ4ZpaKJSjiUcDxJZwvvNGtkeIwKmfs804wXbxk1yD48WC5SmyJzNzz
         wRlMyv3NAfsbQfx+3O+Ow+iEBONXrGg+wMtQdbov2chiJbUO9Out4l8Xi1Do9xJ02Sjv
         C/Lw==
X-Gm-Message-State: AJIora+l5UC37ARiTyX/IrUMHGPeWOK0WGS0d5VqQO7nXXr34GnUxQXE
        KI3wn8j+qTODUC614wo+sOKtEjOxXV0=
X-Google-Smtp-Source: AGRyM1sojo8Unue+P0zYugFWcQLBKlT7WSwwhHD+jclENo1oTZagS1PCoPKxrV8WRIugtgw6qfuEfg==
X-Received: by 2002:a05:6402:268c:b0:43a:7a08:bb67 with SMTP id w12-20020a056402268c00b0043a7a08bb67mr2419217edd.358.1657017027947;
        Tue, 05 Jul 2022 03:30:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm15375978ejj.112.2022.07.05.03.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 03:30:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o8fp3-003rxk-QH;
        Tue, 05 Jul 2022 12:30:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Li Linchao via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] remote-curl: send Accept-Language header to server
Date:   Tue, 05 Jul 2022 12:15:44 +0200
References: <pull.1251.git.1654678407365.gitgitgadget@gmail.com>
 <202207051804341356418@oschina.cn>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <202207051804341356418@oschina.cn>
Message-ID: <220705.86o7y3am2m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 05 2022, lilinchao@oschina.cn wrote:

>>"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:
>>
>>>>I think the end-goal of having the "remote: " messages translated, if
>>>>possible, is very worthwhile, but I'd always imagined we'd do that with
>>>>a protocol extension, because even if we do this with HTTP headers we
>>>>won't get the same over ssh/git transports.
>>>
>>> As for ssh transport, can we use ssh environment to reach our goal?
>>
>>Not really.=C2=A0 Before forcing us to invent completely separate
>>mechanisms for different transports, it is a very good idea to
>>consider if we can use a single mechanism that can apply to all
>>transports.=C2=A0 Adding something at the protocol level would be a
>>step in the right direction.
> I wonder if we can use a new protocol-capability like local-lang or=C2=A0
> something else, then Git client and server can tell each other's language
> ability in the=C2=A0negotiation stage.

It would make sense to call this protocol verb "setenv", and just give
it support for setting arbitrary remote environment, which we'd then
have a whitelist configuration variable for, similar to how sshd(1) does
it.

Or maybe we can just add this as a "capability", which seems like a more
natural fit, we could even stick it into "agent" I guess...

Then it becomes a very thin layer for emulating what we already get with
the ssh and http(s) transport(s).

Anyway, while it definitely would be an improvement to pass this along,
a much better way to go IMO (but also harder) is to extend the protocol
so that we don't a emita human language at all, but emit defined error
states for our various known errors.

I have some WIP incomplete patches in that direction somewhere (that I
haven't dug up now), and part of it is currently stalled on there being
no "push" support in protocol v2.

But if we can get to that point it would make for much better UX, even
if you get e.g. "git push" errors in your language now your editor/IDE
is probably needing to spew terminal "git push" output at you as-is, it
would make for better UX if it could just render it as it prefers to.

This would also mean you'd get translations even if the server doesn't
have the needed *.po files.

It *isn't* a full replacement, e.g. if you have a custom hook having the
locale is still useful, but for anything that's git native...

FWIW I think the WIP patches I'm referencing were only to upload-pack.c,
i.e. to make various parts where it calls die() send over ERR packet(s)
instead, and either pick that up magically on the client-side, or add a
new ERR_CODE packet or whatever (I can't remember...).
