Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D53644CA
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342682; cv=none; b=jPzBXE2CpR5O+gEwU0sRVuhvTSCVYGAWtHr8Vs2t2K/0OVdgp4aI/pc9i/SpRNxcVDaQXWfp94unw8dst80FiE5wEsAJ3vlPtaUBo69pgt0NfXEuY0LdbH2wEzt/KqOlBHSRSNVcsCEoZifT1qAL8yPhprTB112hcnmPlwPZN3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342682; c=relaxed/simple;
	bh=5aVd0th4gCpbleihFCPf7xfKIR83lnt8H7nMs+kNbjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLAKwNRbCMHJJrb7EqYuLdGVVDEIqQJZdqeQO3hyStVUCYMhkj+b71s0lAkw2lMLPH2TRizixX9bojfeREvKdRqN3g6KqrHciTuHQDIDmELwRNpP2rlUVPrHcHMiFbJHQrlHpr4W7dV/K7NVcb3KknYr3RkYM0OJUyHC2La2ycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SriIVcWj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KViY2Gm5; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SriIVcWj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KViY2Gm5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 91D5A7A01DA;
	Mon, 10 Aug 2026 02:17:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 10 Aug 2026 02:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786342679;
	 x=1786429079; bh=QGkccLP6rk53CAs5/e/J6YVcbmAVeGLxMwe5nMCYxc8=; b=
	SriIVcWjLVLxedaMBcoekylmYWyBT/H5IOwbthOHQbz+/0n9rmN2dFxNXFSATRRY
	SdmQsFt3/izSkhBmmOhhhXKDt4RvstuWC1xR8GKlNHyuWKDYlUWquzM69Wthd3aQ
	vV9ePM26hsA6Etqaoy9rlppi1EDVp3nmuoW4zwFoMucviPPV/K3SI+8OFYztTN1W
	f1nMWUFsK/qNheAC9JTrbrZ40ov7YrH8Keihyys5eAeuyHzCq+hG0CJLRywjlLzl
	vIYqRhSaParAhiHVIPuY/6ujbNfmTp0Z+25GCeEaeH0ku0fZypjbsBwD9NgNUUQt
	tgz5Z+TSNPnJRNvlpdjxAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786342679; x=
	1786429079; bh=QGkccLP6rk53CAs5/e/J6YVcbmAVeGLxMwe5nMCYxc8=; b=K
	ViY2Gm59Su33lnuzMQpg8k6IuaEhy/zMQHoLAX7QtluPTj2RvzRDDJhb+Ocu6gyA
	e/eL/GASIrUfegVa/mFXCN/oAKmFYEgqFcOwvhyozBVPsgymMk4te5/Mfa5F4XBR
	5a+FvmdCIpykEhtOcmkmVa2111rZBNNnZXoSicvvr71i3cg1RPcw0MvhbJjhe28D
	fFeGOC71DiB6/i/DO/nwb8FNBNtIaevLEJM0bneEn2fhJPf3Z5UKd6cwCjmLs5n1
	lZG5Ns1iZUzbDMFtfM2MyaVEMCBJ1HShfmxSVr+a2eZmvbgiNv1EZzyAdN8uxCVH
	oFh/lOyJDCWTgzOIvP9qA==
X-ME-Sender: <xms:F215atn9xuNujkPypUwYNvtvQkgX7812msKw-Covc3364gZOyaBjbQ>
    <xme:F215avvxAxE-mCSagFVHMeJ-1k8thww5oOg842Ow3aQUpJANq77-rjrxL4Z4yp4QT
    vTsuRkiajuQ8wEsvXh8mHnfcnoyvGgEFq-TlkPnzZ6wUR2qMXjZA14>
