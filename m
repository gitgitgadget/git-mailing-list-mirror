Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1041802DA
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668468; cv=none; b=qLIKj/UmcPoQq9V7HhxOU5RE+CUdvNML8KRrvQSQpPSYOAQ0Unj8lR/qV0sduz71x0vFmdXoss0rSLytp9WmV9nbKefYTpS19eg3LQG47DY3zGCNbgEw45PFgDAp56cvolqaP9bJTO3pWwpQeM7w5f7T6n+FTyODTupM9OGaWH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668468; c=relaxed/simple;
	bh=5q64rw4FayUkjOSj5kkaS3YiCgKX1HtMXzwc68Z+6mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2FvIs9ZxqFRVJZ+DXW+eIlvy1jhwUKYpfJ7xSP9zZLKp0NLtDTnhF6ZNMRQCoqFMaone+AyZfrnvS0XWEjLYnx9mBg/X+d5SRgs0Z8r0BY3LMtfyv7BtpjQp3CN3Nf5t71ENb9bZJqUP+fAWOWSz/YuQ45PkLHluN3v22m1mpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEBKJSIk; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEBKJSIk"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-80aca73c536so230424241.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717668466; x=1718273266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q64rw4FayUkjOSj5kkaS3YiCgKX1HtMXzwc68Z+6mk=;
        b=fEBKJSIk4ltVoLXc+NjnuD6YKDO+LNbnQYUHcOSHbW4huFqc3MQRcNksiZMkW/IZmP
         /WrYAkkZHFghEnOQ5+H3YHl3yB4me//c+Mqy+WoISB9wdVoI2X1NnpW9Wln4TZ/MBk3l
         YhgjK12pnFXwFre5uHD1RNoiOoyzYHTeTsTU5oztMFwbNWXJKRylpw2YKdUTOgQnJ+1p
         fo5ewM9Jou2XIc018eB47MM98TAhRkt8jVZkmv+2vZLqeJiXyk17dVe/GOtWmL3bEn0g
         cKwuVSEN6B74dhUBxZu3b++8v0Fs+K0UfgOQ6Ejac5kV+6ZdVmbMp48hJQ8XKUZjzLb7
         55qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668466; x=1718273266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5q64rw4FayUkjOSj5kkaS3YiCgKX1HtMXzwc68Z+6mk=;
        b=YzidBBs+Lm51gMiQyYaZmxOyQEGNoYHNi2zG3nLnzVz1vYVC7FU90CVLWMyobw2z1W
         xRLka3wBKBwUed4YT9J38CRUrWrftbftx2Ibis+Y7MHS5SesRTQuF0JbCctz69IDUtfw
         6P0+iuFe9Ke4F2nfk2i+11SRO/jzRt1W5jWkEpVX028HxoAkM15XTXysz6dX3RWlR10x
         QzRWS8vUt03+qLcfLFm58fV1H9p1QENo3WJ+aTx/g8LmahBqP3klqUE27M4Lq+88dTKN
         GIsGrvidWjjNTh6miXTcDXKRU7NZf5II6H5MQfGS5oEag912IX1Je4qPFLojQmELgU+J
         3k3A==
X-Gm-Message-State: AOJu0Yx9ftayaPLzJBoFeXZr212CdNLHDajET2rgw/fC+LiYGcBz15UW
	YlTQ8u9ZJe/MBegMDXxLWKDz2l0VFnJfry0UbmWI526n2JRghQqJxM3XTnFnbD8UWW1wW8Uvfzi
	7DWsMvhdmFgJP70+JfTr4MT3nCqk=
X-Google-Smtp-Source: AGHT+IF0gsQ9uY/KZPa9QcFob3l3O5bFdikMMGqXwzfa+vc1U1Yl+ujvkWqJCmJ2rPcP4BTIXBObuj8vpxDIQtkxGHg=
X-Received: by 2002:a67:f28c:0:b0:48b:a807:2fe3 with SMTP id
 ada2fe7eead31-48c04ab6b35mr5563983137.32.1717668466206; Thu, 06 Jun 2024
 03:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
 <20240606075601.6989-2-chandrapratap3519@gmail.com> <CAP8UFD3SZ6z35QOqDpVowtBKiH53GR_0Ok3Jq=6dvaxaDv444A@mail.gmail.com>
In-Reply-To: <CAP8UFD3SZ6z35QOqDpVowtBKiH53GR_0Ok3Jq=6dvaxaDv444A@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Thu, 6 Jun 2024 15:37:35 +0530
Message-ID: <CA+J6zkTMgvvSbUC5t39s4U80MAk+og5ENQf3StdJ2-MM82MAZA@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/6] reftable: clean up reftable/pq.c
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Jun 2024 at 14:21, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Thu, Jun 6, 2024 at 9:57=E2=80=AFAM Chandra Pratap
> <chandrapratap3519@gmail.com> wrote:
> >
> > According to Documentation/CodingGuidelines, control-flow statements
> > with a single line as their body must omit curly braces. Make
> > reftable/pq.c conform to this guideline. Besides that, remove
> > unnecessary newlines and variable assignment.
>
> A commit subject like "reftable/pq: remove unnecessary curly braces"
> might be a bit more specific.

There are other forms of cleanup also being performed, like removing
unnecessary newlines and variable assignment. Would it still be okay
to sweep it all under 'removing unnecessary braces'?
