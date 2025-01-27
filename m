Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C613AA2E
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990743; cv=none; b=CAJCGvU4g+713uqtYGss91kcqf7iIz5CX5BjbEg8bCfW/410o44dS6YjHrIVL/ggN7R+U+SOSn/bv3KQksu7mse1IMzs8WDbgQ6/0GNFa6mvgUax0WRdnTPzGO/HdsmNmK5hzTwDcoeK1ftvLi10tSgrczxkt/Shfss8cMdU0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990743; c=relaxed/simple;
	bh=U1G7d6idH0kjbYxpxJe44QtaKbitErCRhb3zfrhO6d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+c1cUtm9MckcCl8O6BBvG0Q4YnhgJ2PdO9kE6boLAsTyzKQNZT7Dy6gRPh7qMowM2khNVRVcg+Ts3Z9zU7sS4lwb/taKY5tTMke0542x7VU6sJfbehm7w6witgtEuK1+qxBbwBMENe2a6J/qvnMLtr/+NJAYuNuqlBoB+Y5IQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1YyPa5a; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1YyPa5a"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so8890380a12.2
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737990740; x=1738595540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1G7d6idH0kjbYxpxJe44QtaKbitErCRhb3zfrhO6d4=;
        b=a1YyPa5ab7fo5JaBKcLxf1rMmF3shEBp/bBkyc01oe+zB406IrzdJvVyKrq2nvC+bf
         H2J4bIZHq8jhhv1UkeUWjhR8vmmJuQhtfpMRviJFR7sdEV+e4zufQQ7rnnm6SVwqhAr3
         eFuF8KguoRVkmi3ez0AS/10lBaQ3UteJ88Gv3dfQzBkNSN3k4eG5ySk60rqusnlyWYTK
         7jIi9Wrd7iEQnulnfdOyFnasYU7NiHAFtZ2D1chaKRyb1VF1S82rSzkET0/VnTdU7QR9
         dZl517uSRRqjH3dgH2zmi6ozeZCylWwYdoMGrLT7UYB+LJqRmiD9Hj8BFfh4ZRkPRzGA
         t+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990740; x=1738595540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1G7d6idH0kjbYxpxJe44QtaKbitErCRhb3zfrhO6d4=;
        b=tmIfoamBG31ZzmcYuZ10iEW05dm5cMkxMzLgTWlB4YICRvjUHtbJQy3zj10yOwQjUh
         IFSwWLYhjOjzpIBVdkblnofJdn1Poey/eUZ4UveNMsAB0wof0X52zowoqZ7x78eBqErH
         jqICxoE/ujS+OsHbowr+42i4A8zAyTA1c075rlfyr2WcztqrmM7M7801OQDHf7tDHt1n
         NTyAcf1/mPmjy++bJWlxCXFx5UHEwEfTpaNbdiW/cWbLG8mCKRbEzXQLobH3JW2Gw3dK
         LNRuIgsKwkjgK6JYaibvSqJdUh456HzutnCuXdWn720Afyc8VxK0hA2Ov1dnpI1vVKBa
         gV2w==
X-Gm-Message-State: AOJu0Ywi9CHTS0MsbMVfK6PdZhFsYNrdnFNgs4oVSFqB9WETNVIIiXXO
	YWT1SBTpTHVE18Id7BcZR+wkYRu8PoToV3jzlU8aY48PpZUfAc1U1SQD7iUDkdd81tU67xI7A9R
	+RvqiU/hCD5iVOZDJGztYz0yBgZ4=
X-Gm-Gg: ASbGncvVOjFiOLAtKAGi4oxCLoSrXiog61CRXdW4mlnRiU+5gukguFO0bWCndQpMv99
	iq6TMJH7ma3cN0R5KSvsx0W8rMQu4QHRmefzCpOGPEjpkQD9ouBdGcdakWUlKOOHe
X-Google-Smtp-Source: AGHT+IHqAnvq6VivpaSkeAxZiAtBl1PkyWEmQLXY50z10+C1kz7Nh4/8gjCk4fWtYb3lBE0sFd8wBa0KaxvwIQk0ZuA=
X-Received: by 2002:a05:6402:50cb:b0:5d3:e45d:ba91 with SMTP id
 4fb4d7f45d1cf-5db7db12ccfmr37406367a12.32.1737990739500; Mon, 27 Jan 2025
 07:12:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com> <20241206124248.160494-6-christian.couder@gmail.com>
 <xmqq5xnsmima.fsf@gitster.g>
In-Reply-To: <xmqq5xnsmima.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Jan 2025 16:12:06 +0100
X-Gm-Features: AWEUYZlWJwXVSG2vSas6PLL2AQO9YAjITnFGBlI4hhZljzYnpZ86H65piNgJvsI
Message-ID: <CAP8UFD1hndoGufxrex7PKNZ6L-Z+fJgOxZeT=zVjBJybkk_omw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] doc: add technical design doc for large object promisors
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 2:28=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> Hopefully I'll have time to comment on different parts of the
> documents, but the impression I got was that we should write with
> fewer "we could" and instead say more "we aim to", i.e. be more
> assertive.

I have tried to make the next version of the document more assertive
in some places and clearer in other places by replacing some "could"
with other terms.
