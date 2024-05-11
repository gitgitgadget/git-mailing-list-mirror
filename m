Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39CC7F
	for <git@vger.kernel.org>; Sat, 11 May 2024 16:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715446339; cv=none; b=fyBEk/jqtXsI/a/HVZ1NDv/l6dAqTIx/7NdkHBA0O42MLQ1B930F5NAVedSTaFgq+pe8Lqvj6lDtqbxoM1L66/e1IdUgRDMP3k0s+imhNZsjn6Awo3kQKFvLOtuIXYVlAV/MF2iA/k2Dw/iNORKySSHxttaAHT3pL2pRkKECkWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715446339; c=relaxed/simple;
	bh=1tudDssdJPNGCejgPRWQ1srM2JUtyFe4He95zPdSXxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXKe4bMch36QDD3iRTLA4TOluE06HTc++PpAsW5d4vIzzF2pCLHlgWGu1JiXtLKVL2iubxK9J0O8Fjb0ez8RypvsnOLH4zauQsl4N8qkrswxZXaUdH16Z+DKXlgQcIc+hlNuyaMafSUISI7THk2BZRaKnmkbobc7JXsPXwuYQqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78f02c96c52so183461985a.1
        for <git@vger.kernel.org>; Sat, 11 May 2024 09:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715446337; x=1716051137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tudDssdJPNGCejgPRWQ1srM2JUtyFe4He95zPdSXxM=;
        b=blZgs9TFap+CZ5xbKH4UiSwoIBRrCnzIa3w4hkn/XBnMr1YLAunZAfd9TAa4Siwlxm
         eTLXi8BkuyeCRetME1BBzcp/vt7y2x8NcFYCtHxgM3v2UIlqkTkTfXm76kLjjki5RDO+
         5qK+P4s4xejso0e6cBStUSFDCLL3UE0b8Oio6AUVpp8gw1FyV1hGfQO9hxTOmj8U3FJv
         z56+yGEgqxPQyG9ZLK6eSmzafZsgs1SE8ONRc0dNUaHTG28a7wbzdpS/FJKPtB5oHdpP
         TyUZti6DbAMKLnpYVlfDTu6uVSO9livAlo+fBg+MLqF+vb0VwzPgdF3Ib+KjKI1cBlsQ
         8lNw==
X-Gm-Message-State: AOJu0YyRRVOyDB0Ac55ORwD0UJ3M82U2yq5mqFn228W8TiuehDO6MK2h
	DTnNZMsg1lUW75XMoofUYn/BQUeiAIJfvf7rpNB43iyW70VPVYuXTlj04ENISjTLiFBmtjiNlT2
	ek2MY4Am6EvYs+zrOcfacbqApyTbkkQ==
X-Google-Smtp-Source: AGHT+IF0Sd7KBfskIxRbO5z6bF2f8pUlc4dHOpyDMMWtPkunDlEoUWD6hHBtLFzWcQaWC/42zbTthKzPX7eN9PSb5s0=
X-Received: by 2002:a05:6214:5c03:b0:6a0:cd2a:8ae2 with SMTP id
 6a1803df08f44-6a1681676b9mr65259816d6.21.1715446336657; Sat, 11 May 2024
 09:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715339393.git.ps@pks.im> <625216a7741b64b63717c72fd3c906b04c256bbf.1715339393.git.ps@pks.im>
In-Reply-To: <625216a7741b64b63717c72fd3c906b04c256bbf.1715339393.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 11 May 2024 12:52:05 -0400
Message-ID: <CAPig+cSf1BcAYKk4Mg4Nn8TV6L_VRQg0tXvUcNykFcnwdiFf3w@mail.gmail.com>
Subject: Re: [PATCH 19/21] builtin/config: track "fixed value" option via
 flags only
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 8:11=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> We track the "fixed value" option via two separate bits: once via the
> global variable `fixed_value`, and once via the CONFIG_FLAGS_FIXED_VALUE
> bit in `flags`. This is confusing and may easily lead to issues when one
> is not aware that this is tracked via two separate mechanisms.
>
> Refactor the code to use the flag exclusively. We already pass it to all
> the require callsites anyway, except for `collect_config()`.

s/require/required/

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
