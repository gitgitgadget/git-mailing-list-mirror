Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BC138B991
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800552; cv=none; b=KXlje8Y7PJEWHQr2Yz0LM5WPUtYQXsHLhqB5zSI4hYeKY+FUyxbXz57ulssTjDzQ2DhBq2FA0uyNkmTrslFq+IL/T0LeQ//ujBGNDyWZJB+MMYQIIBT2XsELyBQw3DaXgM7gjQsUJ3+6wo9pd+sZEQMVSLVGNmXrjrS7JILu9CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800552; c=relaxed/simple;
	bh=0RsLGvw1ByCuT03LhtFT3p9BJL0YCUs9Mc9om/MlBDE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LitZtrjeYM5dcDvTAv5fZtC763cfH4dV3qpHQWNtt0kCpYHkCDAkijj9Du6S//e7qVjw8X9D3tA0JZ3xUyy0QN6wjfoj79K8hnZDAhm6dROmlnZ2AmK7NUX08mLujhuG9aCdhAf7km3LVNXeanrb7H37c34jfhgcbSjEEqgBvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9L6yaDe; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9L6yaDe"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-121a0bcd364so1827812c88.0
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 07:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800549; x=1768405349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0RsLGvw1ByCuT03LhtFT3p9BJL0YCUs9Mc9om/MlBDE=;
        b=j9L6yaDeXa7/HNS4oJcnI4dMHTb+hVQ5ARW+0tLNCjaOzcYL1tVsTs6f58PMOLWmZS
         7rya3MX3lV6y7S/oUn7a6cFJ5ykNDLsp0KKlVJE5mBdo6F5J7M51bEDMEX6DeoE41DDi
         ixs6xU/5mS/ExR4nciutWcEmDN5gOBiu61oqiJGnBHVajVDVCjNXb3N5LpRPLiPeFCZ3
         UvcitH74lbq2OtSl7G5aZRv5PDuPg34yff88Eny98w/zxlBPdct4fY+YBNeVXcxu23Cq
         2Ma1p5ZQ/j2+ZyYo3iGE+M18cfnqwT9dHar6i8KRJE+mjR0k0sHyXUWr3iT8/D0ViOwB
         yc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800549; x=1768405349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RsLGvw1ByCuT03LhtFT3p9BJL0YCUs9Mc9om/MlBDE=;
        b=AZLsH/Y1QcXr/pgrXIqC75ocHA09OzprhXHAlKL+sdYG/WKyaRCFganGWvXj0l0dqO
         GNBnT/uSm9jo30EAwm8CWyEtX++LfWBLu5ZRA2XL+z5gYi71fvEv5zXwD6BnVDywM+MK
         m/nP8yodx4MlHwtSjAujfo2XNA0e2pLd4jvKjp7u/XgtG5Cd5mjaZ+ERMo9+YVb0HIpf
         1sz+V5h8JMigVTziAyCf5qrdc4c6JDpNFxA48guEcYv6pfMHSFIkSQXgmuTNBuLpDX39
         /g/L0dKT6wNIKF2gpTrTGAR0WGMrhHylZEsDT3wvtT1L2XizijXIE7Amj3ix43McElns
         w3BA==
X-Gm-Message-State: AOJu0YyGigbowvCGBFpVQeEPqiWtn+D5GmfyFWjLGiUChTClE7eDD2EH
	ASkQmOLCdvF16ipypxjfumEc4EekxI/wNrLClailynJoAJouxGNXnfru+Jau3Xit7ooPpKsAamO
	uTIMWq3F/EVuxrmeKu7DD9QbBkLxQqANisC948OA=
X-Gm-Gg: AY/fxX5WMBrFzVdSTd/+w+PAzd1OYNsRz3zDUI1y+Vz7f33M9SMc8bH1r+3cdyCZvcA
	lPSoIIeCfOWTNP/fM7fqafztUPOdGuGot407UBdeI2DPk65QD9WOr/byyVU20pTvdpH40qxn7pG
	ZntnwjJ3KBQYLgaf5TyO6HOyqjGYPEYiQigXrRxA6AsCQJTN1o22Qch/pAJAUWt98G3LJgcD63Q
	D2ya8SMA9BqCKloVTXaTThmZhf1DCKcvxLHJt95L9iHySYtY/IaYJj0K2imYAxWTo9qnygz0wk=
X-Google-Smtp-Source: AGHT+IGia+IXE9rcu9nPXv+1aEW27dOKWEmuawHsA7CbF/cV/qCH0bS2ujoaLVHO0Qd3tyVlmS7I2RYJMKSK0Yh/H3M=
X-Received: by 2002:a05:7022:6996:b0:11b:9386:a37e with SMTP id
 a92af1059eb24-121f8b9e38fmr2434503c88.45.1767800549489; Wed, 07 Jan 2026
 07:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 7 Jan 2026 16:42:18 +0100
X-Gm-Features: AQt7F2rB3_uAww4gqdfW83OkynrD4HJUGWwziMTZzyUh4Ya79Qq4hqltQ86c_Yk
Message-ID: <CAD=f0L_1mhHH1iKF88iJua7637k8HPnmTN-x3Tzq9VfSQk05tA@mail.gmail.com>
Subject: =?UTF-8?Q?=5BOutreachy=5D_Blog=3A_Refactor_in_order_to_reduce_Git=E2=80=99?=
	=?UTF-8?Q?s_global_state_=28week_3_=26_4=29?=
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Weeks 3 & 4 of my Outreachy internship may have included a holiday break,
but the learning didn=E2=80=99t stop.

While deglobalising Git config variables, I ran into deeper architectural
questions around when and where repo settings should be initialized,
sparking valuable feedback and discussions with maintainers.

Open source keeps reminding me that progress is as much about design
conversations as it is about code.

Full write-up:
https://cloobtech.hashnode.dev/week-3-and-4-progress-through-the-holidays-a=
nd-architectural-questions

Bello C. Olamide
