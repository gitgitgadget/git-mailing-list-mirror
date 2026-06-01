Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0121E885A
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780358059; cv=none; b=LFn7y9jyesTovVt3FHUnXVE3BeIeIKAHcthrV7DyuCl0Kng8bHDXoFHMvyB/3Lh+mjuW2SSkUHsMIKjXkstZFnZ7u/TA9q3N9e1aDtAF//fxK+ufBv36PvIKq0JsBQjuZmoXPwbBTWQKBEM2ZPECwkYXUP6tpFyCtPsIdeTpG0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780358059; c=relaxed/simple;
	bh=0VKTANh/8syPMvXkXQDRw6pL76yyyKXzGuGHtzBd1bw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=or7k4UtaGEHQaCj/0DDLpA1iSmHl4Rb+FOo/dE5aXr4ANA0RrQ3cDQmUwE0zRfMP18zg8ozA2vMYt5P7ZZpep/DMXezFciFHk14xDl+ed3DzQQKaF2SNRUwK7aqTKElAcL4t+6Jfb24fxDorI7nkVBQgAs3mVKaA6CbLxCUi5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nt96tnka; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WDYApIYa; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nt96tnka";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WDYApIYa"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id EF2EF1D000DB;
	Mon,  1 Jun 2026 19:54:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 19:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780358057; x=1780444457; bh=B65dfxZpi0
	2rw8hS/VMYDvgSIoFxEQJAy+NxjL5Pk8Q=; b=nt96tnkaYuM1wFbAk0+kCIjszv
	fYqh37666t4UKINrCwIwC5swCRZinDNveE3csux7QMst/gPo6Q+5mfta/CKsXcS2
	1Jm/zTlEMJoEiuNelgbcdi8UDOyb86Vq/qhtbeLJqfOPvxf7fUSkAzRu8OSVtCKY
	+IA+gegO23cLcfnouqFJNHYTXDcvocPJX3acoxsKeaOvTU8lW1qS9OVLDF0oKH5V
	w0jlvxhB9CSr36t0fs0FwDqsavVdcf4LRNDgLX9pksbHUxjhtGHmOMjhPZAs5aLQ
	8XdyIz0l5yGTIIv9Z1FoBFRUzPdkOCGUrsDD8uKXBtz5nR5FljVgFExfeY0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780358057; x=1780444457; bh=B65dfxZpi02rw8hS/VMYDvgSIoFxEQJAy+N
	xjL5Pk8Q=; b=WDYApIYazyeaQoZZc46ODEAhiadWLaEe3Xil//y94taJ1h7IEsa
	iL+SKvmTFbhkpfyo+0+90dIqawwM7G6rxgEOeoBuSJHDZjpCynndg4VBx0AnKVRf
	srIq/M9mpaBsnqqbgXi+/rKJOrCTK+ntgGgJHnE+DTzRVP238WNSOWQnGLjnIT7S
	VLR/2EUE/AYrrjSIGRn4aeouYK98bPhM5e4JWLeN3Qp/v1NNuSkRdek5DH9DISrN
	rYrtLgXbgUTSFLlzoNHpbCPdsWS21f+mzmPyGkHm80CDrQEYe2uLUDfKwE3UJmSV
	EA8kKvMxKg7jeEeILnhxqG3apxhN09hSU8w==
X-ME-Sender: <xms:qRsear07Fou0nuaAp7q6B2bkWKFDVOdDZ1SGc3WxWQp7wnTsxgpoeg>
    <xme:qRseapI4yLghT9IBevA_T4VR-iGywe5RX5r9NyvTEqHLGmObzoC4JiwPX4_1t-6va
    u-DZsTeDmmZsbbxikPmMTjKx1CdqAADJMexjT4PToz-Su-q5UmZ>
