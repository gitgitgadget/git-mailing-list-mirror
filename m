Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579C71F424
	for <e@80x24.org>; Wed, 25 Apr 2018 00:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751037AbeDYAwq (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 20:52:46 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:51556 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeDYAwp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 20:52:45 -0400
Received: by mail-wm0-f52.google.com with SMTP id j4so4267505wme.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 17:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MStKX07AXqYHqRrQnwCIczfxy7qLCHMDaYjLMNh9VvY=;
        b=W6CRNGELTuWNZRYGpqqN1T1spLdQ2qAePtw8gxmOzj4I6UUh4g1KkWVr7bFrSXIYmG
         OzrPh3QHH5omkFUtXBXiID+nUOwTZMyklDeY0riwVmIFL380aiPAOUnUSFtoevmZknt1
         Ze1gvQisvFglctxH/a1yum9vZU+assKBbc6KUgnPVjLBugUhsZG0AAaH7noGSnNyo6Jb
         uYsEggl24aQ/cHXon8larF48ppvtuEQBvQ03UVCrmbR0cyUIJ+RbvYqX7idxdSP7yFBy
         8znuo5VEobiWdtEysJfLZcuNfJ3u03o5+glmjN+zrYQXe2KzozzIOcxLrruAOlAeLNW0
         KAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MStKX07AXqYHqRrQnwCIczfxy7qLCHMDaYjLMNh9VvY=;
        b=E+q3hE0W62a6hnUOKtth6YmztbDKv/Q9jmi8Yzeqi2DxMBqAkGiaCf7i9cXwbl/Gq0
         1AYyly+AQ1dSAu77OZYHrgi1LF2EyJ0Ug6w9ItdVO5A5tRDVtYLwpuQxJWhrjyWRlSIa
         dppDv6GehhDdDS9gs50jMhn+VJ+xf/h+NE1Q42gTf7/MDA/wN2CEQ+3cw77aqdJjSPnT
         zgOzocxZRox73Ixpkp6oS5TkX5oVlJaRwEWJM2tMOHkiiSXzF+iKuH4M9LX/g+Lx784+
         Jl2np3/b2bg/ItN96XWyKc/1xvzfnTsDlvz420jt8iH5TABQ/BEV5XGKJLMvw1WuNeiJ
         feoA==
X-Gm-Message-State: ALQs6tAyC5qNSOVWRIqmdonBMTJDErSETffHPJ7Kwpj3g6u7E5qodmaO
        Y+t4omI8Yl6oQpkuhaXGNCo=
X-Google-Smtp-Source: AIpwx4+AsmWSYP11DznWJJP6mKZ3CVpzIDMOfN5ojAc7ju++Uz6/9bhLIiBkuSXMVVIRSvghvgF1bw==
X-Received: by 10.28.193.13 with SMTP id r13mr13006105wmf.38.1524617563805;
        Tue, 24 Apr 2018 17:52:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k28-v6sm33112140wrk.96.2018.04.24.17.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 17:52:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Fetching tags overwrites existing tags
References: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
Date:   Wed, 25 Apr 2018 09:52:42 +0900
In-Reply-To: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
        (Wink Saville's message of "Tue, 24 Apr 2018 12:57:16 -0700")
Message-ID: <xmqqzi1s3y5h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> Ideally I would have liked the tags fetched from gbenchmark to have a prefix
> of gbenchmark/, like the branches have, maybe something like:
>
> $ git fetch --tags gbenchmark
> ...
>  * [new branch]      v2              -> gbenchmark/v2
>  * [new tag]         v0.0.9          -> gbenchmark/v0.0.9
>  * [new tag]         v0.1.0          -> gbenchmark/v0.1.0
>  * [new tag]         v1.0.0          -> gbenchmark/v1.0.0
>  * [new tag]         v1.1.0          -> gbenchmark/v1.1.0
>  * [new tag]         v1.2.0          -> gbenchmark/v1.2.0
>  * [new tag]         v1.3.0          -> gbenchmark/v1.3.0
>  * [new tag]         v1.4.0          -> gbenchmark/v1.4.0

The tag namespace (refs/tags/) is considered a shared resource (I am
not saying that that is the only valid world model---I am merely
explaining why things are like they are), hence the auto-following
tags will bring them to refs/tags/ (and I do not think there is no
way to configure auto-following to place them elsewhere).

But you could configure things yourself.

    $ git init victim && cd victim
    $ git remote add origin ../git.git
    $ git config --add remote.origin.fetch \
      "+refs/tags/*:refs/remote-tags/origin/*"
    $ tail -n 4 .git/config
    [remote "origin"]
	url = ../git.git/
	fetch = +refs/heads/*:refs/remotes/origin/*
	fetch = +refs/tags/*:refs/remote-tags/origin/*
    $ git fetch --no-tags

The "--no-tags" option serves to decline the auto-following tags to
refs/tags/ hierarchy; once your repository is configured this way,
your initial and subsequent "git fetch" will copy refs it finds in
refs/tags/ hierarchy over there to your refs/remote-tags/origin/
hierarchy locally.
