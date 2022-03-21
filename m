Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06028C433FE
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 13:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348420AbiCUOAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349042AbiCUN6t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 09:58:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC95174B9F
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 06:57:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h13so17951461ede.5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=H2zNazEJwFBd4MRTW/FNr/0GjgOaXydpukDhqhvhA/U=;
        b=Tyz4SxRvE7J+6fcxIa5BxA0exr6KmP6PW/kCpj1ynDXnEkkpxzM5fsaDviX2E+zY+g
         MYawzunPTVjSR8ul1VlDufu9ecPXUleBE8iIudY0BhC4EG3jGyMJCiz/jxniKlZcEeZP
         vIUTRaDLtYpaahElFkC0dwHnTPxGZM+v3XQydIDn4Nc7y43//XSkRGp+A0BGEB3Bx5l/
         wMxEzE5GTbzSPRhjG4v8QKpSO05msaLwDYdxB00QcI50/AiDuy6/Nv8PC0hhxC7/5eLD
         0QnlVK8RCxdhRIPWfiOluDYw2jC3Mvcf89YJEWjwhnqD9794+6xibssoRIppTYrjHGRt
         R/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=H2zNazEJwFBd4MRTW/FNr/0GjgOaXydpukDhqhvhA/U=;
        b=MNhw/grpj8kmkHlFRlkLNNcd4xJpl5Ca9LM+r9xGgVeyDTCecLJT+Me5JatP/Ohjeq
         vQ+li826yt5WZ74NN/PfqDhbsz8V4i+j326rS3PH+cT0Fk9RdSosWbKc9zmanAVqNfOO
         iPSaC3tXPWnNoSkH9dbJntk9ORiSZYIC5y7zEumfnnN5dR0arDBCNdBQYz5+YqPzLzAx
         bXMsMrm7t/NS8OxkHWbkQ7w2L4twYmfhizjmZQ08Mf/4KDYK/u9sXY6mcCYEdE66DMb6
         Ow6aeeKLDxdA6GVwinh1+xvqN1Ut5RLGYiS2kZPnm4PHMlgnM2CJJQNV3cKfEvjzBgf3
         FQEw==
X-Gm-Message-State: AOAM532i4VrFW3OKDxYDXKOOftwc7Pitx/pKAi08pkoWzBUN698qmIwy
        dFmZ7MXy7k0tS8XlanPuxh0=
X-Google-Smtp-Source: ABdhPJwBXUnmcwC1B2/eWpM2m8yBzJtfcaA5A9oV/YlOi2TG0WYvlWsXJ5hhEfUU3lNmspHuizdd+Q==
X-Received: by 2002:a05:6402:4391:b0:419:2f2d:a1da with SMTP id o17-20020a056402439100b004192f2da1damr7864052edc.298.1647871027015;
        Mon, 21 Mar 2022 06:57:07 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dt6-20020a170907728600b006dff778258csm1982123ejc.32.2022.03.21.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:57:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWIWv-000WgI-Sa;
        Mon, 21 Mar 2022 14:57:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] t3200: fix antipatterns in existing branch tests
Date:   Mon, 21 Mar 2022 14:47:19 +0100
References: <pull.1182.git.1647845516517.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <pull.1182.git.1647845516517.gitgitgadget@gmail.com>
Message-ID: <220321.86mthj9zny.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 21 2022, Tao Klerks via GitGitGadget wrote:

> +fetch_if_remote_ref_missing () {
> +	# this is an anti-pattern: swallows segfault
> +	#git show-ref -q "refs/remotes/$2/$1" || git fetch "$2"
> +	# this is slightly slower, up to 1s out of 6s on this set of tests:
> +	git fetch "$2"
> +	# this doesn't work
> +	#test_might_fail git show-ref -q "refs/remotes/$2/$1" || git fetch "$2"
> +}

Moving the context around a bit, as this refers to this code above:

>     I'm submitting this as RFC because I have a couple of significant
>     doubts:
>=20=20=20=20=20
>      1. Does it make sense to do this? I believe it's a good idea to keep
>         things "clean" so that newcomers more easily do the right thing t=
han
>         the wrong thing, but on the other hand, I've definitely read that=
 we
