Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038316A395
	for <git@vger.kernel.org>; Sat, 30 May 2026 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780184832; cv=none; b=NDRBi4Mfrwv2cFmgxKR1wHPTYDWruRU5AcbzTLoYlh7w21K8fT7jRudTOrSX7KbyUfWzns24fw9REvvSyUUQBSPn9Xr7MXDRev8BJYWHGIJbPwvogoT+U/9/4/HZVEMjYWxvdEa08FoxvMhPPIxpCWRv9/UrlbnFPr1GbYu5C0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780184832; c=relaxed/simple;
	bh=YlHfFJJ/9KBt0RGMJIGStXkBB9Acfu8NKcTSrbwbeyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aq9eYvAOPep6zzzZJMXwFyfPKZhu6n+3tYd4vXwR9SL2jOh4kwfdw4dubTj/KUXozeJnzDK0rZDriUaWuTaKR2kL38tXuU0GLLfKvJIg8V+2QJtLVsQ4nkichtxU5f16OahjTcsNSoDOTkdNcWEFLVPQ2Us9hNsDvVHaWZF6gCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j2paOr/Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SQf0dH/t; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j2paOr/Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SQf0dH/t"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E9B31D00031;
	Sat, 30 May 2026 19:47:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 30 May 2026 19:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780184829; x=1780271229; bh=klINtNg1Sl
	wwEckkD9SdTHaUgcZcT3GORtp0Nje+3B4=; b=j2paOr/YERD7DS+aCiX6+sItU3
	tywuD6STN7awLziLFbIndstft78SIgaGxIomro3DLQA86F+K4L+Ay/z+70OVZDNi
	iBraIkXlZDX4jhDnXWeWIKMFvYlJEwfFQv3MhzK5kILOtdruEmEg5PvccTdwwCg4
	EO/bANNxmVIjegjVF8XTCeII74zTHNo9+KoUtJWo7gd/nnRLBgt4GjjX7/gxXCFN
	DoA3wfK1zsCv+5Mo+SYhim0KsJozMiEvRxXbunygWscg9x3vR8a+sQqF0V4TQgzU
	+d7u43m4sKJfrjeBT041JJ4gc1UBltmicQ6Wnh/a88stPWXtOCXtZw4a7miw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780184829; x=1780271229; bh=klINtNg1SlwwEckkD9SdTHaUgcZcT3GORtp
	0Nje+3B4=; b=SQf0dH/tSHYfcruuo8zmLgqUVdgoHKQ6cq8tilLvCg8/Igwe9sI
	FMve8SIzyzEdrOFiCX70dbLpZ8sqB9Ge0zaFD0kJeFbUL1UYLymhA9Z8tmvXC7gR
	+YX24WKpf87KVsAglKDVT1LJ5lJgQMuspDLkEzM6z2V4ayVyFdL8sOas/BWNVwdr
	FNgwbFQVc5Oeg/M4/Dk6LJh0jc8PFqFkxRcxC6TDC9PBOzrVqLkqbYqlvBctkxR9
	FQdN0o2EYTRYPKcLS7I4lSHUswXSRhE+g0f5UC5dNS2gqv+sN7EwReonoNCZnUSH
	ant0yBBvtUMLLPTb58ILptVzbE5I3/eKj8g==
X-ME-Sender: <xms:_HYbas54081s-mUzzWBUq5Le5swGZSU9F4wZ0f7GHs6AvMclVzJlQw>
    <xme:_HYbakxqqL7xe1NEazJrNDOgpTBdj7FyXoap12_g7Yso-zhKZc7gbjk5jVgxZkoER
    ncvfIJgm8F0mRRYVoD_aSBwXN9BQuvQYo5zamojBjReLaqe6nsEiQ>
