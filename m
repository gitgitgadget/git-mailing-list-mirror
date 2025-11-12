Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866E2D130C
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966032; cv=none; b=jWwDWvs2auT1AM9ggiYkc4VvDmG+dfayavNvJSbKRsexymQR3kg4/WJHVsfCr6+REvcu26kZkKTNIU4bi9mRzGlmOY3ZzBQxYda0O0OPlLRIwHWmUMjwQ6Id78v30SIA98Q0ekp1xdDRooG4LCS/R7z1LWd9+tOAO3x8Q7kyNBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966032; c=relaxed/simple;
	bh=I22zijUktEpCP/NpAiraTgVzWl1aajqrMRakoo2A4OY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qwN2TXI8w2XM5rGjsZkaFLInsa0Kk0nspRxYOtR3ObgVgh7+TZDUdZyJVguxtw9/WeqZumxXHMxRF0nBOdIb5lRg72zJV5cnR9kg+l38h7JPAgwMVc0YDW7rHZykWyL8FhFgeVBgtKkpvl5wfP8CAtLHtRtbSbXFySFtswBsTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V4Czz8r0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JvQYc38n; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V4Czz8r0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JvQYc38n"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 517B81D000F9;
	Wed, 12 Nov 2025 11:47:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 12 Nov 2025 11:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762966028;
	 x=1763052428; bh=lF3Ij/y/wUlTQOd5yicrL+sULTXiiMLicXXNLq2x9hI=; b=
	V4Czz8r0Gf8GUSs4Hu0mEUo7DMwr/meLxEocV4/Bim/SXoYCzkpdudU1Q7NuDMxf
	yavDvLjc72wWGSGlXCIeBmRLcGg80JHoQUKvebw+KzA8hQQaMhynL/0sm73RRFx4
	y7lzefjT1vuu7MWbN5/jyk/XkjtpvZk61IpZWQwbFmhUHXnNmeKkWXZAR/nQiR+a
	mepJDng53ib341haPe/uJXtcBiwa/R+nwgETH9iSR1yy64DUmtX+pwZMa/rUDBpd
	Rd6syGDsal8ineXWmJ09YVUS9a9q7tvFCG+pXda0y0NUkeccx1kjngY0LH0t0fcx
	VH/+9KsiyQ7JvY10XHo6FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762966028; x=
	1763052428; bh=lF3Ij/y/wUlTQOd5yicrL+sULTXiiMLicXXNLq2x9hI=; b=J
	vQYc38n8/G1e0/aqRY1+Q3ogzWKF2O+X5AeJ/ae5rDUTF3s7qMIJsZoUAamEHj9P
	yEbgjzbolsGulv5q6v3K1SJ3ieymhwsh7zmwPyjSiJRePpxU6VbliveRX5J2oMHb
	Ru400SV5BgAwitBhxS0eZWwPHnKY9+u41lUypNXbsA67Rx+lhsHLAmcBYd/tYEun
	FiZNYcewSWCnPmwdsLi1gYBd/hNp3lYT90dg2TMAfp5TBjTUYx+FiIPH3X9EBvKo
	5jI2V7T4XJ5wU6GzNBUcW7beEXUh5uV6CgToUMOixxlpwafK68Id1gnPprnq44AP
	EefX3W35EaAGDs855Rg6A==
X-ME-Sender: <xms:C7oUacU22Gyr98FozQel3melNUMm4unL-YePG5LtRyfiXUePGfpBbQ>
    <xme:C7oUaXkQD1BDd5l1QyBWNGpK0FFU3Zvi4xNo1WSJ3mGeZR1JL_8auyGeb41eAMEgr
    OcDoiY_ww5G3tgtwopfMq8PxDgF9PCe-dQygKwEEP7mpawlNhGF_g>
X-ME-Received: <xmr:C7oUaVbHrCpyBEAVBAU5ZefDJH26PnfFdckedAiaAD4LsT37YpGSWlhUumUYYMFj9pGopdfHMiaNqgSszSoipRdMsQuUmtQYqL1X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeggefhudefkeegueeigfejhfejvdejvedtheeguedukefgieelfeeuteej
    ieeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkohhjihdrnhgrkhgrmhgrrhhuse
    hgrhgvvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:C7oUaaMxEJfV91znrSyWMD_zrQyX1SNJuZREhHlB7n5JS6G7iKxtPg>
    <xmx:C7oUaSbKAqih8dYg38IjKoPKL2D5O3BSedsVPyV6Nh4rYlbS2hbfXA>
    <xmx:C7oUaQ2EbKgBaqYn4lGAtv2OhaYsoF2AXrKn9J0xuxV7XybCPFmKAA>
    <xmx:C7oUaQf7vr4eZlnoqhvG_WMLHjPqhQXuHFmO7isFDvO6GZYPFkRNRQ>
    <xmx:DLoUaQySRPQ8G69GzLfU8oFBgonsDb8OP2X-QDLzc4-YmjbVKHqNIXDg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 11:47:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] Revert "osxkeychain: state to skip unnecessary store
 operations"
