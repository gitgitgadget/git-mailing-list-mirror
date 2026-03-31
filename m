Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0306B2D3EC1
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994063; cv=none; b=QrpW2CcyVmBYKCA2kXvQDsXxRC8oy31XhyjQnmO1VGt2PfxfYHcpQUcAywoHoLXWA/mYnfcjlV8m69yUdpgMBC+3+lLxAQrCP6yZZRy04Un+uaaoYXFqmq3tUmCLFJosKy2mZty8tUbB0dKyWIhy5k3RBfrEqwbf6GSdpkiGaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994063; c=relaxed/simple;
	bh=G4CeES3FO4RPpBEFfHcQUAwgUKGR2vggCGxtOuIURjw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qGKm3fvhCckkl6niqaYH2fNZpYsnFoNFHNLIH6oXT9Lwlx/2iy8+IVuIVTHtuLWqzECKSuIvBVu1M6K9C+we7hl5qsAUo7NEhHMTib2QRE+0VfoTmU6OrTdAD0LTzkGkdvd7CtzoX85g6lZeahDK+O5cde4VmP+A6N7kdJC8jSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YHnIArhv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lnqags61; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YHnIArhv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lnqags61"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4781B1D00077;
	Tue, 31 Mar 2026 17:54:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 17:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774994061; x=1775080461; bh=pkQRAaeEpl
	P0pcx8tm9DF79wED5PnEh8MNpgQYlCNBU=; b=YHnIArhv77zWZNr/AelPgiSNMM
	sZAgDcm+JSkz9PnHTyNPsad7kX3xiJDh5pEw/GtF+6xPJp3gqi/AfQTXvzPC74nQ
	zaZ9NPK/nosVtvWtL8NDbsZT8O9qrJQyzyuZ5zKvPXi6TmJ1RGdYTqx1MmfAkIE8
	q6OkxCwFew1jZCzucoW/k243kWgNKyx2/oztIzKoFr77WEERanovW48WAttI7auP
	Tl5wXeoF/lACK/76fiLfEnOqMCpvHPIqzBkgfajRjM00lT2ySFsL7MFqKFiaGQsW
	9sfn2LBNfh3gYfeRzEW5SvWAjuWYU+Bi1NYCUeO++Anv79JrO1+hcbcHkUDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774994061; x=1775080461; bh=pkQRAaeEplP0pcx8tm9DF79wED5PnEh8MNp
	gQYlCNBU=; b=Lnqags61WdN5TmlNai4DJeKJ9Ms1Aq7hAXj8xFi0khd0fDza/0A
	m92uvgHbka2okBkXKacE7yNjVIkU6TkUXJQK/arBFqeKnBRVUf4a8TRFeABkQsh/
	fynwRWt7/PkjcClGS3DH8slh7ePj1FwwHccrVmvsE/WGc8BY+MRDJt2/Q69ZJGnn
	loYMplK/E9/MMzqafqngfMxgckol2GQCTgLyY8keV4fLGY1BvY3hdBKXaDmJktsS
	EWr7eYjzNDx51S9bwN2kGe5Iqv3uhFQTthCIIjMMr8Uvvzj5I66CogvWP0fAYXwK
	CYt2NnxABUgquTUmn6EsBIBtDnW6Ch5rL1w==
X-ME-Sender: <xms:jULMae1dQ7pu7y8l8LyH_2-lYNhPrrO-k1-hFpzaNLa-zPu7h0f-FA>
    <xme:jULMaXGLIcpmigqBMEXLBT4NF-7-kXwgUVpHOzw5IlQFXFjS5rTzhu0ZiZE7jD5JA
    YNdYxlJBZySmfpXwlsFybo0qSu-VTJVpLH1YOMlIK6JKb9JWTiC>
