Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9564F20281
	for <e@80x24.org>; Tue, 23 May 2017 17:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966381AbdEWRvI (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 13:51:08 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34595 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761086AbdEWRvG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 13:51:06 -0400
Received: by mail-pf0-f180.google.com with SMTP id 9so121492105pfj.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KC5P9Xf15fwOYc3h1ePWaZ/RrDMlJQhVYQ0NCthpFHE=;
        b=gp6FVDJAJ8Wc0Dz9MmjqVtCwfnHZL8HXI6AVbPMqbxKS5Q/ZP7jH5COvnVo2tt/2r4
         w9UGOzs7SJ68VaH7XlwFIONL85SImoWHLPBtGCzBg9eMgxwiTo7K/+9z21bPVJv4LuYa
         PZefzapF9vXvprt6DiC4I+c8SXR9f5XqXiYihcoe4ulxN3uGjWUEKA4RavFTQATcqAjX
         y02i3ET6aE6TnDSDt3FdQW9mj7QtTxG4MYZr7isDjlsJwqKs9I2okTxHZgMH6rC0Yy4g
         31gwZTRZ5LCMT7tsf2KXJvhjTE4GlUSEaHJrZNRmUzLEb+ltsynfDk5VATFr3TronDAL
         HVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KC5P9Xf15fwOYc3h1ePWaZ/RrDMlJQhVYQ0NCthpFHE=;
        b=DAUdOWGd1NirPUQBcupF8erOH/wJg6JRObqJn8gvdCKY5/53NCMdg9DKNNaGEKyjG9
         SLWCWCuAryq5FdN3c2Qwo+YsXnp3vm5s9mXOdVhWrJOCvGqXxJ79TsK3eHfq/2shPLxO
         QZ8IWSowQFwCgAAK6VCD1ZmaicVMeHBhYugvLpmJ5ZS01khyMtC2rnExoMPGyc4d0LV9
         wVRCDlc82joMiob/SW04jn2vWbCKxO34Ux3uuU3Myg81jRRNYD0BO5sQK6Y6clz64OwB
         oG/SWG/F8dJ5shOD1wAwR4cZ9mFx1KZmqtzEJlYEn2y+C+hcdeAndn5ud4Afc4XqEEI2
         Kvdw==
X-Gm-Message-State: AODbwcD04PiiA4FLP0ZmHcTgWXp3pqxHQhDO0WGSPPuFWb10DvnV33PM
        8IyZEHuoMrN3BV+n/k8QRZuziWlel8EwraiKkg==
X-Received: by 10.84.248.73 with SMTP id e9mr38074892pln.76.1495561865721;
 Tue, 23 May 2017 10:51:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Tue, 23 May 2017 10:51:05 -0700 (PDT)
In-Reply-To: <CACBZZX5EQhoEBvj2e6ogXU5Y=EfwSPCx+jFvTJ1P2KbYNpADyw@mail.gmail.com>
References: <CACBZZX41yrAtBvkVeL9Q=2_TxcwrDXh55gu3qLN54P_go318OA@mail.gmail.com>
 <alpine.DEB.2.21.1.1705231103220.3610@virtualbox> <CACBZZX5EQhoEBvj2e6ogXU5Y=EfwSPCx+jFvTJ1P2KbYNpADyw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 May 2017 10:51:05 -0700
Message-ID: <CAGZ79kYEASh1cehJ-5=HtevYvpFm6H-aWB+P3VEbXm_o=Go_MQ@mail.gmail.com>
Subject: Re: BUG: The .gitignore rules can't be made to cross submodule boundaries
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 2:55 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, May 23, 2017 at 11:17 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi =C3=86var,
>>
>> On Mon, 22 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>> When I was adding the sha1collisiondetection submodule to git.git I
>>> noticed that building git would dirty the submodule.
>>>
>>> This is because our own Makefile adds .depend/ directories. I hacked
>>> around it by just getting the upstream project accept carrying an ignor=
e
>>> rule for that around:
>>> https://github.com/cr-marcstevens/sha1collisiondetection/commit/e8397b2=
6
>>>
>>> A workaround for this is to have the Makefile add such a rule to
>>> .git/modules/sha1collisiondetection/info/exclude, but that's less
>>> convenient than being able to distribute it as a normal .gitignore rule=
.
>>>
>>> The submodule.<name>.ignore config provides an overly big hammer to
>>> solve this, it would be better if we had something like
>>> submodule.<name>.gitignore=3D<path>. Then we could have e.g.
>>> .gitignore.sha1collisiondetection which would be added to whatever rule=
s
>>> the repo's own .gitignore provides.
>>
>> While I have nothing but the utmost respect for Stefan and Brandon for
>> trying to improve submodules, maybe it would be a wiser idea to imitate
>> the same strategy with sha1dc as we use with git-gui and gitk, i.e.
>> perform a subtree merge instead of adding it as a submodule. It's not li=
ke
>> 570kB will kill us.

Actually that is a very valid bug report outside that series for the
behavior of submodules.

In a world where you use a submodule to track say a third party
library, the current behavior of .gitignore applying to each repo makes
sense.

When it is no third party, but a first party lib, then it is sensible to ex=
pect
that the building/testing infrastructure works across the whole repo set,
and the user wants just one central place to specify things, such as
ignoring certain files or applying .gitattributes.

This topic came up in various forms on the mailing list, most often for
config that ought to be applied across all repos[1].

That said I have no good idea yet how to fix this issue without introducing
the ultimate user confusion.

The conditional include of config files (by Duy as part of 2.13) seems like
an interesting approach, which we could build on top of.
We currently have a main config and a per-working-tree config, so I would
expect we'd introduce another config file that is included by all submodule=
s
by default. It could be located in the superproject at ".git/config.super".
This config file could then specify

[submodule]
    recursiveIgnore =3D [yes/no]
    recursiveAttributes =3D [yes/no]

In that way commands run from within the submodule as well as from
the superproject would realize that the submodule needs to lookup
the superproject and use the attribute/ignore/config settings from there.

[1] Here the example for URL.insteadOf
https://public-inbox.org/git/CAPZ477MCsBsfbqKzp69MT_brwz-0aes6twJofQrhizUBV=
7ZoeA@mail.gmail.com/

>
> The submodule/.gitignore bug/feature-request being reported here isn't
> something that impacts the ab/sha1dc series in practice.
>
> It was something I noticed while working with an earlier commit in
> that repo, but that's a commit that'll never be pinned by the
> git.git:sha1collisiondetection submodule.

Thanks for the bug report. As outlined above, we'd still need to bikeshed
how to fix it properly I'd think.

Thanks,
Stefan
