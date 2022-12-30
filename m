Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEDBC4167B
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 16:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiL3QRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 11:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiL3QRM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 11:17:12 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8701C12C
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672417023; bh=z2JQV2d1gamyKS1gLL+vAPAOtXjzZPDsz0tlsQe7knM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KeAgF82FIH6KBhoJrVkJ1GG87bKESRJBWpvKV5Ht9w3Rqs5VFPG3Su23kh5Ho8pP/
         GMPHea8x+FQQKLKmIyqkUg+G9XjBFSGaBw8MwZZoj/CT5cku6arUhQsrtiBELBpBe9
         IZdJvcT+XA/x97VeyI5d4RW7acUHW/OsvtgSbxQD3SaVb/q5Og/oETT9zSp72Avfcl
         c4I/QqPsNZjHff0R07ilgR5D4LvMlf+D333PrBuRczgxhzOfzjIUNbroRHtwvyQXJe
         o1UjDhScr6clgbPsQJGHBNmgscGsp9YLsymoLYgZwnJrkQlI06X4bzQf3mZLNl2sUr
         7sxfZJrQaHbvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4627-1okrFO2FRh-00zcoj; Fri, 30
 Dec 2022 17:17:03 +0100
Message-ID: <755d84d5-62f1-4f4e-ff31-4604c0dca0a9@web.de>
Date:   Fri, 30 Dec 2022 17:17:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 15/20] connected.c: free(new_pack) in check_connected()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
 <patch-v2-15.20-d5210017cab-20221230T020341Z-avarab@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v2-15.20-d5210017cab-20221230T020341Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PobBHhL+rTxBAS1FCUopmkxoQt3wgjdGhJQtmbHYvF6F5r0il4g
 HEEI2vsoZLaWRub4jJN6Nbvr+7pqL6pNpzpagi5rB5B0+zn985t5J2Zw2wDZEorEMvpn4nc
 DGOECVhS9la+crNPxjLIcyszO1doq6NkTA21XQjklnZlTsDBjf9OJBkRfOSdw32kdvRJfn4
 36DLaVCKjqxn3FPSn8f8w==
UI-OutboundReport: notjunk:1;M01:P0:7/Lmy2vYz1U=;2v35iMRYj3uGdjsRLTqFeDCA/Ih
 A3T2/WTMRFKkGFIOOU5cLTY+f7fK2xeI7NIgGF8vDNPRSEhopUuPhmgODOKieJJzZIxrPqmvx
 +KiyFPhJl4/O8t3Oe+cZeeBM1TJIpYPss/0k4D/XNCF8C9L3OUofojAa5H/CXbcUxrwOmltRS
 NdUmzys5bUYVeJt70Iurxh5VqRZvha+SJmRAvia7M3sTLuw53rJdtzbaYmygYiWwrTGYb81MZ
 GZAUv7iVg+jWsCh+hiDfXhNMYYr406TsEsAqjWB0jqrGbS9fgnE9BpuvLs1Gv3uGpDF1leG2n
 V8ov29qPUBoZgwkQlsiMVP2ftGE6T1vDIt1hCrfjr0Pg6MT31ltRwJyD7vOCJPnRnTIeeI+40
 QS3ZxH2EU7wPsrWKvBV+hYw9oWgAlkW4AquYDVO2ecB3boyxK6K4729Qc4YFgdy6kWnZiaLix
 EqKrECA87Axvl8cSFCN5CDowbQj/TUWSqtTv06cB3taG9hU43GF6+eBgfCiWgnr9ytuAWFRGJ
 0j0sZKLBnkdNnRFkt6tooPPE+KaKQP9B212cq0BkgVmYBxqGQuBhIshOGqUDY5gsbW4be3DcI
 +WWx1U0SUFIk8iov7VCOGTsjfZ3zQrwW4GqQ5xl2FmUi2+8u9fFlVtw5EQfs11qHO6VAsccjG
 PZa+0UMO3xDYs46Lz5xsHGNcFTYvwAZB0JsUYvPmXQ8XQFQ/yAXR3B2zyXCEtEwWbHyjU+dVm
 A5jb7dc+d3aBCT6mXV04MFC/XyDAmSnMJ8EbaknEu/bViBzSlrt0Y4luOYwlFdZFmSfF4MlLy
 X9Bbh2wKAr3YXSMnS07L9b/1i5F8X9Kl/DU03au3RznMfmFkSXirS/yHmtR+Cg8zcZNrFbXxI
 o3IV7yfaFJz9N2VGQRVt5sutTYfQmIlRIM2iRYA5R6qlSDFQ7SBhrW6N27T6jC1Z+JWkY6DIf
 MBW51w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.12.22 um 03:18 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Fix a memory leak that's been with us since this code was introduced
> in c6807a40dcd (clone: open a shortcut for connectivity check,
> 2013-05-26). We'd never free() the "new_pack" that we'd potentially
> allocate.

That's obviously not true because the patch removes free() calls for
it, so at least some execution paths were already cleaning it up.

Taking a closer look, though: Is there a leaking execution path
without this patch at all?

   $ git grep -n return connected.c
   connected.c:41:		return err;
   connected.c:89:		return 0;
   connected.c:127:		return error(_("Could not run 'git rev-list'"));
   connected.c:161:	return finish_command(&rev_list) || err;

So there are four returns before.

> Since it's initialized to "NULL" it's safe to call free()
> here unconditionally.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  connected.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/connected.c b/connected.c
> index b90fd61790c..e4d404e10b2 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -38,7 +38,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  	if (!oid) {
>  		if (opt->err_fd)
>  			close(opt->err_fd);
> -		return err;
> +		goto cleanup;

Where are we?

   $ git grep -n new_pack.=3D connected.c
   connected.c:29:	struct packed_git *new_pack =3D NULL;
   connected.c:53:		new_pack =3D add_packed_git(idx_file.buf, idx_file.len=
, 1);

After new_pack is initialized to NULL, but before it is set to
point to some actual pack object.  So no free() is needed here.

>  	}
>
>  	if (transport && transport->smart_options &&
> @@ -85,8 +85,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  promisor_pack_found:
>  			;
>  		} while ((oid =3D fn(cb_data)) !=3D NULL);
> -		free(new_pack);
> -		return 0;
> +		goto cleanup;

free() removed, no leak before.

>  	}
>
>  no_promisor_pack_found:
> @@ -123,8 +122,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data=
,
>  		rev_list.no_stderr =3D opt->quiet;
>
>  	if (start_command(&rev_list)) {
> -		free(new_pack);
> -		return error(_("Could not run 'git rev-list'"));
> +		err =3D error(_("Could not run 'git rev-list'"));
> +		goto cleanup;

Same here.

>  	}
>
>  	sigchain_push(SIGPIPE, SIG_IGN);
> @@ -157,6 +156,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data=
,
>  		err =3D error_errno(_("failed to close rev-list's stdin"));
>
>  	sigchain_pop(SIGPIPE);
> +	err =3D finish_command(&rev_list) || err;
> +cleanup:
>  	free(new_pack);
> -	return finish_command(&rev_list) || err;
> +	return err;

free() kept, no leak before.

And that's all four returns.

So there is no leak to begin with here, or am I missing something?

>  }
