Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE9396D24
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776356488; cv=none; b=W8TMdp4HTnsxS7l1+XaJqBoSYJXoO/6Smuk594qybsF64C45RbKQtCd5du4PEuy17SGNKY/D6k340ZyyiMU0m6UYb4mGD7mlQg4w2lgl5slBovqDZbV9vLRy07evRFTGiCtpvibVQimmmbyrSpPT6g/vknbqNw4/3BPCd6nR5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776356488; c=relaxed/simple;
	bh=L1b1R1SHRlVbLwnejbpomfUOW1WfHSCdcxjmCAnptUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LT6Q9iwLWesS8zf9md98nahPY2JfSNo/gliIgAFEqo4xEZ1tgwrIxZfIvumXviNyqAhRopei2TLc3PenbzqY1+Aomdg+SR+mhX3xb17Hy2wz0EaAl4mr1ppifynbFoEqVWP2fPBVaKt8DwwBR5dIbDJfJYjHV43ENL0n6FiBb48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0ZYZoVsQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aScGz75B; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0ZYZoVsQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aScGz75B"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2530F1D001A7;
	Thu, 16 Apr 2026 12:21:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 16 Apr 2026 12:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776356486; x=1776442886; bh=YD6kZOXHAv
	mPyrDrQE739HqrDmtu5+GFzW8Ua8bTH+Q=; b=0ZYZoVsQKy4/SU9C/fmho6Sq2E
	rKN/R08XJJwST81FRd1EEfokiaS7UpPdKV3WR9iqnaao/fVptA8z9wiP9pPQ+mIG
	JADYNCR8IdmTsjHpj+/1EkFjrj6R6+M/Uo5cqsZW8j9HJKhGtyafU/FddzdXvpaZ
	00jbGumjw3HF4UclSSMbJR8aLRoy5cM3jdJYnfChbgbT8Ddr7B1QqopXfFA/i3hp
	ZSqQv/pBpsOCgcRna9YWDOoOvEnzkxHzq8RjG2aEg4dybfU2qdGOYd+JW1omFay2
	ibyVmuYqt3XXJ5q9zy40LzySaPavm/Ah7wC7vwdGvKJbf0dLXJx8JvIHpi2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776356486; x=1776442886; bh=YD6kZOXHAvmPyrDrQE739HqrDmtu5+GFzW8
	Ua8bTH+Q=; b=aScGz75BHPZwtHc+40VQUuxxulptLHzQe1fnzvTi9XMBfoJApGW
	Kk8+eApwNND+LY9vQ4tyYMiFhty6pxn1XG2WqcLwpRMvxHdLSD0rzch2cmBwGIJi
	YglUP91mOh2EWEZmC/QqAgbGuNrT2Rdnwndf6dW6d3jUO5KL0+Iads/KwTP1IXgv
	JYfVxhofhHsu2xpiYvvB7waQ6foyVDiuHdQI20YfVHyjqlPJm07NKF4QTBDHGJoR
	xubn6IEvntyg2qB6yQwZOcpZqrsGnNvVaJmJAS7aLY4Ctv1Pdq0iwmlKb/pW6Aaj
	07JPntmM789ZbU8UXg3Up0z/z75N+iTCWAw==
X-ME-Sender: <xms:hQzhaXNr4gTRtQ7APw9nZu8PMNXtLJ5FUAbUyFAlFmKk2pB3-WCM_w>
    <xme:hQzhaY34IWRz-kJNiXhZjZYo2cZx6TVx_5zrPCJhCDQzQ0deJ7qV05vT9vfWpNnJX
    vQtAVTVE41yStM-SA0QDJRTTd6u663_IN5J9RDJ40_kWN_eHHNxkzk>
