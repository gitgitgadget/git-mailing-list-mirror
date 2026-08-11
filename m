Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB34D37204E
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455116; cv=none; b=KNpzKXSJ2exgjGTU9OzqTbKsc/fdpa0UbxY7K2HRA+w+pIFzvROzWQI5FBTWCo8kHb8MmgHqquftAfJWtRcwBZg2g/OqXnMthyu1mPUR4ZGWbWqcTOo14Eh6DXfOAH6bGgym0/DD7JS0isygyDD8CLhoxZeJ4MSh/8cZ2YDXsto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455116; c=relaxed/simple;
	bh=pPDjoSb0UeaR6dccb2OqUJ0Y2CbW6JZfycY+/je9imw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIRsN0tg2TUBHjlww0mqpJVtC1aLxtrsF0DgiLmrC+3phSI3a+gJIQROFugK9cXi0yA9YpfnrkC9QdLQIWFDuVfNfjKitS2qoNSeOJD+20crDe/5Wf5hGg7eWk9Zs60h4/kyjI60RqukA2zpEUYZI4ND/gG6kwMJybAZxygU80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EI4Y612C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Le4Vo8BF; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EI4Y612C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Le4Vo8BF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D829EC013A;
	Tue, 11 Aug 2026 09:31:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 09:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786455112; x=1786541512; bh=9k7gXaCCcN
	o5LNvJwTbuEn6fZePoRxbxaCHerlru5uw=; b=EI4Y612COtbB+4yY2mdRJ4nOZR
	DmxL3VvO7G3/GXU3fDKE9XWme2+CK6kvow+7T3EmaX623+LuGSk2DPTmqSJuEQAj
	Dt2BdMM9LeqWuWfCTryQE6pcp4Gbieo0bGFWPmTseN8MTnY/yFoAnaKnLk6MT0Hd
	V2nB1sg/AuboC3fiuvwfPNRhXV4qpEJOdvP76UZkh6dHnfDOT4ThEyOmeLlosrc5
	bDRMOel3zv6C3UV4J390Q/zKeojXz9cTceKXDc9jbr7rU4/3SqLY57NFJvmTj3Xq
	WrTT5iz+BQtFBIp3bxJAmlnRr8hTlx3O6t9iDu/TenXxWnCUJfWAdCtFs/hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786455112; x=1786541512; bh=9k7gXaCCcNo5LNvJwTbuEn6fZePoRxbxaCH
	erlru5uw=; b=Le4Vo8BFfHEDzoDRZTUX3sBllL+8WIlJ9Cppqv05t56S+mFaCPA
	QyLqN5onM6Y/Yfp2XfxWpwMGwcAlkJ/JM29PS0/cCr2BPNOyO0eJIzOH/zkg9AWh
	FAvucKG5b8L79bHRb62OUMjv2HMlVzAJC7lPuELW+UGk2lzw0NxpWwfMEHdrInRs
	yitJMmPblxbeDbJwe8wMg8hW5y8m4kwlp8ecZ6apvmd6AwWmJ5CfMBT8/dJOAKUT
	ziUuvD4RUyuffZBYf/djtD+dJWXfxPezLgcADTToADs2tvs6QTLUUKWWxhKsymKr
	7N5erbOgVy1iATfh0RVy7hdhNnTYl/RK4jw==
X-ME-Sender: <xms:SCR7aldFXwB042C-aJjttsTho9FinApBiFqHYRNO0lzwq_hKYCfhiw>
    <xme:SCR7aqNwP4Iehnwek3hE11-SI257NhrjrdQcn5_BYPvH5D2uTLTE-WDtesvwWyj15
    JGFX1W-JuEcm0uihQxm07Ix2drXl-VT1vmdOJpaTTZjRs3_JNnj>
X-ME-Received: <xmr:SCR7ajh1YxIoJvLJotngtCIa8xvnofA37FcCP0OSwzBEXRR-J4JsPCd9ziz1apzIIIKex34MN-g7My--OVDexmd-0MlYb5a3N-iMavocjw>
X-ME-Proxy-Cause: dmFkZTEi9fIptLDaX94XLg7Yil37m1hgcxJCfJhhPFkCc80KyMusw95uzpXAGnDKJBjYNO
    EO4MZEYNDLpO5CouT+EyBDBNylCAWMW4jJf064tfS/FQHCYBAkptpxw1mpmV0M9n5yoCWM
    bIO9o9+J7XRSIF0qfTvOYTnLWPJ+0+jeHHAj3EdOhx81f1YtCsvLD9WqWuuX8UbYJUj90F
    XTmelqM4BH8HYm0+Gv5ccTPzy8y8wgywgy7REbnycYJ2PkM4DOQSfZ1h2iiFrkPyQ4U2R9
    GzNMwm/Pt9F9YTqKprHdrKchbdNHR9FCaF9ICNQkHNsT0Tc5plXJ9PPtjdUUMlLtxdCeIV
    uch3kKKfDEW27c4cnVTdQdGLis3AKPZx4rBCeeq+/zkR59z3NbtW6b+ClS3zNpIKvLQLiM
    OZj+IptaNSTyhCoQma1TOhiLqnfU+GsSBwaloNes30q1Ppw2bjuucm006BLshHF8yOWBPJ
    LHURV+CL8EPlLD/3Az89C+kR/qIty9cBJT7EL/BEOkI0ag/i+vsQW9EhR7KpKFbwbm5UXg
    xxbiAnUgT75uww9cg9vQvhr2vq8JFrcoaU9e6kXQmYcrPy/VlAkt95PZyBYBzLTn3g3/5V
    tnKgt5UzI+KVp4M//kunUP9aSFacaO0OjtFmLAue398dUavzhCf/7CpIzMMA
