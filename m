Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9978F2F12A1
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045024; cv=none; b=cGp4Qt54sX8MvQfk+ns1sizKyzFCsV+D45Zzjw/MNO1TSeomxG3tRiqm4rYrgxaPNeNFOxgNn4R02+l1jUOqbSmgm8y0Fl8JFOYMfZqR0iz7jubWo5YapeEGFcvhpptzBvFlGTn56ZbFu5sbMzKF9Xxcz5298g4XVtBoUiDFR/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045024; c=relaxed/simple;
	bh=14bxlkKI6hoFplO80FKUKJOvyYxfSs5+tW0ZuCDfvRo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hY/SkvqPtOjRnFApMO6VS8ljfYa7dkfOO5h3/+3QuCoc7qF/bAPiu0XM1o4YZLSxb9IOIaeBQQfB4+6YYfMOKote2N/P+r7cMP2epVfGigrGjipUKYUJKqQfndgXa9LdEDkoVbgZz21Jg3EuvFtLdNIajEB+oVVXGsre5tn0/Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0lOhirv; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0lOhirv"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94de88e52e5so27697241.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772045022; x=1772649822; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14bxlkKI6hoFplO80FKUKJOvyYxfSs5+tW0ZuCDfvRo=;
        b=S0lOhirvuQRC+qly1Kuhtu3BssGn0vwit4kWTe+iQSmgtRKt3z9UNEbyR3C64i8goZ
         B9H8ZfAGNLLClFUZWFmREq/b4/4Jqnw2CffHf9Ys6g/qDI+0Vl/86bp4WdbQtlGIGZSu
         AkEDQurRIsMXorvKxqWoYBfy4PnJSo3FJkDhZ5HCjUPzwtTmsG97xvLjJ46dWVc2Jqc5
         Z3D7htieF7u4RUxtNPEtq0Zg0p+HlTT8HDW0RLNf+jpNbgzZzB8EsurorcytWlY+3kXp
         S7KQTVoM8IQbFDeNBmvoF2L06IpsOk3v26OVDnBBYceZed/hlhwBoZ3sn2deqVfksW4/
         GNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045022; x=1772649822;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14bxlkKI6hoFplO80FKUKJOvyYxfSs5+tW0ZuCDfvRo=;
        b=Le/MsZQYFmaHX1o/Lc+kjKLUHbLfwcCeorvPL6py0YhQBo8l9qIUuwIaqNqCx8AwLs
         1PlnyTqOx7HdgmzWtjdHXQVSYNuXEDi/g2zu94g4XG90BuGQOE74f8XjD/rGqCCChrWC
         OE6FQorLmVywTGCkGhg1BwxGgsC9exjsuaYAWf8ei6HhkGNpfImQKUXk5ZNUgiCYCcCs
         drIejFL9Drvju4AbxBLWi/2kPaMu6W4VP2Dp5PZJGKT9j6n29UtEV+ERiXoCJScXZlzi
         mzhfPADWexTmiQHyDw3K0M+HWL1hbQGPRR55rZCmSF+64/QTUa971rx0tXsFCK3v8Cx5
         RqFg==
X-Gm-Message-State: AOJu0YyI09n+y8QQwJtZhiDO7OCzMgEgjhZCyVYDmUc90i+gR7FKnIw6
	EzrNcAI6BlyJkxLHOPGIPURFsKfrahgWth9Nqzt8Eft+9UHT3WK57QETPjW1Ug==
X-Gm-Gg: ATEYQzzErC0Y/hS8XDxywXSRrz17DBXymAQNbekaDtRmc3I5xiEAjjhT0z1ZMgU/uJj
	YSw/NCbBuJD/1iXqmd+0xUsYLVe2/T+jTN759sB6ZxenaMbID4f0QCye/iKIZSo0wjjqWVklLkO
	VXnoo9wAdDbRGm/8H9OB2LObWS9YnltjiMgzGhJcb8CIA5LScBPXEmfHewg68KC6Ue8CAoD6Uhf
	ejH1q2n7j7X2nKT+U9xXyrhZRaQVCFZyjmh32ZDtyjLnR+pFhdC454HUjjL2WvL5sSgYdPfqKny
	bhqLas9sQasaLarIowpwOeyOsqiMNyPfHe9XUXM0eEt1vIqTLJgbU2YZ+B8fUSGA5xmymqmli6C
	iKkC8Sg/u3bxrEnlcZjh02lDgo9ErTu1mb98sDOy1k5sj3ueQX19DIex3IIOJAnwJB4EB6cUpYD
	nv5o2yaBxI6gIBSfeIIqMgyuI1sAQPhe8MeViB/wcurPmaFrUtfhynnQ==
X-Received: by 2002:a05:6102:c0c:b0:5fd:f2ad:c653 with SMTP id ada2fe7eead31-5feb2f159f8mr8687541137.16.1772045022409;
        Wed, 25 Feb 2026 10:43:42 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5feb6485fd5sm14958001137.11.2026.02.25.10.43.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 10:43:41 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 0/8] repo: refactoring leftover nits
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260225183559.79303-1-lucasseikioshiro@gmail.com>
Date: Wed, 25 Feb 2026 15:43:25 -0300
Cc: sunshine@sunshineco.com,
 ps@pks.im,
 gitster@pobox.com,
 jltobler@gmail.com,
 avila.jn@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <2403C8E1-18A3-47A3-B65A-0303072B5E22@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
 <20260225183559.79303-1-lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3864.400.21)

I forgot to say in the cover letter, but this was built on top
of the current master (7c02d39fc2 (The 6th batch, 2026-02-20)) with
lo/repo-info-keys merge, which is already marked as
"Will merge to 'master'".
