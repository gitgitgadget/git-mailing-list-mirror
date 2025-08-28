Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59722FDE8
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398745; cv=none; b=eYfmogMN6tduO2CyfpZ+WMcyGGjuG4Mokuhljpp4vCVmE/ac1MmPtG7oHooCHDp5z6UTpfU4vftVuP4YHmSp6j08bhCtoNsJIAg1d60Djogxhp+71KYT5ROs9UQk6INg92TMFXdvioPD7hB3gJF9whbtS2Gt467f+ePn7wKkcyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398745; c=relaxed/simple;
	bh=YKw8LZS5zA+doLnXigsEg3yzi0tY/JbHMQIwtwjt39w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uV11rxQpwljdOZv33wv+cWu8x9Jim9AO3oe9bT0n0rifKB9+RxOXue4oXntj40Wrf+j8FE6d+GJ6AtwvMvqDIZ/LNf/HHSK2Z/V9aB+LyhZrBpFPr2/AzSKCnJiN402SAGyxlRHXBkX+YSfedTRaqfxxJyDZibza5ORUKnriscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTbL1eWJ; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTbL1eWJ"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ec4802d41fso6884975ab.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398743; x=1757003543; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YKw8LZS5zA+doLnXigsEg3yzi0tY/JbHMQIwtwjt39w=;
        b=OTbL1eWJqjrzLueRIFHIkEXF01D6RxeTZ2Izbvb5PcC6NMMgt+J7tWDrzZVVOEBCe2
         GeQNesx+SU7+hVv2eOq/Vol2d6RHbKSVp3MHg6VylDhlj8ygMYsLxPVukJV88haSmYbh
         gd82VocRscn/kBXO0TQ2KhdLIYp5oA5F+yWDuNrW5GF5HiKWMfHvLcfHPqQNRLswfsvp
         oExgEavQebJtAdXRpIfPNLQCOlAhBX+hAsCcE0EI3FOHDhTMq8CAqfG6cdnnf9JEoxMA
         6HXJ7VLp5z5DxROOjOkNP/GJRe1qFfywCEw/xwx2m6DqmMKj2UsXzA2n6qckdli7Kyhn
         OpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398743; x=1757003543;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKw8LZS5zA+doLnXigsEg3yzi0tY/JbHMQIwtwjt39w=;
        b=Gw850vNAXJZfm/dNv9zl/S39RjGg6qXNxA28rVSWFeav0Q8dXmEiWGzT922f2vX1Xj
         owicOpdoch85nw/i3j3F30OAwjbZqUnVyBYHoyn+YVcApu/bUGr2zDDCk8lulTqYCJvb
         6f1BzyTt1a6ssEeT3MTXI9H88a0BB9ld4WKTJFeG8BZAcHvMkhudqu0xKBLyTSXP+fWr
         tcHUFCmtNQX2hxvIrJftjUuaPNuT4/VaABbi1GnKjZnbbhLXUEu40U6DguaaubJiLaWH
         wOvyFEbPihT5Yz0Q//68QT/M+oPeWbDjZdn1YOoNVooO3p6fVc9n6VMuOUW95ltLlwGb
         KwGw==
X-Gm-Message-State: AOJu0Yz97pJdyMALgKPasTK3HOFEtZqcwIjP8071k1J59V93VzhPw2t5
	5jVIAObn5g8rsUsnQk4chmYToJ50f1pKCbgh6z09VAJIgou1MbbqNFgxXfRAQC8dn1rccv4ATRB
	3s4doQZUUECcpGddcN6jK0U2wUCEx/LUiwIGmz6rm3Q==
X-Gm-Gg: ASbGncsjMQnAtlJZbOFHGPN5DqgH8EQBgWHMAayijshf9Y1tDtKJ/s4bF7PUk99zT42
	CdziosXibJWdyNlBLrpOsC9Kwh5+CNiUDm8YHR/Jxwwvsv5ZZVleCiRkuWtknj1vUbuzZxpV2f0
	rT4ujHs4YzmBNkAHiIh/mnQhtdmHkR+v18uR13QNhzJ3Er3x5Da91jOCdssW2EwfHQLwCcYAxOn
	P1NCu16FvLzuT+LAhgucVhktuhwMxPfzq4WS0YY/kzGbtCaiw==
X-Google-Smtp-Source: AGHT+IG4i38v44WNojcuGS29BOznNszhdY6hFR7a5E8TvrigHkhx71TRFLn3HV/AWzLlw+InAkqkFNkwj9y3lqy5xQs=
X-Received: by 2002:a05:6e02:214f:b0:3e5:52a3:dade with SMTP id
 e9e14a558f8ab-3e921f3872bmr330731395ab.16.1756398743051; Thu, 28 Aug 2025
 09:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniele Sassoli <danielesassoli@gmail.com>
Date: Thu, 28 Aug 2025 18:32:10 +0200
X-Gm-Features: Ac12FXzeoMRKqSe9y2Hqpsb_r-aqwTPwCzIK4WIuGS1pwVqDld_KYUg-bvflAXA
Message-ID: <CADR1ei4LFVoLhMyya+wx8dXBmrRNSNy6L5Ye_MJgL4kzgtVR_A@mail.gmail.com>
Subject: question: what does "garbage" field in "git count-objects -v"
 represent? Is it broken?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,

When reading the output `git count-objects -v` there is a `garbage` field. At
first I thought this would highlight objects that are considered "garbage", i.e.
could be garbage collected. However, I kept noticing that this wasn't the case,
despite my repository having plenty of dangling objects (that where removed once
I run `git gc --prune=now`), garbage kept being 0.

I then turned to reading the docs, which state:
garbage: the number of files in the object database that are neither
valid loose objects nor valid packs

I don't think I've ever seen a definition of an invalid object? I tried adding
random chars to an object, effectively corrupting the repository(which `git
fsck` correctly picked up), but count-objects kept returning 0 at the garbage
field.

The only way I've been able to get count-objects to report some garbage is by
creating files in the packs directory (or in any of the sub-directories of
`objects` folder) with random names, like "test", or sometimes I've seen it
report the existence of lock files or even preserved files.

So my question is, am I fundamentally misunderstanding what garbage means, are
the docs simply unclear or is the functionality not working as expected?

Thanks for taking the time to read this and respond.
Dani
