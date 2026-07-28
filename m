Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6C3314DE
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254517; cv=none; b=oQz5oKEcCGqRzRvgv3x1cqBrtnDZOitxC2Rg/IeSM0CEXU6XV4QHq1J0c2XofAE0Vzfmq6y8ewXJYemXnAA2zQJ8ABqT7P4cVCrfn6ocQa+GDJhVQ9kKWHFKj6BRPJaWSZINxgNwSaDwZP1C0+SaHWfoWYaNjxpRUYPVfQ1x8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254517; c=relaxed/simple;
	bh=ZEfe/Xc7uyhjUqS03Re6ZT5Z6ZLmlPfWQCw9Fw0+u+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJswrs0L7O8EbR+K6tcB/2iV3W4cqU85nmPjuBrAgLq6lfPu54ceQqa3ehxHjw7ZN24S5BTiC7OaGXmc59jpUmHBqA4aImgTJYHiSWryECAVZi2nhUvKvcRLRCuleZo0oDynW1hv+EC8VhQHMSkJIkQoHesHdIdV6yWFMXOwd+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=er58RpAc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TtvUeSUi; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="er58RpAc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TtvUeSUi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C35B1400146;
	Tue, 28 Jul 2026 12:01:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 28 Jul 2026 12:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785254515; x=1785340915; bh=sAmJ2Y8wdQ
	B+tW7qrVJzPqaNJ4AbucHJw27CobEXzBg=; b=er58RpAcF5aLoAnANCVgCgssNz
	BnbMFuFDbg0un4B+LKib+0usQkKiiU54XsVPGU/oT+JDCv+mIJocYYT2l7p1/3GD
	zx6IZsHqh6Lqba2C3uwz7C5C9Y4O44adlFhSzO0ldjSHWX7rE2aOShc/eo6Z+yoI
	M8cLlJzJ9+Cr9YtE+GvTAQI8F6wvO1pP9nMhns1sGaGD2tiWenCpB/vXOrEttbib
	9T2+TwV6p4avgacUE6ELnT6he5x6xJb7TYuMzQSHoRFR5+zMK0X2pHm0F91Wz5z1
	Q8B9UVQEQS73nnZbk2bAMEeWmZmwzF0714mWX7bRP+H8MDfUzBteSRxcDR5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785254515; x=1785340915; bh=sAmJ2Y8wdQB+tW7qrVJzPqaNJ4AbucHJw27
	CobEXzBg=; b=TtvUeSUiWyADwvBZvTRwgJmNVzN/g2HJm2zUAK8wU7gGXH54XuV
	QFG/RMndZAxU0vWGQZVil+14O/KTQJkL1IrqMz5NBXWA8EVSMGJeJ4dcIzyHnH0g
	p5mS7ZA8e2loKi9+1dBe6+AGt1rrG6uOSBBO6p6tyB4TWr2pF1JCIdaQbXj45+Qq
	RKyaI+j+VsiR56MCjF+u4CZrgZB20cYDWdqR6diKzErFW/oq030TxRDvfnEvR4+U
	jedcdkarml2ibiW+OdbjHHQmRyQgg18N5TEneRzcbgTkPjJzmsz5DgNpYdwJDaXc
	aZvu1dWTqedWGaJ0TuuVHH/2EY1ZBVa9WfQ==
X-ME-Sender: <xms:c9JoarOes1hEbJWqdfurApYlPubzGiTEsi5-aAngQrf0PI2CQQh9jw>
    <xme:c9JoaneOtDEeJCV3chCDSdch5R9AaHIVpHvnjUO2zQmv89Q5SGzylDxAekX8COzLj
    qO-LZmaOX0AjBEn4QToic9z8xmNCYbSDZjGVpjo6203hYDMxB3whQ>
