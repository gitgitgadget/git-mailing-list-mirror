Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA3381723
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669790; cv=none; b=HxjsCst7qSeZMvHiByAj572JNuDO+Xtn78COmtmzIxKSb326ORHFc2SR2A50ihmnaY4MgBhQuV179b6T5r7IEviD3mbdO23+jxI0hrXpi2HPXB82Qnn/oyQ4J4xFcwRlmxCTeKOtelxygHi1+liqfEC2ixB9rKgo6QXi309SdqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669790; c=relaxed/simple;
	bh=uProWZ/r7U6rlPwYJqabYPmFb7nOaSX0hnOh6JZTu2w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Snb2Mlg3iIAT0EowiCm5yCrlpLybwgRW6kkv0p9k8S5qZN6pnI1zWBMDEM817VSUn2wVEr4KK+3KEV90xU6/Vhf0VDgezHxopkZ32WICb586zbfFTlXuUZ/MKqLDw42zuJC5jKVYFQ1ZpaGl83OuOubvOvhSDC1omzRkHYhnzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxnWHvRU; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxnWHvRU"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a994cd82a3bso323489266b.2
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728669787; x=1729274587; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uProWZ/r7U6rlPwYJqabYPmFb7nOaSX0hnOh6JZTu2w=;
        b=WxnWHvRUpEcf8C3BxWWAWF94U2MST74q4PkfBRLqoY/M+IyNJMJd92olqCXy3KD3oJ
         pzbRJInz5HbOxUc7vQccq/0V7humO17D0e84hb3iITADcb+VAKJzwRnCEyIfCowX+tSF
         s4OB0fjr6V7mM7vCD2ifpxSLXoz4P8n0/SQvgV7D6+SdPo7P3CQmEsNE4gsboulnEfvn
         IfKiXtfw4HDqyZVti1jKkSuXqJLKSGOa3CTQh6ggEmgXLPKx8NItaW6d5qsARVUSdETQ
         JVL94lwplezrgd7uhBzn16TlkowBG2yJcyKIhOa2r1yrsHTjW1l/Vzx78tX/BSCdvCL7
         dlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728669787; x=1729274587;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uProWZ/r7U6rlPwYJqabYPmFb7nOaSX0hnOh6JZTu2w=;
        b=fANQPP6H1fzdrs4+l+JfvpLoCeENm3mVaK4DFiufjQcLKFL2zfCw0G5fv3/eE+GBth
         3BMWAz1eR2iOPaj09FKYHgaBZHu1wUL5YkzFD34gh8Y7zg8KfuY1A2zIG3Ko7YnpfNk3
         lqJrK1fgLOo6pvIk8xQtDQ/1V9Ny3Fq9P53Nlqs8g0Sy4U9+94CYdM28AMQi5hBruUY8
         7K2NB7e0ivyhs42kSSFyAwWAgwXQO1lOWoIEcxSnawrhaspEt3PMv9+kXXsOKMYIeatF
         IVoYoMVfeqjan5uqRk3ikK0FAgHfQB7DhrmMkL2UwLM0PaMZkcRo74s9ZOuRCIzHzhqg
         2DbA==
X-Forwarded-Encrypted: i=1; AJvYcCVk8AylSbBtfPwNboROFGe/aZ/3JSwwkQ+qtoH44zhMVoITzWQxICG76tr24OxI/tMlsWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThyJcsydLWHHELW45iSMjB3aQwkEAKKCBmxLhTVA0/Ogx5oMk
	tasDy0T5NynChpJqiK8P2ghypOvuTwpBEy3ZMNQZy8Y4MmBCubkdNr0QZzY/bp/LXRl2hIt+Hfz
	TysEoYOP2FZK5JYiTOObyBw6Wftc=
X-Google-Smtp-Source: AGHT+IFvPK8vFqQOTSz5o8NIW31izJ1iipizBg54kUkAOmKOMw5xQm5IBOU7z1L6u3fjRGDGp1nBCmVqMPSTmhcIuYc=
X-Received: by 2002:a17:907:f75c:b0:a99:43b2:41af with SMTP id
 a640c23a62f3a-a99b9638d33mr290649366b.56.1728669787192; Fri, 11 Oct 2024
 11:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dhanwanth Rao Varala Balaji <dhanwanthvarala@gmail.com>
Date: Fri, 11 Oct 2024 23:32:54 +0530
Message-ID: <CABXkuJMYhq2ht-_edzv2AebGU1LDqi8ZBx0EE36KQ5ZMqSKzzQ@mail.gmail.com>
Subject: want yamaha piano 10/11
To: mdsalem309999@gmail.com, joswihart@outlook.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Josey, Sorry about your late husband. My sincere condolences. I
have much respect towards the music industry and would be very
grateful if you could deliver your husband's piano to me. I shall take
care of the delivery financials whatever they might be.

Thank you,
Vikas Bagalkot.
