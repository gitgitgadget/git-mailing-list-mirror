Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78397C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 13:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AB020707
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 13:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Q8d5zPhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgA3NqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:46:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:54857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgA3NqX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 08:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580391980;
        bh=rCA9MWaO4Zw2jUqP9TAIj5UAtqfyueysaH6q4QUXm8U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q8d5zPhpYPPOcSWMCji4sRMrul71qgZqYxml6RRG9VN57WlDSud9ZA6RFjndI4TKe
         JW+0+OSYQmfq4O/PVn6pNcvY+518JLKYE3HDhnOTH/SCPcsYZsVJ+Zr8HGVxP4WpVU
         jxFJcWFf2YN1q8UTaBgW14yAlmEjqRX5jN/MjS2Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1j87Rj39UO-00ShZH; Thu, 30
 Jan 2020 14:46:19 +0100
Date:   Thu, 30 Jan 2020 14:46:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 09/11] bisect: libify `check_good_are_ancestors_of_bad`
 and its dependents
In-Reply-To: <20200128144026.53128-10-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001301341100.46@tvgsbejvaqbjf.bet>
References: <20200128144026.53128-1-mirucam@gmail.com> <20200128144026.53128-10-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bIsX56eWy88CRVPFF0sg3JmxJEZjZZL6znM/W42Ald0pw4Bb4Iy
 dWn4j+k//660G9GOCu6gGenEEiqOLVc8ZEKFIHbAYlre7jXBtYA2X/N0T+ke+lImLB7ijLC
 FDQ6+PQv3N260x6HzcwwpVdMxYBxZJN23HM0wKq42Y3oweayrf60bAExEjLRwXlx8qfc8/w
 nZmuzUXwFnfljFlIh4ngA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GZYCXjUlJvU=:XiZR0oz643mz90m13ijH0s
 TSG8fgtVdhpnVZKS2oWm/TA+hlR5Gza1LB6YtVkme5SdxsIWVtJ7hwCESTQc1u3sm7chXIVv2
 UwAKg9L7HzZp71SNUHasZVGJUS6NrParM/WBziDujCnyVm29Ui58ukA0stKcIchiMblRZCnNT
 JjVd5PNSR865aXfXglGQAmbLhTeYMxWI/TONdW+yC1HmvGvAFkAcZHBV3g279YK06AeQbJZQP
 FUxQczPR1Zj06C/E1GOBB8rIatHRfhHlaXewY7bhFs7lOtTJKUuvU9ocELYNHBAdB7KDI2H4L
 XffSmHjI/WrLBHU/AUGyOJU6UrXZXjr3+Kek9PtaMH/94PbjTLxmIduMyQdcuohvfmvfE611t
 lsHp7dxbE/gHIq2/Y5Ui1dJEwE7baFNcLozb6zwGgTAHdIpOfSFkjhJOCuvhFl1iTrJmv/TGk
 HJm/ez+QWYLW66sfzn+5ywQfRmv9l5THcpskzmCFk4Horuxl6ApAIpuHWZUthJDBm8uVh3P8p
 isSw6T3BsjLm07PkbPfpGO6L9XmoRUR4ETHzsy3VqqwGpoY1kHeOp5B0QBAP7V7vLMjgTIIKO
 DXgxC4F2VTlJZYHmg/Y47FpMB8zLHraZxSGp/f7Fv3W2WkDmN7qL+AMo1bbqY3dA31gIoQwf3
 2Gy6BSUw+j9iojQ8dE/0sKJZTTbwno9YWFHCnb8EInB3k3FHryX/apA0LmCSZ33O036sgE7Ww
 MtvnHGXJcB3UcgbyRww71YrQVlpeBA12JlC9Q5oDUQhZom4oXrO0iZ5QOZcNikmz+4mgW7dnq
 4TUa37vLCGpFNYGTWH4ZX57Gi+m33pG1tt5nFVQN9gbTkEMIrHxNySEFWK4r2YFw4SxvwTo6J
 PkQT1qJFRsueBp34c19uZhL93Tact6rPNlM6DneFQlFTW989oeQ6BLJfnNBvz6rBs+QZAitdm
 Un/qOXgNjQ7FdfCcj0LAfpvKvvTCl+/oLxm+XBbZhQfLsuwcLA75VsUJLJrhT+U0tRisG+yJW
 54UMUCO0L3XkBQ2KPt+8S2Hnha26FuYkIOAcRLevIPVYgBZDBCvNz/wP8qFH4jD4z6m8jFS3D
 6SL9v40rjfb2L3ReFprVBZ1ZLpKfQ6xPx/KuWo4dQcISpTcQIJhATuJMCcU4J6MnK+nrwzB2z
 EBOcPTpmuWTJtUEmCXB1Xrr323Rr0Q3zjlOAcL2dA12AQbIqHRNwDuRD8qlLyKyZaIcrGqG0t
 8dS3KPXc5empDFESD
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Tue, 28 Jan 2020, Miriam Rubio wrote:

