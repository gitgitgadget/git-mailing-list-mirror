Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC43A25A655
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443075; cv=none; b=mNOaSwGOUHW15GEteV8bYlDzgZfzkggXYKljcu6nVCjFQgzUfZOZczvzdSC4Enp9exGz42hRCf4OJZPuEyfoYgd3q/U0NTKhiWYtNITO5j9r5kHggn9HoZc+q1myldGavcMV+nrvNNrdxk72f47AHv0087iBNmFyfWlggGolI2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443075; c=relaxed/simple;
	bh=TFeKJKUD4ruv+u7Fw13kYJ60nmL+y/TuHMy7iVY7rOE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qz4LKs4KuY2mlfZ42Hqw3gU+UuAYZFmGBCS9HHUZmcB1Tpql2jKPs7VA/PSaPZCtoYGUIIPDRvsTOeewue2m1KR4ljy/vw1bczPXHiV0DvkzPMrHXDd9TFUgFFjys4u1bkjf9fTvMZ6/Q9ez64Ye2ey7t3S48bITs4Sb8R3Z/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--snatu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ssIAuI9i; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--snatu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ssIAuI9i"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso126518a91.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783443074; x=1784047874; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFeKJKUD4ruv+u7Fw13kYJ60nmL+y/TuHMy7iVY7rOE=;
        b=ssIAuI9iHFdvWQg/puxZ37uZhB74VSgA9QmiJjNpKWIIW4/Rr2LEmPG6mhaxktzwjE
         i/AL1syd0CfzzKzCM3r8YF0kAyvkTtmqqkS3SGtyBLFr326wf7oKp7uvQI96FS/xjNAb
         o9ETXYTezENsN5KS2UNjuQDd1K/1szOZze318LOABNGxPJwbCF7/ghMXY1gRw6g4FS6Y
         FvJdYoM0MTw6W3F2vBy4p9NOhJstfNAFdJ6sI91t5aRaLb/55wDP7oWrnbugxUAJwW/e
         V+RVHIds9dL2S98NsPNnFUbtX1YYHDExwsS+qZaIrjbYaKxJgUGvhQBEA+baY1ZucdZS
         7K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443074; x=1784047874;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFeKJKUD4ruv+u7Fw13kYJ60nmL+y/TuHMy7iVY7rOE=;
        b=elwzUOpHAP2i3jZmhUZMs1ufjc9HBssTkpdaDMS44EIXXs8uT/Hf5ROemkU8PF3NWf
         /sgzPjjbc/apZ61qC/DAfhDnRKSTRVhegeBm6K9owb7VqZ1hYQkZhhh460/hyCUp+BET
         2A2Dj94wuYvcc+SLy2RBue07RfQyX58Bc9Nx58XItVnvYTpN8WFqTspoYZPLjEdfroyV
         qUXFYz2ptN3IE2dh4NXiAQ+xIE53IRUi1W5w4fPEuHSmaI3ea8BUhih6FQW4kYCGiiCi
         w23hWenuLxnZq7pJxHlQxM8FmxGYfODphWsSGHIng2spzTi8YosLJ/tH0mh4Zi4BlBpg
         AsIQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdN623un5qpnzFXXeBEhv/L6SJIuY69sXW78Eb7FwUmHjoH9POCwICiJwBnhgITm/3LJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywm5WNbZCAqd4VKKnuO+ws1lob2q3vXmb3oa/7CL9KIDpTIweA
	WQ08eNXexGJe7HIBlwVaBvxa4Fo0jVT/x5oVMgVqK7O20VAIKGkNxmLfMlBQaJQfjbYYfGTDUym
	Xcg==
X-Received: from dybhr12.prod.google.com ([2002:a05:7300:e2cc:b0:311:50ef:5b3a])
 (user=snatu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fd0:b0:37f:bfd6:8b40
 with SMTP id 98e67ed59e1d1-38755573934mr5444848a91.5.1783443073780; Tue, 07
 Jul 2026 09:51:13 -0700 (PDT)
Date: Tue,  7 Jul 2026 09:51:12 -0700
In-Reply-To: <xmqqmrw3aoas.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqqmrw3aoas.fsf@gitster.g>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707165112.1750921-1-snatu@google.com>
Subject: Re: [PATCH v5 1/2] Makefile: add $(GITLIBS) prerequisite to osxkeychain
From: Shnatu <snatu@google.com>
To: gitster@pobox.com
Cc: ben.knoble@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com, 
	koji.nakamaru@gree.net, kristofferhaugsbakk@fastmail.com, ps@pks.im, 
	shardul.27591@gmail.com, snatu@google.com
Content-Type: text/plain; charset="UTF-8"

> Sorry if I am mistaken, but as far as I can see, $(GITLIBS) includes
> common-main.o (and it being .o, not .a, it is always included in the
> result), and git-credential-osxkeychain.c comes with its own main()
> function.
>
> Using a list of things to link that contains common-main.o does not
> sound like a right thing to do; in other words, linking too many is
> just as bad as linking too little.

You are completely right, and I missed that altogether!!

In v6, I have reverted Patch 1 back to depending explicitly on
$(LIB_FILE) $(RUST_LIB) rather than $(GITLIBS) so that common-main.o is
excluded from the link step.

To ensure that linking errors in osxkeychain are caught automatically in
future CI runs, I have also added a third patch to the series:
"contrib: wire up osxkeychain in contrib/Makefile on macOS". This adds a
"test" target to contrib/credential/osxkeychain/Makefile and wires it
into contrib/Makefile under "all", "test", and "clean" whenever running
on macOS (Darwin). Now, when CI runs "make test" with TEST_CONTRIB_TOO=yes
on macOS runners, osxkeychain will always be compiled and linked.
