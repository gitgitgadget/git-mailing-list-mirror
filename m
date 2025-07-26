Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D421CA10
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753565283; cv=none; b=kULFV6TrifpYmrd/0yFBXGLI6ZjKdPzKEJNj778iHp1AchvNwC7ftCvqtrAe6R+wkRmpv4DPcqKYxxstKvY/ENKfug1yvWA6fPyngyoJj0JBB71Q4OeWYVL3nsb2SA23eGZw5oG+zkuAVLybKGLu1PR2V+lz3Msdb/DRRNaRUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753565283; c=relaxed/simple;
	bh=M2U4dbADczyopMlTbK/oTkHC8u2UmarcZUwcEw8qPcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPCYSPiQ3iu8qrgUn9FYGVx/AyQXNKJVNBEUC+mdhnlJfvluB2pTm2fnIoV+Rs+8n6F2XnQrvelZezMuUyCmnQqQLH7my9pMtwYteLKdGm3nrWSAApThzu0uztEo3EdFumCfxHQyBXhOMuyVhifgh4F/Srq5zr+p1k1qDFoaNPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWEQvU8E; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWEQvU8E"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e9a1090360so840808137.2
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 14:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753565281; x=1754170081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YBJIxxmO/DZfqmy+GChC7OuI6wBwmP2oq2Nchc7m1K0=;
        b=NWEQvU8EX+poI1pIVyzYIdFo4fSPc8tCzGb/GsCz5Wnu5dD3Ag5ZcbIi+xoId+QXoi
         gLwpO0qcjn8CkI+MrxwTrZi4SAmDUjsRe6/RERToVNaCefyU030hYxsjuj2fnY1N/rrp
         ag5dGqJxKCDG/zj0TP0ojOLO6MEfCOSnsKyyaBOJzbdQTeMjVT+bFpOev+jz02+KQQwC
         G7FqzY2r7fkHHqro/K+rQThh0FfKSK2PWblZOS9qONenfitPMOP+HGzclPL/cUH1oSZQ
         qNBGMuOxnqBc5NLGqPjPA1dW34N1n/oJji3fMLkl6SgqU/dnaxjzHLtwSJ8640TIXETl
         yk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753565281; x=1754170081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBJIxxmO/DZfqmy+GChC7OuI6wBwmP2oq2Nchc7m1K0=;
        b=bOCTg2sRvkJ2ddPat3wsgEzAVQ0A3JwzMoWv0hqg3Ij0y7onUwATM/ULcaOZRciySM
         DbrwRwZMzkv4QXAEcRww2rQHqlhcD0td3q4hdpNiqUHtF/a+/8LG/pNoaZjoH0PJU+iy
         nBwhmWackuQkJl7sR5HJtUGP2siDU/dBdEglrmXFTJtEBuvfvuvmHh2f9txi7+9Ny8a8
         nPM7RTV53koASyMJsgMOw8RL2UenDMd8J95Of7+C/7kkEr2H9aMaYe2OKvCk4s1OwB3W
         rwiyZs5wyOXMNwrHF0d4S6JLYwtFzMbi+orbPqmfFz4adGgo8Hx5PvD+gyS1RT4klvEV
         u88g==
X-Gm-Message-State: AOJu0YxEVag4yHJ4bmGhjwkn2WVwpr0xyV093YCTtQ1vDBVsaxTie2kr
	lD/uNclUmTkragmMIBNlWZdlY29JGasMHZCVUCM2g4+TdfcxyPzoQO47MQh1H67tUA/pp17B1ec
	cjHRMHFpi9meApkXo6FR1gRurb31+75M=
X-Gm-Gg: ASbGncsIDEjopWR/GwcvguqLr7W3jQrrPwewff7uiLBgBIjL6BKGmjbUgQv+JcxOraO
	rNDyxn+B/qY+SwmApoz3475Tilu38F3U46D1WBd3wB32oPP3edC8/sRKQXIUUQj+vQ0oPCpicLq
	3NypBq43RfAyY0KMP08SIcLXTyCS2t/WQTew1LWQ/3jY0ZTNRic1r7VwkwH9xo/NdKmYWKRfLjS
	3wGsMk=
X-Google-Smtp-Source: AGHT+IHKwxMqWMdUxDhaxYnSLalmliluKjgO01InB4Rr676aHiEDGwkRO1bh7Ggl60ihb+o1WadJ52rhgultKVh3N/A=
X-Received: by 2002:a05:6102:4189:b0:4e7:e5b2:f651 with SMTP id
 ada2fe7eead31-4fa3f8c6b7fmr2906657137.0.1753565281056; Sat, 26 Jul 2025
 14:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq34alik2g.fsf@gitster.g> <CAPSxiM9Udi2PxpT7f8DdLn1ihny2gW_H=ieLjV25sEFYSdAjMQ@mail.gmail.com>
 <xmqqldoa26dt.fsf@gitster.g>
In-Reply-To: <xmqqldoa26dt.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 27 Jul 2025 02:57:50 +0530
X-Gm-Features: Ac12FXxNTpBe5_YIz9ee3ae_dJzO25PqKWY_6uS8qRPbvEbojlWmTZsGA7YZmuc
Message-ID: <CAPSxiM-kFKM9s8fbPajGhNDdz8WbbNUnjGw+DiRFtkO3vL2aNg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2025, #07; Thu, 24)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Administrivia.  NEVER QUOTE SO MANY LINES from the original if your
> response has nothing to say about them.  Remove the part you are not
> commenting on and leave only the relevant parts that you are about
> to respond, and then say your thing.
>
Thank you very much for the info.
> >> * ua/t1517-short-help-tests (2025-07-21) 2 commits
> >>  . t5200: move `update-server-info -h` test from t1517
> >>  . t/t1517: automate `git subcmd -h` tests outside a repository
> >>

>
> Also do not leave the original that you are not going to refer to
> after you finish saying what you wanted to say.
Noted and thanks.
>
> >> * kn/for-each-ref-skip (2025-07-23) 6 commits
