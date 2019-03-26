Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB7F20248
	for <e@80x24.org>; Tue, 26 Mar 2019 06:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfCZGuc (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 02:50:32 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:39224 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZGuc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 02:50:32 -0400
Received: by mail-wr1-f49.google.com with SMTP id j9so12899997wrn.6
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 23:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=fcgQDOLiHuN6p+P5N62S8d3MVPeOJehRxPJUVsenIjY=;
        b=Hw8FOArMsm4zBT9Va32TQh41fKwVPOinlobESmjdfvHzUfhnpSii9Zv/zEHAteLyUN
         XLF4utsbfLHQ4ekIxG7cO0hdl/6txzb5Kb7kciJK+/mZpDtpmDg5AlInX+m1JPtHN2Hv
         rloAKXlaZ437JO5hVof0BPlNXxamtqpj2eSBYlLMCwuVKMi8leIj6RBJzXGPjWu5QwEh
         ivcOQFZ5CFJ+j5Fx0rm+HODP6YvPEy0jvOSSSPpDKtJR0ppx9q2qdlFrFveOBMHnk750
         hliBK6DnKq7GyWCctr2EsAgzPTJOSBCQKPZWfZ8JzqaPYHJYJ3s/sL6AbfNloJMbRu8/
         94aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=fcgQDOLiHuN6p+P5N62S8d3MVPeOJehRxPJUVsenIjY=;
        b=VNm2+whHO3a+cuyocRz7ieAtHyqaGajEjidqE74dA5gc6p7nWyW2ETtNgmKFAbMduq
         whNZnk/NhTgh6rktrbqsPPkvxhcbKh7iYPW2xGT6/xlku/Vvwfk8mhKhGzIIvDnuJWNd
         aWp2rGdoZNyvnDPV84oP/JB4ptedjHaJ61D81stRYWf6itAxBN3AIp+ldtRHkjskHZwG
         jZBHlFSLLwOoXvxOCYvJGBTSF4wfrmBjsNs532Uj7XItlXkzgiEKVTUh9patM3pf4tty
         KfKf2BXThCYc049q0vYe9Iobyx1OphQDnAGXKcLaKOlIPpzKR8XeXRmyYnQ/nxnhLZii
         79GQ==
X-Gm-Message-State: APjAAAXVOlPHTghH0uZI5XXO+/W+n+aFCoN0hQZMaFXJTSL6aF55YaKm
        yO01Z01Xqq3pQ47Y0y8PHie6oKhafQ8=
X-Google-Smtp-Source: APXvYqw5vvnS4/F8G4TF4JW0pUuLeZ/9/TnfhKiNWxdf9mU6VSj3v89DMiieyJfi2+qv2kTzKJ5OYg==
X-Received: by 2002:adf:ebc8:: with SMTP id v8mr18241428wrn.172.1553583030023;
        Mon, 25 Mar 2019 23:50:30 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id c8sm16118529wrx.6.2019.03.25.23.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 23:50:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Subject: Re: Auto-gc in the background can take a long time to be put in the background
References: <20190325232223.r72qtffyzn5qzoxc@glandium.org> <20190325233007.GA23728@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190325233007.GA23728@sigill.intra.peff.net>
Date:   Tue, 26 Mar 2019 07:50:28 +0100
Message-ID: <87k1gmb03v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 26 2019, Jeff King wrote:

> On Tue, Mar 26, 2019 at 08:22:23AM +0900, Mike Hommey wrote:
>
>> Recently, I've noticed that whenever the auto-gc message shows up about
>> being spawned in the background, it still takes a while for git to
>> return to the shell.
>>
>> I've finally looked at what it was stuck on, and it's
>> `git reflog expire --all` taking more than 30s. I guess the question is
>> whether there's a reason this shouldn't run in the background? Another
>> is whether there's something that makes this slower than it should be.
>
> The reason is that it takes locks which can interfere with other
> operations; see 62aad1849f (gc --auto: do not lock refs in the
> background, 2014-05-25).

Even assuming we can never improve this I think we should make this part
configurable. It's assuming that the contention is otherwise going to be
with yourself in the same terminal, but it doesn't help if the primary
source of contention is going to be e.g. other concurrent processes in
the same repo.

> Unfortunately making it faster is hard. To handle expiring unreachable
> items, it has to know what's reachable. Which implies walking the commit
> graph. I don't recall offhand whether setting unreachable-expiration to
> "never" would skip that part. But if not, that should be low-hanging
> fruit.

I have a recently patch that does this that I need to re-roll:
https://public-inbox.org/git/20190315155959.12390-8-avarab@gmail.com/

> (I also wonder whether there is really much valuable in keeping
> unreachable things for a shorter period of time, and the default should
> simply be to just prune everything after 90 days, unreachable or not).

Do you mean unify gc.reflogExpire & gc.pruneExpire (and other
variables). Would that be cheaper somehow?

Or just blindly remove loose objects that are older than some mtime,
assuming that if anyone cared they'd be in a pack already?

The latter of those would be very useful, but if not carefully handled
could lead to corruption.
