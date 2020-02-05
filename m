Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD323C35254
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 12:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D387217F4
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 12:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PyRXqBu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgBEMtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:49:24 -0500
Received: from mout.gmx.net ([212.227.17.20]:59507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbgBEMtY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 07:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580906960;
        bh=AefgrPFRmz7EiaXZMCNcSBkqeHDMYugZHq7pZcljc/o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PyRXqBu4OiNvrNiQiaSwlUq/o8LX9bogbT0ZCrRkaND/nzm6ECHk9nh3hQ5UBdQvy
         OnlFhcFQ9fkY5u9SMe6CqqCdP/C191vLtUKFgmowHVXq8f1K3LqW9h8i5EeaG49FRk
         5LXa2vGcDYY9frcSLDd/Hk6NroN0Ok6IaL3TTp+s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTABT-1j6mMC2hO3-00UdYJ; Wed, 05
 Feb 2020 13:49:20 +0100
Date:   Wed, 5 Feb 2020 13:49:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kevin Willford via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
Subject: Re: [PATCH v2 1/4] fsmonitor: change last update timestamp on the
 index_state to opaque token
In-Reply-To: <679bf4e0dd16f7d6f4ba1f05af50cca24b5abee4.1579793207.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002051344020.3718@tvgsbejvaqbjf.bet>
References: <pull.510.git.1578423871.gitgitgadget@gmail.com>        <pull.510.v2.git.1579793207.gitgitgadget@gmail.com> <679bf4e0dd16f7d6f4ba1f05af50cca24b5abee4.1579793207.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iFz8M7TdhfJLfujA6kQ5iNKX+VtaiA84KEFn/6HvrneYLGNikhN
 P8EeY4YpxN7/gs0ayz6zDznGFLZ2i8hGzyHwOlwBe9MdNjfFW0C0sGuf1RizZcZIBcJDAcm
 3oIaVPj1siNPsSZgEsF+WykE0pMroKle1qDObZaLet3nK+D6z5fbDgIh4O0/zDSA1sHkhNm
 TsPzX9Z57oK6vTj9iJ5FQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0WknReRBqG8=:NXIYJFF/B9dnoDp5yVC5Bq
 jUbonbD/wArGzwR4HBJhUrdiTo+J260VFRJCHXW0wMvJwSKX+fWGBD47nTuMiVha38meJjVlG
 tlMW5CtgKfs7G3Hw9k87uGgtjvgIrUaS41QEbIHNnxqY1s7uAxN5GcKtsIxixnUXGMSI3mh2o
 rhAFquGt+Tp0p8UN6xz9DugWJ+xK2coaULIwO4Dx8UIdGb6J08Siz68hB04PjULY5N4/e6Izt
 XbNTayGwY3uvKFqD85x8FIqxaDKMW1dzSL9GuKO2o2B2IxV6ENljHxn1XtbCFaU4T89a5yz2n
 IoQh5UQLVSu5xk//poRr+Fql1Y4lMI0hrrJcH8F0YZTJ+HUzKzXlyJl7IoICjP1QUGBEfG2Fg
 POdics4pxErkD/42VqgZ9q2NKNq7vnFLDoqEEuD7on5gtwuy2SCVM2onpWw0TdzvAOh85KbkB
 AfDBZvaY0IJlqz2NFZ5nEuo+8MQ0gxDzHHfMHz3Ow8O5F7Jypk0RsWmfn/cpbh/Ezu57+MxOZ
 2KwPPTlTaDZcrp3utBZKnqK3l0XHjxm40fXj4d0FJJTD/c7QyC8MEw6ybU27mTD46Wk2887av
 /B0+hqkSX+yslsBp3rVhr9RUrIBkLSe8f9i6p3bp2qyHPnUI9nXgsTv9SBYbQCMipXvkEu4Lq
 TiNs7jfORO1uzLnXBXblVc2nXgbkI7FSA2f/r8NlHMZ2aFTz9nOLbJSCC3strDBgRopVDSk/S
 HCjBIVOorEc4AtYnkPkmKEI/HcnI5KukVYBjEIRrdVdXgrQ4XoRzv98LbDtEGZSs2SdklRAUK
 PBjvghVrwGVxHfsNFd9H4gMOFlxZfIvm+eLg8ioToNAErxWlsw9XMsPKPYP8uRu3S7cKAmcud
 YafKYET09uNktuyp8/OfJ0bDxpBh3mk0DQHapaMb6/SiuxHFcZtNqoMlH/Baak8ZWN03K9f5G
 /zv6k+HIB9ezYeqzY+m4NuDWthby2WGYGRSiwNBy9nR2IjThbuW3lndXJFQsE4OuW9vLTV2Mw
 RNXKrQNGnCtx3yjRQk1M1cesIx6jHVrY4U7DBkkVzxLweC1z5olkR0nTSvBDrZB1dao/+HtxW
 qqivaFbRbfydmgpNDRxwenCQyl8WxLnrdBjCUmTDlQq7COZWvGkdutv+89iAmZbQTHQeqck7g
 NJIleEj0s+KngHWwDEfv44p6euEcHZW4xGm5CuyEHbHQm9EEMYSJuhBM2y++i7EUsnbcFqf6K
 4tUgUu+JlkEsrggvc
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kevin,

On Thu, 23 Jan 2020, Kevin Willford via GitGitGadget wrote:

> diff --git a/fsmonitor.c b/fsmonitor.c
> index 868cca01e2..9860587225 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -89,11 +98,12 @@ void write_fsmonitor_extension(struct strbuf *sb, st=
ruct index_state *istate)
>  		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u=
)",
>  		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
>
> -	put_be32(&hdr_version, INDEX_EXTENSION_VERSION);
> +	put_be32(&hdr_version, INDEX_EXTENSION_VERSION2);
>  	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
>
> -	put_be64(&tm, istate->fsmonitor_last_update);
> -	strbuf_add(sb, &tm, sizeof(uint64_t));
> +	strbuf_addstr(sb, istate->fsmonitor_last_update);
> +	strbuf_addch(sb, 0); /* Want to keep a NUL */

