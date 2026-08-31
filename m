Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9833F6C4B
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179324; cv=none; b=SzLRuA86OCNXuaGtF9RCNQrDdrdPCr3zt3p4la/+bzopjiJ8PMqzyAvRrXox3k0kP2h2kLMrropjnmQBPD0yIpWUPn19zKc/qeDPc3VPJYGJQ00Y92ts+jcIF9VzsQCRPN+6g+WO3BLdU9ovoHEHXW9+/m2fxnGenc+BP7z6imc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179324; c=relaxed/simple;
	bh=KmEDKTNeKJM66iRJy0UF6AhjglWf8OlLXKlaVQwfe/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+8NX4m4TtaZGc9QVoTBqol+PgRsGWYoZGjufPto4Sc/XNEKWRJlNd1AXB7IK5BS7vUVX98+YdE1dS/HLtIhHq2mXOdKaBqV1qcj2L8MnA2bwhGx6RbMWv68wytAdLYYhQKJwKDzBnVRe8etlh50fhWNabx68bsjTQrHUB2K+RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceJw0NfQ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceJw0NfQ"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-902e4af2d9dso40847846d6.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 05:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788179322; x=1788784122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJ3tEJ0p8ixU3GfjGqiYDbd72Tu76vfiVzd8T+q92RE=;
        b=ceJw0NfQS/9vokhn14T2yX5/5U+L5MfLTp9ltmvpmdptM7roIygvqL1Vi9jUE4xWWH
         26Kg6sieTwLcV3AHVbxO4li4cDFJ1jXc/Nb3Tfs03cRB7RTK0mAQ5YYFlsSwDIusnim+
         W69fzL47xixICLMY1OTlsA6OrDzLCqxmpr3yd6sxdWdHjV0lylQtvUQb++E380qkHq3p
         MUsvxgaORlAGIPt+DALyBHT5S7Y9F3vvYkeokcsHO7h0X+fB+Z6qVQy6bJRJ/qvIdJez
         9sNJK8fOzM85HCEccyMnjr3NUw96DV/0tR4SjrF8bh7AT1MtaJKT0D4r2SSJ0WNZeU9K
         b2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179322; x=1788784122;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJ3tEJ0p8ixU3GfjGqiYDbd72Tu76vfiVzd8T+q92RE=;
        b=pKpQxlOB43zTfxdZlGCk6TWOc/JtnBezY1JvEkjXTJdavMhtMoDH9xqz+2/gL4uW3N
         bSXmGlWpEXUL5bCSaRg2PQYIBEqYMJ+BOflh1JQCnPG2sxfU1FodIumoJ4Zr9LQoYGmX
         wUASFXHKTMt5eT9lfp9s+J/qg5Ik0Mj9hq2qJX+8SJpGhLZ4vnp8VMiM/1fxEcaLu7T4
         0GZTGC2ygZLwL3eUIs5gBQ89/fadboSvVX6Q0Pu+974/XIRCcBSMJPiDTJ62zsg4QZRk
         DFsMwVnPcGyPrjg8Aa65UDlZVgGjubVsig/uDaKuSo/qZovb8fbTwpyvVY+/J4brVmZX
         DVLg==
X-Gm-Message-State: AFuF++kS6dQNtLtBBM/dRvH+TJN0KmAgtqKLAU6uf0H6Gz96XwRgwzs2
	7Fm7v5TqQxXkpwBhtpaYYS0CJ2tOb1IXxJCgXItcJIz8vIVlegbGNjYv
X-Gm-Gg: AR+sD12E0yv/Oh3jGCLGdHR6eyUjzjjwYz0SsNoZTM10T0ZR9/GOe/f2d/SHj0TvKqs
	8OvF7LQ6swkqu5D61RugBXiappLMrSv2vGVz4NJKPDLHEx2rOPkI2hujFxRs67QfwLTbgg84US2
	2zt7nItOROIn62j4mu4jyPhAKIwsKf7fvos6GpsQRPeYq55x8axqmopLyKf8/owMFmaCNQFMqDA
	5wK7L55H+LUwR40sk7FLP+pOX3kgTBeKXAxZiu/TmQ4Xe/X7m9osdNFzykWKnqzKgzjFp3CXuY6
	eLAmom6zH9OBy/uGzX/Q2rqkp5ZRghILhXm4JacUn+X6zNcIjGIiOCduBZ91ET/ACsBjWD4Wxo+
	LBxnTiEcwpsFvPKEBB9iBPJwyC7ArXtJkY25AEYLZIzLnPdDmCb72G/w6Q/w4xVexK4pHwZ7ji5
	4isQD9W/DjAb25OmIKHZTBxo2EgTPLwq36+d0bjlyRM9r156CP6/wkSg/l+lIRlgC5mX84sOfeH
	EZIcaNvPHCVeQZ57X4LhH/WSHzGB4w7YeitDgzJMpzu7zb6mrRoiWNE8a+N6Hj0JJsmBC6UUCqq
	uDO3SBh+ITXazfc=
X-Received: by 2002:a05:6214:2b93:b0:8ee:756a:bc32 with SMTP id 6a1803df08f44-90e87205e0cmr96751836d6.15.1788179321707;
        Mon, 31 Aug 2026 05:28:41 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ceaf94d8dsm68240006d6.1.2026.08.31.05.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:28:41 -0700 (PDT)
Message-ID: <202e5eac-becb-4b75-80ca-5d56caf36f3a@gmail.com>
Date: Mon, 31 Aug 2026 08:28:39 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] banned-die: create header for banning of functions
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <ttaylorr@openai.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
 <84634717e2eca479026d1cdf39a089a8f61d131e.1787684181.git.gitgitgadget@gmail.com>
 <xmqqh5kikkgi.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqh5kikkgi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/2026 4:34 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> It would be reasonable to name this file trace2/tr2_banned.h to be
>> specific to the trace2 API, but it seems like such a restriction would
>> be valuable to put in some other areas of the code, so adding it at the
>> root of the tree seems like a good long-term approach.
> 
> In other words, the functions banned by including this file are not
> listed because they are banned from being used in trace2 API, but
> because they may lead to die().  There may be some other traits that
> we might want to avoid in certain subset of our code, and we may
> have similar banned-frotz.h header to prevent direct or indirect use
> of frotz.  Which makes sense to me.
> 
> Would the same approach work for the_hash_algo and the_repository, I
> wonder?

I'd be curious if it would satisfy two directions for those cases:

1. Help declare a subsystem is free of these globals and thus is
   ready for multi-hash or multi-repo handling.

2. Help declare a subsystem is _not_ free of these globals and thus
   should not be _reintroduced_ into a subsystem that was declared
   clean.

We'd need both, in general. And we'd need to continue expanding the
banned-*.h files. I am curious as to whether there are static tools
that could assist with this.

Thanks,
-Stolee


