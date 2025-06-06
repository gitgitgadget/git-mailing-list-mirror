Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41BB1C1741
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224149; cv=none; b=lyEoNhxG76mBg460cwCKtREI246FAhdeuj4LhF3p7Ezo5a21Hfm2KCkXdylS4+dV/vA4U7xRfwc/oeXpdJR8hlT+iPMJLJqatrQ53rQ18NduOaEXD8SM5cncIEnexKlithDPWAKGgurdbZVIahkcC1uMylQjT7nkSYdoJ7Xo71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224149; c=relaxed/simple;
	bh=FP9/EAWTQzg0EwooW2IPquXgDDqRK23GKYX+XMgoMhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mdBkcj6cBI1QWxlUR+sj4p/IWlR/BLduYjpCfbIuLT8ziodCDJ0fcb+RlpeETPUFB/yBWTaSOBiTJQpv5SkFEMPN3xZhn31YWvBp7AvLk9w+P7EH1OBcSWGraiGIdKgXdEED6Y7OHa2xDgGCMjhonKSOTv8C0MV0uP1H2IRjYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GhJQL0U/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q/7WNFMm; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GhJQL0U/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q/7WNFMm"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 988EF25400E0;
	Fri,  6 Jun 2025 11:35:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 06 Jun 2025 11:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749224144; x=1749310544; bh=enZFiTZ3pf
	9/2LpteTFwKB8Gor9ri+VCAmf/4IVk/b8=; b=GhJQL0U/0p7ZyjZ+5U51aC02dd
	vzUVRuRDQcskT5kzEBdGiKrRGwNb1CIlkP94Df5PeXIS1sUejpNLEQCF9N4VN8hW
	hTEtGZ3DGZv1XjUoamcucYdJX0+fBO2NPUQkZ2gS+fcI6HSvcqnP5tdRcqF6iEgz
	MzRVi/k9rFiuLVyBwwdZLBJlKqiJGgjvyLkOod7qa14+92hOgCB+3UHjKqRZBSUV
	T+6m2acVyRjJWNe3xvaNyrJcABKILmJImfe4VLjtWKiGFoFh9dpdn7OSg+OLt/8q
	Vj6s3i78GGRzqzcjYAEJZkiFgHKHCA1phHT7/2z4h7a1xgwfSpcWSVmhOv7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749224144; x=1749310544; bh=enZFiTZ3pf9/2LpteTFwKB8Gor9ri+VCAmf
	/4IVk/b8=; b=Q/7WNFMm54ePn9C87z9ZCSdiOnqbLarCqWzWtgUtN6gPm/mvij3
	YvO3a4394g7uTr4l04h5Zfx+hXLDBmnKQQBqlRxv9DeWZvLNLt918z9lqbTuivMl
	kqapDk+kCwI/OyltBLJum5zh4QtAyhy1oFNMGtmv718hGfmHBteIgGNJkqIESox8
	kqd6X/YKUifCUPQiTx3yXt6J4+sBS9MRyrh31trkt9EawBsaUs6SxBngxztXGBUJ
	md9Y2YLmq/ugXVCssZSyBNTN64O8qdzSk+QBOP36gBC7TojSn+rJHB1R52Fjq9e5
	MTk3yBczpCUqnnoy25njSR605z6QmUKY/6Q==
X-ME-Sender: <xms:0ApDaD5zgYHNWzNJvu-RZYX-DOzUGp1rpPGBps1IdTlWE1-pWOiMIg>
    <xme:0ApDaI7hxbpWcV8WHQb3oVX5bB4yQB8h1Ye211HE-rjHhgUsuYSJhzNi3ZONHiA5o
    uGVO9bI0DWYm6vXsA>
X-ME-Received: <xmr:0ApDaKf1Llko-CFpvtQDFiUZ4VdF_0aiKiOKfgClsxOjlf5Dyh0hgg6cauEBiRkXT_Ge1I-vKcs_0W2hlliGnAxB0jejy1n0jeDP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfefgveeffeelgfeljeejhffguefggfevuefg
    udekteevteduudegfeeftdegvdefnecuffhomhgrihhnpehgihhthhhusgdrtghomhdptg
    hurhhlrdhsvgdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0ApDaEIOira-TsC4TcQP6nc4WoTFE5QrDI6UonyTV3WWxGSs0ukngA>
    <xmx:0ApDaHIis15J6I2_8GDMvPdF1iyRrRZHlu1-VmaW6QHA7qmE6Bn0DA>
    <xmx:0ApDaNyyNmGu2T5JZNo7LPxFd2Fu8bmzANIiLZIQBbCGX9Q5vu5E1Q>
    <xmx:0ApDaDJhaaZtZHXHmLiz5OQpoqjVdQcL-6uaoVQ7WMVbdcuisBWZXw>
    <xmx:0ApDaIqsWrviTSQQumj7RoTRG0_zEjM_6Lsj7QJ5NEsqYnh2flL74eUi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 11:35:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Jeff King <peff@peff.net>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] curl: pass `long` values where expected
