Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F82DAFBD
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780353723; cv=none; b=FHfejF9jA1efxzAOZl49skBau//wZa2HDYqz/OO/x0LIJW3AhOdDw9maFjgVD44SpiTpO1X0a0Uce64KshXAF3OIS3xuKPb7/19hqtzIqCa9Is5u7wf2ccU3itanZZ8bWvN18Tnhh6qD4w+Lwa3i2QFo/fly7O4pj8saTat5Rm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780353723; c=relaxed/simple;
	bh=jdjgRX4VZ827PwAiIOw74fUloTC9ENJkpYxE8q5jvAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pnYnPOuXNOB3Hzf01DYVguUtsxmI5jB0x0o+iPYCc+TzQ/QSZAuSKDfRO/jD+FRi+GUcpN+q1E/CwsfQj8pWxZhyFrRwb5tPguN9RHLDjJZHA10dJiA/L6kkUT45jtm9q2hgCgorDz07TQWvYoQCOKIFbD3ftv9cv9WcjWI7Ba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JgPWAqt5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LR1QleKQ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JgPWAqt5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LR1QleKQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 792F81D00099;
	Mon,  1 Jun 2026 18:42:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 18:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780353721; x=1780440121; bh=y1OnYULA5L
	npP98K8SzAnrtGCWXTcqoRlwKA8QewvAc=; b=JgPWAqt5JP5YyyWmUc154oqrGH
	K2584mN4SbC+arixTFe66a7r73L2djO1KpJRjvzXI8pacZ4jP72n4CpeIOW18NxS
	sT5Gw/nHHOxiyTFu1bvQq/0VgdvTZYR7fH0+3SQVBrspnLaQCrhdgr+KGOnF0fcA
	W2sxQ5VoFFQbVzN6wIslOPOd5EbCuqchagir1JilL+FRjmLaqb0WImGjouMXhVtd
	v9R0lb9lZPM0MLOn1lX8v7+eSMIO8V5PMtILAW1ybrmS+B0oIw1zefv702o10D/p
	OlLJiZhGv+3EqKrMyUQTJNvLvClwlPd39UdRx7IZ5AOQFOwjL5bu+pSHm8DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780353721; x=1780440121; bh=y1OnYULA5LnpP98K8SzAnrtGCWXTcqoRlwK
	A8QewvAc=; b=LR1QleKQRPLaqj36Rj/tRZxsSsgZha/3YvhVI78LOg2TgJVYKKR
	YdvoS4I+qQIBuGKfXrEeEhOvncoEAF1HQ3Wwq2BPnzs7a9Z++ueGVZTlzbn40vX7
	nxY90ElogoYB4VaImmI/4ddgMvwfxL3eCGLTPc7enA2nsmGmOR964KoAcTDZHQdU
	cUq1tvo3yM1xO0/iGIj9UhLzOBh87fZ2T0cUIJRC8gnwnpYdehP5+q+BzPwWg8dx
	Y+QXZr7Iupvj3EL2qOSyLneeVcptVDV+CgvMzgJZzPgaOlr+5OsxiNMJkMIB5Oqi
	67U4ykML8C7IMGh1gHWlmilHaHosb4k5jpA==
X-ME-Sender: <xms:uQoeap-GWsduw7VB82RHsPPdxqq20N77haZ5ptxomIAugX34p1Z00Q>
    <xme:uQoeakvsQJZs2I1rl2Gjo_c4TpJFQNWq5iy6ne0XtXt4-2B75RaZCkBv9MNSbyZWN
    Z93uQHYEHEAOJ5eIv3JiU3SPWHV2FrgVp8MgYrt3HNgfEf3kP5rGNw>
