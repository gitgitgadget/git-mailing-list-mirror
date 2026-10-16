Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7390537B01F
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161046; cv=none; b=k2JAuobCU7sfaUpyylYY0PldBpS50cRj9BAbs9HLVI1mKsp+TOB/B3hHBC6V1p3tj3bMEl2qcFWyF42z9SpdupNOVsLSJb0R2VEFtJTSABk2DWZrFB7MWFwz0WB5l1LppPvUuTlBP9vFVw8MBQHue3SVGXzgBJkYMJdmI9FX+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161046; c=relaxed/simple;
	bh=OLSDSMzhr0opQ4w84jm9o7xVKed6tQ73BfHGClwSUGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=niwm5o0aTpDOPMdYMFS6iLWO1EjMoF/3LG3f31mro+wO+RAxAq9U84WRLnXsEeIGiuRSKBF9K9c1boMgrw19yKdY46qyaLjPIP4AJr+abBpvwfXn7jOrv7GknXjEEmQtaMOQBMY8iwyRxbL/p7dAPh6p6ngYd1QYt+lrGV0ZQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f2NXKn4z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L737wViR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f2NXKn4z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L737wViR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F75CEC01D8
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 10:30:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 16 Oct 2026 10:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792161043; x=1792247443; bh=ZdZWw/Mcq3
	Wgn6K9v+1L4r8IUcFsPJ4P0wKPi3Hdaz4=; b=f2NXKn4zwHqyVVE+QhylDMtk5j
	GwXpmwBvSYtpmKKsxC7YOwqo7Waaz+5EU241qxKjUKSCBe+mpWiO/YZP6LhKq7Cc
	Dt2ILOM2/xH+SH2FNWUb6WLfGjNA6LCeAAbh28wPyfMZnYrqwEQiX3TjlydStkYV
	wD68Drd+PwuM05bhasOwBKSrs5PdHKBoVENnwBdvlOtH3wpLY5hbBsHUpn2dSORa
	7T8iqX68nNBv9Y+locxQHretXSojfKvysjfuN11oONGHm3kBxgu8LgxCg9WVWbMA
	TH5muEAvZf2r2KYXIhteOUZeuXhjKhtZ3V/1dCsO4BPi4bCI6RjwzAJ+03hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792161043; x=1792247443; bh=ZdZWw/Mcq3Wgn6K9v+1L4r8IUcFsPJ4P0wK
	Pi3Hdaz4=; b=L737wViRQDmbY6oM4ILvrSCiZODY4sYSBJQ5OPT8UUCdvrRvJIt
	vvNBWXV0latCjt5z+WGF6IyWn0JCwnILV4nEpJ6YGs7zrMhFoC2Q9wbCtyuzFm95
	raAhI79AoMZXsCzfaLoXiqjntBM5GrRxt/swLV2GQ/gspPcrpEgefuCKlW6pfkbq
	pLxPJYQFwQk9gbo5YVaC5JyrAiWP8r2QQsOeBJInVB6DL4NCVWi0TcVq7V5ntCdy
	6SynzJfLpWXzeyt88O2ja2eGRFlH4uJizcPP0BtPADBKd/43JlqOK7O6gOiOXU9h
	5oA/tdR2OfEppZKzKEeOPrKFx72TNve0IpA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792161043; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CYa+fVy8Bu9wTRKm0HbSGVu7GpxYYRj2TNEaiIfrLN/TbhT
	Hp9HdJoHC5a3zKOYOKyHXaKXhCqmkry+MiEtZxIAJwweusptKUgl3lyOgJljpILt
	BBA2gRLOcXBjulzqejydk9nGos4Y2dt20llWRDhuoA7trudd2Wt/dNv5lAfJHhUX
	hhTNMQRkDDI8NSm1gSCBNbcQs5t1hJLOukG6tU09LJoGUk6m7lcdRJVTfWSMdkul
	J+MB6ANMOtQrkffHnZ3goseHdTeRWM2IX9ztmr0OCgSVShyjC0rhljMIYzjcvF1Q
	APJ46giDyrSLyhBP/srxWb+F975IWLw/BoqjSUg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:FlZuf+oKAQnejrCMn+Tb8x+5GbyMYSgjq+M20OvquJo=:OLSDSMzhr0opQ4w84jm9o7xVKed6tQ73BfHGClwSUGY=;
X-ME-Sender: <xms:EzXSarNBuKwMN3DqFdHekwL8jw0dLDSn88WLpnnlEA96oRihyCIVEA>
    <xme:EzXSas2xq_t0saIlk1wl-s7TW_4eqb2zoawztUeKGkTfMGPCnGt9GfdcZ4hB9DnOx
    _SFQS2JwwlOmq4OZpBzGPLuTDbFHbiZxnVgdAppCK1m5IQ4Sv0lh2Y>
