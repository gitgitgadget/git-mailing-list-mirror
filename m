Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293791AB514
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086271; cv=none; b=Pc1lnS78qDZp04dOWqo3GUTSfarKz57Zceu19ZCn7LxwCccPdj2diKUIZ4YrX0SowKf0Riuq9qvwqKQTBILIxI4BiKhOexc2Kw9tl5hoeSYSMd4XZ7okPl7CNYnpl3Qet9r8XBh6Zcv8+Onqd1Vr5AgnxfZ/VkHMKff2CkBsRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086271; c=relaxed/simple;
	bh=spRxUvYSH8ugbFwbp8WmRu0iZzICp51v94sXYZQBzBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASwT/Q/kl2uGpprScvkDX7WUl7NUrNv8AmnexT2a1B/BSXGYqXUeXmjHKtRfasRW1TZKG5YEPTq5jyPGcph3K042wPOHpIRl2i894kVuWGQGdvLPRra2N3SktNuI8e6m1XmZ3ACqWcBWJaWT8hKPOHTXc/SS/AjaDxP55AZiU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU+Do5pf; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU+Do5pf"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee8911b451so4600521fa.2
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 02:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720086268; x=1720691068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yP2WseTt/smjGyTNcgCd7oD8pSNvu2SbvYwIZCYNook=;
        b=UU+Do5pferwjwJ2fUfo1NZRQKby2FhHnBJhGusE1cQ56QU5RcRClhEmTUU5eJNfZkt
         g9eBakmv88bvYLIVQHB7c6KPFy/UzscS1pNnRJHntCvNNNSqs+6SHxK41e4cvhz6cQKc
         JrMt4Vi3wxQg29UKZyKrxMqp8bqVh/4+ABJ31cC6wNXIawb0hZ6CiPtNUWmrZ6w2kQKj
         q80dXvVqFfXkRfyL7A9GtaQtpgVVdmH/bTGzEAfRmi8yUbpo3TTo0xayvcCZk576e+v5
         1DJ42pjHcWXCd6sDr+bsl+jDagC9Dv6Zxqgl0egal2FpU9SLneninTUc6drrMijktrFB
         e+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720086268; x=1720691068;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yP2WseTt/smjGyTNcgCd7oD8pSNvu2SbvYwIZCYNook=;
        b=hqSnW6RPTXju0Wnd7iLcNh9ahQd06PpnTPzepQo+HklYqCOhEC3BUS4Tjli2F6i5jn
         0U058PSlV+MB2cFlMAp5wC2vLnQ3u90YbQrkY4MbsLh78aNOfLhClMvapGAj5iS8KoBB
         unJBDbuD8D6cr893OMQFGVUuxpWnIsVBrzu/KWjirio3blU+IPuG1oPiAUz1sLmPDjtP
         Bb+Xl7CvWwyXmCQx3BZtYXKmPoGaZHbYx43AbkTu5x6kDFbaU1CEN1bb0Qu2bi//yaFL
         7TDpKZTr9GYIkCCv8z8F5rRFfprw/7xH4ds+a2ForQ0uG9LVa2jHaVAyeSgDWbi2rb1O
         rJkw==
X-Gm-Message-State: AOJu0YzcEnbp7kWHgHXNFLTR7UpJGFVUoJ7imJATkebEgNulWSPxtNoV
	kAeQNddQzK2QUhtb5yxSejbzZce6hIL1Igz+umaft0k1iCPnYq0F
X-Google-Smtp-Source: AGHT+IGhn6F+V2RF4iMTtpPoFcsykNeKsZa8bmA5lw5TGtoo5f/c4/p6p5hPaE3nLUlo3j2/cxYJ3g==
X-Received: by 2002:a2e:2c0b:0:b0:2ec:5b10:685a with SMTP id 38308e7fff4ca-2ee8ed8847bmr6814211fa.17.1720086267887;
        Thu, 04 Jul 2024 02:44:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fca8bsm17134245e9.47.2024.07.04.02.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 02:44:27 -0700 (PDT)
Message-ID: <6d747a7d-9091-4ec1-b059-6ecf16d89846@gmail.com>
Date: Thu, 4 Jul 2024 10:44:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
To: Junio C Hamano <gitster@pobox.com>,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Josh Steadmon <steadmon@google.com>,
 Christian Couder <chriscool@tuxfamily.org>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <20240703062958.23262-2-shyamthakkar001@gmail.com>
 <xmqqle2ie9b4.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqle2ie9b4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2024 17:20, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> 
> The changes since the previous round look exactly as expected.
> Looking very good.

Yes this is looking really good now

Best Wishes

Phillip
