Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24258202C40
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363854; cv=none; b=fRQsLHuX5AJgNAooMHXA7zfTDTBe8hTuEBZsPNr/W7Mg8m8lGX1QUKesNRT0Ahr+kOBSx80/53JCMd0MFVMiCl2bxP6e3l7SgW0/vgGCd34P6+YU1JFzRG/Gxr+98u/Y5GvwhaZ4aHfDlDtGwkEGcEnpe9TNi9HBM5Da7ec4yAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363854; c=relaxed/simple;
	bh=QWurTCpUpsKjfx4/Pmz2fnaIGLsm4xRXyyUlMwQUIjI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aNfeZaXQB8fpt5apV2pILgH3XtbIigDkFsbR50xHffqM/bv7jDV44wmKMjb/RTDGJ7SmHHYHEdqbGyGVJeM2obsJVxyoghFbf2LsijZxwaOH5T+KEs0E7Lzgv0t07ZUbi9+SgatxmAKV/rc8MtRkmshwkxKBVeqLZR6raHl/09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=plEGAmsF; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="plEGAmsF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736363844; x=1736968644;
	i=johannes.schindelin@gmx.de;
	bh=V1aX3OHQ2LmRK8QvJqFXMAWxm3vegzbTbuYaxE9KrLs=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=plEGAmsF+HkE0Aaqu55ZRnxsTAdO2fWJwLvbfLYpTxLzum2FQTu6QJCC0BBdSlYz
	 3ppINBRUfEtDHP/Ws+apoOqj32z1Tm/Xs2rHF/d4tyUQtaHuaVXryNMQhDj1N3qsU
	 7znKfJjPcp3g7fh6wVYSXPzxDdI5Zb3LDxG2D7NXKSv8NixYzqC0kJ3BJv8ppnpOo
	 O1xHtQkgtMgtYXgZPmRPRcaevwa3CDD3seZEMBcTZBCrvVd9u71QE3VKYjwphqUTk
	 vO+4Z10c/fxK18frASsnCALCOUc9sENyKXp29OJOLwo/X4JaLCZkObzdP5uqijHTZ
	 /ovDnCWOlj8QgSY0Iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.7]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXpK-1t5Aii0dRw-00IfLW; Wed, 08
 Jan 2025 20:17:24 +0100
Date: Wed, 8 Jan 2025 20:17:23 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, shejialuo <shejialuo@gmail.com>, 
    Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 13/16] builtin/blame: fix type of `length` variable
 when emitting object ID
In-Reply-To: <20241206-pks-sign-compare-v4-13-0344c6dfb219@pks.im>
Message-ID: <4d812802-afbc-4635-7a19-73896fcda625@gmx.de>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im> <20241206-pks-sign-compare-v4-13-0344c6dfb219@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7mEOudqZjj6hUQbNiADHGEC8QZUGWB+WkOmGbiE79bhIz5YKm7Z
 XcFD2LU1YnnA5/+jFQdApXf5gwpa7Hn1h7kq5LbjktSpudDUKzwpfcZhaFTbu55uHsIqg13
 4aXloqUfwTBpv9yt7D0BRLyJCMLAbUb0SDNCwoOLCszGVnfvVlcrV1wEbWL/WbMst+XNeqZ
 EJ9o2YzAJPPGrCeW25lBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CY/axSDkjhc=;pxCuLD3zthueGRZURRbpD0MXx5m
 E+4vvDs+lmNr8ebqmk99cdZI5gRXWe6i98RhxY4+eKmucUaJCLFo1pA7bSSuSUmeWoqNbTPYA
 /ftm1zhrkJtujQSYl8FsNdf9xmx3hZBHkONTWAqcQx1UeK01k3DuZqTL/oB936VRmJOH05YYx
 n9a3vVaIxX8gFXngCHpQIlfmU9tzW/KhTdViDZg4iHAYyldOln5se0aJVnuyyIu52zNI4HiNm
 A8vjooaeCxY1ZmlIHVDdUzoyNoV3/bxDG1ysgy1uFarlkoTwYDn2agofdFtUgFSVsvPKFJMF9
 GA9fwmm+DkfdzbtrCJ6jrt3Nb3VdSJpNd4g1Lxn+7W1GD/lxiaWDPvPC9ujQ1v9Y8bcbbaQgw
 XwMbxaxdEo7V24qGDzqWs8AUoEKq8jV5ca1SPecZtm1tM97OhmDuQud4PrkHcl100AxOdFDAi
 0ChJS5lrvKF4zr1FjrRSVhioS1qfVZkL0+CpAPaSoSuyN7pO/vKYuvdJZ+7zXi4no570H8pse
 ANglW/aFG8YNgb/crV8WFp2W3DA0V4AwFMEo0/W8xyMc19htMbPoz402jtASTToBqlg7hydzN
 zYflz6N+en6thHiXfXFsCcAK/FShrxnJbzeeGdeS64a14am5j+LjfxZUIzrEO4H966hz60MUh
 9RfG62iPkjrKBb2hezii7b5fZz8aSxGyu5PWQkBmuXj+QAKSzmMZKMW/PL06UxvMPdYH1N4Hk
 Ie0yxkvJDmah7aCpsnfHE2bCUkwIZRPaE6wI6wGAIMeJ8rWsJhgCm3t9GHcr/eyHmnmvf/55i
 EZjSytO+NJhpCVNa0LuPmtTSO6b8dil0LgUekp7NrFqLZ2OXQbJv27vcbrbrCjRgi1GI7Haqb
 ZkW4INMT+kcCikNdZd0/7g6M5Cno9aaS76zR6YujuxTKG2cYfkE3yAhmTXQDBCoUcuM2Ld/V/
 42o0VfPgB8anFVBzU2tsDG0SHH24f+HMkQOtn5f11FLKKXrBkcQs9/URsCflQoN3IgRCfbarf
 //0atLtkBwUI7QapOrsb5js8ddQ4I4ulKY4piJz0EBKpbWzDd1RwgxcNmHEQolpAnXCCAWBdt
 gUOA6pxxI=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 6 Dec 2024, Patrick Steinhardt wrote:

