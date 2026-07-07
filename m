Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9E33F4DC1
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441525; cv=none; b=RIxf6D5x3sq+w1wohnDQx+9BgldkR6aFgkhceB7gBJyhatlN6q1Yfpf/rfRZP610FDMVDzeCbFar7EWSge4pv8vyY0kBWgc8vygwCNyokuYKwo6MF2sYsmZovKVEw7FvCgeeyhsCNvRrPEZ2kT/R8Ta+LJpdkbYjouQdJcdpP3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441525; c=relaxed/simple;
	bh=6qhdfdMh1X/S9pfZ9i5s4E5jUA7B6gTUzs5R/YG/KXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G6cINg9qCXsQ34aSCQLeIZedcimBjmHjYFzxjIwFkj8lYIlYc34lTBKdC0PvwBxOqLI+6IxTR+F7jU9BjZHk4wY1UN5KAsPdjOWbNtn8+mrWKf1HNULvDPad4/G6lto61Ao4X6eUg/X4r4b/m1GELkHdLDoGYKLFpkdnLn4i4/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rh/wzgZD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJFi+YuJ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rh/wzgZD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJFi+YuJ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6E2D7A0102;
	Tue,  7 Jul 2026 12:25:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 07 Jul 2026 12:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783441523; x=1783527923; bh=gPHwkA+CAg
	0Ey200YdXztla8PS53HR2c9tc65I0sh6E=; b=Rh/wzgZDXIdtK7DRSLmAP8yr7d
	vd5qQgrmOiiwGZFy4mZC/+fn5Ngm8oezbVfCrg2Gar16aEpLzCaxkPk2dLvQkgvx
	bGs8BeLuSP8WzgSLC/JL5JyhamIFB2NGo2rL9XjwMSrSxXnd1izQ65q9wvPZ1NJw
	i9lxQ1ZsnRWpujZqii2p4dKb14uhEl83atEf2G2LKO7D1j/ML1X/64w1CywTc8o9
	Ldrfc8GOf6PM/yo0vUST2eiHFCuFboiQhX1QUBxdqVy5reQY+HeBGVayFPUH/pSj
	pEL4UO39wu/LhG85lIVT9rfB3FIZYu1YpOxfk9naBsb2d+rNf8KMWkfuPIHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783441523; x=1783527923; bh=gPHwkA+CAg0Ey200YdXztla8PS53HR2c9tc
	65I0sh6E=; b=XJFi+YuJZZOXwMYItxnrGBuxz7wHNR2f/sLxl1pFf+u1QTKDATg
	MWkAfOmQ0om75+lbHGoEgRYjFNXdLQ6a4uT60OfcqiHpy+kLvYQaizMMBF9t8Tw9
	cc7i9AwGDiHDIPAZ0FS5se3NJwh04ej79Khqd+Ia57JMR/zvcVIRcrj1Xv7qufS5
	Y1UkR6TDArneHK2yp8O7eYK8gtJeong/7nAFzbl9XrLEv3lo9wE7KUeIQ+bnt2YM
	EErYe0A5h9//wcrgK6wSO6PsMyt61LxdHRZu+/TtBNxRIS1oDWD0zY/exmsZw6w5
	XUWVHELxMjx2U1OGTF/hXTUghYieGSlBSdw==
X-ME-Sender: <xms:cyhNavQPQLdNLp1sANhEKJa9DtV-7em1x7k1iqxqU8SBG1hYuICsmg>
    <xme:cyhNanrpuPy0g-nl1l4FLHywBGCdBnOv0Z2FKivGmvRcNOI9UG_nDS_wGyr32nkn7
    IMB1XIebttyramW1D9s1NdL7Jrxx_F5KtTLnflU7R40HxdXxjLaufo>
