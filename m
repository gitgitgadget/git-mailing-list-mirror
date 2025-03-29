Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E4813AD3F
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743260048; cv=none; b=mW2REpdq1IF5lQRNrAVOfjQrEbVQMTpT4ksmkTGB6gaABtAZXbNBwrlR3g0RKc6Y83I1N5GWTk/UXqxWGRWJWSV0GzY7wWrpYOpWZBff2B8hWJhHQ57MQRhXZdlGJD86L/EGld6SREXc+aJKTq4w4Munr0bVmmzGWAwhW2X/lqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743260048; c=relaxed/simple;
	bh=QxBC15Qm3QJcH3J45J3PfokJPYYODxM+ZaABfF7RZ5M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=O9jwAKFFWaa6xGrNUjEwC1vthMT0PhXfeFRkhTfZbbL6+9WGi0iXNWeql/gKpBH3EYLKIHnX9goCx3/BDj6hsZd98s9t2onhmLgw8LDsXCArcsBTKXEMICh+FSaoF4UemfJ1xMoikIJMq5NGsr+dAdO2mSPD2HoZGiXz041UUSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpERG5z4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpERG5z4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2243803b776so32349195ad.0
        for <git@vger.kernel.org>; Sat, 29 Mar 2025 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743260046; x=1743864846; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxBC15Qm3QJcH3J45J3PfokJPYYODxM+ZaABfF7RZ5M=;
        b=QpERG5z4GMqtgoKTSsxPiKpY4T8qfxQswY7+hE8EWaCkM8+hfE93RCulKsAezRlEuH
         qMAUeMDxwyh3chc9pY5zRszvwJAPVuK+/gsGhKuKGMh072mJiYb3S2ATSo3EQurTsmp0
         HdwyA8gJT7gKshAsEeJahxBxa9gu1P8dOTEJNAawGFOyB+d/PkBQYdmmlHmyK2Y82DX+
         +Qzj7/FgNnlpujl3EB/FNjOwVeF8xtgLaPK0wbpJBPoRWdCMr07H1bxt9u2bBI/2L+ne
         OlOmBMqXEG/X2ikXT357O00LZ4R4ALAwl33SfxKtz9T1l+aS2V/IiGlBVh+Gom/CUeyV
         TuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743260046; x=1743864846;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QxBC15Qm3QJcH3J45J3PfokJPYYODxM+ZaABfF7RZ5M=;
        b=lMAttOodoHi7VdSnqkxgFQFvLfc9QIdPGzoArxmF8/gDtUhYUFJ6gev9Sy5/6A45uL
         nVRSE1nzJmpyM0t1Olk7gcGwaeoqiUTdtwnMtcTfV8jYlBduWCpgjEMFsOcEBJRcFBlg
         P7gz0Orz13+wbuR1KuAWoAPiNXkHPWUUogsDC77iNYTDUAiclFvxpy/LX+6A2EBq+rUj
         lBEWnFy0iu667yUNMVfZ356ZGYIT4KMhTbpbKNvLotQjJNR/9Of7i4F6rQJjMUtI6fh0
         0u2tBgoeohKRLqrmcJdUMJiA0ObshXg++9Kv9BSnKbw9txeNWUgBxGfEE4ETfTpZffAf
         E/vw==
X-Forwarded-Encrypted: i=1; AJvYcCX0BS4H7S3S+6Z2jdITcIU1EhIiY+EyGIkMW05vuBswGeRF8C/JjcDSBHu+jqrF0H9mlDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjeE2r8YMFQYC0V0REh5yQw8Jf6Sajh17OcoL0d4UvyzZgjYb4
	QNmXSwhuaw/2hYr95w6iPFgOttrrSBdS0siNI5PU0mwv0GkTDYZBxvDKvTdL
X-Gm-Gg: ASbGnctIvO6Y/sXn8KZho2BY9AjrWyp/p0AQk3ZUGMV24hhYo4jp8vCIyYuqbSY4icQ
	pGQZ9jWdvd2x5Fv9sOZwGClkNKa/kLnQlI/Urz9ORX8a3ntd1cizBMMPTlGjIH5OZ01RQkKmIyY
	ZEEGjH0mGiamVFzcNRy9qYFWt3MjWkHZhMuWTrbZ3vm7jpNQACF0rciCHbjLhKWp9DcY0LNdMYm
	K6NbbCwKZWk0jm0O/5xzyMp8ONue6CgazW4dqtTM7Vszhez+m74CbiDxt91cemaowrs+IevY2qg
	p4six3xxNUnSjD0JKY3I6A0LvnBkk1vBOJbTmQ==
X-Google-Smtp-Source: AGHT+IGVV8QH9+TkyvJr0ML2iuf7LjiynQgRB4Ll1gorqSdofeGv8nvoO0P/gmdm296CijsVeQVbig==
X-Received: by 2002:a05:6a00:170c:b0:736:6d4d:ffa6 with SMTP id d2e1a72fcca58-7398042a89emr3437359b3a.15.1743260046007;
        Sat, 29 Mar 2025 07:54:06 -0700 (PDT)
Received: from localhost ([39.184.61.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710636bbsm3653033b3a.87.2025.03.29.07.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Mar 2025 07:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 29 Mar 2025 22:54:00 +0800
Message-Id: <D8SU3YXKL9SD.33GRX731LWZE3@gmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
Subject: Re: [GSoC] Proposal Discussion: git-refs Project
From: "Yuting Zheng" <05zyt30@gmail.com>
To: "shejialuo" <shejialuo@gmail.com>
X-Mailer: aerc 0.20.1
References: <CAMvj1+rbYKFNeWEvvN76MTpzfuWc4TN4ViXRE4nTfWy7ZMspWg@mail.gmail.com> <Z-FJ3EQdFIkQgtkR@pks.im> <D8QOYSD6NLCS.OVF4RKHUCX0A@gmail.com> <Z-aoALIDd-U0bYnI@ArchLinux>
In-Reply-To: <Z-aoALIDd-U0bYnI@ArchLinux>

Thank you for clarifying my misunderstandings=E2=80=94some phrasing issues =
might
stem from my non-native English. I=E2=80=99ve revised the proposal draft
accordingly and will share it directly in this mailing list thread for
your review.
