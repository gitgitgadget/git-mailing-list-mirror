Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C13FC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB1160FC1
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 18:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbhIMSf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:35:57 -0400
Received: from mout.web.de ([212.227.15.3]:39167 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236549AbhIMSf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 14:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631558076;
        bh=GRfBD5KvrH26CPBg3hUP0pJ0HrzAfuGLReFo8dUJ8es=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ksIuSTw3L9lojIXt9VoeVYbCdgJnXt6EaEwb99US8ob8AnqE7CDysRUfTHb0GJSR2
         sDz19ljaHWVQpmTQediYkf62YzcREhd28WFoWtDA2ewvycRhTjCbHaHgZ8GdTzRU4n
         SCjX5MIYPY47MgiHHMHLiEY5bC9OIqy2eow8KAqU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0M2dxF-1nFCr03wjF-00sR1m; Mon, 13 Sep 2021 20:34:36 +0200
Subject: Re: [PATCH v2 08/11] rebase: remove redundant strbuf
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
 <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
 <ad3c4efc0272be8eee052a08731656a406f8f90b.1631546362.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3c7c5560-2cae-a4cf-a298-6d77a3fb9226@web.de>
Date:   Mon, 13 Sep 2021 20:34:35 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ad3c4efc0272be8eee052a08731656a406f8f90b.1631546362.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xy8NLTUkSsYWW8pXF67onB4VKkSfesrBI7/XKUIayNViNAkl1WT
 q2MCT+9kNh/4fm9KGMXBc16fTx8ySZiVli6wBja3soHFCz7xdvvaSsG/58aeLYldJ8sXR8n
 nyjAqItRua+e1+fvs4Nt70fUX6mLq1RYA5Gdh29qZCDgG1DYSP2GLOfnHggTYD1snIzbU1T
 cVy25kzBTE8Qfzph3TrJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JCvI+vZmnDs=:JqggWckQOV4Ip/zBGs1K+r
 BJzq7QflDA8NjhX2fmdgF2gJL4+saWlFqUI95uNN0lA4jhNmceTu5nvAH+rNSeMwfDSorTLoM
 q/RYtfUtSKLi1FE3PRZzg4BgwPlaW5r96klxvyUAcBCb42PmRt/EtOcB2ajkh2RVCKv15vn2l
 Sjv24xYgTkX3LSqdi+gA9sZKRMoXc+f5qbOw0LaI5jDoa8i1F7BYvWBJD/HmaawHrXJIk9Yto
 7UYPNcdTy6Tls+rnYl9HKHAWrZtX4C2oJT1abUxXwWNMkLaNTp/HGDVLPzq+9PNA8HrUYFOKM
 6YySt8hcAgSrgYyoMXWlqLBuJUv3n/CgqfeXS43OWMkNidl9UiNrbSfncUYZMnfeQlYRj83ee
 8yLRH8WCLHvI3+35/6eXfjBtmhajpCsrWDynAqhsov+qE/srQnxJtef2eGObilSPb5p3IZuAb
 DD4EDUofT1teThhL3zVrq5SXkVG3f04DFtkvRXVMJZAql3Qwe3gwyyTMOFGYtLE2JyWVm/a7K
 LXyZ/UyJHBB3xdwXvyoSz9ZkCwX5jX9K0chE1NhAjavDCx8160kxkh/meNDtEGT28rz8+tk5X
 WX6pfpSi+NLYAFL2br8JUPIcOp3RD7kXuLv27GgBhHmL60mSJy7RUwcA0Ougj5dqrhyKFzcue
 SDULsPl75iYnNkGXqfQ/1MWg2qkZtURB6HBvnQWKlyklFPF1vicoIW2LuF2YvqYzTyWhSs8gN
 YgNLwtNX4AFbC4NX7pyWBJFurawqaK7J/FJ52RJh8Tx8Em2YnVm3pKSBepemF7G1ZJ2JjOwCD
 2AlA+8e6nQnjxo1P0UHK/pVbVFo32HajYK/TxJqKJb2EYFa4MUAjGN34d0NKRJ7ZOB26PunN4
 tDt+gqkXyCJErTmxUY1oerGSPHV20fJwweUcYBFKXAZeMy3RoDrZ8NpEMuHGNPRyDRl72YH/h
 cXqbTNwkVsT7egZamSd6P+0nOM3fKwzigopoKIjPpy2eXtHB7ydIhBbOl/7EQBCyi3MbS+v8n
 c7JrWtQO88Jkuk8Naq3/w9f4ykH10LslYNwv56utaEkHsxn3UmnVxPbrpMnE0regMg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.09.21 um 17:19 schrieb Phillip Wood via GitGitGadget:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> There is already an strbuf that can be reused for creating messages.

Reminds me of a terrible joke from elementary school: In Peter's class
everybody is called Klaus, except Franz -- his name is Michael.

Why would we want to use the same variable for multiple purposes?  This
makes the code harder to read.  And the allocation overhead for these
few cases should be negligible.

The most important question: Is this patch really needed to support
tags (the purpose of this series)?

> msg is not freed if there is an error and there is a logic error where
> we call strbuf_release(&msg) followed by strbuf_reset(&msg) and
> strbuf_addf(&msg).

strbuf_reset() after strbuf_release() is redundant but legal.

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 6138009d6e4..69a67ab1252 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1299,7 +1299,6 @@ int cmd_rebase(int argc, const char **argv, const =
char *prefix)
>  	int ret, flags, total_argc, in_progress =3D 0;
>  	int keep_base =3D 0;
>  	int ok_to_skip_pre_rebase =3D 0;
> -	struct strbuf msg =3D STRBUF_INIT;
>  	struct strbuf revisions =3D STRBUF_INIT;
>  	struct strbuf buf =3D STRBUF_INIT;
>  	struct object_id merge_base;
> @@ -2063,30 +2062,29 @@ int cmd_rebase(int argc, const char **argv, cons=
t char *prefix)
>  		printf(_("First, rewinding head to replay your work on top of "
>  			 "it...\n"));
>
> -	strbuf_addf(&msg, "%s: checkout %s",
> +	strbuf_reset(&buf);
> +	strbuf_addf(&buf, "%s: checkout %s",
>  		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
>  	if (reset_head(the_repository, &options.onto->object.oid, "checkout", =
NULL,
>  		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
>  		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
> -		       NULL, msg.buf, DEFAULT_REFLOG_ACTION))
> +		       NULL, buf.buf, DEFAULT_REFLOG_ACTION))
>  		die(_("Could not detach HEAD"));
> -	strbuf_release(&msg);
>
>  	/*
>  	 * If the onto is a proper descendant of the tip of the branch, then
>  	 * we just fast-forwarded.
>  	 */
> -	strbuf_reset(&msg);
> +	strbuf_reset(&buf);
>  	if (oideq(&merge_base, &options.orig_head)) {
>  		printf(_("Fast-forwarded %s to %s.\n"),
>  			branch_name, options.onto_name);
> -		strbuf_addf(&msg, "rebase finished: %s onto %s",
> +		strbuf_addf(&buf, "rebase finished: %s onto %s",
>  			options.head_name ? options.head_name : "detached HEAD",
>  			oid_to_hex(&options.onto->object.oid));
>  		reset_head(the_repository, NULL, "Fast-forwarded", options.head_name,
> -			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf,
> +			   RESET_HEAD_REFS_ONLY, "HEAD", buf.buf,
>  			   DEFAULT_REFLOG_ACTION);
> -		strbuf_release(&msg);
>  		ret =3D !!finish_rebase(&options);
>  		goto cleanup;
>  	}
>

msg is not released if die() is called, but that's OK; in all other
cases it _is_ released in the old code.

I'd rather see the use of that multi-purpose "buf" reduced, e.g. we
could simplify path-building like this in a few cases:

-       strbuf_reset(&buf);
-       strbuf_addf(&buf, "%s/applying", apply_dir());
-       if(file_exists(buf.buf))
+       if (file_exists(mkpath("%s/applying", apply_dir())))

Sure, this looks a bit lispy, but still better than the old code
because there is no state to carry around and reset when "buf" is
repurposed.

Ren=C3=A9
