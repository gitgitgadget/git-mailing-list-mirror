Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C02D7817
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470682; cv=none; b=jcPpw1cAXJaf/4OR5QNspZD3BJZ6+6gPfNSkJmorgiQzgP+kwk0DOK1JNPDIjIHjawqdTJ2HYZAQrZHFRKw0JWdQlvSW7V7swYjQVxTW0qmspsWdc7kvLgudJce13BBkHpfPYXg+JiJHuxnu/OyXchwcCp2zsN7QfFZaGan7/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470682; c=relaxed/simple;
	bh=Xu0Wlrlaaq/gIsvkb9rJqgqpPXv6G/mkhUZtQ/4Avw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AeUyCLzVhMSnxMSI/+ma0zwld6bHKulWuo+qhyI7wL2jdbr2oUxUnxfwOES7p5HjsedFOhaVQreWxwVQbSRO1koMB8BMJElgEr82WsDvm/0HY4aElgQ6xsb54xJRVdKQ9qr2m3qJEMjxtRo9fX6wPJDA9jFQZ//39j8umbSYfRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvSohdIH; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvSohdIH"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so4869189a12.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751470679; x=1752075479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AqofYmwvQMIcYsDfjw/1WU4WvMcNXgVK2Yin3IGaRG8=;
        b=UvSohdIHcQ1VoCR6RhWzKOM7n0J5qr3isDuQOZlu5iKcJWECTrRQ3Kp18t03ta7CiN
         xhT9RHNgdLdgwscac1s1gySMR92BO2I2eaVpruO/SZ22ndENIGTiNES7SP62HXLfNP4b
         D413vr+Kzp9LjZ+0f44UuN2AXTHnVpSC9TCnKaLZ1tkatw6RLeuj5oW72jRzuTRTLJQm
         XTpkGFGJlTs/MLAcaKAMB7xIoGrjzeY0amzOauP9ZHvjnJcFr113YcJLaDKDTCR13sdq
         eebclFgzXeOsAaMxNCx2ugjfEQddcfwqrdg+k9m1lZrY8QFY8xsYC90XX5gz1Ym0omFg
         aIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751470679; x=1752075479;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AqofYmwvQMIcYsDfjw/1WU4WvMcNXgVK2Yin3IGaRG8=;
        b=MbR5DmHxCc6898vnMCC9L2NFWCnCWPwqTN9AJFt9k1f6LcxMmLVz3H5aAss2c9lOJB
         f/AsTLaPDjqQQYBxkU/gKf/L0ll8pan05LfrVssVA9O1N0yqaIjRHRMv40jVdiiVc5PO
         UTU9sWXSn1euT5c3VKXNMzpCHUM9YloiMUkkNzILpz95jqpWh/EgZ4EHYCsHLEt5Fot0
         +S/0Tms/R9Q0QPyDIsEss0sbHjHrLrXQYQwW/qEJ09oWuW/BxtWb5W1F9APLrRWbKcWt
         GYXpkLkk7EW94NB4vySNk2kx7lfXFPN+RJWErLvQYcbJwUixrZk7ztT6WRv6H38usIIy
         P6JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL4CQ7G1q2Y/hrxOsQc4y9DR1v7MwLtiDzH0S2IQHKIggh17bN5ZkLlIw8m7newp+EFFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwgefOmyNaj1S/GwYJFegFHi2tvY48zsWGsW8/hlZ9YBJgFjTc
	YgEAVNGs580b1vgrYkpUPHdcuOvJNsu2ld5iFnFSOcRrKjE9eJm51GkyRhPmeQ==
X-Gm-Gg: ASbGnct6F+rMn7wUDIONFUXvbmxYXRmd2JNxXyYszSV9mkIqbc8WB78DfryZ89l0qcR
	J2wRcGMFA62Y5VMQwomxHk0Z2uK4oada6RgjvUtVeXc4WF1sZ1AOgHzQav+cbcoPI/4w0BCCYwp
	ZnAOKkliiYa5133o34EZzGnfQcGOkuTrm2UwBTmSQN8icRM3+fm50c9Rve58F5ubmhg6wStLM2D
	BuM7LGGGqteRV43aJrzsas0Y/aQOXd13aut++RwTK4DK3p0c318oPeGkg2daaMvVW6jTDnTD27l
	QBvz+DwDl3TF7s0kA+DwYyj3gn9meVIC4d91Gc0M9K2MRSpL2a9d5VJ3tWTYTCqfTTwt7J8KPNt
	vezXDGh0YM0mnyesjSC3I8oOaICg=
X-Google-Smtp-Source: AGHT+IEqVAwo4Rw89oQVic6+th86VRucFKOTPlrzDKiiuX8kNvpUfaZ7z4RZRwIBYSJJf0OjaFm3eA==
X-Received: by 2002:a17:90b:1847:b0:312:1d2d:18e2 with SMTP id 98e67ed59e1d1-31a90bddbcemr5152257a91.20.1751470679551;
        Wed, 02 Jul 2025 08:37:59 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31a9cc4a4dbsm121518a91.10.2025.07.02.08.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 08:37:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Karthik Nayak
 <karthik.188@gmail.com>,  K Jayatheerth
 <jayatheerthkulkarni2005@gmail.com>,  ryenus@gmail.com,
  git@vger.kernel.org
Subject: Re: Re [bug] pull --prune could not delete references due to lock
 file already exists error
In-Reply-To: <CAPx1Gveenh075k5W-KAKnyJKfdzMNL0iry-043mLB8rKZ_2wuQ@mail.gmail.com>
	(Chris Torek's message of "Tue, 1 Jul 2025 21:50:37 -0700")
References: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
	<20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com>
	<CAOLa=ZSA273KGPnwZ2aRBU_ybcCTYogBHvUwpa+5CfDOc2bEWg@mail.gmail.com>
	<aGKdICvmKlumU0ru@fruit.crustytoothpaste.net>
	<CAPx1Gveenh075k5W-KAKnyJKfdzMNL0iry-043mLB8rKZ_2wuQ@mail.gmail.com>
Date: Wed, 02 Jul 2025 08:37:58 -0700
Message-ID: <xmqq5xgafvs9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Chris Torek <chris.torek@gmail.com> writes:

> On Mon, Jun 30, 2025 at 7:21 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> [regarding]
>> > +                             if (ignore_case && prev && !strcasecmp(ref->next, prev))
>> This won't work in the general case, since the two refs that match case
>> insensitively aren't guaranteed to be adjacent.
>
> Also worth mention: it's not just case-folding that matters.
>
> On OS X (Macs), path names get "normalized" so that the names
>
>    s c h combining-umlaut o n
>
> and
>
>    s c h umlaut-o n
>
> refer to the *same* file or directory. On a typical Linux/Unix FS, they differ.
>
> (I don't know what Windows does!)
>
> So, if you have a "folder-full" of "pretty" German refnames, some
> spelled one way and some another, well...
>
> (It's not clear to me what, if anything, Git should attempt to do here.)

The system supplied argv[] is fed to the precompose_argv_prefix()
helper in compat/precompose_utf8.c; opendir/readdir/closedir are
also wrapped with similar NFD/NFC normalization (really, UTF-8-MAC
vs UTF-8) helpers defined in the same file.  So the path you read
(via the opendir/readdir like dir.c does) from the system, or the
path you are fed from the command line (via argv[]), are normalized
before code in Git above the compat layer even sees them.  The path
recoreded in various mechanisms in Git like the index and the tree
objects are all normalized.

