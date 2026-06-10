Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894E528851F
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112770; cv=none; b=hNf4qbeUKfCuqcEGj5N2ODlsuoNZwspbUW5kAVVeJXcXVYcRLSQk8aNf1yl0nBpzIAmzTctonTq2v1yesFFSjLeagGz8OQtUQQdrOi3tnuiPpEIrhlOAQwsXahsiDyWpLmPjVa2S8mKj3RhtWVz4rU3M3Y8+rig/+3zQGYcIB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112770; c=relaxed/simple;
	bh=A9o0wnWDLa58Knmmm+QhamY4nSZFd0T2jhENoaGCOMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqGSWguzyXTFfl8Q+7ty6xZOPW2rctm8yif/zT7EEGm4GvfPZwEiELO/U54MsTD6mvBbcovhZzP90R1AaXte7PKHisbEskHWgLC7898LzZ7r4qz/5c/XhuN0fEwRxkCllSRru1X1hzEWWsrSPJ64f/pmJo1yPVt46W/0Zb0fgnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jMNuaA3A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ueo5yfoB; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jMNuaA3A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ueo5yfoB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BCC3FEC01F1;
	Wed, 10 Jun 2026 13:32:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 13:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781112768; x=1781199168; bh=j7qSZeIHv+
	6dsKUc6u+zQnF7SOymE7VwSDCXW3Vo128=; b=jMNuaA3AnlOztmeMf+Mvscm8OY
	Vtjl2E1U284YYnIuRYIPcMbIXFZCoYbDqZdM3AO/EuCT0wlcuMjbap3FOBCruf1i
	bus2O3B2dXzdUXqSQBrdGhfsNiKwU5h2j5RYO4RZ6fG2BP1+ok/jk9e2uUs2IJ3D
	WL41yGyUiZK36D9239zxkBBqCUmfgR5FI1ipPWqb9gDS9HjN3Q3rNZEH+YIxhw/T
	3USkYit2ruGcGj5iLFemT9fssxRpxAe+eXLSjyHHVkr2d6hoaZgLXZFzTxxnz3i7
	xAAX1R2JcJSUmtSKPAow6OLyKC5rpVedEhKe45K9qPqVvyeEZgFXhGq1FnRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781112768; x=1781199168; bh=j7qSZeIHv+6dsKUc6u+zQnF7SOymE7VwSDC
	XW3Vo128=; b=Ueo5yfoBB2qeQX4D3vZHvqcIAxDAtuJJn9UHRqzUfIxnvFtLymX
	TfZTY2zY7MlmAubOwMOVKleLPZFixZeQVHpcXUMTd/Ns4098fidfq1r7Xt/OjqU+
	146ghwVjiAJckZwRS0W8hIRrD8RUhL0b39T9cP+Uq+sAY3pPniOwNrCOfRZvrqEm
	bpNzGH3wY5V76WSfyKKNKbeZ9sLueOow2MyaMkVBQ8STNzUJ49lQ0g6+5U8wweg1
	sk6iIa1CUz/VHJlKHiuF31OHh3a8vOcDd56cwWS1V4JhE76mb4TbnFkxX1+L4HpN
	FLIqWI3h4YTlC+tiAGYXu0osIB8yQtr/t9w==
X-ME-Sender: <xms:wJ8paunMNpyeDHu_ehTIKUJVF7La8lc1STKuHuJ6pVllFUhoJxmrKg>
    <xme:wJ8pas1VaRcR3cxprsSt7SeX8JIXZe10TQfqxXPnXF97JNfwwMHfwHzooDrGwdvD4
    KexwwLPgD4RBZYsfrHsnt6bbFaQS-Q3pC0_jBEp7wg0-Vkb7jY>
X-ME-Received: <xmr:wJ8pahrE1efFrJgjaxNHkI0hQYkM1o46oYI2fHzFWlr1Po2Jr3W8brMMZkPmUA7nAMadusnIM-B_IJLz_KuHClpFSZ5zfDMAsYEF>
X-ME-Proxy-Cause: dmFkZTFwwdQexxlPx9BZoEJv4dM02BegAnfZWzWmWFgdSJ9BDQ3LRT2ou9+CJ0SwG9q/tg
    kF8pErpuhwb9FlQ+B/72uRai8rmC8jwueS0lpu1HiLoNnc9hVXWkCJbRU9HiqIyELx2Srh
    UWIjnj6kltaeiKb1flYAE6FNERIIChElyMAGEBu9UVWcT4YU55oS7NrpZVZMT538TaFpKA
    l1NYOOR3UOrei9BGn6hs5apg3lbI1Yfr2BIFlwtXAaprrUpIOmry/3a1l0K0LfnWNnYhNe
    W7u1589XsYEjTWaFkLeEy1tzKNybtbAHDlQx5hVbJUQz0+rIime4A9e+uxGOCFVnHxXNMm
    mxMuOlHucCOjgn1Byk8SlKus+Lqz/51b3IvpSJ9G46sR+nDLAm2uDlSE3PJ30ptOibmRi3
    w+bUBhyh0Z/6OcoU0l11pNktxyd1KG1CmfXHpHmhzzNJXyIQwRzUM4p62EAdA+16Sx1Gqd
    51RaESIlEnWn52fBrm281lGLoVkntivJsjza5ABXx9r8Ij4SKLpjI5+IP/rMvtDKgTp6oJ
    3OH6HaL9f569oMt+VvPPejW2IQSkyF6SEHGvhLzSym5C7nOybkhb39NDPXSu5ikzbGklJk
    05CH6ikS8KoonJWN3E0pH/G2SKdq2G3kWMGnoh11p2/2wHhToybjL8QJ8IFA
X-ME-Proxy: <xmx:wJ8pahfpS_E6wImBXIurFV16it99Ik3DLKbCK_RRFM2hox48z0EmTA>
    <xmx:wJ8paooeMnGMlN4EL1yQ0HUcftXBFGfpVy__B04whdO4r8wUlMaWBg>
    <xmx:wJ8paqFKlVtFvPygKLVJ06RUdctgT9iWRSO4MGJ7R0kgvMOBnACaMA>
    <xmx:wJ8paguA9BECaUTDq6eoKLCE9u0Tpe1wLAJWjSUcXEzJIEohkTcRtA>
    <xmx:wJ8patJOc_X8L_TZxH0DQ5UWwNMyHAoQU86kLCe4n4VtmgaXINK0RqY7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 13:32:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/9] setup: don't apply "GIT_REFERENCE_BACKEND" without
 a repository
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-3-56c864b01c43@pks.im>
	(Patrick Steinhardt's message of "Wed, 10 Jun 2026 16:57:09 +0200")
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
	<20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-3-56c864b01c43@pks.im>
Date: Wed, 10 Jun 2026 10:32:46 -0700
Message-ID: <xmqqa4t2wbb5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When discovering a repository we eventually also apply the
> "GIT_REFERENCE_BACKEND" environment variable to the repository. There's
> two problems with that:
>
>   - We do this unconditionally, which is rather pointless: we really
>     only have to configure the repository when we have found one.
>
>   - We have already applied the repository format at that point in time,
>     so we need to manually reapply it.

Does the second point have a small typo, i.e., "if we have a
repository, we have already applied the ref backend to it when we
discovered it, so NO need to manually reapply"?

> Move the logic around so that we only apply the environment variable
> when a repository was discovered. This also allows us to drop the
> explcit call to `repo_set_ref_storage_format()` because we now adjust
> the format before we apply it via `apply_repository_format()`.

Makes sense.

