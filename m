Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE431FD09
	for <e@80x24.org>; Mon, 29 May 2017 02:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750872AbdE2Cog (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 22:44:36 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33222 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdE2Cof (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 22:44:35 -0400
Received: by mail-pf0-f171.google.com with SMTP id e193so41377306pfh.0
        for <git@vger.kernel.org>; Sun, 28 May 2017 19:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PzwMST6wkjKVfdyD5X5gcIZ9ibbUH/yRX4019fr5jY4=;
        b=fPgbkYS+pzmF4qBzY3wsW0sVqSfleNvUuyWh9bm6mzxt58cgctstbNpGVK2gdZ1T3X
         zy8ETt0GZd8OyKlHLsu3qWRXK6Ok5Yh9VhESmpWelXk2rKKx+piiCqXpgK5bHa1EJdkz
         QGwx3P/j4cZgHqBhnEtM7QkWh96v+9/cdWihDylgi2JgWAli1dEuJuM8e3uapqFDY7q0
         yUgVx7idRYSrtHBxDOegI3bZF5PfQgorDaH1jBXttNNCY4BfRs1jXmW+FOhIcctkkAEY
         RQMJ/1gB/MDA0QW2MK+2zi87UtLg4e5frZO9LJqhUK8aJA53q8FS6YGaqps68ecRq1qB
         DL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PzwMST6wkjKVfdyD5X5gcIZ9ibbUH/yRX4019fr5jY4=;
        b=fJ9whLuBwANgnq1ARn/1mm9CTEFVNZCh2bN8jlj36r5hUkwLBfKYNX89fGdRJajYDo
         dr+FJWsgdasFDs5jFIoQ7l4l51TPsPSjFWcqGeT83BLSQQArHMYhuW7jWR9HguncHE8T
         /PN/YwOkCnwrrfUH8xxt6ELW9/sWjJEiFtGwCxq6Qq1aerApMcnLaef7Fp2ZicWy/1MT
         PKup9H1E3Ej9U+KWwXlOnHJC8d/M5rl+wi3gpFu4zxgYxkZSd3AZjMHrUdKvil3R3Byn
         L2VbQuBPh7flw5D57oNGhMBX9U77Tql8C/xTKyF6eSMLWnUZX4O+HiJ4pxN7A8hxSNcj
         ER4Q==
X-Gm-Message-State: AODbwcAeuYM1GZDY/gz4tAVPGtC91ZlnATbS48vqiUCySCzQ0UM3DvH4
        hKbvh0fh2uO3UA==
X-Received: by 10.84.231.135 with SMTP id g7mr43163840plk.110.1496025875035;
        Sun, 28 May 2017 19:44:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id y2sm13093490pfk.1.2017.05.28.19.44.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 19:44:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, John Shahid <jvshahid@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: git push recurse.submodules behavior changed in 2.13
References: <CAE5=+KX57KM+6n9NpePw9KYPXFy7UH-WRgSwaJDnvRofYFXm7Q@mail.gmail.com>
Date:   Mon, 29 May 2017 11:44:33 +0900
In-Reply-To: <CAE5=+KX57KM+6n9NpePw9KYPXFy7UH-WRgSwaJDnvRofYFXm7Q@mail.gmail.com>
        (John Shahid's message of "Sat, 27 May 2017 09:31:15 -0400")
Message-ID: <xmqqinkk8jqm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Shahid <jvshahid@gmail.com> writes:

> It looks like the git push recurse-submodules behavior has changed.
> Currently with 2.13 you cannot run "git push
> --recurse-submodules=on-demand" if the parent repo is on a different
> branch than the sub repos, e.g. parent repo is on "develop" and
> sub-repo on "master". I created a test that can be found here [1].
>
> A bisect shows that the change to propagate refspec [2] to the
> submodules is the culprit. imho this is an undesired change in
> behavior. I looked at the code but couldn't see an easy way to fix
> this issue without breaking the feature mentioned above. The only
> option I can think of is to control the refspec propagation behavior
> using a flag, e.g. "--propagate-refspecs" or add another
> recurse-submodules option, e.g. "--recurse-submodules=propagate"
>
> What do you all think ?
>
> [1] https://gist.github.com/jvshahid/b778702cc3d825c6887d2707e866a9c8
> [2] https://github.com/git/git/commit/06bf4ad1db92c32af38e16d9b7f928edbd647780

Brandon?  I cannot quite tell from the report what "has changed"
refers to, what failures "you cannot run" gets, and if that is a
desirable thing to do (i.e. if letting the user run it in such a
configuration would somehow break things, actively erroring out may
be a deliberate change) or not (i.e. an unintended regression).

