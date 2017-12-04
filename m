Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7958920C11
	for <e@80x24.org>; Mon,  4 Dec 2017 04:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbdLDE3R (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 23:29:17 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39338 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbdLDE3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 23:29:16 -0500
Received: by mail-ua0-f195.google.com with SMTP id i20so9525266uak.6
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 20:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MEr23SpuwjRYsNmfTzkScIUv88X1NOQKDbITLvnB/ac=;
        b=SIc/qga9vI6GZT3xpKafr7FOI18EN7gHwM5hsX3vvFA94Bmj1HoWzkhluiMGZ1qIbG
         lU+yfnrNIhXQYZi2YFHZso/DjqrO2J2xhg5s0c4H0lKWTkZNmuwzQjA5Pc/ZJzX5KFVD
         Xl1wFAZZibcgyHrauyHikuxN69nwset49Ze+ykiPrswNPXjuZumNaZpcKCPUCYKn5Z7b
         VfZ6mA27G9tNEX8XmraYbDeRhXQTPypcwyDllQR6be9KPJCPjopP+zXtgBwFOAQRMOWS
         FJFZLXnSP4McpfHnpftUH1W8ME8KC/JunhlX1KdaZDBK+V7Y3a8H6x4+6Xdc7fBljkvm
         t1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MEr23SpuwjRYsNmfTzkScIUv88X1NOQKDbITLvnB/ac=;
        b=KQ3GmI3nM0en+h+747ESJ+CyeG4T4yRexyTKrwuVdAoMjEw9oc/SQtE858+7WQ66uH
         kqwrGvSICX4x81NBfNhhXrydNIArw9PudUjAzruhR2sGvsfIIAQzPoeUveHp/1dnkB42
         9HgPTIKs3GDH+tQRxOs0xMavpUtj/nezHGGml+YkrQPo+7WNj0uMNvEQwFvkBD2fPvbO
         u2F3V5zhKIeOgRsWc2i6VyaQVdMTXUewInKY6wuNXoH/PiVFQqzUr4+8XAfCtAmD3VT/
         mIgJfhk+obKds2wNLdYUto4XCl/eToJeI891dzQd0dTYMLMPjIvFJJwAboffEeoZW7gd
         7f0g==
X-Gm-Message-State: AKGB3mLFmP2CYjRrtc5lWb/bqpgzTiqnkmyvA82fTjQApBa1idQHvBIh
        OHTJiyemZV4c82PcdrzZglBFGsKoDYPA96y7zBI=
X-Google-Smtp-Source: AGs4zMYjSxh5/fhdnyh812Py9ydykAzhnjGPzgbRZkGfd9lXZOrR2jm/WT1LQuTeYds68ORVkzryGOA6ZXWReZRLock=
X-Received: by 10.176.75.111 with SMTP id i47mr10792687uaf.100.1512361755661;
 Sun, 03 Dec 2017 20:29:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.73.240 with HTTP; Sun, 3 Dec 2017 20:29:15 -0800 (PST)
In-Reply-To: <20171201055933.19368-1-kaartic.sivaraam@gmail.com>
References: <20171129034620.4719-1-kaartic.sivaraam@gmail.com> <20171201055933.19368-1-kaartic.sivaraam@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 4 Dec 2017 05:29:15 +0100
Message-ID: <CAM0VKjmy8J5VnROyv_O=iVdwn2yELUjPv=XNu6JzJ+OePWbh4w@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] builtin/branch: strip refs/heads/ using skip_prefix
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 1, 2017 at 6:59 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> Sorry, missed a ';' in v4.
>
> The surprising thing I discovered in the TravisCI build for v4
> was that apart from the 'Documentation' build the 'Static Analysis'
> build passed, with the following output,
>
> -- <snip>
> $ ci/run-static-analysis.sh
> GIT_VERSION =3D 2.13.1.1972.g6ced3f745
>      SPATCH contrib/coccinelle/array.cocci
>      SPATCH result: contrib/coccinelle/array.cocci.patch
>      SPATCH contrib/coccinelle/free.cocci
>      SPATCH contrib/coccinelle/object_id.cocci
>      SPATCH contrib/coccinelle/qsort.cocci
>      SPATCH contrib/coccinelle/strbuf.cocci
>      SPATCH result: contrib/coccinelle/strbuf.cocci.patch
>      SPATCH contrib/coccinelle/swap.cocci
>      SPATCH contrib/coccinelle/xstrdup_or_null.cocci
>
> The command "ci/run-static-analysis.sh" exited with 0.

Perhaps Coccinelle should have errored out, or perhaps its 0 exit code
means "I didn't find any code matching any of the semantic patches that
required transformation".

> I guess static analysis tools make an assumption that the source
> code is syntactically valid for them to work correctly. So, I guess
> we should at least make sure the code 'compiles' before running
> the static analysis tool even though we don't build it completely.
> I'm not sure if it's a bad thing to run the static analysis on code
> that isn't syntactically valid, though.

Travis CI already runs 6 build jobs compiling Git.  And that is in
addition to the one that you should have run yourself before even
thinking about submitting v4 ;)  That's plenty to catch errors like
these.  And if any of those builds fail because Git can't be built or
because of a test failure, then Coccinelle's success doesn't matter at
all, because the commit is toast anyway.


G=C3=A1bor
