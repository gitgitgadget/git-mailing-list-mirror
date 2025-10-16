Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B8C32BF32
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616457; cv=none; b=m8+FBdGlK287oU8j48KS9lHOhSAd/aLSlPfI/8NW0ypk+gfMAAlk8EZteaQ3MvUs+/ZYBB4qf9NWSbC8ORTX8ee0ir7vPHN1wgAyh6VUUJGV7ZuBiCXznduGuhyXTZcDkeu5RuB3jtTGoklro2ejSgFdWwXP1UB570ZhchhXWhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616457; c=relaxed/simple;
	bh=6Mmy85OPedNhrNHfhXJkvu1qwy5JUSwHSpdeoDszPeE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVe1G0Fj0vEELRTs0mO53ayb74LpkeKJqRoqwHOo6hSZtmBVZf3kC5L5yViGweAh4ETM37mioVe3LDM1YywikAuCMyafI1zEsHI3smQ+FvkzRpGWtv8iUOJ6pIS3CCfEa4KWJyThsrMeMrwPfJ5t8TCYveSJAl4necBenmiUvoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeggrTPD; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeggrTPD"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54a79cadd1fso519453e0c.3
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 05:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760616454; x=1761221254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dV2ZUxrAc/gkwDm7sRUpGRU/CvHiDgHcUTN94xjSqao=;
        b=GeggrTPDuIIHjPUt4RP6iW301e6KkuGMltEZ0bEzcBH5qBCFGDjxINdPc6eAsdWdre
         DaqocqdQAdIQ1mAjKKtS7gO9Fk/AjsNqOEz6FaHbcoR9N52KzpSHI9IFVUJXslL1cWgu
         enV80s8rfzik2BOOack6Ri0d0Ct0D2Q7BvmiHiyC2EGBLPal59rhDrpzLPjq/rKBQDL9
         0gmjyomTlIi+eXMJrI2PtiRRzqfZtmC3RzAOiFG7GaFFiVUpir/N7fIiNT3QGFJHKi76
         oXJacebdnSQEWMGRGyPAOvFkl/DUbiQCAhzOLvTL/FE9Qeh9zskesCizdEoXuS0LwmqD
         0pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760616454; x=1761221254;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dV2ZUxrAc/gkwDm7sRUpGRU/CvHiDgHcUTN94xjSqao=;
        b=Ki4uNRsVfh74lLZvfwHsYHoUyNfqAQLxkw7fKN492v6v7PDCPr8EbQdPiXQ2c5QQx/
         68BFXYi3y4XTic+xAbgMYuNBoe0OWICGnShPrvHAHWdFOUDjL3l+dK3aa1fMsofFRYrm
         phW0mPNjgGHDcICwFvt1+1S/S/LYnB56Y1KAMeqxRN5CJV1HlPj1oWAL7qXloPRtbMVC
         OjdbQbHl34wsI15icgh6aDCCNqfJd5q6PcvDlzhZjWAwhr14/OxF6jmOBEv8iwbTklJy
         /xo3PSO3vkxcLhJUiRe3uYow/ky8QLnEUERi8KPEjJwBljVzKrPIE83RPw1IDc0qF1LF
         M+Vw==
X-Gm-Message-State: AOJu0YyDJffGB3/cDVw4+q4YyI4AIs38CX6xK2Mw8pBRPmsXJgNfse9h
	PKHiGk/aStJxPcqKY8guu10cDiYoOjmzwLMgUqqAC3smkHrO5tNg2v7+trvZABX0GxKGgaHcWQl
	KbwnTFev3xiCDeJwMxkYqKjtNWhqw57Q=
X-Gm-Gg: ASbGncu0jS+SL2ALZh4g8eKSIaIwdC31a/7WbrIpZ8SkM1oHOerziU5PmFcsjk9cxQY
	20LN4F5JSM/ugKvgnL5m8SDP35tHG8Z/yYcrEN+2Plbs88kVb06vZ8mSUmvZkUqQ3g6GKzYC6AU
	AyFcR2qF/UqO62Hk7DoijryK4spGaVeM9QicTN4roh3VqJV3illwM0Ta8kml+kqg3Y9qiYTMqPW
	EmWtxE1Y8Nop3FVPloDugt7RfFammCuKEq20VWsDSd4+XkwFjo4hSylvSeRhqESmGP9uUM4Xw6b
	m/9SkQfUyZBdtOu9E1c=
X-Google-Smtp-Source: AGHT+IGKpW+AZPuWtRxQko71xqhW5D9XwzalWl8vvkPYxYDNoynjqtmANrKcmb/f9DZqBrSsr9CXYxf5nhvtGxXuK6k=
X-Received: by 2002:a05:6122:1e16:b0:542:59a2:731a with SMTP id
 71dfb90a1353d-554b8c3112cmr12422231e0c.16.1760616454447; Thu, 16 Oct 2025
 05:07:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Oct 2025 07:07:33 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Oct 2025 07:07:33 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aPDKzqT2YaG2NmEu@pks.im>
