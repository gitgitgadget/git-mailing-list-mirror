Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E913CF73
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882769; cv=none; b=gmO1tVA3vSGYBMHFbYSvtNNQyar0TWPrgjMAM/EZX7ngaElfRbqlh1JjUsz8+Ib8aHN6MXbuaOiiAXwgTD6nPrQ4jfBpzvNHdbVdDhtvBMaPhKsO8E2CpRajXxRYVOXopNYii6hlP62SL5PYvuucP877hZqcNMQ76kMzV4SFM3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882769; c=relaxed/simple;
	bh=Ye2J8SBeKIWpPu51YqG/nC9lCp2mSdMbM0o2ZHJX2xU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lJMYQGZVZcZCCO3FlQ9ta3Q/u9FJFsVwPgGpNxRDK3Aqwg9hvOkvUn0bB50DKf02PbMulyDH0QFY8tUaqRZlSRThm8JddnwBMbgakqrjL77ekf9X9xtxY+Ulg+FVJPRSK7sSI3uYXsW5uSgjhenBVrAvADHkJmw98WfoLyqOPQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UoOoHgLy; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UoOoHgLy"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 024691DCC56;
	Tue, 19 Mar 2024 17:12:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ye2J8SBeKIWpPu51YqG/nC9lCp2mSdMbM0o2ZH
	JX2xU=; b=UoOoHgLyaFDkB3cvOnB6avUmcB6mOvrGFY/cUmKu87GfW9pEcz5azk
	FXd4LGVIiW6kWC8qYnIxmin3lL7EIX/cUuMeOAqDQVS0ARlBAahLQXlx2Wpxyhde
	L9cNw7e415lk31vW/tmCkZZ1U252zF3jff4F1DrjrITDAhkdt97h4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDC401DCC55;
	Tue, 19 Mar 2024 17:12:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D21A1DCC54;
	Tue, 19 Mar 2024 17:12:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ignacio Encinas <ignacio@iencinas.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  rsbecker@nexbridge.com
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
In-Reply-To: <CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 19 Mar 2024 16:55:12 -0400")
References: <20240309181828.45496-1-ignacio@iencinas.com>
	<20240319183722.211300-1-ignacio@iencinas.com>
	<CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
Date: Tue, 19 Mar 2024 14:12:44 -0700
Message-ID: <xmqqa5mulycz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6E585B40-E635-11EE-B6E9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> Peff felt that adding `git config --show-hostname-for-includes` was
> probably overkill, but I'd argue that it is necessary to enable users
> to deterministically figure out the value to use in their
> configuration rather than having to grope around in the dark via
> guesswork and trial-and-error to figure out exactly what works.
>
> And the option name doesn't necessarily have to be so verbose; a
> shorter name, such as `git config --show-hostname` may be good enough.
> Implementing this option would also obviate the need to implement
> `test-tool xgethostname` (though, I agree with Junio that `test-tool
> gethostname` would have been a better, less implementation-revealing
> name).

Yeah, I like that show-hostname thing (which I do not know if "config"
is a good home for, though).
