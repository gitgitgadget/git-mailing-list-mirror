Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533E2AE8E
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466449; cv=none; b=rwr8dkDZRWJmrmzdRSqR1gXkjBpfILgEQCnGVvzaE9HltXbuTX0KpzbDdjyVQraT0ILK5dGGxqhfm+rktw4QyZd2JJYdOCEHKk2dVBWd+FnXWevtiu2zbak3j0WXP4t7YQrz9e67k855R735kq04IJnpXyGU5bGXALRoH9IJIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466449; c=relaxed/simple;
	bh=8rl1aiASwMUiu/WUhfPoWVGg3hcswW1F+liVcySAoos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wv+C3iPFGE6z0EcxzxARjUVue4cBOECCTieZPF8Ezde0OGjScPOs7ND6OU7ttkwWB8jUyck7DYVYDmf5sc08YrNWicqsuCMEAmqEpZlCiXRTqpNGUpiJestb7BCVTRSU4wuf5rnu0BvvsjCFRJzPSXowmVsI5PdVy48D7OTARfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+HNvYYU; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+HNvYYU"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-551b9d94603so1753661e0c.1
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760466447; x=1761071247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8rl1aiASwMUiu/WUhfPoWVGg3hcswW1F+liVcySAoos=;
        b=U+HNvYYUESfVYgU5vMCKE5hJlqXA2lKRAKp1awcnmVygn1rfEwJblC0i1L4sLka0on
         lwOjHvw4DifR09qZ4XD2Ac4YBrknBtEbgMy105hHxyV6ci9H+q9E0X2xXc+mn4loUsoH
         mCyXusxSSHeta3gWQAKh4S0aFhY2JVjmOppu8X93yUY34Mq+pc7xsiM8+faG94npwopI
         rMyoc+thpHgakpdPeBsmFvBVCVhK2han3ffAsqDCNFwgROs7LyZjPaTRMey/mwxG9cIf
         AEb73Lon3Xtp0WenIfv0dYSjT2XxKeJGirnisAq3Z7E02YEZHKt/AVLvASZJAZHrspKf
         0oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760466447; x=1761071247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rl1aiASwMUiu/WUhfPoWVGg3hcswW1F+liVcySAoos=;
        b=oiPiGua923TSEmT+FH6Bg0Z3EBsKIZpJllxz/f6EFbVJKW54VKYGuqmr+IcHXFKS7V
         sueofdPmoGuqa9CbqhtUQK5u96+Ku3WBuv0OOQzGKJgH16WdmFvclABDa6DwJrbKLY98
         u9ozS/Ajo3COSWCijMsFappIHjW8S4m9nb4vB44JsCM23U/PEqbnKHOmdOb4uoR7dkrk
         mo8B6SdSgn0Xv+Da+O+3YAiasVQSd1B0budhaYms83SmpjWzkwvKmaq9+fX1dpnVe+3h
         3kttfn8itt/AFKVFrvo4Jrc6O3oM+Aw4xUthR8aO+8/ggERe/RtlJsQqlgd0QITeXEBU
         beWg==
X-Forwarded-Encrypted: i=1; AJvYcCWJsr+oW65JVJtNQIqULzMszzUK3JmnSgikGj/+Wq+qGFN1ysFGXxhcUzm8Vc/bRUJDw0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZJWs5R11uObQocvJuv58HCiswhCrk8nh7aN86jRDo/bwF31Dy
	sE3bbiwnamSWC2vrCNYckT7DsrHgwkJSB5xN7G8Fnw3+hrlqfT45eXU0sc5tj+MLp0NzFTMvaex
	D4llP7fKn22FZhNDQ0oc6fYYR2NpYixM=
X-Gm-Gg: ASbGnctreFtakn+s2ULDDwje/MYVUWtZhgHiey4FhJnnZKI93ZA1gFa0j4CPqWo1p3O
	ZuJfrNFG9AVlTxwz2nJWDFVk1astfy1+EBcDrxIgKVp+Y9IznEuQDwZpc3a0qViyyIilre9xwJH
	zyCionEfbck+dkIIdZhj2TQbwjwwfIcNwl2lvRDOO14m1LqsLUZzroaagh9c4ENcF6/gq+wblbm
	biIYyDLcd5LbAZEXtlTAGZ+GFtlD3F9CnnbXtq5vZmtAF+O+3VcXrnZxdAv5FdCpCKi
X-Google-Smtp-Source: AGHT+IFiCLyRkalNgByZe+irYC3r064gE5UlpQ+nTwiqeu6+roMHUocAyj/kdNbjcWRr3EB18oe0CTwGv71C7pVv88c=
X-Received: by 2002:a05:6122:2190:b0:54b:bea6:a226 with SMTP id
 71dfb90a1353d-554b8c4f4c3mr8139520e0c.11.1760466446566; Tue, 14 Oct 2025
 11:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014161446.6135-1-solobarine@gmail.com> <xmqqa51txs66.fsf@gitster.g>
In-Reply-To: <xmqqa51txs66.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 14 Oct 2025 23:57:15 +0530
X-Gm-Features: AS18NWCwjQzzg_DnJLCcLUeTFIfobcHBUUOdCqIJRNGA5Q2CeuzN6AS7BLDc3Io
Message-ID: <CAPSxiM9Ovkoa18gY=0+5cCHukz6Ah56Q6wLwV-7Hbs0MeWjVng@mail.gmail.com>
Subject: Re: [PATCH 1/1] t: update path checks using test_path helpers
To: Junio C Hamano <gitster@pobox.com>
Cc: Solly <solobarine@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hope this helps.
>
Thanks Junio for the review.

I was on this before the email entered.

Solomon, in addition to this you might also
want to check similar review done by Junio and Eric in [1]

[1]: https://public-inbox.org/git/CAPig+cRfO8t1tdCL6MB4b9XopF3HkZ==hU83AFZ38b-2zsXDjQ@mail.gmail.com/
