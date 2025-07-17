Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BBD1A314E
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780673; cv=none; b=ncAI35HmfrO7tvUOtnki9sp7rJ3A61luL4Def8y6+MBSEi7yisyfos4P3lpk5+5qDPdIyPZx1mM46DnLN3M/fQcgSFKU/f+lh3ClF8KCvqQL2oDuq6dkmwEc3MR4rIIrS0jKFjNOiZWZLJMBR8tUWe6Trel0vTzMw5cxcqlrzaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780673; c=relaxed/simple;
	bh=8RoMJ37oMbmBW0m+zsiOJ/T9ochf+l8RUVKM9H2PNtU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpvzhYvxZiKz/il07wNPpmsURAdsXXh/HvJHSTgTil5rvK6WdeMtF4+0ob5thkfD05k/UsWcThJ6oNYAsBu4GqPxS9DuHvtdVj4NGnihuDSRQPV6gLY53Kn1MWlVWKRf5JuFkPJPYNUF3Wb8DcfYpn3ZN7cdevn9hA94/+fQTB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwqhzqLg; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwqhzqLg"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-87f2a0825e1so365614241.2
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 12:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752780669; x=1753385469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOfTBnF4wEWIpWWYuhMA+LX5n7C15WIu6YhJuMzcAAQ=;
        b=mwqhzqLgvSKyIt7+bjZo9znH7UO2TSq+UdifLJO8l/qvqIb9/Q24UosltqHhQy9vJv
         mV34+lQgW4CyRvHx+3EIcz7midmsmgyyDJK/xw3lRCpFXkaVjwi5SHOUHM8bqScOYWcK
         M43SFNk24sA9n0aVgljzlc8q8hQ0RelmNXo1UTQKmH2m+h7DXDTP4KgIhW2b9qEbA5km
         uTPacs+owHFvZPQB01XM8ariyjMrO7qoljjpooE2+5yVDWN56VX5UK9INi0QXrqWs2tP
         ceVA+ZanhuEOM48BjlLarxCGEnHuVkTqm5RVZmYxnXCy9HA/XdABl/EQSrZsctD4UzXh
         fiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752780669; x=1753385469;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOfTBnF4wEWIpWWYuhMA+LX5n7C15WIu6YhJuMzcAAQ=;
        b=EB8eyc09YTPrrRuC1/90jcCGW2apsOCYn5dajZIi/NUwHazN+0yqMzapoM+eX6zQq8
         FSHNPuJKlVpFWLOR3ZQK7YnwXTs6mALeEPXslcO4qTIERIYqHEe8eLo5442ZK5v8fy48
         K4Q+NPYoPISNTSqXB2Po7UwEkzAAJ+QmWJagfHWaqNH18FKYS1boLzzokDA5+ImiMrKp
         5WXCg/FMfI1V694Se1zCu+OMcqlJOmcEyeUt++1NE88ns0KKhyLLHq7SCdUumQ3nM7RJ
         20v6SusXRlVuMjnlY8k9kLFmf+VVC3EBHugpuwFmWqBcCzI45vrSbgzn3UM41SH2tyoz
         0FjQ==
X-Gm-Message-State: AOJu0YxCVUAzt6iknGwl5e7oEc87ohupHewaOyGfcyE0Oo75c95jKLnA
	olb1qvo1qO+Z0+ApgKVkqQ178nMD9Cpl63xhgSArIWU+eQCVEQ2iBq623vn0rdDrgZkDYuoLL27
	W7gRn/0xLa3S8Q4wT0zDJBItLVJNfvy4=
X-Gm-Gg: ASbGncssvMRST83aOsK7pVTyXIDAqzcnlcAUfbhQgA8Man3vNR1oibF2IYL+4H6KVn0
	ypduj76s+GcazewMJs5vxHuhZcJmiFwK6CAukBvhCODIZcGGmV7VTOAzUkp6T2Wp21qcglL0vyz
	ueNsesgGZMLaZhWS2TzmoUFT5PhVkFBLwImGL8c+APpcpPQUNepP7GvInj1SXmK2XYCluDFjqTx
	K3b3lwBs+rUUi9zp0VSn0HmLCkFknk3oT2mJB5ccB8NSfUPgXnX
