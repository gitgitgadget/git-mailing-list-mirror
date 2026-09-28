Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB04E3239
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607677; cv=none; b=GrBINcqnHIJWS/EMge90ukFMYszpMkcP6ML+/BYdTTyaLB7TR4NVoIC/BfJmm/plsRn3mOx1KM8BPQGebIG0VXrK8NFgB3kSPobLxdoLaJueT7rfoQUU5uyJeOu/HIbErWh8BzK9bipey15u9+x1CFjAO5UiNDh4FLKHKHh69mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607677; c=relaxed/simple;
	bh=nIqeZ1DgVM4bhFq1tw80Srze5Yx5kdPkarwyM+humZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sPGYB1PdOZG6L6DbMG14zLmkxklypcv19EHjg/PpRFCgjmlQ5+33AuxNRBG0s36z1E5SxER5vuQfHFipK/3yC/6pthxqzx2VgdyTBCs3B7c1q0ImvN35htujVvVbrAXqL0RmxVxblpux9vDXjRArv45fDkc3svqW2dlB9mI0sUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qOdReZo0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WzKJyuU1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qOdReZo0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WzKJyuU1"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D7A6EC0183;
	Mon, 28 Sep 2026 11:01:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 28 Sep 2026 11:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790607674; x=1790694074; bh=r/AmFP3roq
	edv3ygaatAGWhPTmG13TrKlj0umoO9hd0=; b=qOdReZo0k1wzYYz3tLgxiPwvz9
	p2dKW7FXvTIrDyNv5GDSBNDNiJhYEXs42p+iDwfx5a+Rprm9HTz2Rij+EUNdNYKO
	jkZYAymGTP/Ltguy/A9SCoVlU+Exfh/iGxRKeU+8egTxXQiAd0JP1djWRfrvkXJF
	dQNjvEzvtSXHuOVdR2v7zHk9kLF+VO8NN96/VDp9Ssw6ggE07VI1g1ETTO77q71t
	/g1qAD3pObKYR7q4qVIueQnlM+whxxXZ+Z/N33Kdfp8Do6AOagjs5pmEJG4moBwI
	BLmTeiHeYMYYoH60y1wBHqDuHrmJDkvSx6GpzoscAcJ+Mgx+34pKfGFTxJiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790607674; x=1790694074; bh=r/AmFP3roqedv3ygaatAGWhPTmG13TrKlj0
	umoO9hd0=; b=WzKJyuU1Zdya1eYhxgzA5VHCQtQUBeJQMLNlyWXfBLYW3JKrtYM
	aeVlEy9scEUlZkeaifbSxQ5bdil+KbBMYGKlgoEXqUlK3/HT5iBrLO1FtXEAvl0c
	6FOk0OJKRUvtPR8ack6pRpJF4g5UnQqpi+8b6f+PTSVnUmRGVrDpV82k48qBfxUK
	81gBs1BI8p913o25KxovFsuRKVKGzY2DDXEMcKVMHcJn8K+Z09fb44JgciXwk4ge
	VYjeK4mExXQ5D7eQXiCqxdoysC16wu82sjevt8kBOSrqDQXSg1gemH0O6diRNMyf
	L3QENpFJkHoa4vFVsnq2wz1rPQzVLIxJWBQ==
X-ME-Sender: <xms:OoG6anE507adRA8lwU9gorHRGvGT58A3OlTi0O5H4Hn-_ynU6sW7Ig>
    <xme:OoG6arzyiEHU5Ksx6TCogsiUoY12BepaIp8nmgtEn7s3K8NkMtE0wESbmQc1xkPI3
    DVGNV89fVQfD0qeYgtrAz5vI4ML3Mr1Pnz9rIr0qgzjid4_UnunLOE>
