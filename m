Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65F712A14C
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415706; cv=none; b=pq+U11oBRakgo3FJx4h+KNlVvvjSpliNv3klqcn0ueuiR7898fl3e2igZuzYAEp16chGSag4z63vY4Efmb920wBJrxRrfUznWG2qdTYZDdkqIfTMkLtjImw+0t3zp/kTB3nsr5c1v5JmlYLOU3FT8gtvxc5rtya1MN4sAYAJ+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415706; c=relaxed/simple;
	bh=6Bxs9SSadD1S9t3jErs1C2t7NKbOVjcYEf1+nb/HEw8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QTIswlOf22fdpLtlmH0zocDkpEYNqefyphkudjmD9Cb5ERgKdpCy4EqrhDJI4MztTdIhZ0ezR1K7xrYMSjR5N5RWgGWmnlqLvPktDkF9LSIKFKwu9fpOCBf070uScRIga4h1w/p4iD9g+G4kzaGxPAf0Ny9rpmlSiGKzRS/TtnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDj4H2LA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDj4H2LA"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so33253995e9.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714415703; x=1715020503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+BKy1c1lc6HTVOk1cpfRpAxYmnD5jODGm3sZVeJYmvc=;
        b=nDj4H2LAywF/OWDW5l008o5zU7C9vBFAiavLq9+hNR00lffu1yVHsiJ7iKYTtgUFWT
         V8NJqis9oSDLmSKDckgxsM1cA0Rd/fdqhTY1XWWG2ztgiPTQqPOqxcWhDOXde7nJBja2
         e/SLXJSa/BXAF0Bmt5GDpFwx2dpF2RcgRc7rucgAWmTg6jD9YfE7scdzucou2Zlb4Pfx
         RqKishvO4YIr4rAmgpXtxHlodfmLtCLBrUAixLq5om7xN2rsCCh/TcYZ57bAJm19JB6q
         Vn7gIjRIkaFxbhwXSJIClVj/N/cT8yjLHAJ0CwPgndrgVR5XaOFi48YITzbRYu0Jz54V
         kpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714415703; x=1715020503;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+BKy1c1lc6HTVOk1cpfRpAxYmnD5jODGm3sZVeJYmvc=;
        b=juqmkQ/Ip0mK5HHrYebrcrwnxVER6U7UJcnud1iSqnHqCFUdbpBPFylZ9jbWUfDpkq
         gHWqnOBfv96wILE10Ro4fNtEE7KPPu5QY7IKe1cBfx0BRZ+ORSEyWEWDTDj7U/iQnI2T
         Pzi6zQ8EwBfORg9fEZ6I/OJfSinm9uu8g5Uc5Yasl2jtoO4W45gP3yL3ocCPFfHs+Ro1
         zwyo8LUfUKC+uShjnRC4qWEPtQJiU0rrBacySAqGm+2u1zal6TsHva5Ag8pYj7Z5GQjB
         1z+nLTL6Azxe4eFb7KPrDSXpGbcHKFVUWpTPYvbQ6Fb1QtQibpDNKHgtrPLfdrANFR6q
         c4sA==
X-Gm-Message-State: AOJu0YyQnHdzw9HK6TrggDDMxCAiFjgN1lg9lvQccgZjaQSbEv3LQNVU
	L+GZJ4pDc7eiNekNwZKX7TYrq2ecPz42OvixWRawyjo38GjQRKxsBeMHqQ==
X-Google-Smtp-Source: AGHT+IF5YTw4ZVnmqjkkYJMpcr6B06d3Azewr1qjQ0ufUviVFzJ1pkeixkcrl2YxPuH6yW6sk8NGcg==
X-Received: by 2002:a05:600c:5110:b0:418:c6a:1765 with SMTP id o16-20020a05600c511000b004180c6a1765mr406219wms.16.1714415702738;
        Mon, 29 Apr 2024 11:35:02 -0700 (PDT)
Received: from gmail.com (111.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.111])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041563096e15sm46633076wmo.5.2024.04.29.11.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 11:35:02 -0700 (PDT)
Message-ID: <952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
Date: Mon, 29 Apr 2024 20:35:01 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 0/2] add-patch: response to unknown command
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
In-Reply-To: <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm happy with the currently queued version v4+fix, and my understanding
is that it is OK enough.  However in the recent 'What's cooking' it is
marked with 'Expecting a reroll'.  Here it is, in case it is expected. 

Rubén Justo (2):
  add-patch: do not show UI messages on stderr
  add-patch: response to unknown command

 add-patch.c                | 18 ++++++++++--------
 t/t3701-add-interactive.sh | 28 +++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 15 deletions(-)

-- 
2.45.0.2.g84ce137e4a

