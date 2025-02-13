Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105E1FFC55
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444580; cv=none; b=FOWbVmXVxLLSxLOTED0tDiikHy9WUYAjz1VPS2/1GnCi9VHo4PsyNjJ12ja3Gq1AH4Hx2vDrKli+G8xML/zD1qYm+/If5DOw41bg6c4WCtv+AGBVDdz6xnNAABhBjAXF+NEzIhFAPLPlO2bITO4v8dTWUjyH85l+IgKOUEHYcTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444580; c=relaxed/simple;
	bh=qTi0ezZn0Q3aO4hLN0g9a01NetkZ2sCs6wuP9dFzcZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4cVl8Ef57Afr8fbImpplrT2Q9eu7pWQYeOpSKuxNwCefRj7/XOn3ti7t0Wyuv9R6y5lECcPy4GtN01Ksh22nN/81G4Mc2C0EQeerQ1cIoc6ArH81HvOEJpRbvpTNRmoTvVrvfRhF0xaY/1ZRmakvQ7UNB8cSLEBNf9wb1TAKxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkdOqUsz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkdOqUsz"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54504a6955aso537486e87.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 03:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739444575; x=1740049375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qTi0ezZn0Q3aO4hLN0g9a01NetkZ2sCs6wuP9dFzcZA=;
        b=QkdOqUsz4dd579t/5dRo9rIooFrGNKjoZPM4yljQrYGCPNbAJ06AgzeIMVmXNI16i5
         sc3z1jDPbhNjZe2fo3MHjfmis2elq4jk0LnnarxzoEsr05fj9aJbUpEDMsWghqZjFiND
         r2W1V4Pqf3v1PJIJ0ex/KmG+pbMdUa9BAVJFu6Buyo5S6E0GrpVgcLGrbLv4XxXGfYgW
         RTw/ChrkL8Oo8LIB6YL558OrHFR31N3xDSlBrP/sxb3HCJxGHKs12GS9jws0QPBOP2v6
         yCfd+vtH1PG8/CupVuZhz4MrFjQUSYWvPM7Lg7ZusGOFQqlA7eq6IO7cKNyxbEKFV0DO
         mmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739444575; x=1740049375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTi0ezZn0Q3aO4hLN0g9a01NetkZ2sCs6wuP9dFzcZA=;
        b=qM9LxeaKf7Hus9bFuZnGiNaqyDrhyARSzmEDQTr89xHfio4bZI+EJ0XH3466QZkBtS
         xRofxo8y+j+JuP7vfOK6H355KoQbKvc2xKsajg5ZLNq1wF6DIXiYniTAO9t0FZaBT8bq
         QKIJ+HF/SSwruoE+I0xDlCloxflEkp3nxBwrQep/lc7Rk1wDC2MR1s3C8K7b1r1W6v07
         Be+NB4DQ2di2uRCL3ToOm8qubkaJeHlhDjoOMJKk0MhWZk70hmBaoDzApY+hDJ1XuDzb
         fz4nhRSmzv8n2OnZpL4gHxk4PxUqjNkCPmgI9GcIwzIVpGzgpaYEL4xQU/11seYOn3Ys
         DifA==
X-Gm-Message-State: AOJu0YwTXw0p64neFpM6ieNMNdk7D/ryRFiiaVydOqoJRt1cTU6o0AId
	4Adj8I8fNcSJbDLUTyC7ld2+ZDy5bwgGiH1wLzmshZDob2FTGMeq6UXzBmluZz9w4OT563qoxKi
	a7m/FMD6DCXBSUGImV3e/PzKKg1qH97Sv
X-Gm-Gg: ASbGnct590wF6qhkFjXkz5ZByGTRH/QmphtGe13Fj5ivyyMKoRTvpqTwxLfbbitNrgM
	oPuNYqD9+ecpzFoqSwNXHQsZKoIK8D03pCGBtGj/kUb3l0nci4LWM/PFVeYP2uGcqI6XIpRpL60
	k=
X-Google-Smtp-Source: AGHT+IGrSJMBuLdMrMfKZt30P/LLiFeO2N3FCi4XAncbYgtiwnAZCmxgLRImvwTAAqr+NQxGf+Gbao98aOP6PvLjbVY=
X-Received: by 2002:a05:6512:b1d:b0:544:138d:4b7b with SMTP id
 2adb3069b0e04-5451ddf312emr842573e87.52.1739444574492; Thu, 13 Feb 2025
 03:02:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211194334.20710-1-meetsoni3017@gmail.com> <20250213090040.16133-1-meetsoni3017@gmail.com>
In-Reply-To: <20250213090040.16133-1-meetsoni3017@gmail.com>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Thu, 13 Feb 2025 16:32:41 +0530
X-Gm-Features: AWEUYZn2h8kBuokQjyczcbkaQgTbPlTTcreqbjsuT3o6lXQ3xPINRvT60QcanF0
Message-ID: <CAPhwyn2-H4F73j+9gMTV__1+5PLRsirFf+11dgPYVyi==-w7Nw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] merge-recursive: optimize time complexity
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

Hi everyone.

Adding the missing CCs who were unintentionally dropped in my original email.
Please refer to the previous message for the patch details.
Link to the patch:
https://lore.kernel.org/git/20250213090040.16133-1-meetsoni3017@gmail.com/

Thanks,
Meet
