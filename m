Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC9231836
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791224353; cv=none; b=KBxPbbuaWbd/FSOpiDqsh5MkOSECrau8qF+bx0Z4RF5198FwegYnd16eulqRNdYJgxURPsdCeGkoKLCSXZnry22OBVGh+dfXQT2Qer0g05QcJyW4CGqA+aa8EdfQX5I4DGElwYyFreSfN0+4sDPgKndSeuEyNHVwlEGHR+d5bZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791224353; c=relaxed/simple;
	bh=nQgnnc9jgGR1KR2nAB0wsK2uHy0MeZ0MrZYjFVgaKn4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VmhqhasX6Q7d2klYZ/HTwVyfg1/nEaSe+pvfaiULsId1DZ3dOstlmGXVv+2LKnb6hMmYdlJa6BkM6xlLAuFhe4vEHNWM4Pf5LWOYBOMmvozTY8Z/yLoptN4fA9FlaMPqocMua2ZyCG81ATInL1jB+Jo5csfF9/gSQK9YL7LWN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oc3iHM8+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc3iHM8+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a1722c37c9so10560245e9.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 11:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791224350; x=1791829150; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nQgnnc9jgGR1KR2nAB0wsK2uHy0MeZ0MrZYjFVgaKn4=;
        b=Oc3iHM8+of39RpxU84zO3JnJuz4N3Wv0c3mDriJ2xOaDPL9j47I+VnWDuRy1hDD0Kn
         BBCi5lk2ZuvNWZv0ZYNV+dVHBx89HrvobUc++B6JudBO34OqzTJJjEqRWjq6HSA3juSv
         Bk3rmS6ZS/WTWWsy04p+EiQzDBQgfkiAe6S6SQWqPgILuh0bYjolMD4d49W0is0fsfNT
         rDiI/dYiIr8CYy1MHFAu1+0DXl7ZcadZZvrd7zFnVGB3wUgMflOKIMdx7++IRsYFXjyZ
         Ko/sumGAd2YGk4rDTk/Iwymy9X6VcBtxJ9PRxDOOI/XCZfCD5bb1B7W6vdh1YmoC7AZX
         SCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791224350; x=1791829150;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nQgnnc9jgGR1KR2nAB0wsK2uHy0MeZ0MrZYjFVgaKn4=;
        b=XbrMPWjma4DriMZIJ3LLaxz2cWHTe9oRkgxhd1WiWnohzW88fsb6M84rWtfUEVNxDI
         TeQZM8ZpYlTq6UPo8wjBhOlo157RT32A7wUNdofXIMPjA+q3P8lYaLbIf62lHsQpV9BJ
         I2A4iC6nsftY/59MZH8F444WXFLftdJTKJS/jWM7LoVu8apTfNK1sKcg6Iwlq31d7Bgu
         dEXduL0Z8u+GmKBLnzGcouHntm45bhoqlX/oInBR9v9MuGolveLeqaatSZHo6Iz8TRw7
         6ejbA+w/KlPCzKtfjNb+uJAvi6C+htb0554LY4BZdLlzE9d5ua71osDMrUYmaPHZZuTX
         rQBA==
X-Forwarded-Encrypted: i=1; AKwUvBxuhzkMD97bFNVo8RD4sfzqiA89BsnuFPySg9+JJFfmN8VugLY7CaeWf+CwWjs6z2Fu8dQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kc4BIxPc4LPksTYD4/kxlwVZZy1HpJ9l2sQEu0NFpoKrYNIgHF
	DOraOPiabxUUxEo6PitL5RIySOMm8b+9IncnTjeiwQz/OjaCZZKiPwrV2vDWv7ENrMA=
