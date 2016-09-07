Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E49D21F859
	for <e@80x24.org>; Wed,  7 Sep 2016 12:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757335AbcIGMw0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 08:52:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:60365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754914AbcIGMwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 08:52:25 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0ME47n-1bqBIn2zHz-00HL77; Wed, 07 Sep 2016 14:52:06
 +0200
Date:   Wed, 7 Sep 2016 14:52:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 2/2] patch-ids: skip merge commits
In-Reply-To: <20160907075425.6jgamuwm66xbklu3@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609071338310.129229@virtualbox>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net> <20160907075425.6jgamuwm66xbklu3@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Rs2zHnP3DfQO0goe8+GlScwuafSph///mcu/okSat3CpDmEsali
 RXJSHsaRyRTeme09mXokBU5EXe/SO9m46RLMr2fM9F4sWYKBoFlndyHHM7tCyeCyKWP8042
 nP4xcfvTyZ+GwftbvaSz6ywXn6SZN3IQiMfqrs5nzI+e3BeUqDyQcRqqIcq/gxNBWiZeazt
 e3hwjrAEuIq9B39El+zFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AklD/AWoNZc=:iBDj5RstpctxTRtSQYz4Rv
 A8w4QSWFDcJOaSKmU/E2Wi3YlQQYW3ByDlg4wQmqg8lLL0SFTBON/LaSQOrmkWcMu9XiyZjEh
 VtFJZHdPBsJ2EFbH2mMGEhhRaw1cOIIjWmArAOnyruoUoUBdIiJtrO8aYOg5slA0WDyqeoHnt
 yVdk2gWJLl9my06etGDfccHRE5JPvFIEctwH+uxifAksaC+RI4fyK/+d6ZznT7Bon49B6MHrH
 qTQBOIg+f9c//P19+qLoGGMWlMdxIX/DKobc1PyXKMXHDXEzpCS6F7jbRm/sVpXFHFsWz1mpf
 f/rMkyeo0i0GkjB7t3fjn0S5diz+ZoeQ3XC6U+EQow7VLYWjztQq+BtzyOeTe822W6ujgsrZn
 igKGkVxDR5Ibr8bLYmkqYfbWmb2kLAVqbjv6NCNHgW8Yy9hc+f48g55E3klx7NKThJFkRKp2c
 zWFCTHA6Bp6hJm345B9pABV9mtMKwoKxFd1dyubXF9MBRnzJ/7edvJr9vxN1H1l2UKVL+VRGm
 X7VTXq0q9JuBW0BMfmsTnzNDCBPh6IpufuDv7ROIZ3rEjWpW8aLq8j5brwE4oltQia2EbN0Ny
 rJQbscX8BJjbdhtoOg7rLvd4ah2DwyPJTPAJfJsBQl3Lf619Ng8rA9jWd+DWPWiNHv5tYBJwl
 b9TzGkvua2SDIjAotwWG2wm1Atw6wb3x53nBytvPMUQCLCg7KTcmBtPb7eWEtXdRtZBfpvcj7
 t0sQGuqJ3krQ6foAgnLWrT9WgbabJoUAT08yfWekdtwMpwXpc5ur8IlcJ5MOX8wOFQlopVV+d
 mr8zizk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 7 Sep 2016, Jeff King wrote:

> [...]
> This patch just ignores merge commits entirely when
> generating patch-ids, meaning they will never be matched
> (from either side of a symmetric-diff traversal).

... except it does not ignore merge commits:

> diff --git a/patch-ids.c b/patch-ids.c
> index 77e4663..b1f8514 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -7,10 +7,12 @@
>  int commit_patch_id(struct commit *commit, struct diff_options *options,
>  		    unsigned char *sha1, int diff_header_only)
>  {
> -	if (commit->parents)
> +	if (commit->parents) {
> +		if (commit->parents->next)
> +			return 0;
>  		diff_tree_sha1(commit->parents->item->object.oid.hash,
>  			       commit->object.oid.hash, "", options);
> -	else
> +	} else

With this change, commit_patch_id() will return 0 for merge commits
(indicating success) but it will not have touched the sha1! Which means it
may very well have all kinds of crap in the sha1 that may, or may not,
match another, real patch ID randomly.

See e.g. the call site in builtin/log.c's prepare_bases():

	[...]
	if (commit_patch_id(commit, &diffopt, sha1, 0))
		die(_("cannot get patch id"));
	ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
	patch_id = bases->patch_id + bases->nr_patch_id;
	hashcpy(patch_id->hash, sha1);
	bases->nr_patch_id++;

So the sha1 is actually used, even if it was not initialized.

I would suggest to simply copy the merge commit's SHA-1. It is no patch
ID, of course, but collisions are as unlikely as commit name collisions,
and it would make the "patch ID" of a merge commit deterministic again.

I.e. something like

 	if (commit->parents) {
-		if (commit->parents->next)
+		if (commit->parents->next) {
+			hashcpy(sha1, commit->object.oid.hash);
 			return 0;
+		}
   		diff_tree_sha1(commit->parents->item->object.oid.hash,

on top.

Ciao,
Dscho
