Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5631B10D
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764599695; cv=none; b=kVYu17BouXDEERXkX2ArcpDiA+HWE8Pw2MDXmt0PZMJWVS/cV1FJoe6KnmAsgGHGHsdEUjgjIjMy+QMZhZe0R0AeWPRZeqQMGmq1Z83mLlKssglVYJBg7jsvL/VVOENbBaxLs0lG8pBkcTnJbYyTegaboKYe1nmBl/QIAoMQEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764599695; c=relaxed/simple;
	bh=gyt+5awHIa1FfUVOldu9bx8q/TR+LNddXwgQKiH4TOI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q1C8nSnCrfZwt/xEABEEQXFBvoifxyr/skUo5TaZX/JvRW9M7XhZ0BgH4X50g3cpULZz/5+EZHM6Z9znYVuinzd97Rdxg6Y/+349S7ustZNHRPNdmqFQN82aVLHTRDoBil/r5P0QH0Xny03OMqpgflJNIkMKZUHt6n6jlZxDdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6QDnzeA; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6QDnzeA"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5e186858102so1492595137.0
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 06:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764599693; x=1765204493; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyt+5awHIa1FfUVOldu9bx8q/TR+LNddXwgQKiH4TOI=;
        b=A6QDnzeA1PI/7vx2Fw2GwD6L9KdmxMGbDMKrM2T9xF2E5+xTqtXo2bAnitI6/Zzi5/
         qv/TZ5lhrnUjnF6PbX9nCbmoh3XDZAXxG+AVaOFYkG8Ra9is/hIZKVtoW+Zk8kNrbgpW
         +LUf5rx79nhl+vyeMzU1Mc8gckH5dVpOl1x64v5Z5RufDozXhat0EDJ2ruAiCORxBXjM
         Ar6QgYKVWiH/kClQeBBCOrfNzbsTr96eDprIiIKSe0VwmOB48kpvv+dgN3+csHZ9j2YY
         A3iiHj0wujZf16UROsP7duOjWbfhHWQr0EoXO/nyvyyN/FZGRsq+CY0kxgI7t0R4iYiL
         q8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764599693; x=1765204493;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyt+5awHIa1FfUVOldu9bx8q/TR+LNddXwgQKiH4TOI=;
        b=NP1NmyavlarZexwFxu4n30wtNhiaB15m2VbWQV8CwDgQxUC0YGS+n1xnbzWB7vv0Eg
         GAXvZu9/8qeMETfq4Nv4tmndffrYxVJvjp4S5k8M5CScYD1uzEyErD79i3JBGKmUJcqj
         BM2BVXxodbKYL4rpZIqGlNDyh5Wc6qGoka3hFfkhPk9OLkmgn6TZujOof0sbSkTwOBB1
         R8bFzFcAKBW75pX+Z1SDZ6zaZYsT831sOiqulDtts4oHkAPwlP6j5kYX6nLtOn6/McJE
         OiHby2XFoscdNvu4PQqkFAkQ4Nv3c0vJbQM21Eyt43qVjBWkGvnAIOh24HbJG0uURRJe
         KN4A==
X-Forwarded-Encrypted: i=1; AJvYcCVO+964o5F6miuGBIqcIDADwleTiG3Il4NZlBiI0mJskbOTAVxujyqhtfyXdSCZW3SfTqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvLZg2nA0pRvRuEGAf+tQ3hQ5iQ8ibc+g+c9DZttEEJEomyECr
	YBufSqyO+HSvBR3A7R7p9n8XjPEDpiNzjLNx4hmHc4vDoxCrWG568Si+
X-Gm-Gg: ASbGncvYj1YN1EnBRhEI7BhegIRmkecyxwyvnrAP7yUK3ULM+pCAfvhZRgkEBovcRXN
	D4yGK41FUskz7HwSw3jheA+FSj7izIL3MUQUgMIFUnjRiOzAU2Adsm7s0OGPgFtRq/gub7jbOii
	e+9O0A+SdRwpMcG85af2NqXUIrRTIFovphWp3uR3z6I+jvLhrgbLcyeuIVsQQJrSl7VZBAnPsvr
	8B2E18djoIsbB3J8s0QlEf9jz30zBnQrwFPJX8xWQsLbJMOBdopfvP0SuUC9zhsk3VhLs2sxbN8
	RLbvVZZecJka/miFyD1vWgeBgihyHzqMixhiTiYYjZthQvvApOXfT4YdQHw5ZXkhdqlmLBABeIF
	HITtOOtkUSTUe9HKf3jevds2ciEV5e+DQeVmAFqDGRCrrGTAkK0fMkXQYtG9z/mUzfKdEHJvovi
	hozzhPjYF8i/rdhX1DJDOuETgroyInRb6we2fN91DEHVoVytLZBs4=
X-Google-Smtp-Source: AGHT+IGxhgf7fwD/sAADVIFylECbBOWtpCbjO14gxs0m85Mb6XwaXTyCHSuUwhUfgFnYSIC8Scczmw==
X-Received: by 2002:a05:6102:8003:b0:5df:b1f4:77dc with SMTP id ada2fe7eead31-5e1de441b5cmr13562688137.31.1764599692828;
        Mon, 01 Dec 2025 06:34:52 -0800 (PST)
Received: from smtpclient.apple ([2804:7f0:b77d:1b6b:6139:6790:a488:ce51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e24dce4a6fsm4941463137.9.2025.12.01.06.34.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Dec 2025 06:34:52 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH] repo: add -z as an alias for --format=nul to
 git-repo-structure
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aS1Rvy9J2KjWrQb4@pks.im>
Date: Mon, 1 Dec 2025 11:34:39 -0300
Cc: Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org,
 jltobler@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <EBC0724E-A53C-4219-B314-1C8382584297@gmail.com>
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
 <xmqqms43aqn2.fsf@gitster.g> <aS1Rvy9J2KjWrQb4@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3864.200.81.1.6)


> I think this ultimately stems from [2], where you argue that it _is_
> possible to say `git repo info --format=table -z`, and the last option
> wins. It's the same for `git repo structure`, so I'd argue we should be
> consistent.

Yeah, I agree. I'm also ok with `[--format ... | -z]`, but given that
this argument parsing git-repo-stucture is the same from git-repo-info,
it wouldn't make sense that their synopses differ.
