Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B01D5154
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753805919; cv=none; b=bq5KTD+RD7b8yfaH1wH5RJGEylTvcZwc7R/LgZ2ezH+nKNB1hjgDZCymUS8JtQpu+O6Ob/Gg+NYOCnVnGKywvQwGp3/F26DV3OrVy9IQ4TfEeg4p+iWxRh+3V6HmvAPc1od9h01myvdBGxEzIbnrOhmK7sAr27AAm+TPh1n4h24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753805919; c=relaxed/simple;
	bh=O9Y3Su92q4Klikn9ns8P46Iy7aQsq++NnsP6jKKj6aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q758REJgL7G5dwJTu1etxSLJr66SPlbFBKjOQrIAnZER/TL4SPhx4Y/8IJgRJsdg6QU3oZxH3tE55eATGPr2j3IE2Z3+wKH9xuGqA65M6Yw0heYHkFpf5EFOwPKrz07tiTtCfqjfEMZL6RY3GrapEto/QZFJ5hnAf6EkkLf/aHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyLoQMqF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyLoQMqF"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55a25635385so6385243e87.3
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753805914; x=1754410714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O9Y3Su92q4Klikn9ns8P46Iy7aQsq++NnsP6jKKj6aY=;
        b=LyLoQMqFkJWFV24oh+HaQwtKoFqzgkU7+OGP7L6LKNlRCVSQvCPMIdeyNGkDXkgL9x
         +fIJuJhO5mFTom42x8QAg5Hae3gRTAxnkzoJJJ5BjM8ZjdvXkqrEqk4SHNl1X7ZR/XJp
         v/A4Ccwyi8raSpHpTC8gzU5dAdvYT3aiZWuDmB16AWcfY2F0ufWYq8YtJhUUr2YQT46o
         qjQO7btmPodpce37Zi1FJmMUlpchFi0bEuyf45wQ/aiSREQo+/gOMLh8AWo6WGnKraQ3
         xw+u4M4WOND1LLItcKCY6ZSHG0t6VqpMAxwaAUC+CsYR1TK38ic0TXXIVCL8fcxiwQFl
         RlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753805914; x=1754410714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9Y3Su92q4Klikn9ns8P46Iy7aQsq++NnsP6jKKj6aY=;
        b=DgEyNNW31l6NzQPFyMCcMK/yPs4yiAeSrdgvpFta9NBbGZ8kLSJaFQvv7L4xlALpIU
         W5POtpVXCJslcIE2KNJAwCyFeu1aX5E1SXgg9P+7qir4140qfwN+gOKtqayVBaE8cUOd
         G6w+wX7oHiXwms8pC9Ser0uHfrJfHLLNIoLT8bDe9TCO8KEge9tynwUU1DGDwv8rD4xJ
         y2SsSlDdpNmm31U2uEjOqLbzwtpIvipsIiiHPdGfq8Ybv835UC+Z0CtNgTBSvRpvJNpY
         qYxXj9TkCmtTzXJMDK3HPrErtmbriI+vVSqYVB1E1KO6hDfNipBo8HxO6BjZRCnfPd5Y
         K0rA==
X-Forwarded-Encrypted: i=1; AJvYcCUGV+WAGKU1GJMz50fI4ZF0Gx/zG/RjD8ICbXRSDnUcG/jypiVGI+BoZAGMBskeFT5jfoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymNRVzOjyTn06BQq/xl+pYfmHRYDyzw37HiIFgkwHLR5UfzwQc
	qM22bYxhzA/vkBa2+QrhE2Bt+WXME0LuxTusp8aEGW3eaSGGMe7LAu40KJxPxA0OzlidEzWjeUi
	VjhsnPBWCsW3y2YADOFsDLyZHWquRyE4=
X-Gm-Gg: ASbGnct6GdTzwMQ+QJ6jMHWutBpbwEI/JkNmVVxXJJnQj2tTzERJgYdlHNja+TWlZVg
	FRQLFqqh3Ho52Ia8Erix9cTaugeo0Nc3yxiTzhDFZ03K5dDZ9cRxuPilzemaKc7sfblREo3Q4Ic
	y/dcgKMtdEzqIXTQvpk30S6omXtH7cmbcQTParp7QOJfKTzS+UR+dOHsaorMUYSZtMum+rqcIq9
	7xjb+6qKJC1EktTW+Kj1gH54b3j2xDvI3mD1+5IoA==
X-Google-Smtp-Source: AGHT+IG6BVAmWZShpUaTaZmjLwepyr3zLtfzcDQzeBevz+Qq1sEyRz524mRPNycSJf6gDPfzzap8AKwDlH8VBM+p4NQ=
X-Received: by 2002:a05:6512:314c:b0:553:3770:c912 with SMTP id
 2adb3069b0e04-55b7c09e438mr52023e87.47.1753805914083; Tue, 29 Jul 2025
 09:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
 <pull.1915.v5.git.1753772511.gitgitgadget@gmail.com> <ec7481b5-5244-4a76-962f-d3bed9e4172a@gmail.com>
 <xmqqy0s7ouug.fsf@gitster.g>
In-Reply-To: <xmqqy0s7ouug.fsf@gitster.g>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Tue, 29 Jul 2025 17:18:22 +0100
X-Gm-Features: Ac12FXzjrvyO_i843HrMjsxMzxngkGbZCIino-O8szqIm-Y7lj893Mj3sK6pShU
Message-ID: <CAP9jKjHyfr-E44fWkrDE_zAWKD7OS45tOf1DgGdBzDoxEty51Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Better support for customising context lines in
 --patch commands
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Great! Thanks Philip, Junio and everyone else who helped me get this
finished and in.

Was a good experience :)
