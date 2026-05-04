Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D73E4C8E
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916687; cv=pass; b=j8xlD4T+1M21cJT+O0AdZYxlBhFLT90Cj6eplyVo1SVPM/OJfeskl/0WlejnqDaCAztQ2Q11ARyafOesMzY3jtrndjYxq8zwTFT74DUz37Pf+3nqVAobSCidvtleBRNjVL/Ui5PzuhqI+d7gFA2MklhSzlHVeTp7KuqrvNGkdGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916687; c=relaxed/simple;
	bh=wBwMzzIUACDG+ZrxmomCNRzxYjNnSbbJV86gcY4iWs4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YiRX6E2TL8bO76/MPfE15ocB7kfCtjvNavBt8fuNmVNHkHkYV/kKQu30GhQ1zzwvLGyw58uVdP3r2UoBXKBTx8sQNgQP+whXoiqJazVVc2p271MAvQAWe24MMLMxn7tW8DkojH2e5FII9azsgxz/6vsYOqXuncOkCvIzjNbycnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qj3+3Od0; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qj3+3Od0"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-6221c7251d1so1547591137.2
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777916685; cv=none;
        d=google.com; s=arc-20240605;
        b=dnYZhj7sX4Q/jB1XakfYTmPhUr1O5ZiWkXgdOH29Wkjwov9z5ROBn0fQ24aGC+bj0h
         dZWb9IT7Jx+M2o4bI8+Qngf05zhFDpJBdPeGLO+fG+ZaSGBbylSyOi7i7JqAgiXDwQQk
         o5mJvVfD1J8pVPkvcbImSok3TYBDqGGg8oYV6lzSOUDqlah1I5D6U8ZKQ5e/HNvZu+7n
         OyunYMQhZzz4GnjIAEknBkHphafjU+ALfvW7w3F5HaA1gfsJo0QzUmdImuXmSpw8/F88
         iZU2yEzsIveP3ROSljKcSLzZQQzQInpL+IpMQk4SUqZ7G18lsKbzyYQyfM7ssWx2nwY+
         r0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=eFkTWYy25zR52XRhDStPAqtMY8nJOPwRn2lI/sz2gTM=;
        fh=WI4fY4Wh2p3m/DGlRVYsTuJuXcSK4F/DOdSbmz2dFno=;
        b=GqxGorPWGzt0oCSy4eq/6wje418xOi8BNeQhqgooKRRcrEI3vjQ2M2KPhw6Gx3l9D6
         w0I3yngz93DeYBP5JSpk+kxBIk3+LXvLZGESboiLpHaUfQWwyKxqBW9dXqpd3P2Ww7M8
         kTvCzrtt8QOvvWGX0YdmOPDHOEmrYSbclxFZ7wfzPIE+WJ1X6wV4mM/z3tG3552KaVB3
         yzQI2i3I7UX+saL6gbUB1l9QcgItnuI0qoKfRZ+BRWWCKHV1Gs/t9i440vlyMYVZF6cJ
         gRJWdpzgmFXGy50PDTY1mB0AVSW3sBVkaQpOXhR3Yfoj7dMZ5YePGgGXBXU90uA4DO8u
         y90g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916685; x=1778521485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eFkTWYy25zR52XRhDStPAqtMY8nJOPwRn2lI/sz2gTM=;
        b=qj3+3Od0M8I9d7ErlWfezduMLRBlbngkq7R5SrwPF/uZ7o+b4w+jWPTlmMSSDE2ok8
         T406dBVDz6IvlBXI6B56nK2qlpgSMIWASsnY5Mo9lxSu6xCBg0QTU7aVDLkcWvc0NHk8
         Faej1OLJ16LSmGrLnxPYynrfNebPpQTo6VDuQ38NSTMD6A07cDCnnE6+jJhb4lWdKUdd
         5KE6iQQvD7vSvUbPtEVRPLYfMBlshT2n7Z46xxjEaYKRIB/4A2UL7/M8QiNPQaj973ZN
         IjCecKN7UcorL5AEIrp09JllJFsY5dT7qkTG/LIZdYZGTELqSSI692PjB/+cSNKz11AB
         Anpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916685; x=1778521485;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFkTWYy25zR52XRhDStPAqtMY8nJOPwRn2lI/sz2gTM=;
        b=IBIGmjpY7/I9R10MpyqcL67m8qc74YTssZ4XRkJkuHIE5mEg8g+8acN/CcFVEOhtbD
         p4T8I9cMg/GUfoDZWQwgU44BhPG1fp6fmrJSE+IdypyV8n418HWn/G/c++m0fq2Aq17Y
         +eMPKJZeloSHwHpE8sy1/KB5JJD4nn7nPBjsY3hT31d6rPPCO4wlQGiezbglBfi7VwoR
         OLKOa30MqF+CSSrQ8jr0hQG0Bia6g7uGQLUBO0AA/Rgk5fYTINWbv6l65w9h661V+8Hx
         SVe2i0ao2MtKPTdOkyVoc4BcGVmuK7DcyjeOnPS4gZ7N0gZ4abMijyT+xrD0zJBVaAd0
         Svig==
