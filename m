Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26D1DFF0
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754257643; cv=none; b=We9F4FIlmijJuGCCjhinDQ/a5LUkoqEkZvsE91Ys8BGOR41Sj92FzoJ3PdgpAvMvWH4nJoL0lR/C/Xe1pRP2wvws5i440qL6WkxA53A+03AJDXOz/PIvfoGJiBcHtwHcXp/ka3zdVFJ5XFvFjwlQ0RCUYl0wuyv3YNzbQqrqNs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754257643; c=relaxed/simple;
	bh=wFaNa2MLgVm3dbzsNGlr8I3JMfj2hPWgb1ZrWvDl16M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fy8QB2U68eWgjCe6MPhKAd80XaWK0LE657n6V+BUnU82SvFllXvpuU1Dg+hkazfACC6JS/Ut1gIPKFqN8EEPsTZBhHH+9hMTzM8sKFQR5+q6vpavsfXyAQtlXqBnrSpjzRZHVT6NqM6rVG3VNGRfAo+/rTSFw5VNwKKYnoch7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmMWPMn3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmMWPMn3"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32117db952aso988315a91.0
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754257642; x=1754862442; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFaNa2MLgVm3dbzsNGlr8I3JMfj2hPWgb1ZrWvDl16M=;
        b=kmMWPMn3oDp/2Up8C0kFa/TCpGFz36bqTYVe6V6eLhvGuuQhpP14vXD95FrZ1wklTg
         fZOqoYMwEGVaEIzLzzfwMOkcCIBNgXgfwYbPHO0eMziofCaPA7VXXyuK0pXLLdSypTsC
         GXkCwJ6Eajt7xammUx9odyilC0k/j3xMZmposcbDcp5gyD9wU1u6xNDDj6yQDyQ0e/us
         7AQ02//OMcx7WzqxIOT73UCpw9ppbsRpYzTqNHEPmAHpiNrYahl24jGP/AUrX1B87Zin
         AQgU1pyYXv9EOJKbawysDewQ/dTDXQQhTQx7N0QoiHqAXxeAMKi0Py4HMJKVe+1xXSTy
         1w3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754257642; x=1754862442;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFaNa2MLgVm3dbzsNGlr8I3JMfj2hPWgb1ZrWvDl16M=;
        b=iCtJN5HhIq6pJtwYJzLmmrlcjaqvUSnvTWKYOgzpXr0B6gOepOIYA6y8+qpPTTlBhY
         g/Khka88G5H0QACbWS/V3novtrkRy9EzoIoelhtgcvfQl6OFnhVljgakM5Ov3g2XLwdx
         drqFaoii6tcLWRmR3uVvuTcFrNqE1mn7MYnAt53pjSAZREd74KkyCVkE4BIH4ldR2QUd
         ygFXxTd2flavghbXv5shXprm/uocYHDNz18D6Q7UcLXr/YG/nMa6yJJRgw8WrJ/y0JqB
         D6c89KOoio7MbsX70gwjcPaPK+GeeYvbFfziS1XcdBmAgs/Yn6EJ5ruol9W4b0epwxpJ
         ef4g==
X-Gm-Message-State: AOJu0Yw0Ygljso2m+BR2sb4IqTsJMqh6oa2unaoIpsaIL6oEUbkYonTv
	sw4Anv2GxkxD5cpHXTw3SqZjPupPVpOjKmTGBTXkLAIz6kUqwp+foMj6
X-Gm-Gg: ASbGncvTawu4DtWGSO3IG2TIvQQs6MKqyfVCiYN3WiDnVkG88ZUy4HiwsmLJnSZataL
	pXwINNY14SzTf/eX0KnTO/NEM2dEIIIcFz+gJP7jb3LYWjK6wYNEAcY9UKILXPWbkGeOkujfUKZ
	ZrxMz39wjZEw7VUnDV59mr/G2G+aCWvNnpzV/EcKZO3tzniCdRDm9fTI/GA2uwLuomrRL9Yek2m
	UsDa+3U5ufCmqM78bwb5JU440GlGcraslUhvzD01KrTTShIDm4BKPeNXz4DdrYsEJMbAu2dsIPd
	mP2MPTglbwga0T6Et/FSsUjpdStH7V82mUxNrU64VF5soD9Dm1d6Nd0JS1eJiQ8MdOLNklVEuEt
	5g9O/eOvr5DPSdARaqtlveXFW0KvE3Lg0mULAGNbrPXKO7XA+0JHkb5qrONueu0rwUQ==
X-Google-Smtp-Source: AGHT+IGD8G6gZmI8Nl6jQDZsjWagVzGFJiNzZvTfy2WiAsxTPqCCZ3pkE/XSpgcvpbBcvm5rX7+JZg==
X-Received: by 2002:a17:90b:1e0d:b0:321:27d5:623e with SMTP id 98e67ed59e1d1-32127d5658amr4837436a91.23.1754257641575;
        Sun, 03 Aug 2025 14:47:21 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8359:ec14:6f00:6014:d8c0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebc1a57sm10053414a91.11.2025.08.03.14.47.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Aug 2025 14:47:21 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH v7 2/5] repo: add the field references.format
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAPig+cTxNUPayO2SdCL-BPtjb2rfr3e3RK=BsQxAiiEAtpBaRg@mail.gmail.com>
Date: Sun, 3 Aug 2025 18:47:12 -0300
Cc: git@vger.kernel.org,
 oswald.buddenhagen@gmx.de,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com,
 jn.avila@free.fr
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC57657C-41E9-4DCA-AA7E-9DC5ADB2DC40@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-3-lucasseikioshiro@gmail.com>
 <CAPig+cTxNUPayO2SdCL-BPtjb2rfr3e3RK=BsQxAiiEAtpBaRg@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3826.700.81)

> This logic leads to a poor user-experience if the user asks for the
> same non-existent key multiple times since that case subverts the
> deduplication logic.

Makes sense. I'll change it in v8.

> is unnecessarily confusing and difficult to fathom because it is
> repurposing the strubuf and increasing the number of allocations and
> deallocations for no apparent reason.

Agreed. Given that the strings that I'm storing are relatively small,
it won't hurt to have two strbufs. I'll incorporate your suggestion.

> The function documentation (including "Usage") talks about four
> arguments, but the function expects five.

I changed the parameters but I forgot to change the docs. I'll
change it in v8.

> I'm having trouble understanding what is meant by "repository named
> with its first argument accordingly to what is being tested".

Indeed, this is confusing. Actually, this solution of using
`eval "$init_command $repo_name"` is quite fragile. I'll change it
to a more robust solution.

> These tests are easier to understand and are more robust in this =
version. Good.

Thanks, Eric. Your reviews were really helpful for making these
tests better!=
