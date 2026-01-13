Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71021281370
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768309786; cv=none; b=pf9obSkdEePeWQanTBEhMQpaf3QYoPzmwBA1NckaEyMY5I6Fv6em8Q3IzjUKhnVNtiHQQC3TkQpSXnZB76jhruYBdLUfRxwbCj0c3mnog7UTsqEAanxW2pIQLVmvsPFmAYBjt0QCUuC7lHbm41Ll7PuCGnhPZ6UUcJou62aBFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768309786; c=relaxed/simple;
	bh=e10rnvX7H/0ufISfcOEhViROoSwkPKVkkcNMmSjAb58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MnEcUhKCQeLcp6pML0hISXyyshrURJSZZw3x2PP+hiyeSsNtffFeKcd33oDzKvlqU21iMozR9z+c/j8OFnY4hUYnhG5sdYLmVHmMGOPcwqhrRoQG8+zSlZsrLCdbErcsDbXV3BivyU/mbhAXNnm6f8zCzAbWxtY0dbQu7991Nj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XUa9HVcX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L5EUsExp; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XUa9HVcX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L5EUsExp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA9207A002C;
	Tue, 13 Jan 2026 08:09:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 13 Jan 2026 08:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768309783; x=1768396183; bh=qezFOuxIek
	WxFUm/S0Vo3cD74WXfOclHOE+oxtF6y9o=; b=XUa9HVcXaGoIC/JmfjzYuGMJ12
	lU+TYbvFWoi/nPRzz9FeMWDTPUot+pB3TOPLVUWDZYokBKAO08Y5lKHFBYTQM3lb
	LVrJB0tW8bVZvNpwOam96DghATZjZQv4hou+Vypv2FR/KaNVwtnWND/Noyd8Re2e
	GDhFTiEH2ao4aNarBqzcEg3/wpFLPsFbz2+3xd1MkuAieX34EQ6vkCHsVabbobCc
	p3ITYbZi8mK0Orm0FM5Q54TfVldkVcWnM+ic30zRegotoUcIAUjW952yLv9IcXrX
	SeAN/AV9/QejoAajq2L/I1CQuJG4iIUND6j0M6rK9vDddElPnpVWi0q0O1qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768309783; x=1768396183; bh=qezFOuxIekWxFUm/S0Vo3cD74WXfOclHOE+
	oxtF6y9o=; b=L5EUsExpY3AtZAPmuS0+Vlfm5Xyt3fKCHzuNRr8Y2gVTz4oOA62
	Ga2YhkqiHcpKyMQ2V8+qkj8rlZ+FMEgsGRmNdsRy1wXvtqMdYDTrkqlivrkjq8Pt
	yoARfVV0fmlppo9Gihbn6jlTL0Z8aP7Kyd6Au0zPruTwkoSyRCgW3GW78FoqnY2V
	16eqJaAk6xqoEc7AUkatsNaYTI+g6h1dxMNKM/RLqgLU/hwNUy1n5cTDxFlr472v
	1/m/JLyAfTBAtuf1OkhfmPl0mdor1s+URvSK0EsQbxznQIiCb8B4uRqc1HG9Ix4j
	cyFaJdZPhpmWKUEH/zTYBoP34Sf7gOYZgtw==
X-ME-Sender: <xms:FkRmaUlsk7s_ssRJV-11MkAzwFHqfAYD8DQmPEQ4A2Q70yVbH28BiA>
    <xme:FkRmaXjyy2kAZ2uFu1jlBbPBtOEmENbAyoefoByqSKX0fHERUFQ9xeXG8ZwJev830
    spYYO5pJFzUolM6xTxQTGOTRCIOxH9dcdR-qoho6kpOCkEFe7Ti1A>
X-ME-Received: <xmr:FkRmacdnESehSmZFAZGYrHy5rj5PYQpemQFwbgdKpryQ7x7dsgYNEIBMRFsPFHgk6IhUKQuPLprU3qxg405-tGmWeeBTCfbikKSB-n4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteeugfeiheekgeffffdvhfelvdelffeiueetieelgfeuhfevtdfgteejffet
    feeunecuffhomhgrihhnpehhthhtphdqrghuthhhrdhshhdpphhoshhtsghufhhfvghrrd
    hinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehrrhgrmhgvshhhsggrsghusehnvhhiughirgdr
    tghomhdprhgtphhtthhopeguvghmrghrtghhiheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FkRmaXhpB2cwzSI49zrbg0WsqjDZAuKxmX0cK3Iry3hmesLS1hLycg>
    <xmx:FkRmaUyH_zeXmtDYxOzL0uBocF6osG-DCwmnQDaf5rexFNdizIyKvQ>
    <xmx:FkRmaTMCm5wiiAS0EPzZLCQWcMktAheCwl2_qrOyuejDHtZjLbzsTg>
    <xmx:FkRmaVU4BkG1_mXX1tnGxblw_WG_0_ez-_rnPYTaftHyKgta99finw>
    <xmx:F0Rmac1xLXgWHyF-IJmYY_VF2SeOggu3KYlhOUkZ9eyxMvcQGFA2dGqd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 08:09:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Rahul
 Rameshbabu <rrameshbabu@nvidia.com>,  Lucas De Marchi
 <demarchi@kernel.org>
