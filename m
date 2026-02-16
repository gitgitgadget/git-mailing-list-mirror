Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8388B2C0F8E
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248378; cv=pass; b=JuEGZbC704JD+k6qK5GVxnZX+UtCWNzi4BAOXvcsCQAwtHC/cqTip7+Ng4asfrp6gIbqp8xy4Yu6MzbFM9siinxoWWajm7ibe4uYMYyRMldNK8pLZqkX7wkg3pliOxjnhFroZ0lJbcpuVg/zl0j1zvVhlZ37EDzTjY+kjprpJU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248378; c=relaxed/simple;
	bh=zKSYXCGwrdetHC6Ym2spwgqFNCfTgTT11qqPYuZAznw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLFd0ctyJH8Uj5lU2WuWHYPq1uN7jDSDKUh2egIY4tZGpipjil8CmcpN3evIjgeFoA5xJ5aPUgPipAKleeJONUQS9WH9BxkTR3IXj8Ka4ptITrRKmenuq7ZdvSSzmfFqoctVwP8UDndq3BEE2ZxkD4gmBpcqNkUB8454R9AQKOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMb2dvqy; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMb2dvqy"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-127423bea4bso8903c88.0
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 05:26:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771248377; cv=none;
        d=google.com; s=arc-20240605;
        b=UOUHg0bQE2sr2zqsqC2ZNdjvdlv/qeDz5Up0TJd5H3aC2S46FI3dmBPRFr55gXfRvo
         zDuXjExg5g/6Phj4RAQg3kpSxInL1K6pXfuXoD+ST9pa5zKsLGcU+UuKkLZu1oW1mIzD
         BtEZU2LAA8mjZsQK9prRRxO8xAAjxFB5fyXXrDV7YEFtnJJg71sDPidU9eq1Mzoq+0MI
         zuF6ks/EJ4+ra7p3IS7nBEWSVQPJpkq1V3xloeJAppY/C4xHlf85M+qgWMKSO0azDLV1
         Pvxx+vdKCUBlL0H6DD+c/KZUxEfdOcMgwhYjFAjgaKlyYbc9Wk5EU3T3k6x8prcE6lfd
         pDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=29AQzkuQaSIllIKvNIO76F2YzFi+MxBXCIcWCDrTW7Q=;
        fh=yHvCKuzYKfO3IYdlf5j9ICzbwHKJD4hEX3y04qWJL5U=;
        b=FX1jcxp84iZhwqD9c7faOgeRacrSdb/FxMgAYcp1boq+PkuJRdI4D5VAIIK/iNNF/F
         unux+nQyafbYSXefVUmpjwwb0t0/E2R6QqduudwyPRs8ASPaGlW4/tGYLHe6mEcLN8P+
         rVE8T9AhkUHtghkaTNCDC8nWJBn6YD/4sWPSkS9iALxEjmq6JVCxfqVZ2kA1bne3729c
         j9gQ4W7UVXddO24+FDqldiSBYPxqlBvcN9Z8xI7czY3BN4CJvthUaciBR7UJQgFATx/x
         X+/L8khDI2KKXImjwcGsXlyER2eX+0/wCClchevehP80F+swXWs7i2B2JpXyMNcx7EgT
         cbAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771248377; x=1771853177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29AQzkuQaSIllIKvNIO76F2YzFi+MxBXCIcWCDrTW7Q=;
        b=VMb2dvqy0woSQGk3bUnEMOZ2nsEvUw8mKqFKD+ProR1IcUkbyUpNaS266vupnvZgeP
         HRdqYdvaPvfQBxWGjAVFunHFbWd5uS8Ku712rWd/FStuGZNQTPdGl8htobp4fsoqhF6L
         3pzlycSCYEZmIvFmt+EO3NHZdskDG0I3J22qyIPlH8A2L1gOzXbjrNh1Ws0oI3NgM/Sb
         TaWjpdZivPajOAZOWj6Y1a/0vkCR/+jQM7fbUeGoFjzMzhxs6gErtvzTT4hblH/1G6Hu
         6CfyjZHPsXA98YL/noSU6TOzT0dOWWDCiEeU38huOh8X5ta8cAWlNOwjxTzGQrO7HjOt
         P3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771248377; x=1771853177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=29AQzkuQaSIllIKvNIO76F2YzFi+MxBXCIcWCDrTW7Q=;
        b=Dtx1HwZf4i35FBla70Gcl7xTjusVzwm+7RyF6hlCbr+iYCIeGoiZKBZJRp60sZWLtr
         Tsgx/Mab7jcAm6OLsakqaBTQWA99gwqr1PoPqYKw+NcFWjNAHlPDs6fNfA9hTLCiyN5A
         4PHLdUqfSIEQPJ2YxUrztnNrytmELvK5/IsndO7OcyTci9xt/QGPraICeVuD3h4qkLPC
         p/eYjVZkhFfaUybU/M/ZOo+lb7T0+gP0SGHXQY6NY4kYiyL3ZqfBVCpg6fZTe/a1Wdee
         rPNoy6W8TbNOWqnI7jAulDPOeCpZb6b2N14PyOwP2akRb37xR4ky4lzHc1YC2gAtrKZK
         m6Ww==
