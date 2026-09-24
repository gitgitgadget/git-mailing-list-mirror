Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764AF38F954
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287723; cv=none; b=Fc3pq3Eq1WDIyerl9fJLeQbonstsM3CwNWvG1sb4DG/ZerJEY7y+fBV0kBpLIC4WuUuK0dVe5uai0aMXuzoegGDi3wjSPONVr2NWl719ol7Azb9mCEcJ2C40yxQAW0Vi5hNAQ1WNaPOBYPti39bmLDPTGuMvLSMLU3QwfiJXYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287723; c=relaxed/simple;
	bh=ulJb/aKKKrQTmD6sju4kN6U2UJWqshh8fjAUfHNEoM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jOMmfmhkTdu3Hz4K6GfrBZfpmGt/eYzgo3ZyvSdruv3wHQmhQCMe5tEWGGt5RplHP6425RvNUt7PUWDYtbPNapN6IAnWuZj48A4oxHrlLFjwP+9lr/rzXGy5MSLWL7Gj85i8QbHr0rPQMe0Uez33kTVW2NXN4RbahNQdpYW5uk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RNhwxVqu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qlE5tAFu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RNhwxVqu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qlE5tAFu"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E2DAEC0190;
	Thu, 24 Sep 2026 18:08:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 24 Sep 2026 18:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790287720; x=1790374120; bh=/IN04uS2ui
	wVLTp2fs1ZpqmRs47CsrteoZiU0qaI14s=; b=RNhwxVqu9HHRYEhK3PCyjTUxjB
	uiLFye1AEw2sevqZ51RNAoeNS+TZbLMeCVehL6+6bW0XnikvtwXE+bCIl0SgHoZd
	igghf7F5w66JXqSpg8U36dr/KwjnVx4MtK0GmcsCYrxaO0fk8ZeJ3uJ3RVN/Yczv
	eXa0Mvw82UvvtB7+NFgRGMGYltUE+r3N93QgYtOpQFY5jBCzh9Mv1VYOz9VAPJnI
	qgD0/cnrIV13FsNyzSe+GfwyLCkblcUVFjZZDB/Wrvw4kR09eyT5KVtVxtEm8+lg
	cIeviZDxHvMzEeP4vsNeRHRwQmkH68M9nE+nY1jh1QN4uNIymdOmKzmwforA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790287720; x=1790374120; bh=/IN04uS2uiwVLTp2fs1ZpqmRs47CsrteoZi
	U0qaI14s=; b=qlE5tAFu953q8+AWl1hrOJmLbot/n4yx29FSQoyZyIdcqjxiSK6
	fSWWLHaBD9c9Jkz4gZQb8yLxRpTYB/eGSXLJd/e3MGuNxgDSaCcJNt9yA2Aa9uyH
	oHUdYjWPm7xacLjJApFKC00pwBwEVjwgpbHiiUuP3EQnDfdRCgmdNBblODBepA0F
	SSHhHnSP3ikU+jWVSebMbcRTZFRCWnW0N8TTlVTb/JA/S6hJnf2RqFJ00JcnA/WO
	t+BPwaKnGlp3yofnACsfBTxx9XB1vUx6phoRraTbl2Vwr7MOY/2EqgeIBxVEftnc
	96KuIEPyprFTL0gRocof5Wryy0RybbQ+TWw==
X-ME-Sender: <xms:aJ-1akfA3RCQFBUqa-dkc_Q7udPLGRxb5evlPFK6LhL61Pg_HTIcbQ>
    <xme:aJ-1atNozZ-A3t3nfCnBsD-ZwaBnK8yzim0q2K71LHNnP6cfykHFyM1yNw0rNoDeM
    fNXT5j9G_ox33qoBJzYnYDe2_YyJtLGqkCI-NE1K6fy0ynSkxfA9gE>
