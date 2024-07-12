Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4D1741FE
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798185; cv=none; b=eJWBFCQQk2TMEZDKfdZKszRKodov7Xl6/Fl3xhOL4cpK7Ll0/ZHKfNpUf9tTQwhdXm9ciwLsBEtCGi7YThbYYPJVhQt2JogY1dAplMmi7IOIke2mhIP08+vV4cXVP+KIeUEYL4ww3ZOfOWBQX3DnREjvhmDw8URKRlaYttWdNwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798185; c=relaxed/simple;
	bh=lWwmjHgppq07OfA9izn/Gofkh7gRRLOPS8KgN7NGoqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW+sC9TxsgiHc2yEySsOar3XWptgg3Ps8WYjUnix4503z7QHQVuZrxpbeY/xvp1WKtMGTEr1NwGZrt8tg4cYC7U89jnMETqFs31Alp+hiEpPg3psHLbdWs38/mwG84ioydIKQwkUicKTw8DfqM2RHfaL259fT+2GS78d2ZTMfqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOLs6h2+; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOLs6h2+"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee910d6aaeso27535751fa.1
        for <git@vger.kernel.org>; Fri, 12 Jul 2024 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720798182; x=1721402982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZE/d+tp+ZMiPc8+JD9ZyMQ+cVyeZ/ifEvVvyNB05+wM=;
        b=VOLs6h2+S9517UN91FKG+mFE+vHwY7+RJJ1BgXDFz2TcQPiO+4/5jJ+2WpUnVuB03U
         QIgah36TKkboj+FLFWMapxFjy/kuNZOEc1fbk9PETLnOd+bDB6nrXhZjcRclF1kMg9QA
         dTntKgBih0PpAGAZLQkeYg7lJXpYhEI869XjydAj5xxl88UIigKWphVRXLujghpH7oA1
         0QSmcCyxr1tma0FKLqfs9/EsZ15DzeK5uERRndDC09aLMa2BrGQvoAHkIr+45DmP7UjU
         RC5npcKxEzgKCqiLuBo90yR0MdxVDHkRjBTASrfevVjf49r0ciNjP7k0WnoeYq0TdWql
         Zxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720798182; x=1721402982;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZE/d+tp+ZMiPc8+JD9ZyMQ+cVyeZ/ifEvVvyNB05+wM=;
        b=dB4JbsTuOM/BdueuFWayre8/GWKnzSQn7+GPO7VzVTLXV5bJc9Zi3hCzRNrQif+l+d
         xSjkh9+O+RHw7czG52Q2lc/1sR7ufEoD8VVYTTX6/PAK5W2b1sQgmqclDTyd4G2f1dHl
         0Sye4doBIcEgn/c6vnq5iuIjvGsB5KY6tXYxN1qoomJelPWLkH4F8zj0nZxy2yJOe9BT
         WudOvGwVSbO9kGWzbfxza4ZoJAiJnoJvHextVln4HaL5xd0N2lS4eFD2szxDGCzJd1LA
         XpZKw6XDZHo5VlaXMtoN0snWMzYX2C0vfR7CXGeyvyMdMIoK2LIjcAkIYrZfP/h0AUJa
         0V6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXv9Z0aA4jar3hrJasBq7s6OGfK2L5y0GgyJRla9dPkipksYltmB+F36M3eJtp0edpqPb87zXyxUVhjgE6eEZtMBjjQ
X-Gm-Message-State: AOJu0YzX0l8JZPFqCIbnjuooe7ugEw23+p6BtDKZpEYWrg9QROFNA2Y5
	aaERuzFitf83zOMJDYoER4067cNyJT17PjdBmskHKw/OxWRFTTMT
X-Google-Smtp-Source: AGHT+IHhbDwxlecTeG6znFnyKioFA99wV6VImJ5h2etI8kcvA7j9T4JjOZeJUDGzOnz8Tft8kIIUqA==
X-Received: by 2002:a2e:8297:0:b0:2ec:6639:120a with SMTP id 38308e7fff4ca-2eeb30bbb0fmr80946281fa.10.1720798181769;
        Fri, 12 Jul 2024 08:29:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f239883sm26744965e9.10.2024.07.12.08.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 08:29:41 -0700 (PDT)
Message-ID: <42867b72-58e0-48d7-86eb-7c312db942dd@gmail.com>
Date: Fri, 12 Jul 2024 16:29:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/8] clang-format: avoid braces on simple
 single-statement bodies
To: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240711083043.1732288-6-karthik.188@gmail.com> <xmqqcynjswz7.fsf@gitster.g>
 <CAOLa=ZSJ-PQ+8rsURP16QQ_K8rR8xrhFO8tnAPSZD88COrzj1w@mail.gmail.com>
 <xmqq7cdqpry4.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq7cdqpry4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/07/2024 16:09, Junio C Hamano wrote:

> Of course if we really wanted to avoid end-user confusion and still
> want to have this in CI (if only to see how well the rule fares, and
> what the actual false-positive rate is), we _could_ run CI's job
> with custom .clang-format file that is not visible to end-users in
> their normal checkout, or something silly like that.

Getting some idea of how useful the auto-formatter is would be valuable 
I think.

> If we are
> going to use it, then we should use it everywhere, making sure
> everybody is careful.  If the cost of forcing everybody to be
> careful is too high, we may want to retract it, but we won't know
> until we try.

It would be great if we could find a way to auto-format the code without 
inconveniencing contributors.

Best Wishes

Phillip

