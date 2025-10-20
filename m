Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825B239E6C
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002980; cv=none; b=G2BbDC8Jd5y+PxRo+juo6umPFOlhMHaVh5Ncw3YANOSzqm86WGDoCmtNunzNtu/1CLwBB1UiliWzvcxvtbNMfCWWGqcaoKptv38NAmU5XLRPXunPXeBGvwomj1QpRZel8RaaRkPllUX1lRGnSujt5YX5lZq4ml0jYjwdC3xiG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002980; c=relaxed/simple;
	bh=Y2rXl+ODcektui/l7R2ep8hQRd82w1F+axHNtzfbrAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HP5Xy8GX7FOsdIcE/cBuB78LRsWqMjKZZq6MdrFQrq5mbNPfeMqZuF8Ymh48VO5eJhYhe8+2J3j4m5upb6AiZqEo+wIpf7mRndcFZ7st1y/IFrJ1DmqWRaZMLf4KX60LeUr0TJxe8BrcX2No3TY/HCiEAUTGdV0l0H04HOexYE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp7vrCNE; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp7vrCNE"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-367444a3e2aso60557551fa.2
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 16:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761002977; x=1761607777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9YuGJcTxfO0NMV1WLbA5D+wZAvkrAz+rbxSbTdtAKo=;
        b=jp7vrCNESu8BjdxvRhVzEo85ZYr+Ns+4TO2Z+ANuhxikxUF3puHybSHNgWBHTD9k0N
         S2Lnhcm6sVbrNRerQugR6qYeIC38WwpSGsrbZ/FADj7ZGwh87ceWbuUxLoceXwGajEhs
         2D89oS5Jxk94zr68FsWfrp/K6Y8jUgROaW3bCLGNm5XEQIIyzb0WjdcR510MG3z2iSS1
         TI70fcvv8UFxE2ckpTii+fQ6cEgEZMtqb/597FYC62J/erFKpFiIbIiKcm70Mh1PFWfh
         BdjQDWn6aCzSIS3y/mO0E8P9MDUuIizEjlw13/6oS/uNTZ2tos5zcFiYhFllNfLpTCcR
         oOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761002977; x=1761607777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9YuGJcTxfO0NMV1WLbA5D+wZAvkrAz+rbxSbTdtAKo=;
        b=UrNaTSaSM1AkKbxWO+qc7KSa5znJmWBfXdgaL8UcUwRpVJmU+GKsq0jRp79atHjbtz
         DZGhOpjmFFwm1rh83T9qtCcJA0+V2qzcPt8kUZXBx7OJjh2q3rAqElHb7Yg7HzKbIxJ4
         8aotYRs/lfqH+F8DLCG1ihGAD+HvJwiPhPXXzP3MQlwg23GqNDqlUavP8VMG3+Jk9G7/
         xJ480sX8y1tJ/rd1fc6qSR6WO/Rn1KZWj4OiPqxrB4RSLTf1+O5xv6GUYx4UmPL/e9ww
         0TF5/0XNLAIje43MSnCgohfEN3I2u9lUZBhsNT+apuMYPF1EAtoXmTDQgzMD1C9yNdVk
         13CA==
X-Gm-Message-State: AOJu0Yz7adk2hjjbpePc1gRQCaQXZTDdCyf++3JgoSnJ8YFH46GZOJ9Q
	zAPlciL2JRiYX5lnr9FY9DFr/V+lJ0s+ijJ7ezjYtWiGOocYtfYG2L62OFODTvlMry9j/xm/kem
	R/nFddWKs+yQW1qXeT+BigblHNArYH7o=
X-Gm-Gg: ASbGncvZo8w+LPH0215vzX2TPedQ3j7oVk9GqxV+p12Iq2aLJTpL2bifYHcrHrPQHoF
	+lQFYTh6BZUFL8QbFD6BHWHVqZ8fIdNSeU2cRxTzmdcN3/yh4gwkQWgDu/A6S9ej6Po/tN8KfMh
	Gy5gLmvN1TU8uuQYRF0G8l0urMePcUJMUSUgowSRP4/G52vnhCqiL8w6Ay2n/RB4N8BHtIaWVxf
	/LhU78I4P2226kNFKyOfrNFQ47A083It7XsnU4y9LBcddjxe782u0/vA7pmLPDtnikXAKOY
X-Google-Smtp-Source: AGHT+IFaG6pgBgFYJUXg1I7XTv6gdxD7vtlapZGnbvE2Rc3QlaOcLS3Pl/+TfGKCKWcOybtS9mW60FgBvaTcM/fV6tk=
X-Received: by 2002:a2e:be0a:0:b0:363:f65f:ddcb with SMTP id
 38308e7fff4ca-377979395a2mr42161191fa.18.1761002977019; Mon, 20 Oct 2025
 16:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com> <a3e706ecdae51434fd5ee112c13f8cf374faf6ed.1760563101.git.gitgitgadget@gmail.com>
In-Reply-To: <a3e706ecdae51434fd5ee112c13f8cf374faf6ed.1760563101.git.gitgitgadget@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 20 Oct 2025 17:29:25 -0600
X-Gm-Features: AS18NWBPeotfnti03Ws0S9pxkXY0zJyyB03UlcpDBb_6gDwDYgtijt_pjqzGw10
Message-ID: <CAH=ZcbAjX=V_VvJsRzvQEA+CMM7dWQx6E5=d4FL5CD3s+ozjBg@mail.gmail.com>
Subject: Re: [PATCH 5/9] xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:18=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> The ha field is serving two different purposes, which makes the code
> harder to read. At first glance it looks like many places assume
> there could never be hash collisions between lines of the two input
> files. In reality, line_hash is used together with xdl_recmatch() to
> ensure correct comparisons of lines, even when collisions occur.
>
> To make this clearer, the old ha field has been split:
>   * line_hash: The straightforward hash of a line, requiring no
>     additional context.
>   * minimal_perfect_hash: Not a new concept, but now a separate
>     field. It comes from the classifier's general-purpose hash table,
>     which assigns each line a unique and minimal hash across the two
>     files.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>

I'm a bit surprised that nobody has commented on this patch. I thought
that someone would have criticized the length of the name
"minimal_perfect_hash" or asked me why I was splitting one field into
two.

I don't see any reason why this patch series shouldn't move forward.
