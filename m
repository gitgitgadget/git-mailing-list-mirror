Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879F63AC
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 00:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709686629; cv=none; b=U39GTqlGxXsVtCNneUuApqX5TxH8S6aP1MIma/xUXnV1jhfNatwvzDsDWfOYu/8zQwUATbbbPsYT1lYw5HdlWqyTkAUyq7RIJZxoJNkrHibk9yi4HwVocyTxAyac/IhuwAd0uJ2uKgEDNup6mCbPWH++PR1ZrWMcx+6Pc+4L2oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709686629; c=relaxed/simple;
	bh=sRVqG/Hfk0KHC+qAqdgorH6TWAD2idlp5wuL+5XfQjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vo8E2o7NmbKpll8I7szl2x0BCvwtBKQRI5SSEJWiF4LL6xDCOr9xwd61v6HWJLZ+Qfk92MgeZjeWUXLUzC7BIiturVceSV9o8VvCbExQcy9Rd8ZCMB4zxd6SzvKD0KrKssY/Hd1r8M9Gf8r7XRFRwcII5OU4IRNjrL6ZIo0bPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=otAjF/Q9; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="otAjF/Q9"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 580FA20EB7;
	Tue,  5 Mar 2024 19:57:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sRVqG/Hfk0KHC+qAqdgorH6TWAD2idlp5wuL+5
	XfQjE=; b=otAjF/Q9vBJdyXxyfS+SQ48TvjKJJ/PUnQqBq63OoJd4tKxryy27nj
	YfqtI8Tf6DFCaPkSnN+Say3g5+lqiI/oSxeATJ9qGx0vU1sgTL5LN6bz2n2XT9tx
	9u6Oo11SaKVQ3jbkINokW0bqyGusQ/pqDVuJaJYtVfhM1ohJvjx6o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 511D820EB6;
	Tue,  5 Mar 2024 19:57:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2CBE120EB3;
	Tue,  5 Mar 2024 19:57:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Beat Bolli" <bb@drbeat.li>
Cc: git@vger.kernel.org,  Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH 18/22] t/t5*: merge a "grep | sed" pipeline
In-Reply-To: <20240305212533.12947-19-dev+git@drbeat.li> (Beat Bolli's message
	of "Tue, 5 Mar 2024 22:25:17 +0100")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240305212533.12947-19-dev+git@drbeat.li>
Date: Tue, 05 Mar 2024 16:57:00 -0800
Message-ID: <xmqqfrx4w52b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 717046C6-DB54-11EE-A33B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Beat Bolli" <bb@drbeat.li> writes:

> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  t/t5401-update-hooks.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
> index 8b8bc47dc0b9..d8cadeec7331 100755
> --- a/t/t5401-update-hooks.sh
> +++ b/t/t5401-update-hooks.sh
> @@ -123,7 +123,7 @@ remote: STDOUT post-update
>  remote: STDERR post-update
>  EOF
>  test_expect_success 'send-pack stderr contains hook messages' '
> -	grep ^remote: send.err | sed "s/ *\$//" >actual &&
> +	sed -n "/^remote:/s/ *\$//p" send.err >actual &&
>  	test_cmp expect actual
>  '

Both 17 & 18 look good.
