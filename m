Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8ED2367B8
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751945763; cv=none; b=hFKtikEgTVWSFbyQgaSgq8kiEQ7/hOMWkCEVe3EPUz4sVoQtqeqxsqKmf6lqreZm0fGquO3nJPVGQHHGtKZxey2xeLy/BPfytvN6yXhaZgrW1edNsyKHdMqdmP6PQJS1hHufp65n1aw9LjQE/aDtolZE3fRWm/JuDOS4R5V9oqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751945763; c=relaxed/simple;
	bh=mhUtlayzHHke+BYXgIXOZcYXlg1Iovm4U2EyW1rff9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDB6wzllq7IQV0bRIceTkflx611Jsiosa693j4Vt2iMIB+CbmCOeJcC6LjH3ixO9EZSE0rBo9EJxusp8P6EQYDu954UK0F7RWKI6gvLqo/UyzhMSuLfrpE+Tqdwb8VrZmtzrAI5HriAgf7YHVMBqlxkhu9JGJdSGq9ZDJb+0nU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxS8HXZD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxS8HXZD"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so609338066b.3
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 20:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751945760; x=1752550560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9l6GzhybD2Bj6pkVrUAMbrA1lBmC42X0P++HjPM2ok=;
        b=PxS8HXZD1XnbEvX5oVQ+HkxF5dc9AhZ6pLx+/je1//3U3F2B5Pzu9s61dQmFjWe7lc
         bVlQm6tOxqHcEdA6CthCuUgVry41cBkrQs4yTL8FN9wNPN9YYLARqpGcAyhiY0c/w3A4
         QwObw3+kgw1C9JbF/8fXIJaC7xm2jyPLkGCLjoJ4YOJ0NMkqleFyA/RkjAy0dPreX+5M
         zFm54RmJSAP90mGup1T2OtwJKIdT8/p2Tm54WTTtr2VvIR1KJY/Qzpem2vS1y4nctzpN
         tjNIDatu6jwgjaHEqeb9Y8UKrYDQnXsYLag5tnVXu/f0/bhZs3TQUw5AZbydc1yNNjG2
         jXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751945760; x=1752550560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9l6GzhybD2Bj6pkVrUAMbrA1lBmC42X0P++HjPM2ok=;
        b=ovnAc4vJEhRA6CU9ScwKfpJ6yotuzpqG32v1/xeZOd3HoVfVIdRlBSvBdr3ylzXht5
         aXT7NXdMdwSyOfQa1969bxctEKZ9VjqnbqtiV9puBYuaQsO0ivrARv2bq1QyqxMBvU3R
         BSimn4uoNuNgLA4FM1RguJ28bPFOafpb51kiQGP0x2OBIpLl4PmRnrXoKq8015pUZitL
         1IXt5r2uhys/wazRAnLfc9LO3PhgH2Fh5BYcgdu7woL6mdEIk1akljye+oLJvGag8IXi
         wz4eeHpDN4X67HCFKbn5pORd+yUgofM80lDkWjEHbYbphnQ3cFAMgS7WiirEjtTQeli+
         +ayA==
X-Gm-Message-State: AOJu0YxaCpPfDXl5Df35Nxmqktj9mL5lizlHBfy+ZMUeU3dEeQW5pjdu
	gfv4sflg8GI6sOhqwSRBKkFZIPPL77sjYY4yeuqMlIPYcxsJFRioCTjXEwyAe+g89eO3bMjVmlr
	xeTxSv1TNPyplNmYJH6LtCUpy27DH6tU=
X-Gm-Gg: ASbGncsg2kYOdXTpMzb4pZmpxC9FYslXc25ijFcgfHvu6S0PiAL437PgLD3qEZoolGe
	LzhdMEUsFzSP6MM2Xj1m/zJGSXpjEBMHLlLmXy7RmDvEqW1a5YGUM6ckokWENX3WaS+BWXZBE7H
	5mEJxNqzYIqQE2oSoyfIuM36JPx1ALnW6/tYr+Yo4fyd1QBvQuO3PPnlmmCtPQniMPvlTXQtYJ/
	g6jWwOP47n2jmK4
X-Google-Smtp-Source: AGHT+IG6BwQOjUDqsjtE91cYc/jSjkkb31pjEixJikxVeky75C1daFAXEjCNhDRMJZm7rSE+wCXuJJdZ3jxqeDHy2tE=
X-Received: by 2002:a17:906:6a16:b0:ae3:c780:b883 with SMTP id
 a640c23a62f3a-ae3fe82d4d8mr1541583466b.54.1751945759611; Mon, 07 Jul 2025
 20:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618151821.528627-1-christian.couder@gmail.com>
 <20250619133630.727274-1-christian.couder@gmail.com> <xmqqbjpv1ucb.fsf@gitster.g>
In-Reply-To: <xmqqbjpv1ucb.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 8 Jul 2025 05:35:47 +0200
X-Gm-Features: Ac12FXyp-791Xhz-u1wpOrHOwQKAzH8qFAw7A5nG4v7xHAwsmrSW-nUDVsdfv3s
Message-ID: <CAP8UFD223ja7jKU+wb6TiGkc9frh5dt1rCJkOkk+O+J2MPokrw@mail.gmail.com>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 12:58=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > This v4 is just about fixing a few bugs in the tests using the SHA-256
> > object format compared to the v3. (I had issues with CI tests on v3,
> > so I sent it without waiting for the results.)
>
> We haven't heard much after a few comments were posted on this
> latest round, since Elijah's
> <20250619133630.727274-1-christian.couder@gmail.com>; I understand
> that it would be the author's turn to respond (the response does not
> necessarily have to be with an updated iteration).  If so, let me
> mark the topic as Stalled in the draft of the latest issue of the
> "What's cooking" report.

I will hopefully send a v5 later today.

Thanks.
