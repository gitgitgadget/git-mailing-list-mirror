Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF49C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 23:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CAE610A1
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 23:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhJTXgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 19:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTXgP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 19:36:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAFFC06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 16:34:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i20so261707edj.10
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 16:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=UKR8nlkckXp6jXti+LaNrW+chEGbbFQiJ8oB/DFfpjA=;
        b=myvG8cQ3Q86nIiseVE7uUsmcFsyV7A5Msr5YJubpaSW0s5E9h2OSLeimrFYTBAPwVY
         j8EbcKc1WYCN55gxuhQKTyuXpQNoi9ztJWDDfDZFo8V2dS0cDtQt8B+NEsQnfiUsP5kg
         AbsOP+mPbiRBC/inhsTLaOuOnOaTkXcgPxFVRORkfY0/W1GfSdR1gGExmYSyo5z4fqp0
         lMeTE5wzKWAxFkFMWHmwNka/XDse2Soq90au9InGTWPmokLeVVFLtYNJCTTNLZ8xwEzi
         b12mikGieVc8tJzrE57T2OLNMPAlAeVF0NDsJxmp2WhAoxjwF3GMWqZOMoivlgzjHGqf
         znCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=UKR8nlkckXp6jXti+LaNrW+chEGbbFQiJ8oB/DFfpjA=;
        b=kr8JX5jZsHWLfgtjFZVlU6mWVQ5zgyunYovI7TFVqXrRMHyJMcuVTHTS2h7YMRcbdR
         WJ3pW5P7DdUYlFdcvTGjk4FJVZxGjRK+NVzDVXi0hgBwOWJF5PSXUgvyWQPMjXWSZHxH
         /8XEPTL8WFls8TnASsHF4mOX7Ca2/Xc8sakDEWTtjm1NVaTrYbZ5+/LhqgSE0cCWzJnu
         1YncwYlY/hFjuqhlsb/zsQRD53lWE8BYD1e177xOdSO7/n/1e3q5bIWZd9tbVX3DfFX2
         MQTLFzK0DvlHaAf+rQjMj4qV61CGsCbn6IWgln0Z5XcExG8vj4gIKv/55ZYWx/EIAmo9
         6z4g==
X-Gm-Message-State: AOAM532rSygXVyHHvG6908cuFshiuN6k7AAwbsYt95BMFBO7sjj1e6zp
        WlRWL1e9rzLH2hsOg478CX7dpEuM9C5Vhg==
X-Google-Smtp-Source: ABdhPJwJF6bPIw4rPmKQlm6vEWSFAilu8WgRz3sl1g6i0ENJd52upLzoqcdx9kSZxktHW6D5RNYSMw==
X-Received: by 2002:a17:907:7691:: with SMTP id jv17mr2763307ejc.378.1634772838394;
        Wed, 20 Oct 2021 16:33:58 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f25sm1628104ejb.34.2021.10.20.16.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 16:33:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdL5o-000uBG-RG;
        Thu, 21 Oct 2021 01:33:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
Date:   Thu, 21 Oct 2021 01:14:37 +0200
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
 <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <YXB9moNHRj+nrnX9@coredump.intra.peff.net> <YXCKqAEwtwFozWk6@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXCKqAEwtwFozWk6@nand.local>
Message-ID: <211021.86v91rmftn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 20 2021, Taylor Blau wrote:

> On Wed, Oct 20, 2021 at 04:35:38PM -0400, Jeff King wrote:
>> On Wed, Oct 20, 2021 at 08:39:51PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>
>> > This series is based off an off-hand comment I made about making the
>> > cmdlist.sh faster, in the meantime much of the same methods are
>> > already cooking in "next" for the "lint-docs" target.
>> >
>> > See 7/8 for the main performance numbers, along the way I stole some
>> > patches from Johannes Sixt who'd worked on optimizing the script
>> > before, which compliment this new method of generating this file by
>> > piggy-backing more on GNU make for managing a dependency graph for us.
>>
>> I still think this is a much more complicated and error-prone approach
>> than just making the script faster. I know we can't rely on perl, but
>> could we use it optimistically?

Jeff: Just in terms of error prone both of these implementations will
accept bad input that's being caught in 8/8 of this series.

We accept a lot of bad input now, ending up with some combinations of
bad output or compile errors if you screw with the input *.txt files. I
think I've addressed all of those in this series.

