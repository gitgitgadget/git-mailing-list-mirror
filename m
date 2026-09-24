Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC44A6CFC
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274419; cv=none; b=H0fTkxX/gtENncWiJZ2TqJup6EFXXXr1Wy7lee5CniBIYTWnxDvgggG3dAW27BEoget/vbO/YA1fFgJ/W+GAtEHTmQ07OyE4cje0JHB4glmnmsSC1GKvr3s2HRjdWvpggGSU7UiUjgfqyuYN4Qrtyb5y3wNyWg8lKJ1oIKyv/lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274419; c=relaxed/simple;
	bh=wjdgPkhQ/D4nqesIwXEKlleZ6HRO9Br8enkg66qdr/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qY5qCwr6Y++ZEItK0w5dEkHt7DEAZmFxN8SH8XezA1bzdJiInSnFxPDBvhOH2wstFjvtLjvUexd53L4RZAzN89q2plC1beeSinQ64awOXwbtcvP8nQab5KMRxYg2wRU6NTmMKnWxNrs2vkUoedCTxfu4XC1iJwjsHYJh0bp0aiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bu2XkW30; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m99jRnyx; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bu2XkW30";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m99jRnyx"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 7779FEC001F;
	Thu, 24 Sep 2026 14:26:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 24 Sep 2026 14:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790274416; x=1790360816; bh=i8PIvtjU3c
	GSGEluRodCOB3VAmAQ7vGEZ/wMxO/rPDI=; b=Bu2XkW30XYhQrOHHKu8uT3UKRV
	g/V/s7umOJXWLVMInzGcIEsHtjBlHN+ow8zQsWXvr8DF5xdeOht7xyI6gsbAHN2D
	mUVd5OI+RxIcYAaahw1hKs3Hu7cuoVBPDLTB7XmRN9zltbftcNHw86g95Cvfs1n7
	uR7QHxnR2nZxukNA2WftjlNUCRHRQp5Y9QlvMEizYZ6kvQNDGYMQYlCujY4fhrH0
	kKePh5fQet2dPO48+t8urfE8vmpevsHXk7PudL//ZOn+3CZDGWMe7W1DvsSrXN+9
	GjZJi+qCeHcWETB0balSziRZUYUtUXQVAUGuv4s/0jC8x9L8wW53NQQJKawA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790274416; x=1790360816; bh=i8PIvtjU3cGSGEluRodCOB3VAmAQ7vGEZ/w
	MxO/rPDI=; b=m99jRnyxBpYtq79sQw7ik0+XRxiODy57EecAFQA80rMZNLddlAk
	V84iYZVAulcHotRfaEiFQR/NlbuELcLpDCrJrxk2PIhlPcJL/0kNIGrN5w0zihXP
	eRtxZ7bYBC1DOdgjeDEVl0eut0XAI4SUi+nzuUrOC/MTFQKt5pORwM1/gmKsraZp
	utRyq2jW8OCUjFP4M+98T3T9twZP4LVomMjOJ6SrAovs3sJD9LwFXvIeRSEbyzq8
	/aU6D5CfrZYNRVIGIT0xlULgO7JkYe+N4cYEmCFGehD+oZD3P7xCe+eeOUA4KGum
	lU+ygKZsRhNIAzrIUKT2cFf2Kn/RwLWIQ0A==
X-ME-Sender: <xms:cGu1agNWEcWxxS3DivbSVbs9ZXXC-aAwYJ96fsVBaSBHtJiYM_lnLA>
    <xme:cGu1aqqS3VdnDuga84g5-TyhXqFqJmtqIzJ09aluC6rZkXzq60p2Dr37LsFnP2bH3
    X1tDkMhIdHWFsJnfL9EjhWaBt8zdNtt6Rz0ojYb8G6TbEr7muwB>
