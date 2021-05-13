Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72718C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 11:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C8E61176
	for <git@archiver.kernel.org>; Thu, 13 May 2021 11:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhEMLuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 07:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhEMLuM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 07:50:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D823C061760
        for <git@vger.kernel.org>; Thu, 13 May 2021 04:49:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s20so33933926ejr.9
        for <git@vger.kernel.org>; Thu, 13 May 2021 04:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6IPO5h/unduLmgLcbI1kskpuxLCvIr2YAtjZBY7IwN4=;
        b=mtnjos4VLdanoGjex9Nu56sqKxCV9GW7os8QnZG1A5wQL09sP3DK9wNaSSN0Pyd4go
         ttT+SxIezUxs6LDMGb+EvBVMicKnVJMsnZB6L33D4htjtGfCIpnRfAiLFvWhBvseX9+0
         5kjr672rrtndcnUM5VJXqegwW1Gv6XkQjxbFoSd9Dm2Hxcv375cY9ovN/iDPRmowxbJN
         4EvG70GeiNxoxthyhnjigbIdT1gOoqbLOYBIyyQLFU7gqWoDcFyJdV05NBocsgzovq5v
         UoYMyv8rxLwohaiTMj7v96Uwa5tnvJxltlVduegzxw2jYmF23JPDvJ4qjq39zdjrdKsl
         OGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6IPO5h/unduLmgLcbI1kskpuxLCvIr2YAtjZBY7IwN4=;
        b=ZVwWF1FigQn2m0FmaHDRj8URFf6oJ5b+AFz5HRsMvAHr23ODT9MChwtmDKBBdzA6MI
         EL0d8alD9hhTwbXXICDcg+ufj+cay0hKsQM8pXWkm7jRkQ5B50/LZpQr4Xtne4evqH4h
         g25V/uUqospm7Rxnq00Q10tqgjZ4l5rgzN3Nf+Dx98r/OQuqQRK0h7Kc5IiTJhS4P1ew
         b3pHJ+fNnjNHUnDO7kBlGJ3L9xXATWh+ame5Iqqrzm7Bd/+einVkIuxdMMttUn3GT1BA
         Y7DPYGSufMvfE9JADNyJ3d6wnrCEZsH3inq5VvbGqiFTeh16adRKh9YOx4VuM50xI56m
         6SZQ==
X-Gm-Message-State: AOAM533y0pJRBG6jkBJdTcC14YDxTgojQX4e4s1SZ1Bahnq9yonfOKy+
        uuJRK8GKaQBjYrYIDJmTptFbJ/iV1OjmNg==
X-Google-Smtp-Source: ABdhPJz8DIvfBfpHfZC3vJvboTrs5k9bDH1Fwf5H2EEQB1PNwLGOToX6hosenqggRcxMyk2bJGHw6Q==
X-Received: by 2002:a17:906:355a:: with SMTP id s26mr41778305eja.528.1620906541660;
        Thu, 13 May 2021 04:49:01 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q18sm2196632edd.3.2021.05.13.04.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 04:49:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBv?= =?utf-8?B?w6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 9/9] send-email: move trivial config handling to Perl
Date:   Thu, 13 May 2021 13:45:06 +0200
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <patch-9.9-0d87c9a5a3-20210512T132955Z-avarab@gmail.com>
 <YJxgC/PJ/JIcIOfq@coredump.intra.peff.net>
 <609ccf688a4e7_329320879@natae.notmuch>
 <YJzUvZjzSYuKcsTr@coredump.intra.peff.net>
 <609ce01c4d5df_5a82087a@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <609ce01c4d5df_5a82087a@natae.notmuch>
Message-ID: <87h7j6svkj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 13 2021, Felipe Contreras wrote:

> Jeff King wrote:
>> On Thu, May 13, 2021 at 02:04:08AM -0500, Felipe Contreras wrote:
>> 
>> > Jeff King wrote:
>> > > It is a bit unfortunate to have to go through these contortions, but
>> > > this is definitely the best we can do for now. I think in the long run
>> > > it would be nice to have a "--stdin" mode for git-config, where we could
>> > > do something like:
>> > > 
>> > >   git config --stdin <<\EOF
>> > >   key=foo.bar
>> > >   type=bool
>> > >   default=false
>> > > 
>> > >   key=another.key
>> > >   type=color
>> > >   default=red
>> > >   EOF
>> > 
>> > Why do we even have to specify the type? Shouldn't there be a registry
>> > of configurations (a schema), so that all users don't have to do this?
>> 
>> One of the purposes of git-config is to serve third-party scripts that
>> store their own config keys that Git does not know about. So we can't
>> know the set of all possible types that will be asked about.
>
> Yes, I know, I maintain several tools that have such configurations. For
> those you would need to specify the type (or find some way to install
> the schema so that git parses it).
>
> But I'm talking about git.git configurations. If you don't specify the
> type in --stdin it should fetch it from some database. That would be
> much more user-friendly.

For what it's worth my idea of hacking a plumbing thingy for
git-send-email here before ultimately deciding that my simpler caching
approach was easier and gave me 95% of the win, was to just teach it a
mode where it spews out all config variables \0-delimited with all
possible interpretations of it. I.e.:

    some.variable	123	bool	true	path	123	string	123	[...]

It's rather cheap to do the "interpret this as --type=X for me" on the
C-level, so we might as well spew out all possible interpretations.

That means that any external tool would be guaranteed to only need one
"git config" invocation to parse any of its config, i.e. in a case where
variable X decides if variable Y is a bool or path or whatever. They'd
already have all possible values.

Something like:

	git config -l -z --type=bool,path
	git config -l -z --type=ALL