X-ME-Proxy: <xmx:SCR7at1GaahqGnpl7oIxZBgS2UH3wIZdiILOmSpjvvmOvT5R3wOp_g>
    <xmx:SCR7atjvevEk5zTqe7giUuzkJ4FdcaMg38vwjmDSNT5JjDoX_XO2FA>
    <xmx:SCR7atd8iv4KV-udPdMLtJGVVlBCkr_c7N-jHm-RbDMAGpQQKJtqZA>
    <xmx:SCR7agllP919mGZfLIw0BPBq5GXZYn5k4iu8YAD1S-Ka5tHFjHpL_g>
    <xmx:SCR7anhsyiZyRYUUO7yC_t_aivPIKaEPkVhKT2zEmB7Kvj5N0e-njeR->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 09:31:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8857c187 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 13:31:48 +0000 (UTC)
Date: Tue, 11 Aug 2026 15:31:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com
Subject: Re: [PATCH] fetch-pack: trace packfile URI downloads
Message-ID: <anskQP_xB-Xw3nug@pks.im>
References: <20260726083310.16180-2-tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726083310.16180-2-tnyman@openai.com>

On Sun, Jul 26, 2026 at 01:33:11AM -0700, Ted Nyman wrote:
> When a protocol v2 fetch includes packfile URIs, the client downloads
> each advertised pack in a separate http-fetch process. Existing Trace2
> regions cover negotiation, but not the time spent downloading these
> packs or the number of advertised URIs.
> 
> Add a Trace2 region around the packfile URI download loop and record the
> number of URIs. This makes the cost of downloading external packs
> visible without emitting an event for each pack.

Right, by having a region we can verify how long downloading the
packfiles took, and by tracking the number of packfiles we know how many
we fetched. What we don't know is how long fetching each of the
individual packs took, but I think that omission makes sense. After all,
we can reasonably expect all packs to be served by the same infra, and
as such they should usually have similar download speeds.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 29c41132ee..701a23f808 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1886,6 +1886,13 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		}
>  	}
>  
> +	if (packfile_uris.nr) {
> +		trace2_region_enter("fetch-pack", "packfile-uris",
> +				    the_repository);
> +		trace2_data_intmax("fetch-pack", the_repository,
> +				   "packfile-uris/count", packfile_uris.nr);

We don't have a repository available in our context, so we have to use
`the_repository`.

> +	}
> +
>  	for (i = 0; i < packfile_uris.nr; i++) {
>  		int j;
>  		struct child_process cmd = CHILD_PROCESS_INIT;

Sensible. We don't need to track fetching if we don't have any packfiles
at all.

> @@ -1936,6 +1943,11 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  						 repo_get_object_directory(the_repository),
>  						 packname));
>  	}
> +
> +	if (packfile_uris.nr)
> +		trace2_region_leave("fetch-pack", "packfile-uris",
> +				    the_repository);
> +
>  	string_list_clear(&packfile_uris, 0);
>  	strvec_clear(&index_pack_args);
>  

And likewise, we don't have to leave the region, either in that case.

> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 74a2b7730b..537deff7b3 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -1223,7 +1223,7 @@ configure_exclusion () {
>  
>  test_expect_success 'part of packfile response provided as URI' '
>  	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> -	rm -rf "$P" http_child log &&
> +	rm -rf "$P" http_child log trace2 &&
>  
>  	git init "$P" &&
>  	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
> @@ -1238,10 +1238,15 @@ test_expect_success 'part of packfile response provided as URI' '
>  	configure_exclusion "$P" other-blob >h2 &&
>  
>  	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
> +	GIT_TRACE2_EVENT="$(pwd)/trace2" \
>  	git -c protocol.version=2 \
>  		-c fetch.uriprotocols=http,https \
>  		clone "$HTTPD_URL/smart/http_parent" http_child &&
>  
> +	test_grep \"event\":\"region_enter\".*\"label\":\"packfile-uris\" trace2 &&
> +	test_grep \"key\":\"packfile-uris/count\",\"value\":\"2\" trace2 &&
> +	test_grep \"event\":\"region_leave\".*\"label\":\"packfile-uris\" trace2 &&
> +
>  	# Ensure that my-blob and other-blob are in separate packfiles.
>  	for idx in http_child/.git/objects/pack/*.idx
>  	do

It does feel a tiny bit off to piggy-back on an existing test that has
nothing to do with tracing except that it requires the traces to... I
dunno, what does the existing test even do with the written logfile?
Doesn't seem like it's using it at all.

Anyway, having this in a separate test would've been nice, but that
doesn't warrant a reroll in my eyes. So overall, this patch looks good
to me, thanks!

Patrick