X-ME-Received: <xmr:cGu1ahGJl2Tct6G4XFWFcdGz3d9un1hOWs5YvMpUSN4-B8MZ1QTfeXx1ko6J9wg7O3eQHiv-qGIaRw8LTG0fLSVRgszEk3iAOz-K>
X-ME-Proxy-Cause: dmFkZTGIWfpZUoU8MYalG+x+xujQdPsc9IrS3BpTfcYxtLi0B0LKdIasbWx3zqZV7rm21g
    6DPzhoobLBsSxRSIBU2MUjLCalJT8c4LamZClQhVwQw4WhS2vSqbxCykDFMUTLeXSntKHP
    k+aaZcKQmPI+en3TFC2Icb3P4/3wIY8O46vIbkLE2EMO3/mR46zcebOnDdLQIhfQJz0Ooe
    TmzxAuULg1C52sL4FfTjoXjmMIqKs2ZK3gbABGdW2aoqrUb30C4QZhpADX1MtEYbKCaNwn
    U9GWU/wJCly2n5E9tj7LsqgI8BV62NlsJ7duE8ktcmJkxOuGEqaWryRJyYqT2cRnOwoFMs
    DOoORw8pDif6qJ9phzF5eDfBx3c1C2YOXBpdXx1l0pZC9KcGfKtbhhjJ9s0gD4Oeu6ypZy
    RzTIL5i+ww8HuQOjU00zihB76yje9gFHmza0w0Xg+zecV0JnK2aaW4aWEnyzPZzNZ0DHqh
    s3LpTq8OvCXrvee8n+Dy3uI3O9ejyntqHDsiJZRC4V5z51lg9nn5SMqpwDTaan5wtsy9vu
    f/PCtjGZDycOt0dGvwAEXoTbqJMaCbwJs1arSXGpLPK8kJ7at/PQN9dmDgyHnQIgUh+htw
    Xbz4diZyRPqMcwFkpreitlZUma9pSrDKVtKDVHWc768/ux9AgTxWZldk9KKA
X-ME-Proxy: <xmx:cGu1avoRRPepT3rruC6s7JbRlU3MS52aJx86Gr1Xbmk9pfM6E0nSwQ>
    <xmx:cGu1aqYSEDVkc2lQm6fUaeqMuzSuDH0Fz7RQX8XpAFCfJDo69GO2vQ>
    <xmx:cGu1aoUz0bzRbrFyPm8teWt2olQYyiLYdi-qTGxytmIls1Ww5tuU6g>
    <xmx:cGu1aj_kADxZsYAYcSPcPJePqP-1MJ0bIKuDTnqIIuFpVT5hdchgmA>
    <xmx:cGu1ahKPPKHx_I5b_B87EFO2OCHdHhoO5y08sIJK_BosgeobK8jLqT0X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 14:26:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  ps@pks.im,  r.norouzi@proton.me
