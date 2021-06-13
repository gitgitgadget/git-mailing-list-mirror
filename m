Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFC2C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 13:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2067C6128A
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 13:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhFMNnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 09:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbhFMNnw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 09:43:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07BAC061766
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 06:41:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id h24so12006049ejy.2
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=bfuJfB9ZYh544M8XxNCSKvm9Xd2IZWx3h0g6CSGdWSQ=;
        b=OQfbaBdcC3ULlXmVHhCGVWp5jw0zpq0Hza94CWZV1qcJbzbuPEL7ogbWZF7yLHjtv8
         gdW2PK/PtKmqFIWrPmc1ZmFaVVZM1h7pUhJ3XimY/NfmpDEeCLlZTKmFRANB70DKDSL1
         0SmcJ5GuH89nmU1ksOL/VRYRnhhhTpxoRd8ZzF2IsbRsnXgYu5/pmL80ZJy9HexMfLcS
         iC0bzKaMWhzR8XrFsnabpPO6hMAcyvFAC7yqODVKDenTnvxDK+BC5P4zqqkkdiHPKvkh
         XlYm05dptkGcCjMP/AuRFzutVflQvUATCqaWSVTR2Uv27r/21QSVfnwVlapa/4dLMSk5
         vImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=bfuJfB9ZYh544M8XxNCSKvm9Xd2IZWx3h0g6CSGdWSQ=;
        b=pmt/mcjJP08nRvApscvYLLhKbFqqK0EtYPqKykaNEIzIxBMFs0gRGX+K+MzCFNd+kW
         0Fja/19wG5JyUSg4tP/7ANRlV/fS1GpcShYBk9st5cPuek6UzDUqaoP5+IKuDBxoRX37
         yoHXUDwXtdjBKONFRGX/iVjyzVE0Y4wdQceNZpKYT71iN5ofju6cDDi+16wAnMGAhkRy
         Gwjm0YQUEqAp7dUjAyUegPewH9AoNEZjlIUo3bnG4gNg1gKvvzjGcC9BQkjiZydOq/rZ
         mFjdq08J2xhcdphcVLIUFP36vQILgmusCLCxZ+6mhji+KgKtdCYUPVMS+Mx7kRdClpga
         JbsA==
X-Gm-Message-State: AOAM532dfCVqbgmoMCPZOAI8NW/LDwQgV5mYtrM1b74MH/Q9pFxFhgeX
        9CfgMwg2pjTWeBQZjOB/kNg=
X-Google-Smtp-Source: ABdhPJx5lqyH4PTPL59BvP8LjJpZ3AI82/BR4BjPwCz6wTWtmENZes/K8ioq66zTHgf9Qz0Khxc6XQ==
X-Received: by 2002:a17:906:1912:: with SMTP id a18mr11477857eje.117.1623591709345;
        Sun, 13 Jun 2021 06:41:49 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id o20sm5837370eds.20.2021.06.13.06.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 06:41:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test-lib-functions: introduce test_line_count_cmd
Date:   Sun, 13 Jun 2021 15:36:11 +0200
References: <20210612042755.28342-1-congdanhqx@gmail.com>
 <20210612042755.28342-2-congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210612042755.28342-2-congdanhqx@gmail.com>
Message-ID: <878s3d286c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 12 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> In Git project, we have multiple occasions that requires checking number
> of lines of text in stdout and/or stderr of a command. One of such
> example is t6400, which checks number of files in various states.

Thanks for following up on this.

> Some of those commands are Git command, and we would like to check their
> exit status.  In some of those checks, we pipe the stdout of those
> commands to "wc -l" to check for line count, thus loosing the exit status.
>
> Introduce a helper function to check for number of lines in stdout and
> stderr from those commands.
>
> This helper will create 2 temporary files in process, thus it may affect
> output of some checks.

I think it's fine to just blindly stick the name into a file in the CWD
as long as it's not "actual" or some other such obviously likely to
conflict name.

The convention you've picked here (I'm not sure if it's existing
already) of naming the temp files after the test lib function name is a
good one.

More generally speaking we have a bunch of helpers that have this
potential issue/bug, in practice it's not a big deal.  A test that's
being overly specific and doing a test_cmp on unbounded "find" output or
whatever is likely buggy anyway.

If it ever becomes a bigger issue we can easily set up two scratch
directories during the test, one for the use of the test itself, and one
for the internals of the test run itself.

> +# test_line_count_cmd checks the number of lines of captured stdout and/=
or
> +# stderr of a command.
> +#
> +# NOTE: this helper function will create 2 temporary files named:
> +# * test_line_count_cmd_.out; and
> +# * test_line_count_cmd_.err
> +#
> +# And this helper function will remove those 2 files if the check is suc=
ceed.
> +# In case of failure, those files will be preserved.
> +test_line_count_cmd () {
> +	local outop outval
> +	local errop errval
> +
> +	while test $# -ge 3
> +	do
> +		case "$1" in
> +		--out)
> +			outop=3D"$2"
> +			outval=3D"$3"
> +			;;
> +		--err)
> +			errop=3D"$2"
> +			errval=3D"$3"
> +			;;

It looks like the end-state of the series leaves us with no user of the
--err option; Maybe it's good to have it anyway for completeness, or
just skip it? ...

> +		*)
> +			break
> +			;;
> +		esac
> +		shift 3
> +	done &&
> +	if test $# =3D 0 ||
> +	   { test "x$1" =3D "x!" && test $# =3D 1 ; }
> +	then
> +		BUG "test_line_count_cmd: no command to be run"
> +	fi &&
> +	if test -z "$outop$errop"
> +	then
> +		BUG "test_line_count_cmd: check which stream?"
> +	fi &&
> +
> +	if test "x$1" =3D "x!"=20
> +	then
> +		shift &&
> +		if "$@" >test_line_count_cmd_.out 2>test_line_count_cmd_.err
> +		then
> +			echo "error: '$@' succeed!"
> +			return 1
> +		fi
> +	elif ! "$@" >test_line_count_cmd_.out 2>test_line_count_cmd_.err
> +	then
> +		echo "error: '$@' run into failure!"
> +		return 1
> +	fi &&

...I think it's better to not pipe to *.err if we haven't requested it,
so under "-v" etc. we can get the stderr.

If we're unifying them I think a better pattern is to only run that "$@"
once, get $?, and then act differently on that in the "!" and ""
cases. It requires less careful reading of the critical function path,
especially with the differing indentation.

> +	if test -n "$outop"
> +	then
> +		test_line_count "$outop" "$outval" test_line_count_cmd_.out
> +	fi &&
> +	if test -n "$errop"
> +	then
> +		test_line_count "$errop" "$errval" test_line_count_cmd_.err
> +	fi &&
> +	rm -f test_line_count_cmd_.out test_line_count_cmd_.err

Let's do that "rm -f" as a "test_when_finished" before we first pipe to
them. It's fine to do that in a test lib function, see e.g. test_config.

We'll get the benefit of preseving these files under -di etc.

> +}
> +
>  test_file_size () {
>  	test "$#" -ne 1 && BUG "1 param"
>  	test-tool path-utils file-size "$1"

