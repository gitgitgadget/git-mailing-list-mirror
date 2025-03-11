Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42422F163
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690467; cv=none; b=jfe7GM4jrhwrFHVMQdxqaJsdoxCyNeoTUnW4BtyoJqG1uzB1Z6C8Vy6wx75p/6OObRYPsdNhWpDOLzRvqPTrGmYJid2zkAm72QDAICKAsqet3PyzwURWgpfx4wnA6B2KnGsksquZHOf/su30LoqIKTOSVbbQVQ2Zyad/NGlX1Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690467; c=relaxed/simple;
	bh=zfdRbny7QLtc2q19uQQNwIIbW9F7UoH+I8QmIkWgoKo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=FDXr4BqYeuSV8C/KouI2zvzH9BoOYC0E0FTl95W8pqILgFDyHrvwLUUrigdL0I6xzdSajW/ckMyds7UJ36vVWvKQ1E2LpFbL7lXT+bINB4EV+E8vkeaXT6GadNaEva6zPaEKSYpvZ8LUaLt6rfw7w75m8OyvB4UMUqjmSWHe45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmJ2THHq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmJ2THHq"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2255003f4c6so47846105ad.0
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 03:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741690465; x=1742295265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvXSh1sJUe90n3lZAiOkp8N4vGiTbZpuEhgRTQIjnUw=;
        b=RmJ2THHqKdUJ8qGD4kv+9Gc2Ud5a/yQispRuCME73itpwgRr8NsYF8vtgQuH7J76/0
         zcDQg7vcFjFA+XNd2Rz/xo5r+kyoqhA5h9WUSmffinHrBP0c02+2+VQJluNXR9Hrgs1X
         DhkIKP9oYYOnUJ+uIrz/a2RzqPlP0bNYdfilZ4ilXMsmzhEITO6kp0Gm1caJqdB0Ucki
         yRKD3+HuVVOA2PtFkFKEyapS1D88CapateDwSgIK0PGe6Mu55tBbIb05r+KJLpX8kyls
         yopBYDVYDF/VVUhGdYLkQyQ8FCjNNX0SD8r5nkp5G4SJcLo8NSXrZLoKAViiscZtDfJV
         RXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741690465; x=1742295265;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvXSh1sJUe90n3lZAiOkp8N4vGiTbZpuEhgRTQIjnUw=;
        b=hQWy/Q1cy5b0sDiDJWDRotuCqMi7lyLXS9nKrcDVEwQzLBMSE93uZDoI83JanWZN/h
         /4j2vXibt+PP5l7c7CORn4RmjD1ouyAEr4wjs8Ytj+X0dEYi4pbKp6w01hPrvid5Ocvi
         UUiKNYGab9RgFbFUYlqmcryV49ux1Z20uc9ouoVjWE1XSDLpJxf6EYfR2jTOGrjF+PAJ
         tXXQlc1r1s0P5KPrMyWoXWwaV2A1uwHCdm003h6AqOTuTq9et5U5xcLUC7OZ9nWpfnal
         l2HrNHymR2JmDPWV/vZDTxnT6bwOGuy05EqQkkIEUh8/Jhwt4g/N6pWCAFsOGzmLGN7e
         jwnA==
X-Gm-Message-State: AOJu0Yyp83fZVXHo6nuNepHPKSI0UWhM9XLb+KHY0yalzODWqKhr59t6
	Kvp76Y+IFO2amsLAiU0sWVO7PQ/KiFQfve9PrKqQuKc+mdHrkfLfx3n5Fg==
X-Gm-Gg: ASbGncs9boYwj/DFCW6SKHD8+AwJKDZfEM4vRk/Y+NFP7xvpdRgjI/9wjh6UBdhrTmu
	qM0YuOTDpQfGP100cVS2f8GOM8HQfL2plP8dOHv3XrmUXCm5qpDEp5SMVW6ZYork1ORBQ+yF0RB
	kLwOaDdQadvYSn3aCG6oFoUElynVG39pwJ8PeDjDvR9F4F3m0Pusc0cDwZzq6Xw79h00ME4t538
	z4R018Zpwx4MNCkw4WhZiQnBMXq/XzmZdq+dNyhDhGPDK6D5B3UTj97GgjWjq0z8ffQVjSD3i+8
	HxgigulviJe77+tU2Plq9jfBatf6kDeENUgty+ZKuUR4XxiHUghbTqbuLfZ/34aMQWk2AHWAv9o
	NpED7mq6WNBtV9jsOmZEW7RfNVzv1VqcAOoPxAg==
X-Google-Smtp-Source: AGHT+IE6boC0ErIUHJVIGD2ZHwKwImNmHuMp+6vCWerKl/mrXHjUzFWj850q/Ifvgv29YCJd6ZI7xA==
X-Received: by 2002:a17:902:ecc8:b0:21a:8300:b9ce with SMTP id d9443c01a7336-225931af245mr39052015ad.49.1741690465407;
        Tue, 11 Mar 2025 03:54:25 -0700 (PDT)
Received: from ?IPV6:2402:3a80:4190:e364:c141:c68f:80d1:8af1? ([2402:3a80:4190:e364:c141:c68f:80d1:8af1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3010db4691esm204427a91.2.2025.03.11.03.54.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 03:54:24 -0700 (PDT)
Message-ID: <65ea4bed-1513-4721-af63-1ebc78194a7d@gmail.com>
Date: Tue, 11 Mar 2025 16:24:21 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Defining timestamp_t as intmax_t instead of uintmax_t
From: Arnav Bhate <bhatearnav@gmail.com>
To: git@vger.kernel.org
References: <629c3c21-ab11-42c1-8cb1-34698e736db6@gmail.com>
Content-Language: en-US
In-Reply-To: <629c3c21-ab11-42c1-8cb1-34698e736db6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Arnav Bhate <bhatearnav@gmail.com> writes:
> This also means git cannot deal with time before 1970, though I can't
> think of a scenario where it will have to.

I just tested and found that if the user enters dates before 1970 the output is
incorrect, for example with git log. This error also seems to propagate to
GitHub. This may or may not be related to using uintmax_t, however it seems
likely.

-- 
Regards,
Arnav Bhate
(He/Him)

