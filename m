Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01F2CA7
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 00:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709686540; cv=none; b=ru7o3G2mcA8FeA9p5AoZJAcCdAwg/iAO5lj32ytmbs5qXu8cBZTacxf6yOmL1r30DL850hVxNrLM+U5X1VGhOJDnVPkRiYpSLpasLz+yLOSrftxhj8UK969xxy1RbPSphh8WuBa4/OcYfH7EBI1YtjYduLt3ygRPnGJmNwAKp20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709686540; c=relaxed/simple;
	bh=v62nAZN/Yvkwlj1yz+g2qv3zm1fRM6LsC3Nuv/vhNis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cle8m7fkli2Jsbxn1uq41HjuqsZKtOrsPBiB9vtxvAIiwUjl65r5fWAu33NQdGBqgGQqkFO/0zmfoYn5O/YQcKHFN9xOpCXiD8ju3GxXdwXlKUviA+3rabaxn57/RcOvsjpa4fyRQPxreDsrzj2+/h23Z3EUQYXdAPnmrBMQUkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=t41QRZ7p; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t41QRZ7p"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 96FD420EA3;
	Tue,  5 Mar 2024 19:55:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=v62nAZN/Yvkwlj1yz+g2qv3zm1fRM6LsC3Nuv/
	vhNis=; b=t41QRZ7pX+LRdLwG2DyNm8BiFeBRsGuZ/z3VzrYzYLsscSOiWAgtyu
	QEtyeA9doHPcgJ2HVOmz5IhyM4TXUNMfWeVAkf4nFuGR9aQ85WSoiW/QDjUXCcF6
	zufrBHrEMjfhHi/sQw4H0vZ7smOrMIp/iWU8dKE/hasUHK8eWfSMs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F1E120EA2;
	Tue,  5 Mar 2024 19:55:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3868E20EA1;
	Tue,  5 Mar 2024 19:55:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 16/22] t/t3*: merge a "grep | awk" pipeline
In-Reply-To: <20240305212533.12947-17-dev+git@drbeat.li> (Beat Bolli's message
	of "Tue, 5 Mar 2024 22:25:15 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-17-dev+git@drbeat.li>
Date: Tue, 05 Mar 2024 16:55:33 -0800
Message-ID: <xmqqjzmgw54q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3D9C4E6C-DB54-11EE-9EC7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  t/t3920-crlf-messages.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
> index 5eed640a6825..50ae222f0842 100755
> --- a/t/t3920-crlf-messages.sh
> +++ b/t/t3920-crlf-messages.sh
> @@ -97,7 +97,7 @@ test_expect_success 'branch: --verbose works with messages using CRLF' '
>  	git branch -v >tmp &&
>  	# Remove first two columns, and the line for the currently checked out branch
>  	current=$(git branch --show-current) &&
> -	grep -v $current <tmp | awk "{\$1=\$2=\"\"}1"  >actual &&
> +	awk "/$current/ { next } { \$1 = \$2 = \"\" } 1" <tmp >actual &&
>  	test_cmp expect actual
>  '

OK.  The original excludes any line that has $current (a branch name
without any funny letter in it) on it and sends the rest to awk.
The updated does the skipping inside the awk script.  They should be
equivalents.

Looks good.
