Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A9632AADE
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412931; cv=none; b=owOa4bLilaVda1vVhPD5WxQO6kLIG2gQ7k8D3+ZdUFzbnZ/JYsSQxRjX7DlEZ9DqrZcgFUXKrItu3+6/8cMVcZwECjwT4KGIoaHXOgZ/sGm8Fq5eV1qW0q34xeY32zP7KJ0ESQEDA3F1Ob/DS5bbghaUEkI9KqB1kN8OdklVOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412931; c=relaxed/simple;
	bh=Tl3bNOyV8ZQkjOqbW2hyUuE08NClK0499YxapeK2bNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+xMTmP2B41DLij+1LISZl9xsg5hM+XTKOiHASNcpYMgd7C6CJjqs1VmENwyq0h6kP8C9XRzyQKTufH28oVyQL1v0mSOKMoCUqeImag2VE4rpI4asWRTBNBWqneI3vqsrd7QhqhrXTeV+x2qo35Nxh0W2ea6InO5vtLEBD27G8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H27zF/A4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H27zF/A4"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b6f52eea8so64017e87.3
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 09:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768412927; x=1769017727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlXS+rIByA26DE3ilWLVnJ3Sk0HHWYyJJTGckJxl3F8=;
        b=H27zF/A42uItki4fIAxD4iLdAKJB5xvAF36coKjKex2e2NQ0rJyE2sqAucQ7frcCYE
         wY0vp8Lhkk45MEbDmBuct+zSvFAzkVL5vw3Nm2V0KBgClDZNokuhWIJ8W32sR3Qo3FRE
         XZS+GHCnTYSt3uiWxqcyFHeEUxMcAJXj3yQuNVUPah00+lrCB7+XV4w0tSdhKlUmZ72e
         RHirnyBaqugGbvFEx3CcBqS0u8W3yUFNNFkw18TfHHZ/Jh3YzujJg55iRT41s9b+S9DA
         Q3JPHyIlUXt8qrvIEiFxufA6M2GKxlaXAMhTzuNJkiTysgfm+1mhGmTgEFqsDW9ZxY5A
         aCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768412927; x=1769017727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlXS+rIByA26DE3ilWLVnJ3Sk0HHWYyJJTGckJxl3F8=;
        b=QVb1uw0iaxq3rUZDuQGgRtwxa9eMvc83N+nQesNeDMil489NAOOo+eAhX3MCxTBv20
         GlV05Z4flaL+HwmEgQPT5LY0mITFlnbep9QsNoKpRrJ/SxxX8C/NHIiIqPebx/22lPW8
         IBd2brMniMVup6zgVxqMZCzIyhQdiwBn1jUCDnJMMRpL8L9iNXzuBnQ8JA8THhxH8pR2
         b6Tjeb7S/6hTLpdjFmjhDO/gAVM+eH32OGxsgQG3nN0P+rC33xaSDgQS92FzHJ5d9wLW
         SexUI9aRQfoJhusulkbCN/pa4hQso550yUAWY7ILMnyS5DAAqFGf9y9Zvo4OMoUllI3h
         0u3w==
X-Gm-Message-State: AOJu0YzScR9EBTE2WBRCF0HP8fPR9s8qGVoiP16IPSuii8X9tsNzOQ1U
	TLMChpk3g0Tl2ypw96b4srlx0fVnMsSkGwCJq56K1v7EkBoAZN39czf7
X-Gm-Gg: AY/fxX5abJZwvLPEoFIuZ1+gbe1JX8HK1f7SThPcS1devQvSUrnaJI1Pq3pPZ4eppeY
	gOSDgZjTpiJWzOrQ8rqg9mFxa9a+PAzBseoeCTxn8S+HL5YciJEwFSO+JBJVoG+aSkz0LHhgnhC
	3P9jZwqlIyK9vzsplyDPfrFnWOiUXLcyrTfwXQktHqM9jf2cNabTSmWe+/ZqxYAvmIMg3q7mOdY
	8Fs170Z42gF5Mpdu7vLlvryNVCjrisYnpRWbaeYqoQS4FXpMUn/tXLq2zHwXLdYXMgdHOd15zjd
	cIIeLU0pHid8pHn1cbqxOYPR2qyLAA6Lyp6iWVRq5hD0kBQhrMJapO8I0MZ/vDG3zGYb6vUOC4j
	js8Q/9umfiVqM5q7fXtImj6K3q0Oc7Ycib2KwEus8gtrTtrBTL0NVrixW1MqrhYxLvjqbQMFpiq
	wAS5dfeoH5BhTstM8ryCENvtyXOZsAdcBm39PFzZbflMvUST/80ZJglQjTK2efOAT/EtHpK/nAl
	efN5IPVUA==
X-Received: by 2002:a05:6512:b0d:b0:59b:9ad9:af44 with SMTP id 2adb3069b0e04-59ba0f883afmr874977e87.29.1768412927065;
        Wed, 14 Jan 2026 09:48:47 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59ba1045c2esm863979e87.84.2026.01.14.09.48.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 09:48:46 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Triangular workflow
Date: Wed, 14 Jan 2026 18:48:45 +0100
Message-ID: <20260114174845.61215-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114162427.GA885771@coredump.intra.peff.net>
References: <20260114162427.GA885771@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Sure, but:
> 
>   1. It is a lot shorter to type @{push}. ;)
> 
>   2. Using @{push} works everywhere, even on my non-triangular repos,
>      because it takes into account the push configuration. So it's a
>      much nicer muscle-memory to acquire.

Makes sense, I’m all out of arguments here 😅 Please don’t take this the
wrong way, but it reminds me of this XKCD: https://xkcd.com/1172/

As long as this is turned on by default then I’m mostly happy. Maybe JCH
and others can weigh in on if this needs to be this configurable or always
on.


Harald
