Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7833C433E6
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 12:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E5964E3B
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 12:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhBJMmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 07:42:11 -0500
Received: from mout.gmx.net ([212.227.15.18]:43141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231933AbhBJMkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 07:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612960702;
        bh=OYIYEQo0HWo/F4Hx5hgjVkAuflQZw8x6lntNh0PwUl8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Qo8vf5G6HTNoGqBxPupG0ai3Ku5K0MMpb69q/iRWnOP68hO03vulHFCC49QF4FYA0
         vaAeVtYP7cruFfNefRUBmxg0SzEIMVsUA5J8kdwlzgXwAeCkp0SatZ3+o+vPP+Bfmx
         SeZzYypkhitLpuYWB7OcxiUX2UqVd6MC2EsHqkxc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([213.196.212.209]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1m7pKN0oXN-00yvQ7; Wed, 10
 Feb 2021 13:38:22 +0100
Date:   Wed, 10 Feb 2021 13:38:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH 08/10] grep/pcre2: actually make pcre2 use custom
 allocator
In-Reply-To: <20210204210556.25242-9-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2102101338220.29765@tvgsbejvaqbjf.bet>
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com> <20210204210556.25242-9-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1170852189-1612960719=:29765"
X-Provags-ID: V03:K1:IedHEhDDhHX3OIjS10DINxWco+DuO8SXeiKYQ0+g9U2E+yDxhj+
 AahAhsUbKZprg6vny+zuEVtzWR7vLZtzxvcD0z/jITmcQGOxub8p1eWov0i9hKDxTUZmK5r
 Z3H0TJPCxuveyp8SLeGm8paTbNRk1EAtQuhwa74wSIw7bUYJNl5XmV3Yw7a/fg0jMw/iCu+
 L6kKw437FlxPhQ8Mvn/Bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cG/XYslsMqU=:oPl4FxN/jXBfS0TnuRwAFs
 aMWxydJRm+nKqoXdrGYYaL6NeLe+esKXBwLxslIKa1iff2QjwKWBaArPMZxgkam7D7lDRCvqS
 LVeeqnZ0rTgU+Z289JSL4FgycbgON+id6Kf2Z2fTa8PlGvtAsK9Csn6BWPX+AAt5nFLG/rNvD
 SHr9mpy7VmaqeA986LZAFyObtvgpPz96AkrS/yr0cvQgFuZeVz19AwbnG35MbRg7D/sNqzhhb
 HK0n0XQ6kB3xah7lGCD8yNjDcUSvIK5env/Iuj+ysMONWI0xVihu42nc2O0EjQ9myYDFsmze9
 Qm3aeObeMlo0izUQL77lpEX+wPSLXPD08tpgRJCC+AggK5PGsTqRchwupaFug1M413pne7vc4
 JiODUf2yuTQXq0/bS16KhX3gdN0JjSLX+mKBGzeDVeQPLziAmco4s7XgKK/BWfVuefYzdXoWx
 Dgchc21oflFGxfi1xQoSVylIvzH5v8SP7YRbISdPvp4hauAMqIFbDY33b5spWbBAAejL1jSq5
 kBGzOOoqzVUMNI4jvJj1s+BSI0zC7pk8HLoIrlijgI9gUoutCH1Stw3GDj5mB6RExbClrlB0j
 x+EtlyT6qIYNqoLKPU2bIkbLvbPzV/FCutjCxXDiQshFRPIxK5SRTKVGt09gLgG4prRfc/1Ff
 U7LuQ2kyRf5TJdhbSl75rUaSgXsxAJl+HWIWCEksjzKynm35b4S/GGyu460s3zwaoicrtsG4w
 xbQowI8TByAV6ehDht+yvjhI5EvtlxKu+ydQULc7vnHHkK0/YY1wLcSOnx1uFjRR9/z//3tq5
 tx9Qzdx/zlkmE1EwtQL48MjDkOI16x5gbmjUZZJ5uHhjo5/MT1QwRz7Kl0zhpKqZbevZYaa5h
 5iX6VqGgMUETvjJ63jwXzGYhq5AMs9e9ASakO+DaI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1170852189-1612960719=:29765
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

ACK!

And thank you for this patch,
Dscho

On Thu, 4 Feb 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Continue work started in 513f2b0bbd4 (grep: make PCRE2 aware of custom
> allocator, 2019-10-16) and make PCREv2 use our pcre2_{malloc,free}().
> functions for allocation. We'll now use it for all PCREv2 allocations.
>
> The reason 513f2b0bbd4 worked as a bugfix for the USE_NED_ALLOCATOR
> issue is because it managed to target pretty much the allocation freed
> via free(), as opposed to by a pcre2_*free() function. I.e. the
> pcre2_maketables() and pcre2_maketables_free() pair. For most of the
> rest we continued allocating with stock malloc() inside PCREv2 itself,
> but didn't segfault because we'd use its corresponding free().
>
> In a preceding commit of mine I changed the free() to
> pcre2_maketables_free() on versions of PCREv2 10.34 and newer. So as
> far as fixing the segfault goes we could revert 513f2b0bbd4. But then
> we wouldn't use the desired allocator, let's just use it instead.
>
> Before this patch we'd on e.g.:
>
>     grep --threads=3D1 -iP =C3=A6.*var.*xyz
>
> Only use pcre2_{malloc,free}() for 2 malloc() calls and 2
> corresponding free() call. Now it's 12 calls to each. This can be
> observed with the GREP_PCRE2_DEBUG_MALLOC debug mode.
>
> Reading the history of how this bug got introduced it wasn't present
> in Johannes's original patch[1] to fix the issue.
>
> My reading of that thread is that the approach the follow-up patches
> to Johannes's original pursued were based on misunderstanding of how
> the PCREv2 API works. In particular this part of [2]:
>
>     "most of the time (like when using UTF-8) the chartable (and
>     therefore the global context) is not needed (even when using
>     alternate allocators)"
>
> That's simply not how PCREv2 memory allocation works. It's easy to see
> how the misunderstanding came about. It's because (as noted above) the
> issue was noticed because of our use of free() in our own grep.c for
> freeing the memory allocated by pcre2_maketables().
>
> Thus the misunderstanding that PCREv2's compile context is something
> only needed for pcre2_maketables(), and e.g. an aborted earlier
> attempt[3] to only set it up when we ourselves called
> pcre2_maketables().
>
> That's not what PCREv2's compile context is. To quote PCREv2's
> documentation:
>
>     "This context just contains pointers to (and data for) external
>     memory management functions that are called from several places in
>     the PCRE2 library."
>
> Thus the failed attempts to go down the route of only creating the
> general context in cases where we ourselves call pcre2_maketables(),
> before finally settling on the approach 513f2b0bbd4 took of always
> creating it.
>
> Instead we should always create it, and then pass the general context
> to those functions that accept it, so that they'll consistently use
> our preferred memory allocation functions.
>
> 1. https://public-inbox.org/git/3397e6797f872aedd18c6d795f4976e1c579514b=
.1565005867.git.gitgitgadget@gmail.com/
> 2. https://lore.kernel.org/git/CAPUEsphMh_ZqcH3M7PXC9jHTfEdQN3mhTAK2JDkd=
vKBp53YBoA@mail.gmail.com/
> 3. https://lore.kernel.org/git/20190806085014.47776-3-carenas@gmail.com/
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index c63dbff4b2..0116ff5f09 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -390,7 +390,7 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  			if (!pcre2_global_context)
>  				BUG("pcre2_global_context uninitialized");
>  			p->pcre2_tables =3D pcre2_maketables(pcre2_global_context);
> -			p->pcre2_compile_context =3D pcre2_compile_context_create(NULL);
> +			p->pcre2_compile_context =3D pcre2_compile_context_create(pcre2_glob=
al_context);
>  			pcre2_set_character_tables(p->pcre2_compile_context,
>  							p->pcre2_tables);
>  		}
> @@ -411,7 +411,7 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  					 p->pcre2_compile_context);
>
>  	if (p->pcre2_pattern) {
> -		p->pcre2_match_data =3D pcre2_match_data_create_from_pattern(p->pcre2=
_pattern, NULL);
> +		p->pcre2_match_data =3D pcre2_match_data_create_from_pattern(p->pcre2=
_pattern, pcre2_global_context);
>  		if (!p->pcre2_match_data)
>  			die("Couldn't allocate PCRE2 match data");
>  	} else {
> --
> 2.30.0.284.gd98b1dd5eaa7
>
>

--8323328-1170852189-1612960719=:29765--
