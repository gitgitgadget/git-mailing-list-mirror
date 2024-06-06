Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E626C10E9
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691053; cv=none; b=aZkCfsIJ2u5+AlhaKoBJiyBDKvaV3TsnyOTvIk8A1nPzgkqZdsDEv1brelez9bx8fQTBccH9mOVyDIc7DhC5khsKXBQ7LitO7ZH7i+Oz8l+2uK556bZ25/nQ5fsJwpqoK2njNVa/mQ0xrFSuFYNA81rindnUzIxavBw10DMqxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691053; c=relaxed/simple;
	bh=s7MthOpz7INKoWAs2q3U7FxXZyGZSZVpNzK7NgLenFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nma0KUeLI+6yW/MAu2pTSRVM1WCRbxyc1RtxGboLzmZZ6kpFlw4a/8m3bTglUSCduJMJ9zyEMUdFvQkZzlo2duZwG/fj0QF3AMcvQqTcIuNXf8haVfDJsWcokQ0EivDqaRVF2rybVINanwcglI45vfYKIjqgRdGoQQGW9YL3kLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9WecKm3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9WecKm3"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6c8537bfa0so113917866b.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717691050; x=1718295850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7MthOpz7INKoWAs2q3U7FxXZyGZSZVpNzK7NgLenFY=;
        b=C9WecKm35XjgV6mfwdBb879X+Fg9WvD9sAcG8bXSuCKg5wIwoPm7jOKOFpIMZWwAmM
         Z8MYT/bRdnestLmsexwJXbW8v8Tl0HlKr6T6/kGEzj5rQTeDUdrga1jilWv3hLUNDCRl
         nbr+viu6y0KT4sq3HmmS5XOxWHSe/YzGAMRjIkpWQ2QTFeb46gmsZr7yfrDokYcRyDqS
         2qCKg/WYGWyffP1RRvj2nwtVO+Erp0EDRrf50O15tksSJQIgsWJFxwUpVzV25fmVmxuG
         iZ+8P5MBTq/4OWKaTbLFiwVC4N4wBYUz/BflMfqFTU8VSMyvYPFcz3pLzn3qZC/X2nsa
         afjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717691050; x=1718295850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7MthOpz7INKoWAs2q3U7FxXZyGZSZVpNzK7NgLenFY=;
        b=UjSSZP8zSzUwIsXe8Wi9gYKlQFfneobjuWSd7e83ua/+l+KMo4QfVcOORmUffyx6Vy
         /Mt6cxq6TjP4EbAEsIIQ6+UlGTJ0ugx691+PoqRol2jn5Q7FFKY7eg1tr+beo27QyoTw
         WScEDI6GmGHmBtVL6gbZAYkbuu+M7YVJU5I9ZEjxo+ZcZBXC7oQ4YfvoYHX6cLwj+6+E
         90kLRmmSApWZMeREL3W1/TMGG9QjyhC7KrTjz3cLvmvwqeu4Wy9xLRaLRV6oJogwKUhd
         eaAe0DIXX+GgfgGXbuN7ZewbyUeFZzcTRGMm15TPyCm85tpTKXLGDNWuO7PDpvuLhhrM
         qmLA==
X-Gm-Message-State: AOJu0YxEiLB3LFwWGA7iQSKMRqNS8ooP4ppznAm+iP3R4q0xgjOkeTBc
	m8xTPzZSJ72saw9r0Ju4B9bYiwwS8KXkFMw65h3uPg4oikkU9SMDxJTqturoTFwpOqtk2JeBxds
	U0C2lkU2uitIuk62bppi4ccIWh7M=
X-Google-Smtp-Source: AGHT+IHQzKMbNhgzil2W6aJLXwCDwJQHWQ57P1hE/qKq7VcsB3HzJATUCtKaCbS357sjcRcrtpRUJL8H6u2emDTxlGk=
X-Received: by 2002:a17:906:d79a:b0:a62:2ef9:131 with SMTP id
 a640c23a62f3a-a6cd56111bfmr5380866b.6.1717691049962; Thu, 06 Jun 2024
 09:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
 <20240606075601.6989-2-chandrapratap3519@gmail.com> <CAP8UFD3SZ6z35QOqDpVowtBKiH53GR_0Ok3Jq=6dvaxaDv444A@mail.gmail.com>
 <CA+J6zkTMgvvSbUC5t39s4U80MAk+og5ENQf3StdJ2-MM82MAZA@mail.gmail.com>
In-Reply-To: <CA+J6zkTMgvvSbUC5t39s4U80MAk+og5ENQf3StdJ2-MM82MAZA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 6 Jun 2024 18:23:57 +0200
Message-ID: <CAP8UFD3xepwyjo1c7LvazpNr-M1BDgUBMbjghgtHbyv0syP6mw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/6] reftable: clean up reftable/pq.c
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 12:07=E2=80=AFPM Chandra Pratap
<chandrapratap3519@gmail.com> wrote:
>
> On Thu, 6 Jun 2024 at 14:21, Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > On Thu, Jun 6, 2024 at 9:57=E2=80=AFAM Chandra Pratap
> > <chandrapratap3519@gmail.com> wrote:
> > >
> > > According to Documentation/CodingGuidelines, control-flow statements
> > > with a single line as their body must omit curly braces. Make
> > > reftable/pq.c conform to this guideline. Besides that, remove
> > > unnecessary newlines and variable assignment.
> >
> > A commit subject like "reftable/pq: remove unnecessary curly braces"
> > might be a bit more specific.
>
> There are other forms of cleanup also being performed, like removing
> unnecessary newlines and variable assignment. Would it still be okay
> to sweep it all under 'removing unnecessary braces'?

I think the removal of unnecessary braces is the main change and other
changes are made while at it, so I think it's Ok.
