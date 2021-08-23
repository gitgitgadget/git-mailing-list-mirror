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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1219CC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBD06126A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhHWNXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:23:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:53769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235813AbhHWNXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 09:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629724944;
        bh=vjF0MZU4fybLc066XPNk4kqzQpoPbdTc0cInBOWiY1Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=F1POi+g36sRrasMgFZcqDZ1eTRBEfSXUP54UnU8VukeSLxJoEXH6Mva5tf2bx5k4e
         fGg4QtrcIRzyR6itZIs54DZnORvXrYVfSVBJ6kSPx9OGCd42XaKIo56xqcFlIFodmP
         J3ACWLzoXuhGEd8oSUZ0ND9YqBe+WFI8RHGgS1qM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9MpS-1n5Zhc2E3I-015KMY; Mon, 23
 Aug 2021 15:22:24 +0200
Date:   Mon, 23 Aug 2021 15:22:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        newren@gmail.com, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] sparse-index: copy dir_hash in ensure_full_index()
In-Reply-To: <pull.1017.git.1629136135286.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108231521320.55@tvgsbejvaqbjf.bet>
References: <pull.1017.git.1629136135286.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4089dmfTfok4bFBxJwYJL6kqmmUi4Ez+4ABhoBY7tEZ0FzT0vdn
 hwW5fy26zF9Fh7jAm+ObMqTM1cg7wKaw8SBz+mRh0RrIakGSdMYoG+gz25rzKLPwCipJTVb
 sgOWpbMZx/9D/3J1CI/0LjCjv5K7qj8z7ZCFRwXZTzO58vSHh8fqq+sXRg0ZPbaTy1xdlSs
 UubBgxT9MtqZiGKBEw7wA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MXUbpLv1itQ=:hAI0JD80Is7U0qs8peFtTJ
 1grKGJVBRpmj6yvKs8k0EnTjHhmPSIicRN3u4zsxRHmKGIkuSdb/axnnWPsDjleioGpvyRN6R
 bYVrVhPq2moeWTfJjPL9qhB2Vs+pa1jVvlxi6B9goywzhoSoZHWy9EA2uE6225F8st4RLnz3P
 KTk/nbFc50HxfTdhYCgiFDFyzpFZlemUhbEGqCu+S0nMHswp8bVAuNuFKoAa/fauBEZ4k/GLU
 DkgunoOU5Z1hJ55iqKTIojnzS5vRO3BESKOnWeTg5waPGoxkyhxl9Bgn496rkYT7P1MrlgPPx
 TwtUaWBt3GP/66/rgou3PztovWCb+cndPp/cfybr830excTrrVUixHJ5R6szJEtsFOi4nXuWh
 jR2I6+jFexUHGV60QaaAI9ztAF+oxzRCwxkqeyMfPXDD3Sbi/jvhH2WJyRPxIgbnlMjlv8ptC
 R89XxALnJgGYqvaoSGLB2XKHsFbrORsfxkJSGJQbKSPIaJOjhUs1EoVWgS97QY4VGzJvgfPXd
 QY4jG+KQimx3UH7Qi+D5a4maZJ8aNtCESu9bvZ2JkI0aJ1luEAZRbf1QoZwPbkuF6gF5h4UAV
 Bt31J0mW8N7NJSwo6jad17iCeFoIDflv5qn2lhnJnI8lVzgT46psmBr0PQIp7C/+ZoyHJQIMV
 kvVF02gucOloRI3wkx5hX2Pqg5U7tlfdTy5YgRE+Z87hDq/YU3PIgJMT3Rwu1jyE9HrJsaShN
 jNkpIBCQWBhJQaPiWI3MugDmYp+gT6JQF4pEFJmUM0V9EAiU8Xi6UI0tAyO7PyWlfFsR1ZTSe
 rnkwMrCGocLtBPxAa7eu1pHZKCNnuP9vXi9qsSD4sUcKzeDtualxVvHdXTia4BLSdvEb2ba1I
 DIxtCVEVuvR5gGbGQ6GVxuwoDXNakckkFwaUvPThPgK2rq96I62PWkqInEg83JPiqXAADw1kS
 3sOAbUI94JscBmq13dBPoHkSfpurfZLsjWpJErycgGlIwf50yL1ly/mVURzQ4tXDSO1CPY4gd
 vFC9h2DX9UIgXa23hTXe4oXUrPOX+wm8NQtr/Idze77O59mzj5cXSCZmKt0sTdF3D1Lroa4Uv
 dEFYcB6T1W2dCBAtu1ep27KxLUMrDyWVzIs+XveMnqslpNHLRAYGLqcRA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Mon, 16 Aug 2021, Derrick Stolee via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Copy the 'index_state->dir_hash' back to the real istate after expanding
> a sparse index.
>
> A crash was observed in 'git status' during some hashmap lookups with
> corrupted hashmap entries.  During an index expansion, new cache-entries
> are added to the 'index_state->name_hash' and the 'dir_hash' in a
> temporary 'index_state' variable 'full'.  However, only the 'name_hash'
> hashmap from this temp variable was copied back into the real 'istate'
> variable.  The original copy of the 'dir_hash' was incorrectly
> preserved.  If the table in the 'full->dir_hash' hashmap were realloced,
> the stale version (in 'istate') would be corrupted.
>
> The test suite does not operate on index sizes sufficiently large to
> trigger this reallocation, so they do not cover this behavior.
> Increasing the test suite to cover such scale is fragile and likely
> wasteful.

That explanation makes sense. And as the finder of the symptom, I can
confirm that it fixed the issue. So here is my `Reviewed-by:` ;-)

Ciao,
Dscho

>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     sparse-index: copy dir_hash in ensure_full_index()
>
>     This fix is an issue we discovered in our first experimental release=
 of
>     the sparse index in the microsoft/git fork. We fixed it in the lates=
t
>     experimental release [1] and then I almost forgot about it until we
>     started rebasing sparse-index work on top of the 2.33.0 release
>     candidates.
>
>     [1] https://github.com/microsoft/git/releases/tag/v2.32.0.vfs.0.102.=
exp
>
>     This is a change that can be taken anywhere since 4300f8 (sparse-ind=
ex:
>     implement ensure_full_index(), 2021-03-30), but this version is base=
d on
>     v2.33.0-rc2.
>
>     While the bug is alarming for users who hit it (seg fault) it requir=
es
>     sufficient scale and use of the optional sparse index feature. We ar=
e
>     not recommending wide adoption of the sparse index yet because we do=
n't
>     have a sufficient density of integrated commands. For that reason, I
>     don't think this should halt progress towards the full v2.33.0 relea=
se.
>     I did want to send this as soon as possible so that could be at the
>     discretion of the maintainer.
>
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1017%2=
Fderrickstolee%2Fsparse-index%2Ffix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1017/derr=
ickstolee/sparse-index/fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1017
>
>  sparse-index.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index c6b4feec413..56eb65dc349 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -283,6 +283,7 @@ void ensure_full_index(struct index_state *istate)
>
>  	/* Copy back into original index. */
>  	memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
> +	memcpy(&istate->dir_hash, &full->dir_hash, sizeof(full->dir_hash));
>  	istate->sparse_index =3D 0;
>  	free(istate->cache);
>  	istate->cache =3D full->cache;
>
> base-commit: 5d213e46bb7b880238ff5ea3914e940a50ae9369
> --
> gitgitgadget
>
>
