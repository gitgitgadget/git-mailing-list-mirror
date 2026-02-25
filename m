Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820903D6497
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033503; cv=none; b=ekWBpYzs0jk5kfR3ffU5UR8TJtfUc60x5LOX6rcZ59lwmQlh/2/c6ntt2ctsbW5hvawW48R2F5evgcZiRX0YRpPa66H9md2XxZ0xAXOLUAsNFS8OHxG6X4MEtxepVICEShlOyZXzsw+Q+Wt4haulrZRc1xXy4sn60qgmjy2u43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033503; c=relaxed/simple;
	bh=4JsCC96Xpwi3fiZyGFW6myr0eS9rqHs1/nFdJQRfnms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwRXOV6s28i12HbH3H1yNzhi+5sywhnnup26V2MUApu2VlE2gSs7mqLhDZz/W8M4EoyBPlF58N4Y/DvAvIQinUv6HhTWuXgrEKYxOPpBZ3PRTsX/L+3n55Odjjobm65gElPwC3qNIahOszbq6prVVKQ/nPwiOVkxDy0svHzupsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTgt+590; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTgt+590"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3562258142fso4010537a91.3
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 07:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772033502; x=1772638302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JsCC96Xpwi3fiZyGFW6myr0eS9rqHs1/nFdJQRfnms=;
        b=fTgt+590jLgMyS04m1N4qlHGXyM37NxVG0FeQaNUeRpREoocnLTdEazGK3Vz3g5Gnr
         6E1+w6GryVt3jYx2tUNjxu9e1guiAQmhzEAdlz1YX1kNfAFib+idfE+BhbDzIYNVppT3
         bam51uoTKDXYnOw7e3I6TwdKe8g3q2VO9l6XNIpPFAHGWkNaCqITWKOeGTJfyULBlu9z
         f2ocTPTC0nz3YoyHuuRQ1Zin4gus2jrsaoVFF94+cTfo3acczwe3PGWaiI1ga+JdJGVe
         cVcVgBILYGOWojduX1zP6eVBybQxk34mz5mZFHl4L8RXECp7b6EZUdcOyUr5SOHUFMyt
         RodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772033502; x=1772638302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4JsCC96Xpwi3fiZyGFW6myr0eS9rqHs1/nFdJQRfnms=;
        b=qOeOOGRUnh0zgOet9goEydgkV61jpwN8y9TW1kQ+na9m8oM28FtL4ox4KPRuFxYVW/
         1n1Vyno7g+Pg2ROupQOMkHAYI+i/+pwOyW5FWLPtaxeZnCws2pWt/VXkONkZDOcktUOp
         5SOb5vMI5gnAzkEg7/isfjhwqNThlsO0vDoUfNbaBxw52BTwK1NdRlt4ptH3tStlk05m
         XViQj5Jr79FqMXHO4Z8LowRZ/Eb+LJnKO4tUU5VCEpbzjyJr/dudVb7rqoMQczEfCv/f
         5MNVv2PX0QmCRWgNtU3Kfrbhi1BE9fwsremFanBe9xd5FgGeQmdqGJSLVSk8IHW+w+qe
         c8uA==
X-Forwarded-Encrypted: i=1; AJvYcCVhRoSdzrc+HsS9VblkCNYUf3EsstE+b3f5T6Yl9+CNASeuZbzmSJk0xie5JKegaQBi1Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXd+Le+p/8kj5EeaWJSFzbFXgJy7TgOcbTq9fNuZyHdtabQz6Z
	4IwUC/43Wwba/U3cHrYXbcrZtGvqhDgHiFuDR2GOj0USqFTI4Y2Er4bH
X-Gm-Gg: ATEYQzxMwHztIIf1DtrgG1mPRtqGmyWmU+eqB9+XhGZQvU/XglIg28ijhEeHCxs2JHk
	EIvluFazQ7lY2etYnT8ZE78ZSIgUJ75YZKA1GfPfN/D1llRJSxeS6FzgibgG1JfCdMWBq50KejX
	itUHqDG1DnhBjbrEvMEU9LX1oCr0uNmKGqk0+hxLGRzXZ6+Xca211qvi0lW4WrL6SrQUxR+ej2R
	gjz7yo6aQK666zM70nDSo5esaUfU+PshV4/tx6Xr2f8tH+ihC1nRLrG9GEf2kZ0TVe7KZ/kAHIX
	PppxxFVOyVOW+oBUkzCMNRQKFMXLxJf/xQlJfTyokO5gBLsMnqSaGkRiBaXAuniDrmU0zIaGHOx
	6KN8GsWyINOil++dgU+ud6wYkuTGdGnYm6RwrXGdLcIdWGTLhM3dsb15/HInQUJhp97nW+qibz6
	tyYbyOyKwJ9JgQSAqB2vlgtHGADfJuIkg1AckqfSC7t3YRXhZpieX56syCkaOzKoc1ukYUocV6x
	shPpDDtDmPDUucyPK44oXTHGu1gC6Mlh8pP4J9Ghce7eEFV5NsZiAAAptOfkyAyMrhOyMzmKgiv
	hdtrPBc=
X-Received: by 2002:a17:90b:270c:b0:34c:6124:3616 with SMTP id 98e67ed59e1d1-35928be9848mr543471a91.27.1772033501686;
        Wed, 25 Feb 2026 07:31:41 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:1975:95cb:38f7:a991:455:152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359037af175sm3091601a91.13.2026.02.25.07.31.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 07:31:40 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: ayu.chandekar@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	lucasseikioshiro@gmail.com,
	siddharthasthana31@gmail.com,
	valusoutrik@gmail.com
Subject: Re: [RFC RFC PATCH] builtin/repo.c: change info default behavior to show all fields
Date: Wed, 25 Feb 2026 21:01:32 +0530
Message-ID: <20260225153132.7387-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225001439.54954-1-jayatheerthkulkarni2005@gmail.com>
References: <20260225001439.54954-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> In the Pro Git book there is a chapter which has a very good description of
> plumbing vs porcelain [1]. It might help.

Yup, after reading it I did realise how pointless my suggestion was.