X-ME-Received: <xmr:_HYbajwdWAY2By8CZQAbxT8PYc-T5DF-0u76IEmtiiGV2zWxdAUyDhAdsbY0U6bEw2hf-YmONoXmwXJTuFm2ggJoYQAeYmDAa5UK>
X-ME-Proxy-Cause: dmFkZTEPXBxufqq66s1ivm9WxI/IvJ7R83eV10bVnbm52A9trPJTfELPfiZAP/zR4u85tC
    b0yR5T4ZiCMBUpIbBBMWElI2CD0rV6oIKzQkEJooz9EijX8TtRHR4lE9v727uK+cx8KCR4
    0+akClYnRViCaR3eS1nDzp/3XwjjXmrC59F4VhSUlLBOHalw9+53lvDUwK8Eu/F6+B5w52
    dHaJqnW/+xgXJ/lyeGtstWFoorGklFDyl+bQFZDBImyyfpDXySc+ehDaf8EE9ks+XaADzj
    PLiiDun4BX2vulhQTOGCP8rqttDpdyZYGzrncnFGeD5y/z365sa0FyofeGmhNUo9xPmLsc
    8aUlEv5Xp0sGPfNlnNVRWX1nbLeZRRBmXlwDLwq6q8+d7dcHiiuvtgqrqUyNRzDNh7ISII
    buup7c+CIlnZ25jQ25Dsr8XWyedyIRY8hlV8g9wPZoZhMPvTxAJtway66OyXMn1vs/sY0U
    q6pJzbaHUUBPmvIGqAmxdPQbwmfKW0a+EhpY4bFAy+QHh83TiX4c/faJOxiAT/ROLsFI/V
    xR5vqiMA1UcHJjmCk+9xdNy8pnK6xtrCgDl1lnGts+LZ45nXzEF6y8nBOmBjaMo4DNr0Dw
    hKn9rhjZz4MJ7/qyRTjHTotk0u499KpUBDuY6HRzeTRWXD0tVKwMCf6imruA
X-ME-Proxy: <xmx:_HYbasyEuV7-O57i6CVyNF4_hvkemRNkO6-aBY8UYEMHv37n9Vc0OA>
    <xmx:_HYbataPcouI0ghDTzXf72tD8YhgACeDltJxpZBpBh6gM3-I_UCRgQ>
    <xmx:_HYbatXbRX4oTTto9Z2tL6YRzWNITNiuzOaiNYZPzR0fEdvW6uM91A>
    <xmx:_HYbarg_1TtcyHGbCoj4O8DkYI0XI4TxAJcpN2-fjSycp15FBhbh6w>
    <xmx:_XYbalVkzPFnLw8nNqL8MIfgYLEsy7ToE4HPJpCN7RSEzw7EVY13p_eA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 May 2026 19:47:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>,  Tuomas
 Ahola <taahol@utu.fi>
Subject: Re: [PATCH] describe: fix --exclude, --match with --contains and --all
In-Reply-To: <20260528232950.187002-2-jacob.e.keller@intel.com> (Jacob
	Keller's message of "Thu, 28 May 2026 16:29:51 -0700")
References: <20260528232950.187002-2-jacob.e.keller@intel.com>
Date: Sun, 31 May 2026 08:47:07 +0900
Message-ID: <xmqqo6hwcves.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> git describe --contains acts as a wrapper around git name-rev. When
> operating with --contains and --all, the --match and --exclude patterns
> are not properly forwarded to name-rev as --exclude and --refs options.
>
> This results in the command silently discarding match and exclude
> requests from the user when operating in --all mode.
>
> We could check and die() if the user provides --contains, --all, and
> --match/--exclude. However, its also straight forward to just pass the
> filters down to git name-rev.
>
> Notice that the documentation for --match and --exclude mention the
> --all mode. It explains that they operate on refs with the prefix
> refs/tags, and additionally refs/heads and refs/remotes when using
> --all.
>
> Fix the describe logic to pass the patterns down with the appropriate
> prefixes when --all is provided. This fixes the support to match the
> documented behavior.
>
> Add tests to check that this works as expected.
>
> Reported-by: Tuomas Ahola <taahol@utu.fi>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>
> I was looking into reviving the patch that just added a simple die() and
> realized that its actually pretty straight forward to just fix the support
> instead. I'm open to either route, if we think this support isn't
> necessary... I'm not sure if there are any gotchas or other issues with how
> I implemented this.

It is curious that this fails in some but not all CI jobs, and even
more curious that these failures look the same.

e.g., https://github.com/git/git/actions/runs/26671595367/job/78615760984#step:4:1984

  +++ diff -u expect actual
  --- expect	2026-05-30 02:21:23
  +++ actual	2026-05-30 02:21:23
  @@ -1 +1 @@
  -branch_A
  +remotes/origin/remote_branch_A
  error: last command exited with $?=1
  not ok 70 - describe --contains --all --exclude
  #	
  #		echo "branch_A" >expect &&
  #		tagged_commit=$(git rev-parse "refs/tags/A^0") &&
  #		git describe --contains --all --exclude="A" --exclude="c" --exclude="test*" $tagged_commit >actual &&
  #		test_cmp expect actual

Rings any bell?
