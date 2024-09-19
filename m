Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305C19F43D
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726752214; cv=none; b=ZlfUi/cVP3CIBmToV4fW4+485t1t/um/A72y20xp+7o3Th8NitKUGvoA9UUX6lknE42wcdXhfqPU9wa0ldWXdBF9VJgRQmrwV014kKmRRl8akymYOJkRoO76RP1Lr7bdmPNEOgh1zq1id5mhCa9j6OWAPOlyonKBBot3wRCU9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726752214; c=relaxed/simple;
	bh=b1UrfUZXZ0NNMzhOPNbRO4fai5+hOhfTHGx7zwaxe4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsfAyM5A1Z0RADW60ciigZYg3SoFU0YKyyaoAeMKHxmW7C1z2S2i2Qy4ulq8Aea4R2I40Z9TPT2MNOoNjvfpxSbmWr7u6I6snIBEporxeUY2zD6p635F1JN8eMyqj+FJ/cPVyc0uzpo4I0v6FE6JAwnnvNYKvzjuCb85i8dVlRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=precisioninno.com; spf=pass smtp.mailfrom=precisioninno.com; dkim=pass (2048-bit key) header.d=precisioninno.com header.i=@precisioninno.com header.b=LLe5I3+J; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=precisioninno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=precisioninno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=precisioninno.com header.i=@precisioninno.com header.b="LLe5I3+J"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e0719668e8so360201b6e.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=precisioninno.com; s=google; t=1726752211; x=1727357011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhoCjjngRyL/Hzfd5fWZEeq5eG6crNKzMn93InqH9No=;
        b=LLe5I3+Jbdva5GxiPU4MgiMnD5nX6KMnDXbi8eKLdJiXFHihR/qTGqnu82Y8/kFQtW
         b6qjPjDa/IGJ1fp4XjOz7VbP5itFkrGapJ/Co7BATL6kwISabm4g0geHevMOifN5V8jz
         TQWPhB8eKdwjIOVtromoZvKrxewNcJApV9v+U2g6sITkp2TXydPvOu/ShjS+UxSZGTHc
         6Hycw0mKD3nw5d9GxUxDme2qWBvWn+dxiW8TVtjdS4rj7dlIvLzfLy+dt9h7vbAI187J
         +JceHY2nu5NJ0EFqU4U51o7iQ92i1PI5RndLu6ogHWGHKmTodZrD9KU+bMWw1PB7RtOj
         ITZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726752211; x=1727357011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhoCjjngRyL/Hzfd5fWZEeq5eG6crNKzMn93InqH9No=;
        b=rFac+7IzP501S1/NPQiSkCqEy7R/hk1RvabwzJac2OwT33smKgL5AB2rnGtl5ab3Lz
         V0Zd5Gpg0+XjH0txPhDni9u68BdUPtNzM0xkjcAf7Y/ugzibCruVBpL3Be+PtH4d4gOE
         8+BVeEmj+Kad0iqcb3EwSOXAWQMqZRTz2LfXbegQ0TxqnAj8xQmDKZ79Lzt9x0mI9y4Y
         Y8GkCX222NAMYRCPuK+XqEmS+1iGh5MV+sLi/k+hJYIZ3ZE3PStjXpXRLrdcenpudPen
         JmDKJF9Dp8NPPf1iCyuNshck2oYNJH87WRwOmwWnjto6W88woXTggBPGvL0MeeDWB5oT
         bf5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVPyRXBaZgW1PBeY+rENMSEBjM3YqlnJETrIGSvggVO0TL3QKrUWRTM0JTzT3xtrIFkeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuuwlt2su68OxPescZF1Lz7jeU00c3HuNrakAzjd3RowbBMudE
	WGuv3tPQDTphGT5ffgCNP3exVDfX6VbKK5Hszsr6kKGgCYxYgNY4V/B+RNghWmbL5a9lsLvVQDU
	p9l1DdmgU/pb4iBm0kjenRtqGEufram4BA/9cxA==
X-Google-Smtp-Source: AGHT+IF4HAk1jj+S1SQsxU4fRRYvuePmiNz3hvgPkGZfbMEuBzuHEdjMUFkklx0DGNpyGR+TwjIlTVrSCbzXwpBAjQE=
X-Received: by 2002:a05:6871:148:b0:260:ee13:e665 with SMTP id
 586e51a60fabf-27c3f646b11mr16981914fac.37.1726752211471; Thu, 19 Sep 2024
 06:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKDm0rNaHbzoiPg=DeuCoxzooNAsxw2BJfc0wg7fC_-=o9uJ7w@mail.gmail.com>
 <7b4ce2fc-3763-4881-8459-e0c1f2cbc69d@gmail.com> <xmqq1q1ga1dp.fsf@gitster.g>
In-Reply-To: <xmqq1q1ga1dp.fsf@gitster.g>
From: Matt Liberty <mliberty@precisioninno.com>
Date: Thu, 19 Sep 2024 06:23:20 -0700
Message-ID: <CAKDm0rN-jvtmVhwODQTcQJu5LYTJ7GwTKUtfA9kzifHR6WWf9w@mail.gmail.com>
Subject: Re: fatal from submodule status --recursive when used with grep -q
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm saying most unix tools do not error when the pipe is closed and I
gave 'yes' as a simple example but there are many others.  grep found
what I was looking for and I don't care that git didn't recurse
further (in fact I'm happy that it didn't waste time doing so).  There
is no problem except that git insists on complaining about the closed
pipe.

Matt


On Wed, Sep 18, 2024 at 6:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > On 16/09/2024 16:08, Matt Liberty wrote:
> >> If I try to grep the output I get a fatal error:
> >> % git submodule status --recursive | grep -q "^+"
> >> fatal: failed to recurse into submodule 'tools/OpenROAD'
> >> I didn't expect any output but did want the return status (0).  I'm
> >> guessing git is unhappy that grep -q exits on the first occurrence of
> >> the pattern.  I don't feel fatal is appropriate here.
> >
> > I assume git is dying with SIGPIPE. As the only purpose of "git
> > submodule status" is to write the status information to stdout that
> > sounds reasonable. If you want to collect the exit status you need to
> > consume the whole output so that the command runs to completion.
>
> Yes, but isn't the main point of that complaint that "failed to
> recurse into" is not a good way to say "because you closed the
> reading end of the pipe, we are aborting the operation and not
> decending into 'tools/OpenROAD' submodule", is it?
>
