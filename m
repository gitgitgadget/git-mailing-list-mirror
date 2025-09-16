Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDAE224FA
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060079; cv=none; b=XIDm81KKBryUnlK0XyYQ7P5S0ON3pO5hacfEmNMONQm3nZyxgul1bs1vCurKWYi07Z7ifp8+2x2mgURBWxU9L0F1T9tTBfbhTw0Xkry3c3PuxK5t09e1S6Ucw0mAScwHnmeH0GJAN/65uprYbAM1ePU6YVYNHPoCUrMBE46n0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060079; c=relaxed/simple;
	bh=GKtQlgePuF0z4320kryMY4S6wmf8OUXHjmwT+HbtmQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgFcB064voUPMZ/5rWElhBV4vnXg4k64qm5uv4F1xJqtcC81cb2r+EXZZv6ui+oIK65dZ6A6L3kqBbtTo2bxSgSPUEXF7kJbEHduw2TgetjyxXqnYjMJbvI8obljuwUtgAo673bF3r64MT7odSZd+k999GziYQYYhN2YsMoluZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBkMpmbp; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBkMpmbp"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-35e9f3095ebso4580921fa.3
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 15:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758060074; x=1758664874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKtQlgePuF0z4320kryMY4S6wmf8OUXHjmwT+HbtmQ8=;
        b=PBkMpmbpLkkXc1sFHh1A3b31ti6qpVDn5j7czZuGz4QafqlqeT7PLDbMacd9I5DXcA
         fOg1ubOVI9cY2IxTwlt3fodywDILM6iod0CHe+YyPVxzDTMfY/kcy34n5Fy1jjOvlytR
         TnAe4mNC9iqCNTB4Xj/pGfjcQnJdWDV5B+yAzbOHmXDh+0n84xL2uWZZPUhs7bm6fCfB
         xsvXmA96QnvQblM2oPp9ojMoGVm6sf/kzVSpWS1u4CyVOCSvdXrOs6azHOCXmvw6cJaa
         dhPbZikaIkcmInvcSsRG59OSbMhQdkawheTMMZESfTRgsIHSaGxeLoGUbVkPX1ViWKn0
         Dq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060074; x=1758664874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKtQlgePuF0z4320kryMY4S6wmf8OUXHjmwT+HbtmQ8=;
        b=AN6y8Ry/1iWtBfTYBHfOa2GWUHwy2l8dASc0KLmeD+XZxmkctTAsYBiwx9KazyrM2v
         gRfshVbIUuEKvwJWLbVExSSbElr7Gp8W6EHR3ZvAwckfEuYrXV4Aclep9ktuv8thtUOm
         VN8MGSrbUbSfCnL5wpb4l+z0VlOM+uuZ+ITI20oFWIRoOKWL7DdhKavK30gnXds477L1
         caZE5esMfEb+cuo7ZiU6FHHz5BD5e5yw6Mwy+wzloKNhaty+Mp8Q9Ux+MypPojIOJMPt
         J1o9rCrfxH/7/9ljrms12HEUjBjjveqGBKPInNhWQP5oXeidl3+wHzFMVEMMQgX2R6L2
         rt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVZUUtMOyfaKKjUp0fH8Ikq8bKSFUIBGEDK7fDX2FiwQFBl60JNVIDjpfZb28JgKHg4o8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ZtG56am9dHGOK2DIvf3DyfDzk9MpGu46GzPUdvhe4DguJVXr
	okz6o4+4049gfiu9xeDp5rc9NcuxumJJOIuAJPoaynTWyhi+Fj4exnA3jdPNatey1bTz+mfvarL
	J7hTtWYwQboTg8DhRCOQNvWMd8sxtetQ=
X-Gm-Gg: ASbGnctrZ5rtQJpJoC06I5wII8bbeyUlmkXwI/37oyEhAe8OxsnaO9s8sjLvKTz6VBX
	WEQWHy2zCragIvyv9e1t4gEBnOBXn7yKH8NNHDT7vwmfuWtsQwjOkEd5y8oaBqR6RK2IsL73psX
	XwrCwGDhKX9d5yKCNHAad77mAiME678ttHtubuG4aw+sLDCG0/LhQFNPwmpJ9ofJyf8FoCSH9ge
	GZkCieZ
X-Google-Smtp-Source: AGHT+IEdI4pepJ0Gpsc67XUJYbaNTKPWLWF8rcrYYoPMFigixnW7GmwZkqABabSXlwAAgP0oiD+EIt6sWXBVhtE3CE4=
X-Received: by 2002:a05:651c:4358:20b0:336:ac3a:73b6 with SMTP id
 38308e7fff4ca-35f63aaf3c7mr252331fa.28.1758060074297; Tue, 16 Sep 2025
 15:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com> <xmqqcy7qm582.fsf@gitster.g>
In-Reply-To: <xmqqcy7qm582.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 16 Sep 2025 16:01:03 -0600
X-Gm-Features: AS18NWB66p4EO6jpojm9b5RLN9vtFlIMybeWhR0hXcZ5_yUBbI5XWBcoXAB3FGI
Message-ID: <CAH=ZcbCra35t7sxnwTvaw2oQeh6VL719v4Hx1fjDTGiU5Gmh-w@mail.gmail.com>
Subject: Re: [PATCH 00/17] Use rust types in xdiff.
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 3:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> I think we saw that the earlier part were read carefully by Elijah
> (and others may have read without finding anything worth commenting
> on), so should we split this into two parts and start merging the
> early 9 down to 'next' and then to 'master'?

I agree. 1-9 are ready to go. Do I need to create a new version of
this patch series? let it stand as is until it's been merged into
master, or something else?
