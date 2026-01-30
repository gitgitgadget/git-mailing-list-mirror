Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7661A1F09AD
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783098; cv=none; b=LyzCGBvEVR2PPPTP5bIKXj8CseiizFEsuF3cRr4yR8ZME2CPg9RcmRdGnWdqFwJz3xP3n0BD2v/Nh4MBHd02jO/S2I4sxkkBW2Mm2esqggy7VyA2HMw2YqNeb9nDR0on8lyFm1dlRT6cfW3T6Jk7Jfk1FlFw/2JJOsh84qfcvUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783098; c=relaxed/simple;
	bh=yJKNWPBJ+uDffT+BQEW/F7HTqtTfuEONyVqMIFHOxlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYt7xGYKe3ia2r93X2ZbG4cwmmqCjJFuAxYOxecQsKyOdeiUjWyHIV05QkNGFIZg9moh+VD/wjnrg+wvrQnkiwljSC12ZXDc7MlSAuB1ob2iCNnROmM/badAaPDdZkGdREPRbEVspkYCjGBBBGnpxBm50ATOX2qyRh4p3WFquxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPxheA7i; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPxheA7i"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a12ed4d205so12886215ad.0
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 06:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769783097; x=1770387897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5p2mu7fSAmvLvBkdlSvBHXnql7inpq9d4NvTh6wLvKM=;
        b=YPxheA7i8AaN4wJ1JU0eACiZSiVDB7cAb01TQy8GXYs39NsgRzDWwvj2ewXp3FXJj+
         envWxjXDU4QPe1Pz/zuVKFVr5234Ktw55Hd0UBNhPbn1o3WYVown5/s2drrhNmgNoJ9p
         ifJSYa8Dxix3i8w3w87XRQH3L1VuAyxLWcJNTKdLuhDnX6gHJppNtI5ARL1r4G4ugtmq
         xdv77FJy3oMKl+7K4Qo/6yPc3gxGFPYg3aUUGiutUdP33R3t8hL2oOHyI1bnXj0P7gGA
         WwN5zZLb4hD6m5BnFF4uJQuRilqhg+eyTpVjRszd8h9OLW7SQAIlhKNzVdnJEZ/ggAdB
         mT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769783097; x=1770387897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5p2mu7fSAmvLvBkdlSvBHXnql7inpq9d4NvTh6wLvKM=;
        b=Us9DcmOWqW1Lw6TuxLXQ1w68C4MJg4zqzlZaYiTjUr/gw37JHCznwNFNYGElYun+dd
         D76mUcg8LAAm+890/YnUdSNJH+w7YQ7uZ75PZtJhW1hHw4yQIzWpERnrOtQtSfZMBuEb
         ds/zNWVtffJRdANK60Tudz6cTeU4oWjiRJDrFfSc52zTr7KojdbeYLuab5uBtaK6hKKt
         pLIxnAmVAdQ2eadsq/BAzZlFUsfzlm8dsMb8H4+xz5TcXhgxpE5+ss5Dwh6HeUKe/noN
         4KOshNaN1ZWIys+pqwY9NSEAYej3AZsiY0Bch7uYGG7/K/yZGlWXHmeOxj+zd2xP1pKZ
         obNA==
X-Gm-Message-State: AOJu0Yz6L3wyuNqBE+ASCHbFpqeUtF6nNUNaskiAlx/W67gpAFNumPD/
	uGa9kfOa/roq9b6FcXDGDyCiiFXAHeJWUiVMgHBXuIm0cz/19yeM1tJ9
X-Gm-Gg: AZuq6aKxSWoVFC4phhSrX7amIE4FHypj0ZQ80QZvJsDlXUohssdRaFdrUVwUJz5jFk/
	/CJ7Ee9Sb/5qcU42XiEynKasl0rkorgAHbQV5d/yazs/yodU87lq8cffxJz/JDxnAw0raA4Qhn9
	L8CZ0L70iC8n944wlkAzXPG2bYXd610ANbYYyAGCPSxpmw/fEFJmSyEE63vBEhZ7mhV/q3WKwqP
	Sscu+6xJDyMrNVbgRdj/AK3Ek6mJrtOOykOlnwdd0ON/AF5SScM9DvDzkBC4ZwnKJuxcXKbwehJ
	IBaLGNsBgri4AyOfjpy5FHL0/dUqpCwgM7Ah5J+cPDjCQkuQhshdpVlnfd6wgukeA1QJb9Ws5qN
	AWE0k3L01tv+UunSuIbX2XHwZnJhpcpFvDzJHi/E74zmLBgCrau+hCaD1GX/RpUHjkwwfysZdAr
	ee4DVkc0vXIwtiQeL/GgEe+eDyeYO/jPJW
X-Received: by 2002:a17:903:3c27:b0:2a0:acca:f3f0 with SMTP id d9443c01a7336-2a8d99396ddmr35217355ad.49.1769783096701;
        Fri, 30 Jan 2026 06:24:56 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d9a1esm81232895ad.75.2026.01.30.06.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 06:24:56 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #10)
Date: Fri, 30 Jan 2026 14:24:51 +0000
Message-ID: <20260130142451.7324-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqwm107za7.fsf@gitster.g>
References: <xmqqwm107za7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jan 15, 2026 at 12:26 PM Junio C Hamano wrote:
> * ps/validate-prefix-in-subtree-split (2026-01-15) 1 commit
>  - subtree: validate --prefix against commit in split
>
>  "git subtree split --prefix=P <commit>" now checks the prefix P
>  against the tree of the (potentially quite different from the
>  current working tree) given commit.
>
>  Expecting a reroll?
>  source: <20260115122652.18673-2-pushkarkumarsingh1970@gmail.com>

Hi Junio,

Thanks for the update.

From my side, the series is complete as posted. I am happy to reroll if any changes are requested, otherwise I will leave it as is.

Thanks,
Pushkar