X-Google-Smtp-Source: AGHT+IFK5FDAWYy2oGLZm1tVhm3zPkBrlXavZF3i7i5ue0iaT4mHwrFT3yZ5bgv+FfCxEYyWWi1wNLEIqfHdhMhPlFk=
X-Received: by 2002:a05:6102:3306:b0:4e9:add0:2816 with SMTP id
 ada2fe7eead31-4f955a759d3mr4452218137.5.1752780668864; Thu, 17 Jul 2025
 12:31:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Jul 2025 12:31:07 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Jul 2025 12:31:07 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqtt3a7u08.fsf@gitster.g>
References: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-2-852d5a2f56e1@gmail.com> <xmqqtt3a7u08.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 17 Jul 2025 12:31:07 -0700
X-Gm-Features: Ac12FXz9HMPZFRGtUmj0eu71HEE15kPB__KA56qYs5S5uF1MkPZwmuWuZ4nkAXo
Message-ID: <CAOLa=ZRqLgdnUz4Eeof0qdD_RkBYOKOT4oOoXEb0P386KQ0g8w@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] ref-cache: remove unused function 'find_ref_entry()'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000233ebd063a250df3"

--000000000000233ebd063a250df3
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The 'find_ref_entry' function is no longer used, so remove it.
>
> If my spelunking is correct, ba1c052f (ref_store: implement
> `refs_peel_ref()` generically, 2017-09-25) is the commit that
> removed the last caller of it.  Which may be worth noting here.
>

Indeed, I could also verify this by running

$ git log -S find_ref_entry --oneline
2c90b85801 ref-cache: remove unused function 'find_ref_entry()'
ba1c052fa6 ref_store: implement `refs_peel_ref()` generically
9939b33d6a packed-backend: rip out some now-unused code
....

And looking at `ba1c052fa6`. I should've done this before. But thanks
for the digging!

I plan to address a few comments on this version, but I also see that
you've merged it to master. Should I raise followups for noteworthy
changes or a new version?

Karthik

--000000000000233ebd063a250df3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4e547c745a0d38f0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oNVQza1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHhiREFDaG1xNUZhTE1nTWxmUVJnR2ZhSTFFS1FZNwpoM0dQcFNIa1h2
d3IyRzloQzN2K0YvSDQ4Uy9QRDhMUzhZZWNsamI2NXZRVG9MUURHa1U5anhuTTVycW9qUm9WCkFi
Y3poY3NYVkxNc1d6ckN5YlArVHYrWEVTSGpTYVhpZzNLR01pZDk1aVY4WElLeEhKQ2JJblFmSzM5
WC93dFgKOGZ2NWtQdEpzRVk4MTFNeXZ4RlVBUGRiWUg0N3RPdnpQb0dDNzh6WCtyMy90Y2VQcmFx
bUljVU9EVGtmL1pibgpGOFYzVWFvRG5PTldvMk5wK3JVYXh5ZEg1amRoZ1ZhWGc0QTBVSjJkbXh0
WWZpMzlPZUk3Nm9BVDVzcUFISUVCCjRtelBTQUMxbEJWSEZ3OGNOaGhXNFhwUFJmR3djWWxSM1RH
OGM5UWJoN1VhYkM0Y1U3VmVtOHFDU2Y3clNacGwKZXArTWNFcStLYjBvVDlyb3hJRVBPVHkxelNk
RzhhWXFIRWhXUEFIbFdOZEd6d1FLbEtaMXNheVZ2Y3h5emd6bwpWOHRwS0o3dVdMQ241Z0g2QW4w
TmtVTFAxN2FHdTZtc2JBVGg2Y2VOUHA5WFFkazNUNU84ME93VWN3dUZZcThvCnpXakh4NVJBUndv
OXJzRmFFWUFZdGRaTXc5TzhlWkVqYTdWTmVFcz0KPVlMc2QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000233ebd063a250df3--
