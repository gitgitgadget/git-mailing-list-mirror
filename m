Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814935202A
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183830; cv=none; b=VN4uXuM+tih5sFqLu08iZSH3S7VZKRCwYku0njTfk/3hQzLS4iUJHvzg+mlhF8DuhL/wlbgl+NAetIw5U4TqllQ8aqRwuY6kRhst/Pnxjf4/vKa8J0smpSRlRsPqoMAu2Z41tlBhBA3+uhO1U5iYqrDzpxEjvfTAqW6ELWj8IxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183830; c=relaxed/simple;
	bh=m+jZoBtHq/AcAJw+3CO6kJMzuxrbODZ3NuTgd9eGo5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TRDgJZ+ZgT0avbL9D1f0kUGyzVPnAozz0If+oTh8PMPWPuIT3SlRqSiXvtZ2w6fP0hg5/d8YP9YDqVn5MSBWx3EFiVeA574fLHFcqJNWoP7KhK0J+nXmEuSkYSFTRKHTyTm8NdJaXVhPbalKSl0ysZJD4Sqt11UuXlFe7EAosLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jeOOMaMa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MR2BHmdf; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jeOOMaMa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MR2BHmdf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC7347A0115;
	Wed, 23 Sep 2026 13:17:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 23 Sep 2026 13:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790183827; x=1790270227; bh=fMs8+VS0/g
	vjPTOc9dUkHyQIzLHE/gCtCH4E/XkMkWE=; b=jeOOMaMacA+aw8qkKuDVV9HdeV
	mhrW1fzZP3j2dGAT6cViVCSVTa5Adg9TUjyDKolN9fk73zODggmN5IGaqZMojVU/
	rq7Lu2NacW3vsVYu941bCuSsdmir1adO9ZPuZbSUHduEon8m1GWkOAXeAKiXBGmZ
	pYoAkZ35XMoPi2Pny4eydtApfd9N7yV0hvx3fv+i3+/NlpQm98gKzPJIQAipKz9G
	+oddT750QsF3xFGIEpR5EP+KYkKKtRx1ZMhlGZMUuGYQTEumw1fn/qQ0lgLndIkX
	KcgaqaJJOJCO/kYgfoxsFKz3qWpnxhW8Rjr1vocDdh8sb8e2rTAh4y6r7scg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790183827; x=1790270227; bh=fMs8+VS0/gvjPTOc9dUkHyQIzLHE/gCtCH4
	E/XkMkWE=; b=MR2BHmdfywdhpIm/P5OsnSCTywbRd9/UC4P0PcYYeeEbfvgMa6y
	uGzgTgwkxLq1i6nkWDvirL/VtEuLXooRqSVfKpc60vy0i78t8zThRZH6+UjC5ORg
	Fkcp222Xq8rLiiF/9TZEr0xU5x3FUTEVeNs/UhsVuVKOh/DQcI+9ZcpzkR+K/Yi1
	3i8HndTtUQ/dyzrmAQwUDTnc2uKA3jAmCgrYei14Df0r1KlMV13uchoHGgvI8ho/
	gfByeJwbMwfO1OCauUIju/BNjc1SuPIXc3J07jNJdxkbSlgtIXhsN8T4ETml7bFT
	ACjKFh8a+HcGfb9CcFlsfVaguaFP/dhNKPQ==
X-ME-Sender: <xms:kwm0avpiEijnsFCsXTLBJiyb3l_Pt3wrbGY8k5Xw_YckCRAeZWWg8w>
    <xme:kwm0aginZbrFmqy8ZjXbZ_PJPxP1HqVgmft37RZRA7-42m5DDpYfH9Fv5t05h_Y2M
    9QyHG51qIisZQfZjWWv_7WNIpAES_Q68toqYOiYL_3bVJhskwB5HwU>
