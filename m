Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB173E2744
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960562; cv=none; b=r0ppqOyrpyYNxKqyoJUigZ9r+GRTENmlxmwAP50kHEn/q6gZ6+LYVN5AZ5UIXWo5kkkS7VIIgasl52Os1MOkVT61HipSbVWMFcyRlm0GBrwtWt+1tQNIyP5RQAawJb+OT4gj53hwLqHQZ5MbxM/L3GRQb+yhJ9YYvR3+rwgFO0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960562; c=relaxed/simple;
	bh=C/+8k+7OJXurGG0ThYV/ryg8zuagmBJ89UThbE6NY48=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=TwQZhvMs95gRttLBsA0xCvQbwj0kJ7dumNUchVL2VJpvXZuoK1WJYnV46oGm2A0BApR05bLYKDdpL560Wi6AQXRN9pfmmHyD8CnH2WBZrIaoyxQd5dn9ZG9Pxe049cJsMojLX02T0K1AmZzdKhRTCR/wrfqlUNpFV3mzk0op04Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0roi9jP; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0roi9jP"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64937edbc9eso7098202d50.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774960561; x=1775565361; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFxSQEM35rrsLagEUiwgf+kxAuu7DS7Qvn7NIJ0nrlE=;
        b=i0roi9jPv/PW5EdAU5+GT0aCwVbrqgJ7MTp2XzYEdNPGBD6ueOEvHnY4wfnkHmUMm/
         cjrqxtCf7aGJ6Vb0sYlHYuvBiWzmj1si36PJeFKP3Mb00HOPdX1wjZphFWA5x4khqyKg
         zttmhZ6DCAWVRPUDNeP/5trV8QRgUgLez5buSHsk6p+7Q+2LjH5U3stw8/mzl3v0ObFc
         jKZzWdumHHYFzo4GAPmnrCi4LN77hph6a95f8+f1zPX0ZFBhIwQAplDxysHfa7T+ic9l
         TQeO4UKLFUUiVDOT5vdqA3tlu/MA42FnPiEtbZsiw21OKlLKASFtKKQppgCgjTo1yo6J
         aYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774960561; x=1775565361;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eFxSQEM35rrsLagEUiwgf+kxAuu7DS7Qvn7NIJ0nrlE=;
        b=QrGJmHoRQLm2hAILLlcqdV+4r2PoNP7Vv1gLHk92TQgTBGTD77us6Ry5ilLT1ree4s
         JFqzdP2kNOpWjk0dd7ZhxeX+e2Y54ROdWBzwXfJHzJbaV6LnNPlI1cFfQaHMtP3ji/DM
         uHqFd8ozkQvBgkVDwYXvYbGPIRrA0j1U1t5EWW4/9Bg5E86dPJ0cO7JhptOFnhfpQCNW
         EDH225gvwmOTZuKgb3NUaB1oKoE7rzr5nUjSRZYeeNaqCdUE6nplwO5CjQM2wW0JQgN0
         RToizarS0kaYk61lLgsWJBHbk0lWY8uuA7CMU7geZDjABwsStTdQhzULmVNtiD1ej/Ne
         1wXg==
X-Forwarded-Encrypted: i=1; AJvYcCUiintjaSctMX13uyZLnjRhg3bMhPkFy5KOQzoAhrqz8fr8FW73oM8EWJnUHEEj9WaNUwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXInJM8AF5/b9OIjWuC6Xczltdf+KxITWKYUtKQEQ7HDj8hrzT
	090W8cSn+qRJfoMeCbG8n4hxbndgdoY6qL2lDbyDS3Cnq1I40q0yvAZ7
X-Gm-Gg: ATEYQzwSgVwDOckiT32LtB2g14cJzEcl1BT8YuMMUt0na0uXMfimRg52uf5dKYD5O1Z
	O2ev4/5GUQ8C+7Z/pQapvYKfVS6HLz+zEVSXqhDCHJhWKVlPtbqD0NGsiHmV9EJLLBN+gKqD0mq
	Ryv+j8SJvWqHF+DisPp+WCVZJaESGdN0GGUA/kB++pt3nFVoPyDAxv7nvj37VxuEW+PCd61BU+Z
	Itu/YIvIsmeYxGoC7YAiOlLdnVLT7DSkOvJgOVrmBe5YQJX4u1SC10Xvg4j57TlWyzGal6MFGcB
	BnNN9I+N4cJuTB7edRUh8g+rBOzgSfPM9on8xGEy9cQ+PzoGqtQ7Ie6ui6pahqWB2uG+NlFJ99w
	Q3NYVftFFXZu1kfLQfVXD040AT/8aEcPgO7tJhAk7/p8w0ZHqNM2YUoLYiQ/b/GJ/MIrujqMr5r
	U3rN9bHFujXnb4a33brxIzwCUKT0AGwABXdfPh4/9/Oes0puhJKfHyI77FUwKMC8pGgAd1M91xS
	AhthhFvPWxb81r/SGu1zeeoHKsyf1C+Be65WxsxIGGMEg==
X-Received: by 2002:a05:690c:389:b0:79a:ac83:ac84 with SMTP id 00721157ae682-79bde04238cmr147517127b3.41.1774960560746;
        Tue, 31 Mar 2026 05:36:00 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:bc53:d54a:1e10:2d5b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a09583f32asm12433007b3.24.2026.03.31.05.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 05:36:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] doc: interpret-trailers: explain key format
Date: Tue, 31 Mar 2026 08:35:49 -0400
Message-Id: <8E736B70-424E-48AC-A6D0-9A8B091D21F6@gmail.com>
References: <5ba0bbcb-25a7-4ad0-ac1d-c86508eaffdd@app.fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Christian Couder <christian.couder@gmail.com>, jackmanb@google.com,
 Linus Arver <linus@ucla.edu>
In-Reply-To: <5ba0bbcb-25a7-4ad0-ac1d-c86508eaffdd@app.fastmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: iPhone Mail (23D8133)



> Le 30 mars 2026 =C3=A0 18:26, Kristoffer Haugsbakk <kristofferhaugsbakk@fa=
stmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFOn Mon, Mar 30, 2026, at 23:55, Junio C Hamano wrote:
>> kristofferhaugsbakk@fastmail.com writes:
>>=20
>>> Just like *trailer* we emphasize these two first standalone word
>>> mentions.
>>=20
>> Again, I have no idea what "these two first standalone word" wants
>> to refer to.  It is not even clear to me if it refers to a single
>> thing, or two things---the verb "mentions" hints that the subject of
>> the sentence must be plural, but I cannot tell what two things you
>> are referring to.
>=20
> Key & value.
>=20
> Something like:
>=20
>    Just like *trailer* we emphasize these two first standalone word
>    mentions (key and value).
>=20
> They are the only emphasized words in the diff. Although I *have* relied
> too much on the diff context before.

Perhaps =E2=80=9Cwe emphasize the introduction of the terms =E2=80=98key=E2=80=
=99 and =E2=80=98value=E2=80=99=E2=80=9D (much like a technical manual or pa=
per may emphasize the first use of a new word or abbreviation, making subseq=
uent uses link to it so readers can find the definition)?

I do find it interesting that the introduction is with an example rather tha=
n a definition. This suits =E2=80=9Clearning order=E2=80=9D (concrete->abstr=
act), but not necessarily =E2=80=9Creference order=E2=80=9D (where I just wa=
nt to get to the definition). Hm.

I=E2=80=99m not sure I have any concrete suggestions, though.=
