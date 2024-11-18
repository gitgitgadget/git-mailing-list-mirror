Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41C71990DD
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944242; cv=none; b=Ss0PQkqIFBC2ZD7dIDz+eXHSirohxs3+/77iPcOfN6+KJgKiYkPQsNljErwoN311dkvuXz4Q+DPEYK9cPAkySwGcyZ60Ut0u55gaF7Pct84byu+ptTjIar9STQmKQIATkTMw0ji+mLLQxAnxQZ+9W812GUEhgI4A0aWfFhG1tMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944242; c=relaxed/simple;
	bh=Hiv0+b9RYAFv72jpdOg1BdMwDYW10vC0pFm1HYs0/3M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgHOOXK/01x0NEa/c7oTo0zBCvtRk/RPxPmdZQNzkAv7OiiZWUjsoDuSuGspjXJhLQbqcy/ehhcl+a/7mTeMrztN1YgOLjy6ZXsdizU9UirEsZlKPR94Uds7qgU1dTi/oJBzAbnwVMAH9qo9MGrsQcyOFec2NVCQVWxovPM4Wpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLpQj8Bi; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLpQj8Bi"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5146695d946so3097552e0c.1
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 07:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731944239; x=1732549039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4g3kMLFaJYR6A7YBcC0dj6Oe9oJIhX7I/7KnLdYsIA=;
        b=iLpQj8Bi+rhDMqFKDYM/q8OXyGRqxkOQf53EU2x7O7L2FSOnZ+9De5q9mDRbaVopaP
         z88p0D7AT5BNFFmcHexBoB2Hpq/k2B1KwTQ/7+zip56ZtQMJYizYJIJBHCTjAsB63NlG
         Rf/obBMJRHmcKD12imwrHSecUEbrnpc3QLQkO8QeqDYwtHKWjNOD3TvhRWwcWpX+JoAi
         Nc3alXV7wFjVijQnWbtnS8jX02P2nD4AnIzj6nV0MlVCmv60vBvWD6BMLDj153ob9ZeW
         El9JQ/ybXzX6ymvtJZxKTsAN1wNaVZz3+fNHkpVSreTgqt/zAWDgfhLjwHtfPQINAYr+
         6LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731944239; x=1732549039;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4g3kMLFaJYR6A7YBcC0dj6Oe9oJIhX7I/7KnLdYsIA=;
        b=BYzyd2lQE7VwGJ/Ef9UcrFoPPuOvBVy2sp1afFp3ULHMSqlBumKYBtobBSRyLCuStP
         DBei3ticAVazZHby/kmcnQygFCNBbC3i69KCk9CMNBM6o9+PmMRXWaTd3wiPsvj6hPvX
         YmBkC6jyWYEwXMu3ZcDZ1VgGNinHN2L/avXSc8oXF805FJ5oAMWAKlKWG70PmtaxKPn0
         t+YZxwrLKJB8ccFN22jyA/7RC1jd32Lojjm+5hhL7qQsBOw7CaMcAUDlynEtNI3N5+Lk
         FemqG1jDQP6LdK8UPdGaoxJ/FTlplKthBYceFDKhv9qSliVFm4FoTURVi8+BR+C1s1Oi
         pY2Q==
X-Gm-Message-State: AOJu0Yz3ckxiHi8aKlZn+Y34kQKNvu4QMQ8Lvnfa9gqwOWZQryEsDWlB
	VWfWiY3CUCaXjsQ3ilTPYJi5kO6hyAKFGx5vc0lAuU5gWqCNh4C/ps/I/yGVFtN9oXFN5CjGri9
	2IOMJP8zjf24NcqtVfCuAIHJ3DhnV/CiI
