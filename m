Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D7340DBE
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676152; cv=none; b=rATM5jua3kLul4YoKrUeuG2kD0ffITkUtzbPTxRAsLs3Js4W0ICvGZZ5AveHyfhQic6UZPWuLOTPl29G35lTGuLVWIFrzkW44fKKjVFkLptO+aKZuXxqKNUk/IBb9KV21QINKnkJQc8HsK4OKA8G5IX7g5boaGASgZR0Ol9j8fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676152; c=relaxed/simple;
	bh=YLzjoRXDkoJ2AdY71Q+H+SSfXvNGwoRwrG2ebbATuI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMR+JRkzX7IH3VpAUt7glmUCjigESCOBEAaoFMKPdcsSAQmiq2CeVqkhXqHo0qAqFMPq6qn99Hbm4txWYhTnmHoHPzGT7ZksZ7hwOthZ2Po2vqz1WxQe71GuuWLzePR+B2HEyCrPjS+n/nh+vhSJxAY11an3TL4UYX7Y/jpyCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AokYiwWo; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AokYiwWo"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-430abca3354so59471175ab.2
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761676148; x=1762280948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGYGEkmsBOgihp2Yzf6zjQDSwTmqTT8llzHbgwKiuMY=;
        b=AokYiwWoJRO3rMo4pYLbZ+b/Hho1pF3HdI5tq7QnoN0JmcEpBNGHdf26GGRBebHZ9i
         sGD8Ct54ASVdLCZXA+jLzvb0KQM3LO+YatMBBkSxXby04aj9Htr4eygGCOMg6rWzDSXm
         78Boetk3yhPtl6Fwc67jEsTTPJMYriOfVxu0nJbTHIW8kuO2dPBxWopsuyDup/l8f20y
         A1xLPdDzzmc62xOknklfBi76KDSBCs8ktXDYtjqvna2ceGsD0iH+DnqLj16EKTbAD8Ki
         IEDq9pxGNk2Piqn382RUY932ZgA/2JxH2vZztiudThmdZeLcfzOxWUjBmifiXokinFj9
         Sp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676148; x=1762280948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGYGEkmsBOgihp2Yzf6zjQDSwTmqTT8llzHbgwKiuMY=;
        b=tlzY+ddf+TfpQR9dWAY9nx43N+GwW0z81UvF3cJq5eA9DVJa9xBeewaiNBh1j486O7
         cKd64qbZ280YQyKm6qO5AtFKvRpFR6ag5eKhTEOc23scVLT7DxkNZxy4dQujablCMf/U
         4FUC8BiGw2Gh5KI8HfRtuugLul4jvUgXCATkAmK7ZOT4aLWRYkXnWzpyIsZsguuW39f5
         LIJZ03Fgj0BQzvuucIQVGvlbjIJWXjk5yekm4UhZk7V+kK0DA+Hw9vjJrqZ+Sry4HIMv
         nAJAooLjuvkNZcxB+ylbTDvcjULwNAc8cxC2IqMsRpXdxBhtbi62UFs3b1pFQ5btAmPG
         UEhg==
X-Forwarded-Encrypted: i=1; AJvYcCWouLKxG2jkNQJoIxn88HTkW7vlUiwN/JCDXf49CxK28Y5XX2I0Voykz8jT65zrdwtGmsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ4k7H2kcs8lM+E4eMgcKyxiNknV7lHPW0857/5p+RwfJoUn8r
	lRZyqAuBBR0OYNyZBeXZ0YyHlX3nVtd0Ai9rV3mj9bNQpLZf2nnB+9jgFxRmY54HVOh0n1brpEF
	xgA7SyyYO5jBQZgbA+hrQ7XxpB5PfwuK7bw==
X-Gm-Gg: ASbGncv+ym6oLuG+poTA5PvAIS1zHi2NefnOxu42h1vaOAqSEexDZyuApfv5WD0vUX5
	D97YTlcMwY1aYMCaSOZXTDb2VvZ+3tJ6DmX4CN42xBC7AKXQfiD9aZSbHixhrB62ybjrYk4DBAt
	PhKBjK+mVorOGUSHrJvnQVc4s3XiMLOgmhYMpkKEksMZd8Pg7P/hJiB8Nvk1WqGQHTAuVP7c1SR
	KvMJqEVQDGiSLH2PNUvkW8AwdpgNHctzGgou3YSqldajue5J1SPLapYfF9n/Q==
X-Google-Smtp-Source: AGHT+IHb/uizWaZxWOyOzvvfmYZx6ykANboZdAlDOP/vT552fc+xINrBTQTP7f0wedWSe4A018zWI4pGn56kKKiKUr0=
X-Received: by 2002:a05:6e02:1f07:b0:430:b1ff:74cd with SMTP id
 e9e14a558f8ab-432f8fe127emr2917925ab.10.1761676148500; Tue, 28 Oct 2025
 11:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-4-sandals@crustytoothpaste.net> <aQCKCfuaEKBArD-g@pks.im>
In-Reply-To: <aQCKCfuaEKBArD-g@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 12:28:54 -0600
X-Gm-Features: AWmQ_bnwmRdMd9E8Tb1gcakwUpE2fdlMBeHL6C7Env_E327VH0dJJ27VS5o5q6E
Message-ID: <CAH=ZcbCWNiu5OqJO1m-1QYrZRXFydD5Pt7mg_1BhOwVHu_PKJQ@mail.gmail.com>
Subject: Re: [PATCH 03/14] hash: use uint32_t for object_id algorithm
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 27, 2025 at 12:43:53AM +0000, brian m. carlson wrote:
> > We currently use an int for this value, but we'll define this structure
> > from Rust in a future commit and we want to ensure that our data types
> > are exactly identical.  To make that possible, use a uint32_t for the
> > hash algorithm.
>
> An alternative would be to introduce an enum and set up bindgen so that
> we can pull this enum into Rust. I'd personally favor that over using an
> uint32_t as it conveys way more meaning. Have you considered this?

I think uint32_t is appropriate here over an enum because this value
will also exist on disk. An enum in Rust is really only safe if it
exists exclusively in memory, and is untouched by C. Later in this
patch series there is a function that creates an enum from a u32. I
agree with Brian's design choice here.
