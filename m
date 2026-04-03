Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95BA371D0A
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775199006; cv=pass; b=t3VnH14RVCB4702U6OxcOZ0lx4BWOI42btVtnyCkSvxEDuwC1pod40EpJ9rRugsJdu/NjJbrtBqxj2KkjqV5M20XJ7rFhiF77Gz5L+oydPUT+0j3qZc1NslPHtj3gmIj1q4OytXSz+RQ6UJ9P8XEhbHxyb/OIw8Lw814kQlsXmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775199006; c=relaxed/simple;
	bh=sKo9zbT6CmfeXtliwV3ehQLNhetHCengSmJA+A0ZCb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOCwd6pCT7cw17LuY9SPWwIEfsNbuY6T/dYM4a+HxGnzSUKfi/gNDum7vcz9z5HXzwqlZsVJHrXcLBFLSMSDBAzx4MNohr/QQh1p346izF5GAbK6GC15ZFUxnl1DDgXHEajGvjs1bMta8eP/1VoIm92wXababWw+DsjAtxMj110=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtUCZ7eV; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtUCZ7eV"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ca4ff720ccso1387846eec.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 23:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775199004; cv=none;
        d=google.com; s=arc-20240605;
        b=MQuARtkaocJNZ20EX/6O0J7+UBw+g1oJ9d0Fr2yjnPWfIR6NdPRsoFyWFFTLCUih3D
         11dfxQacF+e4qcxJwlGZcNZ8qZjdnmzc67Sw0NM8l7Xf2CzXnQ6/rTDMP3vsFF1dltra
         AqN9le6DloK8WW7k0IG+paqopjx2HC9x3CRScu+9HWl54AkKMKTsGvD+/GLSpGXf9KiN
         qbZTtoJ0WJ4tUh1yL4dJWyIGP3z6r78awlQ4zdu8pxzOtBfDd/SV7+p/bP/5707TAaU7
         Cf9F/6ewTwGBz/TunZkvad2zhNgE0N/x7KUN5DK6uLOHoIiPabpYhCCM6m4KajQIKoop
         d8eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sKo9zbT6CmfeXtliwV3ehQLNhetHCengSmJA+A0ZCb0=;
        fh=QTqNi1NFp5YzmbjCq99ydseCre/5xczYWf7hurM2gKg=;
        b=kptNbF8Vakc0+nLgnt5km+M6BQ6HpUaYudvcF5xkKb7BiWXJ7eqT5Fp3TvIHOqL/nm
         ZY6c6kEwNHD5S5bsA1tBP1vgoNTzgxr7+7Kc2Gv0IkLUY/TeBu1QkXGxC02GKJfrMzV3
         5dncF4YUGK9RUpHzuYj9xJBVprFqsUmgf0deXVNxTPTM5ib7y/vXlEKbsKFVsTcpxRp3
         jgWI20nChFICB2bmHeCipQNI9zuTeHZYuiWqMBRNiMbdUPbkCnRL1abBpqvf5cQhY0ma
         rhtXvTY3EmRX7Qi8MR0VzDdYJSLDQcmfyTsFTK5fB3KQ1abIZfFIqIq5sbfkaViz0/Bm
         gBAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775199004; x=1775803804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKo9zbT6CmfeXtliwV3ehQLNhetHCengSmJA+A0ZCb0=;
        b=AtUCZ7eVXTz2q+rde/MF4+SoK/3NMV92rJpEwdZoShRsnHRYuYgtKQo5o2JSvLyt+8
         dWxWWAbZYAku31YNuqu8oNgHzSoGmddEduy8nA++CCmLgjGNdonQf5gEZ/dzToDO/E+P
         OS4cJFzCq7JwkCr4uG2VarRsmuiOmFIk39SkiHWsvysf5N4sqMY5CsX2lZRwe225/sgA
         OwaU/BoFPeaAZISzVrKRCFJUx0tFYO9cf/w/ppGYi1530VL6EWcczySPPnhznzC+PmTp
         lcZAGwiWmlY7zi2ysfqw/shEE2is1RmfOqgO2rBuH1G8/pGYY58n3TiGiPBGoNN7Pb1/
         TzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775199004; x=1775803804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKo9zbT6CmfeXtliwV3ehQLNhetHCengSmJA+A0ZCb0=;
        b=WW7jXOlpNC0+QobaTFXAXMLhUNBrOLyosTIYKCG0QKNqczvDVq+pHsXosFICJWRgyL
         NuA6C8qyCco7RYLNl8eDtFvntiBcs9skKL3J34q9yKzt9E3r6+OmxjFtWei/OwrZa9Ym
         lrPnJxo60PR7Vkz0gynbcIXz8kRU0ob73N7liLdB3ERPFET2T+gtmXZRC1OgNpFIbtrM
         i1y+1R/g9q0IbUk5xImBVpG9DNoeohCOHNAgN3FiA8LafeHgL2AJf7LTjHDNIZYmQZGq
         Twx80pUGeBn2mWZEIiPYwVqUaR/BWYe5pI1Xn/7ZrCb2COhSFTjcle6evZ0SrctES3gp
         gGXA==
