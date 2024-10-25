Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205A1D31B6
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849936; cv=none; b=b2UtL/5vObxtpzaNlLhLdHi1MI55hUFMYtTliXM418TVFFBIh+0Q6MSUtMpsu+UN428hYmcXPSCWi3fH7ik/umiG/L7c/6L1wI9bBvnFWurvkn+EIADN9+ZKcgNG7TCxSc7jCQgZSFzI7PaOw5fGQDe/Bjex2utXTJdCzCuzJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849936; c=relaxed/simple;
	bh=5tELQeYufkzmpUyWptdUuTUcTwdIxQgbYfCjSVTVbRU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQWfOl9xjPMQGY5pfOrjG9sRdl04W+1rlEfHpBhL5JgbSfg5y1NU5NEHKLWNpuiyCRPXI4A9porI1tJIHLNAEmQ1jTZ7i8Ib0VOUsywgkZtHjxFmaCxIRA+sQ5S2w/i80Z/LshEYTIWYZ2vK9cMxTGHGJiwbMzXMSMqYfMepCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgE/aYxH; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgE/aYxH"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50d4a6ef70aso599532e0c.3
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729849933; x=1730454733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+QDn/zjZqGkwpLTQBIFDGcLIoUtQtsJ2P1Zbxqdapw=;
        b=TgE/aYxHbsQHNe/FbqRgnAN/HOQQBmiOblE4rOdumCUsChAcbTX0OCxWSszJh0Rtqy
         BWKIXb36T1W3vuznPxvpBuoXywHM7t5zx6xSkV3Y40oEWwymlpYJ3xGsCz1wEgPrheIJ
         87I8+DqAB5dAS/KhDrzprYu/U1MhRTjh0AqkGwNFZ9pMUtsaPLT1Y0I4nr1fhenn0t6a
         GAelFFXGeJ2JOfMQLxCCOGAvbKjcj3xwQGYuMUqHEsuHb4JdBOPhko2C7UKUlmPMXhqU
         PXPKrhl8rMZfMTBWe1CMRHgjkH/V3m/9N3IUqpZv/d9knjabFvkRJ8Cx0dq+QgOjuPMY
         GtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729849933; x=1730454733;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+QDn/zjZqGkwpLTQBIFDGcLIoUtQtsJ2P1Zbxqdapw=;
        b=Wep786NtRsY2AX6E0SxWUAWoU+7k3C31MKKSI8WKE0ydvYYdYbfhRSNvCCoMJZak9O
         pOBoxUJEmHuUVdSGCg4YG6EZrQ3VDY0RpV2gYOG5dgOhEInxtOAQac4UxgUWZVrj6LNQ
         EZZ8BMOUGhJFOqIEz08yjAkWX/Jnr64/YQC80JpAbz7cLWphx6RcPlaXf6N/t1SLH6jm
         kzqE38i4CYqDKyHqNwloJvLgEJTf1JO4Z19Rhnxa6cgLxcBSk4X5mF+99ZclQ7YNPub1
         oMiSTP2jsC+w0u8hyUfu0UTClX/zi4btrvmV2PVlZEwTUs/qMZqGg/L+ZXr03s1OvHAG
         zxBw==
X-Forwarded-Encrypted: i=1; AJvYcCV47wXgxpGE959F9z5AQAYhKJ96S5A4EEWZmCsVcL+L6riYWQy4Ss5HvRe1UdIPbD4CZ+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGp+iVLgzceQ+rvvAFG07FMx6XYwcZlui0X8OJ55ayQq84qYv1
	SegxxcPM6mABKM+WrUCZ9XoR0z2F8pqKbtfxwg4beh8LUA4WWikT0qnc27lSwHbILNcvwYd8FPh
	7sb1i20x0mdSwCgogw1oRdzZckVZu1xId
X-Google-Smtp-Source: AGHT+IF0z5wECqRuA7ump2rK5InZJryyNcovvGLlci5h/e6i6cAuqgzyS4DIPkeGB6pPBWHiOVXM+yRv/ZwF07V+TmE=
X-Received: by 2002:a05:6122:a0c:b0:508:4997:18c6 with SMTP id
 71dfb90a1353d-50fcfc43c7emr11226014e0c.0.1729849933341; Fri, 25 Oct 2024
 02:52:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Oct 2024 05:52:12 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241024205359.16376-2-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com> <20241024205359.16376-2-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Oct 2024 05:52:12 -0400
Message-ID: <CAOLa=ZSb6p_z8jJHSWCfqD6bdTNNXQw-Dq6DsQWt+o+cyQ3x9Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] fetch-pack: refactor packet writing
To: Eric Ju <eric.peijian@gmail.com>, git@vger.kernel.org
Cc: calvinwan@google.com, jonathantanmy@google.com, chriscool@tuxfamily.org, 
	toon@iotcl.com, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000cad23606254a12a0"

--000000000000cad23606254a12a0
Content-Type: text/plain; charset="UTF-8"

Eric Ju <eric.peijian@gmail.com> writes:

[snip]

> +
> +void send_object_info_request(int fd_out, struct object_info_args *args)
> +{
> +	struct strbuf req_buf = STRBUF_INIT;
> +
> +	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
> +
> +	if (unsorted_string_list_has_string(args->object_info_options, "size"))
> +		packet_buf_write(&req_buf, "size");
> +
> +	if (args->oids) {
> +		for (size_t i = 0; i < args->oids->nr; i++)
> +			packet_buf_write(&req_buf, "oid %s", oid_to_hex(&args->oids->oid[i]));
> +	}
> +
> +	packet_buf_flush(&req_buf);
> +	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> +		die_errno(_("unable to write request to remote"));
> +
> +	strbuf_release(&req_buf);
> +}
> +

Was this function meant to be added here? I mean, there is no reference
to it in the commit message or anywhere else.

[snip]

--000000000000cad23606254a12a0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 805ada53deb690b2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jYmFrb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK3lqQy80czVkUnVCb0lVSm05SEhpTVp3TzFLTWJ4UQowa2I1UWpPNDhC
eHA0OHIyaWJtN09SN21CTzF1U0ZGQWV2REgxUnJQZjV3Q0JqT3g3UHVnTGx4c0JjeGdrZnlvCjhs
QzVOUUltS2hSaC9XdVFFQ2JIS3hTU0RmMHZtbW01UE5mMEY1U1RTM2pPbXFNRVhlOVlVMTRzakF3
cTNIS04KTzZWMGlPK0tJODhqc1NJYUhEZkJxQ1VRcU9PeHpha243by9pNGZjWG9vRHluOE8xOS9x
bVdVajVYVytvL2ttWAorM1ZyWitVdFJvVFNnMkNGTzVGTXpYcUhjNjNOS1dtZk1IWmNiNktseldE
dkszUmdXTlJZRXZNaUR3ZHRnaHdZClpYUXJlZXYvSFpnUGVQa1VrN2k1dUYvcFl5OThZM3dEU0hj
TUxzbVkrSVZlSkIycDAwaFhIWC9lOEs5OElTRjcKZXZ1aWFQYk80cGV0Z3NKZjhSN2F3bjdLcFU3
eWxzc1pYdGtYZUtXQS9SemVFa3lVbzRBVWhac3ZpUWgwSVJ1egp2ZWdncjhDNEVDVjFZUUpZQWlZ
YTJyZExUUi8vSXBPVFJEWEpMNkdHcEZuMDZkTllxWlFLUUFYYTFJU25DMnphCkhOWG9vMTlPbnpR
d1N3eVlKV2l1ZXBrSUhiM1BTU0R6UVVHTWZPMD0KPVpyd2MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cad23606254a12a0--
