Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545751EA7DB
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764446124; cv=none; b=XBnlo+dCCmquVpvbH57H4l62h8yBmXGiekbM7ztBqcYYRsRvO0Zy8F3sHFMSUwZuQmmO+9Hn4L1KdePvdVlcbuWIDDaqTz7ZfC+ggw8FNFKTaS9Rx/rZPYTNDiTbf5Z2zFDT+c9VcMbg4xMPtEHacDvHDXXZuJjwht1UoJvA2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764446124; c=relaxed/simple;
	bh=x6UyVlC8E3vdA8r+uh+Mxgre433PXz5esuvoQRcPFbA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=FSsV/gJI9GwQpciBK3uulCrX1lscxiYUAI1YzAVIZGxqrAkbPQJh9Ah0iggfzZOiqjLgAH1YxEbdKu9qX4XIDtsWeWRTWMH5cx0wYABKYtxbKcUQFwo5EKmmEEQ1eu9vV6Mt5PaZE98W14HS0l7RwKPjJ1GJENwP/yDRC5Uw2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQUKzdYi; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQUKzdYi"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78ab039ddb4so28042557b3.3
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 11:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764446122; x=1765050922; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6UyVlC8E3vdA8r+uh+Mxgre433PXz5esuvoQRcPFbA=;
        b=YQUKzdYijPtBOMr5nIVMWPoE1bkE/Bv5xT5lAm2mnZNF3nIGWrklinHsVnNzC2YeQZ
         hY1faKJlWZjq3XobcMLIa379P/i+f5AnhKV9YQ2hyMT2HoQdXMURjDCn7xIeHaU/d3N/
         beIxgfQ/eLCu42sYtrTr6uFG2qmkC9CDYEGrKKdhO5iDYidlQesRqw8hLnL5hkrlfOag
         enQ+sy2e5wfW6ecYCpF+d8KbdxDwJ03OSGcYnkxBmk5Q8A3gp4VKHr+dUd2cUgpTEKS4
         BWGsl2cgpdRqTcoX2c3ZeYVAOdVC50VYvhmRZPqf5b0H2LBAszQQhtWgj7naVFy9ZGJb
         8eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764446122; x=1765050922;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x6UyVlC8E3vdA8r+uh+Mxgre433PXz5esuvoQRcPFbA=;
        b=sY69Fr1XCgd/qvxMn99JSVFtvyFWLSnXbTrK6PF6qwkdZ8GGYLiNuM2rM7I9t5l/Kw
         lJtSMiJXnDoAHv1gbXHOtySltRnAWUzFPcnmFGl8ulqsZFXfWZOsZIyFUBSHuMPCRRfQ
         c6fFpjOisbLH0qK5+pSH4ymPA08iaVWD7uQ2uJ+HvUUQwQpB5VyUVUVMK/gtz+qCQmvf
         VrQSNAPSuz+TibD1y5Ip48xUZ4B5HVc8oIJgwwlWkBAY+zNbwMk19Al/wlLv6gtdFkFX
         Pab8eFd7cgBoStiUMyHx2byzm4l+cmGpECOEgCRLXLHL9RxQ5vbnU4HXT1nHCmQBZBba
         Vcjw==
X-Gm-Message-State: AOJu0Ywmq1IsqfH3jYRNgXqvNLlyEa1EOY7jMtqkCs5WLbZ+6/CuZJd6
	HflzCWmjSGgQl+uRj3kfG09x7zcED0+yWsa+ix+1phbs9PdLJCAZt8bD
X-Gm-Gg: ASbGncsdMQX8GgxmmjxA5o49kpE/Da5u9NMfB8HzbP71hhSCJi7ClUfH6924aZ1qN4K
	Ctni6ZOfFvYIEpIIhxfX8GhrxXAWjYYIeUBTg9fmUJGrQZ03hIf1+aVr3IX/Qdfl3F7r23Uk6qb
	r/k77huzfDgVDg4Z6TMrj+hcoKvITb/mjbCDVzxofpLpQc9h4QrADobXhBXZYbNNzTSTgIbGc1J
	1riBG2s5hLvgvgJULAOLMOn5iK9NTqKls0ajXI0k6FJSe2zWkf0kJUfz5gawH0vkvyHHgT0JkDn
	kMcEwsUMfQtf+LfJVJbCfMRDYe3U6n0alYU32r5Z52pvClON/G5nvoYT58IO/Hh7wFMwI1Ilt4Y
	vBnHCaYx3l/pCvenbf5xIq4kwSH8ugS7NPGydkhXd7/5Z2HUiTIjXUaVijhkWNOMYYAjxF8hiwP
	W/o0BrYqcy33bZIpWGOrVnRQvStGYSiC9aMTCUxQ==
X-Google-Smtp-Source: AGHT+IEpRcETgNQATDSV/Wx4f4XqyM2ZlJ0GvD3s7z9K6tIoAToC3gniEsmBUnPhE5fUurOJQolhgg==
X-Received: by 2002:a05:690c:e3cd:b0:788:1cde:cac9 with SMTP id 00721157ae682-78a8b495a4cmr255484707b3.23.1764446122250;
        Sat, 29 Nov 2025 11:55:22 -0800 (PST)
Received: from smtpclient.apple ([2601:740:8400:bc03:701a:4ded:83d1:3cff])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d5f4c5sm28897487b3.13.2025.11.29.11.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Nov 2025 11:55:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/2] Update documentation/discoverability around `scalar`
Date: Sat, 29 Nov 2025 14:55:10 -0500
Message-Id: <FD92D0BF-E2C0-485E-A121-4C92BD20F7F9@gmail.com>
References: <20251129183236.52760-1-matthewhughes934@gmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <20251129183236.52760-1-matthewhughes934@gmail.com>
To: Matthew Hughes <matthewhughes934@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 29 nov. 2025 =C3=A0 13:33, Matthew Hughes <matthewhughes934@gmail.com> a=
 =C3=A9crit :
>=20
> =EF=BB=BFA couple of changes following on from a discussion around the
> discoverability of `scalar` config changes[1].
>=20
> Following that thread, I was additionally working on a patch that would
> involve commenting each of the changes and why they're set. But that was
> taking me longer than expected so I figured I get these smaller changes
> up rather than waiting to complete everything.

I think Stolee implemented a few similar things in GitGitGadget PR 2010

