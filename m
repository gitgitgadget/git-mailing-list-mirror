Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D1A2D6E67
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 00:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104251; cv=pass; b=t/cYi2bfvr+DB2mJeUqAe1KFZlW3DLXlhPu0m+EU9DANzU3nTmKfrtayZ+GL+JfbfPC6T7XeqNC7b2rd77EaQ7UYWVfvUr/qOhJNyXXVoawNFtRzBbZeii2UQ/ofdxEYzsUp+6911lUL1kIBxBxOS9GQzv34gCRn4iqY+3aI4Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104251; c=relaxed/simple;
	bh=2QSC9PZz8h3UqEV/6qYYfWzghZIvWFr2ojTt1OOoKNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxQ9eRc+gHq9o7vgHe3SefDwEwC0ReGZo5bghD0U5wEAzYpFIdY8oO6ZAk9Cv22Q7UJgO6wvW+TjHNL85TJhKJXdb+40LbRfpJ+XAjuhJXorlbkr9EADcuJNyAAX+0GyxhsrnV0ERtWvCVcZThXzzQmOQYon9BnQ0g+Jxuht5Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-466ec4c6852so1602452b6e.3
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 17:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773104244; cv=none;
        d=google.com; s=arc-20240605;
        b=J36C7DLl7KUE6+qvN+uSTAYaikWi/VIVQi7BBsi6qZ8lKuqH732gZiKVtU7DWIjCq5
         lBKmFToc+Ggaz5TQfXHFAtNnqsoAFv4NmBQ1GPnGE1hr08jWPmSA6W38ZHIPjTi2wNfN
         8Y/BDT5SNwBDuXQTUjlkyfJhgfrasBJ1ws1m7tNCsIWTC5jVBvWXjdvFoj7gzmqtHgWS
         28zwvgO5UfaeEO/OhbpsMnRDph9aZR7q285ljM0Z9UJexxTRmzE/70kTnAxDZ59LXkAA
         pSBmB8vV+zkc80mb8dN/rRNwFOmX6sQUtzN2EAdFk7Q03mo1KEe73y4FS+VSYrxcr9OU
         2agQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=2QSC9PZz8h3UqEV/6qYYfWzghZIvWFr2ojTt1OOoKNI=;
        fh=u3TiFIbMAOjDXr15gEItaB2MLO3ezi8OAP/6LgvlHQg=;
        b=UeSMWnZnsKAkWDbls0Tdc43FbVsUpFQ6S6+Vx4RatP9AMpSHTzXwYIKpG0UQabfnzp
         TliyOE0sX+ruG6Kvt3ziKv0TYfejBKxBywn60+tFAbFUaI9Qct/NgIdmYsnrLWrUepVB
         yfZgiYUwVCXuPa0CX48w3eaumNUXijndeDy5JLETyEdsu3TfcvhDa4VTN5/bi+kcJfcC
         FKFfho57nulMRn5cDkXUyp4J8C2OwMpvSZdeytnme4SBRHAu6JfYOav0YGa3ok+gNn4p
         OPOqVs6pG2xEyjejOjgztCaVCEyK/DjLExfZwIoPPwPsXHmBTjPDz2+nXygEwkfHHTyA
         NmMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773104244; x=1773709044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QSC9PZz8h3UqEV/6qYYfWzghZIvWFr2ojTt1OOoKNI=;
        b=NZKIfhpePLUX1YQhNMuBrcvJ0H1jDmXbOduIe7MpqXeSzHAZmcmgFs08ydaIm8bZfD
         UjA2zWT9Jsu1eyEpOrkQ/PNaD5SHwD1SIdeWoRvWViS0Hsu9EUFRv0K7Z3hvPWDcI+SV
         H3ivfLN3iHMsMUphjriSGSS4ODt2O/RX5CbTY2v7J5KozKhZp/zKpe4j0Qrirp26OtDP
         xnEGZLPC7HabHwdaCcEAz/V2xfiNP/cdc8Txsfl/Yd46WJOxhe9EKdHIDIzKMIr6JqqA
         NmNDYuWZFk4/1HAkMvDg3xlp6Gq6MNh0miEdn/DvkjBgLQ1PpoWjVsIjZcgGpHJzJKvo
         112Q==
X-Gm-Message-State: AOJu0Yx/wYAKJhqbjUgx3SLL5Y35IiYk/f1VdDAW7J9TR6lWOjX5T2De
	QTaOAJxhF0U18mmJeA4BQVd4rY2sksZftazXMHKsC7/Zs6rhW/HNuZdVg0O/iHjxULMoDKkhBbF
	zQSjiAp2M7VaUFrtKtsZyXPOPHZn+vzg=
X-Gm-Gg: ATEYQzxvnHTreqMd8JYpFfcrllaGsdNc79uLeWsocVCgNUrroXv+UvzmEp9h847kKiY
	Ugk9tlUCf9xYQzCyABKsEMmXPKAmeWdOf2zGWb3vTLyWfW6aV6FF6Nhv48dh/uTccYuQ4m9ynZF
	zQe5tPkZ7Whk2sxnn9SfMJMP25C0lBCuYc6hBNEPeolUrNOPJQ5u3oVUaEwIAamPTYTD3PeOVW6
	mTGphyWxC04KqtGvSVFLuFGb5zy5UhDT0YXhjmemSK3V3ow+FDpCEZdYtMtRPIr9evKTJbLfQQD
	louNIZw=
X-Received: by 2002:a05:6808:1903:b0:467:1ad3:7ee with SMTP id
 5614622812f47-4671ad320femr1090510b6e.40.1773104244663; Mon, 09 Mar 2026
 17:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3ad40c3d0762c2e8c14792dfb68cba9f63a883a3.1773026586.git.collin.funk1@gmail.com>
 <xmqqbjgx6obs.fsf@gitster.g> <87a4wgwn18.fsf@gmail.com>
In-Reply-To: <87a4wgwn18.fsf@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 9 Mar 2026 17:57:08 -0700
X-Gm-Features: AaiRm50StSpMoVxAUXUNRl_f00UeEo2iq-CTMo50Q-3nIKYbmc8A6D_3Jn3qAEs
Message-ID: <CAPc5daXDPLYnmtgk3M+B4qOPVU7vWwP3A8jqNe6ex3WaVZMufA@mail.gmail.com>
Subject: Re: [PATCH] dir: avoid -Wdiscarded-qualifiers in remove_path()
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > "it's" -> "its", if I am reading the above correctly?
>
> Yep, my mistake. Assuming you can fix that locally?

Sure, will do.
