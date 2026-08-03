Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD76426694
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777716; cv=none; b=BIC/gMiGeqwPKP0CUVWWalyt9FjUS33oH1XvR1LKzJRSzmkHZminc34iD6xNBsWUN3RYZMc9H3+kec12XtAtEZwF62Euxo1DBM51pPovqVS3HGnHU0PsJIKf/xnPGwjFGD1PFcf9AtlUaoDy+Gh785Wya2kp69PBZwfA0+HnUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777716; c=relaxed/simple;
	bh=9FioILSdKij3sml3Li4oqtFlFdsv0AH4TUwVrA4WZHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VxvaDnuoFgmsYQkjP65u41Y5FKQjJA8CAPWq8Z+n3AH5Q+ujoEJEiLIthlsmR5i9Lj3TI9ixebU1z4vWSvU0u8mL71ZsIKTv6Tvosh+jmGaAGJ3znvGjeZgNknDB0PjvUcs2QIJSxcqWBeCfg9zZetWD9/drtRI8WPjKKFdLJc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=boMPHbUU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z6AOO3Ss; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="boMPHbUU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z6AOO3Ss"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 3EF701D000C9;
	Mon,  3 Aug 2026 13:21:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 03 Aug 2026 13:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785777713; x=1785864113; bh=5Pq/e046Rx
	n9ehW64/orB2quTA7xqgDrgb6xva36S3E=; b=boMPHbUUhwMQW0FHyk6Yk9FO+l
	RHDJ1bPKWmh64HrA/KF5fy4YLE6d9Im9tzWMvs7h5rX6I9fV6Ywc/x9wK4lBPJBJ
	iVnxNAFngenGmbai+UIzvuZXrxdW2QO8tDVAR+Nzc/LKJcYFHpO5SLbIDDOyz27R
	d4ZqU/SLgdIjU5sBnykyWVhBOr+438h8YE5zTGQcQg33F5TXfjiXQFtUDevZwQrp
	9sbhMfOukmTIcUiXee4AGApYl1ePrUZfv8anaRQQbqejo3oOPlInG7Ddsf6opBjh
	09FGtQ5iPBD/X8HcRmLnrS5kAXRuhR05nBNhJFWdtPlAKj1Mx6b4DkDod7+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785777713; x=1785864113; bh=5Pq/e046Rxn9ehW64/orB2quTA7xqgDrgb6
	xva36S3E=; b=Z6AOO3SsI+RduBUt7BDuz1D0Zm2RfXxrcdi69idDFBI++7DWRQh
	KOLy+E+t5ppEJ5dzDlfKP6UigfJN3E20KXoKfnXU7pjsNv1QYK/xoozrKxl6t/3j
	RnrMPrG9psNgdJheJmNtwqEH/dGilqHEZePIu8W4LfzqNQ3D7GiKGDZyn/IYCgBP
	1BFh5CqpsqaAurlG7nHk59LaDuZSGw8LCFK5bF19akPhDMUKuF8yoyGeo+DnV9VX
	KI/AX2mjG2HaOiHq3VyhE5vuD56Ps0X55x9+jn4G5MmMEcEmC9StE1QNJIB1ZF53
	zW4u/ITd0P4TlQRDWQ2+xBOAS8taP80IMAw==
X-ME-Sender: <xms:MM5waufr0g0qb72zsfQXQgmslFDn7Zhs_tqkiM65KOcE2i4tyvLWoQ>
    <xme:MM5war48JSU9lTZNTzU87bnPiolEfUTosvVO1KsFmB4Y76MCZoo8q-Mtff1KM4onc
    PoFvKiJx1HHIhtKFh62AdkY1z8asG7myYNB_UUVmWpeY67AqBUE_3w>
