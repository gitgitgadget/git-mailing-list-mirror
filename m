Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26646358378
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788383117; cv=none; b=ox5kjopJLaGnh59OVez/VlilOe7ivWUYXHxAA936dX1uKuAyAEyHEDNN1liTykML6y5QgujGZEI/oCx5bmUUXXa3Nlrp8bRd4hvA2NZwyn726UsHZozhidXvu9CnNv39/7Lvl8OFZsPCVDjRFfvhaRgnd7xDWRwsvmbrmWMAtws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788383117; c=relaxed/simple;
	bh=W2+R1FT3NYCuN4H1Egis0QuXXofUQ6lmwzb0m4NyKtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pKyYih95TuVeIyXiuTyJf/8FjfT34Ida3Sz3Z3q8QTra1C9CGlia4/laYjfNGJNdEdOPNHlWhQwhTbKMaYZBaGAIOJVGt8n7Z0EuMqhA8pePrBWj1JxoglF+dqTNXoQu2OcKrXldF6PYN4wk88kHZUqyn+eChRm8wP17guvnbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PaqvWCp8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i+sZae4v; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PaqvWCp8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i+sZae4v"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id F258F1D00061;
	Wed,  2 Sep 2026 17:05:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 02 Sep 2026 17:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788383113; x=1788469513; bh=i4XlYLlzTJ
	sTM71wpyy7m9/VaI35ErLG9DXN4SqgtDY=; b=PaqvWCp8vF48HNdkRDYtL6Ne22
	HfA5VAyQN9QsfeSimnOnCsb84OlFISpGAnD2jkeH2Ymw4w4qU6/2CAXcdqvtQnIt
	27XFMEgilxxapeUgeEkdtKesWdEHLkjlbRuqL+MiSgAhRL7lDyoXcfP8fWPTrzxp
	5/Ajpls5h1XLq8S40EVemg/UOlWuUvUmtMny1SccMT1dz5xSR7ZWfG0TLIfZaAew
	kEc1YEfvAHj80CcdEF0iUynjyFgzr9OabVTbsT8NamDTckondMkmNVeUSWOGIjWi
	ZxqeSOzJFZggt+Dzy6i41JxhxOY7ZuaDLfnBpRhuzgK/X21bakxwvQUTCwiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788383113; x=1788469513; bh=i4XlYLlzTJsTM71wpyy7m9/VaI35ErLG9DX
	N4SqgtDY=; b=i+sZae4vDMwxYlbClnophDAPss+0VqUPtOhf2T53XxNtW2eyD6J
	yS2P0dOf7BWzqx863JESOeDuWRxnO2+BDozPlyt8sSST1D000Zts+sxHp+U5Yi0e
	3a7Vup35YNOKxscLnGdvRt25ZuTkt8nmtonqEtt0f0KBaEB55GPB9vdPBaeN9bMX
	vv3GCYxMcBOsu2KwZDZX8X7uyWWZHWViHc6GFVhFVmNaRaKd2gMFbGrcbnU7sDrZ
	UhdMoFcaov1iE+tUhySsXhAkQoCfBBK9WSWxK9uJ8wzcghKNs+1zcdIGdmeDvYoj
	UzJ8yga0jib5pvzPh5lWro9V/IFApNu/SXg==
X-ME-Sender: <xms:iY-YaqH_j3Smt3roAHUK7-BbzpLBUaGiOsJW4GGGADn0f4xNQ5djqQ>
    <xme:iY-YaqZ4z9Wvcm_uWfN0YoGmU60zholz8alf0lI1ZHpjhYBaXuZ4zk9hWcieh8l5J
    tTYTgt1lt-g9OZs2udon0YMVrn_3IOQpHv-10jQ6-yGrUmCRHL4YZzQ>
