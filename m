Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A885DC433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 08:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKAIJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 04:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiKAIJM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 04:09:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBAD2BEF
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 01:09:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 21so20738679edv.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 01:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/BKLQG1DMYAhq86ijOIqa2v5wYLtdT5L/qV8bfQs9s=;
        b=Q7rPb94KT9F+KKCGk1lslO1UN6rmUPMoGlr6O46k1Hiw60XgT4F6h/f2Zh1Sp8dsLD
         syJuqxSNFFpHnFHaztLUkwVo3WYcTHQi6/N+38yDsnxR1MZAovL2TI7hUVPbXB8WT7zx
         tbCdOjo9zhnqqNtulhGHXgpbo+mMybGJ38/g1VDf5PJYKIgeQFl0xgJdC6wSWqUgs5CG
         DKaPiTHSjMH2XUTh1ThKE4ZEfHbYWi5dJrZURCdeQcbQOO3vEQn1k1xyUxsXckGXFuby
         kRbzIMlreOg4Bh/xTYimPF0zijRUADkQ6mWjao+vESkUXkAMAWH3qVKEpTnKxn4Icmwn
         /Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/BKLQG1DMYAhq86ijOIqa2v5wYLtdT5L/qV8bfQs9s=;
        b=wUfSxFmNaShKD25bZgmfScSU8Tk/mjihVE5iZSdiYB6nAppa5TCWE19k3vjSDckBpR
         Pkl60hqUAfsn6mq99Sem3q2HXCsRwPEwDwegAt1p0jyMH+H00l8E8bHv8ciqYgNKOgE/
         IAexbhGATdRl7qvwbt2l+xz6Dta3wmthUAXPSpjfgOZvN6W0dpObgTRs0GKfP/Kj4AuW
         mDk3n/vDO6SKVWBAWliw+A+s/PkmfIIC9gUPy6P1YpSvsArdCkVTxDTZJqkarR3D3gIN
         9C3dzcwfhhb0/QiZ+P6CwQRq/IsLsfaVFfZr8Ne655SX5kQSY3jtgHM2IDIrrrs6AGz8
         Azrg==
X-Gm-Message-State: ACrzQf2lWUjbKGEOLqHtpJc2odSbWV0FH/SmHQJ7D/K+Lj1ngKh+rVH0
        dWcWqsNkB1HzCkL8jOYpofg=
X-Google-Smtp-Source: AMsMyM7k1za4dw708BAhAeiphk6/AM4CYmlZz2kktYimrjxP/vUvLTXPxr/S7Zolu60XvT18FQKucQ==
X-Received: by 2002:aa7:c452:0:b0:463:14dd:2093 with SMTP id n18-20020aa7c452000000b0046314dd2093mr14647908edr.48.1667290148112;
        Tue, 01 Nov 2022 01:09:08 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t25-20020a056402021900b004585eba4baesm4158698edv.80.2022.11.01.01.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 01:09:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opmKZ-00B9ho-05;
        Tue, 01 Nov 2022 09:09:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, peff@peff.net,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Mention that password could be a personal access token.
Date:   Tue, 01 Nov 2022 08:58:36 +0100
References: <pull.1396.git.1666845947898.gitgitgadget@gmail.com>
 <xmqqk04lmagy.fsf@gitster.g>
 <CAGJzqs=PovTFeVFJAT1HLcKQxHdRjozUACh3Z-x8ih6yuYSb7w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAGJzqs=PovTFeVFJAT1HLcKQxHdRjozUACh3Z-x8ih6yuYSb7w@mail.gmail.com>
Message-ID: <221101.86wn8f3xlp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 01 2022, M Hickford wrote:

> On Thu, 27 Oct 2022 at 18:40, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Also, I wonder if the specific "it can be access token and not
>> password" is something worth adding.
>
> Personal access tokens are ubiquitous nowadays, maybe even more common
> than passwords since GitHub disabled passwords last year. I wanted
> to acknowledge this in the docs, even if Git's own behaviour hasn't
> changed. Maybe the introduction to
> https://git-scm.com/docs/gitcredentials would be a better place to do
> that?
>
>      Git will sometimes need credentials from the user in order to
> perform operations; for example, it may need to ask for a username and
> password in order to access a remote repository over HTTP. **The
> server may accept or expect a personal access token instead of a
> password.**
>
> [1] https://github.blog/changelog/2021-08-12-git-password-authentication-is-shutting-down/

A "personal access token" is just a password by another name. When you
enter such a token into your .git/config (or provide it via an auth
helper) we'll sent it over via HTTP Basic Auth, "which transmits
credentials as user-id/ password pairs, encoded using Base64"[2].

Even the blog post you linked to makes the distinction, by talking about
"account passwords". I.e. what's really going on here is that providers
have been moving to using N passwords instead of 1.

Now, I'm not just trying to be pedantic. I do think there's probably a
doc improvement to be made here. If popular providers are calling this a
"[personal] access token" perhaps we should mention it in passing.

But saying "this could also be" is the point at which this could create
its own confusion. This *is* a password. E.g. if you get such a "token"
and want to try it out with the "curl" utility (whose library we use for
http) it'll be e.g.:

	curl --user <user>:<password> <url>

Not:

	curl --user <user> --personal-access-token <token> <url>

Or whatever. I.e. the entire rest of the stack calls this a "password",
and that stack's a lot more likely to be what stays around in the long
term, rather than what amounts to a marketing term for a password.

1. https://www.rfc-editor.org/rfc/rfc7617
