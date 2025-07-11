Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EC710E9
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202161; cv=none; b=HxMviGX22TmoU52hg5F/zWdeCqYvg/Ch9k6b9U9tD4pQhiFn6VJ+owQXesQrTwx39tJAQ/mBWgXk4vGNow3fhiW/qBdVw+2Rl2cv1k17RgAIdM2PT+EjH+uz1kPNqk4kqqlrS7jRmeFs4TWhNjo98VSKLs06wQUhr1cq/JfMEro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202161; c=relaxed/simple;
	bh=aEqEX7DuWn+AVOMSZ8zvunmu6dzijvg0+N0okhJ81PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyX8kF7jxx6o717q40L53pZ4ffAufoe2EQp8WY7CO10Y8BiWQGa2UaqE3PulmcDuw+Ts7O8R4o23tUsupPL71xNTL/bh01KO2vEZADIjorQ+TtPFKlX1q/PJkpocFuQlBRZdTUmfP/T7MBQHNj0eXZ7MroOPizGbBptCub77r68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kF6aP+gk; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kF6aP+gk"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b350704f506so1384898a12.0
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 19:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752202155; x=1752806955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEqEX7DuWn+AVOMSZ8zvunmu6dzijvg0+N0okhJ81PI=;
        b=kF6aP+gkQCVbrX6ZQOkjYJu/YlxwzusXau1rvB1gGOD0GMMCJd8qXRpY1Sv/Wojrgw
         67NDRX71+z66wwjRhBwp3llVNP6/gSELQhbaRCzNzatmkG+qltdTgRvICkky2o5XPpod
         lXnkzKw2/b6/KYxIs89eDxt3vfeENEJrzros+l10gaQ3gzXA7lVAYMxCbeiBMCgG0+LG
         Z+tQjeEmQfFbm6VnYTkWlZb7HqqGE9kyMaXZZBTdAbW6e3gAnRaDt+2nVrA12/1ToeCa
         tROyuUPv7rCNH6aDveRAuUhghvgnXGWQcxhwDvyYD6U4IYtQKbIS6B2QAuNRSe9Z/9e9
         bdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752202155; x=1752806955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEqEX7DuWn+AVOMSZ8zvunmu6dzijvg0+N0okhJ81PI=;
        b=Q/uoYFRhfyNHfU9SPw+g5USxHu+LH0tXq0zX6n+uJjLP7fMw8DGTJaTDzMiBZ+109h
         wJ98Co+3k4I7lxissguuIHFzGgrX3R41ucIpG8UixWl+QaivxzLZehyNMTzznMhapROZ
         aFV85OizUgiXmG559MwarpRAbiJDNOxclon3nC72yc3/w7EaNk3EvAZzi36sJagrLgnf
         Uw1jvA46Z1E2r1NWpnC5JSO4UR3MFCYH36MD1PFz6+uh9RaAc37Z3wHL786FHxx/DKUo
         pabjaaG75m2hFIm3ItQU530yqtlLrm96ser5eyGmWzJKQuMxrWXfJz3Oli74z2B09jy8
         +Kgg==
X-Forwarded-Encrypted: i=1; AJvYcCW5fOBzsJqY7Tfc0hixp0XGAv7HRf7CVfQJfszDXaD0R/bmofV6hTgWT0CEM7AygGxafJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH1OcyN42Ehv5kzJdD6cSgkX/aAvpfT2NTAjpC8bQLjqBSBCRw
	e8HmH892jw8w2H94hqOXL7g9OgBKDLkwxRFG7NzyyO83qWmXafruCZ2P+YITUm9mYCe0FqelAe5
	trzgkbjPwAz1bbkSxK2zYspLc4uNWpy6+GmWH2oyxIw==
X-Gm-Gg: ASbGncvyd6EcRB882LyG1qFIBalGO/GevckIzFvTfZ+cl/gTOJ42aBqnG8h2bE5lGHw
	fDf29LxotsNzCUnArScKaww8gS5GDbadAWVs16LVssMNtocdna3fOFdrHGU63vUA8990QpScUH/
	VsDJVstC+7Pw6LDkeTsRK03uvejQAtyUH5ctYgsDzepf54lxL8q087oRWSQtOw1AbthX5bmVQJp
	j3zdqhpOQ==
X-Google-Smtp-Source: AGHT+IGbwoJdzxBAFlcsfPMySJKcmLGyoCP/RcPKelz8za6C/dZHYiOiHN7KtPxU7gaORpzrUItC67FBK3X13gNry5I=
X-Received: by 2002:a17:90b:2e47:b0:313:f995:91cc with SMTP id
 98e67ed59e1d1-31c3cf1a3d5mr8593936a91.2.1752202155049; Thu, 10 Jul 2025
 19:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
 <xmqqfrf34qdb.fsf@gitster.g> <aHBH0nRLPxBg2HAj@fruit.crustytoothpaste.net> <m1h5zjk4pv.fsf@gmail.com>
In-Reply-To: <m1h5zjk4pv.fsf@gmail.com>
From: Han Young <hanyang.tony@bytedance.com>
Date: Fri, 11 Jul 2025 10:49:03 +0800
X-Gm-Features: Ac12FXzfYjX3gOUTerUfYxyiifvFm3RkoLvrT2eAHD5Y8ctOtK-55Nl7P9IuCFc
Message-ID: <CAG1j3zGn5fS=_Oftu7bBmWsoMc-aCa84AtDXdfxgL8QFEkp+yA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/1] Filter C and POSIX out of Accept-Language
To: Collin Funk <collin.funk1@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 7:26=E2=80=AFAM Collin Funk <collin.funk1@gmail.com=
> wrote:

> I think the correct behavior would be to accept any values, or convert
> the current locale to the closest BCP 47 language tag.

On some Linux systems, not all BCP languages are supported. Not all
Linux distributions generate all the locales, and musl doesn't even support
locales. Converting to the closest BCP 47 language alone does not
ensure the locale is valid. Not to mention the tricky heuristics of languag=
e
matching (pt_PT or pt_BR if LANGUAGE is pt?).

> But as you mentioned converting them would require a database of all
> tags...

Hardcoding all the locale names in the code should be fine, I guess?
Though the problem of filtering out locales unsupported by glibc is more
troublesome.
