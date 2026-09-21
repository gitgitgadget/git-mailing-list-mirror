Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E759A4B487D
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027093; cv=none; b=h0JovXRVnSlhCyCLtfK31t3M/l81QjDiUBrXhJm6GDeB/n62mV/UAwh9DHf4oLPSXmpRmV6SyM/P0FbvEzATHrTea0R5PhFB/34iJ4pmQErXOKluaEZOucP+ar7Q05icrvH5GIz11+WVqhXJsM6fUUDhgmrxFxKkKcGrfvur3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027093; c=relaxed/simple;
	bh=lWHrZa5z4cMEKfUJc3dkGRy7L9uqOu4Ulz/ES343W5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AG6JwGFvDaSgTULMVdvmeyL7SqW6niAaKVJSVrezuEUboKCxJQ3zd7nWrr1Bu2/XQdvgIL+JdBrn4ok9uS8XBEgVx5h4JEvV+J+uUQCVM746NJyS8md13kF3N04BrJ7F0eA9FBwbvSnCrKiNv8nhP7/FBY95rIExsCWljYVrq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K9KyEmDw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vzsS/GSQ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K9KyEmDw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vzsS/GSQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FBCD14001AC;
	Mon, 21 Sep 2026 17:44:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 21 Sep 2026 17:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790027091; x=1790113491; bh=dd0oOb3K7H
	YdhfYGBY2BP1OK241mMUKWD8t1QNf7GhE=; b=K9KyEmDwLcSF5jlPnCYRBcwLfE
	b4I6sps6PZoGhqmJzHscmSa8xB22cTbYs1fIRfZmHovTt7b/JigFD011n28qX4m3
	4orJkdjYMDaKCdh0w6YmV9lcf07qUDbsSX1qup+VtbegUrJ4xya4JTnDxNOMGr/L
	DiEVfzBx8X/WG/82KK2zpmA2YnuTv8rIvSBDEEt7uxYSGNC9JF3S1Rl0taR2pn/O
	Q8T2li1yG4kB9AL3yFC0gtR0zMigKDMNMK8rnwUIq6eh5gfs2vXdYTbwhwISOP7q
	uR7J1kgCQ1TzJ1O+/3hVfV6Kn9N/MMZcEKF+FpPXzFkm7faZJ65QVqkqtv5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790027091; x=1790113491; bh=dd0oOb3K7HYdhfYGBY2BP1OK241mMUKWD8t
	1QNf7GhE=; b=vzsS/GSQmw7xUXe2iN076Vad3IvaxANWe3Gx+/8RW9gcAtrlE1m
	lxEqAPeFm3GRpAgUP31JY71wBonEsraCgDBAkzTCHp5NzhhhVGnOH9frEMBKShWp
	lcPBa75vqG+DTEmm15lLbeaObdt6g6D/kXun7tlb9Tj+g0LohaQ4rAwcZjhl9zuJ
	e+V7uYY84Cfbcn1Lj4vOgDuZhjDYUcR4kvfeYd55j/zzsuIHWrL1cmHP9EYUlp40
	QMbhoSR8yX6TJmJZ3sdli62S9dE3Ds39vlQKRzYB82P0qHoGQUl8y4hYuToOzipi
	DlTYOybWxwwHTNzzcwu2f6umMu5NkVGgt1Q==
X-ME-Sender: <xms:U6WxarXR2XQx-c8DMsPSIpkMqTvYpJKA3ssPn3JvXYOwiRsp6OfI_g>
    <xme:U6WxanQpdLMkrbXEv2OK_BaPITRmDy1URMJMHPIMENRaXgLPsQhlozEXdBnZUqjja
    VjwG9Tjyq9EPrX652psoKqrO1PB81ErXJZSnjCQmP4dhbJPUZLAK5k>