> @@ -893,18 +901,20 @@ static void check_good_are_ancestors_of_bad(struct=
 repository *r,
>  	if (check_ancestors(r, rev_nr, rev, prefix))
>  		res =3D check_merge_bases(rev_nr, rev, no_checkout);
>  	free(rev);
> -	if (res)
> -		exit(res =3D=3D -11 ? 0 : -res);
>
> -	/* Create file BISECT_ANCESTORS_OK. */
> -	fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> -	if (fd < 0)
> -		warning_errno(_("could not create file '%s'"),
> -			      filename);
> -	else
> -		close(fd);
> +	if (!res)
> +	{

Please move the opening `{` to the same line as the `if (!res)`.

> +		/* Create file BISECT_ANCESTORS_OK. */
> +		fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> +		if (fd < 0)
> +			warning_errno(_("could not create file '%s'"),
> +				      filename);
> +		else
> +			close(fd);
> +	}

I wonder whether this would be easier to read:

	if (res =3D=3D -11)
		res =3D 0;
	else if (res)
		; /* error out */
	else if ((fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600)) < 0)
		res =3D warning_errno(_("could not create file '%s'"), filename);
	else
		close(fd);

Note: my code explicitly assigns `res =3D -1` if the file could not be
created, which is technically a change in behavior, but I think it is
actually a bug fix.

>   done:
>  	free(filename);
> +	return res;
>  }
>
>  /*
> @@ -975,7 +985,9 @@ int bisect_next_all(struct repository *r, const char=
 *prefix, int no_checkout)
>  	if (read_bisect_refs())
>  		die(_("reading bisect refs failed"));

I see that there is still a `die()` here, and you left it alone in this
patch because at this point, only the callers of
`check_good_are_ancestors_of_bad()` need to be addressed. Good.

At a later point, this will have to be dealt with, of course.

Another thing will need to be handled, too: while I was looking at the
code whether any resources need to be released (returning a negative
integer does not release memory or close file handles, unlike `die()`), I
stumbled across the fact that `term_bad` and `term_good` are file-local
variables. They will need to be made attributes of a `struct` and will
need to be released properly, i.e. the ownership will have to be clarified
(is a failed `bisect_next_all()` responsible for releasing the memory it
allocated via `read_bisect_terms()`, or its caller?).

Just something to keep in mind. Or better: to jot down in a TODO list.

>
> -	check_good_are_ancestors_of_bad(r, prefix, no_checkout);
> +	res =3D check_good_are_ancestors_of_bad(r, prefix, no_checkout);
> +	if (res)
> +		return res;
>
>  	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
>  	revs.limited =3D 1;
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 826fcba2ed..3442bfe2cb 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -666,7 +666,8 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>
>  	switch (cmdmode) {
>  	case NEXT_ALL:
> -		return bisect_next_all(the_repository, prefix, no_checkout);
> +		res =3D bisect_next_all(the_repository, prefix, no_checkout);
> +		break;
>  	case WRITE_TERMS:
>  		if (argc !=3D 2)
>  			return error(_("--write-terms requires two arguments"));
> @@ -713,5 +714,12 @@ int cmd_bisect__helper(int argc, const char **argv,=
 const char *prefix)
>  		return error("BUG: unknown subcommand '%d'", cmdmode);
>  	}
>  	free_terms(&terms);
> -	return !!res;
> +	/*
> +	 * Handle early success
> +	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_n=
ext_all
> +	 */
> +	if (res =3D=3D -11)
> +		res =3D 0;

Hmm. Is this the correct place, though? Should `bisect_next_all()` not be
the function that already turns `-11` into `0`? In other words, _which_
code are we supposed to skip over when `check_good_are_ancestors_of_bad()`
returns `-11`? In other words, where would the `catch` of the
`try`/`catch` be, if we had portable exceptions in C?

> +
> +	return res < 0 ? -res : res;

This is a change in behavior, though: previously we guaranteed that the
exit code is either 0 on success or 1 upon failure. I am not quite sure
that we want to change that behavior.

Ciao,
Dscho

>  }
> --
> 2.21.1 (Apple Git-122.3)
>
>
