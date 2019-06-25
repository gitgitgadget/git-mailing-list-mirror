Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B770C1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 17:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbfFYRD0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 13:03:26 -0400
Received: from mout.web.de ([217.72.192.78]:42939 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfFYRD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 13:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561482195;
        bh=Z41bj0hp7wyWcYDkhOJz2shi4h4mgpHGZI72sreZvLE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=H6yV8T+gg9tWc/7lptjnCajG7wmPteJxhTWYJTLVr5WFPBn0xotRQPxVA8V/P3R3Q
         RFA6tc3ptkSxYafT1xjwmDduUt/kMjL9ocQWpkCm8TyNtwq2WUtuG09pnrJIOFdwIr
         +K4wtUGtDM02OGVagtZjKcykdSW6DzwRt5K6FrE0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lcxxc-1iNzIx1yNc-00iB4j; Tue, 25
 Jun 2019 19:03:15 +0200
Subject: Re: [PATCH 2/3] sequencer: factor out todo command name parsing
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.275.git.gitgitgadget@gmail.com>
 <ebe8a2b3a1638e8457b1b703b8c4890a9b8904a0.1561457483.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ebaa5956-37aa-29b6-60c7-f287e06db505@web.de>
Date:   Tue, 25 Jun 2019 19:03:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <ebe8a2b3a1638e8457b1b703b8c4890a9b8904a0.1561457483.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TlFi3nB3+VFyrGQwQXAj8y5m0D6Dqn1JkvwzbGeRbCSJTOJ+xN+
 mrMaOQHJ1+wAXDXDAxbhGoaqHna+zITATTHPHJMxkDLrjgUO1EkVYCwX7poN4w4SVuApVJp
 tpoyXzAl4jPt99YistUwNLYiI8H0VfSj9MxtFxvQjAkpGut4dqFbfkllYMeJ7UVlLUQnbxW
 lEz240wAy3H+5WkZmfU0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EBaCUvvI/p0=:ZIBGH/r9JQKmhUxgrXCKei
 LUHph5uTdYn6omjhsdLiLzGLeENltbgCx3LEMnigidD4ZhmCoyUMxPA5X4+bQhwYEs64vrF0C
 THuj6LbRcJsCKDtIcpEdAiVmJqy2zBbRSGob1ds0+7716gH3mRQ9HzBtXdr59+YR3syARb0M1
 zdvj3l/U8mUA8eI1O3JCePqYMj19nqnyy5uDY4fpP3vVAWx2ilXXIdRKmnzZs2ilcw4nDxFBM
 D1J7zCAygUiFKnQ6VJ5+bI2ybv+XwdSBI7AQJmCTbmNi/ztO/aKIK4Eq4P2H/5UNSIVAz61nX
 Yx43ZNHIKg7fOil8bGC8M/eeoiL5qyAk6QsFgnboYjcHV+BhNZFEj0FeLK2s9g+HOv2uRQl5A
 z8UmG52MjRqBH9k/5br64NrzpLUDjHAyrjCHZZOUJ14dTocFgIW8MNpE5jt9j0Z0i6zuq18Mq
 8etNSS4UuN51/iQWi7bLQVi2IfB1ad7oahLo2S/qwN5/m5DAPycXtDsFDxba/LqDY8Sc3czF/
 UGWEcYCE6IaryvFHZ0+4ioYUaVjZzA5pmkafLBxyDsKd+Emttq0VdXNr+3L1s9ZQeoDBf27ZF
 06a/JPymDDE1gHETGL/TsHXZmMEkS815ZMadZ7a3EoDNdy3Opjd5VKa0qYIMgSz1ug1NRJc/i
 tJJEULF1LT+ejpKl090oqqqRbxfO1/Teb+zH7WPVekodDZOQp296UMVj4AgHGPeTs/tlq9dEC
 MXFsGNsaqVylEwWjXjeaW+Nc9+nlGE5iBl7zzuaI2QMOzWaq/GAlImXAEawoPAtVRARLSut27
 QbW7iWwEbXva7ER3t0y28se8PEKElkn+TJ9kXksI0egYsQSAuhkaW+kFIZiQ2CyXpDeg4tvm3
 o4cmvYQihwF6MqwG3tyzxdhAnPVFop3tn92LFqv0nx8bPKSuWOXv3myjizIe0qVZyVVguI59P
 ye7guXLLGQ69HFmriETWFMQjL23cr4U8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.06.19 um 12:11 schrieb Phillip Wood via GitGitGadget:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Factor out the code that parses the name of the command at the start of
> each line in the todo file into it's own function so that it can be used
> in the next commit.

"Factor out" sounds like functionality is intended to not be changed...

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 919e3153f5..793f86bf9a 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2076,6 +2076,18 @@ const char *todo_item_get_arg(struct todo_list *t=
odo_list,
>  	return todo_list->buf.buf + item->arg_offset;
>  }
>
> +static int is_command(enum todo_command command, const char **bol)
> +{
> +	const char *str =3D todo_command_info[command].str;
> +	const char nick =3D todo_command_info[command].c;
> +	const char *p =3D *bol + 1;
> +
> +	return skip_prefix(*bol, str, bol) ||
> +		((nick && **bol =3D=3D nick) &&
> +		 (*p =3D=3D ' ' || *p =3D=3D '\t' || *p =3D=3D '\n' || *p =3D=3D '\r'=
 || !*p) &&
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^
... but this adds support for LF, CR and NUL as separators after short
commands...

> +		 (*bol =3D p));
> +}
> +
>  static int parse_insn_line(struct repository *r, struct todo_item *item=
,
>  			   const char *buf, const char *bol, char *eol)
>  {
> @@ -2097,12 +2109,7 @@ static int parse_insn_line(struct repository *r, =
struct todo_item *item,
>  	}
>
>  	for (i =3D 0; i < TODO_COMMENT; i++)
> -		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
> -			item->command =3D i;
> -			break;
> -		} else if ((bol + 1 =3D=3D eol || bol[1] =3D=3D ' ' || bol[1] =3D=3D =
'\t') &&
                            ^^^^^^^^^^^^^^
... while this removes the check against the string's length.

Is this safe? It probably (hopefully?) is, as skip_prefix() requires bol
to point to a NUL-terminated string already.

But is_command() could do the old (and shorter) eol check just as well,
so the next question is: Why this change?

> -			   *bol =3D=3D todo_command_info[i].c) {
> -			bol++;
> +		if (is_command(i, &bol)) {
>  			item->command =3D i;
>  			break;
>  		}
>