References: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
 <20251015-refs-code-cleanup-v1-1-550fdd8a3b41@gmail.com> <zah4lafziwkqty2qw6erkbq3wfilfneom5vm6vcfqk5b644iff@rcebhmsrgmmd>
 <aPDKzqT2YaG2NmEu@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Oct 2025 07:07:33 -0500
X-Gm-Features: AS18NWBpcVcgNAU-i9S26UcrtguJzOzYKNHA0wciFhnk0-nyN1sq3WzHs53uhto
Message-ID: <CAOLa=ZQGQ_Qan9PtE-akUpWwGg8j6y5xcKpyOpztN7bZp+rMvw@mail.gmail.com>
Subject: Re: [PATCH 1/4] refs: move to using the '.optimize' functions
To: Patrick Steinhardt <ps@pks.im>, Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005aa2250641457685"

--0000000000005aa2250641457685
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 15, 2025 at 05:05:46PM -0500, Justin Tobler wrote:
>> On 25/10/15 11:25PM, Karthik Nayak wrote:
>> > diff --git a/refs/debug.c b/refs/debug.c
>> > index 01499b9033..40cd1d9c15 100644
>> > --- a/refs/debug.c
>> > +++ b/refs/debug.c
>> > @@ -116,11 +116,11 @@ static int debug_transaction_abort(struct ref_store *refs,
>> >  	return res;
>> >  }
>> >
>> > -static int debug_pack_refs(struct ref_store *ref_store, struct pack_refs_opts *opts)
>> > +static int debug_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
>> >  {
>> >  	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
>> > -	int res = drefs->refs->be->pack_refs(drefs->refs, opts);
>> > -	trace_printf_key(&trace_refs, "pack_refs: %d\n", res);
>> > +	int res = drefs->refs->be->optimize(drefs->refs, opts);
>> > +	trace_printf_key(&trace_refs, "optimize: %d\n", res);
>> >  	return res;
>> >  }
>> >
>> > @@ -430,7 +430,7 @@ struct ref_storage_be refs_be_debug = {
>> >  	.transaction_finish = debug_transaction_finish,
>> >  	.transaction_abort = debug_transaction_abort,
>> >
>> > -	.pack_refs = debug_pack_refs,
>> > +	.optimize = debug_optimize,
>>
>> question: Was the debug backend not using either of these callbacks?
>> From the commit message, it sounds like all the backends were using the
>> optimize callback.
>
> Doesn't look like it. Overall I kind of doubt the value that this
> backend has. I have never had even a single use case for it, and I have
> been working with references extensively over the last two or three
> years by now.
>
> Maybe we should just drop it eventually?
>
> Patrick

I'd be happy to drop it too as a Git developer. But I can merit in
keeping it. It does wrap around all reference subsystem calls and if
tracing is enabled it would log these reference calls. This can be used
in bug reports.

However, a counter argument would be that these only track the surface
level APIs to each backend, but not really the internal details.

Considering this and also the fact that we need to update the backend
for every change made, I'm for dropping it too.

Karthik

--0000000000005aa2250641457685
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9c791680ae6b8a6b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdzRBUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNDl0Qy9zRWxMViswSUhOZWoyZU0vUFVJYUFvRWhINwpvZVl0M2VzeWNN
TU1ZckNPQmR5QitpZ0ZheitwdlB0YUx4NlJibHVLeWRRY1NkSFRudDA3aHowMmVMZ0lEY1ZnCmhv
cjNGOXpmeXpXVG9JNGNtS2FkaGRlOU1QRzBjUUtiQ1VDUUJXL2wyQXZRZmlGZjBFTks2MFNOZCtT
VEdRWjkKUUtreG1YWU5QaUpOaXZwcDlsNUFtVHdRaVEzbGZIZUw2Z1lQSVpYZTBZUmpLMjVERUxn
VmF2TGJtbUtkNVhtSQpxYVg2M1I2R1JNNlpCaThjQWVxM2FFSnJhWjNldG11SkZQUWprZ2hrb3Jo
eE9jTUg0aTd5bFQ0bjR0bzdWZDBwClRKSi9uQnBFcXljdVViL25mM1VmNHQ4N2hhT0Q3SDRJczFK
dy91eEtFbExkWVY4MW9PeFNIZldlZkQ2UUwyYTUKckpONmt3c1plN1puZWs3bzM0R0xEdkRlUFhi
SXJWUjQydFU0U04vSW1oVzlIRUxFemlUS1N3NmswM0pRMTgxOApwQ0tUcTdOby9uUWFya3V2angz
VWxxdStEOS9INW1WOEpRTzk3RDcyRmh5c1FsS3dQVXFCbVZTYjlZU0dSb0ZMCmU0SDRuYkJQOXJM
eHBHNk40dG03eUczWGRTSThNRHZVRG53cU9ZVT0KPXorZGkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005aa2250641457685--
