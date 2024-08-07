Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C431D0DC0
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022757; cv=none; b=KSKoyna24tWdaqeWn/9kjEkl7bvOYyLI/dU6a9vs+Q4ITml/d5pjQ7lZn4pQpAC3qWSkcgZ67ejaB2bTngqd2qgGbL+TA6MEw4HMzPuy1nBqDXEtm46Ppy2q8z0K0u7wmLjtj3a9MNoNo7KT6SQedTPFgx7X1YXvEFdRX92vK+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022757; c=relaxed/simple;
	bh=ZnMuvtmKH8PU9eW7+FpAM9+lelGSKqmjnLvAb6k2EOw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=XqmtAj+55j2PU2mk7X59CUurVGBUwiDR+uWfoaNFVq5EWY2u9DKMC5TfG8mmszxjr30ZVe7MC6wmzGM7Qi9Er/xY0/wCGaUH8Mh7xWKEgGpyh/PZcQgxGS9YiWGxeYH1cm9V48WBfhgqdTMJUOxvlMsaFej4XG2AwEquEv5MSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=XtUAiY5C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dd+MS8bj; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="XtUAiY5C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dd+MS8bj"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8F1DA1151ADB;
	Wed,  7 Aug 2024 05:25:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 05:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723022754;
	 x=1723109154; bh=8BLZdb3tzmSVM8FnXDxIjP64rv4RIMSbY+DvyzZth+0=; b=
	XtUAiY5CxXy1fP+ASgYMeWiE1wPbzFeu+/RRpQsdFaZWuZZGMgulR531oNd0JT71
	epMkkIHeWhET9lK9o64Av4d8cNa2RsIg1tUyJs0Zg32e9ayTgJ9mpsc7iYqMUeFQ
	Yg7l0jYsoqYsOW2sBtyHwUYLdjEhr+xThp4FMH+BNx5QP0ch+JAmD2quswq/9XeC
	1nCcgOOz7Ri0TYEuMWhcbyymk8/JCbC3OdIN9VoemywlwWqpnvv4N4tYVjo7aUVs
	pp7LNwIdhuTbItJ32YT6l3msD2UvRebL6xt9WWqxtj9X2yoFq/Of3tFbBJGqL7DV
	WHmqpzZThEo7gEKPYh0lhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723022754; x=
	1723109154; bh=8BLZdb3tzmSVM8FnXDxIjP64rv4RIMSbY+DvyzZth+0=; b=d
	d+MS8bj+C8stF3hLd4OrnyCfapZHtkzwagPLP1/7ZDdYR9/vuPQ2n9KFonTMuf7e
	LHDFeuJ17RL9OVVhIOyf1j+xuvUhUk7GDQ1DyFPI14dy0fdI1hRiTUz8b4eh3zjH
	IK6dzf+Mj2af9rUc3G933sgg7Cy+1EX9Mw26adEm3fDQKdyGzG9/RSMP2oKWGx7b
	Q4W+zcesVoIXJAyBcElRLLuOeeUcd9B5DUgx115SJ7C1boM5BIZF+qsnqVQLX2/M
	p2mVHTsVossO62gMZABEPs1ZkkWpyCiuOD0Qmq2ZTVb2aRwgoriqyV9LUUDsoqzm
	ZxZEoDX2GjBjD44b7tQPg==
X-ME-Sender: <xms:oj2zZoLvrwR3jyrB8pYtEsmgLuIbJQ0W3iZdcxBR0mZI4wSPcRfF-Q>
    <xme:oj2zZoLi5d-ZIQDcFYX_1ZtPfogQfbv9gKJcSs5hqu_JnmlEmV9K5eaUQMQL8fLh2
    dT-HRiicmljSU6lbg>
X-ME-Received: <xmr:oj2zZouVmmEpDETjPxhIheGQ_-HIi894Ag-LNJdfdU0S35OIEZmfjkCVcNgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgrmhgv
    shcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrthhtvg
    hrnhephfetueehudeltedtjeekudelueeihfevheeugfehhedvieektedtvdevgeeileet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmh
    gvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:oj2zZlb6Mxz_ryK3NCAMwvYItRb-efkxeKiUy2A69gA7XZ8tepacmA>
    <xmx:oj2zZvaelkxsTr0vJgcry2D_g0XA1lDo5YspymAmhX2GmJh--tI-5w>
    <xmx:oj2zZhBPoU6Pg1YrFjEGulkZVIae47YyeDBybp4HG6Dp7oK6kwNSwQ>
    <xmx:oj2zZlabFJ3svjKs5WLdYnjnNaMqwZhwa-dXWY5vVIqYL-In3iRAmA>
    <xmx:oj2zZulUfuxCVwHkUSjxUOKeUTcvID3dMrDAnStcdWOcS2biTKyo1qsG>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 05:25:53 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Aug 2024 19:25:51 +1000
Message-Id: <D39KL8N6S0HC.HFB9VRAVWYOX@jamesliu.io>
Subject: Re: [PATCH 19/22] userdiff: fix leaking memory for configured diff
 drivers
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1722933642.git.ps@pks.im>
 <ef780aa36039560fd069ec97ce87665eb0775200.1722933643.git.ps@pks.im>
In-Reply-To: <ef780aa36039560fd069ec97ce87665eb0775200.1722933643.git.ps@pks.im>

> Refactor the code such that we have two pointers for each of these
> strings: one that holds the value as accessed by other subsystems, and
> one that points to the same string in case it has been allocated. Like
> this, we can safely free the second pointer and thus plug those memory
> leaks.
>
> diff --git a/userdiff.c b/userdiff.c
> index c4ebb9ff73..989629149f 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -399,8 +399,11 @@ static struct userdiff_driver *userdiff_find_by_name=
len(const char *name, size_t
>  static int parse_funcname(struct userdiff_funcname *f, const char *k,
>  		const char *v, int cflags)
>  {
> -	if (git_config_string((char **) &f->pattern, k, v) < 0)
> +	f->pattern =3D NULL;
> +	FREE_AND_NULL(f->pattern_owned);
> +	if (git_config_string(&f->pattern_owned, k, v) < 0)
>  		return -1;
> +	f->pattern =3D f->pattern_owned;
>  	f->cflags =3D cflags;
>  	return 0;
>  }

I'm not sure if I understand this change completely. We don't seem to be
using `pattern_owned` (and the other *_owned) fields differently from
their regular counterparts.

Is it because we can't do the following?

        FREE_AND_NULL((char **)f->pattern);

