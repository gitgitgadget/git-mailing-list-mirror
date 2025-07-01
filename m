Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116C27AC35
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385792; cv=none; b=Ge8kR51AmLh9+5z46D1/nEtaTbxY49nsG5FguR+23C9JJwtTvJ/un7Zh/nwIP4cUtBxjTu1bD771db3V90l+zZnxd1P1QEE0ELo/Xp+u3r49lH7V2+im4TYSwj9t/CxXBaJp1ZmGygZ55rbhKKKdpaUq4yvzfTjoVzBTWOlftM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385792; c=relaxed/simple;
	bh=E+vFmlgDBkoIlEFI5ASwWT8VtoRZW67J8w7ElIa2auY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hvG0e2sKRBy/YbXCdEkW6TU3VAgMikaNIDplnE7uWSKKUmG+AxlrNDasnDFi5WFJ8Z1ID76/j5m9gSWHLUZQBK39qNleXPgVSgs3LUEfAA7PvpOVVLGz1htWIaNoocNG58muHbfBVM6Yw61RZ5GCyvzaSNjKVsXChVAKClFE1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTTpc7JC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTTpc7JC"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso6712606a91.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751385789; x=1751990589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E+vFmlgDBkoIlEFI5ASwWT8VtoRZW67J8w7ElIa2auY=;
        b=nTTpc7JCyLi4glG9OUPlisX7QLiPa8ZpwuzGbRZS+G8+tNNgmqdgzJbCQvWiSHjNd7
         sivGKXTr0pxUaobmLate5bCUX9lo22idw5xH5JcYiRrSwvixW2X9K0u1y/o0dYAoquA7
         P+sMFkY4f5FJSWLlUY8Wn8hphX3eneN4QKo3oPZG539kmm9yfE2UTTH0uSjQ6r8ad3RM
         2qQ1BOLUUL6u89jC2n2Fw3v2q/Y0rDy+GoHvabVngoQHlK0UyKk04F9t7TYapk5x7ON7
         MAQR5eyEuclC/+/akA/W0UjwsbBCZx3aO/fjTgVSo+I53qInvKhuYHc+Z40vTDWMyZis
         Pzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385789; x=1751990589;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+vFmlgDBkoIlEFI5ASwWT8VtoRZW67J8w7ElIa2auY=;
        b=iS6geeA5SyfAJxcCd8oh0S+uI7HrvtoDTHE0qoZPoEYINu8yZqQfk9hWpaOPv7MOm/
         NWMTZfMFbb9r9UmfHpTDpr1FuEBTG0qfKotpLXyTGgIXxIUzUqpS4Y9N20MhaBjlGEAE
         qzK/+1v4jf6LYFBBQom+ZpGtpW7wOYPNMV/08RAnzHTVcRYaVz//n7wx+p1uEQ9aFvyO
         rF6xK51XjsA5nwKhO1xFGwhaUO+YkKoT3BVsnrXGbgH6IEimuNlcuEa6UHG7rg0rnqYv
         C38J6Cia+NRDHB4k+6hmph8EBnvB1aSPq7r2quB+3qLAxS5gc0XKsPNX/xvniLN0RKHb
         Em4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCM3aPZtHPzCQ/qxOi/pODJd/cmqpteO4G+8YtzjIzlZTFiHUuNXPIpW6Y38l1Y8iJbIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKdgsvJwizzvvcCBckLwsUBgs2ABzlu7tFrZp6d0DAJVE+aDZd
	FTZAcnqlaixmfatr0KNmtYpd46K+/g1d4Ll5in0sghr8rL6R8tjh7H21JsKEZg==
X-Gm-Gg: ASbGncuWmTzthDTM+DBBLkx8WD6kN6zYoTKhW6GO3lLGzc7NiyAwCJOT7dd63zFMTib
	i14yCUYUF7FD2THtRdFfDvVmCLSFEnv09aZsnD/e44qhQQier0KHtaih8Dm5KoEWwU/NgrHO8Dv
	kZwKjmLPHSrMVqvVnYJd/u5fUCZ+MyXxHEzTZ54VTAhxyVqOl+946F8W/oIdzSKi+OesKoQzRWb
	Efp2fceaT50vP89UsXkDLS8/qmzHxkmpgPsnXHdYGAVo5QYL0KcILmVSo3W2YuLNLnx2yqgSnQz
	Ec5d3Rv6/06+Gh4Raf4GzDBG9eiWXyTuf+vqutIhGLLGXftK8lC2+eJ1U+lYybEH6i+EJynyeVS
	QUJQdX0ZighssL9USENfYNfgUvic=
X-Google-Smtp-Source: AGHT+IF5yZ/rfs7hnXYmp8jQfScxcQj67d1FXex4VAb62KXXf1T96eYra1YqMdCtRnZFxAmrBvB/hA==
X-Received: by 2002:a17:90b:2f0c:b0:312:1ae9:152b with SMTP id 98e67ed59e1d1-318c930b4b7mr22425640a91.23.1751385788905;
        Tue, 01 Jul 2025 09:03:08 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-315f5426bf0sm16906351a91.23.2025.07.01.09.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:03:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,  git@vger.kernel.org,  "Kristoffer
 Haugsbakk" <code@khaugsbakk.name>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>
Subject: Re: [PATCH 0/5] doc: config: update for the ps/config-subcommands
 series
In-Reply-To: <adeb38ed-fdd3-4261-9c5a-901813b102e2@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 01 Jul 2025 12:15:45 +0200")
References: <cover.1751310455.git.code@khaugsbakk.name>
	<aGOx3C7-9NNi7h8Z@pks.im>
	<adeb38ed-fdd3-4261-9c5a-901813b102e2@app.fastmail.com>
Date: Tue, 01 Jul 2025 09:03:07 -0700
Message-ID: <xmqq1pqzlwzo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Jul 1, 2025, at 12:01, Patrick Steinhardt wrote:
>> Except for the issues mentioned by Eric and Junio the changes look
>> sensible to me. Thanks for improving these docs!
>
> Thanks. I’ll add your Acks to the changes.

Thanks.
