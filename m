Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC944EB45
	for <git@vger.kernel.org>; Mon,  6 May 2024 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001463; cv=none; b=FrA2M6fJ8lCpcXwKWYYkfZAnrT4cHjo8fBwQ8EstfowZZmM+norg+5c+epLtRFxrWIEOGlwVvqCn1q66qASjMUZ8svpIEf+Q9nAtJoOe7Jcdh5YYof/b8IqlaylOeDuVvZ6HvbKk6BxM6q3ZgT7sQyby3EfiVb1YbEf8VOiGis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001463; c=relaxed/simple;
	bh=zYXhviVbr5Z2n5NDgtghaKtIXyHeuZP3ejIhlHJ5Qt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSb4Tdw4C+ILpdTCsB/4BqWp4j0gN0VYHVYYj6fLNwKCZXzWZOaw3wFMcGQoMtgi+/heJIwQsQVFmTUlBklx7dZhid6gPlGHsGG1IjYJG7k5BZU5DyMkUCbt71NArl5CM86loi2fw+qbhkZmCgXdahAzYY38g9U261dpIWd7gOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWOxhQeT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWOxhQeT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so12311045e9.3
        for <git@vger.kernel.org>; Mon, 06 May 2024 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715001460; x=1715606260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vBL6WHNHmSE3FuhZPkb4hZHcN09iwvWDLWDy+AEIQww=;
        b=iWOxhQeTYo8ax+xKPjs4me/os1/tGJgf7MeJ24WayusYx9jDfcwAbNQhthiJ/NJHe5
         G5Z8+ctu7nDWaJNquYn9OlziznmhUIGNRHExnoYEx9GvB0Hjo2lS/i2QqtRU0S4e3Qs1
         ODPs/Y8bEpZXlbqcB28IAlaNED9eeBj80TqNAnAkwYkEsb8BYEnQr67y+9E15T3m0prv
         CWj5VEkXAwmBg9KbXVVlA+BU2nwMasNdNSvQahi8mlmCBSpyl/gAgIe8KsOg/rARem8T
         nWVWJRvJj0Kjf47PmrweJGRgGWntOIxGgdIcQVKNWNnxfRBhJRPDEDJlp+4D4LrnN6fS
         Ow2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715001460; x=1715606260;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBL6WHNHmSE3FuhZPkb4hZHcN09iwvWDLWDy+AEIQww=;
        b=VZ1MWdwGJ4Rbrcy1R2+1UOCvey/zMqwU490/A8Cqj/ZiPoGsc0ZgEB+vTD+yRBndbf
         1zxj0o1NllJ67QxxRz4byEBoFsuDG6nhar4BnZJEZdPYM9bNNKIXShl2Ktqa8b4QnkUA
         yE7lx43LX+Lw5R1ZEMev9F1OO7sCMmeOAjNePTmtoH+466I0l3f0ngwNXGfGb+ndTLCj
         EDZkWa5HN2GTy+GNsWQKxMEugV4BEOYI8jPBiiLPieJg6Dc0E85HbqPREPz3+3/6DljS
         bzcSa2TtI/PmhvdkOzzAy4ZwO6QEZg2UtHv1dK/kgyjTEGioS0+T+DuCy+wUW57QEwuc
         Uq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8HHHvKlehVE4gRcjKqO6If6oqUNQMHQA//am07N6TQYhg+b8rL3qtbZKoH2hIhz5Atlnxvc4GsQdGbG59GJLJDcmU
X-Gm-Message-State: AOJu0YysRJLix8uhPueuYd3RdCL5atPNZzdioMwuQEz0+9uFXGs0A+wU
	yCULpbo+gsHsiIV0kCeKPBCzVE4QzM2BZlR4H+9wkBXP/64S2aq5
X-Google-Smtp-Source: AGHT+IGrynR8gbmyhTizjkQs/h3uPKOlnm84+eWbe68CFOI0MlZfqfumC8CcCOsSK6dQ3dJqqXKb+w==
X-Received: by 2002:a05:600c:3d10:b0:419:f087:f950 with SMTP id bh16-20020a05600c3d1000b00419f087f950mr7958943wmb.16.1715001459775;
        Mon, 06 May 2024 06:17:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id u9-20020adfa189000000b0034bc5934bf8sm10718719wru.31.2024.05.06.06.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 06:17:39 -0700 (PDT)
Message-ID: <6cb8c364-a7a9-4773-82e1-ba2899fcb353@gmail.com>
Date: Mon, 6 May 2024 14:17:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 4/7] refs: add support for transactional symref updates
To: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
 ps@pks.im
References: <20240501202229.2695774-1-knayak@gitlab.com>
 <20240503124115.252413-1-knayak@gitlab.com>
 <20240503124115.252413-5-knayak@gitlab.com>
 <17c71b18-20b4-4bbd-b52c-c29ef8d3860e@gmail.com>
 <CAOLa=ZR5a0Tj1abM4z4SAVm5cw5+EA0qyoOMs8QH8MoS6eJGiQ@mail.gmail.com>
 <dff080ee-946c-4a44-a448-294ae8ee241f@gmail.com>
 <CAOLa=ZSMFVDy31W+5=iu2AWjyaR+Jy_BR5txd-bGnHu1iRsL9w@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZSMFVDy31W+5=iu2AWjyaR+Jy_BR5txd-bGnHu1iRsL9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik
On 06/05/2024 12:22, Karthik Nayak wrote:
> 
> That's correct. I think testing that _currently_ would require us to
> probably expose and test via the unit testing library. I plan to follow
> this patch series soon with the symref-* ones. While that's not the best
> argument for not having full test coverage, I hope it is an OK state to
> be since that path has no users as of this point.

That seems reasonable - we have good test coverage for the code we're 
currently using and you're clearly committed to adding tests for the 
rest when you extend "git update-ref" to accommodate symrefs.

Thanks

Phillip