X-Gm-Message-State: AOJu0Yzk4cSBaeZxR/8Vay+JtiEaKkhymSFcPnM6CvXXA1qrs/FZMMjc
	Dj/WyzlwwMrfSzCUMldVl6p7tm3q/t63iIDjR93lTISz5W3RuDfnCHKVOBLuubaHZ8TBEelvA83
	TEDz43bFMXEDhWG9cTD2nZcBXF8grcd4=
X-Gm-Gg: AZuq6aK3EyI/c8NU3bKGh61o0vNpU3JjXSE55PBniglglJ9Pxq4UcYJlIFj1Gew/pd5
	79qP0Bra8KthsfYBkUu64pF6XggFqtQ5o2ffRMuQXBPTAmqJRNvBGhoPUQ3Zjd0yx+4dZ5XoWB5
	+oHPjTaeN3UPBfattbLOkJdd4xOXU7ZvyYi46keh76yGtnm+M7Vjh3KYVFeJ5vJNSDVA+KjEVl3
	yV/4LO9EvxYsAcQyEa9L1G6nU7WNC9BoJo+WnH5WUE7NgClMcjHTNUhHjlMESYm03HA4GMTXCrW
	yz2Fadg6JC5gGEAdo0RyotYIbTvgbOs2R7wtJIG7zYvFItch07+Rptyy0rC7pZ9A21zW
X-Received: by 2002:a05:7022:69a:b0:11b:9386:8263 with SMTP id
 a92af1059eb24-1273ae8ee10mr4778472c88.48.1771248376396; Mon, 16 Feb 2026
 05:26:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204110818.2919273-1-christian.couder@gmail.com>
 <20260212100843.883623-1-christian.couder@gmail.com> <20260212100843.883623-7-christian.couder@gmail.com>
 <20260214023509.GA3684377@coredump.intra.peff.net>
In-Reply-To: <20260214023509.GA3684377@coredump.intra.peff.net>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 16 Feb 2026 14:26:04 +0100
X-Gm-Features: AaiRm52140xBCGUk2n5QyvfxvNF29jZvciJ5PeznOZXdI-iy1zobZRoRZfJQ6os
Message-ID: <CAP8UFD3B6ZVdp_YbjEJigiRKE5Y=i8svu5AOcUCvJMxuZQuH6w@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] list-objects-filter-options: support 'auto' mode
 for --filter
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <avila.jn@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2026 at 3:35=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Thu, Feb 12, 2026 at 11:08:37AM +0100, Christian Couder wrote:
>
> > @@ -317,6 +346,7 @@ void list_objects_filter_release(
> >       struct list_objects_filter_options *filter_options)
> >  {
> >       size_t sub;
> > +     unsigned int allow_auto_filter =3D filter_options->allow_auto_fil=
ter;
> >
> >       if (!filter_options)
> >               return;
>
> This will segfault if anybody passes in a NULL filter_options, before we
> get to the NULL check in the context.
>
> I don't think anybody does this in practice, but probably we should
> either remove the NULL check, or you should push the assignment of your
> local variable down below it.

Thanks Peff, I have moved the assignment of the local variable below
the NULL check.

A v4 with this single change compared to v3 has just been sent.