> The `length` variable is used to store how many bytes we wish to emit
> from an object ID. This value will either be the full hash algorithm's
> length, or the abbreviated hash that can be set via `--abbrev` or the
> "core.abbrev" option. The former is of type `size_t`, whereas the latter
> is of type `int`, which causes a warning with "-Wsign-compare".
>
> The reason why `abbrev` is using a signed type is mostly that it is
> initialized with `-1` to indicate that we have to compute the minimum
> abbreviation length. This length is computed via `find_alignment()`,
> which always gets called before `emit_other()`, and thus we can assume
> that the value would never be negative in `emit_other()`.
>
> In fact, we can even assume that the value will always be at least
> `MINIMUM_ABBREV`, which is enforced by both `git_default_core_config()`
> and `parse_opt_abbrev_cb()`. We implicitly rely on this by subtracting
> up to 3 without checking for whether the value becomes negative. We then
> pass the value to printf(3p) to print the prefix of our object's ID, so
> if that assumption was violated we may end up with undefined behaviour.
>
> Squelch the warning by asserting this invariant and casting the value of
> `abbrev` to `size_t`. This allows us to store the whole length as an
> unsigned integer, which we can then pass to `fwrite()`.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/blame.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index b33b44c89a431d45e05d9863f69c049ba5eec08c..867032e4c16878ffd56df8a7=
3162b89ca4bd2694 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -6,7 +6,6 @@
>   */
>
>  #define USE_THE_REPOSITORY_VARIABLE
> -#define DISABLE_SIGN_COMPARE_WARNINGS
>
>  #include "builtin.h"
>  #include "config.h"
> @@ -468,9 +467,14 @@ static void emit_other(struct blame_scoreboard *sb,=
 struct blame_entry *ent, int
>  		reset =3D GIT_COLOR_RESET;
>  	}
>
> +	if (abbrev < MINIMUM_ABBREV)
> +		BUG("abbreviation is smaller than minimum length: %d < %d",
> +		    abbrev, MINIMUM_ABBREV);
> +
>  	for (cnt =3D 0; cnt < ent->num_lines; cnt++) {
>  		char ch;
> -		int length =3D (opt & OUTPUT_LONG_OBJECT_NAME) ? the_hash_algo->hexsz=
 : abbrev;
> +		size_t length =3D (opt & OUTPUT_LONG_OBJECT_NAME) ?
> +			the_hash_algo->hexsz : (size_t) abbrev;
>
>  		if (opt & OUTPUT_COLOR_LINE) {
>  			if (cnt > 0) {
> @@ -501,7 +505,7 @@ static void emit_other(struct blame_scoreboard *sb, =
struct blame_entry *ent, int
>  			length--;
>  			putchar('?');
>  		}
> -		printf("%.*s", length, hex);
> +		fwrite(hex, 1, length, stdout);

I just noticed this, and would like to point out a difference of behavior.
Try this at home:

	git blame --abbrev=3D99999 git.c

The difference relative to the previous behavior that I am observing is
that the `fwrite()` call does not stop at the NUL character and hence
happily continues out-of-bounds. The `printf()` call would have stopped at
the NUL character.

Ciao,
Johannes

>  		if (opt & OUTPUT_ANNOTATE_COMPAT) {
>  			const char *name;
>  			if (opt & OUTPUT_SHOW_EMAIL)
>
> --
> 2.47.0.366.g5daf58cba8.dirty
>
>
>
