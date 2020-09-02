Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A7DC433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2580C207EA
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q6ajA6gT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIBU01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:26:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56608 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBU0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 16:26:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8DFADA709;
        Wed,  2 Sep 2020 16:26:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X7Mgbfp9zpHKic0QiWAahZoI+QE=; b=Q6ajA6
        gTqjyTlVBdvsP39SMECatSK0ucg2qaC5EFrEjG+j55RRS2rdyhDJ2FrQr7AfD5EF
        fmtQFpq6kQ1iZIHdqyy6X6uYGrMCKx23ruzVKKNFrTuYeGj5mJ3WR/paDGvv1WO1
        X+ZA1IWFm/rJeJkEtvsaeoZZjNcDihxyUc/gY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ncKXR62jdq24MygfYdbhnHDVshDETYX0
        bY9Iay8qQMyhXhulriKIBUwifzdDNs9dHWoGzk70DpuPc5IEh3fFk1QrsNNxcay/
        L7zkpJyyEfBiPRWcJcK/lQgbU/IqTi2D8p5RBdpfcChT5pa6WQuZHydCQ2PSzLZ3
        nadlyXkk8Qo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E02FBDA707;
        Wed,  2 Sep 2020 16:26:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 16E78DA706;
        Wed,  2 Sep 2020 16:26:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] fetch: do not look for submodule changes in unchanged refs
References: <pull.720.git.1599056635276.gitgitgadget@gmail.com>
Date:   Wed, 02 Sep 2020 13:26:18 -0700
In-Reply-To: <pull.720.git.1599056635276.gitgitgadget@gmail.com> (Orgad Shaneh
        via GitGitGadget's message of "Wed, 02 Sep 2020 14:23:55 +0000")
Message-ID: <xmqq3640apsl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FA643F2-ED5A-11EA-B6F8-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Orgad Shaneh <orgads@gmail.com>
>
> This operation is very expensive, as it scans all the refs using
> setup_revisions, which resolves each ref, including checking if it
> is ambiguous, or if it is a file name etc.

Nobody can tell what "This operation" is without looking at the
patch/diff text.  Our commit message typically gives minimum
explanation of the situation and the problem it tries to solve first
to make it self sufficient.  And then we go on to order the code
base to be in a better shape.  Something along the lines of ...

    When fetching recursively with submodules, for each ref in the
    superproject, we call check_for_new_submodule_commits() to
    figure out X and Y for the object the ref was pointing at before
    the fetch in the superproject, in order to ensure Z.  This is
    expensive because of A, B and C, but it unnecessary if the fetch
    in the superproject did not update the ref (i.e. the objects
    that are required to exist in the submodule did not change).

    Check if we are making any change to the ref, and skip the check
    if we aren't.

... but I didn't fill the most important bits in the above, as by
now you, as the person who encountered the issue and figured out a
good way to solve it, would know what to fill the placeholders with
far better than I would ;-)


> There is no reason to do all that for refs that haven't changed in this
> fetch.
>
> Reported here:
> https://public-inbox.org/git/CAGHpTBKSUJzFSWc=uznSu2zB33qCSmKXM-iAjxRCpqNK5bnhRg@mail.gmail.com/
>
> Amends commit be76c2128234d94b47f7087152ee55d08bb65d88.

I am not sure what this reference is trying to achieve.  Fixing a
bug in be76c212 (fetch: ensure submodule objects fetched,
2018-12-06)?  If so, please say so more directly, perhaps like

    be76c212 (fetch: ensure submodule objects fetched, 2018-12-06)
    tried to do what we are trying to do here, but it botched the
    exectuion by forgetting the fact that ...

or somesuch.  The cited commit says

   The submodule checks were done only when a ref in the
   superproject changed,...

so it is not clear what we are really fixing with this patch,
though.  Is the assertion "checks were done only when changed"
it made incorrect and instead we were doing unnecessary check
always?

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 0f23dd4b8c..d3f922fc89 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -958,8 +958,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  				ref->force = rm->peer_ref->force;
>  			}
>  
> -			if (recurse_submodules != RECURSE_SUBMODULES_OFF)
> +			if (recurse_submodules != RECURSE_SUBMODULES_OFF &&
> +			    (!rm->peer_ref || !oideq(&ref->old_oid, &ref->new_oid))) {
>  				check_for_new_submodule_commits(&rm->old_oid);
> +			}

The original before be76c212 fed ref->new_oid to the check
function.  Now that we are using ref->{old,new}_oid in the
condition, would it make more sense to pass ref->new_oid
like we did before the commit, or is that an object that is
different from rm->old_oid?

Thanks.

>  			if (!strcmp(rm->name, "HEAD")) {
>  				kind = "";
>
> base-commit: e19713638985533ce461db072b49112da5bd2042
