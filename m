Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F44963A6
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638748; cv=none; b=fmzZLMBw7hjlGhMNxAFxU5PonNVJe/kYGnw9zBb8To4FxVqbjsadDYqZTs+8JwuXv8VYZQbD6y7mAUqTnRujxpXBGMEqYsAXDvVEN8NCFP/DF6v2RVaTGBcTjLceu2CKW6dh0dGPWu+md/dSzoWpOax7/BDEZVF7WZ3JKnogfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638748; c=relaxed/simple;
	bh=j4m3pmTrc1iL8rC1MGxn1kQXPszFkXhNUd+x8zd+tOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FEk02foJnsE1OOsOKoCIIZOaJm2rNS2trapEr2QEdOrgfGGBbstSbXTRMLkLd1jiYSDGEvHkITQAFIhuUElbnNlAieQlIgyP0NIrg59M3K2u+UzOM+ZYskHgH5KWJSxgi/unH0ar4gvqUpco/swmDmq1OjrkbkzcG/7XURw4PUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QdxxFIJr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ksTwGIHo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QdxxFIJr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ksTwGIHo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2EEB4EC00A6;
	Thu, 13 Aug 2026 12:32:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 13 Aug 2026 12:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786638746; x=1786725146; bh=qfYOTgOCTZ
	e9wRcExzliEHZjvz4KyHyMqnXS8gVwRIs=; b=QdxxFIJrq1hRRw/K+7wN9czV6c
	kx+VGBLexm3b6TAyYvF0Fg8YB1rR3pNdG8xogJKdan5e/0BvJju2NnpmMBlG2VnB
	oJj9QSYp+IOfNis78Wj6DDAJKPUGo53b4C6bOF3xbIp5GRLQuwk5Rc8EwpqdayiT
	InvsZd3egZxFL3DJ39bpsY4hcDpRbdVeFPS7jzxl9jRq08CH16ndcuME5Dj5MGCz
	msHVGOwXzVUKP1iPi6d+GCOJd0t64ekEHg+R2DlJzo+MvvxZ6RnOxfzirMqEkZSJ
	un6d5idm1ORi6uVia1eIeL8JhNo3SYgw51SaJ/s26fQxGgs+GFi4ysSe1c4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786638746; x=1786725146; bh=qfYOTgOCTZe9wRcExzliEHZjvz4KyHyMqnX
	S8gVwRIs=; b=ksTwGIHoZnptFCtf1R3ZEuPHTwlni1VnCVhYvi2ttkuwvUCD8dj
	tmu0AyX7Bo6qq5yfW8RUzjwakAA+QajH2DIodOYKMwoj+2S0Ty2TBh5zQ6To+lJN
	mtn1Cyprryv1ypQtByxRA0MUj2ySqMdFwNMiJH3iBjSo+UHxtlsvst4UEpynwrOJ
	yBXkTNgZTfLhZawAm3IGwy72InUvGjSZZ3y7WcX+BzcZghip7GJaTNvnzFnWnxw8
	HYKnquLZTRMaYLvyQScUH242O1upa5Tqis2ri7p+MSiNNH+g6sq/jBMRa/mhKgsb
	FeqHk6ToAX2LyOhCZS6O/A1z9ZyK59xplOg==
X-ME-Sender: <xms:mvF9agwTs_YiPODwfY7LjIipjC4ux2ldPvATmHTbji8zgYqcgD5l0w>
    <xme:mvF9an8l3dvwncjjHSkXDrJ9zT5aPwdNDSgBnhPApPZ_nndyU98fBMfl7zDXmQ0Kf
    Cw-2_0Zj0HpII-nka95JYR234orijpzsIhgN4HGYUTG-golzi3UlQ4>
X-ME-Received: <xmr:mvF9asJrsEjta8ZzeSKo6xbka4qx0vSs80l7b-Jj-i4I9j4gbaXs6FykRXXP2XKjQoMyKBajGdIpBBvhQ91Sd69SqLM-4Ts5dw>
X-ME-Proxy-Cause: dmFkZTEM4VPJoJtJvoJGZO0zywemnnMhm04IyCbNKqhY24tEfFFJiuSyO+NZf7u1UH+wPz
    5+Q7LyZNDb7NW3g7LeSxxCzuSLEEUj1W756vq24Krzw1ODCC69RzmsJeFm45xJ6GQe5gd/
    DwRnZIu/W67gJhhESqCuNWdzyNTzlepN5HC9n8l5MvWkkFaShzZR7jIM1mIX/svCSQkKYH
    ju30B/19jwOgjt/wLS8MchiZkYfnWpYhdXS7V4l4XeSpBU/OMZxtYqNsmH/sPAb61P6o94
    uofdA8uo4BK5ciESMgp36/XCFvFu6EUaE3p2qZobYcpGdQpad17mAtAwDakpchnuvlSgKY
    RrtFPxCAlTOUoETJJLfjgJdNLAIVjC6zlxl539zKmVN01oUtgIWEG8PWnLFQgf7fxTlFSn
    LI/wKuasGJ3qM5x7v4liJkD5bIQJ0J/23wVMKCXWE7e0wrkjKolacKOAtjoaUhmdllE1qO
    ObuF1Qvmvcl0vjCHX51aRfvkesYXItth1K0aemW8Hp4mtn6I+EKWVBHrNZYF9rR8XjLpqT
    oVJwzaWZPaahxHC9SdsBaTsb/yVAx86FDNuqunrNDd0EPsNvPDcqJl2Y6VHvQW5PYkP2c/
    vH+8Ko8vGjMPbSxr/QKNZSVgQw5FDHAbHrAj+Al1pYUKSMOhmkCrOkfeJ1FQ
