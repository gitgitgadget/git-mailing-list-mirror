Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D833C7696
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078069; cv=none; b=Jh0472T6QDXYjqMrJSFBeZWtUoe7WSTvsLphhsn46WXJTXqH7hCoDtxYD7KvA4BFbEVcBYtd9gLMMfCFe0VLTalGit+pIO3gPPSFRCzamFldPaYhA9Yb3v7cWc0tGv7GBzYkrV8GOSbNg5aQ8s+eT+/ufe4G4Nfj9tX4ZtlRH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078069; c=relaxed/simple;
	bh=Aaen4FsRv9vaTw/jJ9ZV3O0qmCJ41F+8xkoHhBluJF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQXqZYu7iIMNn48iAsL/Z4vo5fEapemcOlyTNJ2Q6zeTYMY5moZhvXAQlqqa8zKbLRWn2UGyX9aMIlp/gDkIL6MGuCjo5Qxk2Z0l+yBfqgzk7ruq1TCInhcNEskmiGX/havTWfTnPTe6Q8c5TsybdulkOILW/1+KsiKiRv5htuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bVVazZL1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cj1Y+bt6; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bVVazZL1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cj1Y+bt6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A33791D000D2;
	Fri,  3 Jul 2026 07:27:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 07:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783078060; x=1783164460; bh=Aaen4FsRv9
	vaTw/jJ9ZV3O0qmCJ41F+8xkoHhBluJF4=; b=bVVazZL1FHTOmhqU+S9ospeVPI
	AwkZDarsII7XubTjePFv7pBqhDTZJgGY/HWtpCi+RUzFCdslQVOybbQvma+52Q9O
	fvoYgaivE6w24JvfjvKYSOwC8MeYqbWvJmC7qhiCtU4j2C4qn6heQlzgUyJwO/GO
	HCUhKZLxb7Oc+g6oj8274CWQhf1amTA732uOOma0UX+WkGm+XsiBDKjTvbc4eezD
	FtVql9n5HwrznbaFlud2aYDS4KRD3X2CkyNrLVZmjN4f/UmUscn0YRo99VJPRXjd
	33NpAx+OFhhW9mg0ClCDSoi2IRNxvwGA49HXLcegqyOQAaQF/qLT3IBoO/gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783078060; x=1783164460; bh=Aaen4FsRv9vaTw/jJ9ZV3O0qmCJ41F+8xko
	HhBluJF4=; b=cj1Y+bt6bbzPYmkQ58dZ7h7Xkov/fE79GBJX5DdW6sHo0jDXV3+
	nQvBOLatWca1zldqBGnN3/Bx+ydAKMMF1qnxJiFwRZGUOTs7rfjFNt3++OZNY/H7
	lLjcms9yvQLVnlbjh07f9Uz8zaJfOeXWD3IikHaOaltdvF53EODMj/HUbw0fE8lX
	OVrl11soRN7mZ9XMe4ycTH1KaZominzu1xlwdUqG9xtCPffcmN+igDx8jCAdT9Ig
	TMxhDm47rrw4bPEyiHvzMB7K5PeF4nsGvRnRMQs/ZYjlsCGflgmNKAOwSh0zSLyr
	JX75liLk0Bik2dg9fL1JmFZ6khPKO9hWoug==
X-ME-Sender: <xms:rJxHapGNZP0BcTP2BYhdoapCwLe4ostUg5piXcZCdMYZ1FgLgKvtww>
    <xme:rJxHakUsQFO44Zx_1PPnEqts2uWiPk57Fsi-0w4hVMszLsob5CkJL_-qdkewuJ_Rm
    cKmxGaUt0lE1robl_tBQ-eGrPIf9SdoqxazQtEHEQJeItpmGa9C>
X-ME-Received: <xmr:rJxHaozN_fPtL6vhNTrGE9fkUdE70aonZfm42VYolqOHWrlHBNCpzHqRCZIomd_GrMDHYfD0cx5nDiS-bfUkjMXye1OftQ44Q8HOjMrePw>
X-ME-Proxy-Cause: dmFkZTFUH3EXMKFe/q2TjJXSO31Gm+6009hwuY+1CQ/T3pzb0jSEDLBuXP7G1H9igjjzu/
    ByF0toCxcnPPzN3ihujVnZrjEM3IZwGEtlucKjhCRY/K3f0mG8//c89cpqRwEvI/RGmTZB
    oZPK7/WdOc8j7acmF1/TVgzE0GY7CHL6nAib55GU2XMa9l2a3dnCo/EEPFhLBPoKKADZoU
    MaOLn2wbAjpCJsbj/Etwz42qxZjWFpl6GyDpAfcs5V1/7bw0/d6WEJiU9vsNm1ZQqBtTjf
    +6TiIV8wDQ8IK7p6yvcK2RpEC6vxTGfefs/mjniQsFVxvphXiEGPMlcla7iQggYttSFyNV
    coaEp8uPMmMSv771IxZnLv2w/6z6pOggOKOeLMLcEx3Ej1+2HpWtNqj+i2sGkEXnKbw7SC
    J9n0QPYS0Cl0m7fzoElXq18v6UY3Z6+53il5oVd2+R8q/MxBqRIuZKRcxGryS+I6T0G+As
    VB7jZQe+bAwzysSS45fqJx0TrA6d4bo4TcL/ULOn8+haNR3XEn5OSoCjpAw1emeggUtkpu
    XAAwOTsK0/rfT55+uepjVnIJV42zZ3S/EkgzCFTuZxU/GehMypJqPUF4Bzey9/H6qQKoXy
    8nOe8BfY03P6f/4OZBvfmoA/x/Jneh+7qqCcUjPYjcpaGXqMaX8Z9Ud3hYsg
X-ME-Proxy: <xmx:rJxHaqOVpvbNc1pGky-RhWdRFWE4ALuNxoXSGsbvVYwhW0KH6JVDxQ>
    <xmx:rJxHah6maOWwfWaw2x-tySWpyDcIxHfSSBMU8jgBjFXPo31Pj9j0LQ>
    <xmx:rJxHajOaDXijH3KjLH5aaapotAI0KKggbCCpRa56NH2LAryJFg47SQ>
    <xmx:rJxHanks7ZJ1Jizju6aZRaNFBtSwoHyD7JH3fXnABovVLv0ZL4n_3g>
    <xmx:rJxHaolzrpv4KHyeBthtR3Vs7X_bw0GZrOLMb8oqW_qn4hBg3q0go1Bg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 07:27:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 300e387a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 11:27:39 +0000 (UTC)
Date: Fri, 3 Jul 2026 13:27:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/9] http: discard hash in dumb-http http_object_request
Message-ID: <akecqPq4F702E8Cq@pks.im>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
 <20260702080707.GG2029434@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702080707.GG2029434@coredump.intra.peff.net>

On Thu, Jul 02, 2026 at 04:07:07AM -0400, Jeff King wrote:
> The flag handling could be removed if the hash-discard function were
> idempotent. This could be done easily-ish by having the underlying
> hash functions (like the ones in sha256/openssl.h) set the context
> pointer to NULL after free-ing. But it's something that every platform
> implementation would have to remember to do, and the benefit for the
> callers is not that huge (it would let us shave a few lines here and
> probably in a few other spots).

This answers an earlier question of mine. It would indeed be great if it
was idempotent -- I've been bitten by interfaces like this once too
much, where you have to be very careful to manage the lifetime of a
specific object. The prime example of this are (were? I don't quite
recall whether we fixed that interface) reference transactions, and that
caused a bunch of bugs in the past.

Patrick
