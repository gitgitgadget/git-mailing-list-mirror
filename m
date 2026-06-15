Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBDE2CCC5
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781488782; cv=none; b=lEYBRpG1wqD4qf4u9YYNzQmz1wVfGM3osReXuGvQwlG+nBA9RdjnsFARPHk6Ia1nIz8iquOql7hRHsUGUGh3r/yL4QsxKd3RNytMsnC9H90X/+hTS5lKty3XxOhZ1sl9EF1G4RuHxlUw0QkIXrOhAHClvf1zxt+SAYsLlxmo+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781488782; c=relaxed/simple;
	bh=kYrTb50HPND3Sd/Rz3Fowzy1V8YjX5PxWkWMATxwqPY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IG3www/zUjgcjkcvNH/g7Eqxi5tZaoxb6lzb2NWkMuZncgYQLmb3TtglJ8muKePds3ZAFbSXyJpCOrDS/qa0ehOW17KM+KjkeeVfd6dsY0GdDWOo/ZuXqm0juLqdljuyvKUi+nghdVTFjyvIETPfTxiwIcdN2BCEQ7DD0+m2+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDhVPVpK; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDhVPVpK"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-59ebb89109aso1909095e0c.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 18:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781488780; x=1782093580; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYrTb50HPND3Sd/Rz3Fowzy1V8YjX5PxWkWMATxwqPY=;
        b=cDhVPVpKC9AsT9yMY7RgDoGGiXl19xHDPlTLPl7wLC/W9knCfr0wJQBqliPsfFS0X3
         iqTveP+RvlvTV7slIJ0Du33r+NZWUWdmrynQDmyz9gnw68wu1Y6EhSifwTZO5GeaYd2m
         OnLXx/82zBAZXf6lXlo18l+vmn4ral2g8WkRoL8egOqQlnqgOmdFVvQFoQ12WPLlFQ0g
         in300Q+t0RMicicu9aO0kmcuqNWzHUmekxQ+kXRcsLLsgZfy1e/aTRMWvZxnNiWDzwaL
         Up4gFfoHciz1dzUylElZXY/xHAzYHbppvEaD3NkyfXru+j7PMpgYt7TrmVP7kWHlvFk/
         KexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781488780; x=1782093580;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYrTb50HPND3Sd/Rz3Fowzy1V8YjX5PxWkWMATxwqPY=;
        b=FDeCdtksi32QujPQTVMURRPRZjyXtYa8+VmTqTBMJIDfAtreyk+J4ttNsL2EBBrhZa
         lif3axBRjM8FsHMLF2yUvEkFivW5pZDQ0qD6YyuE9bmE8nJiI6HV/odaq+N/1E+4IxiE
         P4xAot1FjqXZZNPJ0DgtFdh2QyVxJCJ+N2PO53Dodh/grz/Fqnl94gbGsWkBr9duM4T/
         XHj8g8yhgH7oMicfjDhgtmkwDjJisFrC2CdmCXiT2Ho5nFs5pst9mpcAgviJhZFBDORM
         NoiRJDrTDebT+JvRxI1VOgHasD7wDxRLctH4QWenXh/+e9bPBySOP9ncEqmXynLvkCDp
         v+EA==
X-Forwarded-Encrypted: i=1; AFNElJ8qzS7ELEUibIYJM1hwSiWaG+Iu3YIpU0iFVTvUuaq+WVUdoLTcfetBR7RdyFyEkGI9oPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzXBecIBBfy8woPVMwFWgeug0+kwEsWWo12Ae6U42s0+yW46CW
	SQC3AP9LVuRI9tMfPsffo98hkHE6bebpaoT2LEPTetZpQiG8UWEzi4lS
X-Gm-Gg: Acq92OEbNWzdpd9XE8Te7mxqiFzq4tM8NbWRIKtKz4ISnllQkp/YRedI8e+vBStFZhr
	DDyq2PDZcpxwYPkzXhuSvbOIiCGc0l8FdLRl5UZPOR7L6wKDKtpnqns+EZXXs7LzDb+5SIdft/j
	8+qbvujfd7vwGk44ZoDL/8gNs1b+BWaqxeT8j2NUWEHHuQR2NqXBH7XSuKCUa5P3/eeM7ttXY9B
	9A4gyF8nqpO/toHJUMxYGmkxr6nrr3V8ubnbN5LAjSMHm+ke4Sikxo2uP9Nlm1zU33bDboXDvJ2
	q33Ts1sU1VhrGnjjS5tYEmL1MOvxFskwKBAadPcHU+i2IPLkOgFtV81oGgklUZRFPdDlElArjVP
	t7rVYgvrJFbN947UBaYcSkqmBls2L8qrVWrwx/ijsojPgyJcgPZ8lPncPpPCHU4cZHRNw8zIx76
	hXM0JOTp3fWPycpl2jzbpt9zxG4LLB++VMJKO7pDkfsFekG3a+pSO1ezW6GzeS
X-Received: by 2002:a05:6102:8019:b0:6d9:a889:13b2 with SMTP id ada2fe7eead31-71e88b20971mr7033419137.11.1781488780300;
        Sun, 14 Jun 2026 18:59:40 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:c4:89c7:b89f:3820:2765:34f6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-720847c0e9bsm1842759137.2.2026.06.14.18.59.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 18:59:39 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC Patch v3 0/4] teach git repo info to handle path keys
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260612182847.562816-1-jayatheerthkulkarni2005@gmail.com>
Date: Sun, 14 Jun 2026 22:59:22 -0300
Cc: a3205153416@gmail.com,
 git@vger.kernel.org,
 gitster@pobox.com,
 jltobler@gmail.com,
 kristofferhaugsbakk@fastmail.com,
 kumarayushjha123@gmail.com,
 phillip.wood@dunelm.org.uk,
 sandals@crustytoothpaste.net
Content-Transfer-Encoding: 7bit
Message-Id: <83C69466-3EC6-4C57-88B3-3342D63B97CD@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260612182847.562816-1-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Hi, Jayatheerth!

I've left some comments in your tests. From my side
you only need to fix them.