X-ME-Received: <xmr:MM5wapXrWFHya1GdQxZH-reeMGwEDwMsvo-UriK9evgmmcSNh2qJG74Wz1UGlpqyuku-v1q0HaC0Dwval6eM5e0w261a5DX0Yw>
X-ME-Proxy-Cause: dmFkZTG2Y6jpkvmRNwhRMM8ZzAY9D6uHcCHFt60WyuUIb6/xpo93vcayoeugOf0TECPpwJ
    +oaAhLWd5wekCxqXMgi7MzjuXxrY6lIJSulia3P/L8TbJm3UVXF58PlNeFUMGm321MS+/S
    YjXMLfVzziBmpHWC6m+W7A+S/xakwMxWwT4LbWdcdby7g6AYPBsJlPDt9Pe9SYqCBN2Wk+
    BHeUCxj2yLvLK+VApK/0rYQGL3ec0sv937Dg44I9CGH7HV5NxOUEZFbm8xYeZkeVOx6dQV
    UdA8jKklz35i6rNwBQBb8GvLFj5qSdHm0YXFmSwlkkxHqhEBbJTfCyfadJLb9Gy2eU0Jsm
    rTQO/VyGTPi7o6R3wxPDQg0SCBV0DU+Z305GftF8yEj1Hmho0vmXPNECHYrR6jzhoBWKSX
    10iVP5qcl/b30E5eFN8qYzkCfYaKJn152Exhx5BKIrYo6tOykJxq7zGvIiB7xZJ+o+PVIV
    1TBCinYr347PPYcd0J68Jkm8PV5aeyT1L58BCQKyNGH9IvCQbZYDiHsTgSk1cZYofll0lH
    cyg3AFrA19o8S5ZHWQjTmzUSSfJRRQcb+MZeij1woKYxMkQgd8sZkvh2AmgWtBUfDNEAfA
    oq22EMtWj2APw9JRxbqKI7VoTzsyPvLclEeHsZK8n2BgYnUuxB0ieUr8HhTw
X-ME-Proxy: <xmx:MM5wai6czc2oXvhZqktA5JICm1VjlFnnGWKhl2qyOm9HwLoy60ZkzQ>
    <xmx:MM5wasqiup8KavjL_7z5P1RH7R7FEseY4Ruc4dRqsJ8m_XXiJjzE2w>
    <xmx:MM5watnqIH50iGH-XLnFfoG4SUWWp9a3Z5Bvyedq1czNV5PomdRNsg>
    <xmx:MM5wagNrFwPeyW8ORA5rdwLQ-eBf5RfQJBFgkv-h8DaGNvOP-1-rEQ>
    <xmx:Mc5wavO2uKc18vYhQ2tOqQfHe2umUivn6krGUI53peg27AA3Xp3wCTud>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 13:21:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  karthik.188@gmail.com,  peff@peff.net
Subject: Re: [PATCH GSoC v3 1/8] t5701: use test_file_size() to get the size
 of a file
In-Reply-To: <20260803-objecttype-support-v3-1-7176fecf7950@gmail.com> (Pablo
	Sabater's message of "Mon, 03 Aug 2026 16:39:28 +0200")
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
	<20260803-objecttype-support-v3-1-7176fecf7950@gmail.com>
Date: Mon, 03 Aug 2026 10:21:51 -0700
Message-ID: <xmqqbjbjyv9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> The 'basics of object-info' test runs 'wc -c | xargs' twice to get the
> size of two.t. The pipe to xargs is only there to strip the blanks
> that some platforms pad the output of wc with.
>
> Use the test_file_size() helper, which outputs the size directly, and
> store the result in a variable. Because 'git rev-parse two:two.t' is
> also run twice, store its output in a variable as well.

It also has the benefit of retaining the exit status from commands
run inside a $( ... ) construct placed within a HERE-document.
Earlier, if your "git rev-parse" failed, you would not have noticed
it directly (though you would probably have seen the "expect" file
containing unexpected content).  Now your assignment fails when you
compute two_oid, if your "git rev-parse" segfaults.

> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  t/t5701-git-serve.sh | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index 9a575aa098..51d5dd1ae6 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -344,20 +344,23 @@ test_expect_success 'unexpected lines are not allowed in fetch request' '
>  test_expect_success 'basics of object-info' '
>  	test_config transfer.advertiseObjectInfo true &&
>  
> +	two_oid=$(git rev-parse two:two.t) &&
> +	two_size=$(test_file_size two.t) &&
> +
>  	test-tool pkt-line pack >in <<-EOF &&
>  	command=object-info
>  	object-format=$(test_oid algo)
>  	0001
>  	size
> -	oid $(git rev-parse two:two.t)
> -	oid $(git rev-parse two:two.t)
> +	oid $two_oid
> +	oid $two_oid
>  	0000
>  	EOF
>  
>  	cat >expect <<-EOF &&
>  	size
> -	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
> -	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
> +	$two_oid $two_size
> +	$two_oid $two_size
>  	0000
>  	EOF
