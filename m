Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036039855
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751068431; cv=none; b=J/id1bB/NxarrUR2uSzM6yJB8z3/7g98PoW0pXKtKt0KT44rcH0P3y0baJloSkzzEs37pu4Vwk8OoXsKo/SrytRsfIjDWfIlEUx3wfUfidbsMmRxG68nDQz/cL7McOsdlOYhS4OnpLbumy6CeNTkw4XAF4cgsiqpeHfeb8bAygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751068431; c=relaxed/simple;
	bh=b8gkArLOCd+z9LJ8Y/5MN1dHu7rtEgWOuWa7vkyR9p4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VXBem01RUXnIyWUVp54hjw1JCmpUY6xE8qTLut0K8Xl/ts8qONC0bJnTIbqRnKTIbZWPZaBxIEzvWgz/Yq326l7xnNio8qEVe1d3SP6ogJLPSoKIUsdG9o4PwkKZimkCDfOdPfu3QnzvXt+6sLWSbaVGmye4KQChpFHBm/pHvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lohldqQ9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lohldqQ9"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso601975b3a.3
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 16:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751068429; x=1751673229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GmgYMipvHU0KLMReS2OPc4plGUNd3W31uQ11JHeAvWQ=;
        b=lohldqQ9LjiMixnZ5FGunE6NCCBbwaSoDZ8S5Y3dlgULDrR5vnjumXgAu5Nc4AqpTb
         C24YCsc9ql+TOGFYMv++dnwMo40uz39sZyTFC4b0DJilMNmaZYRnfNwc+A0kUoqKsTi1
         PXKqmRATHuINHLlUw0YZrghH5avPwkP+0NV3xeoMZsbEgmcYgo/P+y3z81dFhoOZBukD
         B6cDMU8FT1G+EqnJ/xjN4FaekMi2ywWoFmlC4gvrLaY7+umEnTc/fre4tqiypteQ9UW7
         D7TKMXLRBt3ou2gh8k6F2tztIu8VALwkX4ZfX3mejD6ghCX9T/Zy55NZG4TXHqV+nxN+
         4q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751068429; x=1751673229;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GmgYMipvHU0KLMReS2OPc4plGUNd3W31uQ11JHeAvWQ=;
        b=vtvlLpcIH99QowekRSG/72/A7to0hNYFRcc4dNd0L5k2I/NxR+rogkb2QGGDPZU1Bs
         C+nCf3r4MA/D9PdSVjexlg/0L6yoGJzon9T+0bkVlbobpW2Y2sUxeX3UUbKiE/bR/rTR
         /W3VYLk9CoWVifzsZWKh9Ydk9JgkAH95+gXnf6QA4sKPGyMSXnIh/cuUx6NNe4KJx3qN
         GZ0qRuDhfqYD+y9aE+EMPFgvobc9pMKOpL1C9TSDYo8XvqzePc1fwTCd6/wMXG5iyJEv
         5daM2/4AZ6egJKeWyFjLCJX6RaAiIVFmKvzGQU9GP6f7RfRQUnEWqs/87nf2JxV+ztsK
         6i8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFFjVLMIzJdXN1jKkQhzD9/9hwdkT9gFuootEobnrn38oOnPHUwrmVTSZmfynZuWLyHCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzswQybnsKleQIhEoJ1Yg3Ms82mvJDQrga9OQ7mS4YFf7S/7PHA
	Ne4NsTzmSPzCS6Cxm3TBhx+MQ2o9KMmd4dVTVZnPbzbn9INR/jW4J+H5
X-Gm-Gg: ASbGncsHLcttKqP3ndr239qjdQVvNmPNobpjDvdTxo4uus/sebs6quok7lU9yps8sN8
	vEid8drXwBTklHgdZDt94TVxo6FA1JTkwhHSaFcC3+iy8jXQUMdmrr/4gyG0Hwhdh8pVTqhQmZn
	4WcEcf71uNp3wFxV7oXhA223qEhNd7yJc0Ee/bUX7xOUdUaL1pTt7xazXBIJLxBVN2lE3pzdMCF
	eFbX8/MUPI8L/JfF97TNWsmfWvJKodhxxn+xeQp3y2+XH3+eqgjuuzhJSpb0tVaDWqgSP5cFFMW
	fAE7TagzOcqXmMHE2NUS4pWyhdw1/LD+XJYYP5/y6Q6Jt1g9KQYJ3538+i0V9CFTX/wcrwdjjet
	HWyza28HVUjQufvkXx5WtmNa7xuQ=
X-Google-Smtp-Source: AGHT+IHIH0nXMzxEUzJhaBhvVz859orw1yL5rdQOSFrwySQClkEc9ws+ygSsRrbAXKdSX3kwipO2oA==
X-Received: by 2002:a05:6300:628c:b0:220:783d:99a8 with SMTP id adf61e73a8af0-220a16ebb4fmr5163283637.23.1751068428461;
        Fri, 27 Jun 2025 16:53:48 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af57e6a77sm3034964b3a.125.2025.06.27.16.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:53:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,
  yoshfuji@linux-ipv6.org,  kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v2] daemon: correctly handle soft accept() errors in
 service_loop
In-Reply-To: <vgailqqh3bcip3gxtdffoo4ey7xjso4xerewxncy22shrzn4k2@25hst4sfgxq4>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 27 Jun
 2025 16:05:52
	-0700")
References: <20250626161038.85966-1-carenas@gmail.com>
	<20250626172159.87204-1-carenas@gmail.com>
	<08804dbe-56dd-4c0e-b36b-a82768b0aa29@gmail.com>
	<u4scxaxivz62fsljo7okkfdvcle3zdby6h2sdzd6ed5n6wi5xb@5ekxdycixwxe>
	<xmqq34bl7xa1.fsf@gitster.g>
	<vgailqqh3bcip3gxtdffoo4ey7xjso4xerewxncy22shrzn4k2@25hst4sfgxq4>
Date: Fri, 27 Jun 2025 16:53:47 -0700
Message-ID: <xmqqy0tc68s4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

>> 		socklen_t sslen = sizeof(ss);
>> -		int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
>> +		int incoming;
>> +		int retry = 3;
>> +
>> +		incoming = accept(pfd[i].fd, &ss.sa, &sslen);
>> 		if (incoming < 0) {
>> 			...
>
> That seems unnecessarily restrictive just to minimize churn and leaves the
> deflaration of incoming strangely sitting in between two assignments, which
> while it doesn't trigger -Wdeclaration-after-statement seems to go against
> its spirit.

Hmph, I am not Phillip, but my take on it is that incoming and retry
are fairly closely related variables in this loop, and better
grouped together?

I also find it a bit ugly to hardcode "3" here like this, but
perhaps I am overthinking about it.