X-ME-Received: <xmr:qRseaiEAOOYO7WjjguW5H9TxceWRZ3M4QrlwsjeqxM5aGYBXKDbGHFJb3oiNDd3DasH6Jv8zmOPOSPWDqU2QYD4-1E3gJo-8EmiA>
X-ME-Proxy-Cause: dmFkZTEmlCliTcGmneNnAbLha7BLV8jIAfjZmtXw7hpyafp1DfMQLg6s3lYbMhba+IAVmG
    E/o0fgwFYFTnEz235Mq8C6sd0gKD88fVXqaoO/b2kVn4OKFCnxS4bsPtSQ0slsEkxS5ZQz
    0c7vjtJjokeLeJWgxGvFeXPMve4trVKPUfZxDOe5pt1kq9EodVpe+wpHEtbV/qwRD/GVKD
    LQVlJsFu7y2sH75GHdQF42WDPE0r1t+C0zBgsf7tRDLesD4NyUMF0a8nFGYcJAscvu/xlc
    qKt0gLtZ93wa8JMVuXUqLNwONDB8ZPW56uuaERdnSrODqSvVbkbBmMlWbYr0X5DVfCs3Mr
    AOoW0MT2Pa1XsXLkSzyfp24B+/YTlTJBOWTvqzPthUDqWHeXzV+cwAVjbEWkhGI9xYMdid
    XRhZ4/6Nw6qwcghAvL/vAQVEJaptr7PgjdLetWAHknVFKMqaruk6qyGwYB0c6IBgK2d6nP
    bjpdUHvug1qo095T10T0aJhz3lwca6snc4lIPxVj8bC0CaTG0luDrQKNHpOfJI4PzspDci
    mk9XL2yLoqbaSstSLv17QxhpQih4EnxX4843R0iWL2h71gYSgkG0XPIwvvl/c1wvBdgKFB
    qLO4xJEvqNysTSwnWJh5jdAMQhGNZYFIqjUnZ4u2yr+ZLsQzxHKiYVlXMHmQ
X-ME-Proxy: <xmx:qRseatXRSoeq0hQ-N0qNL1tXOSSPb_rroY9S5WmEdk48x0mukGSqhw>
    <xmx:qRseaixE-yHD_CTUcQL-lpHbkawQR-wdPX5C08KrKwGPMbSX58KdSQ>
    <xmx:qRseaqSMgxgohNFK1OQMggVfDAROoW0JsiC7ROC3L0jf_Lh1uDCVyg>
    <xmx:qRseamiKUQKO1PrtEr9j_EYw22FWD8C9Pa_PigUlawYNmVfOz1F8gA>
    <xmx:qRseaoHUS_bBKzIePaOnYUF44nachJuSHnjF9QcLRp7fwL14Bxhl-5SK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 19:54:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v4 5/8] environment: move "precomposed_unicode" into
 `struct repo_config_values`
In-Reply-To: <20260601154211.82370-6-belkid98@gmail.com> (Olamide Caleb
	Bello's message of "Mon, 1 Jun 2026 16:42:08 +0100")
References: <20260423160832.114816-1-belkid98@gmail.com>
	<20260601154211.82370-1-belkid98@gmail.com>
	<20260601154211.82370-6-belkid98@gmail.com>
Date: Tue, 02 Jun 2026 08:54:16 +0900
Message-ID: <xmqq1pep24wn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> The `core.precomposeunicode` configuration is currently stored in the
> global variable `precomposed_unicode`, which makes it shared across
> repository instances within a single process.
> ...
> Change the type of the field from `int` to `bool` since it is parsed
> as a boolean value.

Is it really?  The variable (or the structure member in the new
code) needs to be initialized to -1, so in that sense it is tristate
(unspecified -1, false 0, or true 1).

> diff --git a/environment.h b/environment.h
> index 514576b67a..508cb1afbc 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -95,6 +95,7 @@ struct repo_config_values {
>  	int check_stat;
>  	int zlib_compression_level;
>  	int pack_compression_level;
> +	int precomposed_unicode;

And the code does not make such a type change.  Leaving it "int" is
also the right thing to do for this topic, as its stated goal is to
turn the process-wide global into a per-repository setting.
