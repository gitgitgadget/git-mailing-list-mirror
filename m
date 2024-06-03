Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C612DDAF
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423715; cv=none; b=IdKFnYrvQ9teMVkQFhSdYYPhArxUWB/GNcxNSQGqosgiO2IWMtStG8I1ZLGKxqPzxNNzD/RJrQ19xq6aurcRr7kyxJpvqNuu18G4oesSoDSWpvXfGtrcmTxpjApwOlJ9zMcrWrxK8PfNaHn6YQEwZgDr8dupPD2QWB/R3cu7+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423715; c=relaxed/simple;
	bh=2yS3YV1qNvXSp5gbTNrl5oqcHibwIlSVoM5DDb2QTjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YooXQI/cPl75YwK6nCfpOLBojQ6CYlCnWVvYshBjcctXJY7U4R80LClXtpGtr/AQSZKV3A7kYNkt41GLR7IPCRY7x6eVZZY/bqlcBlX/liiEgRdx/YXrR0pHgf4BHfwAzY/w10XkpaHRTDDsBwbBGwS409HT3AAhFgA9mz4PUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtEiAQQ/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtEiAQQ/"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-421396e3918so17381745e9.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 07:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717423712; x=1718028512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=svNLqO9KjgtlEUdy94aGyAjXJ4Izrqte505E/KeAYSs=;
        b=HtEiAQQ/K6f2U7bceO8hYmfKkWregQe1LCdtlUTUgEynDM0mknxa+7fX8XKEnyVOnt
         C3MYKkfiwqdHrqiEREj6+VzdkwcK5HLTGGjMb2wjZ/6jA2DU2pfifqwt8h/ugQZeTcg+
         4/b4GIZMXwLXcWumNI1Yr0AT9VbdUoVgU3grWFEBow9Xbi4vS7A779XIDT3i9OfPCGvW
         DlBOLgmLOgThkuPzpiio+V51Hrm7p/CgbxOaHFC7k58Q2I6nO9Jfq1+uFLtggJtULsTR
         LxUbxU8ArXJ2iVyA+yWIIRVoA0ZZTM9R5VAwVH6j8SS1dSSiYgDVAlisuFV/XtXtYpIF
         CHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717423712; x=1718028512;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svNLqO9KjgtlEUdy94aGyAjXJ4Izrqte505E/KeAYSs=;
        b=SK4QBM86KtRt0X028ph6B1Hpmw3qRBWK8plK//sORUoTWrXlA7ndSsDPanP+PDBTqo
         L4TkgTI2o1B7jUEkQHqee+OKisBd5YNSlvKt0PhoI2TMgf3Y5mLkgjcdo6pTDNeOU/jV
         4ZLaGu+cZ89Be9XqpoC+TSyHZL8eVT620rZhB0+cO7C8IRwt196azSCJe1PueLB3P6dB
         jkV8d4QefyxLtoO+yfdYf6TnLd2sAHYnqt0oEJbGhQfuOolM+4QMq7LdUMKsSwYcOkt6
         YIh7TZ9IuE+a45SlNVZUlyYOTgoozl+yyPtOgzJtMocxmD7sQFIJoffMvrWLxatH3ZuF
         OCPg==
X-Forwarded-Encrypted: i=1; AJvYcCUcxDtfYyUvqQH7SolRVQcgx4NhW6PgByPtZkZ+i6OQLbDZwrUH8kFr1Tb9PXK47pEsg7a7yZFSE4rKGZIhVLY4ibW5
X-Gm-Message-State: AOJu0Yw6jsi2q3WU3ysNImTeZmbsDdWuDbww8bYNCDgk/2Z/+fZjTna0
	LOaGgJQ49gSLKJkHdwgx6bn0OL6fY519OOjf/BfhDQDSbllrKhhT
X-Google-Smtp-Source: AGHT+IGJumqX6cHJJBXJ3YOrf6TPoii+L28u2GmFquKL4ETONKuATEVU8wQpon/d7Xc35aCkH1K3Fw==
X-Received: by 2002:a05:600c:1550:b0:419:f911:680a with SMTP id 5b1f17b1804b1-4212e046b4emr90824535e9.1.1717423711937;
        Mon, 03 Jun 2024 07:08:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062edbcsm8859564f8f.84.2024.06.03.07.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 07:08:31 -0700 (PDT)
Message-ID: <c2129c09-dd71-4cc7-802c-bf662db93435@gmail.com>
Date: Mon, 3 Jun 2024 15:08:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 1/4] docs: introduce document to announce breaking
 changes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Dragan Simic <dsimic@manjaro.org>, Karthik Nayak <karthik.188@gmail.com>,
 Todd Zullinger <tmz@pobox.com>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717402497.git.ps@pks.im>
 <67cb4de5cbbee7f7d4e22a7223a4838551956f26.1717402497.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <67cb4de5cbbee7f7d4e22a7223a4838551956f26.1717402497.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

Thanks for working on this, I've left a couple of small comments below 
but I'm not sure they're worth a re-roll on their own. All of the 
patches look sensible to me.

On 03/06/2024 10:28, Patrick Steinhardt wrote:
> +The intent of this document is to track upcoming deprecations for the next
> +major Git release. Furthermore, this document also tracks what will _not_ be
> +deprecated. This is done such that the outcome of discussions documente both
> +when the discussion favors deprecation, but also when it rejects a deprecation.
> +
> +Items should have a self-sufficient explanation why we want or do not want to
 > +make the described change.

"self-sufficient explanation" strikes me as a slightly add turn of 
phrase, maybe something like

     Items should have a clear summary of the reasons why we do or do not
     want to make the described change that can be easily understood
     without having to read the mailing list discussions.


> If there are alternatives to the changed feature,
> +those alternatives should be pointed out to our users.
> +
> +All items should be accompanied by references to relevant mailing list threads
> +where the deprecation was discussed. These references use message-IDs, which
> +can visited via
> +
> +  https://lore.kernel.org/git/$message_id/
> +
> +to see the message and its surrounding discussion. Such a reference is there to
> +make it easier for you to find how the project reached concensus on the
> +described item back then.
> +
> +This is a living document as the environment surrounding the project changes
> +over time. An earlier decision to deprecate or change something may need to be
> +revisited from time to time. So do not take items on this list to mean "it is
> +settled, do not waste our time bringing it up again".

We could possibly add "If circumstances change" to the start of the 
second sentence to discourage repeated discussions of the same issue 
when someone has a bee in their bonnet about a particular change but I 
think we can probably handle that on the mailing list without any 
changes here.

Best Wishes

Phillip
