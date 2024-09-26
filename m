Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2E522A
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727378261; cv=none; b=jJQ1uVJCsEAC8jFr1YTT/PvNLrGtVKOLb8iwTtUiExzlQqx/SKIQ8hiyiOu5/gAwyzhmSv3sJKNHr01KvxCSltuvSyx1A4UEtRKWTAX7JgJuf4885h14+EKowoBuJQow61aYR4yOXwPdPecx8pvv2l4tj1N8cwtbIU77Nd/4+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727378261; c=relaxed/simple;
	bh=5qGyAeniwGyA7Ed/vTotkh2TsUl/fgdpAXVeZtRDTt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RMZtdNzOhkrz81dAeGYF/RjZIFxo6IxvWgc8XauVofme3RRInX/mkytpdfgix2hkEdyEVl45PqKBFLthVKfUw5INaLWpYF163ulwaTr5RgIAlmps5JVxw06caye2acMQAa0CJk0yHcxbsCmTMEH72CNwqYUv93Sf17+FmtxgIyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxIeywBe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxIeywBe"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b0b2528d8so14528375ad.2
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727378259; x=1727983059; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omK9diXKIL1kfXWwaan5R1SNnPvAkoF6mezRoulLzbw=;
        b=KxIeywBe89ihgr3oFZN7zvDciYj2YkHSssiL6k2niIir59BU8TraIYiBsDRDpcKT6f
         eRHgC50I3dis9ZA+aWjM3vUIYhbO5+vhUlcT3r9Fd1j/GP4GK3AZOsqSchG+AnSvfVfd
         NfwSjr1obZT++B+p4BQCW0r5iAZM7ocPoxCtReiN5GtKiOMjuLlr6pSU35Tz8WIaoPXL
         PmtODJyP/TxoYvpzPdEUsgAcbyKemACT1KBDCebp7jILKKdHNTvt2gbovwoJGjKNLtUX
         zvWUkJ+US2puPpzBkjS0sd1eFpTd2COO1TZyx1pzrAasWtHjCW9S5FbvC3Iqk0elAuPR
         /i1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727378259; x=1727983059;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=omK9diXKIL1kfXWwaan5R1SNnPvAkoF6mezRoulLzbw=;
        b=QpwKfifoJbHCQSG6BTTh+QkSmbJB4uevuPbuN4OgNS2zD90LWJwPrM2g9Vb7CC2/yq
         /sCikJTp/obKbV84h9fLJP0Zx83pDdyVXTvKQey3cpYULATAbDb0PPv8Mw/VfuunHEwx
         FZMqUl5DLAsJNwG75pFJJrqrSuiSjBUo5X6TwArczPz2A0PNrDk+H4N/BJ1sIf1VFKZx
         A5H0z/bRve6aV4dwjAVQhJ6jFYbYu0OnebPDseZLTWWcKhnpSxjxyiysgvfABixCXwz2
         PIsEZWWHpITs+FiBaOcU+m8Tok2qOolC5YuT1rh+cu2mgisUWWzJi8ikQF375TmJNcGb
         VOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOcOc+YdLGCN2+8imkD6BnJOINKp+Tb6/tQ5f7HLgZhp4Ozf9VVLjKcICjQJD9nmOu/Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VFrVuQpA5n5+LzTispD+PBbjCRHB9IZQ5y5udK38LRUNH9FU
	dSDSqtYQrXZP3uYJyf0H+kY+9KBv0xIIg0WCCTcjltIT+yWQO/eb
X-Google-Smtp-Source: AGHT+IGs8kJmpLY1uXIedJ4BO7j5QSZMvs3VwqYqfUkhmjkvssfEGUxhNgCoNYAYm4p+pGygYPI2eg==
X-Received: by 2002:a17:903:41ca:b0:206:9ab3:2ebc with SMTP id d9443c01a7336-20b37b7c063mr8809675ad.47.1727378258890;
        Thu, 26 Sep 2024 12:17:38 -0700 (PDT)
Received: from localhost (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d61da3sm1884925ad.61.2024.09.26.12.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 12:17:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: John Cai <johncai86@gmail.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/4] apply: remove the_repository global variable
In-Reply-To: <CAOCgCU+hv07+FCupr2Ok9LJm6HYT6n6t+ZpifAhwrRnMzOnnWA@mail.gmail.com>
	(John Cai's message of "Thu, 26 Sep 2024 14:59:50 -0400")
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<4ce463defa807fb99eef6ce7abcd758fc2065c13.1727185364.git.gitgitgadget@gmail.com>
	<xmqq7cb0ucm0.fsf@gitster.g>
	<CAOCgCU+hv07+FCupr2Ok9LJm6HYT6n6t+ZpifAhwrRnMzOnnWA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 26 Sep 2024 12:17:37 -0700
Message-ID: <xmqqa5fui5ri.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

John Cai <johncai86@gmail.com> writes:

>> > -     if (init_apply_state(&state, the_repository, prefix))
>> > +     if (init_apply_state(&state, repo, prefix))
>> >               exit(128);
>>
>> Hmph, the reason why we do not segfault with this patch is because
>> repo will _always_ be the_repository due to the previous change.
>>
>> I am not sure if [1/4] is an improvement, though.  We used to be
>> able to tell if we were running in a repository, or we were running
>> in "nongit" mode, by looking at the NULL-ness of repo (which was
>> UNUSED because we weren't taking advantage of that).
>>
>> With [1/4], it no longer is possible.  From the point of view of API
>> to call into builtin implementations, it smells like a regression.
>
> I see your point here. However, I was wondering about this because
> we are passing in the_repository through run_builtin() as repo--so wouldn't
> this be equivalent to using the_repository and hence the
> same API contract can remain that looks at the NULL-ness of repo?
>
> But I could be missing something here.

As run_builtin() discards the value of nongit, we will always see
repo == the_repository passed to this function, whether _gently()
found that we are in or not in a repository.  I think Patrick also
noticed it and suggested to pass repo or NULL conditionally in a
separate message, and if that is done, then I am fine.  I do not
think your [1/4] as-is did that.

Thanks.
