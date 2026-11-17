Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928512;
	b=ehktM1/a+mxRvcXOndwOlJ9coYUi/lPVXq7UIBF/ZYzqqv1hVkW8kdkuQLjV1TGjWDQV
	 fXCriLB54bBF7LeozagClCdj6lrkGfG75muUjQrt+l7Kc7niRpSIoXIilCw2IYvOE2rRc
	 fEe+xw/SrPuiBcoRtdMF/N+z855xD+ye7PalTVReJzPuInJvkU4QkNbt/84XCjys7v8Ic
	 HqeezGgVlF+ZficVIqM9n9iIbvr4c3cSunJ/Y6suJ2CTdvCjwV+fS6iO5advD4RcCsi6Z
	 lscy6TUaC09IECEKwaNtkHzKcOgdtMpkHBgwV+tHBso3KsL3bUCgx3AgCkAeWBK2afA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928512;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=lRWbKJ50Su9dCUv6nLS/pkUEPjofTR6zjMoZFFL+1HE=;
	b=F0yxcvPnSD6yexx/H48GqueDqXLu0ZDEIle3quTYNZxISomnuUEFIRKeD2Abp3PYcm3u
	 jlIQNypGb3LXB+4K+1rG+3cjgxA48f+IG9H+3HD6MCpae5CYogzPyPz3yLWgYWua2z5Fx
	 7h5Lgtc8aGFKYuvoH8XTlR2unJrdOAPm4MJnLVvOaVmc5VncRW5A0XSzyk++I+3i5AfTU
	 DbWWUQTwsaAiR8oq0Kcc9YB+AlCpWo3m3YOnmThuK5/TN+aeZg9XANN37UNLzLhry+QGA
	 A0m0dNmL7zJDgG24lTfBi5/iVPMQbaSjcWOjzFw5KAgH8uw6HShW/smGoxmb/Q2RkNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=Srv3gzDz;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB23606A32A
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 15:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AB23606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=Srv3gzDz
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AHFF5ko1826251
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 17 Nov 2026 16:15:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1794928505; bh=lRWbKJ50Su9dCUv6nLS/pkUEPjofTR6zjMoZFFL+1HE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Srv3gzDzs8ioSLFuxNlY+53kCqc8dDLtnLmT6DTgwU4CACTEMLz3VmWt7B3HRdBCN
	 DoUQI/uiQofYLP9vyYuvIvMUhTw17McBXWOennBOaeWeT9rUT8jukZZskFdQ8Qg60L
	 DnTFPecRELnb+LTUbZfZ/96efaJ59B/oVt//IPNI=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] utf8: respect bounds in utf8_strnwidth()
In-Reply-To: <xmqqld6siau9.fsf@gitster.g>
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
	<20261116-master-v1-1-dc2a50ce0aa0@gouders.net>
	<xmqqld6siau9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 17 Nov 2026 16:15:00 +0100
Message-ID: <ghcxs3v6a3.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 16 2026, Junio C Hamano wrote:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> utf8_strnwidth() takes a len argument, but because
>> display_mode_esc_sequence_len() works without an explicit boundary,
>> there are cases when utf8_strnwidth() operates beyond the given len
>> boundary.
>
> The problem is well spotted, but isn't the blame slightly misplaced?
> The preimage with missing context looks like this:
>
>     int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>     {
>             const char *orig = string;
>             size_t width = 0;
>
>             while (string && string < orig + len) {
>                     int glyph_width;
>                     size_t skip;
>
>                     while (skip_ansi &&
>                            (skip = display_mode_esc_sequence_len(string)) != 0)
>                             string += skip;
>
>                     glyph_width = utf8_width(&string, NULL);
>                     if (glyph_width > 0)
>                             width += glyph_width;
>             }
>
> Even if display_mode_esc_sequence_len() were updated to take the
> remaining number of bytes in string (which I think *is* a good
> change, by the way), the loop it is in may cause the entirety of the
> string up to the "len" bytes to be skipped.  Because the original
> lacks a guard before the call to utf8_width(), however, we end up
> calling it even if string points beyond the given region of bytes
> orig[0,len).
>
> If you blame the lack of such a guard before utf8_width() (or after
> the loop that has display_mode_esc_sequence_len()), it would match
> the proposed fix.  But I doubt it is entirely fair to blame the lack
> of an explicit boundary in display_mode_esc_sequence_len() for the
> breakage you are addressing.

Yes, I'm not sure if that term is correct but the main problem seems to
be a "contract mismatch": a function that accepts a boundary argument
calls one function display_mode_esc_sequence_len() that doesn't have an
explicit boundary and for a second one utf8_width() it doesn't use the
optional boundary argument.

>> Fix this by adding a boundary-check after looping with
>> display_mode_esc_sequence_len() to ensure we operate strictly within
>> the given len.
>
> If the incoming "string" is at the end of an mmapped region (beyond
> the end of which nothing is mapped), reading string[len] would give
> you SIGBUS, so display_mode_esc_sequence_len() would already have
> taken you into trouble.  In other words, even though such a check
> before utf8_width() is better than nothing, in a sense it is too
> late, no?

Correct.

I am currently preparing a v2 that adresses all the above.
I will try to give that v2 sufficient time to hopefully reduce errors in
my workflow and not steal other people's time.

Regards,

Dirk

>> diff --git a/utf8.c b/utf8.c
>> index 96460cc414..7e050bb2c4 100644
>> --- a/utf8.c
>> +++ b/utf8.c
>> @@ -217,9 +217,13 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>>  		int glyph_width;
>>  		size_t skip;
>>  
>> -		while (skip_ansi &&
>> -		       (skip = display_mode_esc_sequence_len(string)) != 0)
>> -			string += skip;
>> +		if (skip_ansi) {
>> +			while ((skip = display_mode_esc_sequence_len(string)) != 0)
>> +				string += skip;
>> +
>> +			if (string >= orig + len)
>> +				break;
>> +		}
>>  
>>  		glyph_width = utf8_width(&string, NULL);
>>  		if (glyph_width > 0)
