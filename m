Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE6E23D7E0
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767970274; cv=none; b=aPGiDedx0DcBxalT9N7f88APxq6HarOTEm2bXW3MAfxyy8F0NIRCopEy5ODRYc8jF2qKXv0N4yiozDwM7TZ9F0QFs0KSeYgxZNsYfJn5dMPsi1u4KB1QMxXvT9yfQ1CiD46mCLnEfJeDrjWVK589h7U3SCmNsuWNFquZLFj0t2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767970274; c=relaxed/simple;
	bh=9jfsmIuiU4lG7M+kkRVWId1kVNH5Si0VQ0/GQshWNjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0onXDdBCbZXAcOqWIgtF8658WtE55da1wprPMbbRjb6H97LTVCGODeImmVVID/x22zoZWRv/IZla8koOzwXGDwLU6Ew9V4vd77XoKugWke7IJwNqkhoP/1DO9y5LsqIYNV3n+cmOCUzq0YqV0Azw9ltKodx2Jl0BmEcH6wnFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NQ53LccY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UzuzPW5o; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NQ53LccY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UzuzPW5o"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C14DE1D0013F;
	Fri,  9 Jan 2026 09:51:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 09:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767970271; x=1768056671; bh=rV1GQa6B5I
	eD4n686UCosVH77wqvY3ZLVNoeAPmZLkQ=; b=NQ53LccYhNUkN9ojnBy8Ptejmt
	fTjvNtLzg8z/oYOtwpLNjW9J2ueG8A9a4/WEaCnVi7n1upxI5klplAYcWTGHHeJI
	lcrd86vab9nG80ZNlr3I31U3qpe+xsailAHWhjxDbmIXot90y51W2x0ar72w3qsJ
	sJKtUOaCnGCwMcGGd/hNBgV2pDpN6vr4yqCfRy2Fq22MZV/vsEZZgbMgW4y55pb1
	HCTPTVdsbhng5TUn4shAMTMVoEqCUfJNaFIz14bI8kwcgJVq0dcF/VuKlhgom61K
	7R1DMxD9MALA0UFTSLwfotEWve3TJVeylDn/vua9I7dXmyKY06c5TDAluNdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767970271; x=1768056671; bh=rV1GQa6B5IeD4n686UCosVH77wqvY3ZLVNo
	eAPmZLkQ=; b=UzuzPW5oqBz0YMPzPK3PIL2KmNIomsN/l6eh+25Bz6WkujQdkVC
	Tt6KJbbvtifj+0ymt1KMuhp6tn5BATOFalYjx2G0tYRySsZpdRpdI67GF5/AuQvI
	XR1SV8CXqnZdgo99qLx/GRA1OW76gw91c90Auj1wRUs++IO6L6q5wW/H44ebhfop
	Tl1EnlBDWHCTmVxKfVs711wJMkmJnK4iLz3+/dam2JAOuXUEF/AOexr8AH/fFPhM
	gGB7k0v2U6RVZaj2URaQd19dkgX6yI7SthyYqsiLQuB6u6ZDzkqHl3mB5v8QVRiX
	6nSMiK53vtrnaGM2TBX854FUrUX79zjgVtQ==
X-ME-Sender: <xms:3xVhadvqkqRAVxdEauofiynFz_ohclr-kUsJZ1cD7aTvF97YxgNAgA>
    <xme:3xVhad64RC_aE7UBxf0NZ6bO368bcE6GbwZYs1syPxx4FielyIjk3fgrTb-e-PG0R
    ePXVQJvh-gDuwnvDgXR3daUK0CrS30T5HbLIGq8sPKaLW9-r6XdWQ>
