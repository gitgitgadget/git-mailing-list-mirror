Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CC0C4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 09:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73763611AC
	for <git@archiver.kernel.org>; Mon, 31 May 2021 09:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhEaKAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 06:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhEaJ7x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 05:59:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A6C061343
        for <git@vger.kernel.org>; Mon, 31 May 2021 02:57:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lz27so15784746ejb.11
        for <git@vger.kernel.org>; Mon, 31 May 2021 02:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PbxRd8ULhGtFNHWVZJahoMKrYNyWQ4eYuNWJSw7lasw=;
        b=h6gZiK8mBAkpQGxPbYGm7mjqACxNmNb5nSLuAyuuiu5SfQo1YtBWq69RE7rHOAoNt6
         1O312hxrZR1I2pIlc37SmY52Hx9G1tIITfIchQGgMYYRtzIe3OqXZS1KVcJvikiPRitw
         KvGcxxOfWv3uebYnsH40F4cuDWVUEaUBXeoDISwllVlq+nDuoJHlOTIYUBYzRAlJJcfw
         vziku/UxeluuOrszp6F3pNdJjikxLC+BMfpp1a4NnF030y5FVdTpzjskW7qpRmf9aAN/
         l25Fj2Wp2x35Z/Qg88DxoCoJi/vIvnvsIUZNdi6VPxZwnbA/ndsoo9VGNxfNzqr6UtAO
         0qFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PbxRd8ULhGtFNHWVZJahoMKrYNyWQ4eYuNWJSw7lasw=;
        b=inGkJ8zkdp3B0dZErrdHrK2rZYXuZmBHvs44JlPkNWnAbbpQbm+sc6fqV5DCkuIcHL
         9fFDB+iSE+Q3E3zkdRBjeimQAvpXZWmMIWQ/o7ebLv5bvfyXGR7O34vzlflBfZTmr8Ps
         Vm+3hmkReGvT1utwL7950gTbcCG7+P2xPEB5Xna5VrAMmUTxIiXPSzdLiwoulNityQv5
         1GXLlrcJxOsYWFws53imrmR8VdI78+/8ugim+EQ6me/6TZGQM3YkGbhW3Kd+oXOarKSn
         o5JpW3EzMrJihy4tG1+xQHrFmvKhKfWVyEzJwqrW3W7rS9u/hbkvoYV8FrGA44wZh6tC
         oCNw==
X-Gm-Message-State: AOAM533a0MjW1EtLy6jgELYA8+Bo4oWO+F4oxt6VWSXA6ab0Qtgh3c+N
        vI1D7MvxisrGOppiqmCcsWVZr8Vf5NU=
X-Google-Smtp-Source: ABdhPJyF0+mNPa7EYeovJviHbB6ZMOPbAY8L/wJTCPyZQ5elMH3tr5rbZ93+7hcjeIAUoeeWMkMgHw==
X-Received: by 2002:a17:907:2bd6:: with SMTP id gv22mr5121007ejc.431.1622455078068;
        Mon, 31 May 2021 02:57:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id rl12sm1757629ejb.94.2021.05.31.02.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 02:57:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 00/13] send-email: various optimizations to speed up
 by >2x
Date:   Mon, 31 May 2021 11:53:04 +0200
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
 <YLR4tMOvkR81+ACq@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YLR4tMOvkR81+ACq@coredump.intra.peff.net>
Message-ID: <874kej2pjw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 31 2021, Jeff King wrote:

> On Fri, May 28, 2021 at 11:23:39AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Hopefully the final iteration. Updates a commit message to explain why
>> I moved away from File::Spec::Functions, rebases on master, and
>> explains and deals with the "undef in config" issue Jeff King noted.
>
> Thanks. The solution was less invasive than I feared.
>
> I guess here:
>
>>     @@ git-send-email.perl: sub read_config {
>>      -			my @values =3D Git::config(@repo, $key);
>>      -			next unless @values;
>>      +			my @values =3D @{$known_keys->{$key}};
>>     ++			@values =3D grep { defined } @values;
>>       			next if $configured->{$setting}++;
>>       			@$target =3D @values;
>>       		}
>>       		else {
>>      -			my $v =3D Git::config(@repo, $key);
>>     --			next unless defined $v;
>>      +			my $v =3D $known_keys->{$key}->[0];
>>     + 			next unless defined $v;
>>       			next if $configured->{$setting}++;
>>       			$$target =3D $v;
>>     - 		}
>
> we'd ignore such undef values, whereas presumably before they'd have
> triggered an error via Git::config(). I don't think it matters all that
> much either way, though.

They didn't error before, they were treated the same as the empty
string.

This is because Git.pm uses "git config --get" to retrieve them, but we
now use "--list --null".

This ultimately comes down to a limitation of git-config's one-shot CLI
interface. You get the empty string and zero exit code for both of:

    git -c foo.bar=3D config --get foo.bar
    git -c foo.bar config --get foo.bar

Ignoring them here for list values is technically a behavior change if
we were treating this as a black box, but in reality we know that these
could only conceivable be useful for the bool values, for list values
like "list of e-mail addresses" it makes no sense to have that in a the
middle of a list, and we were implicitly ignoring them anyway before
when we processed the empty string.
