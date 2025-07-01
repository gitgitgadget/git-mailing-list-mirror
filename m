Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B461DE8A8
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385280; cv=none; b=XTeJfPa8LgQiXcPNxrWydQRSVAXGK1r1uWCNDQNvt03ye6hK+QI0M4Tm/YSInp624N/B1aIspQdsV6n2e/ChXLQ4fYUDXHsVL1Bql9+EMnS02te4YT2DRIzuqaeE+2p+/BP/Qd5SG6QIKOqksI1GAhGWLzEfBzQZbpDxJDb53Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385280; c=relaxed/simple;
	bh=2PSvOAe4kfX5yciucbxscKXE7A/3SddElmutdRV7BNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lT4M5C4V/E0S1gJ5bo1F6GbDaSh+XBZzWORl9qwbMwpnUtxXFVDWXYle4fYX0VpBgs64SkmdzJ/YH+jsE/SGK6MrKaMf5WU8AIhe6RzAJ/6X1SlTsilocNFmTxhbkACU0e6RAgQO0bVET1SGJ10ReTyxF3RwRhSvexUACMlfCRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJk7ltNE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJk7ltNE"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31393526d0dso3755336a91.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751385277; x=1751990077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h+KccZt8WWte29s3FHRxRhvO9a+dVihWdW7qfI9xxdw=;
        b=cJk7ltNE++O6ANrwyb1MnrJT66WqL9AgfZlpQuDWgeDHE4bL3FBezl3qTxCA8wAVy1
         u4Hd2e1BbgabQjOMWd10rYnjS6ANNCon7PJKFG9M4wU+pbsujlUDC8hMrkoBgKt3C+Y6
         Osd3HBd3rhra1CIxrXhl044RDbV7gnfN6ieni4YdTs1RJP6k1bZ6jqgX9MlF6aqDnMTP
         U1CF93w25jIlW4uncXLhweStrpsxr+TumNUWGqp5PtkegPy2xu3nPUPph5deslhlRWrv
         jvCCFo0Ta/p+4IJYsQREu/Qmi16UIYeVlAlgViI2P9nh0BBY1GDVMaT42q01BzmAD41I
         U2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385277; x=1751990077;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+KccZt8WWte29s3FHRxRhvO9a+dVihWdW7qfI9xxdw=;
        b=YQ502Olu5h/mLXxrY0/+8UxagRjaugUFc4yyhvO+fd6Qu5BwUGmooZd5lLr8dDBITu
         yl3YoLr90p4zbFQNyJqy0uBU+HeopsGK9bXEshwVuT6NDG5CZHGZgwceaBAsPcABAT/d
         Ev+8NgFLDh5HcLE/iqK7wRTZMrJ3aal6uhgJivUOsWFRG+YpGHQHrMzMcRrBMFvX1gs+
         bIJFP6FWIzQnuUdbhHdArNuSHuNojqKx1pqikfb8J7B/PIsyvvf2h9YkkHo37yNQorr7
         dR0zyfBjGkhBy40ES9Wetf64PsKqVbWNgsv7GNL5RunZGpjJMRHsekObxOFvacq7ijZt
         wDeg==
X-Forwarded-Encrypted: i=1; AJvYcCVygvwXoXImVo3WM/t5m+tgOey4jDWOLH6yg2tLi9AlIIDM8R/K5FSWTVQL5QRsA1QCRNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKeHmb3ZZuTvlGjt9vhQSCw6Rxw0ccg7vr0iIuZ72caKxTHhs
	YOn16J2I5uDw5KvP/CsYYE/5vJ8/5YKNM5xbyM+DJFFiIQIclyhY9mm53NpkBg==
X-Gm-Gg: ASbGncvT5LHyVT4EkMlFXlaRvMyZX7Pu2TunGJzxKwkMnSYHmP+w9QkMR9uBP+4dpAw
	cCUwf4IuRJUq+7rD0z2MGPywgL9qqB1PWRyLiZ4OuVz0fatkaM63pk8vidoEsJwYKijRXwcDXL1
	dhihFsWbYyMDyU2FY4EgD/uOu8LQXbdm5lTmo9NF9wXKW1S8iLLoVcUybZhUxfrl3i9z1DvfdRZ
	U5n6kkjh4HjmsqF2ujRKzSQsgT7MMLGlnIluywj8nHFLGYNxZ6jerhvMKvtlRfe4KtVedMcwJLf
	NI/XttwyR6sWt+7JLd2uQvQwdRNeTAKoeVqH+xE+r96QyU4act+oepo3sHJdyW+8/wCc4Dgxq2/
	zC5GNclqCCnlq6nzSEKnOcLhnEmc=
X-Google-Smtp-Source: AGHT+IG40zxgQjE/ad9GpYTuhJJuVOQcLJzmQjT3Z++irgYnWoEBbU6C24jcZ3wBNojOubnbohjcrA==
X-Received: by 2002:a17:90b:4ad0:b0:313:5d2f:54fc with SMTP id 98e67ed59e1d1-318c921993bmr28884374a91.10.1751385276561;
        Tue, 01 Jul 2025 08:54:36 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-315f5382e87sm17315609a91.8.2025.07.01.08.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:54:36 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Leon Michalak <leonmichalak6@gmail.com>
Subject: Re: [PATCH v3 4/4] add-patch: add diff.context command line overrides
In-Reply-To: <7686a5e0-23c3-4e3a-b5ea-3b8c80ba54fa@gmail.com> (Phillip Wood's
	message of "Tue, 1 Jul 2025 10:59:55 +0100")
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
	<b68c58b667c29c66433b4634ad44ee9ec5257e80.1751128487.git.gitgitgadget@gmail.com>
	<xmqqplel17s3.fsf@gitster.g>
	<7686a5e0-23c3-4e3a-b5ea-3b8c80ba54fa@gmail.com>
Date: Tue, 01 Jul 2025 08:54:35 -0700
Message-ID: <xmqqa55nlxdw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   * add OPT_DIFF_*() macros to parse-options API, as its utility is
>>     very narrow, and forces those who are learning parse-options API
>>     to learn one more thing.
>
> It means that we have consistent help for all the commands with these
> options which I think is valuable. We have a number of other macros
> that define options that are shared between commands and I think that
> works quite well.

I understand that principe.  What I was wondering was if there are
enough places to use these particular ones to make it worthwhile to
enlarge the set of OPT_* macros.

>>   * validation of the value range to be duplicated for each and
>> every
>>     users of the new OPT_DIFF_*() macros.
>
> Yes the validation is awkward. If we changed the OPT_DIFF_* to use a
> callback that rejected negative values that would reduce the
> duplication.

Yeah, I was wondering about that approach, too.  Another benefit
with the "validate just after we parse the value before we assign
the result to a variable or a struct member" approach is that we can
also complain about -1 that is given from the command line (which
the current code ignores, if I am not mistaken, because it needs to
be silent if that -1 is there merely because it is the "not set yet"
sentinel value).

Or perhaps the valid value range Réne has been workingon canbe used
here?
