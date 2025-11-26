Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327219006B
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188193; cv=none; b=DRbyw1I625Mm0MbMG7tdffNSccK4DH+IDSkTfzsEk70BKFNJ6IhzOKq0O5V0uZs9ZhjotHV5wq0xOOKpimjfgYUBIUHku4lFVrIKWKiv2T6s+lYXU3vY9OvbihyL4sgcIP9Jak1+RfjetAjr8gZt9fvxNHazZPzSJFbe0VXGRS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188193; c=relaxed/simple;
	bh=AS4xleYAxtl85Sy7pG3vvWbRyFfEovcDLuTXdmbtKhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYLekODRIhnbK9zo7AMdLBpVcCVJEiDt6uWH4rJ4tiQvHHfKXL658kEJoLguNAGPxkzJtrFPD7RL2EdDUDZrf+TOnv51fliEq74betxZUsf8hO1kHcxNoh3yMDe344arhSzOa55z9qYGaAVD5l1P13B/4TU6vFaGRZWhno8lr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqPRbtt7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqPRbtt7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47790b080e4so355605e9.3
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 12:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764188190; x=1764792990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AS4xleYAxtl85Sy7pG3vvWbRyFfEovcDLuTXdmbtKhc=;
        b=nqPRbtt7Vz4C1t9P4qdqJ8Y/UeAm4e9t3pfFp0P4MStRprHkmE9moqEfnQI0F+Crvq
         FjmIWYhj6KJJ4f3hUn/JkRnuVmKbYdqeEnfzFRcoKGfMPq0cof3d2fnTg0/nB06kaV2X
         yfiS/fI33xCxwrQL/QJFMOmH/QthDnMJ2Oxr6Ec1yLtAI6f954TR1QJsK1uODMXSW381
         rVmcc4JpBBPAHTN06uAYH+vibeMbg+dMlhZdnjjHL5S6scraKC96B+kZ2o2zRt1YgFbu
         cNMcwg4GSK9NyKTHiP7WQ8llVh5HazIscw9vURCPcb8qItWZlIxdtqk2u/0xpasXY8Pq
         ECgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764188190; x=1764792990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AS4xleYAxtl85Sy7pG3vvWbRyFfEovcDLuTXdmbtKhc=;
        b=i27V5G5HCMDOPH6dqEX/6hgxF4W3iNj7B+louaXm6AOuGkUNBrZ031utkVQqZRX6DX
         B7Mrbkf6AhiVAm5vxLkJ6lJFMm5QL987+F7Tu8t3kjHCGReG5sZVTNzg9pfqqVu9Yxby
         umnpVCW5Ctn985wWVPAvIOAfSwelTj1omS6/1MxdwAnf1rOvjlQlhoQajb3CASFnAVCU
         qijPhlrSvqf6CWwRWesfBLFeHtR7VHuh2v7ouvKfqcqqF7/d3bZHtxXDnb0Niz80mWV4
         zOyJyHlE7rG5dHzgW2p3nLwKcUlV7Zhk4/OAOdJCgzSlCIB/mSoidgctuTJ7W5iODbsS
         pjvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaAsRknwwcHLUi2GL7DpfLoLkM57JbTIGzpi13uAWDSiVUH/zxw0f5md997Q1xFcaRAnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9YviENaykc1ipA5OZvNel73+5o/1LrCQNcXO8k1xu4TMjr+m
	YdOcdh0aU/aqEs2Z65xC+56+pm1oh0syLJNLwkmY4l5EPNOTqfD66hAnhM3fHbklBHN2atz98l4
	0vg3dw6hqucbPKT/RpyJKyY/MQ29jETw=
X-Gm-Gg: ASbGncsKTuG7Hm1bMhkjPVy1SDLVPU4yASXnJZG0sFQh1Lcu27rRRwbsFc8pZrJ9jVs
	94nzlZHfs7Na181k6JkiLOWtclg6HzLAYDXlZtHNxOifKsSzIBn41BS6YxiX4n2FlwijMt5/vZV
	HMjl5rmGKDRm2uDRAN5IeBTBMpDreiYEY6cYheq7zoEhQrtAV4EZhFa8KMtrHdvSqCKPGxAFqky
	d7tY5TjrMBKsFxzpEJULaH4Uvs6JFfJoOfRTTwJXSUcWfCuAZmVksHpTuPKzbIBaMGCownnfX44
	4XRMLg==
X-Google-Smtp-Source: AGHT+IGWScmazBHma9akar+H3+wnSE3iu1A44tGey35P79k1tA4hQGIX3azefSXcsq2rX/Jhr14/OShUGuVvF97nGRU=
X-Received: by 2002:a05:600c:3b01:b0:477:9cdb:e336 with SMTP id
 5b1f17b1804b1-477c1119e60mr175807635e9.21.1764188190325; Wed, 26 Nov 2025
 12:16:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2109.git.git.1764152756908.gitgitgadget@gmail.com> <xmqqy0nsmxvt.fsf@gitster.g>
In-Reply-To: <xmqqy0nsmxvt.fsf@gitster.g>
From: Yee Cheng Chin <ychin.git@gmail.com>
Date: Wed, 26 Nov 2025 15:15:54 -0500
X-Gm-Features: AWmQ_blQZK4vQnRCvavmtlypZXOIkCJtcGJQg3Wo597USLJqL_tuaGpjM-d-z4s
Message-ID: <CAHTeOx_4WSLHJDixkshN-e2pqMS6e2qMKnW25x8ed+GOQBvj3g@mail.gmail.com>
Subject: Re: [PATCH] xdiff: optimize patience diff's LCS search
To: Junio C Hamano <gitster@pobox.com>
Cc: Yee Cheng Chin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks. I was personally surprised how this simple check ends up
bypassing the slow path almost completely in most situations.

I just noticed I made a typo in the commit message (misspelled
"pytorch"), and will prepare a v2 with the fixed typo.
