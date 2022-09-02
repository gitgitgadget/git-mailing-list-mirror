Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9BEC38145
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 10:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiIBKNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 06:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiIBKMv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 06:12:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CB24D4D5
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662113535;
        bh=r8hw0H2drzkCoqpJqHRQ8h/EPHYjPOtceFqSDYVedaQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PyCmvqyvk8tH++DU4FA+pabd4pTWJf/OwkaavBojPv7SJ4TZOofrPIDPiGICIXC9s
         K9+41ttVPON7UpbyJg7osLRahKXz0xYgL8RGLX8V5Tm7KscN/+0RSc4SEfuzim5ZmE
         bvrmOV0e7W21mpQfgkMoWFLZx6yUnZz+ddoIbBmc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTmY-1oreEj021m-00WUsS; Fri, 02
 Sep 2022 12:12:15 +0200
Date:   Fri, 2 Sep 2022 12:12:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, alexander.s.m@gmail.com
Subject: Re: [PATCH v3 2/2] diff.c: More changes and tests around
 utf8_strwidth()
In-Reply-To: <20220902042138.13901-1-tboegi@web.de>
Message-ID: <00059orr-6p52-q0ro-306r-s225561s2912@tzk.qr>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com> <20220902042138.13901-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:k31Npu7Y4bUOfdkpB7wyZZLJsZVyfeyrh09Vi2Dj3bTdjvhxzwz
 eb4Ozia+2Zg3LvB+6x57+yDt4Fwuynt+ceEqgwQyI4LbsnjA/wX1UHTZRs1QEY/gJ3JMkgv
 8pDNLehYxfKFpOJIXEyAEmkMCKUFswX4aF4OZdgmM0XYc7Pm7T2ndmebaIEtsoiUbc2xoHB
 dzRCNo8EO+j0dlpAanhyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eKFPsl7UDI4=:onO7fvKcm/RU9a1NcTF2NN
 Pb9TXpbsdceLCLQdl2J04ZfLtcwfFI8HGkHcUsracDYpKxyb2Ob1ygG/jhbJy1YmwSqKT3c9Z
 Oc9ZLZWTT4M/rIZpwFUd1+l/mRvzJc/2FA1ib92W29qKLEamxpPlkuHuOwHBMtKbMG32C75T5
 YF7oppPohg26qG5ywmnHn8jqtJ4b1NWr+Ny3FZB85OSvV7whNR+T2TYvNYDQC6u0ckurXTQ6i
 F+S/Po3CIOrKRnqMG/sQSlMwacMVrdb1ihMA6JxY+C1QNq6DpMV4vjE3vUYNChsVc8i/VYsaz
 gUwbqgdWc0NAcvEvvimqXfhTYSfkJG0FJS5Vvux4QMs3d1ZGJhgOBUgDEW2syVzVpTpGa1oyu
 DMztEKBij/2IQNbKY5mFLPZyc+74SbnLroV44GAf8UNRLtxBAbQUwO5eng59mOnfaKM6o+XWz
 6XfLBJJyT2N7JviGxvljlIvtSU9RtqX5v2XjshEtm7msHhEtjvhl4Tr0wnbzq8rWSqeCBumsm
 pnL/BpGO1n6l8fTRvFfg+rRkeRSRpxbS0z+1ws28NqVz9dakHpCipSckH9c82IE9K+fYclDnN
 IFsE9dDqKjdRi7U3FpsmeRMhBOCc1F+PGhLHj8VtNQtBRL+We2r+DwLBTZ7EN7IiqglbG6TxF
 Sezw/Q/2sVqFxiUCP19Nrf5pbynneXUEen8aVDsSqOPr6JC9VFmevyJDWqpRQzZYCcr5TYbeo
 +C1jIkTULLUce4Q9a1rvOd+YY93aelOv2lhpLafsLpaU7GyXOp0jyKA977VCRsSV54IntXAlL
 NeWLUzdHcr9nOzZ9CfqLVDeg6RlXsUBZUBKAqpKhCSr3yk/now9R3BEGQNF6LFs0s+6XXUGER
 pGgaRLL+9hpSJcvXH7viZyq7oimtfJZmalLcT6OnsCXjJKlnceyHRcJ5bKkkmDJCFPN0VNum9
 wm7qrrGmeynVCQbIGq3vp1XY/UA8+LhAbUOYE8FxpVgCV5cLzxpWn0/RlP5KtX2MsQS5SjwNo
 Z+x5zw3kyyi9VuFFjgOoQUzGz/uowWPokgzQMGZl+7lDvFq4JL1IA0GglyaG/5ONmxVmUmIe+
 bDxS0fX1KW0TWL/R2JVM0bV+/WsKbX65y+RMvW5w/RATQCrkfXaM1S0ccOfUnOXNHqkDQNPnI
 wQugCsMg0ES2F2RNv/jzhwZrLS
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten,

