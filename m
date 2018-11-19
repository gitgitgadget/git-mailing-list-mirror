Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00AD81F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 18:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeKTEtg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 23:49:36 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51678 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbeKTEtf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 23:49:35 -0500
Received: by mail-it1-f193.google.com with SMTP id x19so9777345itl.1
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 10:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a/K2s0PPDMorfcCUorteJGRujOKVPtwYU9ITgvyGC2Q=;
        b=jF2WeZ2FnU4LXTfI1Mtugur4O0LZp7qEim0/llobQuUghW9Ips6sA+EtTXxOKqdz0B
         PLGg4gbGSnr5lrxbttPu0OK93buTqyUxsGjs4dQVTJnj2BhZYcpGREbzpOMjL52LOvIE
         gw0wtXPBTrFop/ZbhoihBcOJAUvJ3ZSjOQAQbU3pQv5ANZInimthtM8uRUEZv1BJzssQ
         sVulSh4D0oIfsLb+/D2OTJmbA3eLKrniL/fRuGUJeOS3g9F4kL569ZpvTAfH+o0voChy
         i5vZh5dxDMxz7DTLT+PM7yysG/E09f8soN67GJGwOwroRtIgcyZI65mfetSmz6MFh6Oo
         LlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a/K2s0PPDMorfcCUorteJGRujOKVPtwYU9ITgvyGC2Q=;
        b=DiRqORRpcFYKuHpuuZgDw/diEBr2VtzB+dxFdsbVi1HvtcPYQgN4FIZRcDOn6Vugn6
         70OVUEctxWig/iFJA9iHfLMAVnx6sbU3BZ444E6wozJ/gKV4dltDvXttXyvsO0luauwq
         5TgCacIrVj6MiD9xb9vzYpArWa8UF/mRyjcITkVmbvQ6Yp7o6Nop70mEYQTGgq8RshDc
         XpOoxzdhuHiwCwwDrx+tyOfncY1Wf7snL4PTDiwhQpYlaYJ7+WCmr7cEIQn3NYbKiU6Q
         DQSOEaLDORo7fPSbdcrTR/dSJS6RgOIU+RxEtSkaUIvoxhu6wgwZHLwMNghK9bQB+u8m
         nGXg==
X-Gm-Message-State: AGRZ1gKGGYqKh5AiuIrvoSJOm/z98xFeHjIz2pXJqpfS93tMOpVHI6Jg
        E/KjYQMGbbgJLviEfTiQRhoRT7ujM5ASZa7zsi8=
X-Google-Smtp-Source: AJdET5f3scyfB7O2+d5+P2NFXoAlV6MIyyreYbgEo2Vo7DnPlePVcLrkNJR5vvZRQF3TlpGulxJmUdg3Q9TTVm3qpb0=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr19840503jak.30.1542651892438;
 Mon, 19 Nov 2018 10:24:52 -0800 (PST)
MIME-Version: 1.0
References: <20180817161645.28249-1-pclouds@gmail.com> <20181119082015.77553-1-carenas@gmail.com>
 <37b7a395-3846-6664-9c4d-66d2e4277618@web.de> <CAPUEsphrYOV64m08JY_tsVuJ-uwTv=o=m5LdCFOWd+8tWJP54A@mail.gmail.com>
In-Reply-To: <CAPUEsphrYOV64m08JY_tsVuJ-uwTv=o=m5LdCFOWd+8tWJP54A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Nov 2018 19:24:26 +0100
Message-ID: <CACsJy8A_c-O5DrZnMvEbsSa+YzatiLH3TLAy3OV1+AwY5rrCjQ@mail.gmail.com>
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive filesystems
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 6:14 PM Carlo Arenas <carenas@gmail.com> wrote:
>
> On Mon, Nov 19, 2018 at 4:28 AM Torsten B=C3=B6gershausen <tboegi@web.de>=
 wrote:
> >
> > Did you test it on Mac ?
>
> macOS 10.14.1 but only using APFS, did you test my patch with HFS+?
>
> > So what exactly are you trying to fix ?
>
> I get
>
> not ok 99 - colliding file detection
> #
> # grep X icasefs/warning &&
> # grep x icasefs/warning &&
> # test_i18ngrep "the following paths have collided" icasefs/warning
> #
>
> and the output of "warning" only shows one of the conflicting files,
> instead of both:
>
> Cloning into 'bogus'...
> done.
> warning: the following paths have collided (e.g. case-sensitive paths
> on a case-insensitive filesystem) and only one from the same
> colliding group is in the working tree:
>
>   'x'
>
> Carlo

Could you send me the "index" file in  t/trash\
directory.t5601-clone/icasefs/bogus/.git/index ? Also the output of
"stat /path/to/icase/bogus/x"

My only explanation is somehow the inode value we save is not the same
one on disk, which is weird and could even cause other problems. I'd
like to know why this happens before trying to fix anything.
--=20
Duy