X-ME-Received: <xmr:cyhNatKXCWjz9JFfFvEbcVLl0IF4UE8_g4BdueYeYmE9zbFQW7c6Xm-_q2i9YAhURfLK9TbHkvtJkR8nUuZDrSCQlxF_r3_-qwalMgs>
X-ME-Proxy-Cause: dmFkZTE4g5IUInqTzcKoDrWkBBziJkduhmGpPgVJqqy48EvsJl1u0U/H8jUdoSOVdDAU7E
    kJzauT/w0FUYQSZQXmZh7TRrNiWaSW38Btw4tkmXz1oP6YqVcbi1py7xz2c+prJeEjlpkD
    ywIMlazNut21wO9dUT0NhJyFgA41fh+DbkphXAyqSUl5LQfGUPjqCzvZ+4LlgZ95zpS6Hs
    aDYqWGlphOdlKxp75IjFfSC54w4zKcu4WmCxKrLsP71iDVCahrKCP8FMqTdtL3efwIfyRY
    gMp3KPnIXC2St45TUMfeOwuIr2NlDdOv9OENn0qVxFuWm6zLFVYv8kyXk/og1vaq8pZjRK
    5LAT6OnqZOXRrIAnxmFgbYswZCqmsp6HsaK2a+30XdHgMJrCnqxy+7D4Iur2/JCNnizYq0
    UGwMhoTuJZaEaFCJJet/SoFpkDcYyIYhKo1Eryb9ANXkLpulQRyOXRjKdyrrwlFmZ3aYJw
    TWz9nqdAETnZVkZkNtdQudq2iHjO4RG4IYrGzA8TjXIh8Wz3fRSSO1SY/94dv9dtlhqJUA
    ySa4rC0Ny2RZ5uo6Az7Dml1aH2YnwcAk9OI/SGlolugBPJxNPlUcbQQ1+LaMTxjDeQz/8R
    nod9oQPQuscuYNDCROYbqSzPiSRp+RaIu7QWu24MwjtJgE7PvG1NkQTUR5uA
X-ME-Proxy: <xmx:cyhNaqp6tYFBKq9VgSjN8RGHVcDwKY3dhZhBsvyokHyQCk-4pBeOzQ>
    <xmx:cyhNalyzR_y_MohyupcQ3mTNtEiwsHWDGfiy-xXd1afp3prFrtytYA>
    <xmx:cyhNauNfePo4ErPkg3SZo2I22AHEa4lJBQYOmf8XkS7mQLNjPXzRPw>
    <xmx:cyhNaq4N5GAJmkLuG6chJbRtd3t8y01ZAaz2DffcTFzB6ONbLPCKbw>
    <xmx:cyhNagY3ETQIJTNfYsVPvh4T2PE7LVW6NAPvwZwrs2eyGEz8E-CFPa3J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 12:25:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 6/7] http: use idempotent git_hash_discard()
In-Reply-To: <20260707050814.GF1288294@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jul 2026 01:08:14 -0400")
References: <20260707045556.GA1288172@coredump.intra.peff.net>
	<20260707050814.GF1288294@coredump.intra.peff.net>
Date: Tue, 07 Jul 2026 09:25:21 -0700
Message-ID: <xmqqldbm7oni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Now that it is OK to call git_hash_discard() even after finalizing the
> hash, we no longer need the ctx_valid bool added by a2d8ea5a76 (http:
> discard hash in dumb-http http_object_request, 2026-07-02).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http.c | 5 +----
>  http.h | 1 -
>  2 files changed, 1 insertion(+), 5 deletions(-)

OK, because calling _discard() on an already discarded or finished
hash context is a no-op, we do not have to remember if we finialized
or discarded anymore, allowing us to be extra lazy and safe.  Nice.

> diff --git a/http.c b/http.c
> index 0341de5031..caccf2108e 100644
> --- a/http.c
> +++ b/http.c
> @@ -2880,7 +2880,6 @@ struct http_object_request *new_http_object_request(const char *base_url,
>  	git_inflate_init(&freq->stream);
>  
>  	git_hash_init(&freq->c, the_hash_algo);
> -	freq->hash_ctx_valid = 1;
>  
>  	freq->url = get_remote_object_url(base_url, hex, 0);
>  
> @@ -2989,7 +2988,6 @@ int finish_http_object_request(struct http_object_request *freq)
>  	}
>  
>  	git_hash_final_oid(&freq->real_oid, &freq->c);
> -	freq->hash_ctx_valid = 0;
>  	if (freq->zret != Z_STREAM_END) {
>  		unlink_or_warn(freq->tmpfile.buf);
>  		return -1;
> @@ -3030,8 +3028,7 @@ void release_http_object_request(struct http_object_request **freq_p)
>  	curl_slist_free_all(freq->headers);
>  	strbuf_release(&freq->tmpfile);
>  	git_inflate_end(&freq->stream);
> -	if (freq->hash_ctx_valid)
> -		git_hash_discard(&freq->c);
> +	git_hash_discard(&freq->c);
>  
>  	free(freq);
>  	*freq_p = NULL;
> diff --git a/http.h b/http.h
> index 6b0639150f..729c51904d 100644
> --- a/http.h
> +++ b/http.h
> @@ -255,7 +255,6 @@ struct http_object_request {
>  	struct object_id oid;
>  	struct object_id real_oid;
>  	struct git_hash_ctx c;
> -	int hash_ctx_valid;
>  	git_zstream stream;
>  	int zret;
>  	int rename;
