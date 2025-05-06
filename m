Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E67247293
	for <git@vger.kernel.org>; Tue,  6 May 2025 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520120; cv=none; b=Qi4WbAUuMIBygzEE+7Gr8xe1OadnV9VmopynRFomxmmKeO5fFmdYBH4Hj311hH7G9TeACvaeWDhPmIOkSE1bxGpzSqRc+ldevOb7y61G8p1Nl2GAypN7hd2mBYDNhaujhaWL2vZACWYxlPSfg9MBf0DWvIW3TNQCC0E0ou5IpGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520120; c=relaxed/simple;
	bh=eA8+exDikT+1NzcYF9EdkIfrUrWlcby+kSAXyhXlXw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oM+JXNVSSA8zzVSCI3O0sAlrKJaTTwE333ZdStR5MGWb7eEnU7SnMhFzcD8ZclLbIB0g4RpFbfJeja0jGmVvjWHBYihXVCzRQBah5bXCqxwEIX5qmk2Z0eK5sesX6ZlwsNQdvB1ddIA3sUcstUrqWQgMDzsIru//OgxcPgD1WKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM2Xr2ed; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM2Xr2ed"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac289147833so990272566b.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 01:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746520117; x=1747124917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eA8+exDikT+1NzcYF9EdkIfrUrWlcby+kSAXyhXlXw8=;
        b=kM2Xr2edrpKVtGxAUhYVJ/+1OvUZctQh3dlLrYAuLki7MSNSCkJZ8DU1Cr24TstyKq
         8DVNjkqL1RT/lxvbHnx7EMM64gQfS+9oDo/yzzVdyaiEhoowwJL5vcCvF/mARSQL5/+l
         TRz+OWvqgvqiASe29eTxqEhLWameKhwo3mK551vbDMHF4C6pxyVK9ZPm8mLbkaF/2IZ7
         DNT9LtaYTXYwDlELWHQ60Bm5sBcOOBLZ06UmF/qmTyVFuFCFmVCUoofJPlr0/ewnQ1M1
         LuW0xnaG2s6n3h90c0K3qyQPw7sX5nptu82xz+8MSbBxGjYN/JifJqCp35+iM2SUj8E2
         1MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746520117; x=1747124917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eA8+exDikT+1NzcYF9EdkIfrUrWlcby+kSAXyhXlXw8=;
        b=KxoGO3sJ92rVr61vM1bwCw1qOfZMA/t58Q1B0tN2YMhExe17OC3nFNhlb5v6WUMRCs
         7ZJzNqiJtaNd3gV/J9C6w3sUZ6KsYvE83P0liJMp4K3lIN+zs0+Tx+eCAQyWPPIi0Vgr
         rJdZ85VLxZQW9fPu/MmiKN6lS7TDXds7mYEKE73kif9CUzuOoyM3fOQG6NdfB4QkYjYz
         sEZlnYkeG2I7+i/+6DUjUbCVTflCA5T7NDioRD2+c/in6n4n2I8To5nFiBofU2De8M3a
         UqkDAINgT2XDe/pTmgRO1I4Y+4423dHeakJj7K36c1PhnK55pxoh4vbdby9veDBgbGv2
         wI2g==
X-Forwarded-Encrypted: i=1; AJvYcCU1RAYg4wBoQTzXBNuqZl2pr2YcTJpRSg3oj3WinHB0gKbC5XZMNVLZdIbMCz/coe6MkAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJUgLbttmTaVKCaP+SPJSXJFne4yJcAfdzNlYILLEMeWblk5d
	Y/Gi1jUKgS6UH7W+OvruqjjKfLbl09ejrS4FQnjpbhq+yvtkcz58tVUTtDB2FHizvEFia5hwdK+
	rtIx4hFWJez6eugsOIQi/d1m7AEgS1YaH
X-Gm-Gg: ASbGnctwIJNqph8u1kMRt3y3mA1AIDnAoQAPqcv5f96AigdETL2uI0nSmf4CS4Gs2YR
	gyuHnrqrS95HsnVnKo23axs1McTYfxoTwLoRAHaAXiiXN5SMEKil5chVOKC4qqnKuq6GgtMZldb
	UY/oPFTjGUPRTUcZfXpLbn2z/FjqWCO/Jugf+zOTrfFIRFUUWx6ru0Dfk=
X-Google-Smtp-Source: AGHT+IEX9D6QAjgqoh0NMiOqrYMJpwOBg2NWUFC1v6AWX323PIE5m8UeDGbscgMVT692mfqq4aB2zRHxqkjIo3lvio8=
X-Received: by 2002:a17:906:dc90:b0:ace:cb59:6c47 with SMTP id
 a640c23a62f3a-ad1d34c01e7mr221131166b.25.1746520116893; Tue, 06 May 2025
 01:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <b4b7854f330af7588b12e3361bed40723febddad.1746436719.git.gitgitgadget@gmail.com>
 <CAPig+cQmnAiHo8su6UBaKnZ=UZwgwMbDFA6ewMAfvCRR0RFzbw@mail.gmail.com> <CAP9jKjFH_2CmvVAQwfk4KKTjDyMne2Wq9rkVnn+XB0dD5BEOCQ@mail.gmail.com>
In-Reply-To: <CAP9jKjFH_2CmvVAQwfk4KKTjDyMne2Wq9rkVnn+XB0dD5BEOCQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 May 2025 10:28:25 +0200
X-Gm-Features: ATxdqUHZXmyzRUtndW3XLPXJFxoBp01knG5ur8zchbrzMZM9aJ5nOoQrGeQCwTc
Message-ID: <CAP8UFD00bzcrdLLXwjy5yUrvXpnjTDG6ohMTahgpziRD63udUw@mail.gmail.com>
Subject: Re: [PATCH 3/3] add-interactive: add new "context" subcommand
To: Leon Michalak <leonmichalak6@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
	Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 9:37=E2=80=AFAM Leon Michalak <leonmichalak6@gmail.c=
om> wrote:
>
> Valid points, I don't think I have any objections to anything listed.

Please don't "top post" and reply inline instead (see
https://en.wikipedia.org/wiki/Posting_style) as it's the standard on
this list.

> Would it be recommended to update to test_grep (and test_config from
> previous message) in the same test files whilst I'm at it?

If you want to replace pre existing "grep" commands with "test_grep"
and pre existing `git config` with `test_config`, I would recommend
doing it in preparatory patches that go first in your patch series.

Thanks!
