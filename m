Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0302EF65C
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782976; cv=none; b=N08gqAEWsUGumDGHIsi2xqyUfFbB/M4EBGBIpy7IIjBMvQFgDYU5Benp5dnWQi8uyIgnlENepn6P/IL45z0dUdi9p3I9H3u1QR1reFVnFJOfY1Kj2EBb8+HIGr1mZp4FH8msEa5+vB2AYWYJ+ak4DtD23KVeSxJBYFo1Ud7AM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782976; c=relaxed/simple;
	bh=kUqpbKi4Lt20VsKQUqvl1/NnuaGWoSjzSrQaFDjdRvM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RBLaxm57TJhGTaiDQDb5faGagaSdYayPSmsb6kYcGYNPwmKuxha3fp3w+99q3XYG7ixFzg2fRsOGEaCJ99dMkAroQvQ8SFOAhDnUA7Wg//DkjMg8NPOHkBugJIU6/wE6O/N1OJ95Zrb7NnWyoQ+PEV8dP8z6UVWKU95Lj1LI6io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuCQWMOk; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuCQWMOk"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-323266b2368so651620a91.0
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755782974; x=1756387774; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ocPn6DuzTz/PvT1KcfsQR0vA7SwenLwK83BMZVCv4E=;
        b=fuCQWMOkhBZWscfkB4U4/qs7XON8lTJM81qCFgPfln0uVPf0URc6qWJ9PbhIbMm3Sd
         WnDhY7HX14DPvX/kr/tekqocG/dK0YjiQqyG6k6D1OdES0em+md1Og5JZGnOwBizNKco
         28BnP5+jDr9XcZWlTctmNYrEOGuSj28RvmjNpdzBC/UV5nX83T7nP6/+9cP3HDHNRlvt
         ssOks1ph2CRa0NMQyxhwApKkXvNgYCq6Fr3cqbcuf8jPnrfLV2bQi1lrBpBDaQaUO/Ra
         SQhckoNofBekTrcrvOdMVT+8L8Ja5RLpoVU9+1OerOI6+zwIUkrhBMCjc0oXcqGEcpwa
         t5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782974; x=1756387774;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ocPn6DuzTz/PvT1KcfsQR0vA7SwenLwK83BMZVCv4E=;
        b=Hw4tQbLusV49vyxO5jdz2T90k8KtnW7H3WGYfAajTyhfSlCYzyAbanZ+3NU5XdBTOa
         mp0S0R2tsyaeJWfpQlC3A/c1giPRYTVIQukHiKKKpOMdiqyLmTacXW36fnPjs4DPe4LC
         6uH9SMjfFPtvpipykwRN4qv8oBnVzGlmEZ8SEvMjruiJMuwJ0qv3I6/cGGlSCPnhWOZa
         v4hIT1es0JbcCioe2y2kD0s575Ahp3nNzULu2LWSO4Oyx6AvmPHd0ZNLMymsTPveoHej
         P/RvFtz+NQtSBT+IE8DHdoESf+YdF3ELslCSPc9+M47LHG6YPwDlBFM4XRsBm+5Ll2v2
         iNBw==
X-Gm-Message-State: AOJu0YxveGA3bmxBbEPhsNx6mOdHGCIVLjZHXd6S96dtgOUndaDWi4iJ
	nxF9JF0Et1kT5G+uKddMTk7qKpqV24HPKb/dUa0KCWoUmcpkmM5v29zs
X-Gm-Gg: ASbGncvHzyaUKOd65DffHMpotOMN4+6oGldmg6hA4x9WOyuhXwqKYcoZCVU5EnWLQZH
	TMij9MXyVYNrrsXzaGdr5TvV3ckXHjusgLGOR4wuiqKmyuSBeC9OIZ3jvBQKqBHvfoXcssjhBF4
	RkfrswgbQfMXMB44F83Z322PosJLgE+JTk1cp8bqFuwNuI5PPgwIUtOn2I2CVnOvuAxoLd9AQ7k
	p4QfYVQyBj6nbzZ/akpCjO2Ma8dv9+Ng9gMPEClyDb89eO4evGAZ4AqC/F1a7B7RD8UDld3TdAm
	5xf5ucaaq1kA7AVzF5LcCzkO1OOUhAkfwGQN5kNaTaeHppzEqKeQ/cZGs3cHMruXBhC6PWjUpEC
	EutAc7DwyE2zV7JOf9/ACWPoTXORImOos+aH5v6Z4xYresJKbN8dhLtvb
X-Google-Smtp-Source: AGHT+IG7PSc9pGzKOqCGiphtsXwVV4tfIr9aLzKLdTqqXWGQiCzCIRqOyEWNYrXJGtWQgGo7KeEKYw==
X-Received: by 2002:a17:90b:3e4b:b0:313:b1a:3939 with SMTP id 98e67ed59e1d1-324ed128a8emr3965042a91.15.1755782974242;
        Thu, 21 Aug 2025 06:29:34 -0700 (PDT)
Received: from smtpclient.apple (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f240c0ddsm1962725a91.7.2025.08.21.06.29.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 06:29:33 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH 1/2] repo: add the flag -z as an alias for
 --format=nul
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <aKb1BjPfmjBvHrm0@pks.im>
Date: Thu, 21 Aug 2025 10:29:19 -0300
Cc: git@vger.kernel.org,
 karthik.188@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <65E661E9-B926-4EC1-B0EC-CDE2CD1557E5@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250820144247.79197-2-lucasseikioshiro@gmail.com> <aKb1BjPfmjBvHrm0@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.700.81)


> Not a 100% sure, but I think this would actually need to be formatted as
> 
>    [(--format=(keyvalue|nul)|-z)]
> 
> Looks a bit ugly though, so maybe the existent version is good enough?
> Others may have a more informed opinion.

I couldn't find other usage strings following that syntax in Git (I tried
`git grep '\[[(].*|.*[)]\]' -- 'Documentation/git-*.adoc'`).

But I don't have any strong opinion about that. I'm open to suggestions.

Thanks!