In-Reply-To: <80de7491d24fb51c6b2c3b2fc1728db30e2477f7.1749202164.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Fri, 06 Jun 2025
	09:29:24 +0000")
References: <pull.1931.git.1749112304079.gitgitgadget@gmail.com>
	<pull.1931.v2.git.1749202164.gitgitgadget@gmail.com>
	<80de7491d24fb51c6b2c3b2fc1728db30e2477f7.1749202164.git.gitgitgadget@gmail.com>
Date: Fri, 06 Jun 2025 08:35:42 -0700
Message-ID: <xmqqy0u451dd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> As of Homebrew's update to cURL v8.14.0, there are new compile errors to
> be observed in the `osx-gcc` job of Git's CI builds:
>
>   In file included from http.h:8,
>                    from imap-send.c:36:
>   In function 'setup_curl',
>       inlined from 'curl_append_msgs_to_imap' at imap-send.c:1460:9,
>       inlined from 'cmd_main' at imap-send.c:1581:9:
>   /usr/local/Cellar/curl/8.14.0/include/curl/typecheck-gcc.h:50:15: error: call to '_curl_easy_setopt_err_long' declared with attribute warning: curl_easy_setopt expects a long argument [-Werror=attribute-warning]
>      50 |               _curl_easy_setopt_err_long();                             \
>         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /usr/local/Cellar/curl/8.14.0/include/curl/curl.h:54:7: note: in definition of macro 'CURL_IGNORE_DEPRECATION'
>      54 |       statements \
>         |       ^~~~~~~~~~
>   imap-send.c:1423:9: note: in expansion of macro 'curl_easy_setopt'
>    1423 |         curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
>         |         ^~~~~~~~~~~~~~~~
>   [... many more instances of nearly identical warnings...]
>
> See for example this CI workflow run:
> https://github.com/git/git/actions/runs/15454602308/job/43504278284#step:4:307
>
> The most likely explanation is the entry "typecheck-gcc.h: fix the
> typechecks" in cURL's release notes (https://curl.se/ch/8.14.0.html).

All of the above were good descriptions in a standalone patch.

However.

The first two lines that mention that osx-gcc job was broken are
valuable introduction to flow into "Nearly identical ... Debian",
but except that, but as part of a series it is probably a tad too
verbose.

> Nearly identical compile errors afflicted recently-updated Debian
> setups, which have been addressed by `jk/curl-easy-setopt-typefix`.
>
> However, on macOS Git is built with different build options, which
> uncovered more instances of `int` values that need to be cast to
> constants, which were not covered by 6f11c42e8edc (curl: fix integer
> constant typechecks with curl_easy_setopt(), 2025-06-04). Let's
> explicitly convert even those remaining `int` constants in
> `curl_easy_setopt()` calls to `long` parameters.

It is a but curious what build option differences caused it, as I do
not think any "#ifdef DARWIN" is involved.