X-ME-Received: <xmr:OoG6amhKMvPRU60klfT3UwdWOa3mzYUTKUUL6dsnJf77x9cmMhbNOq5EKBmq3wnxjRTo4a5s7GJ6DUd0WBspJgTHcB1hf2vphw9v>
X-ME-Proxy-Cause: dmFkZTGCbatcAaNGCWAh5UmQ2tnQ0mHYm+8ZWQM0mHdR9bs2P42jUz1hm7TG9PhbM5nc2Z
    FQSjM7k//GuvwFtgvwtgjTAWsD0QlAaMqry16G2zGDo9gsYg5HoQA4+jJBQnq6yhe6XVR5
    tdc1otoY7feBqia8pTlKE2R73YpdEwMCEanqZLJq0MRDNCO6uie3247AKwk/redM5i8NYL
    gquk/uDSGzSiO+ieufDOIgqjntqywDwQQEY9q+LfCbo0lMNJE0xQaIQPIp+fcP1J1snjxa
    s1VoE/cr2nsWVex1eYp5q5nH2BMq4frDVXhdzlzfcC9RvO7XlUUpi0oHs2azGXaeCvZhPS
    wjwNflz2t3jSo/wt4n3ezOzOQB2DYtH8zSX1bcBGqd+K0e+Rq60zU3zn1cODBn+4N1TwS8
    VtH4jW6Lu3mTbHacEDbiXYHA9aoGaXzDxpNNw/GcHtyMWrv8zW/PjHg1aqgQljDUosSm9c
    ondOsFmyYAQmz2JBc9iHp0bYZi5Tz9lqXippURjw2SzUD5CQmaQvi/mlotRPoyJ83FpyP1
    W6DngifR6VxSOjqdJMc3HgO+p7B/eVaosQ62voobl8KGbAr+C+Z+8Ft3RDqvn0uYSAmr1A
    jkA25aGhybm+zmSl3u5PB2Y7gKczO+YAJBmJcJEX93ffBSuvmBRK8GZ79bsA
X-ME-Proxy: <xmx:OoG6auyh7WtMTcpX_g_2rnhLsquYoeF9yjjZEjjA4ZMOwem6QZ-O4A>
    <xmx:OoG6ahJ1mcvG_2RfVVwItXcUsC8XJP8pIeMQpOka8h3Sfb2rR0ZW7w>
    <xmx:OoG6atSFriJKyAdHrzl7pPLssbS2_irArJny2ZW6WuGD77uzBeT52A>
    <xmx:OoG6ahp9zjXhApnZhd4JwXy8ePlp8vEVzmQ_5dIxNbzgrMz9tLhQtw>
    <xmx:OoG6aoicPER8v3p5tjQbTHbjdO5DPCOYjrNxj50WeGnPf1RQtzyPxmCs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 11:01:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] http: handle curl stripping creds from effective url
In-Reply-To: <20260928040149.GA498186@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 28 Sep 2026 00:01:49 -0400")
References: <20260928040149.GA498186@coredump.intra.peff.net>
Date: Mon, 28 Sep 2026 08:01:12 -0700
Message-ID: <xmqqo6dho1xj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I've used curl's curl_url() interface to do the stripping here, mostly
> because its behavior should match the stripping it does internally. And
> also, though we have code to parse a URL, we don't have any to
> reconstruct it, making a single string comparison hard.
>
> One alternative would be to parse with url_parse() or similar, and
> compare the individual fields (skipping username/password). I think that
> would probably also work in practice, but it seemed to me that the
> simplest change would be sticking with string comparisons.

Very nice.

> The curl_url() interface appeared in 7.62.0. We document that 7.61.0 is
> still supported, so I've made it conditional here. Only new versions
> strip the result from CURLINFO_EFFECTIVE_URL, so it's OK for very old
> versions to skip the extra comparison.

;-)

> We could probably declare 7.62.0 the oldest supported version of curl,
> but it would really only save a few lines of #ifdef here. I'd prefer to
> consider that question separately.

That is very sensible.

> +#ifndef GIT_CURL_HAVE_CURL_URL
> +#define strip_url_credential(in) NULL
> +#else
> +static char *strip_url_credential(const char *in)
> +{
> +	char *ret = NULL;
> +	CURLU *url;
> +
> +	url = curl_url();
> +	if (!url)
> +		goto out;
> +
> +	if (curl_url_set(url, CURLUPART_URL, in, 0))
> +		goto out;
> +
> +	curl_url_set(url, CURLUPART_USER, NULL, 0);
> +	curl_url_set(url, CURLUPART_PASSWORD, NULL, 0);
> +	curl_url_get(url, CURLUPART_URL, &ret, 0);
> +
> +out:
> +	curl_url_cleanup(url);
> +	return ret;
> +}
> +#endif

