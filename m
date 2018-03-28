Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4CB81F404
	for <e@80x24.org>; Wed, 28 Mar 2018 19:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbeC1TIe (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 15:08:34 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:35992 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753555AbeC1TIX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 15:08:23 -0400
Received: by mail-yb0-f180.google.com with SMTP id o3-v6so1178780ybm.3
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cXo8Htj7YrDn3PamBPHxIKooJzNFNBOSBcJS2vJj/1c=;
        b=PzpZzBF8ztNFOnLWktOeSteoEPFvLqAmnASH0QsnrmO75jq2PYbt8+K1RiHJn4kWZE
         wWsKcgT3nZ5iZt4FxbujafOWDakCofe+0mUTjKdd159/9Nf1sWR8xG/zko/lE959FGn3
         41W+SVKqcl8V0mRMRSPCxzOo21gK02yXAmbJ2RfPYMUUgkckmr7yP2a2CaW6QYh3Qppq
         Ey9LK4Hz0uv3H8tcY0Umevndys2zUnzy5rzlix/DGp7gM6K7QuSnQYQsPTzjItV/70Hc
         LlC9jKo/mUn2apW+AbLlw6VoCJRcwCUm7pJ3odv2yLe1v3ffdQln/mdWe/lLlONvl4Im
         1exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cXo8Htj7YrDn3PamBPHxIKooJzNFNBOSBcJS2vJj/1c=;
        b=hP0UCRYzSqEjzXsq81eECqluWlj/aCQ3a/K9fXUL8jOupHB6dFDSdI6KuLLlO2zzmY
         hRanh1Y4/tsGH85xiKD37+U12wTYkzObLqXLuYqvmKsPmqs4/rU4oVAaTewDU/Pzpgwr
         crFWnXU+89BbwVv+nmTTSlOytnWIlOlm07uKl0tDeoGg0fRAuhMOKhVjZQT7rTEOsYP0
         OlXtms+K/KZ0BIQwmzLjViv9sy4jtvT30IgbhJWSAavKbxWuuAkTUDnaXHw5fTfutFMH
         LaeCbAykIx7K2+pXMIAyNsKx39FAv/eyhVcu/czpjknJ5PzrH/lnb7bnMyq358wIKIVf
         TqsQ==
X-Gm-Message-State: AElRT7Fco01VDB1j1lPLN+gk16KJ6NqB6k1cT3G5fcbgLJjGJVSDKQuL
        +qOhHp9te9etm6aR1ZskjS2E6/TXXW62HMZQ5nMq+w==
X-Google-Smtp-Source: AIpwx48jOUJ61H7o9/U/6E4ntTk0ZkgF8zV+xsmIkDnFfPzjNt2q/ComMI/Uv8QYc6VSP2YLJIhdg0sIRZgLHvOJ3cE=
X-Received: by 2002:a25:2782:: with SMTP id n124-v6mr3098173ybn.307.1522264102092;
 Wed, 28 Mar 2018 12:08:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 28 Mar 2018 12:08:21
 -0700 (PDT)
In-Reply-To: <20180328173543.GA159395@google.com>
References: <CAGZ79kaQYjepND8EdgB73meBsShOc5aBporiK2Bo40fqcar0gg@mail.gmail.com>
 <20180328172449.27012-1-sbeller@google.com> <20180328172449.27012-6-sbeller@google.com>
 <20180328173543.GA159395@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Mar 2018 12:08:21 -0700
Message-ID: <CAGZ79kb1z8Ro9XV72s0-8O_D68VbLWbA=KT2EPOvgfi+e2YWCg@mail.gmail.com>
Subject: Re: [PATCH 5/6] submodule: fixup nested submodules after moving the submodule
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Jonathan Tan <jonathantanmy@google.com>, seanwbehan@riseup.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> +     if (repo_init(&subrepo, sub_gitdir, sub_worktree))
>> +             return;
>
> Note that in Duy's object-store series he made this function private
> (IIRC) so this will result in some clash of the two series.
>

Yes, that is the case.
I wonder if I'd rather revert to v1 where we only use the
submodule repo init, or if we revert b2f0eceecf (repository:
initialize the_repository in main(), 2018-03-03) partially to
have repo_init available.

I would think the approach with submodule init is a bit cleaner
though has some more lines of code, using just repo_init
seems easier, but we really have no use case for a separate
repo_init unless they are submodules. And here we ought to
check for the repo being a submodule.

Not yet sure which path to take.