Subject: Re: [PATCH v2] remote-curl: Use auth for probe_rpc() requests too
In-Reply-To: <20260113031929.3746753-1-aplattner@nvidia.com> (Aaron Plattner's
	message of "Mon, 12 Jan 2026 19:19:28 -0800")
References: <20260113031929.3746753-1-aplattner@nvidia.com>
Date: Tue, 13 Jan 2026 05:09:41 -0800
Message-ID: <xmqqfr89lkve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Plattner <aplattner@nvidia.com> writes:

> Subject: Re: [PATCH v2] remote-curl: Use auth for probe_rpc() requests too

Micronit.  "Use" -> "use" (see "git shortlog --no-merges -200
master" and notice that the usual "the first word of the sentence is
upcased" rule does not typically apply to the word after "<area>: "
prefix).

> If a large request requires post_rpc() to call probe_rpc(), the latter
> does not use the authorization credentials used for other requests. If
> this fails with an HTTP 401 error and http_auth.multistage isn't set,
> then the whole request just fails.

> For example, using git-credential-msal [1], the following attempt to clone a
> large repository fails partway through because the initial request to download
> the commit history and promisor packs succeeds, but the
> subsequent request to download the blobs needed to construct the working
> tree fails with a 401 error and the checkout fails.
>
> (lines removed for brevity)
>
>   git clone --filter=blob:none https://secure-server.example/repo
>   ...
>   11:07:34.725262 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>   11:07:34.725279 http.c:849              => Send header: Content-Type: application/x-git-upload-pack-request
>   11:07:34.761407 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
>   11:07:34.761443 http.c:890              == Info: Bearer authentication problem, ignoring.
>   11:07:34.761453 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>   11:07:34.761509 http.c:890              == Info: The requested URL returned error: 401
>   11:07:34.761530 http.c:890              == Info: closing connection #0

Excellent illustration here.

>   11:07:34.761913 run-command.c:673       trace: run_command: 'git credential-cache erase'
>   11:07:34.761927 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-cache erase' 'git credential-cache erase'
>   11:07:34.768069 git.c:502               trace: built-in: git credential-cache erase
>   11:07:34.768690 run-command.c:673       trace: run_command: 'git credential-msal erase'
>   11:07:34.768713 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-msal erase' 'git credential-msal erase'
>   11:07:34.772742 git.c:808               trace: exec: git-credential-msal erase
>   11:07:34.772783 run-command.c:673       trace: run_command: git-credential-msal erase
>   11:07:34.772819 run-command.c:765       trace: start_command: /usr/bin/git-credential-msal erase
>   error: RPC failed; HTTP 401 curl 22 The requested URL returned error: 401
>   fatal: unable to write request to remote: Broken pipe
>   fatal: could not fetch c4fff0229c9be06ecf576356a4d39a8a755b8d81 from promisor remote
>   warning: Clone succeeded, but checkout failed.
>   You can inspect what was checked out with 'git status'
>   and retry with 'git restore --source=HEAD :/'
>
> In this case, the HTTP_REAUTH retry logic is not used because the
> credential helper didn't set the 'continue' flag, so
> http_auth.multistage is false and handle_curl_result() fails with
> HTTP_NOAUTH instead.
>
> Fix the immediate problem by including the authorization headers in the
> probe_rpc() request as well.

Great.

> diff --git a/remote-curl.c b/remote-curl.c
> index 69f919454a..1d0ae72521 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -877,6 +877,8 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
>  	headers = curl_slist_append(headers, rpc->hdr_content_type);
>  	headers = curl_slist_append(headers, rpc->hdr_accept);
>  
> +	headers = http_append_auth_header(&http_auth, headers);
> +

Is http_auth headers so different from the content-type and accept
in the larger picture to warrant the blank line before this new
call?  If not, you probably would want to have these three
assignments to "headers" that accumulates the header lines together
in a single block of three lines without any blank line in between.

>  	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
>  	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
> diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
> index c1febbae9d..adc210cdd3 100755
> --- a/t/t5563-simple-http-auth.sh
> +++ b/t/t5563-simple-http-auth.sh
> @@ -63,6 +63,26 @@ test_expect_success 'setup repository' '
>  	git push --mirror "$HTTPD_DOCUMENT_ROOT_PATH/repo.git"
>  '
>  
> +test_expect_success 'setup large repository for probe_rpc testing' '
> +	rm -rf large.git &&
> +	git init large.git &&
> +	(
> +		cd large.git &&
> +		git config set maintenance.auto false &&
> +		git commit --allow-empty --message "initial" &&
> +		# Create many refs to trigger probe_rpc, which is called when
> +		# the request body is larger than http.postBuffer.
> +		#
> +		# In the test later, http.postBuffer is set to 70000. Each
> +		# "want" line is ~45 bytes, so we need at least 70000/45 = ~1600
> +		# refs
> +		printf "create refs/heads/branch-%d @\n" $(test_seq 2000) |
> +		    git update-ref --stdin
> +	) &&

Hopefully, $(test_seq 2000) would not bust $(sysconf ARG_MAX), which
could be as low as 4KB, on any system we care about.  If not, of
course we could

	test_seq 2000 |
	xargs printf "create ...\n" |
	git update-ref --stdin

which probably is not all that more expensive than what you wrote above.

Other than that, looking great.  Thanks for working on this.
