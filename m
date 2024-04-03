Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC44C6C
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712125865; cv=none; b=lUJ+EaLL7aUqrkEE/4UNqmSd2Jd8Rp51bec944//gPs3+rf+mpO0pPCYl8WkrlbAwUNr9qpUyfCMdkM3ZmWgCgTtkh7m028jZHOp6gslXH+dU5Iy6IUsKKhasaBBI4yFGwJ3gmG/H8e5DJLihNBAPFSlENLeOsombXCD5a7LZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712125865; c=relaxed/simple;
	bh=b5+puZZ9DNW2DkqYKQ2DNcRQF7Wl1CP35mB0SlrYhSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfYwGNlNSx17DxRugenx+OEE+mQ3v0WQLAUivWRjFDA1UeLoQhDmm4vAsCGrRZWamnFUdI6MUkcnRR1/11hpUU2PyBi7W7RVvqesXkFuSWF3qJ3DE78UytepAEPwcGELjFKx3uAfzLeekuIKjLP6z+KiDaLSZOXC0iq9VzYE0a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bMpWN/nM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wVFKg2oM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bMpWN/nM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wVFKg2oM"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 53BB7114010F;
	Wed,  3 Apr 2024 02:31:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 03 Apr 2024 02:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712125860; x=1712212260; bh=QTwF1Ek1iU
	g2pK/Bj8enHxncd44xcwPYSk6L6vnHUhI=; b=bMpWN/nMkO7GCxOrrCLQ549f/f
	B7SPWc524duCLCuQgZbiVPfLe0Wj/5t71f2qcn+qTWs2JXCZTgicO7vUnboIiS3N
	Oy5itW3/B9JZnIEDitKfQc+A0m7qG3/OZ2vRyeKSnaZMKqftr9Q4xTh4AMOY01qX
	4/akRmbKgDWd/pIFw3NRByLADuledZyXIH8Il5Av/8UOXXV5xaDXdsM1BFdtUvXT
	ZdYfaND0rxtQVmsI2+FkgKxjqup3u1sD9+r4g8E1z59FC28pu5CPtU8Pk03Rm8TE
	oDyrw/plyCAHgAbwrah5kaf1J/6SI8pPoCzJm5adJdaEIn6BlZjUFDuTQO9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712125860; x=1712212260; bh=QTwF1Ek1iUg2pK/Bj8enHxncd44x
	cwPYSk6L6vnHUhI=; b=wVFKg2oMdA9GX5PncZ1PDpa8si+0fyfjMVzr6oWrSLzz
	8MyeLem8sVX8b1M7v+4DNj+6c1b2zpKY/1OVX3lrQUR03PErAm43RM4t8p0t67me
	piWyoJah2KN02DHzYuzwoRPPq6iv+nUV2wY2DhAC7ddxgDbAUcTpD7HVN+Fft5HQ
	EPo07ayeE0iSTnOf4tumXSJ9VIR4/sU+fThnGGmBCR0xnk+OjXdViT4F2vbLHpoq
	lPukaJN2IOWwl1Liw613ms1vU5d0lXc7UnDqBVa+jH/p7VLmMejgQZlg7Rkjfiiy
	+5LQZrVbBZx286nSEtXl6UQglj+YD/uw6tFTs9Oe/Q==
X-ME-Sender: <xms:o_cMZiAqMd0jOlPNljpRThpXwRxuGmwp2aBqwbryGkdu41gSNRGXUA>
    <xme:o_cMZsjLPTfhTTb33BXTyx46U_Hiu4MOHzwigruQ2PaYS9Ol2OYKSneQuHIEzVTA2
    GV_SWuoeuiAxiVo0A>
X-ME-Received: <xmr:o_cMZlnMJU5Iv4S7vePN2dPBGWQl7GeVQk2pCriKLzl-IwAyL9lo5ywdwl1LRFl1yLARO9AFbj_sEfHO5ra8taPYPnpxkajYGf38ukwWY41YUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheegkefhjeehfeekhfev
    leenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:o_cMZgxknxDC9NVIzrX73HF41V8uGlmbZNX453FPP2TQAZa1J0i_CQ>
    <xmx:o_cMZnQlFCfOCu-ckqhAQtCX5n-dpTDoY2Vj8KOO64SflM_WmTpemw>
    <xmx:o_cMZrbGEF09wmjm1NDVaA_yVFOKOybmYcTrjydSxYKiZ7zji7aBnw>
    <xmx:o_cMZgSxESkzl9F2IIrNj-0cv62P5jFJqVyLRv9fr0QtaR0sxxxtnQ>
    <xmx:pPcMZlPcvq5ung3pUt2GkD8Ij9NmP9epgzG4ZO5AS5mmOMsMNlwJt6Ie>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 02:30:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 29a954fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 06:30:47 +0000 (UTC)
Date: Wed, 3 Apr 2024 08:30:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 1/2] http: reset POSTFIELDSIZE when clearing curl handle
Message-ID: <Zgz3nvMLg4ts2rRI@tanuki>
References: <20240402200254.GA874754@coredump.intra.peff.net>
 <20240402200517.GA875182@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jZkVfa2wLZaXEswB"
Content-Disposition: inline
In-Reply-To: <20240402200517.GA875182@coredump.intra.peff.net>


