Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE95938656C
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323454; cv=none; b=hpt01ThcgaiNnt3GeEAVWVazOuQWR4hH2pCcQ0HzOQGdyU4+sBHtM4cUHkappMYtfqKzHmlshmdo1KFtTVYO//biP7YiXmw3ob/Ume77PY55h6Me4idozTSc5+9msxNQEXVDkGtMEguIQeFWQhULMush7tW4CvJ8loQoOhT/7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323454; c=relaxed/simple;
	bh=2YwDWKqqmMvqlhhpNv2b9qa55gLIvLbhj5bvv0je85k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OcMq1BKBv9VQAVHDsLuUBM/GoBWKzm3dSzyKSSc/11VxRlY/084TjcyYg8ZdtkwZO7vJunxU0HAVQY9Zc5FxZ8Rn3PLseBmp3dnOoA+mPapow77pj6BDmswu25OwhQSAFKS9uDIzYXWorJuIWUexeWu3Uu4NrZKLIZdBbmylTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oXEtGWek; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j3oXfVS3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oXEtGWek";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j3oXfVS3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0CB057A0048
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 17:50:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 06 Oct 2026 17:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791323450; x=1791409850; bh=oxeNxzNE89
	nLWmSZmwm+0VDwMByi4e8L8V5qakoPqRk=; b=oXEtGWekpcVOTxvy3k/uOXKCfH
	sbW+uz3CGLRUQUQ/r02Vc/GsUYNO7s7EWDIx1e5FpVU0JQDYz60vgoZBRr9jF96t
	XFlUvcDfQCCSrfRfAmDKHVrsmeknbxWCj3G4PHWw24TzyVEmx12Wp21ZWaZeNEMs
	IzdqV4GjgBKkyNb2QYGb0FQKIgYLITMbXghV+AEUqzQ+IGAt6QF2mxz2vXgB8JLZ
	Ihz/LPiANhElnqF0KYHxFyp9I8eNo4aPn4akIimSZ2Ei/1tB7vYrM/A6kj2xdsdt
	8YhmGaPjVZiV5N1gkEsdKqV6OCSTwdJ6TSiztv2DblfQ65Imp9TQp2bXeDKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791323450; x=1791409850; bh=oxeNxzNE89nLWmSZmwm+0VDwMByi4e8L8V5
	qakoPqRk=; b=j3oXfVS3hs9AtyW5rpGQabWP51u4PrPp6ILUn7EbqsW6QZMNelp
	NS+UIf7VN1D3mvwvCv54S/wvwqxqxtUEZfJr8vvOVe7nG9LShJznVcubuebD4rY6
	0CZOmMaYMl0K/PXawVJQTRCsNwQZTY2KLqbmLvzGh2TWSeiRJTKV4IQk9D4rtTOp
	k07as5uv97gxGhYRgYTWgFwHOpwqRnzwddkRxQ0SG/DZ77kSBmkfQpc5cCOEldP2
	0EHWCtJp3v34cp6X9WH5bBgro/4WISM1zSETHIxoSs4ha2aDqz5PLwZXV0ygNC0A
	yAM2Y+r7II0mIsYlsb4/BLCF8PlW1ROS3nw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791323450; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:FGz4UGBtsNE4KST/KbLLXvJ2ZGg4cqB82U2NElnZuQdCAjL
	Ef0QbZ1bvEUQouROvGYpa40GgQINinny/oObehTSqLvYMWHCE8cL8U9+BQWmEnGl
	jm4W1EGLjJNnMDg9SwkY/6ZQYhIuJlI/q2bQW2x6xBkOJYwVSbb66rhkMC5d0let
	tgUhhGeU3iQyuNz0sZ4ayxsZpnAwf0DPfMC2zFEGbphGwEKsRbPmRpnOJSQIus9O
	NYPn0CWWwEaqDudVtsLAdmOodnQmFnbsYI/KTsQ9RR8+ZC/ggAj3kD275WVQl4xe
	LxZUpEbTsr4sIcqGjK9XwKHaDngn7EPwM3qfOjA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ffYp2mCb9hPH0IZL7HJ5t3WbHWllIJAjwfrwJfmyfuQ=:2YwDWKqqmMvqlhhpNv2b9qa55gLIvLbhj5bvv0je85k=;
X-ME-Sender: <xms:Om3FalDpUriQfeKYAGa8nuA1L8J17oi7NiM__Y05dz0-0QOdNa2-FQ>
    <xme:Om3Faqj32dEA6iXDR4ur9UvSGKn_fKiG5XAqFjjTDw4d26B5Dhb-mX_22vh4lX26F
    6Pn_GfpVcTMKsPCLPSqBhF57Odbwbj95XUQzGldXb6_0KEtz0Gsow>
