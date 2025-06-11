Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F11EBE
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749600565; cv=none; b=DEODsA/ITwJ6dmoeahtbxMMshQoiXvKWjo6xP+uITIwDbxF82ZVBhjl3ObKA6fKDKcere7QD/idLgaCYvW5uzZr48vTVvABvoSgjqARGAI/14xrip3oF/tN1JWo2K34djBqYI+RRseLQz3EECD44OBNSK/GBiGyMgG4Cg0FcMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749600565; c=relaxed/simple;
	bh=botU8lMZndxtsgEaKHY40QFw/R65ZVl9MKvneiFljAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DXitaI6p5NaOfYougN6QAWp/j5PYxUvsqyere+FyG3tY201LnXjQhuLwA3cjz+MshSvFjETQrk8pZNH4qVFDqUEeOdV6IufG8dzX0emefcc+uF8NdA/9MYUScFyXxGLo3RjfMn8hSmWJcrWqhqXBZFq6XyZBz98IGOpT5e5K+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LT+5Z4Xr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AcP5msXC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LT+5Z4Xr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AcP5msXC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3D03513803B5;
	Tue, 10 Jun 2025 20:09:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 10 Jun 2025 20:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749600562;
	 x=1749686962; bh=KZt582T2tJIyNuDrBvMNKR69oLVARgszcWvoJy0uqq8=; b=
	LT+5Z4XrfJoIYoW8JUWKYIJfaY8w1dTp/JUuFOqFGzeQA/pZDymHJTjUWYu2MJbF
	Gp2Xn7siHiOOQQ58O5iPQkv+2fnb2t70HBWsStuA3HCxNuv61pufAAXDCAML2Kgm
	QU0Ny7V6KVQ/WBHtkIXIBC1KMkpWCWuljjhtFkTImNE5CtPv4KUsT6fNZeryXvVZ
	qS3trMwHfmWjU/hEvUDwfBUkgQSyOpGLIAHplCPqU+Hu4FFnNVfDNlz9JGxBE0XR
	7Tad3qG/imwhsNrjtSMFk4K2c8lCX9jGVz0joOKakaQGdOzn6N3zXDwu1c9Wl708
	t+S0WzVKyna0aeW6tXMIcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749600562; x=
	1749686962; bh=KZt582T2tJIyNuDrBvMNKR69oLVARgszcWvoJy0uqq8=; b=A
	cP5msXCxs7Uc8Xrxbxfz91n624PHWYe7TB2oNJGQJ++iIP4GS5I1btEqrO0IPXdB
	u4esLQCsuqJO3FCcBn82n4AQpl12PWPS54jfi2cfoSpEWRG+eCoCB5auqPgcBmNN
	0je33lly3AgygRRIcknxhR/l/MsHsLZ14lTFsrDPSa56Zq9pDbaBD+eTia9QU5Hc
	yRMEm1UQ+CUwJtyGTS3RRtMeYxpO+gEV0NVDvQ18JB/rFlHfzOER9fpNiwTU7Xxa
	rk1jSm/h/xAlLvevKK/+eth4Cr1Z2XWFRC3D05VNIHK3ykKiaDTQKcLQQ3bjktlo
	Afx1yvNOpmS9WKbzgtAoA==
X-ME-Sender: <xms:MclIaB-TgdOA_KyIrKxkWR3OpYFEvzsPBViZ3Dpx5xIXwPXaPDD2LA>
    <xme:MclIaFua40Kk5VtswIfriBrFWhXtkISHNTTjgjW5QrWeDN1-ZgGjMvAMwnPyf2M_Q
    _qSDrDgKoBkseFCzQ>
X-ME-Received: <xmr:MclIaPDS2iSMThGpRT0Igqz-aov9_n8BMtT8F3pZs57K_6gzuf3SQxujO-k4cHqq9IvMrlFlkuwEhXO4KbQSQODiiv4DnjDFCxES>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmvgeslhhinhhugidrsggvrghuthihpdhrtghpthhtohepphhhih
    hllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:MclIaFfc0iSw42g5Vjd8B0Gpht30BnVWJaEtdOkB6YE9ajDVC7zsLg>
    <xmx:MclIaGO_Ne7LvpmFFrq0KHWVcce8zAJK0mHcHxh0mqAB4f3REYg9bA>
    <xmx:MclIaHkLAIEunwYFvwYo-Om8sCKkoxRVgFsHE4LK5fmFn6yb3dJkJw>
    <xmx:MclIaAsqfes0VcRUHdc4VRX_Ot7wzH8gtymAEINyrWk9CP29Xpjdpw>
    <xmx:MslIaNVpmyFxmU4RuTZhRlyM7TjCUKUFgVD9Bo6F61rVCs9S4Qsl714z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 20:09:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Li Chen <me@linux.beauty>
Cc: "phillipwood" <phillip.wood@dunelm.org.uk>,  "git" <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] trailer: append trailers in-process and drop the
 fork to `interpret-trailers`
In-Reply-To: <20250610123459.278582-2-me@linux.beauty> (Li Chen's message of
	"Tue, 10 Jun 2025 20:34:58 +0800")
References: <20250610123459.278582-1-me@linux.beauty>
	<20250610123459.278582-2-me@linux.beauty>
Date: Tue, 10 Jun 2025 17:09:19 -0700
Message-ID: <xmqq8qlzkukw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Li Chen <me@linux.beauty> writes:

> * `amend_strbuf_with_trailers()`
>   – parses the existing message,
>   – merges trailers from the command line and config,
>   – formats the final trailer block, and
>   – rewrites the supplied `struct strbuf`
>   without ever leaving the current process.

If such a helper function exists, shouldn't "interpret-trailers" be
able to lose quite a lot of lines, at least nearly as many as the
new lines introduced to this new function, by making it call this
function as well?  And that would ensure that the internal call can
safely replace the external call and produce exactly the same
output?  If so, that can be a pure refactoring patch that can become
a commit on its own, I presume?

> * `amend_file_with_trailers()` becomes a thin wrapper that reads a file
>   into a `strbuf`, calls the new helper, and writes the result back.
> * `builtin/rebase.c` now calls `amend_file_with_trailers()` instead of
>   executing `interpret-trailers`.

And then these two changes can become a separate patch on top?

> -int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)

This lone "removed line" can be avoided if the patch did not touch
this line ...

> +static size_t first_comment_pos(const struct strbuf *buf)
>  {
> -	struct child_process run_trailer = CHILD_PROCESS_INIT;
> -
> -	run_trailer.git_cmd = 1;
> -	strvec_pushl(&run_trailer.args, "interpret-trailers",
> -		     "--in-place", "--no-divider",
> -		     path, NULL);
> -	strvec_pushv(&run_trailer.args, trailer_args->v);
> -	return run_command(&run_trailer);
> +	const char *p = buf->buf;
> +	const char *end = buf->buf + buf->len;
> +
> +	while (p < end) {
> +		const char *line = p;
> +		const char *nl = memchr(p, '\n', end - p);
> +		size_t len = nl ? (size_t)(nl - p) : (size_t)(end - p);
> +
> +		/* skip leading whitespace */
> +		size_t i = 0;
> +		while (i < len && isspace((unsigned char)line[i]))
> +			i++;
> +
> +		if (i < len && line[i] == '#')
> +			return (size_t)(line - buf->buf); /* comment starts here */
> +
> +		if (!nl)              /* last line without newline */
> +			break;
> +		p = nl + 1;
> +	}
> +	return buf->len;          /* no comment line found */
> +}
> +
> +int amend_strbuf_with_trailers(struct strbuf *buf,
> +							   const struct strvec *trailer_args)

... like this?