X-ME-Received: <xmr:aJ-1aqhBEaGuZXkpMJeMbo9acXHqo87eikzBWNr38at_3VAIKhPVSM8uonAgZaqCqiwUOnNI8HBpCGZxBzJVb8_HMx7XWLPHHE95>
X-ME-Proxy-Cause: dmFkZTGv1Nw1dDBp7tFwIgVzsZY3yzxcEdC4OazjKR2hUR+vI920Y4Se5ou04dPDk71za1
    0DGh0XVlftOjetDZfSK7Qex3DPqBa9XA7ylIg1dWRF262crCme5EfFlP1JstvzhPS4ppN+
    fXrrEGaqHQFowkFkTZobZYc4BIbtuUFEjg+ZFyorRz1r0snl6AzRDkOVXGQeDQvr5orTiI
    vdkw3hY2Fml6HIbGwoGOTwGTQ1IG/wJZnn5Ot73KvyRzmm1fgc1oXIns6MNd5DWuakLmWW
    xJLVu7d6H+eiUlWdCtMZQQsf3aV4jRnC9CPtPiXqCoPMmlVp5EjGrf234fg4rcbed5ZZNg
    zsGu2CgDrvzfftY0QTT7Hc8Pw5AB85f0TApsCMk4Lo82bSSkMAux8PaWFzpN+37bhvFG9+
    hStDAddALkWQFVarXLX3kgD1sJmLdCaEIAmLJzBJ7+F5ZE+LAzil7Om38Ifb3j1pCh06sp
    VbdVWS77aITrLjpiGKVNVW4VrStYe5Ot++x4Cxuw3429ddrz3dW+ix5QxNVtpjdRSNm9cx
    Gts9eSuWygwg75mzq/Ks1A4thLtTLl0cd+yWsvPzBmmQRq8urm+kEB0JefY1ZJSBOdHBe6
    AjsTc+lIwQVOGTM/xfVcDhD4zC4uUVCpxo73cpvlMgf7/Z196lG6OuxCY2gQ
X-ME-Proxy: <xmx:aJ-1ao3yVSX3rL-UiNOweHzphiHOm3TC_OP3bhhqYvE6m8eKpMX-jg>
    <xmx:aJ-1asgpwKrorhB6o4YJnG0-5hTJuDhVjxgeAOiB9CU8ET2g2kgJcA>
    <xmx:aJ-1agfIUZwCQb1To-cXtFsnPtJKXOIbPKMeoPIo2XLS44cp54zzDg>
    <xmx:aJ-1anmI5wh2FtVxLBbvukxt7ozveBR02O5fK60i4Hs6tYzGfhxe6A>
    <xmx:aJ-1auAJkOpy2VKiTX1OoTLoCt7pd8YTljxZaD1Jx0JxzJs5QpyApzEC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 18:08:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [RFC PATCH 1/3] t0009: add tests to cover more error reporting
 scenarios
In-Reply-To: <20260924120502.2642141-2-kaartic.sivaraam@gmail.com> (Kaartic
	Sivaraam's message of "Thu, 24 Sep 2026 17:32:19 +0530")
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
	<20260924120502.2642141-2-kaartic.sivaraam@gmail.com>
Date: Thu, 24 Sep 2026 15:08:39 -0700
Message-ID: <xmqqjyoaz4ig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Introduce few more tests to t0009 to cover error reporting scenarios
> when --git-dir is used.
>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
>  t/t0009-git-dir-validation.sh | 36 +++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
> index 4cba478e50..244dc07c0e 100755
> --- a/t/t0009-git-dir-validation.sh
> +++ b/t/t0009-git-dir-validation.sh
> @@ -74,4 +74,40 @@ test_expect_success 'setup: .git as an empty directory is ignored' '
>  	)
>  '
>  
> +test_expect_success 'setup: custom git directory with missing HEAD is rejected' '
> +	test_when_finished "rm -rf parent/empty-dir" &&
> +	mkdir -p parent/empty-dir &&
> +	(
> +		test_must_fail git --git-dir parent/empty-dir rev-parse --is-bare-repository 2>stderr &&
> +		test_grep "not a git repository" stderr
> +	)
> +'

Why subshell?

> +
> +test_expect_success 'setup: custom git directory with HEAD as a symlink outside refs/ is rejected' '
> +	test_when_finished "rm -rf parent/head-as-link-to-garbage" &&
> +	mkdir -p parent/head-as-link-to-garbage &&
> +	(
> +		cd parent/head-as-link-to-garbage &&
> +		git init --bare real-repo &&
> +		touch garbage &&
> +		rm real-repo/HEAD &&
> +		ln -s ../garbage real-repo/HEAD &&
> +		test_must_fail git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
> +		test_grep "not a git repository" stderr
> +	)
> +'
> +
> +test_expect_success 'setup: custom git directory with invalid GIT_OBJECT_DIRECTORY configuration is rejected' '
> +	test_when_finished "rm -rf parent/invalid-git-object-directory-config" &&
> +	mkdir -p parent/invalid-git-object-directory-config &&
> +	(
> +		cd parent/invalid-git-object-directory-config &&
> +		git init --bare real-repo &&
> +		test_must_fail env GIT_OBJECT_DIRECTORY="$(pwd)/does-not-exist" \
> +			git --git-dir real-repo rev-parse --is-bare-repository 2>stderr &&
> +		test_grep "not a git repository" stderr
> +	)
> +'
> +
> +
>  test_done
