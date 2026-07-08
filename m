Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C731714C
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480555; cv=none; b=bvDHFJykTPYzaz2gIZn5e4LAK9+9QjSPsZWuYsU4SMamjXD/TZUmmdDDw/27KUYRZtqGPmpWkDvldB4Qw5l5NZfLPGWopgy5V/gtl2ki3j5fLDKec5cY/mC+LVnzS2BJaKat3+88/cq7sp7yZt1SPgL+xn6FZ96nuF8EsO1xhp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480555; c=relaxed/simple;
	bh=KS5Mg02XxC7lDskuAQOSI5zYR/fh93vqaTL20naJjXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o9BhgcPIV64i2JyhRolbDM27CAsKPjjAl1afZdOyf54uGwzgSQuBDfKK6R/qdUtoQhRiPRj2lw5w+L/k1qMLTC2l05QuZI9HriOZTJu/kwHFYmPxuSyx6jODN4yLQcjEfUIs4KutSBzGdzq8UD9bbOmRhg+vQGv8BMt+24j8ScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--snatu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lXu8v8RV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--snatu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lXu8v8RV"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88fc985a65so324974a12.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 20:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783480554; x=1784085354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ff1a3agMA+PjHMEHFGUcIuDM3dl9NslCosP433YvBI4=;
        b=lXu8v8RVqX1Cohz4cmoDxdlsH18Q2wBTdGx2gbpRnEd9vWumAnaqpGfx75gUXdKQxt
         +MGFMXx1/WCvJrvG0CixL89BdLzX82l/RHLGEwPtULWAb8df4kLO92vBqz4SFF14P1Oe
         OQ2cegUSrCIOkM+ds2zn6qunkumSQ/dHeYHauzUb6JwalNwyUdPA01L2p1IHMOKMl5yb
         RojJxTSaBJTKslamMhuGjD91fztPh/mr6awwQkXGDgASLGgCJOPYazrNUQY4tNNUSsoV
         /DK4j3Betm0QcgRqxK1koOwNi7I7kssI0sefYeD23P9aRtxkWfSs8kyjOvl1b7GmB+gb
         PXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783480554; x=1784085354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ff1a3agMA+PjHMEHFGUcIuDM3dl9NslCosP433YvBI4=;
        b=Zsvm1xQGJD06gGGWu6KHTNDd26a6vgRBe5ht4i5yNNE4tehWyk7ePE63p2SOo9foIn
         1v+DH8f5FxeuKIvlECK1B3c+RuqypdS3WLIvBDfqJ4eXr/+g3fAt6/lW9eR1JjDmpVjJ
         /tNgOSk1+A8WMg1UWaDfzr5VTSCRR9LipG4CbMm7sohTGYuEDJmQPIcSMM9GMKjMi/My
         TeU+aHlM8orJG17R4nA2wn513u3JtCHnldmBWoG2lM0XJqk6WeFAyFQQ3ibK67RDgRm5
         dni9skr19uPr1uESYr+EGRpAROullZZrcos1fWavEExojFxZAdvbFejMooSQ69MhUJ0E
         bO0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpzZ92HCp2NEtYDGbbYs0WWGVZtj9MXIhaQscl2VmA35tWyENr9vI0wXZJ7Yzoz+caxScQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNyS2ce2ImZbGJ7NpwuBZp+ebpPgipewVqTOhR4BbOqYX3bsB
	yz/kh+fhwYInWhP7j6On48MfQZr8bjk9DgnxdWJiui9H0y8hPw7Dg9UbJo+5swUnIXymwZmbsp6
	Pbg==
X-Received: from dldyq14-n1.prod.google.com ([2002:a05:701b:454e:10b0:138:5e8:1b36])
 (user=snatu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c98b:b0:3c0:9c19:65af
 with SMTP id adf61e73a8af0-3c0bd3a34e2mr475823637.71.1783480553665; Tue, 07
 Jul 2026 20:15:53 -0700 (PDT)
Date: Tue,  7 Jul 2026 20:15:52 -0700
In-Reply-To: <xmqqmrw3aoas.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqqmrw3aoas.fsf@gitster.g>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708031552.157939-1-snatu@google.com>
Subject: Re: [PATCH v7 3/3] contrib: wire up osxkeychain in contrib/Makefile
 on macOS
From: Shardul Natu <snatu@google.com>
To: gitster@pobox.com
Cc: ben.knoble@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com, 
	koji.nakamaru@gree.net, kristofferhaugsbakk@fastmail.com, ps@pks.im, 
	shardul.27591@gmail.com, snatu@google.com
Content-Type: text/plain; charset="UTF-8"

> Is $(uname_S) defined here at this point with only the above two
> includes?  Don't you need to include ../config.mak.uname as well?
> 
> The top-level Makefile does this:
> 
>         include config.mak.uname
>         -include config.mak.autogen
>         -include config.mak
> 
> and so should this one, I think, in exactly the same order.

Ah, yes. I have updated the include sequence in contrib/Makefile to:
  include ../config.mak.uname
  -include ../config.mak.autogen
  -include ../config.mak
