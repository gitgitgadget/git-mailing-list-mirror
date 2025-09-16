Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBDB31BC9F
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054869; cv=none; b=ROgpYugsYFrqYzqb8P9BjLG+k0AK6+vXhzJw7ndtZ10mZY6PwFqahMnaKNE+h4d6jVCJ6FvZClmONzJft1XL9gV8CaAN2LbRktOLuWQH/QG18zBNWZfd2VIDV2su/sraIbZ681cF2Ay0PSRIZ7uohktIK04rUdJb7gDTxmHaBQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054869; c=relaxed/simple;
	bh=yP7YBARx4nzv/UvsfkaaEsjbMFV0SnxfuYpsclvDnmE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=WFXl1jIMm7jerHxVppwnmIeWK0U157LWWK8WPuZqwLWyuRCmljPfvK02ZeLyigwoTYm3X9s+WMRm+2cKyQoCLr0W4TqKAY3Lrva1GatrCdDSNGfuer70CC2AWIYVgvYblmkVI7YE/U8Cw/kXElElXCKOjIkw/bpVwc31vsfDZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRv3epwS; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRv3epwS"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-62e8a8a19dcso1142089d50.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 13:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758054867; x=1758659667; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MqghkUoEtBG0VM8UshA+k/CneGEbI4tPqza/w50CGE=;
        b=GRv3epwSGrbFof2Bjuhn8v1v8z8rWwx/nf/DzhvMfJoAVq+ppskdbDCMZQB7h/wd9S
         HIkD0Dh2ZatTEyY7BqWwPb6vCqMXtxTPdz/0XCpCoLcn5JJ8SDuUF/HoRYI4oWpMVhF6
         1Fupm8toZlcN3EDz6T4D0jhGgqHT6ArPPEmgO9tWYMKQ9ouLyeZWyJsTStR2n3aklxA/
         c+shG86/hyWmM24w5EmDjrwszwXq2Cx+z56l/QSOjMxTtnnyEGyVxHqIUnfkohdHNyLQ
         T0IfSxVrvfMjkzA9qRXZHZpd2p2Vo5QKOqlJExGT5ZFEJWSkcuYTkxsDpETfJKuXd7sQ
         mpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758054867; x=1758659667;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MqghkUoEtBG0VM8UshA+k/CneGEbI4tPqza/w50CGE=;
        b=N6PxVzcmU2Z89JibKrtyqMP5cHfcjJUDF3XvYjuCUi7xVSyPQm0MlLzSdvhIV941iB
         JRIJ8b1tLgIQwYSuvvrGrU8AveJxRxg7c440o28C1Iy9SNzAo7Yp0HF5TQcj4vX2ojGv
         Kdc8YZrXL67E6qnAKw2bmFQD2uQX70riyEqNeFZn0fmjHekAB+fLFYriz/hD5TSs8h2k
         7kBkgDgcbHqGYMK6qnaohIjMi3NgatTsSat32h+xS0GdSmQ3ctI73Og7ULhkx+YwMpX1
         IWVgStzeByYWxNf13oviGYFRKoMVsPs5DVYVa3db3ViK0a5HRxOVlc5bk0vdlNVYlByh
         V2pA==
X-Forwarded-Encrypted: i=1; AJvYcCWqtDp5MHfzLFApAEWGn2KZ7m+x0ymob5oFk4FOebkHOMfcWukeYwiHqGx31g1XXx78NCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFLnFngpA8vi3Cp9zlw3CvpLm9u+/0eV4oSOzEar2KuVh0UJV
	PTxblK3KWBHD4/FYCCcEFF0aMtVRjh5fsqTR/Coo53qkgclSOAjpfeUF
X-Gm-Gg: ASbGncsNd0e4USbB63kjnIGhuT2swEXKBZU1QRUfm+nFocl6RPde/jIBVTPOb41Ev9v
	M70Feh/FAqSEYPxEmnu/6HkG3nzdzUzFzBcmqWx9d7a0V0Wb/g9xG4yIXE41XZByueMyVg23v3z
	bLCZc3Kw9xdjIc9y6jqx1o9Ug0gNvk8KfduSX/oA/qRvs8+uWQkZHFkM+RcWDU2NAvsBtA5uP5+
	Lzzh+5FpfDR7i1e83T0KijmDMvh6tlV2Vy2wrx10pJdt14HvJwTuWJdA3Qmgc/FdDrB7JzAeFBk
	CvGUyWQXFJDIwfuVtpmFQRI/4pMefga6xzYixVM3jVaeCKXo6sxZEDnzinHxnvSmHXB0eg6bRfi
	ODarCB6VT0N55gFn5gN5299+sizhmie7l+NMLxwRVuAYn0T1xFYE1U0aDn4K6XQ==
X-Google-Smtp-Source: AGHT+IGRdXytf6saDrcT9TXULVjVbGMJB3GOJ+I3LcQX/HBzZ6WkoJg3lp2XmAWN2CEZ5pWcvvPAGw==
X-Received: by 2002:a05:690c:6e8b:b0:71f:ebfb:11cf with SMTP id 00721157ae682-73064cfc2fbmr126601547b3.34.1758054866573;
        Tue, 16 Sep 2025 13:34:26 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:d947:8947:893e:f495])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f769302acsm43359507b3.29.2025.09.16.13.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 13:34:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: --shallow-exclude=ref -> "ambiguous deepen-not" error
Date: Tue, 16 Sep 2025 16:34:15 -0400
Message-Id: <7A5A29A3-3738-4BD6-ADB2-F3D1DE355B80@gmail.com>
References: <20250916175740.1044452-1-phahn-oss@avm.de>
Cc: bolide2005@163.com, git@vger.kernel.org, newren@gmail.com
In-Reply-To: <20250916175740.1044452-1-phahn-oss@avm.de>
To: Philipp Hahn <phahn-oss@avm.de>
X-Mailer: iPhone Mail (21F90)


> Le 16 sept. 2025 =C3=A0 13:59, Philipp Hahn <phahn-oss@avm.de> a =C3=A9cri=
t :
>=20
> =EF=BB=BFHello Ben,
>=20
> Thank you for your reply.
>=20
>> On Tue, 16 Sep 2025 at 13:03:41 -0400 D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>>> On Tue, Sep 16, 2025 at 10:58=E2=80=AFAM Philipp Hahn <phahn-oss@avm.de>=
 wrote:
>>>                     A---B---C topic
>>>                    /
>>>               D---E---F---G master
>=20
>> I might have misunderstood, but aren't the commits you're interested
>> in here the ones named by
>>=20
>>    git rev-list master..topic
>>=20
>> ?
>=20
> Yes, which is I have described using `CI_MERGE_REQUEST_TARGET_BRANCH_NAME :=
=3D
> master`.
>=20
> But as also described this fails for those "merged regsult pipelines", whe=
re GitLab creates a temporary merge "X" and then runs its pipeline on "X":
>=20
>>                     A---B---C topic
>>                    /         \
>>                    /        __X temp
>>                    /       /
>>               D---E---F---G master
>=20
> Here `master..temp` becomes just "X", but not "A-B-C".

Here you should still use master..topic if you want to lint each individual c=
ommit, plus include temp if you want to lint the merge.=20=
