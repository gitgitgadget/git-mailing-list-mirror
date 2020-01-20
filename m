Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E91C32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7B222525
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JslQS3Ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgATV5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 16:57:44 -0500
Received: from mout.gmx.net ([212.227.15.15]:36055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgATV5o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 16:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579557461;
        bh=0BdfG3SsyD5QOPDCTmNSniKabJE00GGAEQI8vF3RqWQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JslQS3IpatEiQHPO2v7bkXJDDah19hHN14x4z2uUJF3i9zXZp4e+6BfceRt1QjNhA
         s1HPI3+mgpd9cghC9EEoGZKKyGAgblMvGyvQB65M/eQLyDPq/W0XKoNx5ISnegWNUN
         Sw2oQlFQfOuus4pzdlO0eAl9HeRR5eUewaeU1hZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRmjw-1j49R03xRC-00TE19; Mon, 20
 Jan 2020 22:57:41 +0100
Date:   Mon, 20 Jan 2020 22:57:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH 06/29] bisect: libify `exit_if_skipped_commits` to
 `error_if_skipped*` and its dependents
In-Reply-To: <20200120143800.900-7-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001202253450.46@tvgsbejvaqbjf.bet>
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-7-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8TK1TrY8tuoz4tfHzQA8Pf4GLg+Xfv/mpfev3g7nlPcSuA1cHwG
 zHEqoLxdmCFrp9+DmlXCEg3nevr7d2PrPOyzGgfFwCHQ+BU6is12tQpdn2WKbQiCpzUUpcB
 3HVoL3BUlzzDIL5TWHo8CmFy5ODpHgmhI8QxsYElzbHWqEdX6eG6IblIb7FDY/ESuiQyBsO
 IIJJXrzIdsJVy5PIAlUHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W/PBRE081a8=:W7Sn6Ym4uSQ81kc30Q/Sbv
 RujsE3ELTBXKUIbKvDr6e44G8eqlCG4f2exZBRQ/JW6cl0BjZ+HWq5twvNrB81I0F2RWzQWMV
 UCRkY6GIHY5MVExPB5DeBLe/gfuOjrbGV22Wt4t0HwuYgIVYxNCnE17ChW+5eOaPNV4l+Tc8s
 ibU/ktQEg5ce4ddOdWDOEe2tPus2nGav5W+8D6zCsPldn4N9SmPiPS4vMxXQJLZwiX6OLs0JI
 J4geZCf2h6ynY/DajtUuHbREkX/qavO+KzJnZIm94+JtH67x8cPH2owEXGHrAkdRK/MTL/wlB
 Lk/Bwp0vUqGOquFnyiEKXcvp9ayVMesukH9z6Nyor25d/8IrNdk8V6lG6De0ukDYEga+Whk52
 NAKBHwrAETWsR+2OifNvW/UXu8mQXKtgfGqkHoigSeP6XNkCKOyBlaqqaIxwAqCGkMhFNKksi
 2k3SifUwa0yPlv4ClUCckW9CaMoZzIVocv1ya4dGNe36mdxo1ms2/zZ0Y+kWVJceTxYSbMqTk
 pq2ipvdq9yMCn/JRlxkmGpgUVFc9t4yvzJ3drd/sO2Nb+9ubH+55m+IgpZ3jpKgVDmg8B+dx3
 Gbs2Tag/zfsttGyEJf52DHBTSQtstZj/ga0Lw2hTAtRo17wtIsix3eWDEhzPMWdNpGLV3oKGC
 01+176br1u+RfCk5bk7lNM9QeW/xiOtvuGkaA0oAXgBnB5Y9Y3A4l/hnJwtasopYeQJ9qLRqp
 bHnmHhIPEPEokSvbpqcsRdAzCQ+o3I2rmI94VYyPdYlBtPysEB0s/cSumT75Lr2fALlJiy+wS
 SMQlmhrA+e1Uk/BzZ3KH7z0P8j9GA+Q5J/R42i4GcM5Lk4XV/TNf9amuZW7NvYpfADOvMfXw9
 H+bUhuBCi1afuWjDHw6l+V6BcgimOfjFgXw841rhpzXWOxk2NNT20oGj49jPs0TB6tw0xE99x
 Uv57ZsrRx4AmohOrvYOG7ONaPfRNI/DRpONzMcQekllSKTOdfmW45qCJBoVLcRRS9CaMkVazS
 zGodF1IaSw17xBMkSfGnkg6XUCBYO5U+M9rcfkKwDAJxcMoVIP27xATcKnQObUXbIL0O2DrSz
 TGj0s6I7AV9802v3scXOkFogxxMKUID+C2aMHb72XR4LrFwaergZ9eTyN6QGtxI4DfNf9W7Md
 iqLp7f4W9Rj7VjPyVdvmFwbDgU5rOy+354VUrbpjza9zUkMGGg4G4al4xlE10oqtkEy22fce7
 aTrgacrPdvW8jrCyKv03NJT05jRp2DNvgxOJ9TPNGso/waDQS1k1B95Orkjk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Mon, 20 Jan 2020, Miriam Rubio wrote:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Since we want to get rid of git-bisect.sh it would be necessary to
