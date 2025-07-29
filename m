Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D7D515
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753757429; cv=none; b=Ert/7CLejLuvVSAtW0DbkNA9CasQMCc3h/17/K7N4GsUu7ypDP12cmXDJCZwpM/Ymq5QoS95MPmqeR/5FdcivPQdqqe2OgUIZ6vssUIMLO86pafdBBItgk5Nj615MH+Rxy+59Z/kgFL0FjgLQg6r19joooYDLwe0UnijUYleBn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753757429; c=relaxed/simple;
	bh=m34sJn4EtRe/DYR0slCFlVsbYUEPsho4NIOwMqxIl/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDkPFqc9HlJFscyr9ZU39RRprXZM/pr6sp2WBieBUgUxhM3dfVmvy8RXQhsWmxRNlcYvUS2i9mMNcGEpweA+PREk2tKLssocBCX3R+eX+xuzfIFflmo/sPIUhtuXsIFF1/rQI48G4rIbVARv9uMCp/PzxjbrabY/vx1J31nbhn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=frNKhCqw; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="frNKhCqw"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso4463235a12.3
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 19:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753757427; x=1754362227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m34sJn4EtRe/DYR0slCFlVsbYUEPsho4NIOwMqxIl/U=;
        b=frNKhCqwWX951PX0wOQSoSthttTpB+e9/cinYEtQ+1C4/f6MFirhCV1EMLhyIqxqf/
         0pc18nZcf/10F2MxfJRTV7JiGQAA1F+p8RoKnUBplsczGHXvkmyB7ycPcjZDfc0xOBhL
         5g/RZlV4lIF/mnwsBlsTq7rzh1XYcX3jKrcfFFPVV+m1P7NhwD09jbw1EMZqDFM6Qo3f
         /S2X2sl/E9qrHM/pzXhmYWH9DPXRCf2xuslfXQN6hhjtRBDtR6Ve0LIeQ3oY9MVBk8Pf
         BXGFRIlpL1apoW/6nxSRjTZJrrl1YD1qIEQQSvbq45pjKrVA/s4EYrZPSPg5L2cyKFwq
         9TIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753757427; x=1754362227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m34sJn4EtRe/DYR0slCFlVsbYUEPsho4NIOwMqxIl/U=;
        b=KfE4Uno8vfENmXqkyl8zX5jRHv+4OlH1U46nF1VtekXvfxvzxRry9RwOftEfEx9GT1
         04qPk3HRp9dxef7KqzeyQsumV1QawoLjXrx4bKWHY08CmiKZZWCJyxc33ULy2Y68uGUA
         TTdLpSgVXb3Pl/xPo0VBgV81df6j+XJ1IqcQBkJ9EYjHt7at2+BrdbA/yKAChIsP5udT
         Pfc1kA65j1drfVxYPRqp42uRkkQluuNj8XhqapiP2e1n7yk7pArER8fICEl1ebxXj/wP
         9GKYp6cUuxfKo3xN1J/fF+Sss11T4dD8oNReJG9jpIhDIW6SFRdVTgYHE9rYbNLK/xxL
         fJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdCCBkKywnpiru6aiVcfgchmRUA8lfConoJ8Veki5KvgMfCYbS5d9oU2+2ssgGoigSU3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGGaCl2qrQgethPIj7nKMN3fi8md7FEa2hXQ0IdyPs8KezQpOR
	elfgLBkSsZW25ai1h/0B6kLMFu2Y0EBHILxYSdRVSPR4vzEz72znTO8cKOiEaDgq7xwrOCaDgT4
	qtQwrFEZkoKQejfR+pAbMTOXXPxPKmPF5HFpRmJZoKLumexz1hE0EMx4=
X-Gm-Gg: ASbGnctLPIVbmshN+v7wE5JKWz9Qi079nXAdxa2aKhuBAmAXcO0M8SekkRwvpyNGbSi
	1DFmQ0WzwKGzLYDm0myhnBxwHx4AdnZauXTAHinoxqrvF6ofjBYciN9KI56QjisybA22BFnoTOb
	l3bwPDP9Tx/w8/naSekS9eh4cFdzptEGnHnsnoDHlvw8CNzENPA9YcZhLnFx0FHEG1k9aAfO6Vq
	sTIi2Jr4g==
X-Google-Smtp-Source: AGHT+IHmwXV9M7evSGH9mBeGd3C7XT9XRWxvnovUUENsPP6RIFrXX/NjRp/E4iqrqe85tQPJvX9Bxmqhowk6LLm8CTQ=
X-Received: by 2002:a17:90a:f94b:b0:31e:ccfb:22fc with SMTP id
 98e67ed59e1d1-31eccfb2373mr7905576a91.35.1753757427381; Mon, 28 Jul 2025
 19:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728035548.94277-1-hanyang.tony@bytedance.com>
 <aIcSYs7LxkJeRA-9@pks.im> <xmqq4iuwxr12.fsf@gitster.g>
In-Reply-To: <xmqq4iuwxr12.fsf@gitster.g>
From: Han Young <hanyang.tony@bytedance.com>
Date: Tue, 29 Jul 2025 10:50:16 +0800
X-Gm-Features: Ac12FXxaLQq04twaKigiYNrttZGEdBNSk8qiGAQcWztnkaZn94GDWn71Ug-0kmk
Message-ID: <CAG1j3zHPU_moH51O4i97c7ofuGWiRKunZmtZe2OUAKqAXAKg0g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] blame: remove parameter detailed in get_commit_info()
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Is it negligible but measurable, or negligible and unmeasurable?
On a 5000-line file with a fairly long history, running
"git blame --porcelain FILE" for 100 times, the speedup is less
than 1 second. Considering the total run time is 180 seconds,
I think it could be system noise. So negligible and unmeasurable.

Thanks.
