Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08BC374735
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683076; cv=none; b=q/3FxQWv2xpRPytvW41Je1QDlPq1j9f7gjDS2VPzCySW+wVbxzVLTIdNRI/iVgBaebkV/3n4Z6pdzQQ00JBvSpy3yESwy+oIurfxGOFRa86U92gh003E/r2xHDdpzFR6AlbhbHzSNt9nj56qqLQzpkq8kI5ay8yYrN0Xev/v45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683076; c=relaxed/simple;
	bh=jRjFopZwAEkzW8QVykR/ESqGoXZdfD1qJSrfJLPAhm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=acwuIMKN5zx/QiWGNRTiOom4DG9Gz1Poyx+fH1TI05BkK3IdFYAHE9Ckf1ZPL84Ue48CmhQKiLPkWuYCOErx9zr8vWch5uZIA7985Gd1cq619WuiOcrWtiF8/qrrJPBnZbQPxz0KWjfQH+HCJSHN2SiJ2SfDlXlMlCacUm7CEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T/Y59eof; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cH44LrMG; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T/Y59eof";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cH44LrMG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E19261D0007E;
	Sun, 28 Jun 2026 17:44:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 28 Jun 2026 17:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782683073; x=1782769473; bh=P6dBaEctb8
	VCC97xN9iXqUwXBDqLxPZxEwQbaSCb5CE=; b=T/Y59eof0lXasfdqvPbhpUsc5k
	vAhJ3TJ+als+Oyyae+zQhzovSN+tTQfxxiZqCDkNO7S94f1EwiOuxqihAFcqTmVR
	Nwe8dv0HJ5uIHcGV4iWzKkkJsqOzEs/nAyH8oTuXnwlEeqXB64ytmL/bHDPD01J+
	8fjQwur3D+MD/37H6huYbjmcYPqsh9PW/Hyv9YrUhCJbrbA7uGv+XW63t0BcWs3K
	nn+oMP3pCNbuD/ZRZsBBQTSoHj0hg6Ynsy8YL+/KJ/ogVNQOrFoRlOKHZFv1C3Ax
	AlqhGcP7RoZyiG0ms0FAdtwlXb6JNHrt/4zh8bm7W1iynFA0EAH1BCCJ3ODg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782683073; x=1782769473; bh=P6dBaEctb8VCC97xN9iXqUwXBDqLxPZxEwQ
	baSCb5CE=; b=cH44LrMGSH1Oy5k+TjgxWq7Qewe6tHh4J3cC0tMBYeCi4JFTt3m
	H0/ZoXy6aClaCj9X5/7zVnKficAsMk0C1BEHCY8hrdidA5dPFb+T1ODhCXzut7S+
	pmKWg49n0zmwb/sudI2/FtLbSyptKC79lPh3cI3AvUe0A/X7ConnDHqWtozuIofm
	wJ3eiqr9X6KjQfkUWL8NUZmyZAFSD44QAAtfKlm9gLX1JAI2CQ2W4mDyJsL4dQ/C
	gHaJN4+RW1kLvAsu26cEBAMcduR5EBk+Hjux8ciD7hliwpAT3Xc/VfZsCEj/+6kl
	tT2Iz1J3Wk8RHcgSdeHPbAc1D2R0mVf0W+g==
X-ME-Sender: <xms:wZVBago6teJr8ykDKEC9nyKev_OIoVr5-EMTZTyYzz_TW3JjrukIoA>
    <xme:wZVBatiYs6ElX5beCnGs-SVTvnyYQheuAkB7123zcN5TrYnk3hf4tuNAXOpuTYtA-
    9ogroSCKhldQ60N5w1UVNY6JIRe94Ra-lmkziwOOBCDr4L6tNPkncA>
X-ME-Received: <xmr:wZVBati2_A5HVRZS_BD_ugxgC5D1mSYl6f3BEMnXYes2P56ijqBvYa4fSIPLD4BMGpCecRbvp2ybdQsYWBYpWwII5lbjFGmjfKuTStY>
X-ME-Proxy-Cause: dmFkZTEHtZz2BBU9we6jQvRhjT/5ZuTYtIaYxIcIH91xzGtAJES6ahUT3sqikeVtgSRS12
    4HRm012WuxvqwYHGsx3dwFrbYW3OhwwIxwXlcE/TJ6vA4jNFYPxTZOzzYg7+zlrwRfiPz3
    DcnuQNdCZHKHWpqouXPYGXFJGFnSIe4e92SJBTifvkpXgFPQR270MqIgRlLU7F6Ag9V3r4
    14RK4GzpXrZLCL/dgPNdbqONE0/NBkZD4IHGCu/G65u+jSo7fI/PMZcmhe91n1U8yBEybo
    y1QoUNJ+8f4rfJocA5rV7ErRhPm2+4dpiys7GJR6i/8aCGe1wfLNXLmJm8LBz83ww/V9ME
    nBholYJ8NRcloOTK0fJSKkdMRDdALk/Ko/RXIky6Ily12Bv0d9UrJ5MjCxuN7OMUZKBnw7
    /wQmbD1+7IG+o8eJZl7mIz2H5pXEOAXh4Oxs3HfzydZFCMXHSMjp9noHXvL8y+qdF+IjOk
    Sx9OGEluQuIzm69y5XNBsRtgy3tzWr5Ixfb183FyiSrxyoDo9tf55RRd8r2er8CIxsMWB/
    xOkPae/4aFikhYxh3k9sGfOBJtPX0PskWNWky7fEy6C8idMyk5B+87K9XBxOIvL4MtrQS8
    3KpYcyn7K7cqfX0bszBtNw3lX03ytmCF8DRtFopPkFJPWrZr2tIFGeDloYzg
X-ME-Proxy: <xmx:wZVBajgUodLNNlP-1t4EcND7GbeygAYiJvK-S9KE3TSpkwFlDQKiLw>
    <xmx:wZVBatKodc8OI_tzg6vfGLQSg4qgFqKtB4DAlavAH7nOnmzroSr8vg>
    <xmx:wZVBaiHnWczADlpT7zTsg0ICYTBnbUSpXqeeM42zFqNVBFwDL0zUpw>
    <xmx:wZVBahRXlM53PwSD_K5tozS1pKOhOj1C74XMJ3tb9VyjNTZ-8-1jbQ>
    <xmx:wZVBakDTIXWysRXoROSUecrIR5tYJAVxeb4fMtNfRZBGl4joKHHGoxW_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jun 2026 17:44:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Michael Montalbo <mmontalbo@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH 2/3] t5551: put many-tags case into its own repo
In-Reply-To: <20260628080345.GB107826@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 28 Jun 2026 04:03:45 -0400")
References: <20260628075716.GA3525066@coredump.intra.peff.net>
	<20260628080345.GB107826@coredump.intra.peff.net>
Date: Sun, 28 Jun 2026 14:44:32 -0700
Message-ID: <xmqqh5mm1gsf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index e236e526f0..cd851f24b8 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -397,15 +397,16 @@ create_tags () {
>  }
>  
>  test_expect_success 'create 2,000 tags in the repo' '
> +	git init "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
>  	(
> -		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +		cd "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
>  		create_tags 1 2000
>  	)
>  '

While all the other repositories used in this tests are bare
repositories, this new one is a non-bare repository.

It shouldn't make any difference, but since I noticed it...