X-Gm-Message-State: AOJu0YzeWbMEZCv6DOXFQSNqeyUTqPhjgQLH502yEYhRvtSFksOz87Pm
	4XKm41S92M/h+hIoigYYP0fpyQ3+qUw4+2d7y8qsxtp6ltPLRaglqk843/ZqBhGHtzBbYUzILd/
	EGrrkP6qYeF0nWRIvgXzlvMPV3noeHP2lEg==
X-Gm-Gg: AeBDieswmGx3BngY4E8ZCjZRr3diob4JZUTllNP/ehYn9XKljRLxeT3TVTqZvp6YUYK
	H9CYALdDjnaO5t5Z1yToH4Uc2lkAuQg58uqQN7VF3UObtR3mwkXidg6Lsyn86lBlNifsgftuTCg
	JCoUO6Nh6Z6IzD5mghg2srFL9Rd1yC6ne0cOdJde2rsGcGXadyljQYxqhWHxr8UUgnjAxeJrYGl
	gV76vOBQoONMfKs70U4DeX1A9TOeS+cEIuckpVYy0O+Jl43k2Z2i1i+hoWtyR/qm4CvJPHEo1E7
	b9G6xchG0MhRwaeGQcTLXPv/3pm0uvZDj08peBdHpmd17nJfv/9B
X-Received: by 2002:a05:6102:50a3:b0:5f5:4055:4556 with SMTP id
 ada2fe7eead31-62d84f62cfcmr4645594137.4.1777916685087; Mon, 04 May 2026
 10:44:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 May 2026 13:44:44 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 May 2026 13:44:44 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <afiqvgxwbAOxMsti@pks.im>
References: <xmqqmryhtar8.fsf@gitster.g> <afiqvgxwbAOxMsti@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 4 May 2026 13:44:44 -0400
X-Gm-Features: AVHnY4KMiXwWRAxwh54GsylPfb4LL3iZ6Exhh1Rn45s4dZgySmpfEVzG51hj-oc
Message-ID: <CAOLa=ZSBweZ0-H6z3KQMZ15bqfa0Z7QJhJ4jAsnO63KLnm0Vcw@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2026, #01)
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007492880651017c1f"

--0000000000007492880651017c1f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, May 03, 2026 at 12:47:23PM +0900, Junio C Hamano wrote:
>> * kn/refs-generic-helpers (2026-04-27) 9 commits
>>  - refs: use peeled tag values in reference backends
>>  - refs: add peeled object ID to the `ref_update` struct
>>  - refs: move object parsing to the generic layer
>>  - update-ref: handle rejections while adding updates
>>  - update-ref: move `print_rejected_refs()` up
>>  - refs: return `ref_transaction_error` from `ref_transaction_update()`
>>  - refs: extract out reflog config to generic layer
>>  - refs: introduce `ref_store_init_options`
>>  - refs: remove unused typedef 'ref_transaction_commit_fn'
>>
>>  Refactor service routines in the ref subsystem backends.
>>
>>  Will merge to 'next'?
>>  source: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
>
> I think [1] is something that may still want to be addressed.
>

yeah, I've sent in a new version fixing that. Thanks.

[snip]

--0000000000007492880651017c1f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9bffcda250b9ddbe_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uNDJ3b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFVuQy93TjNzMmg5eG1IMkJjK3o3NzBId3VZcG90TgpaZ1c0RDFYZmxB
S2hhUUJ0QWsvR21QcERBaXROZnV2aVNTNG82Z3ZyZjh1LzF4cG1odFVsVjlKZndCNzRISGdsCkZ5
QmdzeTA5blJmL1NjYlFyUkNsTUdxakk5TVM5UHBQYkpnbEtTbkdPU1MxcUZlN0M5endqRUQvVGN1
ckxPQUIKZWxLRHBIS2JXcExPM3k4Zml0RUptejZRbUpEcHZ2cEdOaitvZUQ2ZjZXMnJnbGtCV1Ju
RUlzTHJQbitoai9kVwp0YkJCUXZ5djFSWjQ1UXpDa1B5RFZiNzNpVzNkRHRDZENHK3d1M3oxMURG
a0t2TWhLNnNRTktZWHZ3aFZGb0MxCmkxSG9pUnFxVTNCSFplWjFjNFIzU0lTeDljZkFWTW1QM05h
amQ4dmdiL2tha3VVNGJJYWUrcmFRY2NBanJlOXUKQmhOaDBZV1NGMWRkKzZDVVh3Q3IrL01SU1lJ
RlpHUU5ERkRNY24vN25CRVVFUnc0bXpZOTFpQUJ1OHJJd0ZGcwprTGNzRTdCeW96ZHZNcGhFaGR6
cTBMVGVlRGtOYWZDbUNiUmxwNEVLaDhiK0ZKY2pUSHYySWRvZUF5ZU41OVJzCklYU2dHTDc5VDJY
Vlc4L3hDQVMvbnVNdzNYajRyaldPNGhDRytYaz0KPUdTRjAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007492880651017c1f--
