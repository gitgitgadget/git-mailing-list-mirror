Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E3861F404
	for <e@80x24.org>; Fri, 23 Mar 2018 15:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeCWPOs (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 11:14:48 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:32972 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeCWPOq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 11:14:46 -0400
Received: by mail-vk0-f51.google.com with SMTP id j85so7497108vke.0
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wFnTSfW9JyUKruaUoeX2JNsvSQQMz7uOka41H+y6pWA=;
        b=YI4y7ASWmGzTeUtO99+U5jvt50hRXkb2A/aDnx6pmKUduJ5krUpQywovKDpJ0gJaym
         LOirDwJYPAGBrAaP9+TRJ8B0hqWGxoJJoE0ODAGClGxvTLlOJ30wfn964VL0ARPqgOL3
         ftZ4+KtsgWggzm07ic72+k8HFiERnbQZiDis5/TbtFYGG8+6F2Y6msSv73POlBtx5/T6
         wAF7onhURi76O1pMA5nuHNyl3Ca9kaYD426GjcMx0dCGXdluL9bz4fXfh+V5vGX/QyUp
         NWYZCz3ANYO9Fhx3dSEY1aHpKiiQ1uxAcCLMtcH3jFfAEnPGY+TsRZZU6KwavWoUUylM
         47TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wFnTSfW9JyUKruaUoeX2JNsvSQQMz7uOka41H+y6pWA=;
        b=FwJffhBGauwgi2BbPoVseVjWRPUw0kNUecWal7bJlU1e+YKEkNsoe6jfHAy4fduu1F
         boVbp6nvdD/wkWgyPlBfRbbm5sjbIY7S+0NyiW/l0T1ZHk60sANgTvsKbwHLgbgQZ/qZ
         bpt7/38B9/vmefeLhSztnM68fpZ2ByjoXvshfD+YjvGFfNDiKJ576KXMKOctUL5y4jqZ
         CXDGDPed7x9t5IM+7TfYV+8ehqC0dY4eV8Dd6+RcjVrPDdOMgeN/oioj2mdDVkyP1Pkd
         6aPh9X6Spot9rN3eYtPUT8RG/EOO9GIumEMnV95+L2UOF8ksDIl59gbAgOFsRefi87QJ
         c4DA==
X-Gm-Message-State: AElRT7HG1iheXJz70SADVxXHLfQCeOzpoAUp7kzexJiK3iIoiaFGMXab
        1zf753UDZEJmUNsHLGlqzacj4QUB7+s3Q/s9FsE=
X-Google-Smtp-Source: AG47ELvZr0pl+tFdwV/gLse9ajz+LGXXo7atP6WmV8BNIhBe1HhTpg0jYiARaCoJGvuuAbmhDAU8P8vSVoz8NA6o4aQ=
X-Received: by 10.31.107.15 with SMTP id g15mr18633947vkc.2.1521818085579;
 Fri, 23 Mar 2018 08:14:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Fri, 23 Mar 2018 08:14:45 -0700 (PDT)
In-Reply-To: <20180322141604.15957-1-szeder.dev@gmail.com>
References: <20180322141604.15957-1-szeder.dev@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 23 Mar 2018 16:14:45 +0100
Message-ID: <CAM0VKjm3WKkxjEN09Dv1wUnuBf8CSsUvmLjmSVb1fbHTyAdXEQ@mail.gmail.com>
Subject: Re: [PATCH] completion: clear cached --options when sourcing the
 completion script
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 3:16 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:

> Add tests to ensure that these variables are indeed cleared when the
> completion script is sourced; not just the variables caching options,
> but all other caching variables, i.e. the variables caching commands,
> porcelain commands and merge strategies as well.

> +test_expect_success 'sourcing the completion script clears cached merge =
strategies' '
> +       __git_compute_merge_strategies &&
> +       verbose test -n "$__git_merge_strategies" &&
> +       . "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> +       verbose test -z "$__git_merge_strategies"
> +'

Hang on, this test fails in the GETTEXT_POISON build.

The thing is, we get the merge strategies with this piece of code in
__git_list_merge_strategies() in master:

    LANG=3DC LC_ALL=3DC git merge -s help 2>&1 |
    sed -n -e '/[Aa]vailable strategies are: /,/^$/{
        # a couple of s/// commands
    }'


and that '/[Aa]vailable strategies are: /' won't match in a
GETTEXT_POISON-ed output, because that string is translated.

I think for now (-rc phase) we should just drop this test, and in the
future we should consider adding a 'git merge --list-strategies' option.