By the way, I notice that we refer to 6f11c42e (curl: fix integer
constant typechecks with curl_easy_setopt(), 2025-06-04), so I won't
be requeueing Peff's patches.  I locally applied these four patches
and the result of applying the first three on the same base was
identical to what I already had in jk/curl-easy-setopt-typefix topic
(you didn't have to resend them---which was unnecessary confusing).

> In addition to looking at the compile errors of the `osx-gcc` job, I
> verified that there are no other instances of the same issue that need
> to be handled in this manner (and that might not be caught by our CI
> builds because of yet other build options that might skip those code
> parts), I ran the following command and inspected all 23 results
> manually to ensure that the fix is now actually complete:
>
>   git grep -n curl_easy_setopt |
>   grep -ve ',.*, *[A-Za-z_"&]' \
>     -e ',.*, *[-0-9]*L)' \
>     -e ',.*,.* (long)'

Thanks for being careful.  But I think it is probably counter
productive to exclud the first pattern (presumably to catch CURL*
and other symbols), as the symbols defined by the library headers
still require to be cast to long; see:

  https://lore.kernel.org/git/r1197994-o3so-6453-q16n-6n3on33n4nrp@unkk.fr/

Anyway, the change this patch makes matches what you sent as a
"these still remain" yesterday, so I understand that your inspecting
the 23 results manually did not find any "ah, this too needs updated
but was missing from the one we saw yesterday", which is a wonderful
news.

With this patch replaced (but not 3 from Peff), I'll redo the 'next'
(thank me, whatever your deity is, and your good luck that I haven't
pushed it out, even though I did it with yesterday's material late
last night) and push the result out, but it won't be a while (even
though we already know the tree objects should be the same), as I
want to see if there are other urgent changes that have to go to
'next' before doing so.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  http-push.c   |  6 +++---
>  http.c        | 22 +++++++++++-----------
>  remote-curl.c |  6 +++---
>  3 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index 591e46ab260d..f5a92529a840 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -205,7 +205,7 @@ static void curl_setup_http(CURL *curl, const char *url,
>  		const char *custom_req, struct buffer *buffer,
>  		curl_write_callback write_fn)
>  {
> -	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
> +	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
>  	curl_easy_setopt(curl, CURLOPT_URL, url);
>  	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
>  	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
> @@ -213,9 +213,9 @@ static void curl_setup_http(CURL *curl, const char *url,
>  	curl_easy_setopt(curl, CURLOPT_SEEKFUNCTION, seek_buffer);
>  	curl_easy_setopt(curl, CURLOPT_SEEKDATA, buffer);
>  	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_fn);
> -	curl_easy_setopt(curl, CURLOPT_NOBODY, 0);
> +	curl_easy_setopt(curl, CURLOPT_NOBODY, 0L);
>  	curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, custom_req);
> -	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
> +	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
>  }
>  
>  static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum dav_header_flag options)
> diff --git a/http.c b/http.c
> index ecbc47ea4b3f..d88e79fbde9c 100644
> --- a/http.c
> +++ b/http.c
> @@ -1540,9 +1540,9 @@ struct active_request_slot *get_active_slot(void)
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
>  	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
>  	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, -1L);
> -	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
> -	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
> -	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
> +	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0L);
> +	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1L);
> +	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1L);
>  	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
>  
>  	/*
> @@ -1551,9 +1551,9 @@ struct active_request_slot *get_active_slot(void)
>  	 * HTTP_FOLLOW_* cases themselves.
>  	 */
>  	if (http_follow_config == HTTP_FOLLOW_ALWAYS)
> -		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
> +		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1L);
>  	else
> -		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0);
> +		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 0L);
>  
>  	curl_easy_setopt(slot->curl, CURLOPT_IPRESOLVE, git_curl_ipresolve);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
> @@ -2120,12 +2120,12 @@ static int http_request(const char *url,
>  	int ret;
>  
>  	slot = get_active_slot();
> -	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
> +	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1L);
>  
>  	if (!result) {
> -		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
> +		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1L);
>  	} else {
> -		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
> +		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
>  		curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, result);
>  
>  		if (target == HTTP_REQUEST_FILE) {
> @@ -2151,7 +2151,7 @@ static int http_request(const char *url,
>  		strbuf_addstr(&buf, " no-cache");
>  	if (options && options->initial_request &&
>  	    http_follow_config == HTTP_FOLLOW_INITIAL)
> -		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
> +		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1L);
>  
>  	headers = curl_slist_append(headers, buf.buf);
>  
> @@ -2170,7 +2170,7 @@ static int http_request(const char *url,
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
>  	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
> -	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
> +	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0L);
>  
>  	ret = run_one_slot(slot, &results);
>  
> @@ -2750,7 +2750,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
>  	freq->headers = object_request_headers();
>  
>  	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEDATA, freq);
> -	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
> +	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0L);
>  	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
>  	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
>  	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
> diff --git a/remote-curl.c b/remote-curl.c
> index 6183772191f2..b8bc3a80cf41 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -970,8 +970,8 @@ retry:
>  
>  	slot = get_active_slot();
>  
> -	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
> -	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
> +	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
> +	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
>  	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
>  
> @@ -1058,7 +1058,7 @@ retry:
>  	rpc_in_data.check_pktline = stateless_connect;
>  	memset(&rpc_in_data.pktline_state, 0, sizeof(rpc_in_data.pktline_state));
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &rpc_in_data);
> -	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
> +	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0L);
>  
>  
>  	rpc->any_written = 0;
