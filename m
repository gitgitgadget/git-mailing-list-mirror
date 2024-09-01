Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34AF23AB
	for <git@vger.kernel.org>; Sun,  1 Sep 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725204394; cv=none; b=YA5ivxU3q0XoyR7Qnbm/75hvQX0gC1FRUf6kmgYXhsSIBMFTPGRPE2du8whO/wgy+K7TbMdxRk1CgCogdWCAE1wrbGGVXacpSOHC3yGTFYUAXb6tGe3AOc87iUxwVZ88tmaiYpvf4iXOPfoTETnH+MyWY+XP6Ifk4xPtVnkdCrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725204394; c=relaxed/simple;
	bh=+uPlV298JoktKhz9QMZ5vxd39o+wZcafvZ+5lp8Ky7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n+yqKn8Y8YI5Q3UIs6b/ugs0ZqDi80lNIwi5re67INGJgv80uth7CEk7cSoOQ6jwvbNYhgmW+qKCYFoU44drkKctSkLntExD4LFM6fxQ9nBwB71zIbbaR6nY121nr5qpeEjmVimnVXzzw0aAXq2gHAVSMuAkwOPflk8eYu6Y6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4YMcs39; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4YMcs39"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so3188156a12.1
        for <git@vger.kernel.org>; Sun, 01 Sep 2024 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725204390; x=1725809190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AvxPyb4lv2ip7MJsj7czpuACithCiBFB3jZgwn9I8e8=;
        b=a4YMcs39xFfnEpSWrg0OgzwxqngP22donpC/j6tJ+HVQsVsjt9qVvh7sChDjg4oS9n
         idaH6YMmtZkofhqcgn5+ElOAKwwCkQyn0VSZCymQw0k+ySMV9OVH3T2grfwTrsm4TLyV
         MT5ly3U+U7IPdd0U/24yE5FGNgjJxUZ318k43IMj9RmHW9pYGrDKjDWH0Z98my1aa2nP
         vKi/kVT0nWcyoGuLkca52w2vtq+S0x+KZquf6RXz1wltaJp12tsBxXbZEZtYNE2ZUcyK
         mfOO4yTeAuvPciCmQI/7Z3hZ7awsvy9Wj90Pz9oRdGRIVL+0I5nAUe8VgIHBrDn5lf0x
         NQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725204390; x=1725809190;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvxPyb4lv2ip7MJsj7czpuACithCiBFB3jZgwn9I8e8=;
        b=AgJUmNgaSkWEj2TbabWYGHy4mz89vAnqT1euwpzvnnCbp2WrzWV9A1gpr31Y+NVbtY
         9ydbTGMTAfEzuUCDk4FGS7JlUv41oK0jtYWW+6wQSI+QfAEvtaaGSbJWh7HLOGGFLOFq
         YwBUZVWK0O+F8GazsaBQmN1zUfhngw/0lvfiHl+bXufsuPg5Vmsbh622i8jej2qO3InZ
         XyLTMAlCzqopa6d89qYW7pzNygcXRZJUBnxZh3BwYTYaQpP8zKQkDMOIODfKoe3mezCR
         puF7nLqe8/If1iK84UFD2hX8vdQP9D9OQf40bE3VhAK5LOsS0Wfln0ADzQ69H9jRNafH
         dJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWazvTI99dlvMpcdPvAfQsfUGoWr6lmuff+0YtDzjIh0X3pYdbqbTraSOSsVZRrzkmLOoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZ6OG/4CxFRH0RRaUTDhkUh2SGrUh5oB+8b+W+Pm7tGdaWEuC
	RFg56ob3vuuKasScIjrsgI7X/x+pXrx1tlq/JPIBbdlFepp/nrs77xZ2sw==
X-Google-Smtp-Source: AGHT+IFw4waCJO1erg5i5W29HuJcAOFbyXgiHtLeVuXEF9pW1dGnxFlZaDKhdjfnNsUFmEysJEynlQ==
X-Received: by 2002:a05:6402:5188:b0:5c2:5141:84b0 with SMTP id 4fb4d7f45d1cf-5c25141866dmr1197353a12.35.1725204389336;
        Sun, 01 Sep 2024 08:26:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c73477sm4397939a12.39.2024.09.01.08.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2024 08:26:28 -0700 (PDT)
Message-ID: <61a4fcc1-1dd8-48a4-a1d4-0201232c9b26@gmail.com>
Date: Sun, 1 Sep 2024 16:26:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: `git rebase (--no-fork-point) --onto=<newbase> [<upstream>
 [<branch>]]` leaves HEAD detached and *HEAD not moved when <branch> is
 exactly `HEAD`
To: Han Jiang <jhcarl0814@gmail.com>, git@vger.kernel.org
References: <CANrWfmSY1F4UB2QSjN8XKY7Kwx6FL8SOrz_OadZ4u8XYDpZfBg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CANrWfmSY1F4UB2QSjN8XKY7Kwx6FL8SOrz_OadZ4u8XYDpZfBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/09/2024 12:02, Han Jiang wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)

> git -C './client/repo' -c 'core.editor=cat' rebase
> --onto=HEAD@{upstream} --interactive "$(git -C './client/repo'
> merge-base --fork-point HEAD@{upstream} HEAD)" HEAD

"git rebase <upstream> <branch>" is designed to switch to a different 
branch before rebasing it. If you do not want to switch branches you 
should use "git rebase <upstream>". "<branch>" is expected to be a 
branch name, not a symbolic ref to the branch like "HEAD".

> Replacing `HEAD` with branch name (`"$(git -C './client/repo' branch
> --show-current)"`) works around the problem.

This is working as expected.

"git checkout HEAD" is a no-op so "git rebase <upstream> HEAD" is 
behaving differently to "git checkout HEAD && git rebase <upstream>". We 
could look at changing that but it would be a breaking change for anyone 
relying on the current behavior to detach HEAD before rebasing.

Best Wishes

Phillip
