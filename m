Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C7022331C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876487; cv=none; b=FNNWoyXJl86d0yBaehq1CjSzzQP83hUKyMyGiFhZQ/ZVjAetY5PJJCr3tDEIzaD0Dp6HbQCzE6jlQIdC7FgICWdLm6seZXDZQJKBL92uQJMHmRnUh2x+p8M+UaJivE/7gyah/F/sytF9jSjLRc88Ib94yg9mDEXDlwlEl77+44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876487; c=relaxed/simple;
	bh=D9X+UqC2P4OFLSjFf4Kr1cprdmxuhzqNGdbL/T2l+yw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=vBRyOsbw50EDjuGoqldJJjluXBzhUB3DIidBPskh4Xo4A3hhmdBS1XUn/3WM6l/gnRHokfQZ+wJwO2M7S1ZWxXkd0TS27lssj4Vhrn+aFj8JD80WQvYTKwkW8NX+4wKZhM33YKEuT4F4+n4YpPYlYaMltb1pjktRk3IezOlZDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ucSIhFGd; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ucSIhFGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1748876479; x=1749481279;
	i=johannes.schindelin@gmx.de;
	bh=xjsZkNASdw2fBeZVc5P7/DR6h27ILvbNl/xIDx1Pz3o=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ucSIhFGd0/3e2qgYYha/JnWlcG8xzqNH775rawe0TSv5xEMa6lSc7KC0M6eIMNeq
	 hVT+lry4nQh5t8p8gAGl5VNOXstSmF8inoyCQgbVChtWf55JgGW8cGpNce6ifSuqc
	 PmXUc0+63y5vCK1LMehKeQcer/DjsS9WFl5ECXGZCBj8FI05CeQ4cNHI/zWiXv8ic
	 mJVneVc5UWprBextorbqkE5TF7cEsr871CMgVvOb7Fda9/D8n1FSEQDBb/j4mpR+H
	 fENCBhZoO/ZSC9VBkSspzwwXaNfEhZTTFNSGYbq5CfdsSG9qbsek190ZFLLvQftCh
	 /TGnABsUbmyYtqzIFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.83]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6DWs-1uFTst1dV2-007Csd; Mon, 02
 Jun 2025 17:01:19 +0200
Date: Mon, 2 Jun 2025 17:01:17 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Justin Tobler <jltobler@gmail.com>
cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com
Subject: Re: [PATCH v2 2/2] builtin/receive-pack: add option to skip connectivity
 check
In-Reply-To: <20250520163218.263921-3-jltobler@gmail.com>
Message-ID: <74668a00-5b90-2450-52c5-d9f00dcb42b9@gmx.de>
References: <20250520014920.201736-1-jltobler@gmail.com> <20250520163218.263921-1-jltobler@gmail.com> <20250520163218.263921-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DPO/FeexjNC5P9plV9Hj3cSGZnUGucDixUl2dvA9SWZAl00AH2o
 PWo7Ijs+oPfY/WMx0rPC3C2oQ+LmJO6qJK2HUA+lG5GCLa/JxtecYZrDRjwxiBdikr0NZKE
 mJsf1GKLoBlFa0/IbI6ZLFCReSZ+CW7OK2mIN35Fed0Ry5kF9PorCvNu5gLLQEaq4/6/Pc1
 v9+IGESREv7/Egu/1xVdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G3EvU2cpmAA=;P2BX/Zi00XLK3lzAkoq0qHdOAhH
 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
Content-Transfer-Encoding: quoted-printable

Hi Justin,

On Tue, 20 May 2025, Justin Tobler wrote:

> diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> index 9afea54a26..f76a22943e 100755
> --- a/t/t5410-receive-pack.sh
> +++ b/t/t5410-receive-pack.sh
> @@ -62,4 +62,26 @@ test_expect_success 'receive-pack missing objects fai=
ls connectivity check' '
>  	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse H=
EAD)
>  '
> =20
> +test_expect_success 'receive-pack missing objects bypasses connectivity=
 check' '
> +	test_when_finished rm -rf repo remote.git setup.git &&
> +
> +	git init repo &&
> +	git -C repo commit --allow-empty -m 1 &&
> +	git clone --bare repo setup.git &&
> +	git -C repo commit --allow-empty -m 2 &&
> +
> +	# Capture git-send-pack(1) output sent to git-receive-pack(1).
> +	git -C repo send-pack ../setup.git --all \
> +		--receive-pack=3D"tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
> +
> +	# Replay captured git-send-pack(1) output on new empty repository.
> +	git init --bare remote.git &&
> +	git receive-pack --skip-connectivity-check remote.git <out >actual 2>e=
rr &&
> +
> +	test_grep ! "missing necessary objects" actual &&
> +	test_must_be_empty err &&
> +	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD) &&
> +	test_must_fail git -C remote.git rev-list $(git -C repo rev-parse HEAD=
)
> +'
> +
>  test_done

This test case seems to hang occasionally in the "win+Meson test" jobs on
GitHub (I tried to find the same failure at
https://gitlab.com/gitlab-org/git/-/pipelines but couldn't find any). See
for example
https://github.com/gitgitgadget/git/actions/runs/15383915635/job/432791348=
37#step:6:627

Note that this problem afflicts only the "win+Meson test" jobs; The
corresponding "win test" job seems not to hang.

Even in the Git for Windows project, where the `win+VS test` jobs are run,
the t5410 test passes within a dozen seconds or so, see e.g.
https://github.com/git-for-windows/git/actions/runs/15383945895/job/432796=
89086#step:5:143
(confusingly, the subset of tests run in the matrix jobs differs between
the `win+Meson test` jobs and the `win+VS test` jobs, but if you click
through all of the `win+Meson test` jobs, expand the `test` step,
patiently wait a few seconds for the log to be lazy loaded "enough" for
the search to work, you will notice that t5410 is not mentioned in any of
them, and the only one that times out after 4h37m11s is
https://github.com/git-for-windows/git/actions/runs/15383945895/job/432797=
53911,
likely while running 5410, too).

Do you have any idea why this particular test case, in conjunction with
Windows and Meson (and only on GitHub) acts up like this?

Ciao,
Johannes