X-ME-Received: <xmr:iY-YaqVAUDA5jhLThq18y02DWM-q3e42tihqiuSMMHi_GjkZXZThuaU7xoId84YRAKCuJprWSl-XfSkouVe_ZDR3a_kHWb58bA>
X-ME-Proxy-Cause: dmFkZTF0yLxlkElQc2xK8kuCAAhtorSjgJ/NXN8rtxka7xseI/gBh3LhCtTds6zYtyQj8z
    1CyY6kJboIL0u5B4Jz04cJN++VI4NfTN/WYv3P3tA3ZrK/AXMfLnbyVnHDWsoeFq4/bvEJ
    2fsJsoP7SwZ1O+ll3D1jrs5fAC7zkAw67ZT6BejX4bZXO1RbX/7l+Dg7VOFSEEGHM5ovEh
    mVZJ8ht66+KxTYfpfBeWDVz0T5dRheACimMjnCx83wMTpKCYn7bhFweTiFGxPbw0h4U9gv
    PkbBBds63XslZlYDQnitZnO43lx2EjFWbG2F0zuC4LoE6rQmBcpGFwDFaGvOrSUc5wqVZu
    L7iy5drkhquTGD5+B15PJsS64zEYCngj3osUbwSv2b1T+tDVmpzTGyS/R2cIb3CYVmaP0K
    /d+uauwPQsG9NEQlUulDuyo8JDJ6Ehrd/LycVPCftgNnxAu82zn2G0dLNoFeY3dwfYOMat
    /0DBrdKbhq1Va5qONGThWhsfxU26SdnA5mv4i0Sf3fYw2idJa48brOTxtTaQY7aNxpvJEW
    mFM5oGyzKcdRGcouffReF1dTINDvJQY9CyzuWiE52fvIguQmcsWMIDQ0S2vnS7ZDICCxFy
    jyGRphl8pC+wnj9lZuC9h6gjVpHb12rvkm4WL9AMsjhcN7iwtbjfAu7UIJkQ
X-ME-Proxy: <xmx:iY-YagniRM9C0iGR4iEXyq-94v92_T1Bq7eOWPQbGy-i6B5hQcuv8g>
    <xmx:iY-YalDi8nnuns_pyUMyJIDiRLAh-923lWMBxSNMwjQQs9OuIjiD7Q>
    <xmx:iY-Yavg5NgasXpS1PhtXuAud_cyRdwuYC8MBK1fw6WCGUXeE8fTMAw>
    <xmx:iY-YaizPjmDqVOPoJRtPD1cHNga6rWuua3IJmfLpYgbjcaN_MzOqHA>
    <xmx:iY-YanIVuzmFaIgVlmJ6vMpFJVLJuAlPV4zx-3Lj9SP7UZRbydyQ_43r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 17:05:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>,  Todd Zullinger <tmz@pobox.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>,  Yuchen Tian <cat@malon.dev>
Subject: Re: [PATCH v6 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
In-Reply-To: <B02189AD-DEC3-4117-8505-AAFA56494822@gmail.com> (Ben Knoble's
	message of "Wed, 2 Sep 2026 07:45:38 -0400")
References: <20260902072646.GB70165@coredump.intra.peff.net>
	<B02189AD-DEC3-4117-8505-AAFA56494822@gmail.com>
Date: Wed, 02 Sep 2026 14:05:11 -0700
Message-ID: <xmqqh5k7gy9k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ben Knoble <ben.knoble@gmail.com> writes:

>> My suggestion wasn't really about supporting more cases, but just about
>> making the code simpler by having one less #ifdef. But like I said
>> earlier, we can't get rid of the NO_NSEC knob entirely, so it's probably
>> not worth worrying about the one #ifdef either way.
>> 
>> -Peff
>
> Right on. Always good to find myself nodding along with your explanations :)

OK.  So will we see a hopefully small and final reroll that takes
advantage of the fact that ST_XTIME_NSEC(st) would usefully hide the
NO_NSEC build-time differences?

I still am worried that something that sits this deep in the
callchain can easily BUG() when working on a repository that is not
the_repository due to the use of repo_config_values(), and we might
be better off adopting safe default when istate->repo is different
from the_repository, but other than that, I think the series is in
great shape.

Thanks.


