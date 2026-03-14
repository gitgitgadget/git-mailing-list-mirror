Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68D17C220
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773511033; cv=none; b=TcjbwCNCJYnJcF+jLJri13E7PQyDlLetl8XoKsRfTHvgQbVU2PifEizCQwoN02TL2YRR4Q3lKw5Xbp2yyYtHSev3M24uYYZb3aQVICX2hdKWOcT6dPrIn4MQfG165/qiGmXgLMPQs2Qq9iYkWhc2J44Ol6GUV4t9TW46J72vZ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773511033; c=relaxed/simple;
	bh=9f7pj/EvoXg7bc3TKGh42ycu/2ZBnAYy1l1EGjSREr0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=C3XpX6+UMMWVXzEiIkOEKfSr9/IsDspncfSf627KJAgK6UTZ0qBRKjELNiDZVrYFOPrE7CFmxrLMdoAllrY1WXZr4NZubDqoD56+XXLIKrEVlxSZbrw0Rzw2QPuTfPQt1z2Uy9g1lr9E4mLShYpxX1IC3v3ln7KHOcYX0lulKjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6CnO+s+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6CnO+s+"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82a088a4956so340015b3a.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 10:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773511031; x=1774115831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f8Y/3tDqrstWImJNGLc80lSk+QK/ucBKSBGNLLmI+i8=;
        b=R6CnO+s+jrBJDYpOe5CQyNsrKKeOh4vHODvxRtzrS/AMtCAnk99QnB4TckTaTULQgT
         uKulOiFd5DvzzEkGF/K2ohEUtpIoh8cJ7LvS9p7LISsoIhhB/DhEgy309+wUvpWeX+Zj
         d8HIOXeuv6gR98Op/Bd7uy0fOduEUZPueep1mHNy3T1I/b5UxPCkcJH75ZXj3lFzvE7q
         PI9oAsvXOsTXFwXJQTZHoL5rTVPpgrQf0QeOjruOs436PTegCh9G9TXoiimdwNxN5Grr
         3/GTZiQSWXTyD3rWQ/T6QTS1b3TS6gmWfOayKVWrg4bOp01T12UQrJEJvQ0BpmhzWGYG
         AVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773511031; x=1774115831;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8Y/3tDqrstWImJNGLc80lSk+QK/ucBKSBGNLLmI+i8=;
        b=gYR82misCSb0jzkSQq6yacDupK8uBwhSKBoga3zQ7Gp0nQ2L0WLtwxSLGy8evbtLzm
         MtMK8iHhpqrtFENYnR8ER32kxd8GEQyBtE1DH3yQ9Bg9lsfEpSIlxHDA/InvkA/xqwNk
         Ee/GPG6jLKgDyp3+CR56PmwehjkjZBGDIjS7FJgAW5Nc7n0iFCtO0Nmmr98LknuqNJNd
         aYvdVSuXKF+drb8zkEGdbyz0NE8JHoN6XHl3cge88JwyPyBUtCkJrA7mceKv915g+q9L
         QkbnVHJArkWDPK3EvZjghzf/hTCWS6B9zdqPdup+eSvBbJlvoX+tIv4sOc97KMNs0OlA
         Se7w==
X-Gm-Message-State: AOJu0YxhkBDOvSu9lfpYp9dFeZErjBAV2QDqjDASXoAQeG19g1X+kdxf
	w3q3NLG5l/wmSOHyUFfEESTCEr0dOKtRIrH2xbg6aGW52Ris90CgOoBRxorU8tWl
X-Gm-Gg: ATEYQzxUbwwUnU76M1v8TnMO+gCRdVuW+pzOiBUO//StCbmxSoxO70w1NGJaC9NO1Xe
	KjPcG+AJiZ/Vn1mleocTQd7Nh3gQa4yvsBdmrE3dcw7mgYIEIgshz6nESBPohRDR+JXrB62ozAD
	GBHkHR49TvWPJJhEByLQDm5asCtrRCs/mdhh+Wpqm0k1kGQ32x3rbnXAxZgNOKU16//A2pQY3JN
	2dpdSxGbW9ckDZA6YBzqCmVkrel3VrOFC9w2by6u3qYzXoTg42IKnlFWPgXAczj1vUy5CN2qbwH
	PO5WDLBGrcRue6MUA4acNGWzfPgA2gZXgGaAp/GGk2NgnwkVbkS4T+yTLuahRWHaPhRtSvlsNhu
	Q0QRHO61bmRffy6MXxjv2PEh9qr1pCCSrtphOY+eQ224PYwqCgersKQpVY6iPg/Shtai5m7d4Zb
	7VqPUUJklNbFGlbvSAZScKXzs7Cm757lN1MP/apVh0biqJNa28wGsY8ecJ1CurToTAZDnk5kAe0
	RWrd/uh4rCb
X-Received: by 2002:a17:903:1aa7:b0:2ae:54b2:27d9 with SMTP id d9443c01a7336-2aecac590a5mr49473255ad.7.1773511031002;
        Sat, 14 Mar 2026 10:57:11 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece85e9dfsm56470415ad.87.2026.03.14.10.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 10:57:10 -0700 (PDT)
Message-ID: <89938f03-0d4b-4852-8f00-edf06e315a16@gmail.com>
Date: Sun, 15 Mar 2026 01:57:06 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC][Draft Proposal v7] Refactoring in order to reduce Git's
 global state
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>, phillip.wood@dunelm.org.uk
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
 <b98780d7-3aa9-4838-9234-290b1d72ffd7@gmail.com>
 <5e5f07ec-72ba-46ee-812c-d6773a4bdbe7@gmail.com>
 <0a944142-7c51-4143-af00-2a5798ea68af@gmail.com>
 <f19c95fd-756e-4890-b718-10ccf09c31fa@gmail.com>
 <a71b334d-95e1-4645-9877-f4a892f5a30a@gmail.com>
Content-Language: en-US
In-Reply-To: <a71b334d-95e1-4645-9877-f4a892f5a30a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I really hope someone can offer some advice!  After all, the deadline is 
fast approaching...

By the way, I was wondering how the mentors review proposals. Can we 
revise and resubmit them multiple times? Is it better to submit the 
proposal as early as possible?

I’ve made some final (and quite significant) adjustments. Compared to 
v7, it incorporates more personal insights and methodologies. Here’s a 
link to the Google Doc.

https://docs.google.com/document/d/1t2sznOvnPz-9tOzVMH--pLxzRqYSJCFzqVWBVfL_NP8/edit?tab=t.0#heading=h.c3c40ftj1ilv

Regards,

Yuchen