X-Forwarded-Encrypted: i=1; AJvYcCWT7t089Gw1KLLUnpJ8xiH54swEKHE1VhYonAMv/S/IiK9AQ0Z4zScgXkImrq2IKGWJDq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbOR3vpD4OWeClDrBKdm8mbUE5N1njE47Ghtr4/7FTw6wvSKV/
	ymfbvqDawDRDfG9rUpirUv6D/YsCAFMS8s9aUIu2oo2ldcS86rwXOhJnEj4fAnU3rMpbsm6tlBt
	tEvcI2/+SN0PRar2SMxiy2g4W1wkL8SE=
X-Gm-Gg: ATEYQzzz5hRaCJonNbj4Zsh83sZ57KFhYE4T+4O8gxQwjabWEm1Mwy1Of2aJMA+H1DJ
	iw9Wz2DHV8vaY6SmBUJp38jnoZ6BmVutvWhA6PN1mS7Q36KBwi7KIp8l1WIeCI3DCIHhM8DWz3c
	zjDaVqp+LUUm9Lrj97K48fgtNqi7IJO8QJY79gef4J15fMhdbToqYNm7kunennkOcy2FZnnHUv0
	e7jFkqm/sCN1EUGAc9Fv6LLABxXkLD11fVIhGdckC8h6msl4ItHxHs6FmZsj0SpECBsC+EvCXWC
	MHYkNRc2l+QC23fhLZYl2DHl3Gb2mrxdRDSS/AHY0TtwIWx4ieZP9+154T6WrSBIYxy849dcXOE
	LaUk=
X-Received: by 2002:a05:7022:92a:b0:12a:8122:24a9 with SMTP id
 a92af1059eb24-12bf08a83e1mr2034990c88.22.1775199003872; Thu, 02 Apr 2026
 23:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
 <20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>
 <xmqqtsu5xaw0.fsf@gitster.g> <CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
 <87a4vv2ada.fsf@iotcl.com> <xmqqfr5lkyq8.fsf@gitster.g> <CAP8UFD3P2Gs0J1FNyKW2URwSEW4ZaTrVO7cM1V8sG+zzXctbhg@mail.gmail.com>
 <xmqq4ilw2cnw.fsf@gitster.g> <87zf3ld90k.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
 <xmqqv7e9qorx.fsf@gitster.g>
In-Reply-To: <xmqqv7e9qorx.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 3 Apr 2026 08:49:52 +0200
X-Gm-Features: AQROBzAQP6fp12sgK4Pj4Z0SvVp7W2uIGtKZ69CdJU_f1K8wWelYyOtyhccTGIw
Message-ID: <CAP8UFD1N0QHTVhG=FtFV2TbiLPBq5bUPds8=TqR4Rq7kziXg2w@mail.gmail.com>
Subject: Re: [PATCH v2] replay: support replaying down from root commit
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 7:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Toon Claes <toon@iotcl.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> writes:
> > ...
> >> Even though I am on the fence about the need for this specific note
> >> in the documentation, ...
> > ...
> > But to summarize: I'm not sure a documentation change is needed, but if
> > you insist, I'm attaching a fixup patch (it's based on
> > sa/replay-revert). I'm leaving it to Christian an Junio to decide
> > whether it should be included. I'm happy to take it to a separate serie=
s
> > if you consider that a better idea.
>
> As I already said, I am not enthusiastic about the "how about adding
> something like this" Christian gave us and I think we can do without
> it, so I'll leave it up to Christian ;-)

Let's do without it then. We can take care of this when we eventually
decide to emit error messages when `git replay` fails, which can be
addressed as a separate issue.
