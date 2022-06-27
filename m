Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D788C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbiF0Sec (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbiF0SeT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:34:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C0A1C11A
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:29:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ay16so20939754ejb.6
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=vd8qQKR5s4cTKIX6/jcv2GKlpnsSWitFMTYiEVlO/HU=;
        b=W+paz0tt3csXw6vkvAbqHtv/k34Mxlna2IFLOhdWqMgefmOJ9k/2T1Y2TwLOnBl9fB
         Keznln6RX+E9FoV9TdfD16VkkevchLmkW5JSdkOyIvVE4Z4vVesqZp4mf2NxcKPBw89B
         0kqfXm09yyc61Ggb3GNyBj+i4zZRL/mUuyjVjY/cDAc1WJZsCBv5RlKlHnp6YDT9rsTt
         GkykeMxuxyxN14ZMFin+icoRiu7dRFRaAKzIrkyPWW/jOW07L17Ny/T1F3AJN1Hi+7l1
         2GcRbh04XutSiqIwbYHt/R7cyJq1p89fP+LjRGjMmK643FGpZGx0dykk6BNAv2Ghck2g
         tjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=vd8qQKR5s4cTKIX6/jcv2GKlpnsSWitFMTYiEVlO/HU=;
        b=PrXsSaDxKSFpdKZgSPhjtNnjSehb+saahS6kvEdxvakbEaDm6qpCSPitHfh1E0saWG
         oA5PDvPtjRdYbXEFmBKsqLc57ADr/nrD/0gMw0EI/vSJqJCoFp6FVwm9QMgnNIe5dfYR
         +x6CyD7VjjGQQfJcZ1SoiOjl1qnJrbAEBUkaZAYTOuigoRDP/+U4DsvUz3u62DNsUPT8
         LvfSMDfTlGhmR/cV3lhcUA7DaOJeaYpAmNlEsG0OJdR5Z8lYHW/4kT6u9Lsp7iyB1jNw
         7QeXN2Q1VVmz7Rqqb7qRqJRpAT6MuCvvGXjBCoq63ZavN8UuffD4+x+8xZSaqzxst1rL
         595g==
X-Gm-Message-State: AJIora/pKaNJYrKETT4fsP8o0CbdapQnWAF5/fKCB3o6KazqjEQiTgvC
        lE30Z74LShJqrIfiw63GWAHiLI/0qvk=
X-Google-Smtp-Source: AGRyM1vPjdf6/bboy/VD9PJaGuJrEDv6Jyvr+YAvS6Vb7UYi6dlXUqtbPjVxZBdjB/otQdFWSb7ATA==
X-Received: by 2002:a17:906:6a20:b0:726:7675:e15a with SMTP id qw32-20020a1709066a2000b007267675e15amr11512648ejc.668.1656354576378;
        Mon, 27 Jun 2022 11:29:36 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709062cd300b006ff802baf5dsm5333274ejr.54.2022.06.27.11.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:29:35 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o5tUM-001bxm-P5;
        Mon, 27 Jun 2022 20:29:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: ab/test-without-templates
Date:   Mon, 27 Jun 2022 20:23:06 +0200
References: <xmqq7d584hqb.fsf@gitster.g>
 <220623.86sfnvk5rw.gmgdl@evledraar.gmail.com> <xmqqr13fxc5l.fsf@gitster.g>
 <220627.864k06i8im.gmgdl@evledraar.gmail.com> <xmqqbkueqe5z.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqbkueqe5z.fsf@gitster.g>
Message-ID: <220627.86zghygdtd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 27 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> You may disagree with some or all of those, but this series doesn't try
>> to get you to agree with any of them. It's just making our tests more
>> sturdy and explicit in their intent by clearly declaring which parts of
>> them are relying on our default templates.
>>
>> So it's helping us spot issues like the one fixed in 7f44842ac19
>> (sparse-checkout: create leading directory, 2022-01-21) earlier.
>
> It's like arguing "this series is a bugfix, so what it fixes are by
> definition bugs", isn't it?

No, I don't think the test code is buggy as it stands now, but relying
on our default templates is making it easy to introduce new bugs in code
that doesn't handle other templates than the default.

This series doesn't get us all the way to running without that template
for all tests, but I have follow-up patches that do that, after these
changes that's a mostly a small matter of flipping the default, these
were most of the changes required in the test logic.

>> I really don't disagree with you per-se about us defining some minimum
>> viable template,...
>
> Well then it becomes debatable if it is a "bug" not to handle
> missing .git/info that needs "fixing" by this series, and it also
> makes it debatable if 7f44842a (sparse-checkout: create leading
> directory, 2022-01-21) was also a "bugfix", or just tightening
> against environment the end-user broke, no?

I don't think it's a broken environment. If you e.g. move .git/objects
to .git/objects.new you can't expect your repository to work, but we've
never implied or documented that about e.g. .git/hooks, .git/info etc.

And indeed almost all parts of git create the required paths on demand
and/or handle missing paths gracefully.

I don't see why we should take some stance that we're going to be
unhelpfully pedantic about repositories we find on-disk, even if we had
never had a "--template" option for "git init" to create such
repositories. I think 7f44842a was the right thing to do.