On Fri, 2 Sep 2022, tboegi@web.de wrote:

> diff --git a/diff.c b/diff.c
> index b5df464de5..cf38e1dc88 100644
> --- a/diff.c
> +++ b/diff.c
> [...]
> @@ -2753,10 +2754,14 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
>  			if (slash)
>  				name =3D slash;
>  		}
> +		if (len > utf8_strwidth(name))
> +			num_padding_spaces =3D len - utf8_strwidth(name);

Here, we determine how many spaces are needed for padding. The value is
later used in three instances, and from the diff it is not immediately
obvious that all code paths are covered. I did verify locally that this is
the case, though, so all is good.

>
>  		if (file->is_binary) {
> -			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
> -			strbuf_addf(&out, " %*s", number_width, "Bin");

This was already a bit wasteful by calling `strbuf_addf()` twice, where
one time would have sufficed. (This applies to the other two code paths
below, too.)

> +			strbuf_addf(&out, " %s%s ", prefix,  name);
> +			if (num_padding_spaces)
> +				strbuf_addchars(&out, ' ', num_padding_spaces);
> +			strbuf_addf(&out, "| %*s", number_width, "Bin");

Instead of fixing this, we now add yet another `strbuf*()` call.

But this could be done more elegantly, via a single `strbuf_addf()` call:

			strbuf_addf(&out, "%s%s%*s | %*s",
				    prefix, name, num_padding_spaces, "",
				    number_width, "Bin");

By the way, it would flow much better, I think, if we used the
short-and-sweet variable name `padding` instead of `num_padding_spaces`.

>  			if (!added && !deleted) {
>  				strbuf_addch(&out, '\n');
>  				emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
> @@ -2776,8 +2781,10 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
>  			continue;
>  		}
>  		else if (file->is_unmerged) {
> -			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
> -			strbuf_addstr(&out, " Unmerged\n");
> +			strbuf_addf(&out, " %s%s ", prefix,  name);
> +			if (num_padding_spaces)
> +				strbuf_addchars(&out, ' ', num_padding_spaces);
> +			strbuf_addstr(&out, "| Unmerged\n");

This can become

			strbuf_addf(&out, " %s%s%*s | Unmerged",
				    prefix, name, padding, "");

instead.

>  			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
>  					 out.buf, out.len, 0);
>  			strbuf_reset(&out);
> @@ -2803,8 +2810,10 @@ static void show_stats(struct diffstat_t *data, s=
truct diff_options *options)
>  				add =3D total - del;
>  			}
>  		}
> -		strbuf_addf(&out, " %s%-*s |", prefix, len, name);
> -		strbuf_addf(&out, " %*"PRIuMAX"%s",
> +		strbuf_addf(&out, " %s%s ", prefix,  name);
> +		if (num_padding_spaces)
> +			strbuf_addchars(&out, ' ', num_padding_spaces);
> +		strbuf_addf(&out, "| %*"PRIuMAX"%s",
>  			number_width, added + deleted,
>  			added + deleted ? " " : "");

And this reads better as

		strbuf_addf(&out, " %s%s%*s | %*"PRIuMAX"%s",
			    prefix, name, padding, "",
			    number_width, added + deleted,
			    added + deleted ? " " : "");

If we modify the code in this manner, we avoid repeating a pretty
unreadable pattern three times, using a much more readable pattern
instead.

Random note: The existing code (not your fault) is hard to follow because
it calls `show_graph()` for `add` and `del` always, even if their counts
are zero (in which case `show_graph()` returns early), while the
separating space is appended in the otherwise unrelated `strbuf_addf()`
call before that, but uses the (unscaled) `added + deleted` as condition
for that separator. It would be much easier to follow like this:

		strbuf_addf(&out, " %s%s%*s | %*"PRIuMAX",
			    prefix, name, padding, "",
			    number_width, added + deleted);

		if (add || del) {
			strbuf_addch(&out, ' ');
			show_graph(&out, '+', add, add_c, reset);
			show_graph(&out, '-', del, del_c, reset);
		}

But I consider this #leftoverbits, not something to burden your
contribution with.

Ciao,
Dscho

>  		show_graph(&out, '+', add, add_c, reset);
