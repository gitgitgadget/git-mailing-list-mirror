Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856AF5644F
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075682; cv=none; b=d1NGqwau1RVKZZi73VTF2SgLs+JwO+7wPT3cKGjXqV4P/VOhahrmVC0o3lPt8BZ6pDH8Vkjh90vNkepzmH+Ifsm5BYoBnL4X8ZzTs0KCFaCYceCLG/fPoZyb1cSYE1nGKvSa1e+WvYLN1dI268E6JakUb3JMHUjUavbA1HRpxuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075682; c=relaxed/simple;
	bh=BWd/dIu0DABszqQ3bbUgSvNVg/Aa5kHcXBTOiN9UtiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOoy63MJ9erOZzDfxiBV/19k1NBwf9kOJ8F5CT1N06Qx+PDLuhYjD3lRDcYfE6mbHQ4fqUj3/DXaUC/HEUdIOw787CVybLB+9Pi/TYFp67PVYDEs5+TAGyo4VZ0XkD2PoWpBJc7QP5aX4fycyXO1KKHPc1I6Uhb1dCxHidz25ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xVfzmRgv; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xVfzmRgv"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-428405a0205so54541cf.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709075679; x=1709680479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BWd/dIu0DABszqQ3bbUgSvNVg/Aa5kHcXBTOiN9UtiQ=;
        b=xVfzmRgvSmLRgH9f7Glryxk6lYl/YGw9Mx2PFuCn00ew0CReQFAu0vMlP69/oLR4FB
         o3AaypHz6v63+L6yKgWp+yy/lmpjWj2XNbhc7FXX/BqDZ9e4qc17AtxZ5bCV/vQsav4f
         z2hgLPCLXXXMkGeSAMCAOMf3bTE8Yiwf+41z0bEdlFjTTtKnIruDRCDcS7IPut68qtGa
         RsCYluucA3W6GrlXjZF9hu2ZcS93MLeSdq0g6dB3exRbaGX047iA5kvJxKCFBOAhwhFM
         i3GSohSX8hAB0sqO3vS1fSHajmmAHXgdYyitqGvpg2r+SwN2RCWaQW7El8FeNisCAtnP
         2ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709075679; x=1709680479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWd/dIu0DABszqQ3bbUgSvNVg/Aa5kHcXBTOiN9UtiQ=;
        b=k9YGfM2Qtnc3hhST/Ziy/U82AzibAMWVJlXLzamiekTJyR53ff/s2bGvVFfRltEYno
         iG09NN1atBRCFnPN+50408BnMYju8m4afm5iUflKJ1HxEUlgOq6MHs47o/BRwe4XVvoV
         NPC0A90LW3UKddc3Yi0rCF0stDXcJ/A/dsyCm+FpBaNSQ+OLHysD0vXuVdxvYhlrqeY4
         F4IsBAvyc0CJwDk1gJwDW9/Zwb2hByrV2ZElZXEKmVKMxeyORCA1WoRvqtZ/367lBO11
         yT/KbgbZoqGhl47SavTXUZoc1H5A3Pi/QzfbcGcijtcXVaf2FOyCE/PS7GSa5mqO9D/4
         8eFg==
X-Forwarded-Encrypted: i=1; AJvYcCV4E3SJQV27lYsrKGfUDRVWt9SQKRXAdGnYB7rIZg0CN+M2kKh5ooPILydNPsaapzDS4Lfl1GMNuqRCOGJ3ncqKC6v/
X-Gm-Message-State: AOJu0YwThjY8ASSifJHICZG9G5yjhDIrV2ID3/YgCjqJPtObSEU2YW74
	93TtbvlejvQ240NQBozGRj0eKH2dIdBaqzX9d2GZI+fKQ5Lizw1BzG/R5RiZhZK1mAKlVlCYB1T
	CAxyaIjYfvoGuGPX4LGjuqCOM9AhRA+ca+ORV
X-Google-Smtp-Source: AGHT+IEvIEJerUWnp3re3XLRQi2noiqnOLi2DHJgHCDCiDOdEnNsyGShAbjfj12a+VUSsAXU6ZJLMigtTvg0KY+LtuM=
X-Received: by 2002:a05:622a:2296:b0:42e:9dd8:4a64 with SMTP id
 ay22-20020a05622a229600b0042e9dd84a64mr30092qtb.18.1709075679280; Tue, 27 Feb
 2024 15:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1677.git.1709045045235.gitgitgadget@gmail.com>
 <xmqqcyshsqcf.fsf@gitster.g> <xmqq8r35o657.fsf@gitster.g>
In-Reply-To: <xmqq8r35o657.fsf@gitster.g>
From: Calvin Wan <calvinwan@google.com>
Date: Tue, 27 Feb 2024 15:14:27 -0800
Message-ID: <CAFySSZC50Avdq=P0HY7gKZ7Rts47c4oTCr04RFVkWKK9_h86DA@mail.gmail.com>
Subject: Re: [PATCH] cmake: adapt to the Git Standard Library
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott <spectral@google.com>, git@vger.kernel.org, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

> > std-lib folks, can you fold this patch (with authorship credits
> > intact) into your series when it gets rerolled from here on?

Will do. Thanks Johannes for the fix!
