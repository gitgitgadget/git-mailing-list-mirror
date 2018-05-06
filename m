Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 245CA200B9
	for <e@80x24.org>; Sun,  6 May 2018 02:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeEFCxa (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 22:53:30 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:32916 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751833AbeEFCx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 22:53:29 -0400
Received: by mail-wm0-f52.google.com with SMTP id x12-v6so11483398wmc.0
        for <git@vger.kernel.org>; Sat, 05 May 2018 19:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Aj8RHVNcrvDxPjTEuZsrpcvj7lhkx+2JPmSdvM0clZo=;
        b=b2CHvEyBJCgG2q3cygcMs8LiagJWfy8sqIC2EPbQYjLleu/iSh4MWtLZpRofwqrLi6
         tl1PlD1nY06LgLi2lfD6sPV0vk8dORslZR0YirjMrEQtkhcQ9v82I8HyZJ9H7Nq0CinQ
         SsMALrjJJpQHUAnePQQ/QDT5QTzw3SgCWhtAcvT90KdCq4w4bTM5l0Km+UK7EzVmTiLu
         amzCnBaIf73XrDJsDhpHOdKOZ0IyaNjeQHfYZ5FHUvfT5HPadcV5zcauDtwXl+VWC54y
         bPVjIJUUuXvTb8qCKOLDIsrPLnO3kar45iHNLOsU3KBa6kfEnIyHwmuCBJ9yVxzCCjYY
         R+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Aj8RHVNcrvDxPjTEuZsrpcvj7lhkx+2JPmSdvM0clZo=;
        b=P+HXyvjYLJGhkLzOHVBiO7huC02vzArlpVUsJazi24uKtkzibAZAzqwsisA7RLI4sZ
         W2h5eN0WVJbr6QDOPF9B735mSnP4u5zk3WrbZhhF+Rx3q768ZtTR5l/w0PyKZS+x8y+s
         ZaWS0yOzyxQjUuA3ntTFsO8bAeCuuGsKXsly4wl+gQY/7SDOVvdBETXkiU0JVzlbdA7W
         g6uvqDVj2GgChq0biUXhtAF3Y7Wyw7napFawp8B7x1cX6+wblqB6WaYowEENg6vU9+0j
         K2QUnW7Qb2wF0hKUZBw6eqg13SNwgE/DViYbglgyVKTav25U57wvROtg1yBefXZFP4th
         HqBA==
X-Gm-Message-State: ALQs6tCO5Qe5bRhepMJbvLQ30Xc7OJ69Ke/IZH1wEuT89TxbTpfL4XNE
        xWq4JUuL19kscCpkv+8c+ws=
X-Google-Smtp-Source: AB8JxZobjKB6WtelQZ62aCvAUy8TnNNipp8+oqvPzz+9KdpPKf9EaO0dvtmzp5NmfbC9MWJWJSWLLg==
X-Received: by 10.28.26.83 with SMTP id a80mr21274150wma.36.1525575208067;
        Sat, 05 May 2018 19:53:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p7-v6sm19692490wrj.85.2018.05.05.19.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 May 2018 19:53:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ilya Kantor <iliakan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: cherry-pick --no-commit does not work well with --continue in case of conflicts
References: <CAFU8umjvEATZguGDmcRMcfAkqn4LW7vf_B9qpLD7uc-E_7qR9g@mail.gmail.com>
Date:   Sun, 06 May 2018 11:53:25 +0900
In-Reply-To: <CAFU8umjvEATZguGDmcRMcfAkqn4LW7vf_B9qpLD7uc-E_7qR9g@mail.gmail.com>
        (Ilya Kantor's message of "Sat, 5 May 2018 23:26:45 +0300")
Message-ID: <xmqqd0y9sdei.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ilya Kantor <iliakan@gmail.com> writes:

> Somewhy cherry-pick --no-commit does not work well with --continue.
>
> Let's say I'm copying changes w/o committing and get a conflict:
>
>> git cherry-pick -n master..feature
> error: could not apply 2c11f12... Run work
>
> Then I fix the conflict, but cherry-pick refuses to go on:
>
>> git add .
>> git cherry-pick --continue
> error: your local changes would be overwritten by cherry-pick.
> fatal: cherry-pick failed
>
> It could continue *if* I committed, but I'm --no-commit for a reason,
> so I shouldn't have to commit to go on with cherry-pick.

Of course you shouldn't have to, and cherry-pick --continue
shouldn't commit either.

Once you resolve the conflicts, there is no more things to do for
cherry-pick command, so --continue does not make any sense, I would
think, when using --no-commit.

For that matter, "cherry-pick --no-commit A..B", unless you are
absolutely sure A..B consists of only one commit (in which case you
should just be saying "cherry-pick --no-commit B" instead), makes no
sense, either.

So perhaps these are what we should be fixing?  I.e. reject
range-pick when --no-commit is given, and reject --continue when
working in --no-commit mode.
