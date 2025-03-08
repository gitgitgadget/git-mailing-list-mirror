Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774A3C38
	for <git@vger.kernel.org>; Sat,  8 Mar 2025 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741396019; cv=none; b=JBwZPQ6OAF0mv+wzliQE9ZK0QVaYpCwgVJqpvx8oLOaQIBiujUx6TLSvMgAdNwotcHjqJINqyOzSuJ2shIVTlmP9k8If6DiajiF2WtQQa95da+hXxMQAY7ZERmR/1qDtwMTuXXUsgQGG4CVHq/HOIox5KGhByGpHsAHfIHCppzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741396019; c=relaxed/simple;
	bh=KB4bKBvnj+CfcaRA0U6RLY/FNwhWO6PhupXZ4V6KSMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQiBhQy5PlNTaBgyRu/t9438JlHLQ574zvoiU70/1/WC/6yxPMWDTsV7fm+F2hcvYlUaIAFUwLdkBFTFhLnsD/kHR3Gx0sK6ZEUox7WS6iWyakeoaIha+hytLccWFq1m5IIvmtbHNaE5mVZUkTq/Vk+N62mvBjymBeeVBkR4RLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAh4Ipon; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAh4Ipon"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fecba90cc3so5023817a91.2
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 17:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741396018; x=1742000818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KB4bKBvnj+CfcaRA0U6RLY/FNwhWO6PhupXZ4V6KSMY=;
        b=NAh4IponTYvbrHOiKckh7TTauqkw4RtRJAYcqgJ2syfxIFTb9d8crTmAcNqGeGyxa8
         6NJyzq/mrGQabk0pCybRRdvyTcUitFZMdvqn/SzEWFh9LHf0mz1mzgu5rcd6ecocPMFX
         kp/3VDnOhvkYdK6qYcs+GJ9+b+UsWCdvixDC50ub2asJSYH2/XDy3Su78Q3Q6GVKYL9z
         jQ4+iT28JhZZaC5K4MWmUQfwYQibvxDpQEkGQCmGoExCgLcjIsyAdSUOr6QwnxHLJTm2
         cvm66M8Kn7q/kc2lsz8Z9JbERd2xqPKSjnfXVDsIWuE3swBT0/C9mB3CWogVWkyBtb25
         voHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741396018; x=1742000818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KB4bKBvnj+CfcaRA0U6RLY/FNwhWO6PhupXZ4V6KSMY=;
        b=dqumAFzP3uOnhyAxE1qY+Jq2vPy+uII9uUWKlV2xbyvx7WNrhaOi1VK/Hc0T1gGkUR
         Ybmqqhysqfr/w/FV1S4SVFwO+XMLfvDzBhA9kBTtVwxAianj9GPf7JXuEvSxB6VsT2Fi
         p8lr7ciV3y72GyefZkOxCJ4RitObvQOOoOcEPWQsvRattBjo1KM9esi8mv+IA3FNDTMQ
         I0lcFQfU+xHwQyfDr9HBbMrG+XvlOTkbzLXf48rr7bmiIkoEsqXWfhaplCla/4qW0lOb
         rpYatktagvlO1l062wwqTWC24BqZYYSu5/QZhM4bnnR7gdyXNKR4Vtimi1s5QYEIYcSC
         VCMA==
X-Gm-Message-State: AOJu0YxKR6JqL7YzFmdKenky0BflzWFKB84Gkp8kAx8sLNX6Dl/REkyD
	BbJSMrd5Sc7qVbQeENqAd+P+OJNjaYxBIln+0nS3D5Zhp+GudkIYYUSQNaOUY9un7kE+Bxgx63c
	5n7dWho075fap7jMv+pUc1AUaMr0=
X-Gm-Gg: ASbGnctahRKJtlSAwAEH3GU6xmX8jP/7k2+bZWzutdDEsdr1Utf4cITdYh8iGi4B6PR
	+kn81EsVKU23f/eQ3945m/NopZN2apdqlRrRuVQSr+acd7d2gn8Jr/ERscl4U3Eul3cwEQZIvIj
	Dcwgt17Q2DX+b3WsQK+0pTsyHfZgyxCrV2Vv1faA==
X-Google-Smtp-Source: AGHT+IFF1axack08d8Da7YpviATK87cZTyU3tNW1/EXYd570/JK2/HJ43zs0HeJmjm9vVmwpHOK9I4eMqqYrsj808J4=
X-Received: by 2002:a17:90b:4ac1:b0:2fe:baa3:b8bc with SMTP id
 98e67ed59e1d1-2ff7ced8c6cmr7202113a91.23.1741396017664; Fri, 07 Mar 2025
 17:06:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305104650.238392-1-ayu.chandekar@gmail.com>
 <Z8g4dTSFQDTi9ueU@ArchLinux> <Z8qpxj2i3vFjJe4l@pks.im> <CAE7as+a+z9EgBnws-a4250TN_hDgWgapefxVAQHvpmUEfqKeTw@mail.gmail.com>
In-Reply-To: <CAE7as+a+z9EgBnws-a4250TN_hDgWgapefxVAQHvpmUEfqKeTw@mail.gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sat, 8 Mar 2025 06:36:43 +0530
X-Gm-Features: AQ5f1Jp58E4_GQmEG7DkfsxN5F2CH7c3Uawju7rOQMXLjNh03eLZOuYOVDCylq8
Message-ID: <CAE7as+bpxfr8F-jakhziW9-z_escWcFH6pJOV6AERoSi8YTAKQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Discuss_GSOC=3A_Refactoring_in_order_to_reduce_Git?=
	=?UTF-8?Q?=E2=80=99s_global_state?=
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, shejialuo <shejialuo@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hey,

> I already submitted a patch quite a while ago: [1].

By "patch" here, I mean patch for a microproject.

Best,
Ayush:)
