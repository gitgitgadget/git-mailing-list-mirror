Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522663D7D87
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035754; cv=none; b=pfUbai+kQjrkU0TWRv4yxXrl6Qbv31/71clLLNowP0xXmLIWTAJzLhcRsk7bEWfP1B8eZRP+WMb81vz6qGhHb6gpN7kIoJHfUVx7ByaQ14pGfAn58qwjRxS4flxj8JbMIQLFjv+a0kUp0NYr0NO5PhNAXMAodi+YlxqYYyJ7n8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035754; c=relaxed/simple;
	bh=F8OPDMWsL57OXor3INKXEF58+tsvcKwLiYTa5rU/0tw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mn/2YfABODrfSuaRQOxWqKYv9xdfgzMNgcrb+SJldpg798TK1YnM0nBJo7TV+e/QiiJYZMIUm56CuSBXPQgmX/bgbV+btkouU4D8sEKRTaSQPYfd9zN6XWibs4GJ2gFNmWWDgo1VjkwesZaXL+o6A+17LAO5tnuAtS+OFTCx4bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjpcxwPW; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjpcxwPW"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5673891928cso3190089e0c.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 08:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772035751; x=1772640551; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kChkPR3EBq0k17SYLXHORQhbbmjsBpv9YkeyXGAo5c=;
        b=EjpcxwPWw249HXLFjVvn30OhCou2D6mKzhPMbDbajsvtJlt+tlgEcQbSMnpovR4r3g
         2hsspCWYyTZlGHGGUoEsBqVjByNCw6Etiw5OT9YrCzZcPNfg23jk6a37UglRTKChLlkF
         9YBSrANInqR9lgGlDdCTlRSIJ/Oi532UJm/uQ/gXPVCixGrRgwQHQYe3WW+l+mJHRJjL
         H2iI5+aaqMjF4yJlrrurczCcWjgtefZTYTiXx7NkSDD5Rdp4sgpGzznFfkocajWM6nFJ
         0Cygx62776snIWg7TLhTVt4PGUar7l36VdcBLQ63QvGQJRjkMcDkxnjZc4JEGMTOZdYj
         /kuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772035751; x=1772640551;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kChkPR3EBq0k17SYLXHORQhbbmjsBpv9YkeyXGAo5c=;
        b=PWPS6/YLOYqSu3S0Tw1Wi3nLn7jYP5+8cosNhaNh0OqeLyjkmHYCkNSg6oTpXGjrDO
         SRGaG/Kp/AzpGaBe6TPyOJ7pdyVbINg6TqsfVwL9+k1oI2N+Bn4XUsFz6PgkvVBJpC/Y
         heMwN48TSAPMLd34qDx7JwQanJva3XTyl7VhIl0c6tSSWCZgac2GFaocTlWTIAodX+DT
         mYmpQYVSdEjHYx/DGXtVULL0n5VZZx3gQfoLTwhWQiDycU6vl4jxpx509Gf1Amy0e6sn
         8BW10jfskUS7WkQIeM7GXwCqQScV4r1g2V7X85BX67355dL5pv/dfMIONzOD2uFNNUfy
         gEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdtLCdN6GVAuYSMPbohk1LQv0993Of9p8IFqJkiUIEFd3LI912MBye3hRtEenlIgkUgKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCry1ZbrPxTIZK73O/fOZ2wJEoDr/GOYVUYxE7sUFyCJsxRTsA
	bHksepxb4Bjpk2oQOmu202bjFQTadmsqi9KZgJFfyt+TOnoxGl5dNvHg
X-Gm-Gg: ATEYQzwV3BQzYHM+oJVNsCxp923MKaclIoHIucSaHsVeuCYsYQIiKgI/xGsEteU7BRD
	IGfVL1n8QvcksJDwnLNt3uP4cW/sEHo9nPZsT/fwqg34gP4kzZYmQ57lg3+EZDbzMwdOaBc4byB
	rqerQucPrHei26P2RIwh0UK5gTXuAKJ9t8psPjE3SCVQ0aYvbwHhZZWNwO317w1moDXN2JeitJ9
	ubs2hoYSO/0irUw1/t4KNhf3Tj9ksu+htMo4LTGmhYU9Srla60XmaROfeyuhYanxgNQn+h7yYBf
	Kpe+I2wtNsbT6UQlnRDQiFBRM3BnxVz0YlnpfydBfULEtplyPwi8tzDZ7ZgNNGeQs8fzRMt34kA
	clZqMc2aOqhv8KhnhFDWjtIus2+fcPR9a+FlLqqN5ZjMSt1hYbozfpXHKDgkDlGDx/RjMR1gI3x
	8cVooWg1CJfilnZDgr1jJ5GZDtQEGTC+RqCEvUvuUtnc9A5K5lnhilpQ==
X-Received: by 2002:a05:6122:4f98:b0:566:341b:4deb with SMTP id 71dfb90a1353d-56a8ba57ebbmr565429e0c.12.1772035750827;
        Wed, 25 Feb 2026 08:09:10 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-568e58f8d17sm16826240e0c.12.2026.02.25.08.09.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 08:09:10 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [RFC RFC PATCH] builtin/repo.c: change info default behavior to
 show all fields
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260225153132.7387-1-valusoutrik@gmail.com>
Date: Wed, 25 Feb 2026 13:08:50 -0300
Cc: jayatheerthkulkarni2005@gmail.com,
 ayu.chandekar@gmail.com,
 git@vger.kernel.org,
 gitster@pobox.com,
 jltobler@gmail.com,
 karthik.188@gmail.com,
 siddharthasthana31@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E0F6937A-7B0D-4162-9752-4AF5C6A88531@gmail.com>
References: <20260225001439.54954-1-jayatheerthkulkarni2005@gmail.com>
 <20260225153132.7387-1-valusoutrik@gmail.com>
To: SoutrikDas <valusoutrik@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)

Hi!

> Yup, after reading it I did realise how pointless my suggestion was.

I wouldn't say it was pointless, since you identified something that
you thought that could be improved, found the code to be changed and
sent a patch proposing your change.

The default behaviour of git-repo-info with no arguments was not a
complete consensus at the first place, some people thought it needed
to return all the values, and some thought that no value should be
returned.

Although in this case I was on the "winner" side (I'm using quotes
because I don't think this is a competition), many changes that I
did were rejected at first place, and I couldn't see at first what
were the problems with them, which I couldn't see only after the
reviewing process. The reviewing process is very strict, and it
couldn't be different, since Git is used by more than 90% of the
developers [2].

Finally, I must say that most things that I think that should do
falls under three situations:

1. Git already does that, and I didn't know
2. It was already discussed, and people agreed that Git shouldn't
   do it
3. It's not possible to do that

In your case, it falls in the situation 2 and the discussion, being
already discussed [3]. But I understand that it can be frustrating
sometimes, and hope you don't feel discouraged in contributing to
Git.

[1] 20250610152117.14826-1-lucasseikioshiro@gmail.com
[2] =
https://survey.stackoverflow.co/2022/#version-control-version-control-syst=
em-prof
[3] 20250915223618.13093-1-lucasseikioshiro@gmail.com

