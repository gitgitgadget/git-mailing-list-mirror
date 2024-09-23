Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA563FE4
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 03:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727063318; cv=none; b=evg/swGyszilqfZBb/tVj7gWmvMYaKHZJb2PUbH2Q7NRSKAIUfgosmeomt5UWSXFZEOfi739ZCZTStjR2fZoHTxk3o33Ik7CyQu2bZro0XZpOIq9QNL9s1jfWNV2ilaezpFwXgg70xrWKzmp4JU9OMugwO5mHm7bWg8JwTGuzCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727063318; c=relaxed/simple;
	bh=yG3BcHL704GZivqJJBg7FUYP1sl1krw9yl7WWUWrsPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhD7EE7/KTiPp2Xks2JOrh019PyEzN68jXDY0coKRMBGxz9t91I6XBWjfAcTgLimK6RAXoRCdW634jpGvMeqOBUE0lsXzWj2oFLZXM8iBbH0RTsUxr/H+yy9/8lWVFnkAbMfqt9KNyJ1yX3r/B2eVfsZ7V5RPrCMdMz4wePd+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=f0uXVsDC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="f0uXVsDC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2068bee21d8so38256885ad.2
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 20:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727063315; x=1727668115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yG3BcHL704GZivqJJBg7FUYP1sl1krw9yl7WWUWrsPk=;
        b=f0uXVsDCWIX631zWZbBiJvcjeRhKwHxAyXn/xKG4jkHwG8WoaTLf69x38ic2M2Ut48
         eVFaValfuhxM6yEp2ukqnVhToPV/ZDaP7PCoi5z0TkYmkn7P3vxSMbIHj7+OIQiVGFE5
         gGgB11faUEsUmB0HZvUrEwAEWBlJKDOuOqTV5BQTk6qNl1B/DvTu3VvTDZLUKKJhhjCj
         PQR2qz6fJXWp0378dCDQNok4SgIcoNg2ULK+WnNpJcsjXgpihg4x3cgxN56k/KB22E7R
         hD1uNhsxPox/wij1Lo+DixM2XBuhdqH+Nuklt4nCEdFgnXn9HF19qE8rZaP4aXXLtqpA
         YqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727063315; x=1727668115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yG3BcHL704GZivqJJBg7FUYP1sl1krw9yl7WWUWrsPk=;
        b=BH5MF/5TU3uNQxMpSc1jYhQM1Pm5cJbNL1DGrE8jWHpnUqcGHhPLs/JxIng9CIbB3h
         NffoqXfIHrYAa7bnKJEh358ayUAL9bRiCtgWpjs7FYEX6p8jK4Vv5jMQ23TkieD621ej
         ds7m2yB32rVk28JdoTn2cQkxojc/Rnhm4k/mPV7BrI6dbIVj/RN5TN+qo593UQ9Jx9K7
         UASEWEymE2Nn2Dh2NZLEOCOzH/aAbZJo+ZQWYUpxSXY5UH/31ltLWJDNPxQN8wnC4s8k
         +cMK+wX6JIPIfvonC/zogvyzwzoj55Qom+XP0yGlLeEUGaE9/Md51aoh+wiXcxDyVr2n
         Fkpw==
X-Gm-Message-State: AOJu0YyxtVmirkqEJZoqep+R1m8RjG1RqM4F+xRRv4nnFLgf1aySmOr+
	Mn3Q3dXOGqiKpyKUg/Jz+czhlez0dsy+jQm9XLkslqAk57ltJjQ+4fTxtESUYxu24kdHhYHi+DC
	caKuo9vwpgQioLtrykPQjhAL2MG0uLaMc7IBqulJQH1Z9p/ANeGY=
X-Google-Smtp-Source: AGHT+IEtmh5YfVljdkoga1P24ISyIW15Qaf9Ro1BWeygXFQOcspjbnZ/4GOde7S8Dpuc4Ry9mSsKysyttBnzm2tH0OQ=
X-Received: by 2002:a17:903:191:b0:207:1913:8bae with SMTP id
 d9443c01a7336-208d8397c1amr118100775ad.14.1727063315402; Sun, 22 Sep 2024
 20:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4B2B1EC7-6B08-4B57-A50F-702C031C2792@mateuszwielgos.com>
In-Reply-To: <4B2B1EC7-6B08-4B57-A50F-702C031C2792@mateuszwielgos.com>
From: =?UTF-8?B?6Z+p5Luw?= <hanyang.tony@bytedance.com>
Date: Mon, 23 Sep 2024 11:48:23 +0800
Message-ID: <CAG1j3zEg47RLYrVfJQi7WubgcdtbK2RWFBtj5rd8NtkPyXU5Rg@mail.gmail.com>
Subject: Re: [External] Using Git as a Database
To: Mateusz Wielgos <email@mateuszwielgos.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

You can use the --allow-empty option in git-commit to allow
such commits.

Thanks,
Han
