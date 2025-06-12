Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786AE1F3BB0
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749747100; cv=none; b=n0nRq4xAoQK2HAFXuTEHKsW8LBtEVVUcRm5isEPf2pjgsHcmA9qcLCfz3D9EGpqafoG3LR4JTGSXa2HFl5uKPL7G25+MTF3dtNFlkiZ3+XT/PHFuIbaffiHXQmWURp+P2+yhOp2Ipd8p8/qLUlDBos7tY+JxrI0KTXxu7qPNd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749747100; c=relaxed/simple;
	bh=KSG2HZHRfaty4YcM+wd5nZHy6aOcOxw7+Cm0msQT4PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TX5lXCYNg5MrOm0xhhvM4OUf72Ell+a3SDxPMibiitFZT6dSb793F6/A3eW9U0PMBCT/5kH/9OXbaZvN13ZUTQ/ZmSVp27gtaAElEKxyEKjbKfGsSjXYVyN56wQmzuKoSlc4MKQ1dPYPFbT8VmscCs1LMDRSejaOL1uL37wIuoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6U90nrf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6U90nrf"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-604f26055c6so4315729a12.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 09:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749747097; x=1750351897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vIdBLoElDsKguyzjCuIxPGjYsEKj9zSpKkyBhB51aFo=;
        b=H6U90nrf4Bqxpdrb4bPIOs5h4mTt+ztJDreACWt354G117q2gGGEzc9czs8GqsogZK
         ypqX1gQKlMS/9nkNH7PiotoZh7KczSLqBjYY9u6XVZLtHhC1X7IFFNgFOGRgYwIzUTC0
         g1vr13AymvGN61NVZD3lr7aDaSlGi3oruB8EEiuS+4/Chs9nbrSRoVqaWylacErIqPlC
         cmLwNLW2RvMP9nftUnjhiTjuzqY2Jl3OTlwiMEek2btVAAwhqThISKLPYMlxHc75gQhJ
         ZMk8oB98KUlYWL7BxIxTLEcj3R14Rrr7zJULJL4bhtdzmUkSsw/vOxXOCy08OrFoSd0N
         kn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749747097; x=1750351897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIdBLoElDsKguyzjCuIxPGjYsEKj9zSpKkyBhB51aFo=;
        b=SCJcDesygwJ6jGwpOe6i6fW5/hFAe0dLTa5xa/6rSlMc/FkRaLhaKXqSNt5/urrSVU
         7S+FlN8HcvB4iLbKiXgmjItacjfhfpnCszdQ4PTRI6+hBUrgwtlJpCsPnO39Cnce38+H
         uVgde6vtAzjpodV6kKSfcBAFShLNsuAJ052NFbHVHVkmmeHxoCws0+DrorVAlhiW1yJO
         H5PgdlzPSG7a2Zz+SlK8RzTNRPdnemSpkuvu1djnGFtdk7WJDBNA5HchSPlGZmi+NIIm
         GsMVGGBap9eqssX87INJtga4dQ0jccBVhemgB9N1jUxXvudf81DSFiirx+8eTEG5DYZK
         r/3g==
X-Forwarded-Encrypted: i=1; AJvYcCX4At8mTZ6fSLUxWDAA4VOXnkg8XHQ0OFPAiM04F5ZosBGzrTkqRQlXlpB0dqSYcYr0eng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjhYJhxj+60DlFkKqCYqOHI4VYaJgPn8T4XejdZE4U3PLHPXHU
	Z1puXavB2dIwGFvLrhbgzn1y1P0GAQZRO49Cwe9X2EPhv7w5PEwYbQLonD6PGzxOvVafepmu7ee
	KIWG0chQiopoJRpRvTzexZtsvL0/jkPI=
X-Gm-Gg: ASbGncueHbHlUyINep4QwDV9g8i0Q4xAj4uzpqsmrLVdKEeUeM6CW1VS9z6Qr4kdGgI
	y55jomOsJHo7UAUEbYA1uCtewNpNj/TripNYk7F3ATgib4DFT2iA74/VFNz8zL1pC96Fpi/LKJ3
	kkh/d4kkP273et7Vj0QfnDCKnUAPZZ65eqShB0JyTF7gIHNMjRmlWp
X-Google-Smtp-Source: AGHT+IGxjvnpRoBqFNXuwx1CnPtBS5xBmrr7gClCkbQgc3r2ymdeiI29Yfb8gfbqvr4RQVgHNwPbeyPTIO7s3lsiWKU=
X-Received: by 2002:a17:906:4794:b0:ad8:e448:6c64 with SMTP id
 a640c23a62f3a-adea5ae9d26mr405926566b.24.1749747096339; Thu, 12 Jun 2025
 09:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1992.git.git.1749546464346.gitgitgadget@gmail.com>
 <xmqq7c1jmgpq.fsf@gitster.g> <CAEgWtF-fNXaC88FWw5K_3ZpbvQSxAfeuCFy8kkrh_z16vD77=g@mail.gmail.com>
 <xmqq4iwnktyv.fsf@gitster.g> <CAEgWtF_0JzZ24L+H-WoKFGaK6Hho-YYbutxSXRud4SK3HwOYXg@mail.gmail.com>
 <xmqqecvqjo46.fsf@gitster.g> <CAEgWtF9MRbRASg1Jb3n6Ggvh8viZOpyev+OyX5DSpWQ7bMF8dg@mail.gmail.com>
 <xmqqjz5hffn0.fsf@gitster.g> <xmqqa56dezax.fsf@gitster.g>
In-Reply-To: <xmqqa56dezax.fsf@gitster.g>
From: Andrea Stacchiotti <andreastacchiotti@gmail.com>
Date: Thu, 12 Jun 2025 18:51:25 +0200
X-Gm-Features: AX0GCFs-ZhvGTHSh5nOdLXVX_GNrgI2C3rLBSYJx1DfcBpZhQlc0smtL7fQqKPI
Message-ID: <CAEgWtF-uKdeJ_B4WUZFJQ7gziN+GjJ=GVNE1V6OebyoQAiiG3w@mail.gmail.com>
Subject: Re: [PATCH] branch: move multiple branches in a single --force
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrea Stacchiotti via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 12 giu 2025 alle ore 17:48 Junio C Hamano
<gitster@pobox.com> ha scritto:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I may change my mind.  But I do not think the feature should not be
> > tied to "--force" option at all.
>
> Sorry for a double-negation failure.  What I think is that the
> feature should be orthogonal to "--force".

No worries, I got it, it makes sense.
I can implement the revised request if I see some replies expressing interest.
