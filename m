Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349451420D8
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601794; cv=none; b=nhsAFB4Z2Z0NOKwjjNT7jPpIilBrznFDZcKxk51ROdVUGV5sado6uBtXaoNKlOMvfBf0foFsodsxXrWJlfRACiM1gGZj4Re+Nzw1F6ebikWPm30aECbo1mjdEIZFGZo2TdoAOy7L8c0kJct/rp8fN6YmjUS5zQ+Zpt8d5Xjztso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601794; c=relaxed/simple;
	bh=we8Q+JqahWRGjbK7I8ljnoAYLLfEtT+3wiHrSLPXLH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Z684y+49ewBy6TzgJwsRzgNwvdaR0aE8SkRDMysUMezCNuJ8bKNHum+odppKtyZKW8YzUxR1sCc55TaoR0rK4TcdXuRFgzGZJIujqdYfiwdC9XkjcDZ8HkiSGZUJ0uUWgE3C5XEjOdfkehG9QCu0pSuoccBgHPnL3CMhileeVWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dGBGMgHp; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGBGMgHp"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516c3e0e8d7so458e87.0
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712601790; x=1713206590; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=we8Q+JqahWRGjbK7I8ljnoAYLLfEtT+3wiHrSLPXLH8=;
        b=dGBGMgHpWMJ7NovFOSyBgwILMMDVXe5SvNBWnPJ1zVYWZhkLTXJPfMkM/bI9Q9V0ao
         G2cA9ePTahSYKdMFcOZwDCLfSbDA86MIldM5VyCBSsKK/ahbau7slc1UPqdXxXcoMTci
         imeX+cNaNPFHI7d9diwqKTtvBLtx0H2ykqsJvhT9pfqHQDJB8cAW7EnRlt2Q0PkdAMA6
         52NUZ5YF0RzhUV89dSmm5L6iR/D8JwmeRxUkdEu8fOOM3HV8OBTH+xiFXCZD4ULZwgdA
         4e45hNodbkcv7lGmrMYmmUdFnSY/92EMUHRY59ilVetSh7NfhFe7KbxK8lzEVM3wucqS
         JnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712601790; x=1713206590;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=we8Q+JqahWRGjbK7I8ljnoAYLLfEtT+3wiHrSLPXLH8=;
        b=iSgra0wX/WYBFnNjThSazt7hz1B7TTROD0HfoacsN/8tPlGO2UITsyCZCRqMpMRUx7
         MyEWEGUYPxIwVcLSpKKeL1xer2DjsB/v2R8FbEZTOJWwC1o96WlFUtNwtBn1FQjoFoyk
         fn+VQVtPW9r/9Laxaa2UnYL0TQD/vf2yucrfmmy+IlPGPtvd4GQdLyqpCcCCtdNArk86
         O3uUXusVgDNY+L1IJTJwN3Kf3b0i8y/jp7j229xAI/NECe+WKdpNNVCkPaa4dN82e8q9
         lpvNRLEo5BABxhUYco68Y8MwvYNfrm/mnChiONDHT6O4Tj8DxHQLMsn3OlxY6gUsPUSx
         +Omg==
X-Forwarded-Encrypted: i=1; AJvYcCWm1OgzryYRrV5/ZeWyfNlsh8xgh1apxC7jPLHiSYrJ964mb1ng+KTHmk+ptxpTXktq6TTAgINR4mlbd58MJbhQQ7kP
X-Gm-Message-State: AOJu0YzHBx5ju/HKX9w2/0NkbsYV8IMPL7ouc6Oloit82buE/iM99jiB
	TzR9WoZioVNQfQBc/uqSNLYImVKdoxyYCtc3pt3HXhd9tZHGhaXSahv0tmGQuswWNwdFMr0kc6S
	ozqA7+9/nCdA9KYQenwiqElcgSBFWuXyB5BLA
X-Google-Smtp-Source: AGHT+IHv/lFwaO0pgGxDuYiXbp+7qVYahZgzaE3Lfum4zglytApeBrRiXCKEaJoDAbE+6PDDs27g1/9/xye/rAAeq48=
X-Received: by 2002:a05:6512:158b:b0:513:cfba:744b with SMTP id
 bp11-20020a056512158b00b00513cfba744bmr9048lfb.4.1712601790121; Mon, 08 Apr
 2024 11:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240402222619.2212650-1-calvinwan@google.com> <Zg38BLxLe193zYss@tapette.crustytoothpaste.net>
In-Reply-To: <Zg38BLxLe193zYss@tapette.crustytoothpaste.net>
From: Jackson Toeniskoetter <jackdt@google.com>
Date: Mon, 8 Apr 2024 11:42:56 -0700
Message-ID: <CAD0vCJ=4-QoqUovaOuw6gPTfPEa+d6uJBaO_Vq9R9Btn_YXzwg@mail.gmail.com>
Subject: Re: [PATCH 00/13] Support for arbitrary schemes in credentials
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Calvin Wan <calvinwan@google.com>, 
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Matthew John Cheetham <mjcheetham@outlook.com>, M Hickford <mirth.hickford@gmail.com>, 
	Jackson Toeniskoetter <jackdt@google.com>
Content-Type: text/plain; charset="UTF-8"

Just to clarify, we at Google do not use extraheader to pass along
credentials. Instead we use the .gitcookies file[1], which iiuc gets
read by the git process directly. I'm not a security expert but I
imagine the risk surface of extraheader and .gitcookies is similar.

Reading your post on
https://lore.kernel.org/git/20240324011301.1553072-1-sandals@crustytoothpaste.net/,
it's unclear to me why the credential helper protocol needs to be
updated. If the goal is to support Bearer tokens, can that not just be
implemented using extraheader? It seems like the goal of getting
credentials out of the config file can be accomplished without
updating the credential helper protocol. So is the bigger goal to
support more robust and modern auth schemes which require multiple
steps? That would be useful to Google; multi-step auth would probably
be a more elegant way for us to stop using .gitcookies than other
solutions we were considering.

[1] This is actually only for external contributors. Google employees
have a more robust authentication mechanism. Concerns have been raised
internally about our usage of gitcookies, but it hasn't been made a
priority to address because a leaked credential would not allow an
attacker to commit bad code, only read it or initiate a code review.
