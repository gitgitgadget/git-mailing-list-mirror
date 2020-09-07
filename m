Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA42BC433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 19:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6127D21532
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 19:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PhyCpPSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgIGTpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 15:45:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:56455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgIGTpW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 15:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599507919;
        bh=H6a7QdsngkciK5P/rCejcIu0/zxvl2aeAWuD+SpwPgk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PhyCpPShrKxFKjMilncjKLwxOTfLYGuQPd77g/dTzJEDwEVG8VkCrPdGKnXoiNLzL
         RSwzuXQN3lMzissJotYR/8Lzd3rK0OgB3ByWj/eLgrFko9Xd0Lu9y3R0wocLX/BLVn
         hO5tLOkXTaMJTzzBh40dVfhw0XVRSAD3rWdxWq6s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.215.223]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsIv-1kVWRs2dPj-00szCM; Mon, 07
 Sep 2020 21:45:19 +0200
Date:   Mon, 7 Sep 2020 21:45:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
In-Reply-To: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OuTs9hy78vFL0swY93eh2T35mx9s0kNgdyAD+vGaJ/KDLVFaSyj
 t2D8Vpetq9gGL5TMNGloX1r5yT08r5hcd8RRXa8kaIEv3G3MslqLWiQxVhN0gytTSMUWL0S
 0O63Lg+FxDNnvvnpSrd4j2+HCcAXpyt8fxt/ETPisBcSx17+xvlaiVlawanQQq9F20NWaHe
 +d+ELdixpldirVwPh+D2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rjW9jh7poQs=:CFTiF3jCKU+r+FSzbkTLoE
 oTKFiZbQPEWfMUFJ57kOAqEfRehCqqrvwmWMz1MZlWf321MJgsYtBm7LFJD2d7lJr9cdAfRCz
 hPTlDj4q3+YlbpkoAVqpgXaJpHfmF7uHEIQXNNcDZnw/GgxdXUtWLk2IAUUECPQIHnXJu1Ua5
 SaP68E8EbOTTFEShM/PrtnAPfDesVv1/+UoU84MDbo1S6B2A8iJHYyf0743c97QPHCF8GSAnh
 komhtCodkiJRL+XEV8WGq9eqpDTinUBoBym8O/Q4nCJOUfsHr43tNA6MmbYEYgm3w8rPXfDSh
 tFK2S1W5A6HfR1xl3vZcnO8vBQ1TqjRtOroV5GTfJhX2bVdSD9ACx2S+adSi7N2udfYzSA1LF
 ZYFgiu5PmRLODxX3p42v+iUbMuj9Ur+ukpy9FRLsUlZ5deDuQGwPDmQBvQWK5gTUJ7wkBfK+D
 fo+hF+6GucYKxTcYDw5I54DkXFnc7B5P9V/8tAHPRGlC1EIwR4oajBdxGNss6zU2NggoTWtME
 teiHuFomv3ev6y48HmTEGoUgwGs3NVqPYTOKSO7t6sTaIPu5Or/GnjFRHWjrIYwUHewzyINud
 rKHAHLwRISn3rFf1md/e9pee9e/eubWosTVliYXlaphNZvwm3hYbLqV0zhq77s5qIRf2L+m/p
 1hYfv2c3T2T7aLLE8OLjGbDCTSCuNB1hdt72rtNi+YKdKjfh9wZm8Csb1JiNcM1d0X4UJkd60
 glqHV0cDs816oBYjiws2SFUTl1RqcnFtpnRNy83Zs9UVdD3rZl1BN7sB10kBslA+tbjwtVSac
 S1RHjgvzI2/30aCu3L1Zol+a+wCxB/CQ0S1md1iser+52aCakqSy2TKEhRgCJiH7820ic32Mg
 zNHCmmP5/UBG5opNcPcwGD61Ht9b5N+k6EqLfYSqP28sAAA/tmkjTweJn9AhqnV3ZMf0uXpRk
 Ib3n89hdprSchjpwguhlfzroUOxSNZS7UVfIcdixlL7pG85tuaoFsXlCUUTKLiwfcC/9C2UiY
 IvIjYs+Axszt+jf5IUACcY0nrb6sryyY1duvQN13731cQcdsItIE4pV27Kz6kzMmknlZzFKDT
 NH9JINf+j/TCviTA4yN3l5r+I+vBLieJt5YgkmZYiSwFBZdG1y/ECNvpGF42o2plySg7jMu4t
 9MwfS4nFF39tMWGGVN3d6A6PRGavYoaDVrnOhr2MA698+hxQVrxYhUo2MSbZiWnim2Kb5h1RO
 f7X9CV831iUwuNFCYooi26AAwcI8jDr9KdU57vQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Srinidhi,

On Sat, 5 Sep 2020, Srinidhi Kaushik wrote:

