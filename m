Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965FD5914A
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923317; cv=none; b=LzZjwu4QDJijxz9OjfTw4vhJDIs0MpJePek47rF+bnlwB44p77DHpVnDVJ9fcVKdk7memRwHrbW9YZevK2NzC1yOQs8LEHa9smt94HjFQ58JYzESHJB1NWs69FWZnMpAMdBmKzLQQkXgbngytmucWSghkvrAbQKhY0aAzbaII4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923317; c=relaxed/simple;
	bh=NeugtnWDQv5S0Volh0PHCMKK6rlyKeptKfrLW/kXf4U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=K7ek8NQTrgios+86IPcDB2GrGDtE6i/8IxC3mkqmE29ETIluN7lMSFBEKVa73C0huBhhaWN4WYp8MBoEdwYExQr8YgdOS7vFWPM9xU/SqcaG6v5e5sWH5gwlvlv6ESRi8pqvUOiHtFdnCZwTfdATt0nsgtK6vwloUqKNWyl97DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXoxOCi0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXoxOCi0"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso1911766b3a.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707923316; x=1708528116; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bO1Pv9bJY97ho4r8tSQhHMtQn2KJQ4zJSWKKmWQzc1k=;
        b=VXoxOCi0IDWDaRmRmpeYAQFW0ZT1IyXxR0o9l7rM51P9Ktio3Zq09Lhnf/+e6PB3iw
         s7JX/AC2sP2J0reDxnAG8wXKJvTPagu6g4iJX2aj+e6m44X51IhnlswavnGvCKvkvucL
         dDh8FZdqDjnhV7WHmIJ/sN3aDc8dr4iEBoQrYQCMkNOtRfnwCdIvEoo+5vo5BQLuKZbr
         aXfsBa/qLwXhaYyR8K8eg+bb5H4TzTqr/Gmf5+BSJ9KqL3SZhBJ97IQviidMaB9rvLv0
         Spsqbrjlc8nes8QIDBqwlrWKfTsiEnAAS0/CbYSE1MeRvFtcfVLzF+uBc60A5z+ed7ws
         OpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707923316; x=1708528116;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bO1Pv9bJY97ho4r8tSQhHMtQn2KJQ4zJSWKKmWQzc1k=;
        b=AB7CuY9Lt8fmLTHnHYe4C7n/tvTJp4nc9XDpHEtSUQ8E+dzbVhX8douJ+cGS7I5LhN
         bZKhBKJXF+fUIUSMC/rtfu+HUBKEH263sKKfxNSyzXA0cY/u6Fxe2D2LxiKTKo0Nlp1U
         I4HEsQgF0wK7X4RPlPjmDEqCFl1ahbgfl4VvjgcMkYzZIKQH0ymRuiXdBcjREGkilS/y
         KbOCJPr90TzFaPDIH9juK4pVUDao4GRKgehRrhXtEzNEyVd8Uuo9G32Dx+Z2L5n1G+Ce
         tQnHC+SyfgByk9LW9xi6F8pZjkJdYT0dKf13YLHjI72ogPZB7D8Ph3ONbfAViTqXcHWp
         Ofjg==
X-Forwarded-Encrypted: i=1; AJvYcCXs7nzl45eQCESeauCzrzY7YptneMba6nIuTqmxY6o7CsNP6+WHViBtYGnXRE5YrK4eJWenAf5VsIlmR6gOCUSdQPzp
X-Gm-Message-State: AOJu0YyDIOGCrj40vI7+JPF2X719VWbB2cJM3XSaCbBCQYJkHRVF2zD2
	ey3fvwu1+oAUJGAjZ5EHFqb02+TAKNuzOYhu+hXLG9XwOxNv4CgIo02YFvzp
X-Google-Smtp-Source: AGHT+IF0ING3H79ugFOvencekRNdeaU1ZLvQwfSOpPNLv3KOrxGBLcItjXWYlVZINyRKH4v7A5c3Vw==
X-Received: by 2002:a05:6a00:938d:b0:6e0:4a04:cd1 with SMTP id ka13-20020a056a00938d00b006e04a040cd1mr3163749pfb.17.1707923315553;
        Wed, 14 Feb 2024 07:08:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4sRk+Kv3LjKujIMGLbP3NyGgAmH/RpV72W5RYCwk3BTnr9I6jcoK6kKzaHJIjIhUJ4EnCT43r7WZGnWy0cP626lFw
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id b7-20020a62cf07000000b006e037ce7cb8sm9820096pfg.0.2024.02.14.07.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:08:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Feb 2024 20:38:31 +0530
Message-Id: <CZ4WA9QJXMX2.3BK6C9ZGOSN7A@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2024, #05; Tue, 13)
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <xmqqo7cjzhl0.fsf@gitster.g>
In-Reply-To: <xmqqo7cjzhl0.fsf@gitster.g>

On Wed Feb 14, 2024 at 11:57 AM IST, Junio C Hamano wrote:
> * gt/at-is-synonym-for-head-in-add-patch (2024-02-13) 2 commits
>  - add -p tests: remove PERL prerequisites
>  - add-patch: classify '@' as a synonym for 'HEAD'
>
>  Teach "git checkout -p" and friends that "@" is a synonym for
>  "HEAD".
>
>  Will merge to 'next'?
>  source: <20240211202035.7196-2-shyamthakkar001@gmail.com>

Hello Junio,

I see that it is already in 'next'. However, I have rerolled it for a
single line change. If find it is worth it, here it is:=20
https://lore.kernel.org/git/20240213000601.520731-2-shyamthakkar001@gmail.c=
om/

Thanks.
