Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E644820A17
	for <e@80x24.org>; Thu, 19 Jan 2017 12:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbdASMJ7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 07:09:59 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36522 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdASMJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 07:09:58 -0500
Received: by mail-it0-f68.google.com with SMTP id o138so4749798ito.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 04:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yrKyjUDCV0/3ztmUKAc28Fqj4gmQueA6GBHzqhQbkTA=;
        b=h/U3cdFrx6PsaOECQ1vH6S+dcGqdOPXlZyNpqNQv583GCncsjO6w+GzcVe/98A6kMp
         F58nDBQ7oA9kShJjuyZ5zoHkN4GJwP3S/aoayCu94R3l5ONUxS1WFYQ3EOc9oDWNSdoo
         oalk10Erq9ZpJKBJXW8IIAXNVITvqlQlGPVp+nfeGdOsLTE10npw8b6rji5Kowdc9e9M
         n0uMcxAym6+4wvciNIStIbryMN5e4rXNL+hGaQ1XngpZZ7xoA4BtaBBtXiqYRHb/8crJ
         X0CoEBxFfCxYJpazo0dJ4Tf6eNhdXtv/ov4AENo8uAFpP+DEeI7zelEBeKhDjW25pTDS
         8pMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yrKyjUDCV0/3ztmUKAc28Fqj4gmQueA6GBHzqhQbkTA=;
        b=GajiqAZZah/9sFvMDW7PnVD9HVAekzyNMbdbn7VIYnhh+koPPXSiqSU+QOyKNz1SLp
         OY+zPmpoeF3bQuBeIbCtL/ZIHro+IX39UOobnT0RS8IEACekp8pvtCmrT4kx1ho3VF7P
         Ht1fNPaJ40axqCLOxUFfazqNoLa1hxyUOy9KDsFBT4lOIhgLuFIqd2D9FTjzCFDijvZs
         Ib/DW9EJV4TQv8xHu84yArl8qFbIQxQaN76y+Ok87kg6YK8s4Iqa4qEotxo9X5470h9A
         lAoDWbNiTgR4rO1di96H9aGodDVkB9eUIxR0SCR07s0+kePsF5Z7CWYvs0CDVd1QjtS5
         xbUQ==
X-Gm-Message-State: AIkVDXJaV+/8lHRPoD4MqY/1uKMQotcDWbJnbbywqSi+LC1i7pl2R13SQR2ggyT+keQ9sr1cTd1ytf4byqOVxA==
X-Received: by 10.36.122.208 with SMTP id a199mr7911514itc.74.1484827797845;
 Thu, 19 Jan 2017 04:09:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 19 Jan 2017 04:09:27 -0800 (PST)
In-Reply-To: <CAGZ79ka+zkr83tSkg_kJWoN1u3fgu1O3u1-7USEoSM1tj-53vA@mail.gmail.com>
References: <20170110112524.12870-1-pclouds@gmail.com> <CAGZ79ka+zkr83tSkg_kJWoN1u3fgu1O3u1-7USEoSM1tj-53vA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 19 Jan 2017 19:09:27 +0700
Message-ID: <CACsJy8BHgc8o+SydeiVnqaZRCbkJEWVzqDZM4sgey04ZLtG3tQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Per-worktree config file support
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Max Kirillov <max@max630.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2017 at 12:01 AM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jan 10, 2017 at 3:25 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> Let's get this rolling again. To refresh your memory because it's half
>> a year since v4 [1], this is about letting each worktree in multi
>> worktree setup has their own config settings. The most prominent ones
>> are core.worktree, used by submodules, and core.sparseCheckout.
>
> Thanks for getting this rolling again.
>
>>
>> This time I'm not touching submodules at all. I'm leaving it in the
>> good hands of "submodule people". All I'm providing is mechanism. How
>> you use it is up to you. So the series benefits sparse checkout users
>> only.
>
> As one of the "submodule people", I have no complaints here.
>
>>
>> Not much has changed from v4, except that the migration to new config
>> layout is done automatically _update_ a config variable with "git
>> config --worktree".
>>
>> I think this one is more or less ready. I have an RFC follow-up patch
>> about core.bare, but that could be handled separately.
>
> I have read through the series and think the design is sound for worktree=
s
> (though I have little knowledge about them).

Submodules and multi worktrees start to look very similar, the more I
think about it. Well, except that multi worktree does not separate odb
and config files, maybe. And we have already seen both have a need to
share code (like the moving .git dir operation). I suspect I'll learn
more about submodules along the way, and you worktrees ;-)

> Now even further:
>
> So to build on top of this series, I'd like to make submodules usable
> with worktrees (i.e. shared object store, only clone/fetch once and
> all worktrees
> benefit from it), the big question is how to get the underlying data
> model right.
>
> Would a submodule go into the superprojects
>
>     .git/worktrees/<worktree-name>/modules/<submodule-name>/
>
> or rather
>
>     .git/modules<submodule-name>/worktrees/<worktree-name>
>
> Or both (one of them being a gitlink file pointing at the other?)
>
> I have not made up my mind, as I haven't laid out all cases that are
> relevant here.

I would go with a conservative step first, keep submodules
per-worktree. After it's sorted out. You can change the layout (e.g.
as a config extension). The latter probably has some complication (but
yeah sharing would be a big plus).
--=20
Duy