X-Gm-Gg: AYBFou1thkI+vrGBDVOd3HDw6xtlK+O6by4y8kjitNAYbsSr/3VZKSkM4G/OFhsXWZq
	dCQ8zxsiALGkIAGQE++I6uYXTDXMkphImFuTQYhZpsnqHpLlngOUM6k8wMxzFUaPWfPW8tPmo01
	XCtktT0KVFVit/EhUMgjORnu02uO3a+oAw17yeoAjkw6Hj2BiheuCrF/6mGUIgqNJzbCylz5sHp
	bW+0qXPUACXZq/1w5p1+GizVoNdcH2Gf7WF+O8pQpNc6O3lATT7r3AL8k43l3fWLAGCFwQYonqu
	VC9mhlHGcsHhj86WJBjspIy5/+XScHSiuMuCRSOUVHGkwxIm8Ioy4fSIhf7f2FHagHYCV7NhUjR
	T6OFRbNOtp8xW+5GO8YK+efYPYWwdDRBEpGhE49BwFCHePOmpwNMRGu3EqT/5lm636u3Sl1QkNL
	eloP5yLQg7cypVRKRdb8cnKwCAR2ErNp1C6g+U/ryK3SMmuIk8jvibCGPRit47s2LqT7kMzrF4i
	3N4+s/8mJGV0qE4ygH4stfc2C69SgsHLQ2xRdy0tTAdOJ/gjSTt/dvxLbRxv7zbYtJ9sloHKSau
	EzzjyMLgPaVRqr6Uwun4DuLSKTUybqm6FyEA7Hme6FkJemCeUdy/NCFLwkLHCGfWmVwuYb1uCKm
	R6zceK715NLUKMKpMVQR4ROXd
X-Received: by 2002:a05:600c:4592:b0:4a0:bc9:28c6 with SMTP id 5b1f17b1804b1-4a0276b6860mr183512775e9.34.1791224350154;
        Mon, 05 Oct 2026 11:19:10 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:d8c7:78b6:eeb5:b807])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a039505568sm322611535e9.3.2026.10.05.11.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 11:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 19:19:08 +0100
Message-Id: <DLX41DP10SBK.3JNC50ICRW1RO@gmail.com>
Cc: "Pablo Sabater" <pabloosabaterr@gmail.com>, "git" <git@vger.kernel.org>,
 "Git at SFC" <git@sfconservancy.org>, "Usman Akinyemi"
 <usmanakinyemi202@gmail.com>, "Tian Yuchen" <cat@malon.dev>
Subject: Re: Participating in Outreachy's December 2026 cohort
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Christian Couder" <christian.couder@gmail.com>, "Kaartic Sivaraam"
 <kaartic.sivaraam@gmail.com>
X-Mailer: aerc 0.21.0
References: <CAP8UFD367UD=AomNVHEBnhY-2DQmqTNRcBX6NW7YZywWgOmxTQ@mail.gmail.com> <CAP8UFD0oYnoXgQ84wHbGg3+QhX78Ucn_CXXYOe8uFpReb7X1Ng@mail.gmail.com> <CAP8UFD1hAjtPuWL8asZ2LzEMJKHGh2oO73n_tsUSADtEHh9b-g@mail.gmail.com> <DLEWITFIKFFK.NSANTRY5XBCB@gmail.com> <1b904e64-e681-4744-b83e-690f3ca94ea1@gmail.com> <CAP8UFD3kd=6QHp2oB+t+g-2D8bY-Oe5+_Vk+RJeaCa_xhxGrsA@mail.gmail.com> <fbed7a60-57ab-439b-a550-2d2b76ff24c0@gmail.com> <CAP8UFD2VutDBA54c1e5uiCjFB8v3Y6yS3MTtY2P6sM5+Z9y7PA@mail.gmail.com>
In-Reply-To: <CAP8UFD2VutDBA54c1e5uiCjFB8v3Y6yS3MTtY2P6sM5+Z9y7PA@mail.gmail.com>

On Sat Sep 19, 2026 at 2:43 PM WEST, Christian Couder wrote:
> On Thu, Sep 17, 2026 at 1:07=E2=80=AFPM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>

[...]

Hi all,

I wanted to let you know that I'm no longer sure I'll have the time
needed to properly co-mentor, and I'm worried about ruining an
intern's experience.

I'll still try to review patches and help where I can, but I think
it's better if I'm not an official co-mentor.

I'll wait before withdrawing on the Outreachy site, in case you'd like=20
to reorganize things first.

Sorry for the change.

Regards,
Pablo
