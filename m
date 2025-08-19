Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B123D7E9
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621913; cv=none; b=HJ3To02Y2TlIXZ9pa3Fm+VcPKR7aD3sYW/4qFaR7GNldby8lHpXikqVpKoY4V9+nXv4VAwPRH4HEqRUDSgq6zgEJak6hmJLq2ofJMd1FWuskpmIr5qdsBBkhG1juV8gbFrzkL/y3FG1ODAp83T1nMlBKOPiE3yvAF8/JwEEczY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621913; c=relaxed/simple;
	bh=RWRb5pyQWw2XfDHUKpH2KL9WsKoCb7WU3Qwz/886FtM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Ar7FLh6vl6dHwNcYgQcX6+YKyr91o1UXa8BnUq+ybu76vjGgUjrYjePbjPWYUZbKKBAceRkIZStLPmHAg5OT6IZ7cddmz75kjMcoFZuKbgQGgR47sRtK0BCLgAreSJ044JYrhEmzV1G+x+uxgH2rak8/nf02+t22t6KMj2euAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOgpLbiG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOgpLbiG"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d603cebd9so60210107b3.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 09:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755621910; x=1756226710; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWRb5pyQWw2XfDHUKpH2KL9WsKoCb7WU3Qwz/886FtM=;
        b=NOgpLbiGlbC9KUhFCVtkTcRCupUqtl/dZhyu8nOxxdq//pvzmudxMXVVsVOJVgnEYD
         E8ukonLNbAQhwdDaUNP9dsCjJgSOHQNSYhKZFD7Yy01CvyMjkYluekHwYEu9PmzFNIvw
         yQYWIBbFWZD+DCe2jKV2wbqGss96osTjDdBXGVEw4xLaDHulAvWW00EYHU4Y69zlDKHN
         jUQHhsKX2npC0Kl9kl2ihHyhWnHe6OwqE9/jZcL+ZKrgYskwj1DCI9G7xkuVQnhbAPak
         xXUcdqwUGFHb/4/LDcRg+pAAup8n53Srn2NRweMUYPPVdkq4II9RedGV03dXfbM4TT6d
         MDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755621910; x=1756226710;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWRb5pyQWw2XfDHUKpH2KL9WsKoCb7WU3Qwz/886FtM=;
        b=lzuPLqef51ypMhvk+HKgs8I//zTbkji/hJIfoKtd5WWnOeie9b8+TNKKrw1nAsygJV
         qq1maBIGnt9ig86tWmX8zzb4ylqoSwl6U1YzCCiJtkmzrlC9GDcnuB/jzZjUeNXqXaUh
         fX3L2rdouv0qMtNkxgRgcpR2dziTxfKoKUNc2TaQKYnCngNKnbN4Jj8rLqE5fCX+nU19
         MabHz18LvvCTjbWWVeLPIxILf/TSk/hudfbwLASFrXoGGM8Z03Hw+/99Y5cx2AlMHGLk
         XJ30OlD0ZxPstFQwJzwG0/sqO/mt/rAuT7ezCifx5IfT+Oo2Ux/XRiP/f4EHaiBXytS0
         3JwA==
X-Forwarded-Encrypted: i=1; AJvYcCX5vLGVS1+VUtygyig2ZcBYBtNvbAu2rAJbn/HM8+PsJDjB3Z1sgln1Qmnp7Z1VEmj9UgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMtqvoGS2aMAw4n+59penY8RqykDlLuRS+J/CpdK3WNPo4+COb
	16Ts+Kv2eiSelD7VdfXl7k5ieIjCTzn39LK4jPBRz08orX5N4yZ9dQZWEGUbrUSu
X-Gm-Gg: ASbGncsu+QRVRaS2kU1hSuFub4Ovd0mIHXvs6cUr7VYUBKOLo4gTRAsCsY8etQJiJq4
	PHdFV4cOTJe2fsqb8HRvAIYfmtZJrwhdib80T0re5Jc/UUDAlYvQiNDzlUg4EVN+J7x6fxBroci
	UaW7O4i+Mob5f4T6t7EJr2J0NZ68monftKrCD/q+2cV1QhfLfeXXyxrdUW1nYA3uHAIJMK4yHaO
	pkp3H1GY/zjCJH8Rc+vZ/3RbHLttwcDPd8wcldLPZSwI7w5IvV9xkWMCbXs8WXrxAxcs4CO9q6G
	Co6FHnNcmoQeUAtptNj1j+3o4FSTdnUiX5mQzYBHOZ48PxxXlE2H5/4TJVd1aQm5gvDOSBzBfuN
	NBxBS4/ICR8GRg5ds/qrfqjvV9lYo7duUfgJUPhbRqPq7eapuw3rHqJqCcHeotg==
X-Google-Smtp-Source: AGHT+IErhTolg1tv3nVa/x3Tn/vrqTHxzaLYpsaqKuwTDLXyytQyz2psqbNgHiuoLhNgO5jsS3Hdlg==
X-Received: by 2002:a05:690c:61c6:b0:71a:3849:f88e with SMTP id 00721157ae682-71f9d57d0d2mr45265707b3.17.1755621910177;
        Tue, 19 Aug 2025 09:45:10 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:3425:d86b:b13a:793b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6debf78fsm30407037b3.31.2025.08.19.09.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 09:45:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on change-id commit footer
Date: Tue, 19 Aug 2025 12:44:59 -0400
Message-Id: <35C37A8B-732C-4CD2-8177-666CB84E173E@gmail.com>
References: <20250819140449.730068-1-safinaskar@zohomail.com>
Cc: martinvonz@google.com, ekempin@google.com, git@vger.kernel.org,
 philipmetzger@bluewin.ch, remo@buenzli.dev, scott@gitbutler.com
In-Reply-To: <20250819140449.730068-1-safinaskar@zohomail.com>
To: Askar Safin <safinaskar@zohomail.com>
X-Mailer: iPhone Mail (21F90)


> Le 19 ao=C3=BBt 2025 =C3=A0 10:10, Askar Safin <safinaskar@zohomail.com> a=
 =C3=A9crit :
>=20
> =EF=BB=BFIf your change-id proposal requires some incompatible changes in g=
it itself,
> then, please, do them now! Incompatible release of git (git 3.0) is near.

I=E2=80=99m not the maintainer (so grain of salt), but as far as I know nobo=
dy has even picked a date for that release. I=E2=80=99m not sure that qualif=
ies as near.=