X-ME-Received: <xmr:Om3FallwGZtZEV5--_obuoJJSq8leU3OLzkamsG9u7P_ubn5pOldXuOsMkPPL3LPtDvboGpX1EtEhmhr78hl8sKVl8ioM22KoAQs>
X-ME-Proxy-Cause: dmFkZTG0ZB8OFz0vxjjlpRnKN3pOJOxhNMGdmKruFeZRhERNACRDNv3tLGTjJF33ZG50Uk
    XEREebX7Y+eO/6fsrrqMM9PfSJhXfPJj/hf01jIo+a9DsTMEb2LIYu0wsEvEOxiI07FLKO
    QslzyvzcizBBsed4he7wzea/otuBS5gakr0VeVvCMyo4Odek0ISrQ0/x0jwUnUIyTNSI4v
    sgyTGQPLjde3EL+ba/GtAJhwBymW9jJLJrCxvKlxALndV4BE2+UvPEWuwoI1ZYMnEb28RP
    /oBeE+QpTeL1+uWS3+qWpT9K1aTYLE3czjbKv7PVLMKUGRfRvcs81dOlil/2Hoj7ukXbaE
    VijMq6VKyjwNn2U30Z2RfXfB01kLNUF5xMRfTmkHDIWvtn4aOizXGUPFbU54GbVzq+7Zp9
    qu05qHyYf4BUs4tKzgn7vqiZIZmfISudhUS509Jj7ggFVqollYSsPwiCWJ5N29ldbX2kn7
    zcceSsiKVljTP6SKYsdsTApCHtHdKLDeatvHM+odY12LgdA72Pwap7WmeDWQPrWTGZl1qQ
    Ich8QDjtJ84PxSjeGJZ3lla/t9oqqMJ0MRYnp9PNqnkGFk/BfsY1440cPLtni2SoI1W6cI
    W0y3QMh/chbm35N/8nJ8ketaJWhtr+awwkBWFA1GG4dG6suAtuu0R7jw55NA
X-ME-Proxy: <xmx:Om3FaurZ8H0wczxdWAYzvQleXI46U0po6zdym2ngAAdS7YmQvQU6Sw>
    <xmx:Om3FamE6ToBvzV7zbNpBHe39r96IQ16GzKewPBT2umRChy7osFnteQ>
    <xmx:Om3FaixPxCc3mNYnsR7uEd92Za5J-_6HsaCQ5SuN0JzFD0j_-k-P5w>
    <xmx:Om3FajpRMvrpLlLESyWGZIlQhRhj1XDmr5AxySPQmyxO-_7RwH38qw>
    <xmx:Om3Fagm9GTegZ5Eq3soQH6D62XnnRKmNj8dGk8kT_bSXmw6znI4fOcIA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 17:50:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Mae Eckert <mae.eckert@albellus.de>
Subject: Re: [PATCH] doc: fix shattered.io link
In-Reply-To: <89f21a129df21b115d5faded2a74a8a5921d62cf.1791307032.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Tue, 6 Oct 2026 13:17:19 -0400")
References: <164ef290-463c-4a7a-92d4-00a56aab71be@albellus.de>
	<89f21a129df21b115d5faded2a74a8a5921d62cf.1791307032.git.ben.knoble@gmail.com>
Date: Tue, 06 Oct 2026 14:50:48 -0700
Message-ID: <xmqq4ieycxc7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Since we published this document the domain has been taken over and no
> longer reflects the original content. Link to the last good Web Archive
> snapshot so folks can still retrieve the SHAttered information.
>
> Suggested-by: Mae Eckert <mae.eckert@albellus.de>
> Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
> ---
>  Documentation/technical/hash-function-transition.adoc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/hash-function-transition.adoc b/Documentation/technical/hash-function-transition.adoc
> index 241d2f763d..f6b38ddd50 100644
> --- a/Documentation/technical/hash-function-transition.adoc
> +++ b/Documentation/technical/hash-function-transition.adoc
> @@ -29,7 +29,8 @@ advantages:
>  
>  Over time some flaws in SHA-1 have been discovered by security
>  researchers. On 23 February 2017 the SHAttered attack
> -(https://shattered.io) demonstrated a practical SHA-1 hash collision.
> +(https://web.archive.org/web/20260207211148/https://shattered.io/)
> +demonstrated a practical SHA-1 hash collision.

Thanks.  Will queue.

>  
>  Git v2.13.0 and later subsequently moved to a hardened SHA-1
>  implementation by default, which isn't vulnerable to the SHAttered