X-ME-Received: <xmr:kwm0akjhyz99BfjW0DHSuN5h8l9W-8hsoXKDlvHVRGvLqb8O8HSvYQWMZ1AeSyiwmZJi0oUCUQzjJW-DA33-CnbZ1hpoJEY8aexG>
X-ME-Proxy-Cause: dmFkZTE5v9MunBl7SJZzSzGijdxACxDr8fBm9TVsRYMe3WTzFe06jA3O/q/OB+hBQ+g/Xj
    L2Vp6pLc4ED6yJtU6FZASKnnPK5ej/JUWNP6qi2T4ka3e0SCOdsN+4iPSQCMdhawUn9/tz
    8AaPP8q1OvMd/SJ07zBhU3fA0O4m9cpkLcnwyJHv6VMvOOP/+YE8FvVjg9mu+XhQ8MDJCz
    gbJYqcVb2e8vKqcqc64X40fzgL+LIw00ExlapubRdbwoyfMBUinOh7i/rSgd31MSkNvJaL
    SJ9LTjj/9rGCJ4cCONfvUrFK6n1MsDxKp15thTmG4bH2SqGeFSP6h3BBe9tUAZwzmE7vmu
    pmVkuNeRoM2AvOOCq25DecIWs1qBPrFCjlQDj1WV8/rfvd2prgJ3ubwMRL/fmbO3nhvCRO
    rcSGZbg8guXcgZIiHZ4b1S5Nd1M0ZoCfcoKmy9BxQCNGt6l+apKIZOioDwAtNbSL865/sH
    lglzZxXsvVZOBr/3u+372LBW3+BT9nxmB/O2IqAeo9jWa7dlXfAd4sGDjXMtziJAsZr1Pm
    MxIwzlbFEprZrPg6AY1UfCSgT98Rylovy0risAoG8rNmcXqifr0/DzclMe+JlK9Gy2MYm2
    hJzjpElC5ITwP6DyGKlwbnML4JPJ0/eHS2j7YyoLXdTdt8MeTV2iI5C5qDuw
X-ME-Proxy: <xmx:kwm0aujFNvqTG07IlL8J0tf3ysilCqMEipzxuiq9SEkqWpibq4vE5w>
    <xmx:kwm0asJwFpYOR7jHMQaOv33UkFIm8qnki6f9R_JX_D3mpkRkJ9WdSQ>
    <xmx:kwm0alGosEPUnatQxYjN7CxqglfMBYQmHi2fNLIBJ-uJ7QO0uENIBA>
    <xmx:kwm0aoS4VUiM06jzgVV42WZW-iga4OhY3Xtck400tYhj-2Bt-EtLEQ>
    <xmx:kwm0ap-zugu5_goOi_gUKd74Dn3Pj4earBUoq5kOKEglso9NUnm4trjK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 13:17:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: work around Debian 12's HTTP/2 authentication failures
In-Reply-To: <20260923165922.GB29229@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 23 Sep 2026 12:59:22 -0400")
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
	<20260923164700.GA28538@coredump.intra.peff.net>
	<20260923165348.GA29229@coredump.intra.peff.net>
	<20260923165922.GB29229@coredump.intra.peff.net>
Date: Wed, 23 Sep 2026 10:17:05 -0700
Message-ID: <xmqqwlsbc2ge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> +# Curl 7.88.1 can fail to retry authentication after an early HTTP/2
> +# response. This was fixed in curl 8.3.0; see
> +# https://github.com/curl/curl/pull/11756. The first affected version is
> +# unknown, so conservatively assume that versions from 7.88.1 up to (but
> +# not including) 8.3.0 are broken.

Just nitpicking the wording, but if the first affected version is
truly unknown, assuming that versions from 7.88.1 up is *not* a
conservative thing to do at all, is it?

If 7.88.1 is from an irrelevantly ancient past, I would say that we
should just skip anything older than 8.3.0, but 7.88.1 is from early
2023 and we cannot do such a simplification.

> +test_lazy_prereq HAVE_CURL_HTTP2_BUG '
> +	test_have_prereq HTTP2 &&
> +	build_option libcurl |
> +	awk -F. '\''
> +		($1 == 7 && ($2 > 88 || ($2 == 88 && $3 >= 1))) ||
> +		($1 == 8 && $2 < 3) { broken = 1 }
> +		END { exit !broken }
> +	'\''
> +'
> +
>  test_expect_success HTTP2 'enable client-side http/2' '
>  	git config --global http.version HTTP/2
>  '
>
> which is not _too_ ugly.
>
> -Peff
