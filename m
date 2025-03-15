Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CE91991C9
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742075449; cv=none; b=UFgXlFMLWa3WNAKxXUUZCFFrnQQeqhnpUf1iBlWG4S7kVaXogBz/wqId6teWqKsI9Qezs4MguRdpuelx0Vwt8dPWQ+64p6+oa4xr2z9wGetK/VwhjVePELXS/z99kI/1YSEeUBZhESGPyQQYwhMbWAer/7pFXuuK38R1ahr2/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742075449; c=relaxed/simple;
	bh=a98EaFP/4o06D5nALYMy6/qEiQJXGYQAlZIiOf0pRqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjW2RhpHgTHoVxv1UfUlIxe/DZnXLM+bi7IZ4rnPpUFg8wm3oNBpXB/JgC9P4iXsNnL5hl/38REQrJW8vwO3SfaSKPBIQVDY9LgdLauejApzc5t+psEN7zczgsBpKyL9JSMgb7updhjsDzmd9gda/h+he500x4/WNXLE81ACVI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYvdoPDv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYvdoPDv"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so4584346a12.0
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742075446; x=1742680246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a98EaFP/4o06D5nALYMy6/qEiQJXGYQAlZIiOf0pRqc=;
        b=FYvdoPDvAgH402nVy3chNCCbqbj64ge8zXEmYdHlMyC6Gd20F+6rtA2ZRPhnQDRpfm
         biJ3Wc+Oxqyz5dowByoetiyqMCZdLMZq206Jx9Q4mPWRtIbQpVrfSULwNnTyRtqTU4kV
         3zTB45tpxVpOOV12gJPzu726DsDLfZJ/0yXb7FbJOwhiu0XQu3ZrhZjt3JNiO5n71Vdl
         Ag+nqRt5yJm7BxM4Eo5dHMy301U+M+QyYG44Therqc8P8bFmznXqknbXtOFIUW3cm2yE
         MccwcKaRQkjbaH+Yst8uJUD+PuXKbDEjA/cqn2SznnBDn3W8M1ieSAmp8miRNKFTAMYp
         wJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742075446; x=1742680246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a98EaFP/4o06D5nALYMy6/qEiQJXGYQAlZIiOf0pRqc=;
        b=I9GH0QsjnM8DQuokXf9cYAHwjezPeMVXo9Fa3JhGnvbC6abNRGFBkpRHUds+19ie1r
         lXnsjV82OxjaFG1EayVzfEEjgxmyxhStFaBO1tDKNP/eHCpZkEXflAG/Ljhd7H5gaoOt
         1Bo/dp6BWOXLfhVWnuCyYN3kVRlZKn58DnhiY8WdBAgatp6Qrlr60xUa6O+gBV7+SEB3
         eF584BiHoCRoW9Au/8czDeWQy8EOUesQDwk1mbg7v8co7su4hRRCbVwaiZV5kFEuilpJ
         00AghZymTHyIXjKcU3aZEf6jhar5N4ceEjSiIATEYbVyW+fdPOdl2Fa21Wq/FiADonnt
         dTaA==
X-Forwarded-Encrypted: i=1; AJvYcCWjPD11mRbpgqBGxECfjhpaPwgPCcNN0iYaKDjel59LYPcg/Vc7mVe1evgL/ggDN06Fufc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3unUhYWKOmzlTTDE0hFwT5DzvpjrXKOVXB+NvcWvUFwWL4WPD
	+fYpbYb5lI2lzfJlI9LJoYSn5gYvptZCAapgUb4tCghyZrWyN4kdmYaMHzPGx8mckJTgYfDN5t+
	IXAvITbbArpF+u59e+T27iq0kE6E=
X-Gm-Gg: ASbGncvPKW2ifyDJy9j2wOUh/WHsANuRcNsd54/lvwgFRRbroLAV86uZqBUyCJCs6xB
	TOe/K+woJoppkm5Gbguexr8VCk4KfBDsCGyM2haFU/WRVzvKtjq6snfU4vTzjAbEcPsBbM0ZN7e
	rNRsNrBLTHXn+uMyexhSapyuXTVGG1W3pq+FkPLElM03k0F4uqvp1tceAQqyzy
X-Google-Smtp-Source: AGHT+IG/MbMZ4FVoyhCQjsn/f595zaa+iSACTOPLqUN0gdbZSuaPD/HSgRGx0TJC1aS5vEegr/rXMQrSCSZghAScbCk=
X-Received: by 2002:a05:6402:2112:b0:5e4:ce6e:3885 with SMTP id
 4fb4d7f45d1cf-5e89e6ad7femr7704933a12.2.1742075446118; Sat, 15 Mar 2025
 14:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmRq=7Q=vCPgmcLcek=fRsw83BPqTX7gTpcLb=JpQpYZEw@mail.gmail.com>
 <CABPp-BHPAEcJibTaiMVE1K7AvYE+TYmOt7=6XUtcZbm7wsWhDQ@mail.gmail.com> <CANrWfmRpDFuqv+fkCf_p_ggHTrRjD3Vgviqrai_rA7Lu-YFEMA@mail.gmail.com>
In-Reply-To: <CANrWfmRpDFuqv+fkCf_p_ggHTrRjD3Vgviqrai_rA7Lu-YFEMA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 15 Mar 2025 17:50:35 -0400
X-Gm-Features: AQ5f1Jrnj0iyfs8GbEU2EYL4RqU82XDjzBxr74paCBNDef2YSa1U_I8RzGeFtmE
Message-ID: <CALnO6CCppGXFHoL1jSkUWQUh41=RHb346hW6Qr9hFJpTawEW=Q@mail.gmail.com>
Subject: Re: `--ancestry-path` documentation has wrong graph
To: Han Jiang <jhcarl0814@gmail.com>
Cc: Elijah Newren <newren@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 4:21=E2=80=AFAM Han Jiang <jhcarl0814@gmail.com> wr=
ote:
>
>
> 7. How to make Gmail web client default to bottom-posting?

AFAIK, you cannot :/


--=20
D. Ben Knoble
