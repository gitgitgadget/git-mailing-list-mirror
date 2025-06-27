Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09452E3B1E
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034327; cv=none; b=qJ1biYvPXa1QYaYXzjcjkmnDfvO5AmePTrsmNiRdofl3gAZ6mDOKkOSE7BtsiQuZ6JMvDQYDVAW8EkAYe59l78SvXAGw7FMJuVtsA+zUsWEdPD2abJ2gqoPyUcTDHGGZ2s+rli+wIwQR6mX31lXvkfy/SXKaFCYtP++s6bwG3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034327; c=relaxed/simple;
	bh=zC1ujysufy053xEH6uwOB/YzjwqDmqOX65Mpwznim/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mulspfVfTnTm92eMWBLmaSPBgS/9kNtSwyq1WdT8CWiNuOL/Dnnml0Lv/SujBvVb5Bj0+5uWrwziA0tr81l+6V9Z1DTe8jHPqkB3h4yhly6Oh4+ESCS8jvNhV5DhJ7sOyzzrEDdCrYRpuRNSDsRWNoGhyHJRWIHnN0tdG27VwBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2hnvqWN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2hnvqWN"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b31d8dd18cbso2640372a12.3
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751034325; x=1751639125; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fx+pwFmyCrsWSK5IyWwar3yyRQoW048RpmyQw+18Om4=;
        b=E2hnvqWNkFLA3+oV1cLju6HUFyjgBW5v6Wv/40dhuNpJ5QpTk1WqobovFkjTvVAhBV
         0fWArEZ6NSrXWtXvgWbuBXUpTLqUGpjR69jynN/ReeS4TcoqNJLJyNoqZ8kVE0QvfGKz
         nBvzHL8AqgPOpS1o3iRJokWkt6Ek2LPov3v8s4ThHpsSdWKawXySus0gytRLAIcgJ36g
         A/nRlqt9dTTZrEEA68Aw8brXigeEviQ063a1Pd7B8Iu2fR2v0Czak5vbG2H63RVHNnEi
         5JHbYthAZwd8EoKY08ttx8AAk1rBc1ZRjPzrHnkwOzfFtI4GN2hUrHJ19YpSKCcHiXgX
         IEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751034325; x=1751639125;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fx+pwFmyCrsWSK5IyWwar3yyRQoW048RpmyQw+18Om4=;
        b=F2yzDQBilKSmGWEtZscVq4bZzGywRsV68jJErDTruThc5Y5F24XCP4O4Xm5dZMaqW7
         VpjD4htfKwMz23LaToMMxeX/rF7PMr+37TBs5xAjIMtJ9odWjEnsU8SkJL0j1ywzDGjA
         QX//iRDcNNd/qra7fCHOsc2yEqMagMijykuL9DHvx/FXVSIJapdWYVqSIcU3oRlvr3cY
         M7S46TFZCyyjaFs27C9fQ1uhZQiYBdgAnZ+8benXX7vwPO2a/00CHx7B5QTt1LSRkm+m
         Fw4zsTwXJnsXv+z91Ezg/lZ40YWO86LGAxxjy24lQ/4AFy3d9YvpUVbJ2lkI66btLkLi
         //+w==
X-Forwarded-Encrypted: i=1; AJvYcCWvUXIxIyZCDulvPjjGMFvFX0IAMLbV7y5HE1UUyK2nl0YOxZTzu6oAhYdVqcYCr3Wllus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtkZdvIX+OB4sMq2LktqR793PI8bI0aZyz05T8F8qlNwfD8PkO
	8ddpNg1Nns+HfUrd9htuz8Ubd3+ykEboRc/xytPiKQL/f/FBBPdPQFS2
X-Gm-Gg: ASbGncs5L+gS1xFXTrQVodqvbIvAFwriwd74L4QRskt+ec/djSBSdUa0ENHL3LaI9Mv
	rbAIqI80GOnnoEzKSLkD7uLatzU+ksXX5kBA+7idxjzuQnWH9h6dK2KEAgk6B4MZXtvNPFKncRi
	n3iL/QorYo1f105QLsuw/okcu1p+o4uKsMNzkWgIWfSDD86zDBRQZsIEHHK2xY85meauEbmAkH+
	Fzx6bXLT0wsmvMHy6c1Th+jZ2zyyYMRHQWW/8Ga7BveXnGgg2q9CRcDPY2XmCyQbA2eyGhNIofc
	25cFysR+vO+9xDjhHLAlFYUpXXN+74fhaxRuhy9FAKRXoynHNvLhRliae39+fXmaxi+AjGr63vs
	o7MAmkbY5Mkw9TeQ65lYYxyDlU9k=
X-Google-Smtp-Source: AGHT+IFju43jZffrmL3m0VkMM8gLo4yX5UW7IztErlOIsgnyl01lCq/Fh2n+i2huoUf6aUjbAo+uLQ==
X-Received: by 2002:a17:90b:4e8e:b0:313:f883:5d36 with SMTP id 98e67ed59e1d1-318c8ee5461mr4385881a91.1.1751034325099;
        Fri, 27 Jun 2025 07:25:25 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-315f54270a5sm7161372a91.25.2025.06.27.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:25:24 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/4] meson: add rule to run 'git clang-format'
In-Reply-To: <CAOLa=ZSJH-Wji+-oU+ku5aojYzEuC96tUu+24UTuTxCxt9LYNQ@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 27 Jun 2025 01:12:11 -0700")
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
	<20250625-525-make-clang-format-more-robust-v1-4-67a49ecc2fd5@gmail.com>
	<iutm4xxkhchcpfygtqo2s4nit42sclzen63465ljtovzgdsebr@okpj5jtw62r6>
	<CAOLa=ZSJH-Wji+-oU+ku5aojYzEuC96tUu+24UTuTxCxt9LYNQ@mail.gmail.com>
Date: Fri, 27 Jun 2025 07:25:23 -0700
Message-ID: <xmqqtt418dnw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>>> diff --git a/meson.build b/meson.build
>>> index 7fea4a34d6..578db26df2 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -2144,6 +2144,18 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
>>>    alias_target('check-headers', hdr_check)
>>>  endif
>>>
>>> +clang_format = find_program('clang-format', required: false)
>>
>> Should we be checking for `git-clang-format` instead?
>>
>
> Yeah. While `git-clang-format` is packaged with `clang-format`, it does
> make more sense to check for the former.

Just for my education, what does find_program() look for?  Installed
packages, or a program on your $PATH?  I am guessing that the answer
is the latter, in which case it is not like "it makes more sense to
check for git-clang-format"---rather it is "it would not work at all
if we looked for clang-format", no?

Thanks.
