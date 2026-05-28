Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80AE3CE4AD
	for <git@vger.kernel.org>; Thu, 28 May 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978546; cv=none; b=T9FIoLo+/pUgNPvbzz86fnYIm4EfmBlqKKY6wS2rx0iAWIsmJkVn5bnR/51a0OesS9+7Q4MKyyICWHoFfTSYzZseV06lB8uvajjqiJU9jgHLW60kfRJom2VlVEq+iwWeq3Ac5FLfTZ4TakmcUdZTOpg0alEWHJu+SMz4+9a82zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978546; c=relaxed/simple;
	bh=xgEzEwCIug+9XYyZenVJMtN9c5cgU+x6b4/6isP+nbc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=OWd0BkiqmizUpRzKMeRbcMhvmilw+FRPgQvTdiWKQxecWapTSWZaGao55wmRK2bIqNbMKMhcWXuzKLwB5DVSel9CyneE3iF6yoc8F9EmUpCuPBTMCrhFy1rsbyL+IrZzS+qSJBv+UbvGsSDRADmXLGRrG41IbhdKbSH509YfQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxZ0fot3; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxZ0fot3"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-914b4be9c4bso605141885a.0
        for <git@vger.kernel.org>; Thu, 28 May 2026 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779978544; x=1780583344; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSAUZW2ejVH0RfwWXoY0z2H8PKj3AHT4keeSXjAXGAU=;
        b=fxZ0fot3zXSymHNs2yrrakV27HO70nG1P24FqP4LZPObcs6xltvIl+rYmR1sBz0UpU
         cnWXjl34dCu/zq1vuh8i397Dr37oaLmrwmee3tKZNv5eQe5hCgR+GNsqM6Kv0kVMuXHe
         5UfyGUSw8x33hH+XMoReYABXNJBKFtx1IBEegOISYMOraxFNnP9vQPhwr4xqpDPTAy62
         PL03T8YOrgTjs+RKX8OP+DQmhn73LIpoSGH9dBIdDKnUaY984GW7ip14vOn9z2TSIkKD
         jjmyUWCrDW2nOsPa/u3qbBiLYY4LK2oyUV3WsNaRV9tFSWvawXvDVUkCP37GWeccf5o2
         6L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779978544; x=1780583344;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dSAUZW2ejVH0RfwWXoY0z2H8PKj3AHT4keeSXjAXGAU=;
        b=dOS7CeDyTbzialUEHo3omUV1MYC1gFeBz42EmLlaUh1uno4wAwffhvmtZ0SJlR46Sk
         DreUmwDCSOx+bETTgGz2WiPFMQ1K2aQvKU1++N6ibRSeHnHeVOz4/w2eW3ZOO4POIAvs
         3h0ki2BvBOi/dlTye2zwOgdVoIyZuDaj44SwhcKgXnR+X7aC7C56SPf9IXA1fpmBVyH6
         lSrIugD0fJUwrWq3MWO6lpOzJcNuukBCUxqJSP6eDkNuYVru1N8l4ZvzyxGH2mGiOHoJ
         ZTQ6/h1bQ3W4+SSxcbwbQsvRnAj5twFSpzzEBkQgkdElUHpl83gunT1typ23V1JQI+Wq
         2b5A==
X-Forwarded-Encrypted: i=1; AFNElJ9ozM7ryrZZi4iovEWvZpuH4Q2485pSdV5LyjjD9kau/iymC4sIT//ig7K5jyf2xT53hrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDyTgHMa7d5ADPuPWfYJOQGW4BZvDAmu6jS6cONmF6syiKFJBW
	mKzO0ijPMOk/3ea2LOp6wlfFitGaxWHHKdhudRKb9wdSnOebeRx+vRSb
X-Gm-Gg: Acq92OGTlkzH17Vw2FpNH1WteXKcGg7zobCABi2j6VvseN4lTuaYNzVByxOFfYJEWxN
	w2nWAyQtdlwk5BDalCtZAl/t8utdbZ/aSv+WtWzcyZlmqKzN2d60nHFgO5nGjHMQ8v8njogGVrp
	+N0sIu3If7fCyljVg54bYdTHury52ApCLyvFIzAb+8DtrERL2gNNfPs0Q/OLhvBLv9rYe/LoCLF
	bwoR0f5xvP+RLsjv/zlwhDFZHZzbvdHu/CCd+3Aa2qH0cPGfHlyOJ31xiTAJT1kpROXbbvkyBVK
	QTiL1FFseqdi4hdyaZjsCbfswUKq+tMZdfFvaRUjSvmd+69Uo12wph2LoqQDXulcxYvcs7YRJ1x
	aueclR8bFbRZFvuG8rXqYeWQ/KBkBHgpkwok5MIaaL/l9ajeJqQhfI7dRErIUjUfoCzWU802rnc
	wdOx42y3uXUR4+Q4T6imUQqK4k/7y7qS8EuwDD6OL3WCcBPIvKhe8+tCxfOo4n6RVM9AX1mPahr
	svWa2dBwD1DVVKVgd9Dpuv9rM8gVCLdyq5kyoAXfiMq5wLo0v2pqO4=
X-Received: by 2002:a05:620a:2b4d:b0:8f0:5793:ea80 with SMTP id af79cd13be357-914b4934533mr4067304885a.16.1779978543618;
        Thu, 28 May 2026 07:29:03 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b0c1:ccde:c24:287e:ed2e:fcc6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8800e1dsm816892185a.34.2026.05.28.07.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:29:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: git mv after the fact
Date: Thu, 28 May 2026 10:28:51 -0400
Message-Id: <1FEDBC47-5DDB-4C42-A7C7-695630D330BF@gmail.com>
References: <877bootp3l.fsf@gitster.g>
Cc: Chris Torek <chris.torek@gmail.com>,
 Frieder Hannenheim <mail@fhannenheim.net>, git@vger.kernel.org
In-Reply-To: <877bootp3l.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 27 mai 2026 =C3=A0 19:24, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BFChris Torek <chris.torek@gmail.com> writes:
>=20
>>> Chris Torek <chris.torek@gmail.com> writes:
>>>> A flag for "git mv" would be convenient (and slightly moreefficient ...=

>>>=20
>>=20
>> On Tue, May 26, 2026 at 8:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
>>> May be convenient, but I do not get the "efficient" part.
>>=20
>> A normal `git mv` renames the index entry and the file in the working
>> tree without running `git add` on the *contents*, so there's no new hash
>> computation.  Presumably a `git mv --after foo bar` would do the same: ve=
rify
>> that there is no existing `bar` in the index, that there is an existing `=
foo` in
>> the index, and that there is no `foo` but there is a `bar` in the working=
 tree,
>> and then it would rename (add-and-remove, really, because of sorting)
>> the index entry, without scanning the working tree contents.
>>=20
>> In other words, we skip reading the 3 terabyte file, or whatever.
>=20
> Yup, that matches what I wrote.  We do not rehash and we only write
> the index just once.

One thing I wondered: if we don=E2=80=99t have an exact move but assume (by n=
ot hashing), doesn=E2=80=99t that mean the index would differ from what=E2=80=
=99s on disk? I originally thought that might be a problem, but the more I t=
hought the more I realized that=E2=80=99s a fairly typical state anyway.

Just seemed like a potential footgun to me, but perhaps not worth worrying a=
bout.=20=