If you mean the general concept of making a "foo.gen" from a "foo.txt"
as an intermediate with make as a way to get to "many-foo.h" I don't
really see how it's error prone conceptually. You get error checking
each step of the way, and it encourages logic that's simpler each step
of the way.

> I'll take credit for this terrible idea of using Perl when available.
>
> But I don't think we even need to, since we could just rely on Awk. That
> has all the benefits you described while still avoiding the circular
> dependency on libgit.a. But the killer feature is that we don't have to
> rely on two implementations, the lesser-used of which is likely to
> bitrot over time.
>
> The resulting awk is a little ugly, because of the nested-ness. I'm also
> no awk-spert, but I think that something like the below gets the job
> done.
>
> It also has the benefit of being slightly faster than the equivalent
> Perl implementation, for whatever those extra ~9 ms are worth ;).
>
> Benchmark #1: sh generate-cmdlist.sh command-list.txt
>   Time (mean =C2=B1 =CF=83):      25.3 ms =C2=B1   5.3 ms    [User: 31.1 =
ms, System: 8.3 ms]
>   Range (min =E2=80=A6 max):    15.5 ms =E2=80=A6  31.7 ms    95 runs
>
> Benchmark #2: sh generate-cmdlist.sh.old command-list.txt
>   Time (mean =C2=B1 =CF=83):      34.9 ms =C2=B1   9.8 ms    [User: 41.0 =
ms, System: 6.9 ms]
>   Range (min =E2=80=A6 max):    22.4 ms =E2=80=A6  54.8 ms    64 runs
>
> Summary
>   'sh generate-cmdlist.sh command-list.txt' ran
>     1.38 =C2=B1 0.49 times faster than 'sh generate-cmdlist.sh.old comman=
d-list.txt'
>
> ---
>
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index a1ab2b1f07..39338ef1cc 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh
> @@ -64,12 +64,19 @@ print_command_list () {
>  	echo "static struct cmdname_help command_list[] =3D {"
>
>  	command_list "$1" |
> -	while read cmd rest
> -	do
> -		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
> -		printf " | CAT_%s" $(echo "$rest" | get_category_line)
> -		echo " },"
> -	done
> +	awk '{
> +		f=3D"Documentation/" $1 ".txt"
> +		while((getline line<f) > 0) {
> +			if (match(line, "^" $1 " - ")) {
> +				syn=3Dsubstr(line, RLENGTH+1)
> +				printf "\t{ \"%s\", N_(\"%s\"), 0", $1, syn
> +				for (i=3D2; i<=3DNF; i++) {
> +					printf " | CAT_%s", $i
> +				}
> +				print " },"
> +			}
> +		}
> +	}'
>  	echo "};"
>  }

Per Eric's Sunshine's upthread comments an awk and Perl implementation
were both considered before[1].

I also care a bit about the timings of the from-scratch build, but I
think they're way less interesting than a partial build.

I.e. I think if you e.g. touch Documentation/git-a*.txt with this series
with/without this awk version the difference in runtime is within the
error bars. I.e. making the loop faster isn't necessary. It's better to
get to a point where make can save you from doing all/most of the work
by checking modification times, rather than making an O(n) loop faster.

The only reason there's even a loop there is because it's used by the
cmake logic in contrib/* (how we've ended up with a hard dependency in
contrib is another matter...).

I'm also interested in (and have WIP patches for) simplifying things
more generally in the Makefile. Once we have a file exploded out has
just the synopsis line that can be used to replace what's now in
Documentation/cmd-list.perl, i.e. those summary blurbs also end up in
"man git".

There's subtle dependency issues there as well, and just having a
one-off solution for the the command-list.h doesn't get us closer to
addressing that sibling implementation.

In terms of future Makefile work I was hoping to get this in, untangle
some of the complexity between the inter-dependency of Makefile &
Documentation/Makefile (eventually just merging the two, and leaving a
stub in Documentation/Makefile). I've also got a working implementation
for getting rid of all of the "FORCE" dependencies (except the version
one).

1. https://lore.kernel.org/git/CAPig+cSzKoOzU-zPOZqfNpPYBFpcWqvDP3mwLvAn5Wk=
iNW0UMw@mail.gmail.com/
