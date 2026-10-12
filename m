Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E4135A53
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 04:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778294; cv=none; b=dgyayRasR5cYBj023Og/46wuLX736/1gInrspmu0LaBwV3P9FWkcBB4T3p/vaN8jPk4r0wdv+My8rbc0wR9+k2zWVPU3K4ztYFMX2d2v9kuDR1CrNnyTI+RpX9kX9BeIHJnBWJQu5upfQ53uj6N59Fi9keNmK5L+LKsEzbbArns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778294; c=relaxed/simple;
	bh=VGdXMZaFdeTwoj07rZZt0nIxZyZuCdSxh/ExsjCBpqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWE8CGtlD6z0UEG+Y6A8HvEfQSFfY1wcdidSb/nuDX/Nm/z+xt5p7a/SQumF0Qw+Cpf7HNm6rsk4lwJtwAw4RJUqH22EyTzW1+eBpcm7kmX+Wh5K9mKW7Ru9QyQhV0OUYBYlK5BFqSngVuNLoBW4rjDYJEnloMvP3Yqm4CCYpBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rK/vJzq0; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rK/vJzq0"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33c2520ad38so3279257eec.1
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 21:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791778292; x=1792383092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VGdXMZaFdeTwoj07rZZt0nIxZyZuCdSxh/ExsjCBpqU=;
        b=rK/vJzq0vSmMOty978hn3m5HLl5ToxIWJ5UbUiFHs1cWiLyfF/rWE78eiUsbSgouYk
         ek0hs3wQE3VMn1fj0lnAdysIMV5Azyk6nJXTxU3M5yB8x1EXNhzCG0n3UvwB5L19XT9f
         qejrqUoGzXTjMt+l7W5kLR16MykNYCXZcxqZYRQs3uYDX60LvJL0k/qgQXCdiTeH2eou
         /pTCRLkf0Lbd/49RZlvoaw0BcvtxbHJafi6ernboQsnILlvKX4JaM8DdUmbZtYiXOapQ
         9GoILPgSmRCqotxZBONgSUpcOGAq78atNWNSD2adiCpOnW0Nn9wUhz1jDE5mSllMeTHE
         CyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791778292; x=1792383092;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VGdXMZaFdeTwoj07rZZt0nIxZyZuCdSxh/ExsjCBpqU=;
        b=wDzIEKpDjTNaWXdY9Jj8hN5WxqOxgcbtTAfyB4J7Drbv2IxPyf90ajMVsgq2B9Nzk8
         CTfPh4q885l5Rw1P1HwRs2sJR6BazOkPG8UC4AH1IKPhf/eJ3w1b9zeCk79ocU5YgANq
         HzW0vWFb08b9LtBDPf/D7vEVdOkgF91B+jUwC82j4uKciWxQE9VtMiucjhFISE8xPR+y
         35Ld0eC6OzGJ8hhqELUOyJar25hy59k3+RLPZUyh31KsM6kEZLMG9PhfOjRz1k8en0Th
         iBKIBTwGSXc8zGJQyBPpm7j41mAmITtmoM2EIqoDZoXrJlgSN1wNhQbzKsQ60N8qER73
         lqGQ==
X-Gm-Message-State: AFq9FYL/os/w9I1YDpQkMweNlGmOZj2AZ6AISFEVIv9uK9ildorCeFVz
	tIpVQzKQH7NmLVzKZg2m2d7hHhLg/RLPGUYaV8GuDlNPha1wo60pCfT1r9NYcAfaDpZmEw==
X-Gm-Gg: AYBFou0NaOuRVnZCGti7ysTAql5sC8k7saJwpNeCjeYw7dAnGJxtCNjErGd1YU5WykY
	JVL4RMxAwt6e/pCijNXvmGSVuGSPM3VrNmK+xSEl8b8Mrptet02wbtIP96SQBCmc9XJcmtTZECX
	L//zq8IIeGkmZroY6tetUThhcZMDOcoY9cClrviw7fuVE7sVThP+/P/sPpAxEjAr5VGXgauLR+z
	qvuHu6zPZr/DlOMekvWU6vLI8y8za90u+VM/3L6BWDpg4OPkQkuZJ+XKGAvWOMYD3OEn25HDy+F
	IuP8IFgio6kluetkfCBYm9g/mT/boRfzweLTVrd7ut17xODgj60Vsj7wVvV4Cvicj90rIKaqqpg
	Ud/X+sKgweP1uNUeMaOGy46fD8PHX3fjCdw5pimsO0PgO43Gs4xCaLH8H0sjnIMX0YoqSbq/5Ei
	YRrjEP8e2ZNYlD26f88aUCN+8m1pmXEqiQ7vBKc8lQTgv6OS4DQhX3hs4qpqenyeIcB3YGcQAxJ
	T7T
X-Received: by 2002:a05:7301:1807:b0:35b:2942:f79f with SMTP id 5a478bee46e88-35b2942fbe9mr891001eec.19.1791778292404;
        Sun, 11 Oct 2026 21:11:32 -0700 (PDT)
Received: from archlinux ([2409:40f4:315b:522:e720:8632:5d56:b752])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b690af3easm298233eec.1.2026.10.11.21.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:11:31 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: Re: [PATCH v3 1/4] mergesort: move sorting tests to Clar
Date: Mon, 12 Oct 2026 09:41:18 +0530
Message-ID: <20261012041118.14682-1-dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqqy0c4emvk.fsf@gitster.g>
References: <cover.1791365181.git.dilsheddilu123@gmail.com> <cover.1791556668.git.dilsheddilu123@gmail.com> <21f46a2c9046d1da68233467bafb4b69226f35e6.1791556668.git.dilsheddilu123@gmail.com> <xmqqy0c4emvk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

Using more headers would not prevent this move. That first sentence
doesn't explain the reason, so I'll remove it.

These tests work on lists in memory and don't need a Git repository.
Moving them to Clar replaces the helper's hand-written pass/fail code
with the existing unit-test assertions and reporting. It also removes
the shell test and the helper's test command.

I'll rewrite the commit message to explain that reason.

Regards,
Dilshad
