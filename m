Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CEC2AD00
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203699; cv=none; b=fx8WWVpdbxfRflDckdcwYhQmKPv3rcsLxZLGoucl91fgsPnbtOBgqU+bBzqth3L7056yygI8AkMzdbG2H0JOUG9yJ7tcAeFRp3qsHkhsG1Mh725h0drB+cqmkEB9EzLFYikKlJ+3QPU88bHz47L6MK8AZSKiIlFB8KIvL581f0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203699; c=relaxed/simple;
	bh=zcNDZyB4ytesReVjg4TWHl6I+e7TDt/zUL99uwdGjCY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEldt0GtU7Lqv2G66OiPI7rJe/xkR8zjJYUp+TCgJSYM7VuQcRhb9zwPKXRGnqKeVzV0VsZbI4HC9zaEFpWKe0TSOdeZmCREnceRhnZk3avHK3YKwkL5e92KCR5xpozxZI7eT3wWyCEbptuN7YU6TSnXjwxAHfPMhTPwuMb62OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du8rNvPc; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du8rNvPc"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e60966297fso541621b6e.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 07:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732203697; x=1732808497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zcNDZyB4ytesReVjg4TWHl6I+e7TDt/zUL99uwdGjCY=;
        b=Du8rNvPcoxdqB4Pq8IzWVXU+kaD9XjCzlRO579Q50TX5JmtfZpktvoHBMjzg4aEfK2
         r27es5yAsm65uK2oVSB1gIE7MgGDtZJEtmA3ucAKboU+/lNtN90KdxKFA1Ke6GngGq6N
         aNY70GJAQkrCdvbzx+IJ4pZEp2tp4qinYRHoq9jMWbbUoYcVPTj7BieLFRAIuUJEA8qf
         q93VRmEhFVGsvDJ+6jpJCh9jV5kagFDPN1T/CxywjdNiOlvSZdcMH1vio4bOXYwUkZnN
         n3GwLjsScX/tG5rArEIjeUO5Qy0BTtsyN6J1XhcEAI3P9s4mWtbMmBdmggxXFA+0hO8Y
         Zjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203697; x=1732808497;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcNDZyB4ytesReVjg4TWHl6I+e7TDt/zUL99uwdGjCY=;
        b=gGVAT000qG423A6iEeVXdMnGKzUVVJlkGqQCOE7+Z6axhOwt1d+u778VKV6dxa0BZ5
         0OuSNDzPJl8NcPA4/OmejETkr/BBJ49roN6ECGUCTHNRDpuJ1rdhDwh5WVA+vlnYlTJ6
         dHBvVtKiFCoX8H1YMDbylONMpnLqgQ2t6xSH/a3u1GW9t6vAGx1EJQonxUrY+p2MvMqw
         /YWW7yaBKVEEO4CgFy+kXH4XqUgH2Gl1XrpujZSedaYOyPXpPuzCZ2dO0H7RBPWmVR5c
         gbdgyCHCEOXxIGvhhGztkJUHoc80OWUcIy1Ox1HJmJ7mgatZ487XUJvLrN/MjgKjdvR+
         0VxQ==
X-Gm-Message-State: AOJu0Yzkkd+0l3AyQBHBfPhUoMqdbzMx1I+eq/GEYfMua/Pi0S1BvixX
	31dJfUXGlGDkxosawFmeyAurgHTe8mET5PInYJuwlUF+hzcrtELCcD4n5wh9CctfRk+lbU655fq
	AxhSB/hcEbLcJ2wQ4641n0Luuan0=
X-Gm-Gg: ASbGncshq77p87GqQXGdSbsfzA95xQJbAtPvshFDRHFWJ1JDbTLJOos6WF3nV3JqMOx
	QycNuCYqp3Z75ZOIGpjJ6uq5I/XxKEAC5GsyIbIBapKGSqzwlHImqs86s3GLwpyu0Fg==
