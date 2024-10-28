Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F0B1D1E64
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156659; cv=none; b=Ajp/Tentvz8cP4Znct/tb3Rhk/jWig2O3xBoemv5b3P37Ex/VZ+DmFJj9NqGPRIgb2i+w+knh1MOMsTLSpruTpKiY6ngnfUM84VU5tEUiUKhiaFfNIjehDUaXZbkrigcp77hrhWevVGPZ9qvGEerTZf6a07en/urSTENb0QFIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156659; c=relaxed/simple;
	bh=kMhhyjWOfmEQdqnRvew296dlQkVw/TOQRcOa+Xvwyr8=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Yh4Mi49t/wp8Sdu8HbToy311VyKUvm6LRUfhZiseFV5FRsY+crjeC3Ypw3nks5uXRR5Ne+nf4LY5xQoGECQp3uwa0LYhi2UL64klicMXutiwO8P7fBE+LXxMF/CykyKj+fd6iZkMG70qGeBEvXkI1ZEn5Z5haS8YKYo70YKkbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quxlt9a9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quxlt9a9"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e370139342so88880957b3.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730156653; x=1730761453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t6xJm4x/XwU1aESbnzfBY6o0t6CqRchsqszYWxvPelc=;
        b=quxlt9a9vP/UxP2LSkAQBc+xnWIYsuF1P2rVloOe8gMn9fdIdR/FxJuqRfBVHS7LDE
         lUOVgirzjnqAe3MhdVYdmWrf+YoOrWrXbQJmkNDvmn3pCi7R9qyWbSPmyb1SpbKpAepv
         500if28G90Rdni9jbYmoJ5Km1snO/a335d1RWlT+Hkvdtbv1QQcs2EB4zwxMoVNAsXHi
         Jd++DVS5FS6YH5PABlrf+4nwiOJYjiq4F0ufVzFiMYdFTdrMVaD55sa0WaVFG0HMdk19
         QKW3QxuWmQiCptcOICMkL5qlhhMpNHs1TeicPiRJNT6+jxfOHN2nB3IBm8AS9US1T8Aa
         K3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730156653; x=1730761453;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6xJm4x/XwU1aESbnzfBY6o0t6CqRchsqszYWxvPelc=;
        b=nPaZOF/eu7XvJM1UUSZCM7qwVJ40ltr4Xfp/w+Ji+gUTJBOl9V9cqBSB8VbFjQyyOp
         yvXI6u9YxdAORW5o46Fn0b3t5cxXL5JuiaUC2OFb9GuNfQpBCDO1g+NWppcQM8aNJZMa
         WmLn0qcdoCw0muh14KgqBXV2iOHcMqKbI4vMLEXMYQF9u2PZLC6hGuc5l78SeqxWAA8R
         mSqrIvUVm96VyoKo++uvHy5QLfMF7Kg5NekEx9SfNqeraEc2REINrfnh372ZrKPqCPP4
         lEacq5M1+gbVEjGu0y/mSBxO12X3NSA2pVyHwF65i/0SW29sGoPcu4zgAEvKgFkc7s1Y
         hGFA==
X-Forwarded-Encrypted: i=1; AJvYcCXXlPnJr2vWr7WfVkW6198nJh4LjAaShEC6nn48wv/R5w2P4Pe/G2nYEm/gEWIp6zCQZBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxASGZtPDDY3oplgsk8LZtpOntTpK1bKE+aTX+03F8xQy9jGg28
	Rm8Yfh6yCfcMlZNl2Lg0On62SMOYV56qoWtS/15PmQEHpk+WsrLQZhyoMoEipC/n/qGH64hAGbs
	9AsdlNXLvQwfzAnGDSDOP7DaWLcPr8w==
X-Google-Smtp-Source: AGHT+IGRkI1mogQBgZFE6+Op3hjh2twf6vN12IF4fYVgzcw6Bd02RyBXO4zWx3Ar+MFN1Lv2yQObtnxk6CyTOQ+U79q7
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:ba9c:8d0f:d4f8:e6ca])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:88a:0:b0:e1f:eaf1:2254 with SMTP
 id 3f1490d57ef6-e3087bfba87mr30529276.8.1730156652696; Mon, 28 Oct 2024
 16:04:12 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:04:10 -0700
In-Reply-To: <Zx/q/HztQRT4eLMQ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241028230410.4154271-1-jonathantanmy@google.com>
Subject: Re: [PATCH 1/5] pack-objects: make variable non-static
From: Jonathan Tan <jonathantanmy@google.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, calvinwan@google.com, 
	hanyang.tony@bytedance.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:
> Great, thanks on both.
> 
> Thanks,
> Taylor

Thanks also for your work in coordinating the patches from various
authors.

> P.S.: it's good to see you back on the list again :-).

Thank you :)
