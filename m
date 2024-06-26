Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C9143894
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425257; cv=none; b=IwWsBsd57vv3xNEDq3GB8FrZISH9UlLRBu7uAeCix9WKe93ShNBQFjk8PuidLArw2T2O/Sj2E6x7OKdMYlPUgKOOBByYxei/9K+a4tdiviv7MZCGE4HPt+U2c+80xJkPdm2Nk5M+37cLsSLJnt7ttalkqWXso9rQ7EwfXI3SZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425257; c=relaxed/simple;
	bh=6zr03O2tnKDWzNfJaRLaN1vesXlFgtq1xLTUqTJbEqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3CE0wnTrFX2ZR1i6sfm0CJuHWMjXNznYoXPQrwSt7YDBtKWaXcDWbA+572cOzbIUoOeSKZ0I7kphg20EqIBG5PBYohqw4mg5k8zae0wrk6QAtajze9hBwt4u1b7zMG14kp+NJbJV7pY1VUuG35uXl1xR9Vjc02roftH1HNElME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBRY8PcY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBRY8PcY"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7065c2a55e0so199391b3a.0
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719425255; x=1720030055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXkxqRAMeNH6MJZDwc2bsFZSm4r7pYJZ7l0VI3dBZFw=;
        b=JBRY8PcY1N0hQrfaZYUYFW/R2RSY8ywDrVLSf+s1Rh//8AEQ5kcuOGVFOKTokAriex
         AxdwAbEFH2uuuqWQ+Cgscm9wH07oyZX8WB4wlpwQeTpwoQyf4QQgs0O63hZOoUVdSD42
         FHD8d1BE8qpVmN479Ci4o/ID3RoHdMilZH2/mERLl5EwKR0FPdD2zF7QLhpJ0uTV7M1j
         P9NV/um7sUlNRUl5i6jpgjvuOKQMi17hbuRGCuIeKEIQ2o/Joh56kRVZfhhrWsEuv20/
         jkC4BJfL3Y0kSq7Yj4jTf0blKOyNcKBkPN7gxG4EJ4JQj8Js4QMm90WOvMqWL1vhMH75
         c/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719425255; x=1720030055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXkxqRAMeNH6MJZDwc2bsFZSm4r7pYJZ7l0VI3dBZFw=;
        b=c3FPfhDj4uENr7IEiQ15x0i+yCGNeEacDYy2nKHAJNxKqL19RKtfUhbyrEj8wQtpHS
         AypbGRAb/oaiQWKW998xSp5N/sDlqDVdTgIAipZPFZ2mkdeSXHwUsviUFGLxlaf6A9/Q
         6k+hdQEWYjBpjRzUiO+ggw3pAKNDpNfAv/wYdaVY0qCl+8LCdqPNVcWI2ECch4lo4dyE
         9HrLTxGdMfZdNiUIDWte3djiVmQlhOHT28EL6AD1q7ggPUKw5aghmUrqs0vPg1WLxMe8
         RVdnaT8UFbkVMDAY5uumUrm9x+Fj9DXtz2aF7TK4jMPV4jnCuBbv9PTMOG2ShBNeHON/
         UU5w==
X-Forwarded-Encrypted: i=1; AJvYcCVz9lWlmXIrtN6q15KV0vqU/GYTtRjQpPgy+PfehbvI5C4cDnQtgGDKdK+PXo4qEjDUiHyvEaQ5Eh2LOJDEsqNXHLXq
X-Gm-Message-State: AOJu0YwgLyj/MLZtC+jnM5dsoCQOTQJwSSQL07gGQTnlvY01rhyLFL5u
	uEXM1jiYsKQwe1iqn28k0F5aFG2BhZ/NpW7cB9sNZRJw9RFPrm+d
X-Google-Smtp-Source: AGHT+IHEkkBnpgNEPxWVvV/56LQBv2RXK/KlKJr6V+UiMEfGST+xPLIUdbw5Vsejk+iYUPLGMAMSwQ==
X-Received: by 2002:a05:6a20:a11d:b0:1bc:eb7c:fdd2 with SMTP id adf61e73a8af0-1bceb7cff2bmr14402928637.1.1719425255332;
        Wed, 26 Jun 2024 11:07:35 -0700 (PDT)
Received: from ?IPV6:2409:40c2:205a:5198:c04f:bc01:50f8:f177? ([2409:40c2:205a:5198:c04f:bc01:50f8:f177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d80609b9sm1979726a91.27.2024.06.26.11.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 11:07:35 -0700 (PDT)
Message-ID: <f7d0abce-b389-45ae-992a-adbc7ec10d50@gmail.com>
Date: Wed, 26 Jun 2024 23:37:29 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re* [PATCH v5] describe: refresh the index when 'broken' flag is
 used
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
 Paul Millar <paul.millar@desy.de>, Phillip Wood <phillip.wood123@gmail.com>,
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
References: <xmqq34p1813n.fsf@gitster.g>
 <20240626065223.28154-1-abhijeet.nkt@gmail.com>
 <CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
 <2e80306e-2474-4254-95eb-c2902a56ffdd@gmail.com>
 <xmqqikxv4t1v.fsf_-_@gitster.g> <xmqqcyo33cgu.fsf@gitster.g>
 <bbc223a3-2c82-4108-adf1-5e8518ff776e@gmail.com> <xmqqsewz1ua5.fsf@gitster.g>
Content-Language: en-US, en-GB
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <xmqqsewz1ua5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/24 23:05, Junio C Hamano wrote:
> Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:
> 
>> To me, this looks much better.  child_process_clear's name already
>> suggests that is sort of like a destructor, so it makes sense to
>> re-initialize everything here.  I even wonder why it was not that way to
>> begin with.  I suppose no callers are assuming that it only clears args
>> and env though?
> 
> I guess that validating that supposition is a prerequisite to
> declare the change as "much better" and "makes sense".

OK.  I found one: at the end of submodule.c:push_submodule()

	if (...) {
		...some setup...
		if (run_command(&cp))
			return 0;
		close(cp.out);
	}

