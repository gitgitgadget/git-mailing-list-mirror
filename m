Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73A3C1096
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541539; cv=none; b=uhciArc4NyOt+fbuEZt7Oi4F+fH/O9AN5R1H6nKr/shjmrc9mHF1WT/nKMHGQzA/X3Svw5xHN9u7FTp87cOMpFsS/uTi+STQo4pXEzPbf5/k6nIBd19PdvcOqsvxwR6fzVX+JUNZloOcwJBWqQ6dWyiDYh1aZW92jqtJJo6xrZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541539; c=relaxed/simple;
	bh=ERzi91UsW3YJbtd7y8HQ7jLr0nHzMxu7VQPwK8uQ2o8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a9yQ6/3DxTQRJKoElYdsiSExjuQMMcSJnH1LehXTRdRaI8aA4v5hWMD0ku423hYpuAuD3DLcLwyn8CRIeJZrFbHk06WcNt+J2Bm2jOt8yLFq6jX3o4CuYfOF3hwR82wWjPFobjVlX01B8AfUB+mJPjVsM/UFGvSdQ3cPSy5G2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E6jHrXxP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I39NlZGk; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E6jHrXxP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I39NlZGk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5E4F21D0013D;
	Wed,  8 Jul 2026 16:12:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jul 2026 16:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783541532; x=1783627932; bh=Nlvcx5mP/o
	7vaUtpxnfdDSzs18wdhFaOKUTfoyBJd3o=; b=E6jHrXxPBChZYnTBloTC7Fbxv4
	szumrseeznJ9DtWVZ7FuKyqNbRjAkWGtnUXGnxlNXiizsiLrW43/WptQgHMB6yr/
	OjdL+rIPapI/XRsA9LbjTReikVFIr5VzDNnr5YjdFY/gocWHy3dJN4Tqp7rIaChS
	IavBTE3DB7fP2IypdkBxu/B+4ZlymeSxUz4TMSojWqX3/5aY49LUXiCpuPCdHF7Q
	agkS/dEPon6iElYgy9+DSJwMWBdaHz/BS6M8cwnycrrtIruNPj288sgyZa3SgYso
	YYVlzN3em84vdvCMmqJn8UgaGi/Y2LXgYuXzdVGwEhBtj2rBPaaeAgMWibhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783541532; x=1783627932; bh=Nlvcx5mP/o7vaUtpxnfdDSzs18wdhFaOKUT
	foyBJd3o=; b=I39NlZGkjkIrz2lBpFsVKemtmn1qPz9yQ/F5Us5osoiHuwwAhgR
	lPZnuMnfT2QUTuyOnVVUBo671KgXTDXHXoEwTFeqTpMxE/5Q+oD2ySnh/tC5mlox
	QieAqoAzZ8A9tYVPuCtKgj30EEoSh93Zuig54KCWcxjZtLLGCtsVlN5RtdbjWQmt
	vvJS72pqftACgZmUsL8Muaa5aBNySkakyRVUkn4RV4M05l4Byum/SMs/e728Dq0X
	T3mBFyNezlaWqn441j5ZXfEHY8T5i4pG24YDdeMeDOaEaHCvv/D+fY8fxaclPHHr
	xp0ORrUigjKyzRPDBklLm+sW6ikfDnCo++w==
X-ME-Sender: <xms:HK9OaoD2ijDx6zal46w-XADgNLPEtDEbNoXi4hkowoGhYBRGcFsHqg>
    <xme:HK9Oasz4b8FOCktK_M84MjPEf1s1IrRccgN_vsCpn_4QR_FOlKo5fb_k_PgWftnIA
    P42khCE5fgqULb6RR0Hu5mbxnT73MgfJRrFxar_8handiocDDzv3oA>
