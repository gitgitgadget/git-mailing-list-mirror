Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F4C1EEE6
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738085464; cv=none; b=pPF/FVHODsIzJBdPzY4PibaaUve1KgkQZBMwgz/Fe6XMdELnZB+Gq6swMGq/k4CV/2tBlX3e8W7MipPgcpG51AVQc9jzLbz2LShmqLlI90L4Hhv9m2rQhXuq00IP8VWmgnYtjaRk2ZRmAyqe0/ncd3HvjPYKZ1jwBUlgqzwqBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738085464; c=relaxed/simple;
	bh=/4PV0+/nV3s/BcrD4BjyjaPHeJVvPlVplFuCjJNHR+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xa4t1Pcnl1+seH6qyiNEHeKcwXM2IHYPaHlb1b8dIbVQDidhss2QzJWKEsFx0ymuLKaM6a9In9VNBXTJALiKdK1z8k1zXwm/qJtG//1NBqZfDOIBQczlW4etta5g3Z83MnubJhsy8/YOn1sml7ML4/nKbGpcik2SnQX+HSHpEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AahupGmv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AahupGmv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21661be2c2dso102223085ad.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738085462; x=1738690262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gwAHKXei7hYhS0VQLypPqTsUPMYNeAMqEQgfVRUpS80=;
        b=AahupGmv0gZLxMcD6dIUVdlqYLUEhN9NLCQ7A7E3xG1zb4AhROpp8reXWwg2TQezVq
         c6WuDtOqvO0fJDdgJhX9Nusi32qs5Gr7ft826x+E9mvvzGRuLzNIr9InuBDJTau4av0x
         BbAER0af4lw210CBBjr1NryhjVqhDp2M4XifswpqRhCNzgXoXRCe1A3scko6QdYO/s1O
         f3XnVrMN2uetRSSy42n7YSzNeqb8oZ2ZubkpdxWcH7ydaiUJ4HSTNwxQyicvhxnVgYD4
         CZomDY6wadVthoxTHEbKfboglm+ZfdFDOtPxK3L9nLieZTO9m1bskq0gHthTDgQ9O1Mv
         DYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738085462; x=1738690262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwAHKXei7hYhS0VQLypPqTsUPMYNeAMqEQgfVRUpS80=;
        b=abdnVNQvbYRFNXisq8EhrILZWhFrjawzNZkk7ox6+6drh/PmbrTm+KxmRtuJ/Dqbnc
         N3AsnGPjxaRqIMeIt0A7PSQ2bxD0gLudg5KiDltjczpiTvEe/xDlVxm1rlNm/kwWBuZY
         6curm7PmYOYIaS3mlL5DmFmmOOAFrUlPRrd1kaMLf5Mt1ssSzOmyh8IKSb+fMf37qORg
         FjTo64OJJj1zJr7/UhQI6piAmUCoEY/yIi3bB8oZMa+WJGfLPFRhAKKDx8oIIE/Z++nP
         fn4dJoM5a1kv7eOBwyzdiusLID22q0IpgwC/z9/TvcuRlGgvVwlHsh1iYC6yQNrYHGJq
         lXSQ==
X-Gm-Message-State: AOJu0YwPw9mcYJeD6UJP67Z8ij+vmRpbx4UY/al9lqBSk3pqE4+YiR4e
	8+Rw65RKIrUbiaBACkikci8+b76M/p76X0IUuu12fVNfzDpKyozGTf6tug==
X-Gm-Gg: ASbGnctyENcQVAZwyfHheOT5FPyleL7eIyamSuhtYPlC15QmTCJVTnIAf53DKl1Ev7Y
	kGxkFKRVU5AUzlgDq+BWf7zPcvh3+ENwpWAkBjNE1Qb6isByUL7xDEJg3FuN+7Jgkq5SxLSmUBU
	WSamKDR73Qpq6+UAc6of0zwYeULXvtAqRZKHoTUtGk4qLwzWzgIifUhfBelyFd2kG2ApWWGyeeK
	GdCeRR68P9rPzDrTqsco4L2wZSE4AgGvzeBGPDwLYYQ0PWM9VDUwjKcgGGkdBu5kq1d0SxWFoce
	pNmii8+KY3ySdWs16bKQCG6U2r2RorEeoZ4=
X-Google-Smtp-Source: AGHT+IEfGY/RCD6uRJpWc3qIwX+sV4ikVMXJ1OOuU9W612MhwIQd1SuRq6sxTewTWCZEOUhVhrJrIQ==
X-Received: by 2002:a17:902:d542:b0:215:a2f2:cfbf with SMTP id d9443c01a7336-21c3540b755mr617630895ad.18.1738085462392;
        Tue, 28 Jan 2025 09:31:02 -0800 (PST)
Received: from [192.168.0.7] ([106.51.24.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e256sm84956325ad.170.2025.01.28.09.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 09:31:01 -0800 (PST)
Message-ID: <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
Date: Tue, 28 Jan 2025 23:00:40 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2025
To: Patrick Steinhardt <ps@pks.im>,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Jialuo She <shejialuo@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <Z432QXJb_TfzNBa2@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

(Apologies for the delayed re-send. I just noticed that this one
  got dropped by the mailing list. I'll respond to existing replies
  in that thread)

Hi Patrick, Christian, Karthik and Jialuo,

Thank you very much for your interest in volunteering as a mentor!

On Mon, Jan 20, 2025 at 12:37 PM Patrick Steinhardt <ps@pks.im> wrote:

 > I'd be happy to mentor this year again. A couple of ideas:


Thank you for suggesting these ideas, Patrick! I've incorporated them 
into a draft ideas page for now. You can see them here:

https://git.github.io/SoC-2025-Ideas/

Kindly suggest any corrections to the description, project size /
difficulty as necessary. I've mentioned potential mentors based on what
I'm aware of so far.

Patrick, Christian and Karthik, kindly mention the ideas that you're
interested to mentor.

While I have not included them as of yet, I wonder if the following
ideas which we had last year[1] could still be retained this year:

- Implement consistency checks for refs. The idea could be about
   implementing further ref checks which Jialuo appears to be helping
   out with. We could leave it if Jialuo prefers to continue working on
   the same in a flow.

- Refactor git-bisect(1) to make its state self-contained

- Implement support for reftables in "dumb" HTTP transport

Would these be interesting ones to consider? Is anyone willing to
mentor these this time around?


 > I'll keep on thinking about potential topics.


Sure. That would be great! Others could also chime in with your
potential ideas. Also, do not hesitate to let us know if you're
interested in mentoring.

-- 
Sivaraam
