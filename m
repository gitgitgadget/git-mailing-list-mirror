Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856873208
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189553; cv=none; b=jMEDsM9YKRzAIgWYLkYRw/znTmb6WW1FVThh53xB8f+LS7ubKsDGuLH/hJSbgR/4epc7d43yc720eXrWNmqSIBG2y6Dz+sspC8NZM/DLv7Ut5A4mtB/u9aCodNim598mK3iJQoc7p+oCZoOC6kqCf4lt/Y9jNL2bo+xRDf/Vlaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189553; c=relaxed/simple;
	bh=HTgWe9w+/2+cyCiqL7g4hdHHh/IoDfrTdby/H0SWuYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJHHdD/0pEHJ2AWvAG9uM9dM5PXcIxh07QCyxDWylA8qI1WRFeX0y/zeKnLlG2OnTYDVuSCzTRYsAgSScEibVtJRFEvtzM0m8h38a4N6kc/XWtbXp8FqRv1T5UXZ8Hisiel5kZf5VuNY4p23pKiMk64NjrgGHpJv9ooLwB32vU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJUPNw6w; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJUPNw6w"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so1716857f8f.0
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752189550; x=1752794350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HTgWe9w+/2+cyCiqL7g4hdHHh/IoDfrTdby/H0SWuYk=;
        b=KJUPNw6wTHQ7pooJBKxpjaIB/lzRbVtbz/CKAkE9XMflK+4W30M6yNVwnhqFtI6rHn
         f93hAED0nhr4ueSaacGahc82lxJctdHV5EcVm9d0B+Vdqy6r66hey8YKJQl/0zjPTfF5
         aA0eOAx+CM1BeJVReUWcbx9LRKTuqrEB5YaJONczutK25P+jtqeSyJK6rpA4Hw1diWGs
         LAvrMdmOUENfHeWHg0FjF35K42buFZDrO9yfz6ummOA8u8YfreWmgHrLqWjP+UQJNCig
         +3otn/ZxB8sxBkaF3cYRlqBB6n3gRnUAO9awMutVy5ZPZ4KRRbGPLvPu9DlB87q4nzuK
         cZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752189550; x=1752794350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTgWe9w+/2+cyCiqL7g4hdHHh/IoDfrTdby/H0SWuYk=;
        b=sVIruMsAGPmf288L1sviUtvQLJrcNFXRzTlboseqCSPx0xuDX+B/lXVVr0vUI48fm8
         cwpG3VFhWjzosiAx0UoM2pnWKboOZ+7m7JMSk10FdRxA5G8D/xkGOP9kdpH87SGzdqle
         xtpN28Hs57q3S6y+zQNPhoB/8iXUDiDw5u8uJJ95SlwvREiq5LUVP6zWJjLyF0OVzKvr
         /Xo5hdc71vRLhgBz7Lx43WND9dqQNyHPD01uKKMgtn/LjXt9JW7Wr2P8DJkYWhONDOBJ
         01y2t1g2Hvp++dnIT8N+JfaBNtIbIa3kbsxvznOMEQF14t9OWIkuyKYJGAtKBSBPIGCd
         56rA==
X-Forwarded-Encrypted: i=1; AJvYcCXy+jXNzsbCHG5x5BsPax/F6O1khU08s2EyU69DI1rwowFl8xxhx5VCEqGvpPmNaqtKiBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+cOARtg6px+Oumyy5e26uRDanOtn9KyMTqsWkK0MrbmEOfxa
	adc1eLdYDhw0+kwGxQ0/+noJJ9I1K5NnVIrHbtfI6gbUpCg7rzrBTx/r6+VFqv17k2PK3dYtNfD
	GKGFTy6aMmim8YLcT5bAG08xbcp+XYsc=
X-Gm-Gg: ASbGnct1O8s1G2YGWWKFLQ4ecHezW3rYoNIKVeun7EPxeZUnIYHKVoT2KKR9Favm+6Z
	m9hHGa2/BkR47X9eZ1S6sCWWH+hhaYhXZWyeZlxVFC5TbHjCNxsD6hhXxfBihUaUagcxdkXx+g0
	08gTi5Wc/Y50puhgrH9unysjiyDGYQ6nPrT+oFSN2ETV79MXBMPjf6Z8wMQ9zdGH36hObsAw5IU
	RZV48tTq2gWBaTiz+T1VjrAv0XvXnlwYP1AekgR
X-Google-Smtp-Source: AGHT+IEOop48IbyuH7vQ7XUYLZOtPv8wvzR0i+xNB5PYkIt81UFLMVpop4x2rnwjYrOBZ8w4wQtS/s3lSVq9ejhgrK0=
X-Received: by 2002:a05:6000:2f82:b0:3b5:e275:75a2 with SMTP id
 ffacd0b85a97d-3b5f1c67c29mr938118f8f.4.1752189549565; Thu, 10 Jul 2025
 16:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <pull.2002.v4.git.git.1752176743.gitgitgadget@gmail.com> <xmqqfrf368lz.fsf@gitster.g>
In-Reply-To: <xmqqfrf368lz.fsf@gitster.g>
From: Carlo Arenas <carenas@gmail.com>
Date: Thu, 10 Jul 2025 16:18:58 -0700
X-Gm-Features: Ac12FXwJMTSCxqVEgLH3K_SfPpmNBr2NIq1Uc0ly9MQKGi78VOoKgV9iAW4D2Gs
Message-ID: <CAPUEsphPrP+EGgwX2od-ymcqrkehePX0kNavJRv08ahfesnb+w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] daemon: explicitly allow EINTR during poll()
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?= <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Thanks for the typo fixes

Carlo