--jZkVfa2wLZaXEswB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 04:05:17PM -0400, Jeff King wrote:
> In get_active_slot(), we return a CURL handle that may have been used
> before (reusing them is good because it lets curl reuse the same
> connection across many requests). We set a few curl options back to
> defaults that may have been modified by previous requests.
>=20
> We reset POSTFIELDS to NULL, but do not reset POSTFIELDSIZE (which
> defaults to "-1"). This usually doesn't matter because most POSTs will
> set both fields together anyway. But there is one exception: when
> handling a large request in remote-curl's post_rpc(), we don't set
> _either_, and instead set a READFUNCTION to stream data into libcurl.
>=20
> This can interact weirdly with a stale POSTFIELDSIZE setting, because
> curl will assume it should read only some set number of bytes from our
> READFUNCTION. However, it has worked in practice because we also
> manually set a "Transfer-Encoding: chunked" header, which libcurl uses
> as a clue to set the POSTFIELDSIZE to -1 itself.
>=20
> So everything works, but we're better off resetting the size manually
> for a few reasons:
>=20
>   - there was a regression in curl 8.7.0 where the chunked header
>     detection didn't kick in, causing any large HTTP requests made by
>     Git to fail. This has since been fixed (but not yet released). In
>     the issue, curl folks recommended setting it explicitly to -1:
>=20
>       https://github.com/curl/curl/issues/13229#issuecomment-2029826058
>=20
>     and it indeed works around the regression. So even though it won't
>     be strictly necessary after the fix there, this will help folks who
>     end up using the affected libcurl versions.
>=20
>   - it's consistent with what a new curl handle would look like. Since
>     get_active_slot() may or may not return a used handle, this reduces
>     the possibility of heisenbugs that only appear with certain request
>     patterns.
>=20
> Note that the recommendation in the curl issue is to actually drop the
> manual Transfer-Encoding header. Modern libcurl will add the header
> itself when streaming from a READFUNCTION. However, that code wasn't
> added until 802aa5ae2 (HTTP: use chunked Transfer-Encoding for HTTP_POST
> if size unknown, 2019-07-22), which is in curl 7.66.0. We claim to
> support back to 7.19.5, so those older versions still need the manual
> header.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/http.c b/http.c
> index e73b136e58..3d80bd6116 100644
> --- a/http.c
> +++ b/http.c
> @@ -1452,6 +1452,7 @@ struct active_request_slot *get_active_slot(void)
>  	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
>  	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
> +	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, -1L);
>  	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
>  	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);

Can't we refactor this code to instead use `curl_easy_reset()`? That
function already resets most of the data we want to reset and would also
end up setting `POSFIELDSIZE =3D -1` via `Curl_init_userdefined()`. So
wouldn't the following be a more sensible fix?

diff --git a/http.c b/http.c
index e73b136e58..e5f5bc23db 100644
--- a/http.c
+++ b/http.c
@@ -1442,20 +1442,14 @@ struct active_request_slot *get_active_slot(void)
 	slot->finished =3D NULL;
 	slot->callback_data =3D NULL;
 	slot->callback_func =3D NULL;
+	curl_easy_reset(slot->curl);
 	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
 	if (curl_save_cookies)
 		curl_easy_setopt(slot->curl, CURLOPT_COOKIEJAR, curl_cookie_file);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
 	curl_easy_setopt(slot->curl, CURLOPT_RESOLVE, host_resolutions);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
-	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NULL);
-	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
-	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
-	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
-	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
=20
 	/*
 	 * Default following to off unless "ALWAYS" is configured; this gives

Patrick

--jZkVfa2wLZaXEswB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYM954ACgkQVbJhu7ck
PpS5Tg/+KqcoSKNBqV4G24rFd6Xv0/MywA8MOZaKWTVbXj3wdK4cV6VdIJd/G/pI
Rptn48lhP1ajv79khnTAqyoirIc4j33YylHOZKpXDGindGEaIX0HMlNdZegzEwhU
RNOFapuJC0C9DZClGfRxVz8uwmZecplRUzz6yW44CSBW8a+bffaSIWlmvaFNIAgn
iBDZqcfYuBCueFCkFPuw1jbIYBJh6igUnKUL7iTRyTNTrCtA5+EwihetfcwDEeFb
tVXsqaCi2+GsLCeVFc72hEY/W1VqTsbX357X2/+3H+j+KFPPZ+J8bIHuNi15mtbk
7wGwOF27p3d6XEsGtZeAQ1h32FAQVLoQM80CtSXiavZprMnYFi/1hGRMdEaA3yX4
oax6pOX8xA+CiRbYf4hT/8oRXGsDGuaLGWArkmJi+qWuxge49afHZR0eMN8P0H9J
LapbsXyoR1KUknRMTTmepDva3oDCAMoDNmE2TJjRpmWG74LT+HVNdam4DGKLlQm4
jnftjf/RlWk3l/niIeYsz5O+YnJiJXQ2e3E5K7bvx/teaafkBZ9H2knENhIY+rDo
B+ZgS1uAnGmUVSOJnZXtDt9021nOevyM2gYq6kM0c8gZCp+fl2fu8DAPlI36We+n
IRfU/clDbkYzM7Lyv0pFOfS1xtBFoseHml3ypzjGJ7mtx38vF9U=
=8UVb
-----END PGP SIGNATURE-----

--jZkVfa2wLZaXEswB--
