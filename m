Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAFE3B7B71
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499040; cv=pass; b=afRa9p65YZr/1joOCQyQbiwPlzRLdw48FQOZOnNRIHSLbbM8OyZIC0rfFlITbGnnG/FKNx0muF9/eozSzET7KwSTbmfFgF+KT5fow7fIg67ApwBjD315raW6T8hhDUwSa4UvQ6MrCMk0ZIB/nyAsRLRQvPkQN4Qst6IAJ2vVWxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499040; c=relaxed/simple;
	bh=WAvm100krqwKpFBbUo7GRlaji2qTjcxgMhhsx36WCRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsC9N0iwmkYWjhRS6Tr0OsRiHWMusdi+xgdvI2vDMzdTNb3iNoIINzymowQ8MfGq4rDeJHNCYxaV5fzhrJX4CWW7wpEPPgXStogZ5vh5L1YoKuayG1hkNeNaRlwW2W5AHIBcnwetws2mwx4rC6B03H2/BTCN3Wu1dZ9GzX3oha8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R75xp7H8; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R75xp7H8"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-697edb1bf6eso1944241a12.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 11:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782499036; cv=none;
        d=google.com; s=arc-20260327;
        b=lDQ7FRwRG6GXcwaRGc3PKzZDSECs+aU09a5eHVzz41ADRE2XW+LXmCOUXuOo7esqfb
         t8kW6uE+P/VjCaz7rrxffJy/pKeiVMtkP0HTijNzq2BCVCOa9t97w1SONzCud8/q3nQS
         iKXNYOeN3O4DEgK2oBtNDKIZ+JOd7adwwMiUpp5Fp+UQB3hZMOjnru30Laq9q2/39Vb9
         iBqA2CeAmQgy38kE4IgzS0vUNbRSykhWg1oTtrVn18L+h4HsTOd58w+TXuRBjijpxYiF
         mHqEDXdfE3RzvtE8I7+qdlxGSjAnNQqu17BlJ30sMwxAi9nn1Uj2rZS6QbNPf0NpAIGz
         vPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WAvm100krqwKpFBbUo7GRlaji2qTjcxgMhhsx36WCRo=;
        fh=R/giYyrygKD1SNLPSwpUqoIljA/sqsZolrDYHKL/UKo=;
        b=ZCGWLWSKs+u77cRzDgMM7FM9v5IFOi8vVyVxBm7bjrykEKOh4kpgJToZaWFX9i+vST
         9dcsCe11OemeuYIPCI9ajkcPnDY1cAoc2g647zTpigM9sFDbnUTnulIK4Ub77+XQ4uQj
         BcQxlbDMJ186lR+iwjjjoB4ofbvGeIptpCcc6KdmFGeb7lq/sGsXQGnrUZ43LClPF5L8
         sPT0rgok8XDdnSlPPZgTAplk/ttJxpQWMT2kwK0pLIeD76uFjP8EZTR01OsRX4qAzEsT
         DRCTobwK5oZRJg0mBObPmOtDPsg/kzkBa73z/eruzhZirAABQOej6U1d9siMDhZUhvZO
         RbSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782499036; x=1783103836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WAvm100krqwKpFBbUo7GRlaji2qTjcxgMhhsx36WCRo=;
        b=R75xp7H8F1q4s5e4PQOjO/7RtYppiDJCS44cMcmFPzSNhrh67YUjfVsriC/twMmqHJ
         Wo60UpLGEs3o1g6JS7qZVtxKBhO5IpsmilJasWw/uQbmYacMyfIEnpAOUTaEwgNep4tw
         IQDH/uYWyr6qnWeBa5whmNHR6q+fnNBLaOxWCFV3x601FA/drhIqi29kirY99EURVhur
         9zgsKeG9TkUIhtRF54Ih7dd/Hqwx+5SvBmPMdbywbOTRWztF4MHufdAfwylmuviQfQcX
         pIcNVoZH/tRYOazN9bWpGsJ+yVwNHcwAq84AsSkWtLqLSNSRbczb8vQso9/IMwahLowp
         Ukjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782499036; x=1783103836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAvm100krqwKpFBbUo7GRlaji2qTjcxgMhhsx36WCRo=;
        b=glgVQdlbx6b9ygs7LHv+SA9Flmb1E3cQnMMhU6Mk0attieXdzv+5Uf7xc4aH+D39r+
         852BLtswIroiY8TYyqPNMZ0DzlLoHgi/uAYzb6CntxboDvMzQoOyCeaspTiac8EoaCKV
         44IDU5kZkuQN6L431+OMtT/q42mBb99/MrlbK9M87bGzH9f085lE/AgxZr8uw9HJGmY8
         JFEdRxTQl+1YGPwOfIHZ7ckVVl/FtoMwc0etmn/mDtEJqogRYzsoLfrZi0NoTGNhr/6d
         krv62HfqpbadgfFqdRIM0CtJY6sfocK/iKXObsNEM0y2chNt4m0dfQ3JXgsm2OwL6jXU
         ctxA==
X-Forwarded-Encrypted: i=1; AHgh+RodvpTM7g5hlChQU2W0C4z7VBy+qkjj3di8u6EOS2ocaRL7m4vDsmKJusUfdVShpfQGQ14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+YB7bt5F+Zde2UlljT46xlv6yYisH+uVceiKO56vrVaIKlgt
	//JJ6GM2mrmFHsKuMQqJZkRK47rftY6Cv33Y2Zig7XAZvwDCqivg6S/mQxKpxhUbmd4Czd8Em+b
	vYMozZh2ILdGzQYdptjFH0fEAg6+ciyg=
X-Gm-Gg: AfdE7ckbHOLj24IOKXI5yxGxFkWc/sRuKlRVJ33Ikehe3mhpaf2jN3xKdjbHrtsiIRO
	Roig9/WIJNhyfvPX50WUXrpMiWvEOwnmdeDSLhAwtQdhsQLcnqTKq6jZPkgKZKYCjLDdKBtB5Mu
	GQOg9kxFznKmU8U3VtqUlCVM26bsgnuP3+n2EYKKYsMv6koWNRDaUbTSwR2aXzuOqnWskLgCFSP
	e4qZNNQEnjtp0LEzXgeGpqZSXrRHIdKTzasoIerdC2csmP3ShVAvLQi2GsGz8P/0BTk06jU
X-Received: by 2002:a05:6402:1ed2:b0:697:e8b7:3c7c with SMTP id
 4fb4d7f45d1cf-69810afc131mr2536281a12.19.1782499035454; Fri, 26 Jun 2026
 11:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com> <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
 <CAHwyqnWXaG1HGunztVgUdWnVogqCHRbxh8pcS5fGA6f3mB-nEA@mail.gmail.com>
 <4654a3f1-bf79-4c3f-b121-16bb3ab25f07@gmail.com> <xmqqh5mpcsc0.fsf@gitster.g>
In-Reply-To: <xmqqh5mpcsc0.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 26 Jun 2026 20:36:38 +0200
X-Gm-Features: AVVi8Cen4VfuaTA_2zh40sFLzdNAOwd476NmzroK-R6tqCgoNdBf3r7dAQZEPDw
Message-ID: <CAHwyqnWvCvtenp5_nOGc0Kf-_kOfLm5M4HzB5x2i-R9QQ4E9AA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

Interesting, I will take a look at handling multiple args.


Harald