X-ME-Received: <xmr:hQzhaekU1DKGRlJ9205BFDQROTBlkp_JQoGMdnRqnIW_iUskjeLNzDKeD83ddjrGldYiJdrNdnrdmkbvYFGOLcyLh4kHdRZ-GA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmh
    hjtghhvggvthhhrghmsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hQzhaXVngwna9D6L0NnvuE4pe-K0NtesPPvOxnPJbwQWVsQ_BGDTjw>
    <xmx:hQzhacvn1yYjUdJZ_KMeKMGmTiigwTPowOgccgC443LC-Z4q-qg1Bw>
    <xmx:hQzhaSZtTkE7yBukGvThtaTr2YMaBuoa_pNB_Mw58TaEDhHKyKe_Kg>
    <xmx:hQzhaTXltS2MajsQdyM5SOwjchtXbXe4HUe-uNOCUck8aIsFdi-d9Q>
    <xmx:hQzhaXML3A71I2HJXBxLRU36lGw0oe0E28OA-R6qWGAFUwI1844HMGDw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 12:21:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  Matthew John Cheetham
 <mjcheetham@outlook.com>
Subject: Re: [PATCH 1/3] http: extract http_reauth_prepare() from retry paths
In-Reply-To: <49488cc7d44404b9af55859dd892427bc8ee9142.1776331259.git.gitgitgadget@gmail.com>
	(Matthew John Cheetham via GitGitGadget's message of "Thu, 16 Apr 2026
	09:20:57 +0000")
References: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
	<49488cc7d44404b9af55859dd892427bc8ee9142.1776331259.git.gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 09:21:24 -0700
Message-ID: <xmqqecke3mgr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> All three HTTP retry paths (http_request_recoverable, post_rpc,
> probe_rpc) call credential_fill() directly when handling
> HTTP_REAUTH. Extract this into a helper function so that a
> subsequent commit can add pre-fill logic (such as attempting
> empty-auth before prompting) in one place.
>
> No functional change.
>
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  http.c        | 7 ++++++-
>  http.h        | 6 ++++++
>  remote-curl.c | 4 ++--
>  3 files changed, 14 insertions(+), 3 deletions(-)

Neat.

>
> diff --git a/http.c b/http.c
> index d8d016891b..f208e0ad82 100644
> --- a/http.c
> +++ b/http.c
> @@ -665,6 +665,11 @@ static void init_curl_http_auth(CURL *result)
>  	}
>  }
>  
> +void http_reauth_prepare(int all_capabilities)
> +{
> +	credential_fill(the_repository, &http_auth, all_capabilities);
> +}
> +
>  /* *var must be free-able */
>  static void var_override(char **var, char *value)
>  {
> @@ -2398,7 +2403,7 @@ static int http_request_recoverable(const char *url,
>  				sleep(retry_delay);
>  			}
>  		} else if (ret == HTTP_REAUTH) {
> -			credential_fill(the_repository, &http_auth, 1);
> +			http_reauth_prepare(1);
>  		}
>  
>  		ret = http_request(url, result, target, options);
> diff --git a/http.h b/http.h
> index f9ee888c3e..729c51904d 100644
> --- a/http.h
> +++ b/http.h
> @@ -76,6 +76,12 @@ extern int http_is_verbose;
>  extern ssize_t http_post_buffer;
>  extern struct credential http_auth;
>  
> +/**
> + * Prepare for an HTTP re-authentication retry. This fills credentials
> + * via credential_fill() so the next request can include them.
> + */
> +void http_reauth_prepare(int all_capabilities);
> +
>  extern char curl_errorstr[CURL_ERROR_SIZE];
>  
>  enum http_follow_config {
> diff --git a/remote-curl.c b/remote-curl.c
> index aba60d5712..affdb880f7 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -946,7 +946,7 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
>  		do {
>  			err = probe_rpc(rpc, &results);
>  			if (err == HTTP_REAUTH)
> -				credential_fill(the_repository, &http_auth, 0);
> +				http_reauth_prepare(0);
>  		} while (err == HTTP_REAUTH);
>  		if (err != HTTP_OK)
>  			return -1;
> @@ -1068,7 +1068,7 @@ retry:
>  	rpc->any_written = 0;
>  	err = run_slot(slot, NULL);
>  	if (err == HTTP_REAUTH && !large_request) {
> -		credential_fill(the_repository, &http_auth, 0);
> +		http_reauth_prepare(0);
>  		curl_slist_free_all(headers);
>  		goto retry;
>  	}
