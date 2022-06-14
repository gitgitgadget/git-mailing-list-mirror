Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4A9CCA47F
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 16:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbiFNQqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 12:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244064AbiFNQqN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 12:46:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CD028737
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 09:46:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fu3so18298521ejc.7
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3AevMgyQ7C0AgiFsXw8V777AlsVtILeLSX2Z5sFqi2E=;
        b=U6s0iIxK/edwNF2RdNQPOzk2b16EFixtzMq4akNEXBVJkOYg/BHKRudzT6c/p9Z9bD
         UG5uSFieAcpd6/3bsaJlQvWN317Ddw9Hbh/2nAbdPPnytTCWZppzOG/UDVVRkEGIz1lI
         wrCTezcGQFf3xWQdjmBos+MdHo8ZoTTKmgJMCZHPsuRvl8lIS//QSbSuhMpp1WGT1osx
         WJh6tJXOKOigAQ3NKATZGNmdP/mfiC8Gx07WCz6sSbThentjtTDcnfecrXW273hmhIyL
         oI6R3rkP0Cz4TjZM5R9u/uMa83WmTLLfMllio7P6Ev7inrG51Zxv672+drvPAGMS7meK
         ZVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3AevMgyQ7C0AgiFsXw8V777AlsVtILeLSX2Z5sFqi2E=;
        b=qBotMDot5cj2savV84sIuUWYr/pmUnW3vPJ/tdFRrdy+WPaZBLc56OL+EoY6hTw1cp
         5UcWnL4ZNcyl7J4VwG1ag8bChGNPm3FlLCjiymilCbkdFuu9qmgXLvFmmcHBv1EheJTi
         NSVpXw6TebYKTt+lWQm++MT4yy9ehys+dwxVBf+42kzuUzEblQGJqKUd3EdPl3pMVotr
         2o6tDwAYmtjVXP2ZOKpaVHlk2gRflqvEtDVTeyrBW3uc2zUpbkl7GOWgDUY+fHrSjpLv
         owJJV5CaMB6aQwo13g8tubWOTNYZA+Om6j2nBK40Gj/4Ud7viqDb8fI9y2loC7sJOuEV
         xB3Q==
X-Gm-Message-State: AOAM532Up0fwcEfOvWDBy3zH/aL8ZScrd4WYmezMivY2sszt+aOWHw2o
        61/ft2OGUMFwEpJ3/8PrBmyHeZsj+FhMEg==
X-Google-Smtp-Source: AGRyM1s6ISph8rZvWE4UGv5VCqqqHeGvPFTmV0yoSZiHKuG8FaJL80Py9zZMX/VpEJQ+uDcpBpmpzA==
X-Received: by 2002:a17:906:ce:b0:715:705e:52fb with SMTP id 14-20020a17090600ce00b00715705e52fbmr5036995eji.303.1655225170777;
        Tue, 14 Jun 2022 09:46:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id my51-20020a1709065a7300b007109b15c109sm5276443ejc.66.2022.06.14.09.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 09:46:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o19g9-000ZFI-FH;
        Tue, 14 Jun 2022 18:46:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        me@ttaylorr.com, Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/5] branch: fix branch_checked_out() leaks
Date:   Tue, 14 Jun 2022 18:43:57 +0200
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
 <6cd7db33-6ab5-9843-4483-4cce9835b177@github.com>
 <220614.868rq0ytaa.gmgdl@evledraar.gmail.com>
 <0d00d910-a7aa-dfd8-a24c-51968800c2a8@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <0d00d910-a7aa-dfd8-a24c-51968800c2a8@github.com>
Message-ID: <220614.86v8t3xkfi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 14 2022, Derrick Stolee wrote:

> On 6/13/2022 8:33 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Jun 13 2022, Derrick Stolee wrote:
>>=20
>>> On 6/8/2022 4:08 PM, Derrick Stolee via GitGitGadget wrote:
>
>>> While TEST_PASSES_SANITIZE_LEAK would be helpful to demonstrate the
>>> leakage and prevent it in the future, t2407 uses helpers such as 'git
>>> clone' that cause the test to fail under that mode.
>>=20
>> If you apply this:
>>=20=09
>> 	diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
>> 	index 0760595337b..d41171acb83 100755
>> 	--- a/t/t2407-worktree-heads.sh
>> 	+++ b/t/t2407-worktree-heads.sh
>> 	@@ -10,16 +10,8 @@ test_expect_success 'setup' '
>> 	 		test_commit $i &&
>> 	 		git branch wt-$i &&
>> 	 		git worktree add wt-$i wt-$i || return 1
>> 	-	done &&
>> 	-
>> 	-	# Create a server that updates each branch by one commit
>> 	-	git clone . server &&
>> 	-	git remote add server ./server &&
>> 	-	for i in 1 2 3 4
>> 	-	do
>> 	-		git -C server checkout wt-$i &&
>> 	-		test_commit -C server A-$i || return 1
>> 	 	done
>> 	+
>> 	 '
>>=20=09=20
>> 	 test_expect_success 'refuse to overwrite: checked out in worktree' '
>>=20
>> And compile with SANITIZE=3Dleak then this will pass as:
>>=20
>> 	./t2407-worktree-heads.sh  --run=3D1,6
>
> Of course this works for the tests that don't need the 'server' repo,
> but it fails in the tests that _do_ need it.
>
> I'm able to make this work by creating the 'server' with init and
> creating the wt-$i branches from scratch (they don't need to be
> fast-forward updates).
>
> The linux-leaks tests still fail due to 'git fetch' and 'git bisect'
> calls, but these can be avoided by carefully splitting the tests and
> using the !SANITIZE_LEAK prereq.

I mean copy/paste the existing file to a new one with this on top, then
remove all tests that aren't your new one. That worked for me, doesn't
it work for you?

>> Normally I'd just say "let's leave it for later", but in this case the
>> entire point of the commit and the relatively lengthy test is to deal
>> with a memory leak, so just copy/pasting the few lines of setup you
>> actually need to a new test & testing with SANITIZE=3Dleak seems worth t=
he
>> effort in this case.
>
> Well, the point isn't to use automation to check for leaks, but instead
> to fix leaks and add tests for the case where we previously had leaks.
> The tests demonstrate that we aren't accidentally introducing a use-after-
> free or double-free.

I mean that the patch subject is "fix[...]leaks", and this gives it a
CI'd regression test, which seems worth it.

Of course it's also nice to check for use-after-fre etc., but we have
other coverage for that. E.g. glibc in CI spots double-free issues with
how we set it up, and we tend to segfault soon enough (or someone runs
SANITIZE=3Daddress) on use-after-free.
