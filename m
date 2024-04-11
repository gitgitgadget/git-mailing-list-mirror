Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D0417BA2
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865108; cv=none; b=sDnICc1JdUC8o6ZKO16wrb3Yfe6xRBW5W8F2MFvZZSkUvKJhAhZEQsdCPTgoosO80OFThdAvpvjRfzWod/U9R7s3twf7OOj7cWgLRcvajgeVSF/TQcnFurmbkD49bOFLLM2ZywbPUeG9MO9wn0z6lr7fkEBv0T0Utzm08jHubcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865108; c=relaxed/simple;
	bh=vua7XvRKS+eK3sqECmpRVkb1p0DbI9tbbpWtuXk+sl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DXHy4Ky9QbHRqvfwm5ogvknxp86zabWmUFNvgE4t+Bfy1U+R1uYVtbbScvvjKSRPfJRpaX42/4DUV0fxoaSKyNNG2GRaMJpnhEIPCwLOQaCYDlyzCne78d3J1j4Qs8/LNztca9RUA6/44ofATY2r0JbMnBVgw2qgWoa2pI0rl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hRRFGkSS; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hRRFGkSS"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A2FFC39B87;
	Thu, 11 Apr 2024 15:51:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vua7XvRKS+eK3sqECmpRVkb1p0DbI9tbbpWtuX
	k+sl8=; b=hRRFGkSSKwKhqbV6PzcLh/7qbvbyYrQh+Ix8NhlaKaX/d2HQ33cK8U
	YyZUoC3pBUuvJmBchuS3cInv9QR+v0MytWD+w4dkpvdnIaWpKBPxPAHhKewogR+P
	D9l/fJTACqPxXxTp+rOXif5lv2tvg3t7fpxhSjuJ4eUcO/8donraw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A36839B86;
	Thu, 11 Apr 2024 15:51:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 42A8A39B84;
	Thu, 11 Apr 2024 15:51:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Chris Torek
 <chris.torek@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 5/8] fast-import: improve documentation for unquoted
 paths
In-Reply-To: <2e78690023f653436ec2eba0c5fb9dfa6bb62624.1712741871.git.thalia@archibald.dev>
	(Thalia Archibald's message of "Wed, 10 Apr 2024 09:55:56 +0000")
References: <20240322000304.76810-1-thalia@archibald.dev>
	<cover.1711960552.git.thalia@archibald.dev>
	<cover.1712741870.git.thalia@archibald.dev>
	<2e78690023f653436ec2eba0c5fb9dfa6bb62624.1712741871.git.thalia@archibald.dev>
Date: Thu, 11 Apr 2024 12:51:41 -0700
Message-ID: <xmqq5xwnu182.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EBCD6444-F83C-11EE-9B4C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Thalia Archibald <thalia@archibald.dev> writes:

> It describes what cannot be in an unquoted path, but not what it is.
> Reframe it as a definition of unquoted paths. The requirement that it
> not start with `"` is the core element that implies the rest.

The other is that a path with LF in it cannot be written unquoted,
which should be treated the same way as ones that begin with dq in
this explanation, I think.

> The restriction that the source paths of filecopy and filerename cannot
> contain SP is only stated in their respective sections. Restate it in
> the <path> section.

Elsewhere later in the series we clarify that NUL cannot appear in a
path, so the above looks perfect at this point in the series.

> Signed-off-by: Thalia Archibald <thalia@archibald.dev>
> ---
>  Documentation/git-fast-import.txt | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index b2607366b9..f26d7a8571 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -630,18 +630,23 @@ in octal.  Git only supports the following modes:
>  In both formats `<path>` is the complete path of the file to be added
>  (if not already existing) or modified (if already existing).
>  
> -A `<path>` string must use UNIX-style directory separators (forward
> -slash `/`), may contain any byte other than `LF`, and must not
> -start with double quote (`"`).
>  
> -A path can use C-style string quoting; this is accepted in all cases
> -and mandatory if the filename starts with double quote or contains
> -`LF`. In C-style quoting, the complete name should be surrounded with

> +A `<path>` can be written as unquoted bytes or a C-style quoted string:

If it is followed by two-bullet-point enumeration (one for unquoted,
the other for quoted), then sentence ending in a colon here is
perfectly fine, but we are not doing so in the next two paragraphs,
so let's give it a normal full-stop (period).  And make it a
paragraph on its own, which you did correctly.

> +When a `<path>` does not start with double quote (`"`), it is an
> +unquoted string and is parsed as literal bytes without any escape
> +sequences. However, if the filename contains `LF` or starts with double
> +quote, it must be written as a quoted string. Additionally, the source
> +`<path>` in `filecopy` or `filerename` must be quoted if it contains SP.

As the description for <path> in filecopy and filerename refers back
to this description, this "Additionally" is a good clarification to
have here.  Nicely done.

> +A `<path>` can use C-style string quoting; this is accepted in all cases
> +and mandatory in the cases where the filename cannot be represented as
> +an unquoted string. In C-style quoting, the complete name should be surrounded with

I somehow think the early part (before "In C-style quoting") is
redundant and unnecessary, as we started the section with "as
unquoted bytes or a C-style quoted string."  As the previous
paragraph about unquoted path begins with "When a <path> does not
start with a double quote", I would have expected this paragraph to
begin like so:

	When a `<path>` begins with a double quote (`"`), it is a
	C-style quoted string, where the complete name is enclosed
	in a pair of double quotes, and ...

>  double quotes, and any `LF`, backslash, or double quote characters
>  must be escaped by preceding them with a backslash (e.g.,
>  `"path/with\n, \\ and \" in it"`).
>  
> -The value of `<path>` must be in canonical form. That is it must not:
> +A `<path>` must use UNIX-style directory separators (forward slash `/`)
> +and must be in canonical form. That is it must not:
>  
>  * contain an empty directory component (e.g. `foo//bar` is invalid),
>  * end with a directory separator (e.g. `foo/` is invalid),

Thanks.
