Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804BE3173A
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214713; cv=none; b=RODtE02l0snGZnVdgZudzMfkyD/pRKYkOwQF+iqanLrKVEOFiSUKPMZWVJ0+iyFB+zs5Ll1r0m/l6xppDxXbPVJH880SL5i/miW766+CtAvVbhKLQ4ocVtugl60eomptAu4qT14i+69iqD6DGVSuncmm7TlcK9um1yufXtiCIVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214713; c=relaxed/simple;
	bh=fYg0J/4IcDUgmU6D48lM96YZAbmTpUtHShIXKiYJrSw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Ppix1GHpHNkCpMks1aBeB9++3sd9W6tVHY56wFZNlvMalYbWWM0tOpiGZdGP2jxfC1S8xVJCBE2tDwWzh/K3XHy5BARigyTY//Hf+GdQXyc5rngiBcLa5L5x4QXMOwZ0JlDFKOx6kVI9bSevfIfZsrPSHDuMoQetXmwsgEOwysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imZkURJB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imZkURJB"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eab4bf47aso1223014e87.0
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 12:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706214709; x=1706819509; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6clJSzeWovdZqQY8tqk//ZYO/W7hcSeEYuu8rmsGQ4=;
        b=imZkURJB4y02sd+y/PJpPj+p0XWM4b4alcJQOu+H+TjL11bHq+Le2huNBklCURg8qy
         1hYlLlcdrYmwlmIDb+rHGr60dKOdJ2NCA7iwhHWoH7o+zvlKuuekBprxWm4zIzr8PoKX
         ypCymYETz2HRaLbmyarwtCk6toW+GQ9I+qx7DFCi3Wc4cWk9JRR70JbOwoM3GFUnn1ya
         YpmjUxCzpOSWa9SR3kk3xIryg41tKDmEaSqe+PJRLy3PG8yg6yFu9eQskOc3+6i/TDVJ
         36IKensdspEJ1mqtoHtgR1oH/9nQzFamwcPiS61QWyRksVbczPMx7WGHIWrGkUMq3aNj
         JFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706214709; x=1706819509;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6clJSzeWovdZqQY8tqk//ZYO/W7hcSeEYuu8rmsGQ4=;
        b=M5PtOFXJ+m3iPECHpGODYY/hV4CjBs5iC9DRD9Vsf5642Vhu5mfIutiwejyws+p7v0
         mFigDOi3aVbZGF3ke7yYGbdOiWXseVpLRLffmb2X0NDnn3xD4nSd1RVVk/YhjyoM4NEP
         2ySfMPLWklO+VmG/5HNDNMaRbRDcXJs455XJQpW3PGb3paRer2o1hyCiYp9OM8F9882Z
         5sgn6+Cc/4TrqyiWGZOX5x3e65MwaeNDwt7tozxOSre3F+A7ExTk9xpESlZOkiASdoEc
         yC0Wlb2d+LQsnFp3xOIc+TV+WUXG1U6HPDGO1TmyApnDveVhXp8JJqOs3QtNmudknU8l
         ao6Q==
X-Gm-Message-State: AOJu0YwThMhfXn8ER8Y8aN3hQnEonKya2/k+pTLEJlnDUaMuthuOA39P
	C8kHnh8wsYwJgUtcEXfVEUF7+2+DanjUTJNmMIFdLFLFVAkFauBqAhww8MHP
X-Google-Smtp-Source: AGHT+IGHqG5DnQgtsPhUB8VY+ffwbhjlv1AB5jtnGpvSIAvo9rRDDXfmHmBs6aPnOobYfAnmxsts1g==
X-Received: by 2002:a19:6409:0:b0:510:22af:2bfa with SMTP id y9-20020a196409000000b0051022af2bfamr55220lfb.6.1706214708917;
        Thu, 25 Jan 2024 12:31:48 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c28-20020a19655c000000b0051022c3a76dsm47991lfj.177.2024.01.25.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:31:48 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	<87a5ow9jb4.fsf@osv.gnss.ru> <xmqqsf2nnbkj.fsf@gitster.g>
	<87plxr3zsr.fsf@osv.gnss.ru> <xmqqa5ouhckj.fsf@gitster.g>
	<87il3h72ym.fsf@osv.gnss.ru> <xmqq1qa5xq4n.fsf@gitster.g>
	<87ede56tva.fsf@osv.gnss.ru>
Date: Thu, 25 Jan 2024 23:31:47 +0300
In-Reply-To: <87ede56tva.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
	25 Jan 2024 23:27:53 +0300")
Message-ID: <87a5ot6tos.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> Now we are going to introduce "dry run" option "-n". Most simple and
>>> obvious way to do it is to set internal flag "dry_run" and then at every
>>> invocation of "remove(file_name)" put an if(dry_run) that will just
>>> print(file_name) instead or removing it. Let's suppose we did just that.
>>> We get this behavior:
>>>
>>>   $ git clean -n
>>>   fatal: clean.requireForce defaults to true and neither -i nor -f given; refusing to clean
>>>   $ git clean -f -n
>>>   would remove "a"
>>>   would remove "b"
>>>   $ git clean -f -f -n
>>>   would remove "a"
>>>   would remove "b"
>>>   would remove "sub/a"
>>>   $
>>>
>>> I see this as logical, clean, and straightforward behavior, meeting user
>>> expectations for "dry run" option, so I suggest to do just that.
>>
>> I think we are saying the same thing.  If the original semantics
>> were "you must force with -f to do anything useful", instead of "you
>> must choose either forcing with -f or not doing with -n", then it
>> would have led to the above behaviour.
>>
>> The thing is, it is way too late to change it that way without
>> breaking too many folks, and that is the problem.
>
> If we agree on the behavior above for sane "dry run", yet you worry
> about backward compatibility so much to deny changing the behavior of
> "-n", then a way to go could be to introduce, say, "-d" for sane "dry
> run", and obsolete "-n" while keeping it alone.

Except exactly "-d" is already taken, but you get the idea.

-- Sergey Organov