X-ME-Received: <xmr:3xVhaeIygAOZVJQtNcoQq6GGD5ATkcMniwAUZ_lVAxTH2VvmociRvn4hwFGtdMlZJiIPdoUa65k27QWo3qxvyhBsFLdowlkDpTN39DJ3Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeluddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfehtefgveelhfeuueevuedvnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprhhrrghmvghshhgsrggsuhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:3xVhad45b3iGsswji5Y16LtEB0ETDyzn9GFnrpf_CwqGWotRUBMRrA>
    <xmx:3xVhaRyTYnwpO-12pKHH5YKkFjze13aG__ZvgUWDYA0G0Vzji2Fi2Q>
    <xmx:3xVhaRZMhXZLgSSnJG5fOM9OxlSVyEiW8pqvuhFzbs-VarzGGJ1Q4g>
    <xmx:3xVhaTQzON-TEmxJcI5G_h0wuip4bx2iOxg7I4V0iB1E4SIppomO_Q>
    <xmx:3xVhaeWUMFbbA0SKyA5Jjenwu05jx-NBzzix6zvaO_XWw4Qe4GclpVmK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:51:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a9e09cf6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 14:51:09 +0000 (UTC)
Date: Fri, 9 Jan 2026 15:51:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH] remote-curl: Use auth for probe_rpc() requests too
Message-ID: <aWEV2qs8MHqt_JXC@pks.im>
References: <20251112223722.376330-1-aplattner@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112223722.376330-1-aplattner@nvidia.com>

Hi,

sorry for taking so long to review your patch, but I didn't really dare
to review it as I'm not that familiar with the subsystem in question.
But given that nobody else reviewed it, either, let me try my best to at
least provide _some_ helpful feedback to hopefully move this forward.

On Wed, Nov 12, 2025 at 02:37:18PM -0800, Aaron Plattner wrote:
> If a large request requires post_rpc() to call probe_rpc(), the latter
> does not use the authorization credentials used for other requests. If
> this fails with an HTTP 401 error and http_auth.multistage isn't set,
> then the whole request just fails.
> 
> For example, using git-credential-msal [1], the following attempt to clone a
> large repository fails partway through because the initial request to download
> the commit history and promisor packs succeeds, but the
> subsequent request to download the blobs needed to construct the working
> tree fails with a 401 error and the checkout fails.

Okay.

> (lines removed for brevity)
> 
>   git clone --filter=blob:none https://secure-server.example/repo
>   11:03:26.855369 git.c:502               trace: built-in: git clone --filter=blob:none https://secure-server.example/repo
>   Cloning into 'sw'...
>   warning: templates not found in /home/aaron/share/git-core/templates
>   11:03:26.857169 run-command.c:673       trace: run_command: git remote-https origin https://secure-server.example/repo
>   11:03:27.012104 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>   11:03:27.049243 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
>   11:03:27.049270 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>   11:03:27.053786 run-command.c:673       trace: run_command: 'git credential-msal get'
>   11:03:27.952830 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>   11:03:27.952849 http.c:849              => Send header: Authorization: Bearer <redacted>
>   11:03:27.995419 http.c:849              <= Recv header: HTTP/1.1 200 OK
>   11:03:28.230039 http.c:890              == Info: Reusing existing https: connection with host secure-server.example
>   11:03:28.230208 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>   11:03:28.230216 http.c:849              => Send header: Content-Type: application/x-git-upload-pack-request
>   11:03:28.230221 http.c:849              => Send header: Authorization: Bearer <redacted>
>   11:03:28.269085 http.c:849              <= Recv header: HTTP/1.1 200 OK
>   11:03:28.684163 http.c:890              == Info: Reusing existing https: connection with host secure-server.example
>   11:03:28.684379 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>   11:03:28.684391 http.c:849              => Send header: Accept: application/x-git-upload-pack-result
>   11:03:28.684393 http.c:849              => Send header: Authorization: Bearer <redacted>
>   11:03:28.869546 run-command.c:673       trace: run_command: git index-pack --stdin --fix-thin '--keep=fetch-pack 43856 on dgx-spark' --promisor
>   11:06:39.861237 run-command.c:673       trace: run_command: git -c fetch.negotiationAlgorithm=noop fetch origin --no-tags --no-write-fetch-head --recurse-submodules=no --filter=blob:none --stdin
>   11:06:39.865981 run-command.c:673       trace: run_command: git remote-https origin https://secure-server.example/repo
>   11:06:39.868039 run-command.c:673       trace: run_command: git-remote-https origin https://secure-server.example/repo
>   11:07:30.412575 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>   11:07:30.456285 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
>   11:07:30.456318 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>   11:07:30.456439 run-command.c:673       trace: run_command: 'git credential-cache get'
>   11:07:30.461266 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>   11:07:30.461282 http.c:849              => Send header: Authorization: Bearer <redacted>
>   11:07:30.501628 http.c:849              <= Recv header: HTTP/1.1 200 OK
>   11:07:34.725262 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>   11:07:34.725279 http.c:849              => Send header: Content-Type: application/x-git-upload-pack-request
>   11:07:34.761407 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized

