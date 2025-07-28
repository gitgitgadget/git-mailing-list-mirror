Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4186338
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753733895; cv=none; b=eX21GnNu2LiKvdwf69y9h9+Gt2ECl5cIFOCKQ0TWq9cYU7T68Cs0R6TS4lt2Fx0wgDof0D+kwpJYEzWCjP7FXiDa48KYSVEEStE1XwpEu74V+0241Mp/CeXLbJgd6+DGsToCwDg6mGi+BkgyHj1iH2FCp7UYZmwwM1yDVNcTCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753733895; c=relaxed/simple;
	bh=R/DUoSj5o175ZjQKBPL7KWIbV/3irKWFSLo8qC5boiY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZR0rL0ApCL9Il0xQs4YaljFLZQ9jae/bXF04f2ekg9O88CKAk0MBfjfgzmUavCFKMKVi8715iOf2Qx4Mw/Jv55wVO+W+N+Do9WmigzsRE9as5IXcCAw56sA1+IqWgp1FaLfpe4QeIKX9VNh9svC625xODn90Bpgf6mNr3xxFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHbvCJL+; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHbvCJL+"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-88bbfe763ecso58636241.3
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753733892; x=1754338692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmnBEk9ymRDkE7Got2+byRQEvVqF2K8eyyIEKzxoks8=;
        b=PHbvCJL+vWFNDj41I5KNHP4UCXvZKr7kVlSo7mPOvkYd7ovju50rLYDWq5eKjwKW/R
         MChb8TxB0blRl79x62FonFimH09A/6ZpjR6ZL1nKTY2ecveShz+eMJZoNt8T4kx4qv9E
         zYMcTqsK4rR2I2MMAwDkQ5t6pZOotPc38G4S76zTBMNUrVLxsJoiPypoYfklE/fAtIxP
         B1Z8fkmUmz4/25XR9Vqu3Jl8V8qLX9nVL+SZxojPMyyAupEd2CutXBPG8ZYyZLnM24lk
         hPqgly+wW/IN+/AAHovyfrq93w+1RVPkrs5iZshQEnAGujo8Tzap6hAvyH+UuCemZVcs
         hzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753733892; x=1754338692;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmnBEk9ymRDkE7Got2+byRQEvVqF2K8eyyIEKzxoks8=;
        b=p+u6cMpzRUH53uXNLf9WnUbWOHH77Kg209GNUwitBbBADHQdMvF8Br9k/mBCkd22EK
         feusjDWK30v5fB9F+lnP4P+Rg6mg5zgNa9e1zxRWFyZRs+YEYYBOOfqqgck2/nsXfn2R
         CPYEMkepLjx+otdeeNU+AZFLpo4KnGn+dxaxdxSbKQZrqUBbKHQXBVmK27ILdfyHfqog
         xBKPYebWhTb5JI300HSGkzrvAb01pqTz0Q3P2LFx+5pKMwKxXn9mTuFdEEDiHLWa+aTX
         HR+35rQGWsSQ8HBZhNaaEPUeEc1M5BPSSGqzWPlajhUoGvZfN7sbNrkF+ISOnArX/uXr
         JfCw==
X-Gm-Message-State: AOJu0Yw+3w2F0QiWMuMv32hF+ROxhqpuCjB6myaoeAjNNir1YlpEuiJ2
	sTlEHOsmxyp62WR3bStT3e2Gu3q/1Q6qlvQq7fODOE09TG3szdVZ8vut2+hvayeY7fOR4VUC2Of
	kwMS3BcHJLiR74k6C4FR4SxSupGYwMj8b21ul
X-Gm-Gg: ASbGncsbE1SHMUZ/uoN/zyD87t+gkvyYzY51bOwzFv2tffBJz87MQg2itW62t2AfTge
	c+HWEroknzhsREmxCHMiM0t+XX4MdeR5r0xj99k3Uu58vCUPGekw0i/WtmLiE6JF+2RNwof8CAZ
	i6BCHJc6ElpylOYFVgiyTD2zHJ3ATITAm1WE9f2DbGJMUF5+hqUsr5TwwCw5yfVSx/q3XfPLkEx
	zUYNsSkKQv5dAO6TlxP58EokTYF7eJqUTYIylNU6w==
