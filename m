Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D15431BC80
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758055143; cv=none; b=EvjfHNEuWVEbzsRlvpYti8j6YjQiUCj3B3qbIXJhqJUsAjGmDvEsdTLfBVzTy94HCbpREuQ+C2Em+ni6uQAgUhXiC1tZDFW0aa50GT/spLIY7SL2HuAv0xQN3YlLlpQ6BmEssYhpk4r/rSLznGnRvxdWNjw5yKjKnB6fOi4fbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758055143; c=relaxed/simple;
	bh=b0VaKVrAh/5ayYrGE1BzFNqLic6AHINJyO7wMECwVAo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=hNdV4BZIAnxijZPX3yKiLvss2p6zwoX8BKS02s98FoIFTlI3XlFwXggsJE+cRWY1RHh2jPVVbE4ogUmOYNCvhRF/HVQ0LMUNhd+CRXdFL6my6Fv1Ltd9Rr3OqvvKvwyOQZj2pIf/o+7Gb//qeIqNF5uBRXf9vVhXcXwGCHdxCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoWtFdYK; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoWtFdYK"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d6083cc69so56958777b3.2
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758055141; x=1758659941; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWhgdy6OHs8LwjhNOwGE76s5DyrP7smrIq4Fgh6CWUs=;
        b=EoWtFdYKGml4YQiwh4YU4C/wgQdc1brVmKxtVtQnHd8xZ7TwGeDj9FeKuGRCR1ip62
         WaEtqOeYDjnr6xPb7Kz7HyLaBATeK6mdoFoZeLyITVdxQdpln+0nIjCpKTsAeProIhXr
         8tNOAaE89t/7JMkvDSrt8w61SeslBMR/q9XksmjOakCu0jVpdk9ccJB08A9l9k0GLQ2M
         FypXBjIBaToOf0HQQonPbyeayWyV6B2XjfzdbsYiTOIxQIw+m3yeFKSV78xsMIqUEFIx
         +ybkBDvo1CTsT9iqmYLpyJHsj0ePyF3YWwiFKJTndcz8g9XvamQCrpGNLU3iGVCP38LY
         sCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758055141; x=1758659941;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWhgdy6OHs8LwjhNOwGE76s5DyrP7smrIq4Fgh6CWUs=;
        b=eDdKotaFzl7OlFVTF8TIpzaYH8pAEFsnhIsyl1BkKMI18bD7dOarKhS5j4DazFCvvh
         THksa4XF5n3dJ7wUWZcJcYPDgRMrmD3hmpwO/SUYaU0Lyrl34pTyiyfhjUWFuOcbq++p
         szVdhTnti2oLoUmtlmz5dSlczfz+V7frsPkUVJGFE9SlixAZlD2w8MBlQPqrIobXEczE
         jLAu984Oc2l+LffG+49z2zsYpSn8WRx0Jt/IK5z9tWXO4fEtkK9YPlzhCxRMfNTzG+Fu
         5LssvkR96uyt2TdQqF2JDMxa/NT0NI4BflblybuE+s0/tNQo9we90JW9OBFGe+vn+zAN
         ZV+w==
X-Forwarded-Encrypted: i=1; AJvYcCURp546T4LQWHxqTj6KVDg9sLcXifeuj2FN2ZtlgKhUoY50DA1SywAxXYCC/bYx4HNcYSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHauzr5k9W3usJ7QJP0r9AL0UJTXF4qoqgFVYXjuLM6DQzwJV
	W/HIMBm/x2XwqBqn6Wl9kVoqKKFkfCWq+ZlF7CI8PqdZKWMEPqRtC//m
X-Gm-Gg: ASbGncuPJTX/sJ5hw/w7Ka/ZjK3Ewev9rWRbulNYBXOI0NKtXvJnP0YqFsAbF5gHaNh
	cOZyP930P+tduaeghZnphTnTqKmbuPtBYDDRRtAlWGHGoH7+XtdhOzCvYY5OW+KJwjEUOvAfhJR
	/wOhNnO1l13gCjy8sEI1U2zyBQ/nqMhTezlmlzvCDSLSRFlQ9IyFI+Swtwb8/wdw3+/9v+t/KFa
	9+5Fv4ToSaZ/wVquzLBvuVi4zIHiMioAuoeSjEPIEqqjIs4krMOJ7IP6GLryOEf6XaUP7NEZx0m
	xjc+PCd3Ro3YvLV6nx9y1ofW5WFFSBnqRAg2mDl4urJ5SyBU42dhHqWVxRMqeIy4+5g3VURFwY5
	2Hj062WBGfO7c3kJ5ly/4Fw/ixYih+HwkxNHB+bBVOI1Ht6c8pc4=
X-Google-Smtp-Source: AGHT+IG8LTpipm6J/x1usxJ7/FCGG5PxEMdNx8cg18a/bzcSoBP4Jki26TruEwz/cKtBnT1ytEZv8A==
X-Received: by 2002:a05:690c:a91:b0:722:6ab7:f645 with SMTP id 00721157ae682-730658c30ddmr171280047b3.49.1758055141011;
        Tue, 16 Sep 2025 13:39:01 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:d947:8947:893e:f495])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f7683148dsm43443757b3.23.2025.09.16.13.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 13:39:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/4] doc: git-push: clarify intro
Date: Tue, 16 Sep 2025 16:38:50 -0400
Message-Id: <884CC5BE-5272-4422-B43F-4C0743ED7EFD@gmail.com>
References: <3f9f511f-7f9c-4179-85e1-87d76b748db3@app.fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
In-Reply-To: <3f9f511f-7f9c-4179-85e1-87d76b748db3@app.fastmail.com>
To: Julia Evans <julia@jvns.ca>
X-Mailer: iPhone Mail (21F90)


> Le 16 sept. 2025 =C3=A0 14:46, Julia Evans <julia@jvns.ca> a =C3=A9crit :
>=20
> I think "..., and sends all necessary commits or other objects that aren't=

> already on the remote." might work if we want to add more detail, since it=

> gives users a hint that maybe they can ignore the  "or other objects"  par=
t if
> they're not sure what an "object" is.

Nit, without wading into the above discussion: shouldn=E2=80=99t that be =C2=
=AB and other objects =C2=BB?=