X-ME-Received: <xmr:c9JoaqVPqR7EjMNyrjLFMKtN2HGF4vqR9EgA6R4RWWuqKSfoMsp5f8biQiwBffegogixEtDZGQucDfmkaShPKoKciHpIpyaG7A>
X-ME-Proxy-Cause: dmFkZTE3vL/M80ZT9aUpejZorsFLsnWIIgyVikTWPiBZ+8S0zlFRiihjGI8z85FPbb0vDZ
    Hjwq0A90N0O7pkcuxiFgVgnUeqonPSyUvSCI3NUtGoP6jx6cbZYEFS6dvqR3YuWgngYgJm
    AVRs3sLgHm1OINHuyVP3xVFcvjeviEHtNACZ+x/ZU/sK4nD3GzxoqohUS0yQDmUgJkVsJW
    j70nVpqtU/MZOeT6Ddz59w7AuOENSuqXA+FOlN3sNp8hSmen3yEUSMtAYv+JsUTaV7IoJW
    QaQvPuD2r7zP9XnGFSZXKDKZ7Gg1+b22d5OHFZZs0N1Ui4Xk7UyO36s+DRVOAwmk7TmSp3
    +O+qNqz8r9k+oJPsX26RXaAQUAHkLsF6mgE5fkb65i92Sic6PcFd8fiMslsXHymlU9h9xd
    Dny9Xd0+37jZf+wVDr1U9YkAAaI4pPlSBzI13oJ/wmabw+5WCqZLCZ05kOyAmPPdBxMN/G
    6MvQNtNFms7hpKRcvLsAghrMuV7iAWSy//vlQt3T27ha681ZXL4wXBi7EM3IotKA/XXg0i
    Lu5QOkQDd0wtY91YuoI/Uxmv741XKKj0/9WoQaJ3U4MtMWpTAt/r88sPJBKFASIAvCl3Re
    5CsfhLFrMc4/VfcthT4b3jRd2Pmr2bHPZA+JW7WNMqLT+iJaolJBmNh2zvoQ
X-ME-Proxy: <xmx:c9JoaviAvbHR1qvP41sdGaLhC-RUOqE5oen4FqEQIBbE3LZdaCxiiw>
    <xmx:c9Joap8BaDrEF71hkr4TeE-FD6p1dKSw8Q0xPlDySqn4pxgvfUmFMQ>
    <xmx:c9JoahbMwqd9fKeWYWYdAVQzjtMzy_M8J3Fb8nQPCe5aweb9ulKqjA>
    <xmx:c9Joag0EWPJ_uEB1LP3DzB8JuWjhaeIW_H9JPHBUw-HM03VgWbQbtg>
    <xmx:c9JoamipQ2MPUIZAmbXqoE2zHnwluiooTrVSSNP_hbt3G8VFoEmgO9q7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 12:01:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] t0014: generate deprecated command names dynamically
In-Reply-To: <20260728143845.GB41686@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 28 Jul 2026 10:38:45 -0400")
References: <20260728143653.GB11894@coredump.intra.peff.net>
	<20260728143845.GB41686@coredump.intra.peff.net>
Date: Tue, 28 Jul 2026 09:01:53 -0700
Message-ID: <xmqqse53drwu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> We have a few tests related to aliasing of deprecated commands. They use
> whatchanged and pack-redundant because those are the only two deprecated
> commands we have. Eventually those commands will be removed, at which
> point these tests will be checking nothing useful (they'll just be
> regular aliases, which we already cover in other tests).
>
> We could remove them at that point, but the code to handle deprecated
> commands will still remain. We probably do want to keep the tests around
> for the eventual day that we deprecate more commands. So let's ask Git
> for its list of deprecated commands, and if we don't have any, skip
> those tests.

Ah, now I understand.  So HAVE_DEPRECATED prerequisite guards tests
that require at least two deprecated commands, so that we can test
cases with aliases that involve two commands among deprecated ones
referring to each other.  Obviously, with 0 or 1 deprecated commands,
there is no point to perform such tests.

Makes sense.

Thanks.

> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
> index 9d7c737355..cbc447b481 100755
> --- a/t/t0014-alias.sh
> +++ b/t/t0014-alias.sh
> @@ -27,10 +27,15 @@ test_expect_success 'looping aliases - internal execution' '
>  	test_grep "^fatal: alias loop detected: expansion of" output
>  '
>  
> -deprecated1=whatchanged
> -deprecated2=pack-redundant
> +test_expect_success 'detect deprecated commands' '
> +	git --list-cmds=deprecated >deprecated &&
> +	if read deprecated1 && read deprecated2
> +	then
> +		test_set_prereq HAVE_DEPRECATED
> +	fi <deprecated
> +'
>  
> -test_expect_success 'looping aliases - deprecated builtins' '
> +test_expect_success HAVE_DEPRECATED 'looping aliases - deprecated builtins' '
>  	test_config alias.$deprecated1 $deprecated2 &&
>  	test_config alias.$deprecated2 $deprecated1 &&
>  	cat >expect <<-EOF &&
> @@ -89,7 +94,7 @@ test_expect_success 'can alias-shadow deprecated builtins' '
>  	done
>  '
>  
> -test_expect_success 'can alias-shadow via two deprecated builtins' '
> +test_expect_success HAVE_DEPRECATED 'can alias-shadow via two deprecated builtins' '
>  	# some git(1) commands will fail... (see above)
>  	test_might_fail git status -h >expect &&
>  	test_file_not_empty expect &&
