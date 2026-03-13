Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2C3D1CA0
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424319; cv=none; b=QIAZX/+FgnjYopr7etElpWvvtfwLRQAWyry6Jcx4bYYdkmyNlca0qXghiyLnhWd7bDy+2N6T7HuRg1nE1+kJTvVa1bhCXC3lgyrjCIqqfgWOjp3o0B8sVHPyMawO+OYVuin8shfZ701ka2YWZzvTors1526x2s+e+xG/3dHVOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424319; c=relaxed/simple;
	bh=VDRPKZcLkoWzplKBDfOXXXRCw1up4ni/s3JPfmTlIJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zv0OKLrqVEYZxGGQQnvfnZvjSSElHRxX7/nADFFIHdY/nUHAVAVTcKAG8l5NIP/DCkDSmwlRQYnKWACFh72JQ11VUTSWNezmi4SzaH/Q5aj1pnKEcP/CNis93hoZgxzTgbvwAnlSJWOwDXcFSwFlWSbZHzberkb1PYNf0XUJAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dIXyFAHY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCjehJMS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dIXyFAHY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCjehJMS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E639BEC00BE;
	Fri, 13 Mar 2026 13:51:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 13 Mar 2026 13:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773424315; x=1773510715; bh=nz1JfYQcxZ
	Tcg33AuzC6vz3128mlj3DEk4ZVBGgdVck=; b=dIXyFAHYMDKnRdNde0Mfth5RQR
	Dgmv3+krxYkh2fm5Y63/YiSPnYaVEmM/DqojKp/zS0ZV7fHUTccOZMLAm7wSP3dS
	U3SxhbfuRTDsNUwrFtY3B8KtMH6pBD/wxsJ0b/dzjmyZgARSEwoKpPBlKZH83Oi6
	nNO1o23mXyUn7fdM7g+a647kDVEM8yJjZpQjnuqXhtuWfuKUIbor4XvuADD14+Pf
	X3QiE4ej3QsbR+v2L/EgP7Hz6VuS58IYD+zYlFYg+vYwj5eWUnoBJKbSTJZsD5GH
	T7SLRAZdX/KrmfqaIV5oinQeZGtDM0ZXF1r3lRChWGZ7uMrG4zcGqrLbT6sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773424315; x=1773510715; bh=nz1JfYQcxZTcg33AuzC6vz3128mlj3DEk4Z
	VBGgdVck=; b=VCjehJMSmoNZcVcVsLQOulO2N+6q80LJGXYPd7dKfMxYCTKAxfG
	ac7E7i2FsaDLuoSA9JCxr5pJoyHP7RGFkG/qewPoBX+4PQG+3ONU6UGpU5b3xhFc
	ipkVdofglyNUWGaLWFTeKG58YDeZODxG/+9lbRq2JpTfiVALfPExNjeCxU2ZnXXz
	QssgDaHxc3gGf9Duy40+uY1Xj45taReJHHT0P5Hv8W+muVMhPBeLZtUcHFI7HTyT
	BrXfSkLvP5dSWz7quFyCCtxIQw9uw1IF4PeC8a7PfUbS+eDl2opQZLDhjJOKLAjN
	ZRiCo63dK2xXJ3CulHhWEDyYRdfY0nXl66w==
X-ME-Sender: <xms:u060aS_Rn50Yv3SmxFlwNIC-BChUt7zNRrmXVmUDdWDZUoMz82h2eA>
    <xme:u060aaJCIv7sW2XSkgxxPtPufA5pkKIETPjBJ4qVWCwsSBxWNBsmCJF0LnW6APZSw
    e5s6wkQyvOgaISKxTM-n8etnX26u-JTOYxeeeGnyej0AqyWs8Omcg>
X-ME-Received: <xmr:u060aVbzSRpOwo2J-iHT_uhdmRbFqPsjd5zQZ7Dx28wKWtffSRG0yvclEA-6gpRbFQxSYJK--Uk2ERW6hqkGInJWSnTUop_IMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrihhtvghs
    hhhjugejheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:u060aUJjLnKFDGRzTZojVFZEzMPhWhVI176QpU321UhltI-4mcYZgg>
    <xmx:u060abAKJ3KjC_eV9l_NHz1psLlAd8P3Dro891rAFS5hg-Vznkg4NQ>
    <xmx:u060aRouCzMBIUv1kkMq0G4pzZ0fzMQBKVCH6NtbLNJRWE8gr58o9A>
    <xmx:u060aegG-UAJGbK0XjzPfITqo_-PHDeq3G7Y9rUI-7T5ZLsopvWtnA>
    <xmx:u060aWLL3gy4U_sEOtmwckqejsVdWwzG2mWujp_213aVYVWB-zeEZdA0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 13:51:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ritesh Singh Jadoun <riteshjd75@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Modernize pack-refs-tests.sh with git's standard
 command like test_path_is_file, etc
In-Reply-To: <20260313161808.1242-1-riteshjd75@gmail.com> (Ritesh Singh
	Jadoun's message of "Fri, 13 Mar 2026 21:48:08 +0530")
References: <20260313161808.1242-1-riteshjd75@gmail.com>
Date: Fri, 13 Mar 2026 10:51:54 -0700
Message-ID: <xmqq4imj62it.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ritesh Singh Jadoun <riteshjd75@gmail.com> writes:

> Subject: Re: [PATCH] Modernize pack-refs-tests.sh with git's standard command like test_path_is_file, etc

Unusual patch title.

No justification given for these changes in the proposed log message.

Missing sign-off.

> ---
>  t/pack-refs-tests.sh | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Check CodingGuidelines and SubmittingPatches (both found in
the Documentation/ directory).

> diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
> index 2fdaccb6c7..dca0c77ca1 100644
> --- a/t/pack-refs-tests.sh
> +++ b/t/pack-refs-tests.sh
> @@ -61,13 +61,13 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
>  test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
>  	git branch f &&
>  	git ${pack_refs} --all --prune &&
> -	! test -f .git/refs/heads/f
> +	! test_path_is_file .git/refs/heads/f
>  '

The point of "test_path_is_file" is "we expect this path to be a
file and there is something wrong if it isn't and we should report
to the person who is running the test loudly".  That is why

	test_path_is_file existing-file

is silent, while

	test_path_is_file missing-file
	test_path_is_file existing-directory/

both loudly report the failure.

But in this test, that expects "! test -f .git/refs/heads/f" to be
true, the story is the other way around.  The test expects that the
loose ref file for the branch 'f' on the filesystem should be gone.
In other words, it is not a notable event if .git/refs/heads/f did
*NOT* exist, and if .git/refs/heads/f existed, that is something you
want to report loudly, now you are using a better helper function.

I think the update should use test_path_is_missing instead, without
negation.

I did not look at the rest of the patch, but the above should be
a sufficient guideline to decide what replacement should be used.
Be careful to the original that uses negation and you'd do fine.

Thanks.