X-ME-Received: <xmr:uQoeasAL_pr7F2wbb5KPGfiq5lSAKCMCIPKuPMCUjczxkrMLHS-92XNri9MWQoG2d_c8uXzC3y9lSJuX8vO98HgsAz_FMDG3G5ZT>
X-ME-Proxy-Cause: dmFkZTEk4QPvGlKCQu/75BxWW37PIbTeUzBspHnziFZ4qSE6XFfTN6OXm9kxJ0J2/pE0Jp
    KN6PIndZQ5PtRubgZScs6T3Ol0NskB83K0sd3H0ZuJXnruAhuhpzCxZaWvqmhYhtKnCzNo
    Kfu/d8dDSzTFvfKv0SN4UjcjTiBA51KrXW1YvRUIUzht0nhDGaZWJiIzPevdPW1GxmkZag
    is3p+tW9McfZATGBA6cWQ7VDN1iIsYoXYiMOWzBbmpSZxPwgq9UIi9JrLZaf1UHmN9DwJf
    tlZM+ttAiYf2T2rUj9eYaeV4DcBq1XAmQDFAkr41hiVz0RNvx25aU0Jp/maaXYUV2kyifA
    L4SUA9DioYxi/chLz1IUtgxVi21MCe++pV8mtMfV6db3YmedZj4HH0CLiwUbGetcJ3guC1
    o9da2h2+KOImBC0KEvYiFTLOBExrfUHFACVqKvKL10P5RRx2PusUFP4+ei2ddniI40Kvh6
    KoZFn9fBya2p+XaZdwVWMEK7vr8YZ00YnJOd8OKQ6DiwLMuvdKvJCnek9JEXTfQ5j1dCxQ
    6H0uugbT4IAaPNfZPyxuj4BDj3yaIQLEFcE0S/NAznLD8G++R0JOBP9a28z7inBN6ANt23
    x/hPnz1xbz6W60TpE9d8uQGlDqNMQTIWwBobY+1b6UFsSp6ljvSbIh+cb0yg
X-ME-Proxy: <xmx:uQoeasWO2WpBOJHpM9dCyyx235eCgf4_V00dcAO1f1mrRr0THFWPOQ>
    <xmx:uQoeaqD9wxXZftHU6QYWU_VX6pNpmc9r2WJ6GvSwe92KZHVcre6PKg>
    <xmx:uQoeav8KZzhNyeiltORwADytgxuesjPhw-Yslh7xBqUA-Rg-8eySsg>
    <xmx:uQoeahHcv2T6Z4bR4bWC5loJvrXtpDGTNUS2jYQVo6E6vgwXASiwYg>
    <xmx:uQoeavhhfXdqRTVHziBc9ZDMCchjH2giztPz15Ax6R1l1w0qiZZSE1oU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 18:42:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] config.mak.uname: avoid macOS linker warning on
 Xcode 16.3+
In-Reply-To: <pull.2313.v2.git.git.1780065163866.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 29 May 2026
	14:32:43 +0000")
References: <pull.2313.git.git.1779901919956.gitgitgadget@gmail.com>
	<pull.2313.v2.git.git.1780065163866.gitgitgadget@gmail.com>
Date: Tue, 02 Jun 2026 07:41:59 +0900
Message-ID: <xmqqzf1d2894.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/config.mak.uname b/config.mak.uname
> index ce5e7de779..d4d55cb324 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -163,6 +163,12 @@ ifeq ($(uname_S),Darwin)
>  		NEEDS_GOOD_LIBICONV = UnfortunatelyYes
>          endif
>  
> +	# Silence Xcode 16.3+ linker warning about __DATA,__common alignment.
> +	LD_MAJOR_VERSION = $(shell ld -v 2>&1 | sed -n 's/.*PROJECT:ld-\([0-9]*\).*/\1/p')

If LD_MAJOR_VERSION ever ends up being an empty string, then ...

> +        ifeq ($(shell test "$(LD_MAJOR_VERSION)" -ge 1167 && echo 1),1)

... this "test" would see

	test "" -ge 1167

that would result in errors like

	/bin/bash: line 1: test: : integer expected
	dash: 1: test: Illegal number: 

While this won't break the build (the `ifeq` will just evaluate to
false), it can be noisy.

Perhaps

	test -n "$(LD_MAJOR_VERSION)" &&

in front?  We know from your "sed" invocation that we won't see
anything other than an empty string that is not a number, so I do
not think we have to worry about feeding a non-number to the
comparison against 1167 except for the "ah, no match, empty string"
case.

Other than that, looking good.  Thanks.

> +		BASIC_CFLAGS += -fno-common
> +        endif
> +
>  	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
>  	# Unix domain sockets and PThreads.
>          ifndef NO_PTHREADS
>
> base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
