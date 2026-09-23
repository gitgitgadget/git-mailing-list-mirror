Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31D13B42F9
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180187; cv=none; b=aiDdIDdo4gDM05ei6zcFp+Y6CEDxO/AmFWqRhT2yV2HsykpP0HKHvdwzsLsxHpDqw2d+UmpQofoQwZemsEyf+9gJ8aj23FiZ9zjdUjp1tq1gxBNouuGkM6oq66KIcMZSk8qGg0bENHIwtigQ+cOpVIRzksQFaaNvKcpGR9JSsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180187; c=relaxed/simple;
	bh=VTbYxtzsIXOK4zcPUI/EgB/0oXE4nDhTYBTDw/M1TRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y87bm9QIHJOoxyvoSLWFVSQUisSZyr1OFN0cUuyh/mONKXA7O3OnY3Rbzae69qA+lSjcYovYgLsxtxollB+383P+fMK1mjAbHyay3yKcghccak73prhbZmCcj15ly0oEhmt08knPH0t+sZuF2l1WzFyPwWiHdBwT+DkWwPervYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c/oauMMf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D4E+hFk6; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c/oauMMf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D4E+hFk6"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 074F31D00120;
	Wed, 23 Sep 2026 12:16:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 23 Sep 2026 12:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790180183; x=1790266583; bh=l8Uxruv2/U
	ENp6VuF/zq19M89obqbDGtqTqsGywGcOs=; b=c/oauMMf16eWg0t7xYgY2vcuLh
	cHwTYFI/DhCkeKxanLcqXMiAXOwWorGYaQBHKvLlqhOxUwgtjD9nhFY7KlW50569
	2IFYj5fUXdzlZHUablVVr6T2yT+HSSn9j+n8etyD2dQkuF16cCmBH4s7tmyzG//J
	c2JF7+DZmdKcDp64kULuxP9s2UfTvCoxEuC9r9O60qDz366m2wnxDlsy/UFbqtk3
	tGPxRN3dQglmXEK8QJFmkbTkwkJer5zZ9zxUiJoZr2HyylXRFwaMuapiqyQ8Xuvm
	O7/o48dDRY5UGP4SyfGHfjCyo/uhHfHVq8B25OvvGwgILo6Xejt7RtwHXdXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790180183; x=1790266583; bh=l8Uxruv2/UENp6VuF/zq19M89obqbDGtqTq
	sGywGcOs=; b=D4E+hFk67/IDSYTV1Dm8ktTVhhBb/vR1JQ7OGTy+to6owwHZG1c
	BaPm9hlmpPsq3ybk61saT6XfuEn4i/EKA1YTRvS3JLzWQX6qfH8jn5loKNZwLerg
	GwHdavfRlmAMRTEVE9AWOO6G1CRwSlVHqpRqi6fClOmA0kw4WvxEUa+ChA1kR45N
	LhU27GqeMaYh65Vdg3F57Dn7EpZm+INMfqcJMC+wf8vhT1vCSzb+jEfo5bA0exzo
	BZRenxkc2fX0YDYB2MyZ0uhXYtxxK1YET326EUDX/BNN9P9odyaxMk6MmZ8CGvKF
	ANZWeq+j8jfFS19mAw+vGq5wJNrd9on/GnQ==
X-ME-Sender: <xms:V_uzag2wYmmPIxplgUl6V8pkOQwYlc3Uub2LMYgX9AkPNmmNDHQwHQ>
    <xme:V_uzaiFkW37dR1QYuh8K3feGQZ79wkrXpmj723PeRa_8zYVKC9bD7pclpmHkTmw-n
    8cXdVKzeseJt_DDpfGO0zyQJG_TEdliyHpz5rJCPjlH_8lpR4s0p1I>
