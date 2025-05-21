Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1523D291
	for <git@vger.kernel.org>; Wed, 21 May 2025 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819122; cv=none; b=R4yHDiI0OopNZwgE/wzCp/S0S3s4HAsHdzVAe2Vj+aWjNebqpWgBT6k/LlVEZmN0X2Do2AuRyZRt4BrKTvtpSQ9WS0PpqIn3/ZIK+QAEOireXFqKj5P46AKaBAQbb9SrZwEgaubKos4ff06BnJN9jhZbebS7krhz8APE1MoBsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819122; c=relaxed/simple;
	bh=yBhBis0X6XcXxUVDya7ja0h+Gwp5G6ZUtb0Adp2Lp5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Isanw4UMCDOxVT+p7nKU9ejqVBoUK7DeA5nnrAVsY4RTWU2dHYcWci1lQT7c6BgyX2ZTJhOzqfoI6nvNFbBADXd58D2ZRWmTkJ20zbhlEYHzvESJRiBHEWmY0ph7YZdO2wENn55syUyLQqefFSi3VeQTBghaWIRTbdqc4GcpDug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UHjHu/Jl; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UHjHu/Jl"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5ba363f1aso933038485a.0
        for <git@vger.kernel.org>; Wed, 21 May 2025 02:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747819118; x=1748423918; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBhBis0X6XcXxUVDya7ja0h+Gwp5G6ZUtb0Adp2Lp5M=;
        b=UHjHu/Jlrms3+Ya2XPIIbNtYZSwQsu+QEPOMhkBo9sZugTJyStW4Q9RxyJRbWYbAY+
         qj/63TPWL2VimYAiL6lcAc3xTlJFjmM9X+IjfX5YNmWOl/9I2aHKz+g6jJiHZBf4v6cx
         B5WPdZkDlWj17/x3gGqjPiPGHjH2B9rcEiTEZUO3XjENWI9HsLUef093N6eV5mMcrKVb
         y8i1yOry8TlDB95wxuEBnUYE7jbvGpTxXRUSb+3PUFYyH15cPhiAzTMehFOzhvyKb5hI
         G4V2RaE2RemYMPV5FL0hHAy24BSvfYRm2R2cJi0vj78qNYeMeo4gO6pA7skRzKVRXMgX
         I0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747819118; x=1748423918;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBhBis0X6XcXxUVDya7ja0h+Gwp5G6ZUtb0Adp2Lp5M=;
        b=R2szE4J0lAiO43S2SW1rFCR0zOKqFAwE7CRP5D8NfDXhb5DqGH2RMP+YvyapQJS9cE
         2Wg/FlV34Yq9qq+vFhFrykfbnzDa9qwNnHVW9Gqj3/3/x16A53lE7SUOaISeMOagrTpn
         9csCEn358y77pB4U/38KmpTOwIWfpWUg3t7DitRnKUFpBQ0ZTU+YlnV0Zn7Ii/rCTlsP
         FMCNS6TsiAHh0fdIDsVINQaPA6inMXjiHObXGeHOIJm0FHkdb1c9WtvJdDJXeodAYuIL
         fx6mFVDpbmFepWdjRjaimjH6/zNc2QkCQKGLQRjY1+lzjSm+CYStCNW92mBIRXqT3EV1
         4n+g==
X-Gm-Message-State: AOJu0YyYz4pfJOEGyO1dMGvkw6zIG4dLwTbDdOZg65EPy4yztP16biI0
	sZZMxk+1JfGpvXAmZ43bGKGE0wpUyErdUieiX1P3MOUAlHDEIBVQSkaLIBPn/uZy3lGj/Z1nzoB
	8dgqF9Te2hBpFDdzcCPtkYHKfhAri1U2Iiw3eb1Xc9Jk/OyKqbE8I
X-Gm-Gg: ASbGnctsy5zlsnq2lHl52HkwlnEUm5PAkmOmbTD9AES+RP1LeI1La2RIOHRTdNtrT9I
	io+KJ9wWJ+RMKmWwwzEt7vCblnuPwW3dsGEpf7fHNfR/MKkR+c4JmzB5LYgRJQrro12+Cq7Jj8L
	BuW+T4pUNMp394C9hYgv+ZxPssqJc9o12xeA==
X-Google-Smtp-Source: AGHT+IGyrHEkk11Pl/jg6KMED4UHvZHBjjW7SendgT3bjOwm0YeYdAjGIOqEFoUgHVtFlaJaqnGcnv0Rvfd/BNJf69Q=
X-Received: by 2002:a17:902:c411:b0:227:e6fe:2908 with SMTP id
 d9443c01a7336-231de3bb4a4mr288160045ad.48.1747819108012; Wed, 21 May 2025
 02:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521083521.6552-1-hanyang.tony@bytedance.com>
In-Reply-To: <20250521083521.6552-1-hanyang.tony@bytedance.com>
From: Han Young <hanyang.tony@bytedance.com>
Date: Wed, 21 May 2025 17:18:16 +0800
X-Gm-Features: AX0GCFu2BXlbl_vrPW7-f20vWhL90IhiqFyMOiBfXdTDgEED2sla2Dyt1kPbTzI
Message-ID: <CAG1j3zHUeGWQ-AD7bpJ=QBVAviBTcPi1yDRfM043+6sY4qkq9Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] report lock error in write_index
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 4:35=E2=80=AFPM Han Young <hanyang.tony@bytedance.c=
om> wrote:

> We can let repo_hold_locked_index print the error message if the locking
> failed.

One downside of this is the command still prints "could not write index" be=
low
the lock error. The caller can't distinguish between the lock failure and t=
he
the actual writing failure.
