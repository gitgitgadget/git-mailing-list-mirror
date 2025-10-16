Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230541917CD
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643242; cv=none; b=cLTzShn/XX/NEFJYPPvz18ZHrSAg2JERZf3EWxhFGKmNKVrio7Z0iWge7OQMDMLF6SuCUGLc7CAn+XWHApE1s74gO2BtHTv1JYiZ7APu6JhK2QEki79F94m1RyVuCuWZR4bgGwKG5Z8k8CETeqkhbSv22SLWic+vI9rVsv9D8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643242; c=relaxed/simple;
	bh=nJKgiXS1w+WGGSAYgRTetorVm1FvULid5ZHIlx0sJR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z1/trHwkcCn2ZKs0wEUbRA77dBTQhZpd4um/iVk8xRL89+B+AyWl/H+e1OYc+8aV+OvXZ1seanJ6d7oeVw6B5rvmkC8X6ii2POAxYBeZTOw8M3a3xE/ht04HKS3wEH3NQkQ0I5JmQFvkO0zRc3orBZRxZHh2PKaK+8uCSwrmQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XqXrWtZ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hs0eXsiX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XqXrWtZ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hs0eXsiX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 53551EC01DB;
	Thu, 16 Oct 2025 15:33:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 16 Oct 2025 15:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760643239; x=1760729639; bh=JngnQMmpiQ
	f/7yEuET+FeU4f0oTdQLlhj9zjdBtabRk=; b=XqXrWtZ97t0tuH3nydOyoA9629
	Hb3EDp9Twfx2uaE60Qk3RdMhTcem5kg6/f7/1WW7YnoNcgcAYxRhResGeu0987oz
	+gidKRb+SkB7o3UNYaYjReo4cxKX1aGoxV0YLjb+2+Jl8EDsfyLL60M1P+SGyGUb
	1X9iq9HqolLm3sKTGBXg2tAlMUQ8P1mTRybuhVO1YyiaoER4rlK0O0rSWvv4I5/X
	QRVaXFzm+WB1BjTRHc1rmvOzSbR5rebbM44U6skBT/EeyfXLyMA7M+2MCGqK7SvO
	E+54iHpKKlUZYdd4qS0cDT+jRFZYpzen0+ipr8Omct8KpRT3b5KgTC7BlsVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760643239; x=1760729639; bh=JngnQMmpiQf/7yEuET+FeU4f0oTdQLlhj9z
	jdBtabRk=; b=Hs0eXsiXGHd2IXYlNdU6WE+qw6Fc+iM36B9CLdh4c+jjX+fgUf5
	znsGeThrLllR6Qi28IopFrLCgfvtYr+wAWfwRzDgGh6SEfSDPYncaUrMg0/FlY0x
	V/TUnpKMZikzfacGD9GTMY6Iog8z/iHbM5HzxPh5eFnME/OIZNWJn/HfjQBeq/Lb
	YwsC0qC/G/aFHbThvuHctW9Z2vPuYRFJgqx5VOPcsme3JZjX+hqN1sBoz1v0aEgM
	nJvmgduKbMfNkln55zYcDUfsSxYYtkh2URxb8KFH+v2h7YivfWZWz/Ly1KiG0U1+
	i9uYHpZCew4ueLCXu7OR9O4MJOsomJODOsg==
X-ME-Sender: <xms:pkjxaBmW0Vk1Wcwc-xxG6caOzuM5WGIg3wgIkscmuSEObxicDsAMkQ>
    <xme:pkjxaERW9UmRtcIX9YCnS6BXW7CK0AJW3TNQCcxKLbQvyhyAhI20Ers831cB_uvl1
    WRymHGJE89TkGMB455awj52cxNhdXgY8q4mBmJ8pkbQEVD6XcmZRw>
X-ME-Received: <xmr:pkjxaFDbJJxiUS490FkeXpuyzBD5Vy-pUROY5RDpd2CPKLQO3NJSmlwlPjxPMWg5rl-CMlrdY5GQlFvR9BRpmXhk1f4-pP6TUalM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekleffhfefvdeiueegjeehfeeigf
    fhheekvdejvdetjedvvdehtdeuvdeuudduvdenucffohhmrghinhepshgvthhuphdrtgif
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhitheslhhohhhmrghnnhdrshhhpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:pkjxaLTERQ8-QqczAKXH9kjglfZny3luCChfrFRbzDNIM8acSs3R0Q>
    <xmx:pkjxaDr0vweBInRfMK4JMVu0m4B0syiIdaIwV2dM5U9vZ9zxjO3H6w>
    <xmx:pkjxaNyZMD7upJT20CJpQhPHvqwf2rQRELncbhopci17SRcpyZzyXw>
    <xmx:pkjxaII0kDGVTqQALpMR1gxkTo1N9d9yhXXPvLsAwz_cTB10oe2_bw>
    <xmx:p0jxaN91SDTS-G41CuxEuIlSMAfSH5ihEXfHUfLe8w0fGLKCsoJUWKp3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 15:33:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <git@lohmann.sh>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] setup: allow not marking self owned repos as
 safe in `ensure_safe_repository()`
In-Reply-To: <20251016053322.44495-6-git@lohmann.sh> (Michael Lohmann's
	message of "Thu, 16 Oct 2025 07:33:22 +0200")
References: <20251013094152.23597-1-git@lohmann.sh>
	<20251016053322.44495-1-git@lohmann.sh>
	<20251016053322.44495-6-git@lohmann.sh>
Date: Thu, 16 Oct 2025 12:33:57 -0700
Message-ID: <xmqqo6q63al6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Lohmann <git@lohmann.sh> writes:

> +safe.assumeUnsafe::
> +--assume-unsafe::
> +`GIT_ASSUME_UNSAFE`::

I haven't thought things through thoroughly yet, but this probably
is a good thing to have.  I cannot say the same to [4/5], though.

> @@ -1330,6 +1336,9 @@ static int ensure_safe_repository(const char *gitfile,
>  	if (data.is_safe)
>  		return 1;
>  
> +	if (git_env_bool("GIT_ASSUME_UNSAFE", 0))
> +		return 0;
> +
>  	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
>  	    (!gitfile || is_path_owned_by_current_user(gitfile, report)) &&
>  	    (!worktree || is_path_owned_by_current_user(worktree, report)) &&

I think you didn't have to do anything in [3/5] for this, though.

It is sufficient to pretend as if GIT_TEST_ASSUME_DIFFERENT_OWNER is
set when GIT_ASSUME_UNSAFE (and its config/option equivalents) is
set, no?  IOW, wouldn't it be equivalent to your series, if you
dropped [3/5] and replace this hunk with the following?

 setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git i/setup.c w/setup.c
index 7086741e6c..e3c81a6fae 100644
--- i/setup.c
+++ w/setup.c
@@ -1307,7 +1307,8 @@ static int ensure_valid_ownership(const char *gitfile,
 {
 	struct safe_directory_data data = { 0 };
 
-	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
+	if (!git_env_bool("GIT_ASSUME_UNSAFE", 0) &&
+	    !git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
 	    (!gitfile || is_path_owned_by_current_user(gitfile, report)) &&
 	    (!worktree || is_path_owned_by_current_user(worktree, report)) &&
 	    (!gitdir || is_path_owned_by_current_user(gitdir, report)))

