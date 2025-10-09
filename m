Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7E70830
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044175; cv=none; b=ainWKLAWom8L20X8LVwC3L2p0pRaZWnRzRzt7fCoxK0Svyn0EXfJ5iZs8l1tfnOIEQ17/pKehiiX2eaN+O91DZvHljUsKZ/dMq2Pu8XtdHoaqv8KZCzUwTK1+qLb5a5bBGEy2RLl6n6cLpVpz7dqJKgNkUMwjp5jM+R1nx0Q8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044175; c=relaxed/simple;
	bh=EMx88qo1BPhaalhAsMQ2vxAJ/EOfwVXRtBjBqM9VzQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JcLc0DlumobgrgbgXATxL8iAnO8Y08kRxe7BqHu+Me9GNV86gRI2b3Pyz3gdUjgf795zZcXR6EBOJaYq54CMBNx5ruKSi77W41JpgPoEXn6NJiJgcyTa/6A0JeBkwofUjhFeuGQBZ8JmgaK4IDFtaL1UtgPc7JS4xDetKZ33XnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+oEkGj5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+oEkGj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760044171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CeVfMWLyalpTT34mX0mA+hs2M+re289FhYXudsjyF1g=;
	b=X+oEkGj5QSbK/3e1l0xL0KAPFNq/9oKNiAzOY1aBj2wRcvxTDMrzVwyXyy68xL8gKJ9kMy
	KFdTpnUQOsa4iT3Qp05KF25ruigdKfnbivyMk9Ana3TGMgbsXlIymUIRRemRyvuLcDLYBS
	7j+BWFA+t9KolX6rYUxt2xlcV9HOAPc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-N2LG0I7EPpKS0igNZKokLg-1; Thu, 09 Oct 2025 17:09:30 -0400
X-MC-Unique: N2LG0I7EPpKS0igNZKokLg-1
X-Mimecast-MFC-AGG-ID: N2LG0I7EPpKS0igNZKokLg_1760044169
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85adb6a349cso495041785a.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 14:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760044169; x=1760648969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CeVfMWLyalpTT34mX0mA+hs2M+re289FhYXudsjyF1g=;
        b=D7i6xCnCkAiKwUzLQtE04DfaCQQfOsOOxA9RSqxlXNsC7u8Q2yECKGZL/Yur9kxvfp
         3slvdLRA8Bct/pawp6TKQ4yiZ0gYYEL68aX0NeOj6tFNi6swQfFdq67kod8FKN4JVXDO
         0GW+RXosEgl5fjR7vVypAYS0BWpKU1J8Yypqez23KpCEPogAgk2YkzC3f6pNOiKF6qUw
         3wjaTZ8nGamXjEWSdfLztj9hRgcekOLVY57sdWZuBZwOu0ERgYHGHPu590FxbWo01nc0
         nKGuQ4SCpbGZ+wg+rqzP82jrxlTsz8XR64ClpE54HIW7r3OZ6mp728xMSXRMbC342JZI
         fG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYRY+xd8ao/CDcFO6KmJ6dSJrxTXAdn8O/ALPZNdtvJ49TtFQ08cOVH1122m8A35sYWhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwuFeGuRD9giYyFiSLmqe2buPGqG76jLfLmHaB9aZ3OXT3A3Xk
	IguhH9PUlUh1g4yVaQT6lQvnah2QB7G5CObwiscye+gb/PK/nhb5T2GbNMVHuNtFlQZCFTGBv2S
	thj8Fb2Jfff1m3IQCLvSwG9PZTIDgfjZz9gocaPr6RCJbFyCTaO/G3b9L7mkeKw==
X-Gm-Gg: ASbGncuGDDCL94xTNAK05AsZlqp8VwYsnf0ZnPKuUPNHDbaJE/PIgrFqfKIF1QiqMHo
	AhLwSWcNvxT60opyyuASi+Ox9Ul3FdeYTVdWz4uHX51khSJMLcCt2RCankIFZ62FkNOSYewhsoo
	ugx+cOUn+vBEellAWYyTbd++sAWn1/xFb5Q+u0msVbo+lrONNPczeAjsou08m9ANDZ73RfwuaHN
	h3h3Qfwdi+tiu23iW+rh0NfJv8ItutopreQf68aMPZEn8gOVqCTVphA+SKAfOMVveXPaxodYXua
	OKx+685YVj+3PznarDeWtgq7dD0lrLfDhvqf5Z6Ybw9bUVcPaolv13QFpcLtWjcb69LN1PA2iby
	SCQLH1yImy/ee1mVSbg==
X-Received: by 2002:a05:620a:3710:b0:82e:ce61:f840 with SMTP id af79cd13be357-88355a557e0mr1148838285a.84.1760044169081;
        Thu, 09 Oct 2025 14:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGagvhb9L2LRoUUbSH/qzn3ECLACg3Mdh1ie0u7SRafJuHBZtH0v7c6I19upromKf37riKFWA==
X-Received: by 2002:a05:620a:3710:b0:82e:ce61:f840 with SMTP id af79cd13be357-88355a557e0mr1148835085a.84.1760044168594;
        Thu, 09 Oct 2025 14:09:28 -0700 (PDT)
Received: from ?IPV6:2603:6080:b00:79e7:5442:2825:33b4:f35c? ([2603:6080:b00:79e7:5442:2825:33b4:f35c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a2274482sm268404485a.46.2025.10.09.14.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 14:09:28 -0700 (PDT)
Message-ID: <bf5f59df-b390-411f-a187-c1da6cbfc1da@redhat.com>
Date: Thu, 9 Oct 2025 17:09:27 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 'git whatchanged' is nominated for removal.
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <a6067200-a7cf-4632-85f0-8c6bcd00a5c1@redhat.com>
 <dc5de1b6-db24-499a-bee3-3eb2208ae08b@app.fastmail.com>
Content-Language: en-US
From: Justin Sherrill <jsherril@redhat.com>
In-Reply-To: <dc5de1b6-db24-499a-bee3-3eb2208ae08b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

PERFECT!!! thank you :)

On 10/9/25 4:59 PM, Kristoffer Haugsbakk wrote:
> Good evening
>
> On Thu, Oct 9, 2025, at 22:53, Justin Sherrill wrote:
>> i recently got this message in my friendly git client:
>>
>> $ git wcp data/aws/insights-prod/account.yml
>> 'git whatchanged' is nominated for removal.
>> If you still use this command, please add an extra
>> option, '--i-still-use-this', on the command line
>> and let us know you still use it by sending an e-mail
>> to <git@vger.kernel.org>.  Thanks.
>> fatal: refusing to run without --i-still-use-this
>>
>> This is just me raising my hand as I still use this feature :)
> This command is being removed because it was supplanted by git-log(1) a
> long while ago. Both commands use the same machinery, just with
> different defaults.
>
> You can replce it with `git log`:
>
> • Given: `git whatchanged <opts>`
> • Replace with: `git log <opts> --no-merges --raw`
>
> Additionally for the sake of readability, you might have more
> use for `--stat` or `--name-only` rather than `--raw` if you are only
> reading the output (not feeding the output to another program).
>
-- 
Justin Sherrill
Content Sources Product Owner
Senior Principal Software Engineer

