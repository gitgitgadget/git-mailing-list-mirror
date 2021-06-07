Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34BCC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 21:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EA861182
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 21:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFGWBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 18:01:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:48149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230359AbhFGWBP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 18:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623103156;
        bh=Da0e9p5odPyDPTiEAH52uyo1iXjYGRxq2Xu2hLLUP14=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UTk82jXSLeIyQ4cgB1AezEgsnZ8flKR/cvZWfwNF9CzYkMPxZ4gzxS08tPOsrkJvJ
         pS0tiuPmF7yQbNR8lSs7SZLkx7rQUoExCPCLX165+iNTQy/wBsqmXw7htqL2Zw6Qfv
         uJjEHyFOedkZnqwYnNGr/zIwqEEoIUTdosfcdmnU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.8.58] ([89.1.213.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNh7-1l93Ai44Vj-00hwpk; Mon, 07
 Jun 2021 23:59:16 +0200
Date:   Mon, 7 Jun 2021 23:59:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] remote: initialize values that might not be set
In-Reply-To: <pull.974.git.1623069570553.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106072355110.55@tvgsbejvaqbjf.bet>
References: <pull.974.git.1623069570553.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PknDa1EtNiGUMQRyB/tAvkM7glHUsMXE1HPwyYRNKCQvitqAEiU
 JLNwe/O+Mlb5MLmmsnNpvB3HPo2erthrVMIN112DHPCq3D7cjHSqLf99Tv7s3ygn4WQR2Lm
 Pur19hbwFgEVb61NmSKMgXJsb/hOG+f8OE0BpS5251oHAyy9E9kWc4p8PCEG6zK+7wZUGSh
 5zd3ZgC4H6IxAdP8MmGYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S3lbp5UMVqU=:Iu7gNiFBETz7H0CEuEWwQP
 A1yj+T8ootMFyGBFgN37EZmJ5tJ8DfK5tx9tg9pPeeRo81hi+8FF5+eqwYaxO+ZzkAOvoFO0h
 qlnfs8Y4FVYBmeuNaIlfi5FyND2+ArKseaaqJ2BbQy18sp1fLd60u67H9irWD5BjD2u4DDSex
 Jh3JpEUfM3Ind8abAeapau7jF9XZ1ez0l/e67S38U4HVQma9gn3R9MZVtykBk66JzHR8j1ceX
 0FcuTyO/yD5nfvCIFf6JHu0gzC61KTW8ZtbXXRUx/Jq4uCpXPEny4sPu7uaHdw8iHZREQtBkl
 Ec6CnhfdeQkPoDZGw8ytMNFSqNwFCPzxcdcgk5i1l+dCLSuU2bEtIZjJV9qwPToqHuAxxBUAG
 fvrrfOZcy71MDjXEKLa8i3ifRPQu6eVHUjgZInE6kelop9xohsTYEyU4tCMrdxJjE0Q2TyCdP
 h+Y7uutCiq1R+o5eOWaUPTfoGebehfqm5Wu4YlN+M4RlYi7SxpLBmQvWOiV2MLVaEK+uSwi6d
 UpO80N0rSHWoTKxr7QPWjBNRP0bKbYoupW2MPXVtygq7WJ+F1q8pbJR3HvUKaV2HzHJlQgHJ/
 y0JKVHBUbs2ckIgwtigWmwtTw/pPkkQeyNzl+tGE+RI3dAuUM+LZ9DJcH3h8oTNGZ7EBkzE54
 e1se6AgV7yeM9N9S9GHCEypIY7k7VIPL7dj+id/rYGGSNMeJUzYufqHQHsezgW0alwPt4O+7Y
 KB/7eMNVNYPw2bnS1j5Pyc3wag9x0wjH7L7CpuEvAtn9Pnce9eRkCtyq2vPLfzrE1WYJvw/iK
 if2LwxcKlxOODDsCFDvjNTNO1TXr1w12NfdVhtOIVUffIhr9BAGXxWUY4YGCFc/JIor4kxXtP
 dtCDHGFqLg1YqN3MCtJo71mmMf/msxVmfBjXoZEnkdFQmnxPnhdeWx5XmOsEzYP1jcFnVbHoZ
 1Y7XEfOyoaetLdHnyakaWTSzdatKHOFtzTmm8VbFGQ0nUriY4BhmfxKj4DCdBIZowooDhLQW+
 IA+avfr5Le2YcAUR6SbWYAjus+CLkL+nZHL70a67h1uly44J+ojhu7Hibp0+sP17rJovDEHH3
 nXwp4auhR9pSP8CRd5Wo9AP2twr6v/2lNE9Ug0PVFmCybB8B0JLrx0CPQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Mon, 7 Jun 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> I noticed during an unrelated test with Valgrind that these variables
> might be left un-set by stat_tracking_info() in some cases. Initialize
> them so that a later branch upon their value is consistent.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     remote: initialize values that might not be set
>
>     A very minor fixup.
>
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-974%2F=
derrickstolee%2Fremote-uninitialized-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-974/derri=
ckstolee/remote-uninitialized-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/974
>
>  remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index c3f85c17ca7c..a116392fb057 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2101,7 +2101,7 @@ int stat_tracking_info(struct branch *branch, int =
*num_ours, int *num_theirs,
>  int format_tracking_info(struct branch *branch, struct strbuf *sb,
>  			 enum ahead_behind_flags abf)
>  {
> -	int ours, theirs, sti;
> +	int ours =3D 0, theirs =3D 0, sti =3D 0;

While I like this change, I am somewhat confused where the values are used
for branching. The only time I see them used when `stat_branch_pair()` has
_not_ initialized `ours` and `theirs` is in those `trace2_data_intmax()`
calls. Otherwise `sti` is set to -1 and the other users of `ours` and
`theirs` aren't reached.

If my reading of the code is correct, maybe the commit message could be
adjusted to talk about tracing instead of branching?

Thanks,
Dscho

>  	const char *full_base;
>  	char *base;
>  	int upstream_is_gone =3D 0;
>
> base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
> --
> gitgitgadget
>