In-Reply-To: <pull.1998.git.1762930881599.gitgitgadget@gmail.com> (Koji
	Nakamaru via GitGitGadget's message of "Wed, 12 Nov 2025 07:01:21
	+0000")
References: <pull.1998.git.1762930881599.gitgitgadget@gmail.com>
Date: Wed, 12 Nov 2025 08:47:06 -0800
Message-ID: <xmqqv7jfryet.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Koji Nakamaru <koji.nakamaru@gree.net>
>
> This reverts commit e1ab45b2dab51f94db9548666dfd7af626d2aa7e.

OK.  Let's make a mental note that e1ab45b2 (osxkeychain: state to
skip unnecessary store operations, 2024-05-15) appeared in v2.46 or
so.

> That commit was trying to skip to store a credential returned by
> "git-credential-osxkeychain get" by setting
> "state[]=osxkeychain:seen=1". However, this state[] is kept even if a
> credential returned by "git-credential-osxkeychain get" is invalid and
> another subsequent helper's "get" returns a valid credential. Another
> subsequent helper (such as [1]) may expect git-credential-osxkeychain to
> store the valid credential so that "store" cannot be skipped by just
> checking "state[]=osxkeychain:seen=1".
>
> In order to solve this issue, the state[] mechanism can be refined or
> "osxkeychain:seen" can encode the whole information of the last
> "get". For now, let's revert the change.

Is anybody actively working on the proper solution?

In a patch series that replaces the old commit with a more proper
solution, it could be a reasonable layout of the series to make the
first patch a revert like this patch to give the proper solution a
clean slate to work from, but this looks different.

If the problem you are trying to solve here were a regression that
happened after Git 2.51 was released, a revert is totally warranted
at this point in time, even during the pre-release freeze period.

But it does not even look like a recent regression.  Wouldn't
reverting this change at this point give existing users who are
accustomed to the current behaviour another regression, essentially
robbing Peter to pay Paul?  In such a case, I do not think "let's
revert now and then hopefully a proper solution can come later" is a
good approach.

Thanks.

> [1]: https://github.com/hickford/git-credential-oauth
>
> Reported-by: Petter Sælen <petter@saelen.eu>
> Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
> ---
>     Revert "osxkeychain: state to skip unnecessary store operations"
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1998%2FKojiNakamaru%2Frevert%2Fe1ab45b2dab51f94db9548666dfd7af626d2aa7e-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1998/KojiNakamaru/revert/e1ab45b2dab51f94db9548666dfd7af626d2aa7e-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1998
>
>  .../osxkeychain/git-credential-osxkeychain.c          | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index 611c9798b3..1f49ab8548 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -12,7 +12,6 @@ static CFStringRef username;
>  static CFDataRef password;
>  static CFDataRef password_expiry_utc;
>  static CFDataRef oauth_refresh_token;
> -static int state_seen;
>  
>  static void clear_credential(void)
>  {
> @@ -172,9 +171,6 @@ static OSStatus find_internet_password(void)
>  
>  	CFRelease(item);
>  
> -	write_item("capability[]", "state", strlen("state"));
> -	write_item("state[]", "osxkeychain:seen=1", strlen("osxkeychain:seen=1"));
> -
>  out:
>  	CFRelease(attrs);
>  
> @@ -288,9 +284,6 @@ static OSStatus add_internet_password(void)
>  	CFDictionaryRef attrs;
>  	OSStatus result;
>  
> -	if (state_seen)
> -		return errSecSuccess;
> -
>  	/* Only store complete credentials */
>  	if (!protocol || !host || !username || !password)
>  		return -1;
> @@ -402,10 +395,6 @@ static void read_credential(void)
>  			oauth_refresh_token = CFDataCreate(kCFAllocatorDefault,
>  							   (UInt8 *)v,
>  							   strlen(v));
> -		else if (!strcmp(buf, "state[]")) {
> -			if (!strcmp(v, "osxkeychain:seen=1"))
> -				state_seen = 1;
> -		}
>  		/*
>  		 * Ignore other lines; we don't know what they mean, but
>  		 * this future-proofs us when later versions of git do
>
> base-commit: 4badef0c3503dc29059d678abba7fac0f042bc84