X-ME-Received: <xmr:EzXSail157udo_u87_wAr09ar9v31Jk8WG-xfUWWo0G1FTKD19t4NCLaetptYU554obFyRtYrmbnIQr1L4jxF59siry_FU7DAnbC>
X-ME-Proxy-Cause: dmFkZTF1xHFyD1FcLOQm6TQF0705msCV7xI3HvaaUNK88yaZQ3zGNMIua5d74/BS6nSIqY
    8w69jGeciCZoSfs36VUaZayvRUSDIO96dk1iMkz2e5KGPNyKaRO07NV63743k3L4VVQ2G8
    rcVFHSuVQMXt/7iNMsn3GM8F+O5AsAer4oSUDuBG9BkdRc9w3A7tcnMwDj/6b8JQ19tV2c
    Y1+xpmfCinD0Jg9ppW4r7OMyNeZE1EUrVs8y+Q7PNT4VTFKie5c4AIV5xQltBJCWrTHDw6
    gpyXznaOj0282QmxgxFioUycJmmmgR9V0cJ+gqyVmlCe9sZtpu/tFZDdALIoHiE+r05dH2
    m1Fwcn+fz4CJ+skLdZ2KzNuAZEigUulJD/nfN1AaYlQ2aOms+8EiRKUi1I5Bn1R9+1b75W
    x580dLWsimJ++xSWnPk0v7KEmVCLIfNBMaDqsXiZh6fPS6jDOhPo2Wm3YyRCMVS0z0CAsN
    oK2iR/X6kVhCPkH5HWxDJDRaclqUm9GRygwTyYH8Z1XFL83due7uEoNaMQTGr2Ip2yFprt
    v/dQwKj5eLlQ6tuQKjSKpJv1NMQrejOQwfOihA0FpbY4VdafhLKTDH2figGN3e+RUx/gE0
    81ZLaiXK0Jcpf/UCFSHXmOQpk7Q03s6ZrwwRE7I0QGY2Pv3sDNuYQwBVvTBw
X-ME-Proxy: <xmx:EzXSarXiPAqadRuTe3wij_DBsWYszyxhWOxJLZSG9YdO2lWXuZNeGw>
    <xmx:EzXSagvijDnX6iSvwW_k7bJ_Pc7QBBRDUT5tEVyoL-eFzDuetqMzNQ>
    <xmx:EzXSamZ6MgSmyeOmikRQQfVu_tyy-D7zDzXAmb9IC5CYgh0QyKP0-w>
    <xmx:EzXSanUJt8Op__RgpCs57toAGxT76jV23rBwsEZh1QxH6rvHiyC6-Q>
    <xmx:EzXSapsI6nrYOtpAa5S6pP4xxXvbaj4wL6k2HiFZ-7wPqW8pc0K-8ZsB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 10:30:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/5] http: use `size_t` for byte position in
 fwrite_sha1_file
In-Reply-To: <atHiiye4oi_lF5FP@pks.im> (Patrick Steinhardt's message of "Fri,
	16 Oct 2026 10:38:35 +0200")
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<70a909de18e8cd8d282439fb51a9399baa8c7be8.1791958171.git.gitgitgadget@gmail.com>
	<atHiiye4oi_lF5FP@pks.im>
Date: Fri, 16 Oct 2026 07:30:41 -0700
Message-ID: <xmqq1p9pk99q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 14, 2026 at 06:09:28AM +0000, Johannes Schindelin via GitGitGadget wrote:
>> diff --git a/http.c b/http.c
>> index 4af3c29c76..809471f436 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -2848,7 +2848,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
>>  {
>>  	unsigned char expn[4096];
>>  	size_t size = eltsize * nmemb;
>> -	int posn = 0;
>> +	size_t posn = 0;
>>  	struct http_object_request *freq = data;
>>  	struct active_request_slot *slot = freq->slot;
>
> Right. This is how we access the variable:
>
> 	do {
> 		ssize_t retval = xwrite(freq->localfile,
> 					(char *) ptr + posn, size - posn);
> 		if (retval < 0)
> 			return posn / eltsize;
> 		posn += retval;
> 	} while (posn < size);
>
> So it's clear that it doesn't have to be signed either, as we only ever
> add positive values to it.

I agree that changing the type of posn from int to size_t is the
right move.

But I wondered what happens when (size - posn) is larger than half
the range of the ssize_t type early in the loop.  After all, the
proposed commit log message worries about the case where HTTP
response body exceeds 2GB.

Shouldn't the loop clamp the bytecount passed to xwrite() below
whatever would fit in ssize_t when successful?  It may end up making
two calls of xwrite, writing 1.5GB each, to write out 3GB payload,
but that would be better than attempting to write 3GB, succeed, and
be fooled by ssize_t that is narrower by size_t by at least one bit
that we got a negative return from xwrite() and return an error from
here, when in reality we have written them all?

    ... goes and looks ... 

Ah, nevermind.  The big comment in git-compat-util.h before
MAX_IO_SIZE clarifies all of the above.  In short, xwrite() takes
care of clamping, so its callers including this code do not have to
worry about it.