> convert those exit() calls to return statements so that errors can be
> reported.
>
> Emulate try catch in C by converting `exit(<positive-value>)` to
> `return <negative-value>`. Follow POSIX conventions to return
> <negative-value> to indicate error.

Good.

> Modify `cmd_bisect_helper()` to handle these negative returns.
>
> Turn `exit()` to `return` calls in `exit_if_skipped_commits()` and renam=
e
> the method to `error_if_skipped_commits()`.

I would remove these two sentences, as I deem it obvious from the
rationale above that this needs to be done, and the patch repeats it.

>
> Handle this return in dependant function `bisect_next_all()`.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  bisect.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 83cb5b3a98..2ac0463327 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -661,11 +661,11 @@ static void bisect_common(struct rev_info *revs)
>  		mark_edges_uninteresting(revs, NULL, 0);
>  }
>
> -static void exit_if_skipped_commits(struct commit_list *tried,
> +static int error_if_skipped_commits(struct commit_list *tried,
>  				    const struct object_id *bad)
>  {
>  	if (!tried)
> -		return;
> +		return 0;
>
>  	printf("There are only 'skip'ped commits left to test.\n"
>  	       "The first %s commit could be any of:\n", term_bad);
> @@ -676,7 +676,13 @@ static void exit_if_skipped_commits(struct commit_l=
ist *tried,
>  	if (bad)
>  		printf("%s\n", oid_to_hex(bad));
>  	printf(_("We cannot bisect more!\n"));
> -	exit(2);
> +
> +	/*
> +	 * We don't want to clean the bisection state
> +	 * as we need to get back to where we started
> +	 * by using `git bisect reset`.
> +	 */
> +	return -2;

This comment is a good indicator that the constant `-2` here is a "magic"
number and it would most likely make sense to turn the return type from an
`int` into an `enum` instead.

>  }
>
>  static int is_expected_rev(const struct object_id *oid)
> @@ -949,7 +955,7 @@ int bisect_next_all(struct repository *r, const char=
 *prefix, int no_checkout)
>  {
>  	struct rev_info revs;
>  	struct commit_list *tried;
> -	int reaches =3D 0, all =3D 0, nr, steps;
> +	int reaches =3D 0, all =3D 0, nr, steps, res;
>  	struct object_id *bisect_rev;
>  	char *steps_msg;
>
> @@ -972,8 +978,9 @@ int bisect_next_all(struct repository *r, const char=
 *prefix, int no_checkout)
>  		 * We should exit here only if the "bad"
>  		 * commit is also a "skip" commit.
>  		 */
> -		exit_if_skipped_commits(tried, NULL);
> -
> +		res =3D error_if_skipped_commits(tried, NULL);
> +		if (res)
> +			exit(-res);

So we still `exit()` in `libgit.a`? I hoped for a more thorough
libification.

Besides, the `if (res)` probably wants to be an `if (res < 0)`, right?

Ciao,
Johannes

>  		printf(_("%s was both %s and %s\n"),
>  		       oid_to_hex(current_bad_oid),
>  		       term_good,
> @@ -990,7 +997,9 @@ int bisect_next_all(struct repository *r, const char=
 *prefix, int no_checkout)
>  	bisect_rev =3D &revs.commits->item->object.oid;
>
>  	if (oideq(bisect_rev, current_bad_oid)) {
> -		exit_if_skipped_commits(tried, current_bad_oid);
> +		res =3D error_if_skipped_commits(tried, current_bad_oid);
> +		if (res)
> +			exit(-res);
>  		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
>  			term_bad);
>  		show_diff_tree(r, prefix, revs.commits->item);
> --
> 2.21.1 (Apple Git-122.3)
>
>