> The `--force-with-lease` option in `git-push`, makes sure that
> refs on remote aren't clobbered by unexpected changes when the
> "<expect>" ref value is explicitly specified.
>
> For other cases (i.e., `--force-with-lease[=3D<ref>]`) where the tip
> of the remote tracking branch is populated as the "<expect>" value,
> there is a possibility of allowing unwanted overwrites on the remote
> side when some tools that implicitly fetch remote-tracking refs in
> the background are used with the repository. If a remote-tracking ref
> was updated when a rewrite is happening locally and if those changes
> are pushed by omitting the "<expect>" value in `--force-with-lease`,
> any new changes from the updated tip will be lost locally and will
> be overwritten on the remote.
>
> This problem can be addressed by checking the `reflog` of the branch
> that is being pushed and verify if there in a entry with the remote
> tracking ref. By running this check, we can ensure that refs being
> are fetched in the background while a "lease" is being held are not
> overlooked before a push, and any new changes can be acknowledged
> and (if necessary) integrated locally.
>
> The new check will cause `git-push` to fail if it detects the presence
> of any updated refs that we do not have locally and reject the push
> stating `implicit fetch` as the reason.
>
> An experimental configuration setting: `push.rejectImplicitFetch`
> which defaults to `true` (when `features.experimental` is enabled)
> has been added, to allow `git-push` to reject a push if the check
> fails.
>
> Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
> ---
>
> Hello,
> I picked this up from #leftoverbits over at GitHub [1] from the open
> issues list. This idea [2], for a safer `--force-with-lease` was
> originally proposed by Johannes on the mailing list.
>
> [1]: https://github.com/gitgitgadget/git/issues/640
> [2]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.1808272306271.73@tvgs=
bejvaqbjf.bet/

First of all: thank you for picking this up! The contribution is
pleasantly well-written, thank you also for that.

Now, to be honest, I thought that this mode would merit a new option
rather than piggy-backing on top of `--force-with-lease`. The reason is
that `--force-with-lease` targets a slightly different use case than mine:
it makes sure that we do not overwrite remote refs unless we already had a
chance to inspect them.

In contrast, my workflow uses `git pull --rebase` in two or more separate
worktrees, e.g. when developing a patch on two different Operating
Systems, I frequently forget to pull (to my public repository) on one
side, and I want to avoid force-pushing in that case, even if VS Code (or
I, via `git remote update`) fetched the ref (but failing to rebase the
local branch on top of it).

However, in other scenarios I very much do _not_ want to incorporate the
remote ref. For example, I often fetch
https://github.com/git-for-windows/git.wiki.git to check for the
occasional bogus change. Whenever I see such a bogus change, and it is at
the tip of the branch, I want to force-push _without_ incorporating the
bogus change into the local branch, yet I _do_ want to use
`--force-with-lease` because an independent change could have come in via
the Wiki in the meantime.

So I think that the original `--force-with-lease` and the mode you
implemented target subtly different use cases that are both valid, and
therefore I would like to request a separate option for the latter.

However, I have to admit that I could not think of a good name for that
option. "Implicit fetch" seems a bit too vague here, because the local
branch was not fetched, and certainly not implicitly, yet the logic
revolves around the local branch having been rebased to the
remote-tracking ref at some stage.

Even if we went with the config option to modify `--force-with-lease`'s
behavior, I would recommend separating out the `feature.experimental`
changes into their own patch, so that they can be reverted easily in case
the experimental feature is made the default.

A couple more comments:

> @@ -1471,16 +1489,21 @@ void set_ref_status_for_push(struct ref *remote_=
refs, int send_mirror,
>  		 * If the remote ref has moved and is now different
>  		 * from what we expect, reject any push.
>  		 *
> -		 * It also is an error if the user told us to check
> -		 * with the remote-tracking branch to find the value
> -		 * to expect, but we did not have such a tracking
> -		 * branch.
> +		 * It also is an error if the user told us to check with the
> +		 * remote-tracking branch to find the value to expect, but we
> +		 * did not have such a tracking branch, or we have one that
> +		 * has new changes.

If I were you, I would try to keep the original formatting, so that it
becomes more obvious that the part ", or we have [...]" was appended.

>  		if (ref->expect_old_sha1) {
>  			if (!oideq(&ref->old_oid, &ref->old_oid_expect))
>  				reject_reason =3D REF_STATUS_REJECT_STALE;
> +			else if (reject_implicit_fetch() && ref->implicit_fetch)
> +				reject_reason =3D REF_STATUS_REJECT_IMPLICIT_FETCH;
>  			else
> -				/* If the ref isn't stale then force the update. */
> +				/*
> +				 * If the ref isn't stale, or there was no

Should this "or" not be an "and" instead?

> +				 * implicit fetch, force the update.
> +				 */
>  				force_ref_update =3D 1;
>  		}
> [...]
>  static void apply_cas(struct push_cas_option *cas,
>  		      struct remote *remote,
>  		      struct ref *ref)
>  {
> -	int i;
> +	int i, do_reflog_check =3D 0;
> +	struct object_id oid;
> +	struct ref *local_ref =3D get_local_ref(ref->name);
>
>  	/* Find an explicit --<option>=3D<name>[:<value>] entry */
>  	for (i =3D 0; i < cas->nr; i++) {
>  		struct push_cas *entry =3D &cas->entry[i];
>  		if (!refname_match(entry->refname, ref->name))
>  			continue;
> +
>  		ref->expect_old_sha1 =3D 1;
>  		if (!entry->use_tracking)
>  			oidcpy(&ref->old_oid_expect, &entry->expect);
>  		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
>  			oidclr(&ref->old_oid_expect);
> -		return;
> +		else
> +			do_reflog_check =3D 1;
> +
> +		goto reflog_check;

Hmm. I do not condemn `goto` statements in general, but this one makes the
flow harder to follow. I would prefer something like this:

=2D- snip --
 		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
 			oidclr(&ref->old_oid_expect);
+		else if (local_ref && !read_ref(local_ref->name, &oid))
+			ref->implicit_fetch =3D
+				!remote_ref_in_reflog(&ref->old_oid, &oid,
+						      local_ref->name);
 		return;
=2D- snap --

Again, thank you so much for working on this!

Ciao,
Dscho
