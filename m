Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4603D2FD7CA
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678495; cv=none; b=bFJ8Q+G/738GJUNNHYmC0GwWbnuEZ9stnFOYuV/6nntw+zI3hlRsOWlmupQiDKYOQ9lphVRzth4c46bVc8ixxI/Y9DWwlrdwsWp015SW/0zWgq8znlZoqOowFBcQec35HAR34ffkZEs/Ks8I1dvpZehosHkr647RKh97unDRFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678495; c=relaxed/simple;
	bh=jWPmNd589wYVcjYD0Y1wEopDKhfJSXwXzeGnc5pmE6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gN6LiLRkRL+n8QmStbaKZB9A1BuHRLorqaWl7Ov5svSfT+OIZocEUUh+P72reySV6hq0GNJrxBYlXVH1p/T9+ctAEI6VF4i3QYUs0MNJPpovJSPEpA1a3aUNG55K4eBgdqnkCjkAKbokXTSTNtlMW2I2a8MOEki7+9KSYFmpaLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg354duj; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg354duj"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5e18598b9b1so3799185137.0
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 04:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764678493; x=1765283293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWPmNd589wYVcjYD0Y1wEopDKhfJSXwXzeGnc5pmE6E=;
        b=Yg354dujYNzYxiYFebc6QYIOrt0QO3cskLtckBNqEijH5vOvZKSndxHGJ8N/qnq03d
         Fbbnc0cAEYfVZF1DgD9EMsvItpLEKmkPiQz7ZzYDxmAkTWSpBK5uZYVK+yThnkWd9L71
         fjM7If4sfRTk0q1qEXsyUEV0ZkmJfa3NYUMX0H4CUaX8BV1gO62hHU71ov2s6PQYcfWZ
         HcAi3chndAXbAQL4FS94K400SnY51mwle1/SBCIy+0MA+k7Q839sOUGzKcDryM9IfwoF
         dNjPbT1tRQ1Gbt2bUpuMSwZbeQcUgIDEa5R38wyVLO7HkEbjz/DEaARlXufUz4/WLAmg
         2OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764678493; x=1765283293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jWPmNd589wYVcjYD0Y1wEopDKhfJSXwXzeGnc5pmE6E=;
        b=fkfjtDmuR9GZ1CtnGNSaL1PAuTOmA87qfKWCQ8auoWamsC+KjE/aTlrqiOVhXdEcva
         XZkgnKlmzZaa9tm93MPCe7WKE5ato+eqFPJLV+S6aeo0YDO6oPcapbyIqwoaq89nKX9j
         1bfddMRVCOHXnDSPNDi734AqaQVJf6xOp1XbkE7PoIQvIOfwwgRKp0lY+C39CaR8d0Fu
         xRzbt1RJOO7q9fSKA99vs7jf41w7MHh2CYA1GfNWbr7w3pTHLGgK6buOJI4qN5IYUYr4
         ejR88dtLB0rF/TJNqZwLZODOmvrN3EpcNFnDWXsCh4Lrq26MxslppSbwwZVAeBqjjkFB
         Sedw==
X-Gm-Message-State: AOJu0YwN7RwvXYGxGTekaCW2a1Kv1qpOZkaKACmGUwMmuN0j4GH0hNsl
	tx6/ISjNWLFdvUEFi4LGVEyoJnZ6HIfHqjzZ2spbM0SIlmwyZ49nxPVbro+qswB+fV4T9aIjjZ+
	lXbkSv6kc9igw14AAW3nfVATxh+OEdhs=
X-Gm-Gg: ASbGncvNHb57R46Sq5Dh/Ag40fjSFVGCKPpXF2BK+HOqLt59tE8fvWf7RoEQYnbwso6
	UpeZCJ8Z2EbnVMApLe37TltqRmm64tejr341La5Ax749Nwv5P0sTWKX5hzE8hTh8ZjzMXBNoWHy
	JQGDtXJWJHrf/mmTqrTFw70Qk7RIUYKtfneyY9eEBkJa0D69md160QunzXmtdO+FLuUeQmNQ3uT
	N3OPMxmskGpyuWdZPlW16o0mtFUF10K4f5biiYexbTLtK5sMwX3yhZjqc6VbvPjPRKVJEfp8Jjk
	mCnt8HSYzCwQMQSY1hK5oAYD8QY=
X-Google-Smtp-Source: AGHT+IHYLYFC3S+Lvue318xB5CzeFo3FHUKwEWgL1ttRyFdAo0I8wv+ZfTZiaN1hVwgyATOFcdWUu+EriyAd6kho18M=
X-Received: by 2002:a05:6102:448a:b0:5db:cec7:810b with SMTP id
 ada2fe7eead31-5e1de2cfa1dmr18738258137.29.1764678492997; Tue, 02 Dec 2025
 04:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L_-b5d5qVdL0TASS5iA8rWQxianT4_2zmhMtwN8p_TYbw@mail.gmail.com>
In-Reply-To: <CAD=f0L_-b5d5qVdL0TASS5iA8rWQxianT4_2zmhMtwN8p_TYbw@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 2 Dec 2025 17:58:01 +0530
X-Gm-Features: AWmQ_bkFmCqimtSQTmO0zXH_r8AaYdJmvKKD6140gjekMkhGD_DyCAwAy6sFZpA
Message-ID: <CAPSxiM_b+kDO=-Lm-SYVPaACJLuXXV3bJMpOywHWVWpKjuG-uA@mail.gmail.com>
Subject: Re: [Outreachy] Git Internship: Refactor in order to reduce Git's
 global state
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org, Christain Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 3:10=E2=80=AFPM Bello Olamide <belkid98@gmail.com> w=
rote:
>
> Hello Git Community,
>
> I write to you with great joy, humility and gratitude to have been select=
ed
> as an Outreachy intern for the December 2025 - March 2026 Internship prog=
ram.
> Working on this renowned project gives me the privilege of working with,
> and being guided by, some of the best and most impactful engineers.
Congratulations on being selected.
>
> My appreciation goes to everyone who guided and assisted me during the
> contribution phase. I have learnt a lot already, but I am eager and keen
> to learn even more.
>
> In the coming days, I will be working on the project
> "Refactor in order to reduce Git's global state" and I hope to make
> significant contributions both during and after the internship period.
>
> Thank you all once again.
Looking forward to your contributions.
>
> Olamide Bello.
