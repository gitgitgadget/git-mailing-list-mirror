Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6417B418
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638720; cv=none; b=bah8FkrxiTbo7avj7Sr9WC5PM8mgh/QR3X76kRHN5va+eJrUtBO9ra0IxWyIa26SerpgtHOd6y/ePp12H6NfF/wwtwCDaffj6ZYZskH3rUXelsCaUT2zq3/c6x1ibt+8OrCYdA3ALz8t68OJo4KNhr264+nw1jCnR7MbLjALjbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638720; c=relaxed/simple;
	bh=SwO12yy9+cV/oD821ko26aPDD2qELZeTVCKp3+upEdU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PqPOWQoEtghpKv4O6qnyhj3D4ZYLvp6VYBzgLJv4RpAytc2VtakVymkY8ZlDSKng0qsbDb6W2VxfEKaQGVrfMNhCRdDgy3JBXnRk7on0gZifNaA0zqdQVhR/Z2orRGUjs8IQnDUOuurIbLicuH7YHsIW4DM7jQvfXr41GeQyvuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcrnuKVJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcrnuKVJ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747e41d5469so1177835b3a.3
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 07:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751638717; x=1752243517; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLLFGy4L3sp7IKy7LzhEHuK9zAd1EwxEc1929M4B57M=;
        b=KcrnuKVJbYFNo9vgWs3uHkzsqHUx1Bc3S4IPsHs0pqomzyZjMHqvidn1GW0LFqmTpl
         A1LEWSZkWkeUu4wPrK3mW7/Sh08rGgvwjJ1aQQUYt3erJkugh0UE4JIJTDx/DsnMZmOu
         2M+/bO1loFUIgRQWj+VaXtHkBVKBoqLLBB/m/ONmWp15UlecYeAnNjZCnaSr89uEj1tX
         TTF20NSzUdGnkxd0XIFOfC5kwV0nUPNjTJ+i/X2X8aCcb4P0y2/jTnJdRb8Tnc/QLKrS
         oZlZC5GCOy866RCk3wIm+6KPjs7NXfcqP90TCjUHx6a0NeIWVYy0wPpcBbjlSbtijdWl
         5RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751638717; x=1752243517;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WLLFGy4L3sp7IKy7LzhEHuK9zAd1EwxEc1929M4B57M=;
        b=Rp5sAUM6qDHerQQ7IjtM+zEKcSyH6ZnOZR19KyPQ8rvXPsy5Y/G7MudIWt4aWI43Co
         HL7v93+/RxCsJjJ2avTFD9NcdBw0lsemHAvIfGxs0UIh/mrBlcZbxWfdp7mUhlhKe8yM
         ovS/VUGHkP4WvbPpIxHEu+xcvN80VUft96uzAyN1eSMq3jxLiN1q3gwCyK9aNmJa5qKk
         AROhATAr2Uiheb0+vEpk9p8YYKK4hOxoL4IDwJsHVMOtqiKGl3oYDsSyuyPtnowL6F0e
         E4WpH+FxEVynukHVMBJQHx5kwk1yNQhQ5SeA3OdDbmXMKeGK0X4QPkG9naLEzOxQ0rEF
         9qZA==
X-Forwarded-Encrypted: i=1; AJvYcCVKaM5DXOITh9xcxx9FB/mErzVzRqAEqXVUkwqKvSFcUtTCEBNO2s6Rwh0LhEgWnlOj9fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYCtXPdYMg/C1zI8vJBM4Ay+Y/bof3e+l+UPe+0Kz2LNvw0wJv
	QHmBRQniYm7guOfQIMbIR94XpAOle5SgYtwQEr2IZqDfGUf7hhfaRf6zod+uyQ==
X-Gm-Gg: ASbGncuWnGQaaTxqT8SiwFvqwV1ur07YNv/y5zxMLDhW+5EF68fFkeWBwVBQAky+EKw
	OrMv3SUD1FpeljB6e5Q5/DMpRe+vQXJJmsYCDqDpRWzBboQ4BCGOVpTF+Yeu4s5rIMrE6eJEtI0
	nrHcWxLNRmbfGqUOYVXmtwOQoYu+gQP/kdyJSb1sAotaJboWH8bPnA2cl7Gfc84yhepe2TGG2YH
	+vBezOpY2UBnnPthq4JAnEIxSMfNqCq53FyaL3Lzc8rICs/M9+0r4XT8wjLr/4kgPummDn3eN0S
	TAaEG2LrIhOnSmdZ3HgPO2HeIRDltNqgWFiAubVOa0QAP4eVQK4WFhJsn+dVFMcg8MIJO1r5iTm
	xGDK+Qn/j5YgaXX94zH03Z2s3Avw=
X-Google-Smtp-Source: AGHT+IF4lchK9AP0XZ1oUtm6cbSJD/Iuq9B1ppWsiuxgMpbkm6Fq6eui4MGq1NWak5cin0HErHp4Ng==
X-Received: by 2002:a05:6a00:23ce:b0:742:b3a6:db16 with SMTP id d2e1a72fcca58-74ce8ad64dbmr3451426b3a.20.1751638717283;
        Fri, 04 Jul 2025 07:18:37 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce417dd9asm2329106b3a.72.2025.07.04.07.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 07:18:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Per Cederqvist <ceder@lysator.liu.se>,  git@vger.kernel.org
Subject: Re: Allowing "/" in the name of a git remote is a strange choice
In-Reply-To: <aGdi6GRbI6Txm25Q@pks.im> (Patrick Steinhardt's message of "Fri,
	4 Jul 2025 07:13:12 +0200")
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
	<xmqqikk8bltr.fsf@gitster.g> <aGdi6GRbI6Txm25Q@pks.im>
Date: Fri, 04 Jul 2025 07:18:36 -0700
Message-ID: <xmqqecuwavk3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> So it is not like we can just forbid '/' retroactively and expect no
>> repercussions, especially given that I hear there are more than a
>> few thousands of existing Git users in the world.
>
> We cannot just blanket-disallow this now, true. But shouldn't Git be
> able to detect this conflict, similar to how a user cannot have both
> refs/heads/branch and refs/heads/branch/nested?

Yup.  Sorry but I should probably have not left it out, as that was
way too obvious an improved "solution", compared to "just forbid '/',
as I cannot imagine anybody using it".