>         have a "don't change things unnecessarily" bias somewhere.
>      2. What's the right pattern for the "(git show-ref -q
>         refs/remotes/local/main || git fetch local)" fetch-avoidance
>         optimization? Removing it adds a second to test runtimes, but =C3=
=86var
>         warned it hides segfaults

So first, 6s? Is this on Windows? I tried running this v.s. master:
=20=20=20=20
    $ git hyperfine -L rev origin/master,HEAD~,HEAD -s 'make' '(cd t && ./t=
3200-branch.sh)'
    Benchmark 1: (cd t && ./t3200-branch.sh)' in 'origin/master
      Time (mean =C2=B1 =CF=83):      1.887 s =C2=B1  0.095 s    [User: 1.5=
34 s, System: 0.514 s]
      Range (min =E2=80=A6 max):    1.826 s =E2=80=A6  2.117 s    10 runs
=20=20=20=20
    Benchmark 2: (cd t && ./t3200-branch.sh)' in 'HEAD~
      Time (mean =C2=B1 =CF=83):      2.132 s =C2=B1  0.013 s    [User: 1.7=
42 s, System: 0.561 s]
      Range (min =E2=80=A6 max):    2.120 s =E2=80=A6  2.166 s    10 runs
=20=20=20=20
    Benchmark 3: (cd t && ./t3200-branch.sh)' in 'HEAD
      Time (mean =C2=B1 =CF=83):      1.944 s =C2=B1  0.005 s    [User: 1.6=
20 s, System: 0.495 s]
      Range (min =E2=80=A6 max):    1.938 s =E2=80=A6  1.953 s    10 runs
=20=20=20=20
    Summary
      '(cd t && ./t3200-branch.sh)' in 'origin/master' ran
        1.03 =C2=B1 0.05 times faster than '(cd t && ./t3200-branch.sh)' in=
 'HEAD'
        1.13 =C2=B1 0.06 times faster than '(cd t && ./t3200-branch.sh)' in=
 'HEAD~'

The HEAD~ there is your patch here, and HEAD is my fix-up. I.e.:
=09
	diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
	index 9bd621ed97e..7f7b3b28581 100755
	--- a/t/t3200-branch.sh
	+++ b/t/t3200-branch.sh
	@@ -17,12 +17,14 @@ test_set_remote () {
	 }
=09=20
	 fetch_if_remote_ref_missing () {
	-	# this is an anti-pattern: swallows segfault
	-	#git show-ref -q "refs/remotes/$2/$1" || git fetch "$2"
	-	# this is slightly slower, up to 1s out of 6s on this set of tests:
	-	git fetch "$2"
	-	# this doesn't work
	-	#test_might_fail git show-ref -q "refs/remotes/$2/$1" || git fetch "$2"
	+	test_when_finished "rm -f ref" &&
	+	test_might_fail git rev-parse -q --verify "refs/remotes/$2/$1" >ref
	+	if ! test -s ref
	+	then
	+		# Purely an optimization, makes the test run ~10%
	+		# faster.
	+		git fetch "$2"
	+	fi
	 }
=09=20
	 test_expect_success 'prepare a trivial repository' '

That's a safe way to do it that won't hide segfaults.

In *general* it's a bit painful to convert some of these, because we
really should refactor out the whole bit after "exit_code=3D$?" in
test_must_fail in test-lib-functions.sh into a utility
function. I.e. have the ability to run an arbitrary command, and then
after-the-fact ask if its exit code was OK.

If you'd like to refactor that that would be most welcome, and it
*would* help to convert some of these...

But in this case we can just use "rev-parse -q --verify", or rather,
nothing :)

I.e. my bias would be to just not try to optimize this, i.e. just
convert the users to the equivalent of a:

    git fetch "$2"

I.e. it's also useful to see that we behave correctly in the noop case,
and as there's no behavior difference it's a marginally more useful test
as a result.

And if you are trying to optimize this on Windows as I suspect I think
it's better to not do it. ~5s is the time it takes it just to get out of
bed in the morning as far as our test runtimes are concerned.

The real underlying issue is presumably its the shelling we'll do in
"git fetch", which we can eventually fix, and then make it approximately
the cost of the rev-parse when run locally...