X-ME-Received: <xmr:V_uzat5VNUM4qrLMoWVGOZW-r5Dbd7MHaJJ5-0ryrGGtvM9VIi3Dp7F8oR4oBcnxpOba4icAqMFdkCtGoayj9zDasUbQTEAFCbrD>
X-ME-Proxy-Cause: dmFkZTE4RG+aHaUGiPbK5VulVL4eImJxT3+04tfAMrm8VpvbEcF5kHhHof497EByZJmZSf
    EwLDJZ9mnTvTOsTrplkm0mp3FDHcIaRxAh86g8i+rO8YJ3PmgGEsylttEgnReiNZzFEpO4
    QE5SGRy9ifGeaa6rG1eBCcP4fVc7nocun6VQzWhPMAnZNsdmV9TH16nGAMAzxHbx8ta/Hs
    U0l49XFpZRQX3P2iTuB7fH3aHoJw/rc5+lh3Upg65l/9WCE2a+dDhsYGb5e5CePjok9b0y
    I1i4gwN6aLtLc2wbJuvCPAg34h1ZBdR4ko64IeZQOqsDHChRB/K1Keiobu5vUvQUqnsfYM
    6l3gtUuDro+2p80XcRopPzzQKFZkIbIZIVrQz7b1IusJmcQSaANn+FxRT+V/V9vx+Pv7HR
    c6Tq5NNJcnEXxxQGNm9JVPlKcXrEgvmXJFj/wgwLP2JjzPpIspQ0TPsVr8KVqAe9AX7Uuu
    FKRxGIkutVxPfxI8eD0NZvy0WsArznaJBpy3xI/AtZiw+rWfCuAcui/hNt4l9paBysp/y6
    8+BG9AAzdRk2NQal/AmQW0WBbvLwW9zDHEXxbEJ4kPNyMhiWL87VPVJI6xo2T2vlbrN48E
    Z2EJJr4KHsJ+LFxlJ+w/qZvRavrJ4MhXvhh6hZ9eVLnJo3IgEj42qs/Jx/0A
X-ME-Proxy: <xmx:V_uzaosRow6rFUPuTwGJliVQnIiFn2pMMK5RUA2AFdc_kmqgq-Z61w>
    <xmx:V_uzau6PliDq24b6HgpoUJc3lpnMivtBfPB9Zt9U9iW_mBFzLvDnbw>
    <xmx:V_uzajVqaYfY8vHp5fUX3OXtM-0IXCNAyKOV47aFsgM5JoMWJMu-Rw>
    <xmx:V_uzag_qFMRvlcac_qMlXIq8N6PFHB8z1mLQsB6gUFA8h8XjeY29bQ>
    <xmx:V_uzarRpmEplenth6FsiXgbCHqzzT4yI1X2gKoQrt_p6yPzXmtXm_-fS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 12:16:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: work around Debian 12's HTTP/2 authentication failures
In-Reply-To: <pull.2236.git.1790118373340.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 22 Sep 2026 23:06:13
	+0000")
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
Date: Wed, 23 Sep 2026 09:16:22 -0700
Message-ID: <xmqq1pakc59l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Since 00fa8502354 (ci: bump debian-11 job to debian-12, 2026-09-05), the
> `debian-12` job has intermittently failed t5559's half-auth clone with:
>
>   curl 92 Stream error in the HTTP/2 framing layer
>
> Anonymous discovery succeeds, but the upload-pack POST requires
> authentication. Apache can return an early 401 and close the HTTP/2
> stream before libcurl finishes sending the request body. Debian 12's
> curl 7.88.1 treats that closure as a transport error instead of allowing
> an authentication retry. Curl fixed this handling in 331b89a319d0
> (http2: polish things around POST), included in 8.3.0:
> https://github.com/curl/curl/pull/11756
>
> This did not happen before switching to Debian 12 because Debian 11
> ships with libcurl 7.74.0-1.3+deb11u16, which does not have that bug.

Superb.  A well written diagnosis like this is worth a ton.

> Replacing the packaged libcurl with a modern build would defeat this
> job's purpose of testing older supported distributions. So let's simply
> exclude the flaky t5559.15 and its dependent t5559.16 on Debian 12 until
> the packaged curl carries the fix (or until the end of time, whichever
> comes first).

Oh, 100% agree with the reasoning.  Thanks for this workaround.

>     it's just working around a flaky test. In other words: This patch does
>     not need to be fast-tracked into v2.56.0, but it would be good to get it
>     into master pretty soon after that, to reduce developer friction.

Yes.  I do not think there is any reason to cook it as long as other
usual patches.  Fast-tracking would make sure other things do keep
working on older Debian.

Thanks.



>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2236%2Fdscho%2Fwork-around-debian-curl-stream-error-92-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2236/dscho/work-around-debian-curl-stream-error-92-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2236
>
>  ci/lib.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index c6ccbf8c17..1cf31b5a2c 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -334,6 +334,12 @@ pull_request,*|push,*next*|push,*master*|push,*main*|push,*maint*)
>  esac
>  
>  case "$distro" in
> +debian-12)
> +	# Debian 12's curl 7.88.1 mishandles early HTTP/2 responses; see
> +	# https://github.com/curl/curl/pull/11756. Skip the half-auth
> +	# clone and its dependent fetch until Debian has the fix.
> +	export GIT_SKIP_TESTS="$GIT_SKIP_TESTS t5559.15 t5559.16"
> +	;;
>  ubuntu-*)
>  	# Python 2 is end of life, and Ubuntu 23.04 and newer don't actually
>  	# have it anymore. We thus only test with Python 2 on older LTS
>
> base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