X-ME-Received: <xmr:F215ar8cjCqPD9L8OKbAq-o4tFf2RECbSuasXzPcSUwNjgSguQY_HCiwIFuQohn5gwJHtVqC8pzKLry_cFiIerlEvW_zCrMrfVK5vQxtdg>
X-ME-Proxy-Cause: dmFkZTGJe4aKHrYe3Wl2uXB7MZBOT5BhfdMPN+PNAdcXaPC6hYk0D5Cw3T/7UiGizXBTB6
    EQq1EaU9uv15Bcu8lQjIVJaQcpU1/I999k5QHWduykSWN8uUcEQhUYyO+H0d3MABjMjq5Z
    UKHcPjZWHnQgwWt4XykwtrWXzRu4ydt9Bpff0RQcjmDdoP5+f4BQvM/j3fznAbZsjsqjHd
    01Fx9eqWwYDl6tsIovWVuSqTEoeq1TliAQc5Dt94nsD/rPQfIUgLSTshVXAtM4bc9o8Y/y
    1FU2IVgZt0XNeKLXrEUAO2W3ZY1MK/LuXt7keOuTvYSvnrf5Vq4ajYUyt/QB8/0P/bIWUu
    0jeYC2tpig/iHsCzP004UO4lRN3Hh0vZ/feOTt6J8Iuc12YxFSHx+QcNfmJuhn9K6BojTR
    WFqIeluZB/40II+iQPyrp5e02G0K3XHFvTBWyWStbLQqEmgCdUzfzYCfe8ML6oWhsFGxrI
    hWZkAwaHAZ2bDYpNoNxPlw/9ApUKVhKPNxLQG4n36ljFz/MtPAJKi0pNy70LwtghPbW74h
    i5Dlzz0tEdwpf8opNEIRl+fxDd1moNGg9XpPgBl7RaPAxP6TnMOrSld3o8v/LU1epFxMfr
    A5o72T6Px5FtG1keJTeQSztQMI7W+kciadDrC7HCz/SI4qizyJiqKMDnTXng
X-ME-Proxy: <xmx:F215apMBMacryA2cSoin_o3PmuXlowhao3kjRtGpeOP9xSi3HpEOEw>
    <xmx:F215apF64Vm_Xuuy7raSOgWQNBOkVEGBq5c6kWfR1-MC9HDsFZMdWQ>
    <xmx:F215anTPx5gFQIzl_2flqgjS91BEir_4xqoZSf8qDGkFBlsk_7epmw>
    <xmx:F215amvUnr4msixXeBD5EdUDU1gJIHPXTI1YalqJtmjJd-CJp3hjRg>
    <xmx:F215au185q3nbuoER6diOQBxUYWvQSHuDvG6kUm5FivTvNVhABRLmwxL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 02:17:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 93010678 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 06:17:55 +0000 (UTC)
Date: Mon, 10 Aug 2026 08:17:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
	Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] object-name: avoid use-after-free in
 get_oid_with_context_1()
Message-ID: <anltEAohp3F9Jbx5@pks.im>
References: <20260808200832.24313-1-diy2903@gmail.com>
 <20260809194212.77439-1-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260809194212.77439-1-diy2903@gmail.com>

On Mon, Aug 10, 2026 at 01:12:09AM +0530, Shlok Kulshreshtha wrote:
> diff --git a/object-name.c b/object-name.c
> index 83efba0ba6..bffe795830 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1803,13 +1803,16 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
>  			    memcmp(ce->name, cp, namelen))
>  				break;
>  			if (ce_stage(ce) == stage) {
> +				int ret = -1;
> +
> +				if (!reject_tree_in_index(repo, only_to_die, ce,
> +							  stage, prefix, cp)) {
> +					oidcpy(oid, &ce->oid);
> +					oc->mode = ce->ce_mode;
> +					ret = 0;
> +				}

The function only ever returns `-1` or `0` itself, so we could've
written it this way:


	int ret = reject_tree_in_index(repo, only_to_die, ce,
				       stage, prefix, cp);
	if (!ret) {
		oidcpy(oid, &ce->oid);
		oc->mode = ce->ce_mode;
	}

	free(new_path);
	return ret;

But I won't insist on that change, this is already a clear improvement.

> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 4140c4d8ef..e88946c254 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1357,6 +1357,17 @@ do
>  	"
>  done
>  
> +test_expect_success 'relative path to a sparse directory' '
> +	init_repos &&
> +
> +	# A ":<stage>:<path>" argument whose path is relative is resolved
> +	# into a heap-allocated buffer, and a sparse directory found at that
> +	# path is reported through it.  Cover that combination, so that the
> +	# reporting does not read the buffer after it has been released.
> +	test_sparse_match test_must_fail git show :0:./folder1/ &&
> +	test_sparse_match test_must_fail git rev-parse :0:./folder1/
> +'

Yup, this test indeed catches the bug:

    --- sparse-checkout-err	2026-08-10 06:13:59.698011294 +0000
    +++ sparse-index-err	2026-08-10 06:13:59.703981906 +0000
    @@ -1 +1 @@
    -fatal: path 'folder1/' does not exist (neither on disk nor in the index)
    +fatal: path '�[UU?' does not exist (neither on disk nor in the index)

Overall this looks good to me, thanks!

Patrick
