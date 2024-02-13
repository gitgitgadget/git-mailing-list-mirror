Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E83360DE2
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707855925; cv=none; b=oVFG9F/3J4722+txyecE9Diu56L/dQEJeyL//0woox2SPZmjdx6rnfkXVUqkuDO/BIugXCP+tpyU3p/t7UoeNPttFjptjeLLKrXBsASRrIRbsgUmDlS5OL3GvYwRjXb7d2u9JZeWqxpCBDnAsp0YGTrwY26wKUzOgxIeQ80eCao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707855925; c=relaxed/simple;
	bh=ytFsYGa208/F4pwjU/tR1Mt7P36kEUoGMXT09oNVris=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EH9f+TodTIKgWhxjTSG6Io2HC3X8nA9bjcXsRM/DsHvRHgLb3qhbqJy7fS8L1VEMnA4R0MY/izoLHmz26omH6aETJi/r0Q3QEhefrwIkPQpQYc8SbZeruivjbk8jIDeo4DM3CTNJQyWjt1F6g40IjszYheWTVg0/9HxRkDVZD/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhz1OoK8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhz1OoK8"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55fcceb5f34so5551429a12.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707855922; x=1708460722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWiehwH4xhN/g3GRFE5tSWWJHajQqibgMSIFzCE2xy8=;
        b=Rhz1OoK8Cxq9LvZUY5muT+3v0sY7DRM+LeZMg5Ug+7Yw4q9Zeiee5DU/smBk1HgrdR
         A2G9/NC85JIYdDDSoGLBFcRaYeZyryCdYlLKlQWFG/Ff8hfFKfHpcUo5UeqBuh17sEKr
         +SRDBNeki1xZuwLUxzPWA3+Dj5UPOgmL7VwRHOtqsh2mYwpO5UmEOFTw3GzxPcGBOI1Z
         rdjTrRf0/Jz9+C5+qIA03aO5WNXe/goBf/hGXMKlbwsnrRWRiGwOPfLHCEvjONvHkmVS
         KWZiEjmz+FtupzSiXdoT9wVQky2Nau1b4+C8CrXUTXuR8TDY5YTHraS+kHwUm+reHB20
         5wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707855922; x=1708460722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWiehwH4xhN/g3GRFE5tSWWJHajQqibgMSIFzCE2xy8=;
        b=LeMPHE+mSLoEzL7FH770bmdi0BNFN9zKx42BzNzD7cE+bKpoTIOwzLGDA+OZiWrHbD
         I4vVFcZl83yn0cndC+WPgKVx2DDn7GudlZROBJ3/CAkmGU+gtw6Odc9eY/E7R0Cbvaly
         arFUU7ZdW5cxBpjXca0pl/iKm6J6oJywscSc1SOAG34agohJGMycnrA33EGL1DZrLsaV
         nRc5hmZEskipl6bmffSyLyc3bHD68JS3MMktD8NuehlCHf96Fa5RqFfjyJLKjAPfEsbm
         pQMWH5qrXkGBRRU9E28bFBYrwd9lgPYh9dxiBwna+G7nNBSkuKOZY7hv6Z6varT1j4/V
         cv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgwTbshTwHgg/BPsizG3rrQu6uYNUt9UnyuA4ZGfBIpN8pwstzsrJWF3wyyuoI7tnRMTwG+nECQ8vO7O/L95xB/aHV
X-Gm-Message-State: AOJu0YxHDFIwaJraE55oLrZKBpOT34EfCujQ1FuL2s0b9RxqH1LQ/wpH
	/Ob9NEGqHIIcJmjH1X3U0w9OthpmvDVwngobS4Yk+z8eiA7CK8/t5LYx2mHf8U+X9FO+YPdmbat
	U991P/vc0FCH/1whIIlfwGm+BTt0=
X-Google-Smtp-Source: AGHT+IH3HkNRRxRpA1VRfd+XKFeV2AK1yLYbKkVdWjPb8w66V1OtXnpaE7xYXjPHSEhrrjMSRA7MWwuhoAm+QeTZN2Q=
X-Received: by 2002:a17:906:4a10:b0:a3d:19e4:113f with SMTP id
 w16-20020a1709064a1000b00a3d19e4113fmr312704eju.76.1707855922297; Tue, 13 Feb
 2024 12:25:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <CAP8UFD3qLGua5PTA+i29N+yJH8iKVBPwUn=S606B2E+s959JFQ@mail.gmail.com>
 <xmqqjzn94404.fsf@gitster.g> <CAP8UFD0C37qdTUvCpRFe6_zAeAcssoySY6tobw+AO8hpA8iAfg@mail.gmail.com>
 <xmqqa5o46zla.fsf@gitster.g>
In-Reply-To: <xmqqa5o46zla.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 21:25:10 +0100
Message-ID: <CAP8UFD08F0V13X0+CJ1uhMPzPWVMs2okGVMJch0DkQg5M3BWLA@mail.gmail.com>
Subject: Re: [PATCH v4 00/28] Enrich Trailer API
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Sorry for sending this previously to Junio only)

On Tue, Feb 13, 2024 at 6:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> >> I presume that [01-09/28] would be the first part, nothing
> >> controversial and consisting of obvious clean-ups?  I do not mind
> >> merging that part down to remove the future review load if everybody
> >> agrees.
> >
> > Yeah, patches [01-09/28] look good to me.
>
> I was hoping that you'll give us more details of what the other 3 or
> more you would envision the series to be, actually.

I think the next one could be [10-16/28], so until "trailer: finish
formatting unification".

Then I am not sure about the next one, perhaps [17-20/28] or [17-21/28].

The rest would depend on the splitting of the big patches towards the
end of the series.
