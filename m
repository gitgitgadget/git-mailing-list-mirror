Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0EBC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 17:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350165AbiFJRjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 13:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350086AbiFJRjR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 13:39:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA11244A16
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 10:39:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id me5so54268404ejb.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8IhF8ShnCnqwvCr6I9RG1w9rB4j1Y0E6iU1gudC+yOU=;
        b=W1xQEH9zISvY3+cv0uvEofuC6uj6EfumO1EdHqfs2/QyuOVteiI3SCSE8+VAk/CSf7
         tENy/3K7qHrD3OKgjkR7Khg61KMEcmDet8iBvQns7UUEQ9QpevBe0zzhl+k4kHKV+eUL
         PiiPMo0oPVAPm+LbjPEwep3YU0/d86ol5GXdiJMOSx5koRaqa0nFkWtdkv7G4feZ406E
         Dr/I/P7wxRK0xWrY5xUjTvvRzoN6ZvqgGTY8JLDTX+QtGwyG1vbzsADkrFC33XmSFlgy
         LqbL7wZ7LsHO7S+QWldD5AatAEI6D/2ggGNaCb4TLa2MwY4hwh+b8Mf5EcfbUQeYxBIS
         w0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8IhF8ShnCnqwvCr6I9RG1w9rB4j1Y0E6iU1gudC+yOU=;
        b=iCHO2L+6OATFVWvEm719WI+R+gFtOhEFTQTVLegwvGIiV+q+FdAJGUA3dparwbqk8L
         /6Qu2qF3E8q0bnhwlxOHyXnZ7bkCOMeSizABUHL5x4En5KR1geM9rjYh7piXNC2/uQGX
         CgoA9PTo2udoajpMj2GM6PU8d8RLnRknOk86zDILLUBGru9ijAV2+Ho99C0mRhNKbCy4
         Z99vA5EFatas0v5HY2RgBJK1DowGbJurWShO+QIbo98ks5qRasPpe1crPS74GNVqLhpI
         xuxarFMQGoDaR+o6TZAQiD1sZ67VSfck8KpRhD5ALV3ggbU8hytRFAhyBU8XavC8dkXD
         RvuA==
X-Gm-Message-State: AOAM53190zqztPF6qGdj7HSUN1294hE2W527miLtHUDcLA13yJQp32Wv
        C2esXrd5zmpzKFigKUkCMWSeyG9PLyX68A==
X-Google-Smtp-Source: ABdhPJwv5Z00fp8ycOtvBN/AMEjG0wTQCfvf9IwP5f/QaWd3SlCeKdp3d09x4u/jJk34KdgRuhEBVg==
X-Received: by 2002:a17:906:7217:b0:6fe:9448:6142 with SMTP id m23-20020a170906721700b006fe94486142mr29002090ejk.241.1654882755222;
        Fri, 10 Jun 2022 10:39:15 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ky15-20020a170907778f00b007121b22b376sm1779294ejc.105.2022.06.10.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 10:39:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nzibK-003bVZ-9S;
        Fri, 10 Jun 2022 19:39:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6+ 4/7] scalar: implement `scalar diagnose`
Date:   Fri, 10 Jun 2022 19:35:58 +0200
References: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
 <20220528231118.3504387-1-gitster@pobox.com>
 <20220528231118.3504387-5-gitster@pobox.com>
 <220610.86ilp9s1x7.gmgdl@evledraar.gmail.com> <xmqqpmjgfoxm.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqpmjgfoxm.fsf@gitster.g>
Message-ID: <220610.86a6aks9j1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 10 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sat, May 28 2022, Junio C Hamano wrote:
>>
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> [...]
>>> The `diagnose` command is the culmination of this hard-won knowledge: it
>>> gathers the installed hooks, the config, a couple statistics describing
>>> the data shape, among other pieces of information, and then wraps
>>> everything up in a tidy, neat `.zip` archive.
>>> [...]
>>> +	if ((res =3D add_directory_to_archiver(&archiver_args, ".git", 0)) ||
>>> +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/hooks", =
0)) ||
>>> +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/info", 0=
)) ||
>>> +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/logs", 1=
)) ||
>>> +	    (res =3D add_directory_to_archiver(&archiver_args, ".git/objects/=
info", 0)))
>>> +		goto diagnose_cleanup;
>>
>> Noticed on top of some local changes I have to not add a
>> .git/hooks (the --no-template topic), but this fails to diagnose
>> any repo that doesn't have these paths, which are optional, either
>> because a user could have manually removed them, or used
>> --template=3D.
>
> Quite honestly, if it lacks any directory that we traditionally
> created upon "git init", with our standard templates, we can and
> should call such a repository "broken" and move on.

In our own test suite we do e.g. (and did more of that until some recent
changes of mine):

    git mv .git/hooks .git/hooks.disabled

We've never documented in "git init" or the like that these very
optional directories in .git/ were some sort of hard requirenment, and
e.g. core.hooksPath and gitrepository-layout(5) explicitly seem to
suggest otherwise.

In any case, there's the golden rule about being strict in what you emit
and loose in what you accept, which we've taken with repository
compatibility. Having a tool that's designed to aid bugreporting be
picky about what sort of repository it supports seems to go against the
point of such a tool.

Particularly in this case, where it seems easy to just guard it with a
stat() check, or not error out if we fail to add this to the *.zip file,
no?
