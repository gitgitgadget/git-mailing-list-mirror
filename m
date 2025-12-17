Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E101D5160
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765957229; cv=none; b=YEn4A1uoK+QR5F/88Ako9IegtEfnYidJDV1zwl6XHs3C0IHaVslzXNwPFznBJaiQNEVqfsnxBO53qCCwJeyoLkZ1LBMgmR4kgI9mLblIyRdSAsrxsJ+CSdxPRaxyi0m29mSMgbJExvMpWtGD2MgW6j1vwAcsfPRO0gnQgfN7fJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765957229; c=relaxed/simple;
	bh=jPliwAe9GbayJ0ds0HLCFo7ZSvHQsWZTp/FYYF0sChw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbP7utRnSrH9MG8m/EsPE25DNIYn1vSeeJQJa1sZ44SdovvCefq+3bC32YHfWuPogWccnuJZUdLRf6RuCWENckGOx2oVU9+fGvR+cRvjHbYI+Q6ESrhjeN0w/Ta2wd0XZ2aaBb2qxLfF9N+EOt4PSL/8pi2UXYYKzemVZKcFwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnneR53z; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnneR53z"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-65b2cc63b0bso3114203eaf.1
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 23:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765957227; x=1766562027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6KVZtOhpu9RzwyyQKI00KGcFtvZEgi9iGU3gqlGbxg=;
        b=SnneR53z3Thzxzgd67RHBdKEac8D71Gzjlhz2c9CyUkQs89N2C3hbowqWmYM9mUns5
         1TO87nQfRaKaB8Vq9RcMnKBahnu3mJxesfuvzGTRemWP/wpigxo63jTHBHf507BmNg6V
         W2eAhZ4I/zvSYchLOr6tA4Q4QbnIKGQkkQfGfoY7mu/rApnBYsfL5jzydasrV1UAs4Nz
         uuSCYqwTQps8fp6QqmGHKXAIatboZpW1QZ28dTY2SUIqx58nh/GKLoOhKDCADE1uXFrE
         eANXZvGwQQMFValpRdqN4MZLjyW8fddipQFELwKjMXWmLfPpO8ZwZuXnye+oz7U9CKip
         ofkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765957227; x=1766562027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k6KVZtOhpu9RzwyyQKI00KGcFtvZEgi9iGU3gqlGbxg=;
        b=HTCumcZVIvF+6exIokDQ9ck0+kNt+Ko08YbwjzG7ioKonYGieWUqPT+xBaxHw60R8O
         9k0V6hF3h7GXtyDa/FZQjMLldGI0spcUHsoTl9sHdbzmxGjTzma8t7XkVrui1ACWPEtt
         Axwb7y5yts/DUldFH8wox3Pn0WXiVAWIIy1whXiaavOkLS0Bx67MQqq3wNKcf/GqZIpl
         fwmsMmk9wPTxpYufO3FMerrjC8fW8bGIUTNooN9x/nrmtgVrxtO2UZQeg1ySHLRuZkik
         KrWh9nwFrmQLkBl/ll7pKsPn5JuDX11/DTpeeu6ZJL0azOmYdGAKugE0SqF1cBV0SRDn
         FusA==
X-Gm-Message-State: AOJu0YxbZNUTmDRTiPOc3SAl9IWHXFt2BikTBAgudtsmum+rjxMYGEc+
	E8uF2n9nX/s5gfa4sJBRFenuq8EZWWFqRzPjiJkWAk4Ua8YrZrd2kUkg8VpYRgaXK2Nfpu1wM5A
	ii4zfYWdiCfzDTWOBmRpS+tglmw+6DChrJg==
X-Gm-Gg: AY/fxX5u/CNGNfRZkx0NPyevSwgc3pvnGehHvN2ScaK7r1/EiKjNah91ID4B+nuHfXZ
	foBAkOvFb3pYrt3YQqKPTDAgFaFZpYjBicUZIIZ4SZEJa41l2M6gWDfSSkVhh41oRsQUPPdihmZ
	21dxqmqUT1m6Wb/E62WxFtuMzDKLYQtnj7nt4P47nEtdmO+JDEmNDtQe5VXlvR5LTnBje92dbA4
	Bj6MhzpHEFBTOqGURcudE8sN/ngL4TOjHJvVHaIVfcJzcRjL1e2/rFauwx/r00ecdPtf768Bfo6
	YOg9rPMOQly/LcBG+D9CQ6mS5X2B
X-Google-Smtp-Source: AGHT+IH2rJoxjhQX8W9/1I7OnKEQAhDNJXkNGqVgxYfTB7z4QUVQpi5IJ/uP7j7jIopkOmfsC3Pyndh6Cc/wlUIt75M=
X-Received: by 2002:a05:6820:178e:b0:659:9a49:8f23 with SMTP id
 006d021491bc7-65b451ff7demr6601177eaf.52.1765957227003; Tue, 16 Dec 2025
 23:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqldj48pyl.fsf@gitster.g> <xmqqv7i62r6w.fsf@gitster.g>
 <CABPp-BFgRLo66P49dzgaS0TCbTKtA9J_Fw17QWQUhsLoFXeLnw@mail.gmail.com> <xmqqike53ea7.fsf@gitster.g>
In-Reply-To: <xmqqike53ea7.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 16 Dec 2025 23:40:15 -0800
X-Gm-Features: AQt7F2orXH6dGzBmZl0wYTQKrzB1kV0ml35xBsmsr85bUOKhF0PlOKV7oVVK6Ws
Message-ID: <CABPp-BF=W_y7KFZBWbsDMAeM8+OWH4fJjfCzavPeaDT6UZoNRA@mail.gmail.com>
Subject: Re: [PATCH v2] commit: document that $command.signoff will not be added
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 8:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I like Johannes' edits to the text I had; this commit looks good to me.
>
> If you liked the final result, it probably should not matter much,
> but I cannot tell if you are (obliquely) pointing out that I failed
> to grab and apply Johannes's edit or if you are doubly agreeing with
> the resulting text in the message you are responding to.

Um, I read Johannes' suggested edit and this patch and thought they
matched.  I just re-read them now, and don't see any edits that you
missed.  Am I missing something in his email, or another email of his?

Anyway, sorry, I guess I should have inserted a "so" right after the
semicolon ("...had; so, this commit looks good to me.)"