X-ME-Received: <xmr:jULMaUjbBPIacsdwOQg6bIjNTC6jCQSTSA89ZQ0ackHiaOS2xRffw79TPTRs7doV9kL85m-vJJfsvnuVy_wuVyk5wSDlBH2aaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvffujghffffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepkefhueduteekgfdtueegvdfgueeiuedvle
    fggfefkedvffduvddvkeeuhfeifeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:jULMaa9WTifPizyCaGeWun4CVmkx_rNN4u7Ifi8nA6RTpk6FVq6f4g>
    <xmx:jULMaTqgVrO1faI21eXgK7z2rxYv4l831n_PfjqaHGDHFPMRvCINLA>
    <xmx:jULMaR9A5s78mU9X_71tlcmxfAYua8SKsHBHmefhwVYX2DS4QFiKbA>
    <xmx:jULMafXZzc9P-1uTWy6eFDmwgJscTQ2SfU8f5f5CJ_zi1Oy3jCJdrQ>
    <xmx:jULMaaPmBrzaEdDy84Txdo0TVqQ2ULCPSD_5NrrMBDTbGCgSdSAQ2npQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 17:54:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH] apply: fix new-style empty context line triggering
 incomplete-line check
In-Reply-To: <xmqqldfql4hp.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	17 Mar 2026 11:01:38 -0700")
References: <xmqqldfql4hp.fsf@gitster.g>
Date: Tue, 31 Mar 2026 14:54:19 -0700
Message-ID: <xmqq7bqry8ac.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> A new-style unified context diff represents an empty context line
> with an empty line (instead of a line with a single SP on it).  The
> code to check whitespace errors in an incoming patch is designed to
> omit the first byte of a line (typically SP, "-", or "+") and pass the
> remainder of the line to the whitespace checker.
>
> Usually we do not pass a context line to the whitespace error checker,
> but when we are correcting errors, we do.  This "remove the first
> byte and send the remainder" strategy of checking a line ended up
> sending a zero-length string to the whitespace checker when seeing a
> new-style empty context line, which caused the whitespace checker to
> say "ah, you do not even have a newline at the end!", leading to an
> "incomplete line" in the middle of the patch!
>
> Fix this by pretending that we got a traditional empty context line
> when we drive the whitespace checker.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  apply.c                  | 12 ++++++++++--
>  t/t4124-apply-ws-rule.sh | 16 ++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)

There were only comments on the unnecessary uses of subshell in
test, which were fixed since then, and I've been using them in
production without problems, so let me mark this for 'next' now.

Objections and better yet polishing on top are of course welcome.

> diff --git a/apply.c b/apply.c
> index f01204d15b..e88e5c77e3 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1796,8 +1796,16 @@ static int parse_fragment(struct apply_state *state,
>  			trailing++;
>  			check_old_for_crlf(patch, line, len);
>  			if (!state->apply_in_reverse &&
> -			    state->ws_error_action == correct_ws_error)
> -				check_whitespace(state, line, len, patch->ws_rule);
> +			    state->ws_error_action == correct_ws_error) {
> +				const char *test_line = line;
> +				int test_len = len;
> +				if (*line == '\n') {
> +					test_line = " \n";
> +					test_len = 2;
> +				}
> +				check_whitespace(state, test_line, test_len,
> +						 patch->ws_rule);
> +			}
>  			break;
>  		case '-':
>  			if (!state->apply_in_reverse)
> diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
> index 29ea7d4268..8573e12f46 100755
> --- a/t/t4124-apply-ws-rule.sh
> +++ b/t/t4124-apply-ws-rule.sh
> @@ -561,6 +561,22 @@ test_expect_success 'check incomplete lines (setup)' '
>  	git config core.whitespace incomplete-line
>  '
>  
> +test_expect_success 'no incomplete context line (not an error)' '
> +	test_when_finished "rm -f sample*-i patch patch-new target" &&
> +	(test_write_lines 1 2 3 "" 4 5 ) >sample-i &&
> +	(test_write_lines 1 2 3 "" 0 5 ) >sample2-i &&
> +	cat sample-i >target &&
> +	git add target &&
> +	cat sample2-i >target &&
> +	git diff-files -p target >patch &&
> +	sed -e "s/^ $//" <patch >patch-new &&
> +
> +	cat sample-i >target &&
> +	git apply --whitespace=fix <patch-new 2>error &&
> +	test_cmp sample2-i target &&
> +	test_must_be_empty error
> +'
> +
>  test_expect_success 'incomplete context line (not an error)' '
>  	(test_write_lines 1 2 3 4 5 && printf 6) >sample-i &&
>  	(test_write_lines 1 2 3 0 5 && printf 6) >sample2-i &&
