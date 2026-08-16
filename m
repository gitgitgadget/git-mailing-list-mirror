Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0736737E5E2
	for <git@vger.kernel.org>; Sun, 16 Aug 2026 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786841645; cv=none; b=fJZO1dOP/rOq/3PTNJtPS88WhC3ci8sM6LgAX9qYteD//8LISwAyGKgf3OuvAzkyBvAxQzbAEZX74Eq6Vrp/PRpHux4j+YsrEakr45nmcFSn8/xazRMWexTk5mSmbKGX54FXCxNq/31b9I1xg+KkzGgIDqCaj5xVXbj0HO5HfJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786841645; c=relaxed/simple;
	bh=2nuqteX2QXtvYUIKUvzlTkIsTcoM5JJPcDVolafYPOg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NEIe6MVtyG04rx10wsE0qLoSXILMlMKOymRFxINp3OwkyATMAKY1mySv8z8WCfSyPOzQpenMREdUF7T094p/e8yV4sOZb99DD7PwQPxoJN9AhAdhP2PskA9kTjDaLEmgmjWo9o9jNMRy65dEzv0zuBT6P45oFq71I8QimAKzBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yti/sBAe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yti/sBAe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d5655cc850so3852555ad.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2026 17:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786841643; x=1787446443; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j7WD57Hb6yfbte2Dznk3DTRnBiMbCvbsFgGbm+yDGDU=;
        b=Yti/sBAe/x7ZSNPiDi0HRWp9IReWQnubSQiQvg/mRlV50JRvde52ZL79xtsitv38cm
         T271Yk6/NvF+J+W8YL+KyoWbAvOCCW7bXCIhzIwdWu/XZsllseGtzqr+1wbla08rQ/YD
         HNJ7CdNFgkhDtzCY2tt+xDn+PB/6sBjFlMns1OtdnOwJG/qzxYR+bm/vn2zEEFgInZcT
         iUhRFc84DEFyY/uBomRoQoSUgWtziiABbZp00wuKL4a9sPMIWl/zYCmDAbIGKHweuvWv
         QLPbswNOUfOagzDU7m7CEb/sY5PvBDhlh1DVsNW9mHm2OO5wFWA4QXkANKMP2IkIfp8I
         Oo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786841643; x=1787446443;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j7WD57Hb6yfbte2Dznk3DTRnBiMbCvbsFgGbm+yDGDU=;
        b=iozwafqnmVovr55ZqXJDawtNiMRooDI9rAweBuNS4yA+L817ZjKcyFphdhBnfOF5kz
         QlosVk+eWW+MsRa9feRbTi8/tpvGKCoaPlE2HUcvK0TNPatgzMdKW21yda744xSsT0o3
         9i7WjH9xPW5jVco7BP1wyk3LXVCAwtcP8yEfu06gDKxHVu3Ea6FiYMfDII6kkVvWEk7D
         dydqQXJ8wu1Q/MOGn5CZkxhv38WuCd4UfKrt+WSdF8UZ2eyy6p6pAJMjqJNAeRkmPtYI
         pvWtP7Z+95nnsqXfzoc5ZHl1WNZ2qKH/KivOIJcXUQ8k+ZP398xgAujnbj+LGrTmvRKw
         5tGg==
X-Gm-Message-State: AOJu0Yy7dHB0Z+gwTYl0IH36/f5OtTB9uZfEXhhM1Jffrd5xaPJ5ZJ9z
	Dwn3x4cenLjli7YKVbtw7kaBZeu1ENDhiahj5mQzHNDhS/thgw1UR3Tb
X-Gm-Gg: AR+sD10YGdohoxZnxA+JYg5ZJ1NCt9+bzuyOspO5xAauMNzoWLNPMvVH2fWOM83dElu
	0hJurhvivNF9+xuRv1jewOYtEx8Z3e8U8onsfBWLhGMECubyL6a0WQhrA22ulet57T55h9F7hTs
	HSB60KQF48QGoRmqy13WmWTlh1g1+4Io7NzUYSItH9/wX29tW9zc/PjCnZE1Ef4sfKmH7Z+/oLJ
	d1AJ1k9ENPdf8sWOV7upX1VpQc7MBdrWoMrOSaFXIA/VhZXUYcezQGiO/76ekUruDiO2E7uBiwH
	mRk34eCtJAWRd04gDHqyS9BUXhXQnsfFmlSZDhIx8v8vO+M4xb10l+Kvt6Tc2ySzqyJ84aH3qJx
	K3j0+4NfwtSmyHBY9gT2feYrLeFPsf772px4I1aUOwX2zUeVmgGVqBsZ8M/Ua3C3s5pJR9/nWTe
	YjyiPV7YSutTgIZjERoq707Kndja5EAbmx+5sdqQba1avW3vd7W8U8V5/FoRUQAClLSkrwJqc65
	+CkKc1IgZivOWnA1w==
X-Received: by 2002:a17:903:37c7:b0:2c7:f2c6:89e0 with SMTP id d9443c01a7336-2d3b08053b6mr193161255ad.4.1786841643240;
        Sat, 15 Aug 2026 17:54:03 -0700 (PDT)
Received: from smtpclient.apple ([177.33.87.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea90010bsm21152920eec.30.2026.08.15.17.54.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2026 17:54:02 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [GSoC PATCH v4 6/7] repo: add path.git-prefix
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260806101556.162940-7-jayatheerthkulkarni2005@gmail.com>
Date: Sat, 15 Aug 2026 21:53:49 -0300
Cc: git@vger.kernel.org,
 jltobler@gmail.com,
 Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 7bit
Message-Id: <6E2B0ADE-2101-47AC-B11B-315897AC2AF9@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
 <20260806101556.162940-7-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)


> Scripts sometimes need the path from the repository's working tree root
> to the current working directory. While this information can be derived
> through existing Git commands, `git repo info` does not currently expose
> it as a scriptable key.

Even though I understand that this is a relevant info, it seems
to me that it's a little bit out of place here... This is
a "current directory information", not a "repository information".
> 