X-Google-Smtp-Source: AGHT+IHflsrjpKKMB93bYLa3J+Q97MjX+j2sTYr/cbb+ZwtJzkvOPxxKgNG0QfyO6uD8QU4dGj2/8agOIa5xGJHR20E=
X-Received: by 2002:a05:6808:bc5:b0:3e7:5b06:ff61 with SMTP id
 5614622812f47-3e7eb720b1bmr7647553b6e.21.1732203696824; Thu, 21 Nov 2024
 07:41:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Nov 2024 10:41:35 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zz5hYfHLL1vsxdY5@nand.local>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-9-e2f607174efc@gmail.com>
 <CAP8UFD02a+ZfHo1L5qhbzD2r4bmhXadSj4sy0acPncnj4pcRpg@mail.gmail.com> <Zz5hYfHLL1vsxdY5@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Nov 2024 10:41:35 -0500
Message-ID: <CAOLa=ZRr0LYSnC47K-ifZ-v+pCWx7msBpQc+65-biWK+dm4XMA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] midx: pass down `hash_algo` to `get_split_midx_filename_ext`
To: Taylor Blau <me@ttaylorr.com>, Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com
Content-Type: multipart/mixed; boundary="00000000000007cda606276e1a11"

--00000000000007cda606276e1a11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Nov 20, 2024 at 07:15:40PM +0100, Christian Couder wrote:
>> On Tue, Nov 19, 2024 at 4:47=E2=80=AFPM Karthik Nayak <karthik.188@gmail=
.com> wrote:
>> >
>> > Similar to the previous commit, pass down `hash_algo` to
>> > `get_split_midx_filename_ext` and use `hash_to_hex_algop`.
>>
>> I think we prefer explanations in commit messages to be a bit more
>> self-contained, and not to rely much only on other commit messages, or
>> links to a mailing list thread on a mailing list archive, or other
>> external content. It's better to err on the side of copying more.
>
> I agree, but in this instance think it would be better to simply
> combine the two into one. I do not see a reason why these commits should
> be split.
>

Fair enough, let me combine the two commits and rewrite the message to
make it clearer.

--00000000000007cda606276e1a11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4f7ef08a5afd54cf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jL1ZLNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOG04Qy85UFFvSitDTVdyZTBjL3lRWFBSTkNpeDlYeQpBRE1PWWpPZCtu
YmUrK0FHaTBabXpydG53UFEvWjVDSGlhZzVWaHZaVU81RkhyVFRveXJPSjBxaUZxTGdXN0djCjVp
L1FsNlVhcjl6T3BSR2FPRklFbTRFby9MVDNNUE1ydDhmR1BFekRwenlmd1dmR0wrLzhXSTdiVmdn
cTFOV1AKSWM2L0g5V0ZaWDdYUlhOaVJQZXNqRXpGTVdMRkduYnVPWWlGSkFlcFliWXhmMXRtUlhV
WGZMbW1TcHdyTFRzSwovV0REb3VzNldrZDk0Nll2K3h2bzk2VnJjMXBvemF3akdtb1NnU3J6L1ln
L2w1R24weE4rYzVwN2hrSXhkc2N6CnlTTUFFVDk0cFJ2WFYxMGN1WkJKb21mTnVkMmt3R2YxaVJ3
c0hIemxlaTU3bitsZjFsRk5nbmZSTStxSHNOZDcKTGkxVG9IUkpkQWUvRlRMak5SdFJnZlg2SWdB
Z2NpWEI4bmswbVI2cXk3Y1RtSGNBQVQzREk0ZU9ySUk3dmJrUwp0UEZvVVVERWVJOGNlOVdJOHNP
WkdOMHgyL01RY2NMQldWcXQ5UjFYM3IwbVBLM09oeDVtV1pxaTRrVDZaR2JvCjF4bVVzWk1CZ2Zv
OVg2OWVLRThYTVBQUzBlSE5rQzVnSXpwWWw5UT0KPVd4VnoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000007cda606276e1a11--