X-Google-Smtp-Source: AGHT+IE3jri09vY4dw3RZ8ia//eAvCAGUyLZalGv2TzVwQUjI6aNu/oOzp8j8Azm7O+iT6aMM2iG842sWTHjxPU8ry0=
X-Received: by 2002:a05:6102:4485:b0:4e6:e126:6238 with SMTP id
 ada2fe7eead31-4fa3fb0c7eemr5188974137.3.1753733892484; Mon, 28 Jul 2025
 13:18:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Jul 2025 16:18:10 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Jul 2025 16:18:10 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aINitJW7Mbxswy4b@pks.im>
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
 <20250724-kn-small-cleanups-v1-2-0c70f591de3e@gmail.com> <aINitJW7Mbxswy4b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Jul 2025 16:18:10 -0400
X-Gm-Features: Ac12FXyI7KgBFsC27SMjN8r6cp6ND9-ndEb6ygxmvTlaIohk_r_Lg85vPlvaP4E
Message-ID: <CAOLa=ZRB6VJU4Km8jotcEsGMbQeb1Vq+waZriHS9c2RVxiqJhA@mail.gmail.com>
Subject: Re: [PATCH 2/5] for-each-ref: fix documentation argument ordering
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b14f4f063b02fdd3"

--000000000000b14f4f063b02fdd3
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jul 24, 2025 at 10:14:43AM +0200, Karthik Nayak wrote:
>> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
>> index ae61ba642a..a170de4209 100644
>> --- a/Documentation/git-for-each-ref.adoc
>> +++ b/Documentation/git-for-each-ref.adoc
>> @@ -10,11 +10,11 @@ SYNOPSIS
>>  [verse]
>>  'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
>>  		   [(--sort=<key>)...] [--format=<format>]
>> -		   [--include-root-refs] [ --stdin | <pattern>... ]
>> -		   [--points-at=<object>]
>> +		   [--include-root-refs] [--points-at=<object>]
>>  		   [--merged[=<object>]] [--no-merged[=<object>]]
>>  		   [--contains[=<object>]] [--no-contains[=<object>]]
>> -		   [--exclude=<pattern> ...] [--start-after=<marker>]
>> +		   [(--exclude=<pattern>)...] [--start-after=<marker>]
>> +           [ --stdin | <pattern>... ]
>
> While at it we could also convert this to use `[synopsis]`.
>
> Patrick

That's a good point, Let me do that.

--000000000000b14f4f063b02fdd3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bfd4c0ff5c1a3af5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pSDJ3QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzVpREFDREwrQWUrM1FreTllT095L09jajNCOFNuMgpOOWh5S3VQY0xT
ZHkvTVExNStoYWFRZXNKMnROeGtGaGhmVDhuRGk5Vm1EbVVGREpjUnhpYXo0T3MyV1dSL1BNCmVY
RFhoYnJydzNlWVcvT0NVR0ZXSzFSS2tuV2ozOFQzV3lOWE5UV1dRZlRXdldvR1ZEM0d6WmRNamkz
QTU1Vm8KMEtyd05uWmhlT2c0Mk92d1kweURmS3B5TEEvcnVYaUZzTkhBK2p5dDRKd3NwWmk1Y285
aFlHbHhqWjFYc1pZegovaytOSXorNi83MjB5N2NUVytJVXE0S1F6N0FNQ3REbGVvQUtpajk4OHc0
d2U4TVYwT3ZOMytQdE9DT2RBUHgvCndtbWNubUx2VG5GNWpjajJla2R6OGVHQ2hSdjA4ZzBIL2d1
Tloxc0NveFlHSEZVUTQ4b2ZJMjhqRXZBbE1FZzMKSUlZMUNCZVN1TU5HT0dnQjlpb3FjUmtPclkx
WHBxVTlPSk5ET3F6SjBUT1BjdGRiZFhoN0JUQkxpcVBBTzhwdQpBZ2FOQ1dvTDJJeWlocTFxcHRC
S3E5eFRObExzWSt5RUF2b1pYWUs5MUxCMHo0bHJqN0hWem9JVmZDWGZsTnlXCktEbHNrcG1KRlJr
alFuZTBFS0p1R3VSd0hYK3BsQ28vS3Y4dzdtaz0KPUp2MWUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b14f4f063b02fdd3--
