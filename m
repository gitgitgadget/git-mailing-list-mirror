Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2433225AA
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544336; cv=none; b=qAf4sFH0WJbUYsWuIpNfoTBOOX2CvlCvyg9W+GwVGbG2rFT04OH0zFBHrMf4etbHAmIXgUEBWoKjgyd20y6tQooylXnkB4Iur+TSdOn51UxacS9nLtpTv7dBl5no4OTQVxx8eEOg08Bh3YPVHrwNXXn0rveGxJr1ZRg+3yG7j4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544336; c=relaxed/simple;
	bh=a9BPd9MaGTWV60l7q4zWyx7nGHBXsxoKJUeK0ihwWlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+ERFSqVtbU64IScGwZm5SoIS27WSXeFv8eUq7ZOLY37Xh5xlAkGjs8KahGVNC+SYvby6Kdf1BIyGxISFFFzVVq+p/8o3oG17+yjeSrd6NrFuskt5nOJ10uavqraoZbwfJPMqYhzO2N4ANSYNOyTuB55XP7gVxvG9h08IGit8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQkGLX+M; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQkGLX+M"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so873926066b.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 01:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709544333; x=1710149133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWoy86aovy0i+DGCjvZiU0ehQKQ8q32TwpZk3Dxr2bM=;
        b=UQkGLX+MdlrnYhB64fy7Ut0LNzFtV+Girlu3M5YipQYYB5lt6FBYNeVw6HDo4Nof4j
         o5bTYu11qJQsUQuTPsbnOkOfzP7Hz5IqzfXoyqIOtC2TJT+g6En5can4JDB0aUZVsYWo
         hgmwXzVs1GZ6zdNBfWwA17ZNW3TSLwf359gte5bKwbGER8oV/JLYTGGy9qkC7zfkpgfl
         fNxIOdhTxnLTuEBRRTZ4jHOuZURZxgYJ2EceKyq/+pSHAEGPxtTDSUUT9RHFhxmFabww
         rYYdx23I1HcoGXe9G3A+PlsEmYKJGUBIpHy3RCr49unNTknIeqfztVfgweWzte9jDkzn
         CaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709544333; x=1710149133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWoy86aovy0i+DGCjvZiU0ehQKQ8q32TwpZk3Dxr2bM=;
        b=TAiINkp4OEysaA/TE885WvCppwwMQpwUQgASf+3FbGOok/jgAuxOgZSsytZ/mdBFQn
         Ww0a7jsjqi3AKac1mBtUXND8Fpbp35xxF4wqolYvtZ0wnBICSue9ZxIdSTYmq4X7g/GT
         n2NVU+kaDELzr27z/Uoq7kvMSMHPAUJf0VVjhd43F5O0uaf5bE03mP/G4LmE8nJeAp97
         EQKafiul6jYOeCNbT4NFs6mBeq36+OQDCpPHcQDp8w9c05ZT6qDdwOVVe6ZfQmBOeqXJ
         f88NVFVS4+iTycEnZVv6JdOkyu4/wvuAhOQTdAf3TSNzw4a6MYM3jDxNoKcttCR2+gIQ
         RRzA==
X-Gm-Message-State: AOJu0Yxpr0lAtrOqCxfSeeE04v/x5tRM/AyL1I0YdQZ095Rni38Cr4qj
	c5HkS1bIyM9iiqTzAdJTX6MwaK5cMH4RBRTJd/JUqhnaenfgb+GuHq8wBDOrBfSqi5cgzx0/IkG
	tht9R7Vm3Uvqlgj7Y2cqn8egAm6Q=
X-Google-Smtp-Source: AGHT+IH/G5rGvtkWJn/D6RoziykK25g0XloefjwPFmbaNjX5THC4G/JULiNhAwsPNezjbntacfzOAICZf3tOxnYSafo=
X-Received: by 2002:a17:906:57da:b0:a45:163b:6a3e with SMTP id
 u26-20020a17090657da00b00a45163b6a3emr2975408ejr.10.1709544332771; Mon, 04
 Mar 2024 01:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225112722.89221-1-l.s.r@web.de> <20240303101330.20187-1-l.s.r@web.de>
In-Reply-To: <20240303101330.20187-1-l.s.r@web.de>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 4 Mar 2024 10:25:20 +0100
Message-ID: <CAP8UFD395xDjgqxg=S7dZrbnsCNsMEqQbKBipMU4m45CfT8f0w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] t-ctype: simplify unit test definitions
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Achu Luma <ach.lumap@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 11:13=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> Simplify the ctype unit tests to allow combining specification strings
> in any order and no longer require repeating class names.
>
> Changes since v1:
> * Added checks to guard string length calculation using sizeof.
> * Kept the definition string in the error output.
> * Added patches 2 and 3 with further cosmetic changes.
> * Dropped the last patch with the huge output for now, as it needs
>   further thought.

This V2 looks good to me. Acked.