X-Google-Smtp-Source: AGHT+IEhuUbkalhwTux9qejF4pQa1cDw5Bied2/H4Z3YLNaobYG1GDAv1zk2LdVJEzpTYkdyIWO18Z9saxZpy5ahKCs=
X-Received: by 2002:a05:6122:1d52:b0:50d:4bd2:bc9b with SMTP id
 71dfb90a1353d-51464ec51f7mr19351739e0c.0.1731944239436; Mon, 18 Nov 2024
 07:37:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Nov 2024 09:37:18 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zzr1ZMmH9p8BF4O6@pks.im>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-2-761f8a2c7775@gmail.com>
 <Zzr1ZMmH9p8BF4O6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 09:37:18 -0600
Message-ID: <CAOLa=ZSevO8HmKCWbZqPJzLs9eA6Lb942BP6h_=1iWjzETeihA@mail.gmail.com>
Subject: Re: [PATCH 2/8] midx-write: add repository field to `write_midx_context`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Content-Type: multipart/mixed; boundary="00000000000029da18062731b1bf"

--00000000000029da18062731b1bf
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Nov 15, 2024 at 02:42:15PM +0100, Karthik Nayak wrote:
>> @@ -651,9 +653,10 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
>>  	struct strbuf buf = STRBUF_INIT;
>>  	char *tmp_file;
>>
>> -	trace2_region_enter("midx", "write_midx_reverse_index", the_repository);
>> +	trace2_region_enter("midx", "write_midx_reverse_index", ctx->repo);
>>
>> -	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
>> +	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex_algop(midx_hash,
>> +								    ctx->repo->hash_algo));
>>
>>  	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
>>  					midx_hash, WRITE_REV);
>
> I think it would be nice to split up the changes that start to pass down
> a repo via the context and those that start to actually call a different
> function like we have here. Otherwise it's hard to spot the callsites
> where one actually has to think about what's happening.
>
> Patrick

Fair enough, I've split it into 3 separate commits for the next
version:

- To pass down `the_repository` to non-static functions
- To use `revs-repo` in `read_refs_snapshot`
- To add repository to `write_midx_context`

This should make it easier for reviewers. Thanks

--00000000000029da18062731b1bf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1e2c9da85ebfd35b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jN1h5MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM01nQy93T0gwNG01NEUreVB2OUNJOU9jQmRZeUx3UAo3SjRGOGZRNTIr
QlZMd3VpY2VJRlBVTkF1TFdIWXBxTU5tcEIwZGpGOFJZQWNBU3FjUVpjZWxZKzFRSDdvL3ZXCndm
YXM3OG9sNXAwb1FvWkk1YlBjYnlWNjRXN2pURVZtSlhIZ1I2QkhCeVZJLzNoeUx2a1RHcGJhTkt3
eG1sSU4KUnlRZEp5cjBpZ1hQOHp5cXhKM3ZOdk5oWEZ4L3ZRTVZNVmpmTExCN00vTkw4anNWNmZM
d2FZMWZOQy9lZE5LLwpWODgzRUlxOWxSeHRtcWt0TlpCSVYrbHk0U1JTOVczM0IyZUxnY1FvcFpC
cDlocnc3SHlMcXVJcWRicFI2L2UvCngzR05XN0NLR0pEWjNuZkVHdFlYYk1nV3RUcnhsTVl0Vk51
Q0lKRnJFNzhRMXNQajRBV1JxRzhxZ3Fqd3AxY2YKMjVYVHdmVXp4WDBQZWlOOFN6YnZjMFJkN2ta
eGdXTnRIOXBiU1UyVEtnNU9SRmsvTVdHTklaQlRLSXU3cW9BVQpnUmlvaWVqSWRHQWhQdlBhRnl5
aEV3Z1VYM1EvSzE4WlI5eTUvMnlEV2U4WDNsc3BXQ2dHWmxObDZOQUNkc2RGCkVkWGxUOXh5bENm
NkRTVmN2UWJ3QzNFOGtkUW1aNWQyaWZoNXhrST0KPVpWRmQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000029da18062731b1bf--
