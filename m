Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF52FB2
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730948572; cv=none; b=N32NelguAaGIkGk0wZRxhq4NC9bAXlEwbF9/jwSvyHscHM/PTXjTdR92M2MBE/0dnjVWntGjxjwTq/E2VHw6GldgISU93ujgM6YsTo1hrg95D7i8V1YtZrncmgkpiYyaS6X+XDuWdOoTOqG4erDmwRGfeKET08vDcSMBb/leKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730948572; c=relaxed/simple;
	bh=aFuMqybBmcPFmnz36Zckz2k1f8Hi6ec8ss5PXv7aCnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dTnsrXWhoSW8zENpGIqRHj/eLGb9FcuxpRw4XaiD9WkcYSK/Y4OVxSYEX8lCc0novsQInMRAkj27xvlW0vPUmDQ3og5Ky7P1KU8OdKH9mie5q6mEr1aF88E9PTJyF1J2y1oyTVqLEF0Ty/eYmvKuiRzO195ztLrJpT0VRIyn31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YZTOed+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IVJlq+oR; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YZTOed+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IVJlq+oR"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7202E254012B;
	Wed,  6 Nov 2024 22:02:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 06 Nov 2024 22:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730948569; x=1731034969; bh=DiId8XVpCj
	+zZ1v6HPa7+R5DEPg5ro6bVn0vw30MmsQ=; b=YZTOed+Y2HbuKstti8QZQjYoRP
	1Numw2waVf2Z1svgTYazVxUyacpVxxVLqO2gsXJCFz3tdzwVQbF7g+zJYi+c3VNm
	fMISqz9/BSzRV3gJ4iUOfhccvbgHDTkrBL2gE+I+k1NaBF21uuCX1UYscUavFOpL
	jna3cqaYesnhLwKXiPLiuVPJwsSeRnlnGhPfwyT72unzTP/9bDUuu9e2ZXXFFg4o
	othj3POcxbhIirtyEBBwIBF+CPzcEhnqDMKpY0biCmg6XP0ANebojUOkFvawtzjx
	JmwAM0I6h0g4AJfQ0z61RZLin42bfpoCybszvW+oNAUG0w04iklO3lq0sDaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730948569; x=1731034969; bh=DiId8XVpCj+zZ1v6HPa7+R5DEPg5ro6bVn0
	vw30MmsQ=; b=IVJlq+oRXQewhXZXXitGPG4wokxkXftbM2zHo6RnvVpQsZyLcX2
	4WwQnoEHgr5XisOCTa61rtqcbVwEvlIfFtYDO3qhleXw9ray7UVo7owxWrl6HSc4
	K5RaD99W0RSpH4Vpq4iSE8BoKXMcr6Td7+01iCBDfOYNMi8wKQDyBEaLaRB309eR
	6UQ5KEoJOgas/Ja10ZZP4Qutn1aAT4XH6gkmRtpmi6oiIOPix3n7ucUwxcTD7490
	rV8kgRTCJUs1vHnZ5JnJix+D2kcHr1wyE5zOKqLcaL0oUhE5XV3E4Yz8LuY1DCsK
	0/kmm8AWt/9wIxzXtELx2P4wsjMrxWCWzfg==
X-ME-Sender: <xms:2S0sZ_Ojl_W0dXQ7tnooRd2Utz-tbZ0HasgoE8ntV8yqbkhw9gARzA>
    <xme:2S0sZ5881_RVpexSraWygJxLGsiLSjRw0omrfvyW5hk99LOfFSQfkSrZwdtkAh6XC
    ULZtPspR5oLFXEDow>
X-ME-Received: <xmr:2S0sZ-QBEFwauY9jSpnXUcW01BzSWdpS5shAyj_JybAzxEO9CXvqq09kTCmyJFQMga6TWzvoTqBkS1r9skMW6TRA1eImmkvDQdrV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdefgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrug
    estggrnhhvrgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2S0sZzsSl09PA1A8afgvhIVts-sQfmGVJo7SGTbBBEZvAFQ9ERM76g>
    <xmx:2S0sZ3eJW9JfWICqL8lWSsgPdHoDJQtEZIDMYvttM3poJtJlLGpWvA>
    <xmx:2S0sZ_0NFTuyJ1X8S5YXupUDlGwIEEHQvL1A88xhyf2Purr7CWUcVQ>
    <xmx:2S0sZz_UYdD66VBt2O0334TCs8iHs8SZlUIr--disrlmcIaM3bzEQA>
    <xmx:2S0sZ4HeOdmP9UjQ8a2JDZ8SF4_Lyyd7YPEGu3r7i_8XMnBnLmQ7RVTf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 22:02:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Adam Murray via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Adam Murray <ad@canva.com>
Subject: Re: [PATCH] trace2: prevent segfault on config collection where no
 value specified
In-Reply-To: <20241107020100.GC961214@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 6 Nov 2024 21:01:00 -0500")
References: <pull.1814.git.1730937889182.gitgitgadget@gmail.com>
	<20241107020100.GC961214@coredump.intra.peff.net>
Date: Thu, 07 Nov 2024 12:02:47 +0900
Message-ID: <xmqqikszvj8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I.e., doing this, with an explicit value for the config option:
>
>   GIT_TRACE2=true GIT_TRACE2_CONFIG_PARAMS=status.* git -c status.relativePaths=true version
>
> should (and does) show:
>
>   20:48:11.662470 trace2.c:437                      def_param scope:command status.relativepaths=true
>
> If we swap that our for "-c status.relativePaths", then the outcome is
> the same: we've turned on that config option. But with your patch, the
> trace won't mention it at all.

which may be improvement, but ideally, the "valueless truth" case
should be given differently, perhaps like 

   20:48:11.662470 trace2.c:437                      def_param scope:command status.relativepaths

to allow showing what exactly the system has seen.  After all, trace
output is often used for debugging, and it is not unusual for a
buggy code path to behave on explicit truth and valueless truth
differently.

> So here I think we need to either:
>
>   1. Just quietly substitute "true" for the value. For a bool, the two
>      are equivalent, and this is probably an acceptable fiction for a
>      trace to show. For a non-bool (e.g., something like "author.name"),
>      though, it's an error, and the trace is somewhat misleading.
>
>   2. Put in some special marker for the NULL value. Something like
>      "(null)" works, but it's ambiguous with a config of the same value
>      (which obviously you wouldn't expect in normal use, but since the
>      point of tracing is often to debug, I could see it being
>      misleading).
>
> All of this is made harder by the fact that there are multiple output
> targets. So you'd have to pass the NULL down to them and let them handle
> it. Something like:
> ...
> diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
> index baef48aa69..924736ab36 100644
> --- a/trace2/tr2_tgt_normal.c
> +++ b/trace2/tr2_tgt_normal.c
> @@ -307,8 +307,9 @@ static void fn_param_fl(const char *file, int line, const char *param,
>  	enum config_scope scope = kvi->scope;
>  	const char *scope_name = config_scope_name(scope);
>  
> -	strbuf_addf(&buf_payload, "def_param scope:%s %s=%s", scope_name, param,
> -		    value);
> +	strbuf_addf(&buf_payload, "def_param scope:%s %s", scope_name, param);
> +	if (value)
> +		strbuf_addf(&buf_payload, "=%s", value);

Yes, exactly.

>  	normal_io_write_fl(file, line, &buf_payload);
>  	strbuf_release(&buf_payload);
>  }
>
> but you'd need to do the same for each target implementation.

Thanks.