X-ME-Received: <xmr:U6WxahM5Z90GT-yZZihIbjErJFrxjkMVMpOul_I27OCidXAdXTso412rLfN2NQGFbMuZ-hcdCOQla_RltwS6gvKCxDboJD6i8Slh>
X-ME-Proxy-Cause: dmFkZTFh5Qxd/sWFvsNiPUkT32a0KbGyqd8axdlrLUUPynGnknioSUcXLM2qRtDTfvWlg3
    P8NHSTG+f4fYoPcrobjISGm8SpllRWTsZcp1r9U9NsihUmQpRQlAbA341WM4iNfmLCtcTY
    hMeb4RdVyzsP1+p2H8lrgs3edst//n4zeI98Qyi1jjRo5mHKIpRLwSdETcM9cYJizjsew4
    6c+M6kRqob/wz79kFeTmbmURBFWTtEm/PVu5aSNs7uCMitpQqNrqjNLSeYBJ8IiVYXH7HO
    Zh++z97aYUq340jOoAEdkNyVU7FqLELxsO9J8W7q4+eSHFvjBOt4Zhx44YC4ei5nzgreLm
    Q/ZCGluwws3SOy6FuTZvFAZ9dCZ6TDKbM7rk4lGf6NnPhdRNRRH2yy64xEg8meBAb8kR6D
    +qQzR/m7ZRIkrtPVpf2ZVosO13raCMRAOI413/OrTHZlF5W72jGdVD2GcDJndmEM4zSrsI
    n6QT5yRYamha7hwshSq5BPbxpRyuJyfrr5MGjyH+x0NiJsOxuPW+xYck2XDknQQ11Fmfp9
    Zq0hA2FZLrlsfBSBoqA6J/+IVm7UCeRxnf0dlal/aymVp5Y8+hZSlIwXhFl8Whmryk94pE
    M45HZ7/IIQXq6kn0DHalXMCxmyAFVJ9YLCmgP/3jOSquufeLa18ACoLF2WiA
X-ME-Proxy: <xmx:U6WxatTOq_0lamm7Mq7J_UB9_-v073BXzbHI9S7hYIWOGnLO7gE0YQ>
    <xmx:U6WxanhX30c1XnEDxz2o9EHLvB1-oKFrchI5VKXxmozNDImirPyqeQ>
    <xmx:U6Wxau8sfoROdmgPHVzG-rUtFTJ3JK1uCXDS4XOF7mVUgUxlKhiiYQ>
    <xmx:U6WxamFSdIK8WSBP0VYbe7dO9IB18UPTUobk1b9ayOK5irq8D21irg>
    <xmx:U6WxauGoSq2Utt6Pf_EPaSfx6hYe9ed5AJnYX5TvNsfxiViGPqBDC9aV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 17:44:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  newren@gmail.com,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 6/6] strbuf-safe: add init and release methods
In-Reply-To: <dea925f31647e7c08f3fa467b8058351b463f593.1789736540.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Fri, 18 Sep 2026
	13:02:20 +0000")
References: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
	<dea925f31647e7c08f3fa467b8058351b463f593.1789736540.git.gitgitgadget@gmail.com>
Date: Mon, 21 Sep 2026 14:44:49 -0700
Message-ID: <xmqqld8ul1ny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +int jw_release(struct json_writer *jw)
>  {
> -	strbuf_release(&jw->json);
> -	strbuf_release(&jw->open_stack);
> +	enum safe_result result = SUCCESS;
> +
> +	/* attempt both removals without short-circuiting. */
> +	result = sstrbuf_release(&jw->json) || result;
> +	result = sstrbuf_release(&jw->open_stack) || result;
> +
> +	return result;
>  }

This is puzzling in a few ways.

"enum safe_result" so far has been SUCCESS==0 and MEMORY_ERROR==1.
Presumably in some future we would gain other kind of error symbols,
but when that happens is this meant to act as an enumeration of
different kinds errors?  Or an enumeration of bitmasks that can
signal different kinds of errors?

If we mean "enum safe_result" is an enumeration of different kinds
of errors, then the "result" variable and the returned value from
here would be able to report a *single* kind of error, and it may
be common to report the first error we encounter, in which case

    enum safe_result result = SUCCESS;
    enum safe_result res;

    res = sstrbuf_release(&jw->json);
    if (!result && res)
	result = res;
    res = sstrbuf_release(&jw->open_stack);
    if (!result && res)
	result = res;
    return result;

would be slightly longer, far easier to reason about, and is a lot
more futureproof.  What you wrote, with "||", does not really allow
anything other than "is it still zero, or coalesce any non-zero
value to 1".

On the other hand, if we mean "enum safe_result" is an enumeration
of bitmasks, each bit representing different kind of error, then

    enum safe_result result = 0;

    result |= sstrbuf_release(&jw->json);
    result |= sstrbuf_release(&jw->open_stack);
    return result;

would probably be what you want.  That way you can add different
functions that returns different bit to signal a different kind of
error and or it in.

    result |= some_function();
