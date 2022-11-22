Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB54C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 14:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiKVOlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKVOlS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 09:41:18 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B162B1AD
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:41:17 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id m22so36207898eji.10
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=no1G19WeH1txx9swh4jGx0yIq+NzkzFZFtzBNXxMhko=;
        b=L/UG9UcpMPo6MAZWJ41WW57NLTrIPiPzU+elubPilGPXd/75Na4XpjZWgu4KNQ6zZW
         lR9eEwBRhPeOXmUu2JP468/gK58N94xW/uk9zL40HuVaB0QCIaiWhzIZZ4TdkaGOKdRA
         Qon+S4stP/fHa3Zh2Est/nIRlOiBJH6FAYAq8cZiLS3yrOg/R/5WoFh6C8RvR5J9iGrs
         hbMX1TkpqCakQ+nZ5kgOJGZs42LvzHNC9/L4YC7SYrmOI6IgaSpukAB8vnOtdWW05eJN
         WMIVt6A82Uq8bZ6XoacnxEIecvNDvruMn3Kcn5GsY8gGxIPfKD52nljl0xBTPlNu/h1+
         jfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=no1G19WeH1txx9swh4jGx0yIq+NzkzFZFtzBNXxMhko=;
        b=wf2IF1vGRtzFGT5oS6+Kxxx55BL5CPDMvXtQBInseQhd8A1/5wNZm3DwIB4b10qf8b
         6oPhov+oSqK+V+PLVUK4rVEsVIW9fyW4kez2Te4kSK6HgY26Z9ujr7cJJLH/ruv9rvCm
         9aeJvpj5SEP6U06/D0LRuVOZrmFuWogQvbW9R7qtHWfvpSoY8uJVOQuA7dezXZMut/fE
         y5WbxgT5VpKtUut++Ry6tHq70So/N5Y9ZyeWCHMNgdEwVaYDLKKSq4p071UJRlvW527V
         mgkoThbCzqPQa6D5n1Lxmb9dwYjqbN6dwT6CgeT1vP3fV18I6dxO+HkZXpgsvTXTgMB1
         OSNg==
X-Gm-Message-State: ANoB5pljDIdN9Y8zNR+4USqxcvECPU1On4aHRbX+aY2kqJ0IcS0G9wVI
        AGvC17x7deQ6lI5pi+1BGQRV95lZRrk=
X-Google-Smtp-Source: AA0mqf6r930bZ7G6goyP9HRyvsYIfaQrij5D5KI0eIRkKDbpAU6OGbyUfKaho5YmGRKT0RvvKRa+SQ==
X-Received: by 2002:a17:906:590e:b0:78d:5176:c4d2 with SMTP id h14-20020a170906590e00b0078d5176c4d2mr19751115ejq.532.1669128076054;
        Tue, 22 Nov 2022 06:41:16 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q23-20020a170906361700b007adbd01c566sm6175385ejb.146.2022.11.22.06.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:41:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oxUSZ-000cJx-0E;
        Tue, 22 Nov 2022 15:41:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>,
        Git List <git@vger.kernel.org>
Subject: Re: git can not be built for s390x since update to git-2.38.0
Date:   Tue, 22 Nov 2022 15:35:29 +0100
References: <4657a19c-89c3-2237-9e6b-db897a492072@opensuse.org>
 <CAPig+cT92EokWeVA_Ou1P6kkaq90wneRrgPqnKLbkHnc=U56Vg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPig+cT92EokWeVA_Ou1P6kkaq90wneRrgPqnKLbkHnc=U56Vg@mail.gmail.com>
Message-ID: <221122.86zgcj9hmc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 21 2022, Eric Sunshine wrote:

> [cc:+git; taking this back to the mailing list so others can weigh in]
>
> On Wed, Nov 9, 2022 at 1:38 AM Sarah Julia Kriesch
> <sarah.kriesch@opensuse.org> wrote:
>>  > Gesendet: Sonntag, 06. November 2022 um 21:42 Uhr
>>  > Von: "Eric Sunshine" <sunshine@sunshineco.com>
>>  >
>>  > On Sun, Nov 6, 2022 at 2:18 PM Sarah Julia Kriesch
>>  > <sarah.kriesch@opensuse.org> wrote:
>>  > > We have also identified this week, that chainlint.pl --stats says "0
>>  > > tests". That can explain the empty output.
>>  > >
>>  > > ~/rpmbuild/BUILD/git-2.38.1/t> /usr/bin/perl chainlint.pl --stats
>>  > > --emit-all chainlinttmp/tests
>>  > > total: 0 workers, 0 scripts, 0 tests, 0 errors, 0.01s/0.01s (wall/user)
>>  >
>>  > Was `--stats` added for debugging this issue, or is that somehow part
>>  > of your build process?
>>  >
>> Yes. We tried to debug that manually. Therefore, we have added the --stats.
>>
>>  > What is the content of the "chainlinttmp/tests" file? Is it empty?
>>  >
>> It is empty.
>>
>>  > It is quite curious that it reports 0 scripts. It should report 1
>>  > script even if chainlinttmp/file is empty. This might point a finger
>>  > at File::Glob::bsd_glob() returning an empty list for some reason, or
>>  > the problem could be a failure with Perl "ithreads".
>
> Do you happen to know if Perl is built with "ithreads" on your
> platform, and if so, is "ithread" support working?
>
> The empty "chainlinttmp/tests" file also sounds suspicious. If you
> haven't already done so, I would recommend following the advice in [1]
> and running each command individually which Makefile would have run;
> this might allow you to isolate the problematic command or shell
> construct if such exists.
>
> [1]: https://lore.kernel.org/git/CAPig+cS184iKk6icG6ML=X+6Ng=fJyfic8izFyp1hT40cChm4g@mail.gmail.com/

I can also reproduce this on gcc202. It's the same issue with ending up
with an empty "tests" file.
	
	avar@gcc202:/run/user/1632/git/t$ uname -a
	Linux gcc202 6.0.0-4-sparc64-smp #1 SMP Debian 6.0.8-1 (2022-11-11) sparc64 GNU/Linux
	avar@gcc202:/run/user/1632/git/t$ lsb_release -a
	No LSB modules are available.
	Distributor ID: Debian
	Description:    Debian GNU/Linux bookworm/sid
	Release:        n/a
	Codename:       bookworm

The change at the tip of
https://lore.kernel.org/git/221122.86cz9fbyln.gmgdl@evledraar.gmail.com/
fixes it for me, i.e. getting rid of the perl threads stuff...

That box is built with "useithreads=define", so it's not that it doesn't
support threading in general.