X-ME-Proxy: <xmx:mvF9aleds-radhuIXBQtBQCFhHZ_LzwEmdyZe3-XHmDQunKqezo6-Q>
    <xmx:mvF9aj_3fzJTiL69qIVqeJ0ohxiJ1mrD92pn_P8PDE4z3naypxVu0A>
    <xmx:mvF9aqr-4pdPe8UATzVlPTvngCdVO47X2UaQP2-mIRPthXrQuOFe6A>
    <xmx:mvF9agChM9sAJ4701H5KLq_NWp1JB5YPPy8GnJ6_2uwHQGhxBz1_xA>
    <xmx:mvF9ar9aULGnp66UsS6ITpS7DmR7qLvkdn7RsRz27LYOs75gD2T3yW8W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 12:32:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v4] repository: move fetch_if_missing into struct
 repository
In-Reply-To: <20260813061125.1089553-1-cat@malon.dev> (Tian Yuchen's message
	of "Thu, 13 Aug 2026 14:11:25 +0800")
References: <20260807094132.806165-1-cat@malon.dev>
	<20260813061125.1089553-1-cat@malon.dev>
Date: Thu, 13 Aug 2026 09:32:24 -0700
Message-ID: <xmqqfr0it207.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> The global variable 'fetch_if_missing' controls whether a missing
> object check should prompt a lazy fetch from a promisor remote.
> In order to continue the libification effort, move it into
> 'struct repository' and initialize it to 1 by default to keep the
> previous behavior.
>
> Note that in builtin/fsck.c and builtin/index-pack.c, when running
> related commands with the '-h' parameter, the 'repo' pointer is not
> passed in. To prevent null pointer dereferences, we defer
> operations on the repo until after parameter parsing is complete.
>
> Additionally, update the partial clone documentation to reflect
> that this is now a per-repository flag.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>
> Changes since v3:
>
>  - Use revs->repo in revision.c instead of the_repository.
>
>  - Coordinate the other topics. Specifically, for common-init.c, use
>  the_repository->fetch_if_missing in setup_environment(), etc. This patch
>  currently does not conflict with seen or next.
>
>  Documentation/technical/partial-clone.adoc |  2 +-
>  builtin/fetch-pack.c                       |  2 +-
>  builtin/fsck.c                             |  6 +++---
>  builtin/index-pack.c                       |  8 ++++----
>  builtin/pack-objects.c                     | 14 +++++++-------
>  builtin/prune.c                            |  2 +-
>  builtin/rev-list.c                         | 10 +++++-----
>  common-init.c                              |  2 +-
>  git.c                                      |  2 +-
>  midx-write.c                               |  2 +-
>  odb.c                                      |  4 +---
>  odb.h                                      |  8 --------
>  repository.c                               |  1 +
>  repository.h                               |  6 ++++++
>  revision.c                                 |  2 +-
>  15 files changed, 34 insertions(+), 37 deletions(-)

There still are references to the_repository->fetch_if_missing
remaining in the codebase with this change.

        $ git grep -l -e 'the_repository->fetch_if_missing'
        builtin/fetch-pack.c
        builtin/pack-objects.c
        builtin/rev-list.c
        common-init.c
        git.c

Some of them I suspect should just use the caller supplied 'repo',
possibly after removing the UNUSED marker.  For example:

        int cmd_fetch_pack(int argc,
                           const char **argv,
                           const char *prefix UNUSED,
                           struct repository *repo UNUSED)
        {
                int i, ret;
        ...
                enum protocol_version version;

                the_repository->fetch_if_missing = 0;

                packet_trace_identity("fetch-pack");

                memset(&args, 0, sizeof(args));
                list_objects_filter_init(&args.filter_options);
                args.uploadpack = "git-upload-pack";

                show_usage_if_asked(argc, argv, fetch_pack_usage);

As { "fetch-pack", cmd_fetch_pack } in the git.c:commands[] array is
marked as RUN_SETUP, repo will not be NULL unless "git fetch-pack -h"
is requested, and when repo is NULL, show_usage_if_asked() will give
the short help text and never return.

So I think it makes sense to set 'fetch_if_missing' *after* the call
to show_usage_if_asked() and set it in 'repo', not in 'the_repository'.

Other hits in the above "git grep" output looked similar.  The code
paths in pack-objects.c may need a preliminary clean-up patch (or
two) before moving fetch_if_missing to the repository instance.
I.e., pass repo through the call graph from cmd_pack_objects() to
read_stdin_packs(), and then update assignments to fetch_if_missing
variable to instead assign to repo->fetch_if_missing in a second
step.  There are other code paths that want similar clean-up.

HTH.
