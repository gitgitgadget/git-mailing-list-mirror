Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C91C861A
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467399; cv=none; b=usqBdHY6aeea46dNTjBc0LSMttF1iP2FIUBaTWp484vrliquoBo/uzs3DlX/m4cGWwdL/WZIBRuphx9FYvC9r0wDR7Xf0iTenOBtpHwGbeqh5peRvie65Ar6ChcXmLp1NVdutBkFxblTxEq6b7VG2sHAtbwKtzvbt/sI6VdaLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467399; c=relaxed/simple;
	bh=ZowSPn5lXr8bQ4JCqaNcyYAfzwa4/K0EXC2haBtImI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kysXEgBW1aAkyzWZinnpwKaY/Vc1/7028r3nAYYDEyNfkGhMoyqOyWtm58oThi7lRo+/rYkvQ6QZsYPhX5nnSPHxNzNfwItQ4HASZCaatxtvAC1xFuWiW4Us+FTf9AcUmzBNJVTamnnx0pYo7OG7jeW8jfffcuDwA+lkkRtq+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yh3GRRYE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IK1b5U4z; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yh3GRRYE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IK1b5U4z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id F3BD91D000A9;
	Sun, 21 Sep 2025 11:09:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 21 Sep 2025 11:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758467395; x=1758553795; bh=vasZQgd8ls
	DENBGdARMybYC1FRwPvSJS0FAvGYIDmso=; b=Yh3GRRYE5IN69O/vgE70GHTwfk
	uVGI7tiVPy9jr13V4St8WucTouHRMwxdB/WMhkP4wns66azUfLzL5EkEthibL9cF
	/lImQkTJjNNMg3GU76SYJwKi8KNx+qnAYWCWJJqZd132l/VC5Tl3BSofd5u5vXQS
	kzsN0XrEx1M4zDHlU3TaeX0F1mBXih3y2TsTlAAqy47XwcOwvbI2YxjW479x8iOK
	hd6SESSD8uvSiverK9JV7XaLyre7MIdYCP2V0cpapm5qXiPx4uBDBfjyAsMyf/QR
	CKEJGSpuyN22ExZnDcjhjSObV6IVuuuRyIRf7AlKQLOZ3pa3666QRjT2PS7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758467395; x=1758553795; bh=vasZQgd8lsDENBGdARMybYC1FRwPvSJS0FA
	vGYIDmso=; b=IK1b5U4zvBdUqLEhqxL4xfVSZ2m1vF+arcnfDHOSrwb/oq/BoPy
	uxJAEIFNWZfOV8Sg3Nq4qYOnzZOFsfqkwvpe9QaSzgPuM0g91TAtJaJav6LmnFMy
	D8vKQkkThNSDrBMnLhQ6Yxlc4ckIY/KPdkUM+EvF8Zr2mj5MrePA3PyNRWvWPRi0
	zN6/ebknncW571WnP+um4SMc7fo/XkLqqpNUJ4EKLNWvsE1lJtTNlXgbFNIvHPlN
	EK3baxUoqyimFz1yJrbk+QiqcSSRvR3Ih9Ogst46kZTuIyIFsC5QuUIXyBa3f6Qw
	gSIy45TyO9q/d36+hemDHRJBs2CL+YdkjaQ==
X-ME-Sender: <xms:QxXQaIM60divpJpkzXJ-1RwkNw9HphIKfcv7W1Br-WpRD8F2qX_5yQ>
    <xme:QxXQaJipVUQZwFtXgVL3hi8aYe7QY8f2MGG1k5iIy---dFXZa5x_YlK4vgOF5-hOF
    BugXR9fNDxCPDWkSA>
X-ME-Received: <xmr:QxXQaL3TFxDSZPRLhZKnX4oNnWDmqY5nhqG-mfPCkCBWHr621r8QMV_atRVFN4uFK8GygmHDXjqPM_JmVABa3u273kOXqx7tKvhN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehhedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeekleetveffteegledtkedtkefgledtfedvieejieehvdefffejhffhgefgudef
    gfenucffohhmrghinheptghurhhlrdhsvgenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QxXQaDgr3gfKLheq9tzR21yWqzlAKvZ-9YXkiNv9ZKdULJodaQcg3w>
    <xmx:QxXQaLcEo6qwJYQ6u5_UomoDAvTinQ5ujj-iKhAw9Uj6z7CWubymZg>
    <xmx:QxXQaGl_RLD_-PCY_PAVNwd_p5OFDHKcSnZ52QY1Ojy_-iLPZwloQQ>
    <xmx:QxXQaEt8mzX_o32Zqyx33UXvo4zplA9_k7Yfst8DZJOkykCV_RoixQ>
    <xmx:QxXQaPI2evWBOfYsfmWo4OBuwt06wIQbPpLxsN_UOHS18CtPJmZ0w7c7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Sep 2025 11:09:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] http-push: avoid new compile error
In-Reply-To: <bcb231125c95ff809c618eedab71375b94e6c69e.1758457356.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Sun, 21 Sep 2025
	12:22:36 +0000")
References: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
	<bcb231125c95ff809c618eedab71375b94e6c69e.1758457356.git.gitgitgadget@gmail.com>
Date: Sun, 21 Sep 2025 08:09:54 -0700
Message-ID: <xmqq7bxrx2nx.fsf@gitster.g>
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

> However, there is a much better solution: To use the
> `CURLOPT_INFILESIZE_LARGE` option instead, which was added in cURL
> v7.11.0 (see https://curl.se/ch/7.11.0.html) and which Git _already_
> uses in `curl_append_msgs_to_imap()`.
>
> This fix was the motivation for renaming `xcurl_off_t()` to
> `cast_size_t_to_curl_off_t()` and making it available more broadly,
> which is the reason why it is used here, too.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  http-push.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

As we saw in [1/3], we have been using "size large" for posting in
remote-curl.c and this brings how the size for reading the data is
handled to match that.

Looking good.  

Will queue.  Thanks.



> diff --git a/http-push.c b/http-push.c
> index 91a5465afb..7a9b96a6d0 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -208,7 +208,8 @@ static void curl_setup_http(CURL *curl, const char *url,
>  	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
>  	curl_easy_setopt(curl, CURLOPT_URL, url);
>  	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
> -	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
> +	curl_easy_setopt(curl, CURLOPT_INFILESIZE_LARGE,
> +			 cast_size_t_to_curl_off_t(buffer->buf.len));
>  	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
>  	curl_easy_setopt(curl, CURLOPT_SEEKFUNCTION, seek_buffer);
>  	curl_easy_setopt(curl, CURLOPT_SEEKDATA, buffer);