I have a slight preference to use '\0' here, which my brain somehow reads
as `NUL`.

> +
>  	fixup =3D sb->len;
>  	strbuf_add(sb, &ewah_size, sizeof(uint32_t)); /* we'll fix this up lat=
er */
>
> @@ -110,9 +120,9 @@ void write_fsmonitor_extension(struct strbuf *sb, st=
ruct index_state *istate)
>  }
>
>  /*
> - * Call the query-fsmonitor hook passing the time of the last saved res=
ults.
> + * Call the query-fsmonitor hook passing the last update token of the s=
aved results.
>   */
> -static int query_fsmonitor(int version, uint64_t last_update, struct st=
rbuf *query_result)
> +static int query_fsmonitor(int version, const char *last_update, struct=
 strbuf *query_result)
>  {
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>
> @@ -121,7 +131,7 @@ static int query_fsmonitor(int version, uint64_t las=
t_update, struct strbuf *que
>
>  	argv_array_push(&cp.args, core_fsmonitor);
>  	argv_array_pushf(&cp.args, "%d", version);
> -	argv_array_pushf(&cp.args, "%" PRIuMAX, (uintmax_t)last_update);
> +	argv_array_pushf(&cp.args, "%s", last_update);

Maybe `argv_array_push(&cp.args, last_update)`?

>  	cp.use_shell =3D 1;
>  	cp.dir =3D get_git_work_tree();
>
> @@ -151,6 +161,7 @@ void refresh_fsmonitor(struct index_state *istate)
>  	int query_success =3D 0;
>  	size_t bol; /* beginning of line */
>  	uint64_t last_update;
> +	struct strbuf last_update_token =3D STRBUF_INIT;
>  	char *buf;
>  	unsigned int i;
>
> @@ -164,6 +175,7 @@ void refresh_fsmonitor(struct index_state *istate)
>  	 * should be inclusive to ensure we don't miss potential changes.
>  	 */
>  	last_update =3D getnanotime();
> +	strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
>
>  	/*
>  	 * If we have a last update time, call query_fsmonitor for the set of
> @@ -217,18 +229,21 @@ void refresh_fsmonitor(struct index_state *istate)
>  	}
>  	strbuf_release(&query_result);
>
> -	/* Now that we've updated istate, save the last_update time */
> -	istate->fsmonitor_last_update =3D last_update;
> +	/* Now that we've updated istate, save the last_update_token */
> +	FREE_AND_NULL(istate->fsmonitor_last_update);
> +	istate->fsmonitor_last_update =3D strbuf_detach(&last_update_token, NU=
LL);

I see quite a few `strbuf_detach()` calls in this patch, and could imagine
that this is a good indicator that the `fsmonitor_last_update` attribute
of `struct index_state` could be a `struct strbuf` instead, that is
`strbuf_reset()`ed and `strbuf_addf()`ed to, rather than having the
strbufs as local variables.

Other than that, this patch looks very good to me.

Thanks!
Dscho

>  }
>
>  void add_fsmonitor(struct index_state *istate)
>  {
>  	unsigned int i;
> +	struct strbuf last_update =3D STRBUF_INIT;
>
>  	if (!istate->fsmonitor_last_update) {
>  		trace_printf_key(&trace_fsmonitor, "add fsmonitor");
>  		istate->cache_changed |=3D FSMONITOR_CHANGED;
> -		istate->fsmonitor_last_update =3D getnanotime();
> +		strbuf_addf(&last_update, "%"PRIu64"", getnanotime());
> +		istate->fsmonitor_last_update =3D strbuf_detach(&last_update, NULL);
>
>  		/* reset the fsmonitor state */
>  		for (i =3D 0; i < istate->cache_nr; i++)
> @@ -250,7 +265,7 @@ void remove_fsmonitor(struct index_state *istate)
>  	if (istate->fsmonitor_last_update) {
>  		trace_printf_key(&trace_fsmonitor, "remove fsmonitor");
>  		istate->cache_changed |=3D FSMONITOR_CHANGED;
> -		istate->fsmonitor_last_update =3D 0;
> +		FREE_AND_NULL(istate->fsmonitor_last_update);
>  	}
>  }
>
> diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonit=
or.c
> index 2786f47088..975f0ac890 100644
> --- a/t/helper/test-dump-fsmonitor.c
> +++ b/t/helper/test-dump-fsmonitor.c
> @@ -13,7 +13,7 @@ int cmd__dump_fsmonitor(int ac, const char **av)
>  		printf("no fsmonitor\n");
>  		return 0;
>  	}
> -	printf("fsmonitor last update %"PRIuMAX"\n", (uintmax_t)istate->fsmoni=
tor_last_update);
> +	printf("fsmonitor last update %s\n", istate->fsmonitor_last_update);
>
>  	for (i =3D 0; i < istate->cache_nr; i++)
>  		printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) ? "+" : "-")=
;
> --
> gitgitgadget
>
>
