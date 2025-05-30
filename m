Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E31898F8
	for <git@vger.kernel.org>; Fri, 30 May 2025 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748589517; cv=none; b=i5FAzO8MAFyDVXes533siqDZ/KINZusgznikvVLBztFk77Ea0zFb4qqX2OBUHWtuN7Hn3awFszqZCFPktwNny3I+fDn2Ers5S3qlpBn0ufB8EOLXBY2g33j8H7qO1d5Xxwm/tzNj9YtFKDxypuZO3VOAAvMmNGOcTDoJR+iAWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748589517; c=relaxed/simple;
	bh=cJ6aW/DvFCCgtKMz6sLp1y6NiP2W2NbpMJz0ACUSDaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvS1dAA6YKyLCbnA7CAyvHDuNGK/GXRyt15WaSnH/WD89F8MtFipX0Zhvu/ZCr/nFixfG97/GcQ+PIS47vB1k4WFHjGEBtcF+7DSfF7eF/3yvQo0mPqbwMbtXd4GkL/1t4piLQN9P194b670f9pWkQmeONf6vR3H9OsdGqhFjRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0mM2kjt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0mM2kjt"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311a6236effso1284412a91.2
        for <git@vger.kernel.org>; Fri, 30 May 2025 00:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748589514; x=1749194314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJ6aW/DvFCCgtKMz6sLp1y6NiP2W2NbpMJz0ACUSDaM=;
        b=A0mM2kjtY/jz/DFgYSDZ1fZaKuvDOGP+Wqys7Gzvg9gYnnNbzbcEynKZuMJWSWspfS
         bimVa1HGqhielvg4queGfD8apHQXA783FJCXqnxRm2noDWc0lvRtkFrqR8HN0pxLzSQV
         k4t5ENIwnR/99R/KP36i+15ES434x1Qvh+yRiW83+eDt2QGIFH2CJO/RilzcgUAcTte+
         r4wDTENwhyXHiJ7QBOT+BMvrGVik7JqcRM4fKk82XrZksjoT7Q5lFwOJ8iilrgDacLPk
         N2iLZ67CkKJ3YHoPNOm1QxWNQIQhYhkNITSgR7DcRYPjXH435WwgAzOMAU0wD8MlcAEg
         UQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748589514; x=1749194314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJ6aW/DvFCCgtKMz6sLp1y6NiP2W2NbpMJz0ACUSDaM=;
        b=HpZRVeIajkiU4GoaXCFeTcf8maukb6u5wemTLl3JYhHHKCjhFEAj1TR/UONWHJ72yc
         rN6dsjQdLcpGI5jlFyL8CVKkUiUegA4OG/4RWXkES+yjdNoAgLIVKisbVDc/J6Aud2dj
         AqvMbZQ0BS/6ugiSm5d9pNiEA8w7VGkLs5nztWO7Wyz9/HhxgNB1UosED9M5/n92Yyo8
         BojzH2OAfcZ846ueW4HA6flAwTvdBUKsIcxQ8YzmPQ7lSVxCU0sMhEfjHT6fYAmqjODr
         Yv7AbppNZtbtIstbbQO8wZshMt5qZjRhdwCx7QqeiBVgjqXY7PfFGmKXstTj4ZvRvj4S
         sECQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ102VfYy9Yt87Mumv5HfQ7qsAH5wmqRG7h3tnw58aofHdlw0cBw4PhWj6bItI25VaAzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBPBUBYI26i20vmNk/IwepdkTft/RvkU6PXyt5/LIEejUOHvc/
	YTnUYb9sTEeGfIoO09pdOudc4lanhwcfvo7cRKdFl2WVjygIhaJ0HXtBQY+IX0kqThkogEwCD/d
	PFy6cJcoeBAEump3U1Yj+Z4UEjaUHPV4=
X-Gm-Gg: ASbGncvwQ9xZzQANtnWFD+Mwe/9qayI7iRcM/lw9PLgiapSWFig8A8ZPf+pyyCX0WL/
	GtpTjoKnAFbR5XqvXQg0AMKkZKnV4n9e37VTelxOFXzxv+/Gq5lGi1bXlXHYC6LSDiVvcMLwuFs
	UygDDHbWS+YjWzcphthR0K1mZbeNy0UrXn
X-Google-Smtp-Source: AGHT+IE7pm4Qn9mi1tQvvfzGDKQYPrDZNYgrJ+hMJJX4YF42Oq02Gwt9+L5RqwlbFMl3Z6Ew8BjprOmQL2gafparX18=
X-Received: by 2002:a17:90b:4b48:b0:311:b413:f5e1 with SMTP id
 98e67ed59e1d1-31250475630mr1441260a91.32.1748589514395; Fri, 30 May 2025
 00:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com>
 <d8d8c10d-4f4f-4fde-8b91-b979e2931fad@app.fastmail.com> <CAPig+cTdN=x2GXGW2p_g_k4jgC0eQmjW5zLsWhJm-PP7eMBTiQ@mail.gmail.com>
 <4c1f645b-42fb-40b9-987e-08ce9e057e01@app.fastmail.com> <CABXyHXoCuwAUqiQPxE82mV4n0PQtY1zopD+rJDb+oyTkR8qwyg@mail.gmail.com>
 <CAPig+cQbchWLMH+pTVfLHwFshaex2vhC8Pk57EC4U-vch00ZDA@mail.gmail.com>
In-Reply-To: <CAPig+cQbchWLMH+pTVfLHwFshaex2vhC8Pk57EC4U-vch00ZDA@mail.gmail.com>
From: oneee <kimww0306@gmail.com>
Date: Fri, 30 May 2025 16:18:23 +0900
X-Gm-Features: AX0GCFtxTFTKbn0RCJOVqmTAwui3CILyhsEdq3Eyi8Xj-HtYQHDknAYXhQh8lrU
Message-ID: <CABXyHXpGZCDyR232P5Mir8q_ZsMFJwYkYtE172YZfKCDZuA1fw@mail.gmail.com>
Subject: Re: [PATCH] doc: sparse-checkout: Fix list markers
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Josh Soref <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 2:01=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> You're welcome to submit an additional patch implementing Kristoffer's
> suggestion. Normally, it would make sense to send them both as a
> two-patch series, however, I'm not so sure that that would be a good
> idea in this case. The reason I question it is that the original patch
> is an obvious and uncontroversial fix, however, Kristoffer's
> suggestion -- because it is a subjective change -- may get pushback
> from reviewers. If it does get pushback, then that pushback could hold
> up the entire series as discussion ensues, thus slowing or even
> completely derailing the original "fix" patch from being accepted.

That makes sense. I'll submit an additional patch after this one is accepte=
d.

Much appreciated!
