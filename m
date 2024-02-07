Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A32127B4C
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707338791; cv=none; b=Rp4DpCRIOsjoOJiPH3Q6dEPquW77CWKxq5R8TjXL+5oI3NfbC+kbjhtIo2MfY2jn04bMOHCijG+LoIXPVtabBs/dr9HQx/Q5SlJbdCdMF1za+5/A/8VzlnjDQlIsH4hrpeZU46QvDWSLmd/r2jnvaZeNdrn+cucI5FMcfa/KpbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707338791; c=relaxed/simple;
	bh=AJ7byAgyiM8b6QKIBInk2oF0G3Xg9zAjWWxIMHGSDxM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZHsrfYyja1ttXr/Q1Rqe8oiiE54C9yw7Wth4sZOxUlinFNIHiT4PN9vxCoGjAKa6wkny0dFoJiXyMAaD/qNb2T9cDsQ9vUXm9ZW4okwu3NJgQ/ecFgTHe8or3B0Qna14pBD8k7fWFYhMzTMFuKIRXnBqILhsIX6QpSl8D+plDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXIixcNU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXIixcNU"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56077dd7936so1342040a12.2
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 12:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707338788; x=1707943588; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AJ7byAgyiM8b6QKIBInk2oF0G3Xg9zAjWWxIMHGSDxM=;
        b=HXIixcNURPxLrIQ8rBeAaQoRzvWXUJvuH7ESD0uOsg4RumahZKtR3TPmoWXVBQsTOi
         irlZSJLQTPA161U46edVSlPc9RaV7KlZkEXjcZsCcpq+Mc9dxqRK9o4A14PVi1rVJTRI
         LDrH89sInm8e15QUiuEDLj6EvMtj9v7cGk+78wLcRIkJdCnPAkvOt899lxHzH6fgM0ag
         GVsdiOHXqtDowlKNllBacIqjnL4ymo18A+qsWLp41M+LA4FSxbkKll/s6CFkOZ9AZlcS
         APL8wWaYPikH0WBa2UDZ+J5YYXQHsndlsS5iNwdcdJif8eDr+sm1YyuRY3B2b+Xujhxg
         CSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707338788; x=1707943588;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJ7byAgyiM8b6QKIBInk2oF0G3Xg9zAjWWxIMHGSDxM=;
        b=Y9dhPx1OEC97mabZuKfc0iWKZBRj/Ny5yensJQIH9sRqnIUB073DUZVJGqRcZpbiVt
         iCPpmvZdlzeFjh2dlceZV/XEAugBXmRziGmbI2cCCJH2ZY/hFgFQWv3DcEG+kHMdXprN
         ak51yS/TP0L24aeYKjWbQA/+mHXMHOMTrgM4kTnDekjxgyotGp2fxiRv+TGicL/UMC9w
         7+9ALeacjn/OQ1SocwskBicNbrqIJRIkLVyhwZLy2syfHoLo49XVaj7OqL34xncg4fxY
         Pt/hmySaAINWHojpVkd5BESPxBoL28uUNe/x3uqR9ubp393QqKElM32SHuWlrJoRxozp
         T/GA==
X-Gm-Message-State: AOJu0Yy/j17dr7t2PaaBPlhq755r7Yxf6891kzENrwOvdKr184ivytsT
	xpXqimXTKY5Uj7I7hQe3ZCgX5awJRvNvicryJNh1ehV8isOlKUWRtk9Jhk7gN02v2trWo69P7Ri
	MJJvE0Epy2ZrW+LU4GlMWYUCD0Cl3LUrb
X-Google-Smtp-Source: AGHT+IFErS95a4+OlsvcShbblw8cyMl3ME8zXWKZAmOW+l5I94agcMV05+xTA0Rh+KMFgOmlZvx0cF6VlFwB9FAn/5o=
X-Received: by 2002:a05:6402:391:b0:560:5748:682b with SMTP id
 o17-20020a056402039100b005605748682bmr5057838edv.14.1707338787653; Wed, 07
 Feb 2024 12:46:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Orgad Shaneh <orgads@gmail.com>
Date: Wed, 7 Feb 2024 22:46:16 +0200
Message-ID: <CAGHpTB+mCxvzJ4LDpQrMgHmzigUzcAnRcwMewV0oYKM2HwbNXw@mail.gmail.com>
Subject: Supporting --no-edit for git rebase --continue
To: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Is it possible to add --no-edit for git rebase --continue, similar to
the functionality of this flag for git cherry-pick --continue and
similar commands?

This should continue the rebase without activating the commit message
editor, and just keep the existing message.

Thanks,
- Orgad