Okay, here we see the 401 error code.

>   11:07:34.761443 http.c:890              == Info: Bearer authentication problem, ignoring.
>   11:07:34.761453 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>   11:07:34.761509 http.c:890              == Info: The requested URL returned error: 401
>   11:07:34.761530 http.c:890              == Info: closing connection #0
>   11:07:34.761913 run-command.c:673       trace: run_command: 'git credential-cache erase'
>   11:07:34.761927 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-cache erase' 'git credential-cache erase'
>   11:07:34.768069 git.c:502               trace: built-in: git credential-cache erase
>   11:07:34.768690 run-command.c:673       trace: run_command: 'git credential-msal erase'
>   11:07:34.768713 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-msal erase' 'git credential-msal erase'
>   11:07:34.772742 git.c:808               trace: exec: git-credential-msal erase
>   11:07:34.772783 run-command.c:673       trace: run_command: git-credential-msal erase
>   11:07:34.772819 run-command.c:765       trace: start_command: /usr/bin/git-credential-msal erase

And as we think that we've already set up authentication, this error
code will cause us to think that the credentials that we've got are
invalid. Consequently, we invalidate the credentials that we've stored.
Naturally, this will cause _all_ subsequent requests to fail as we're no
longer authenticated at all.

>   error: RPC failed; HTTP 401 curl 22 The requested URL returned error: 401
>   fatal: unable to write request to remote: Broken pipe
>   fatal: could not fetch c4fff0229c9be06ecf576356a4d39a8a755b8d81 from promisor remote
>   warning: Clone succeeded, but checkout failed.
>   You can inspect what was checked out with 'git status'
>   and retry with 'git restore --source=HEAD :/'
> 
> Fix the immediate problem by including the authorization headers in the
> probe_rpc() request as well.
> 
> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
> Link: [1] https://github.com/Binary-Eater/git-credential-msal
> ---
> If http_auth.multistage were set in this scenario, then probe_rpc() would have
> returned HTTP_REAUTH and this would have probably worked by generating a new
> Bearer token. And we might need to use HTTP_REAUTH to handle the case where the
> token expires between the initial request and this one, but I don't think
> tackling that in this patch makes sense since the original Bearer token was
> still valid and git just didn't try using it. And setting multistage (the
> 'continue' parameter in git-credential(1)) doesn't make sense for Bearer tokens
> since the token comes from an external agent.

This is something I was wondering about. Specifically, I saw the loop
that we had around `HTTP_REAUTH`:

		do {
			err = probe_rpc(rpc, &results);
			if (err == HTTP_REAUTH)
				credential_fill(the_repository, &http_auth, 0);
		} while (err == HTTP_REAUTH);

I then double-checked that we indeed get `HTTP_REAUTH` as an error code
on a 401, so I was wondering why this doesn't lead to an infinite loop.
I didn't connect it with the "multistage" thing though.

In any case, I think this information would be useful to have in the
commit message to help guide readers.

>  remote-curl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
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
>  	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
>  	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);

The change looks simple enough, and matches what we do in `post_rpc()`
itself.

It would be great to have a test case for this. It might be possible to
use t5563-simple-http-auth as an example, where we already know to set
up an HTTP server with authentication.

Thanks!

Patrick