Subject: Re: [PATCH v3] reflog: fix default expiry periods
In-Reply-To: <20260924175843.8383-2-pushkarkumarsingh1970@gmail.com> (Pushkar
	Singh's message of "Thu, 24 Sep 2026 17:58:44 +0000")
References: <20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
	<20260924175843.8383-2-pushkarkumarsingh1970@gmail.com>
Date: Thu, 24 Sep 2026 11:26:54 -0700
Message-ID: <xmqqwlsa1p5d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> The default reflog expiry periods were swapped when they were moved to
> REFLOG_EXPIRE_OPTIONS_INIT() by 85658275702b (builtin/reflog: stop storing
> default reflog expiry dates globally).
>
> This caused reachable entries to expire after 30 days instead of 90 days,
> and unreachable entries after 90 days instead of 30 days.
>
> Reported-by: r.norouzi <r.norouzi@proton.me>
> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> ---
> Changes in v3:
> - Split the regression test into four independent cases, covering
>   reachable and unreachable entries before and after their expiry periods.
>
>  reflog.h          |  4 +--
>  t/t1410-reflog.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 2 deletions(-)


This iteration has its tests much more nicely organized than the
previous round.  Looking very good.

After this patch graduates to 'master' and the dust settles, we
might want to clean-up the repetitive and verbose combinations of
turning a human-readable timespec into a machine-usable timestamp
into a single helper that is easier to use.  But that is outside the
scope of this change, I would say.

> diff --git a/reflog.h b/reflog.h
> index b996712c00..3bdd1ca8a5 100644
> --- a/reflog.h
> +++ b/reflog.h
> @@ -23,8 +23,8 @@ struct reflog_expire_options {
>  	int recno;
>  };
>  #define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
> -	.default_expire_total = now - 30 * 24 * 3600, \
> -	.default_expire_unreachable = now - 90 * 24 * 3600, \
> +	.default_expire_total = now - 90 * 24 * 3600, \
> +	.default_expire_unreachable = now - 30 * 24 * 3600, \
>  }
>  
>  /*
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 8f78cf4b01..93b5b49e1d 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -153,6 +153,72 @@ test_expect_success 'reflog expire should not barf on an annotated tag' '
>  	test_grep ! "error: [Oo]bject .* not a commit" err
>  '
>  
> +test_expect_success 'reflog expire keeps reachable entries for 90 days' '
> +	test_when_finished "rm -rf reachable-keep" &&
> +	git init reachable-keep &&
> +	(
> +		cd reachable-keep &&
> +		timestamp=$(test-tool date timestamp "60.days.ago") &&
> +		timestamp=${timestamp#* -> } &&
> +		test_commit --no-tag --date "$timestamp +0000" old &&
> +		git reflog expire --all &&
> +		test_stdout_line_count = 1 git reflog refs/heads/main
> +	)
> +'
> +
> +test_expect_success 'reflog expire removes reachable entries after 90 days' '
> +	test_when_finished "rm -rf reachable-expire" &&
> +	git init reachable-expire &&
> +	(
> +		cd reachable-expire &&
> +		timestamp=$(test-tool date timestamp "100.days.ago") &&
> +		timestamp=${timestamp#* -> } &&
> +		test_commit --no-tag --date "$timestamp +0000" old &&
> +		git reflog expire --all &&
> +		test_stdout_line_count = 0 git reflog refs/heads/main
> +	)
> +'
> +
> +test_expect_success 'reflog expire keeps unreachable entries for 30 days' '
> +	test_when_finished "rm -rf unreachable-keep" &&
> +	git init unreachable-keep &&
> +	(
> +		cd unreachable-keep &&
> +		test_commit --no-tag base &&
> +		base=$(git rev-parse HEAD) &&
> +		timestamp=$(test-tool date timestamp "20.days.ago") &&
> +		timestamp=${timestamp#* -> } &&
> +		test_commit --no-tag --date "$timestamp +0000" old &&
> +		old=$(git rev-parse HEAD) &&
> +		git update-ref refs/heads/main "$base" &&
> +		git rev-list --all --objects >reachable &&
> +		test_grep ! "$old" reachable &&
> +		git reflog expire --all &&
> +		git reflog --format='%H' refs/heads/main >actual &&
> +		test_grep "$old" actual
> +	)
> +'
> +
> +test_expect_success 'reflog expire removes unreachable entries after 30 days' '
> +	test_when_finished "rm -rf unreachable-expire" &&
> +	git init unreachable-expire &&
> +	(
> +		cd unreachable-expire &&
> +		test_commit --no-tag base &&
> +		base=$(git rev-parse HEAD) &&
> +		timestamp=$(test-tool date timestamp "40.days.ago") &&
> +		timestamp=${timestamp#* -> } &&
> +		test_commit --no-tag --date "$timestamp +0000" old &&
> +		old=$(git rev-parse HEAD) &&
> +		git update-ref refs/heads/main "$base" &&
> +		git rev-list --all --objects >reachable &&
> +		test_grep ! "$old" reachable &&
> +		git reflog expire --all &&
> +		git reflog --format='%H' refs/heads/main >actual &&
> +		test_grep ! "$old" actual
> +	)
> +'
> +
>  test_expect_success 'corrupt and check' '
>  
>  	corrupt $F &&
