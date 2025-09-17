Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B72874E0
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126085; cv=none; b=QZ/TIltm4Nv/KuG3VXlZdhRkW9JVuDfXAkGpiUxbZTZnSsVZ/JN3Zm1jpXMEemOTMFEwy0mlgxNcV8yZGlu7FB1wXqEgyjzEmPTyojjJtGASo5jIRPBAOD1sM8BNQCFrexYsa8Proh050KLQS5zzMDA3Bn9jORcgRlyt3keTSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126085; c=relaxed/simple;
	bh=STQxoCX2VnX4DE8xx38Zv5ycR0pRNs/kLJPvZOt5U4c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NoQg7JnzC/Xm1xxKyCdANEiAhSwxa/sS3xW0k5/RnFTfwOUELLvM9vrIAAcJQkKOqrbUnMbwpbjraH+Ox/Trjq8lHFYfM17RPt5C0JY45q6KFbH0Bi3z80URJk42p9z8opYEeyEPzNH6gqaDyQ9V6UdFBFxWpMfo7Lebrko4GLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jjerphan.xyz; spf=pass smtp.mailfrom=jjerphan.xyz; dkim=pass (2048-bit key) header.d=jjerphan.xyz header.i=@jjerphan.xyz header.b=YgMUlYUi; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jjerphan.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jjerphan.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jjerphan.xyz header.i=@jjerphan.xyz header.b="YgMUlYUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jjerphan.xyz;
	s=protonmail3; t=1758126079; x=1758385279;
	bh=AG5CBrnedRxyPaUEBxSB0bh0LkfysnzutKjfvrDiZnw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YgMUlYUiWhkyDvchKuX5R4NKZtmTDE3KZ5fnv5HjnxXDK+LtlR+ANl6f712Q45xwA
	 Wl9qapRMoRzBaMe+G1FDBUUJZi7SpukyvzQqEr5zd9JmaAyvIAnBHcawXBRa7e5Fq3
	 oNe06ZJx1Fo3VoQh5cGrCCWy+FtNNxADb+kv3+IKw/u6DoDZGEe+jaDUNkfxQCjWzf
	 d2WH3sr9Vk3xvxgFHffAFzT6QAF96t1fanfm5d62NRWNsAWbKXWJHvZA0UY+HI8WwG
	 92lcb2oYr4IJM27N06gC54HxHLl5LpdlrtZXwNrm0R+N2TH+wdmTMJPICM2h1d4QOY
	 GjYGVzsPZ3tww==
Date: Wed, 17 Sep 2025 16:21:12 +0000
To: "gitster@pobox.com" <gitster@pobox.com>
From: Julien Jerphanion <git@jjerphan.xyz>
Cc: "gitgitgadget@gmail.com" <gitgitgadget@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Add `-u` short option for `git pull`
Message-ID: <VVHyXy0fQW1fnBgiAFswUMEMMX4wnc3YIZWSRtSJzZbHOt0dfY0wCJt69MDxfue54cN2gPd8StlVtW2ERYKZcEs8Hpm7X5TaXrygCN2rK-A=@jjerphan.xyz>
In-Reply-To: <xmqqikiam90b.fsf@gitster.g>
References: <pull.2037.git.git.1756147789443.gitgitgadget@gmail.com> <xmqqikiam90b.fsf@gitster.g>
Feedback-ID: 10827467:user:proton
X-Pm-Message-ID: 3b48ccb0aa97542fa614c7a99319d5521a0648fe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-------- Original Message --------
On 8/26/25 16:51, Junio C Hamano <gitster@pobox.com> wrote:

>  "Julien Jerphanion via GitGitGadget" <gitgitgadget@gmail.com>
>  writes:
> =20
>  > From: Julien Jerphanion <git@jjerphan.xyz>
>  >
>  > Add the short form `-u` as an alias for `--set-upstream`
>  > in `git pull`, similarly to `git push` which supports both forms.
>  >
>  > This allows users to use `git pull -u <remote> <branch>` as a
>  > shorter alternative to `git pull --set-upstream <remote> <branch>`.
> =20
>  The above explains what it does.  It does not justify why it is
>  needed.  Surely it may allow them to type less, but is it something
>  they would do very often, like every other day or even twice an
>  hour?  If not, should 'set-upstream' squat on a short-and-sweet 'u',
>  robbing it from future developers to use it for more useful purpose?
> =20
>

Hello,

Before all, thank you for maintaining git!

Having this shortcut would be really useful for some use cases where one ne=
eds to pull locally branches from forks before updating them and pushing th=
em again on the fork instead than on the upstream project (typical use case=
 for conda-forge's feedstocks).

Julien.