X-ME-Received: <xmr:HK9Oat0SiCUyJWFpoUbd82FiMYNuBmCtDO0VO9wcw6b_acXPEDv8s2JfYdnbO1r-jTvAdWwWaylrOF9umpdFVOtlQDFrNzW-gPTBE5Q>
X-ME-Proxy-Cause: dmFkZTFxZeORU2O06Um65088zPPf660cBG1M3mx1YSx/a078tjhH0B/uyevzPQmXFTVRoo
    uGzNVbymtyIMJbMmxW+CEJuTJhswGsBW4IWwXTF7fO/mZOTPPOx4ARrpXzsDUfidZ+nMeQ
    8nTSjyFTJYk/GZ2YOSRDyROVljeYslMpIzbEKQXe6l9UvqdSKsmbde/Ga5vgXb5F9GjjEt
    F5aXUX9Vam+Z3z7G5YCaeWX8YjsThz6UmLcq6EpOJpBFNR0AzUDIBiN8n+VT+uTa7I7wvW
    iVs7A0QGt++iukz2tzFTaxpyyj6zNW9LdaJz7KIZWPxbZj++m6Jh9KBJvoHrK0rJQPosmE
    00HUDSzNg0CCGXm/ek7b2d4Q0xgNPWAI9hmXVrftFQ72o5KwFTU2Rm1WR4MawOupvYC5z5
    vbEfSAAJ275fbc1TFC5DFRqjypgF7HxcV2bnCrd+aaFxN1NNcWyIzLyqk572AlzNfbKS/o
    nBfDf5IinhAEMT2fMt/21dhLZxhVq0FCS5eAtQzRD5bhN4jrQbvZRuw1sobRVrcDdtSNWe
    mXoy6HEakmE9qW6HhInbiHYVx9nGd4NO66gvI0Vkt8p+XmN4TfDodyIKXZ9lzAMXKnAvQg
    PE0o4MvYlSnUjC7U2u9bGQ0JKfPTrQYBLsuKdEuHHX7pUpPu1u1FxOBQ0QDg
X-ME-Proxy: <xmx:HK9OakwETtSgKycdgvUwOdFyBeFhchVapXi-DX3k9hCzHi4-vsxFjg>
    <xmx:HK9OasHw2KLUPkGbeak_FVMqWWR96Rl2EYmVLXx5ipXrvC8FIIR3GQ>
    <xmx:HK9OavZH5eAIRZXCO5wq7FIC2dTpVwde0ZCZWO93sda7SUsWEcpQ6w>
    <xmx:HK9OamAD6d6gOKBN-4E3r_sgt8DchDgTb1C32jjiUd11sAt5s4Dvhw>
    <xmx:HK9OatxiD0sUn4PXCiL3mRSLdsMkj4LyTT9TiS-uUscoFK2TxbpKFR1y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 16:12:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,  Glen
 Choo
 <glencbz@gmail.com>,  Atharva Raykar <raykar.ath@gmail.com>,  Roy Eldar
 <royeldar0@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] submodule--helper: accept '-i' shorthand for update --init
In-Reply-To: <20260708-submodule-init-v1-1-719456077262@atmark-techno.com>
	(Dominique Martinet's message of "Wed, 08 Jul 2026 03:33:42 +0000")
References: <20260708-submodule-init-v1-1-719456077262@atmark-techno.com>
Date: Wed, 08 Jul 2026 13:12:10 -0700
Message-ID: <xmqq8q7ltf51.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dominique Martinet <dominique.martinet@atmark-techno.com> writes:

> commit 3ad0ba722744 ("git-submodule.sh: improve variables readability")
> made `git submodules update -i` pass `-i` as is to submodule--helper,
> but it fails with `error: unknown switch `i'` because the helper does
> not accept the short option.
>
> All other short options supported by git-submodule.sh are properly
> handle in the helper, so also add the alias for --init
>
> Fixes: 3ad0ba722744 ("git-submodule.sh: improve variables readability")
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
> This apparently can't be used much because it's been broken since v2.49,
> and it's not in the help, but I guess we might as well fix this since it
> used to work?

3ad0ba7227 (git-submodule.sh: improve variables readability,
2024-12-11) is v2.49.0-rc0~107^2~1 and indeed we broke it and nobody
has noticed and reported since then.  An obvious alternative would
be to give a single-liner:

diff --git c/git-submodule.sh w/git-submodule.sh
index 2999b31fad..9a989edb20 100755
--- c/git-submodule.sh
+++ w/git-submodule.sh
@@ -285,7 +285,7 @@ cmd_update()
 			progress=$1
 			;;
 		-i|--init)
-			init=$1
+			init=--init
 			;;
 		--require-init)
 			require_init=$1


but since anybody should be directly running "git submodule--helper"
by hand, I think it is perfectly fine to teach it a short-option
like your patch does.

Will apply.  Thanks.
