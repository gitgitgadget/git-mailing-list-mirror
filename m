Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4630AD0A
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764926948; cv=none; b=G2dquS7kn8WqKTJkcsr4FQuR9xtMywZ551SsUSVd1jlBHNywYCN+H/18KzpIo24RiDBaCpXgJs26HkBGxRZBkuiZHjG2dTDJRefoYSEs7oH66U7zRImBLz1R/U2Ccih/UF3OhIgoQbzwOxMxpICcSFclQnTMTzu6s2xHZQ37NXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764926948; c=relaxed/simple;
	bh=aephfKZ04GaYEKFwdr5A3Yf2Jrbhmt4Sj0+jKoTbOaU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ujIZ1GhZOhhB1D+fTcW/CTqD6nMwsgqtfvYktfiYtM/cOMMKEevYtdn4fVTxG8AyNsGJo6o4cRuDvdGi8rBtXebZIjUNoXP0JdpgI7MCRrydnOKxNqHTKSJwP7iec7QGpJ3PZ/2zyitWTeguTqrrBcw9q4dXy8wzlL8W1I47wMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HprkmxqO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HprkmxqO"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ade456b6abso1717779b3a.3
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 01:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764926935; x=1765531735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aephfKZ04GaYEKFwdr5A3Yf2Jrbhmt4Sj0+jKoTbOaU=;
        b=HprkmxqOZwgeONjQxPqZu5ubQD1UCDJAwQguQqgH1bxD5kiaAEghsIQ5qBkvXWbkaW
         GC5vd4c2ykvFZ4GsnTV/Og3zFSuF9vqfeRnYuUa8qNiTvENkbbLCCFb7dKN1ULJCiBcj
         H+9N5DPjVZxiP37RK4AwcUmNOyAOLGkmWihJr46ibPBlyfhc/w1u7Wp6ruN3x0eOcmd2
         UHPIZOv5wbcXDUI4dpBVCjwHZ41nwgOqv/fHQkQI8/QzgChjEKn/y4eD9y0jyxMi++Tp
         bW/dUFd8/K1++nkW10Eh6JzV0ssqjWv3JBk3RJKQsGjo5/fjP/fBxqKgm8iQTyGcEYcf
         /sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764926935; x=1765531735;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aephfKZ04GaYEKFwdr5A3Yf2Jrbhmt4Sj0+jKoTbOaU=;
        b=Y526dRM0qgBE7TuDWqCeMLXWidycCIy8yg5+D1AgrERKDgqPRkw3894EdB0owQMhUI
         WFr1wpnZgIx/gy85bJA8/RaBbcgX7xZXkuSD/SAyEBYDY4P8WAKK+35aNvOqcTnMyzGF
         lJ/8fwMxJamp1KViRMZEznoShChIz3+7vu8fATr9ayARdOROrVjJ/iz6E+GnIas9EiI7
         e3MyxdaUMQLPm0TULTwBeXkDXxF4UhOTSrhZU2GhDbbdj7fawjzMOOx4MCUqKHPC0aty
         3oZ9YMTHf1geITaWLot0L8dW/oEGVuc4u1o7vpLK+v9FAp9pVVatH9a5eJ3toAkB3v0n
         ZB4w==
X-Forwarded-Encrypted: i=1; AJvYcCUrnLICFOSOBe03YqGKUvC7JZD7WHT3tUJRiYbPCCSaxOqgsxtOkqU8AvoBqFJ0VplZU08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9RzggfJhd/JrKYdZ4L2JTUAvBeGo1ClvwinDaiob2jSlyww5
	OuPMc/oysNnFB+5RSZNFydWhlpfFLpA3dFizT3kWjPYtkw0xd5nygToagYpiXA==
X-Gm-Gg: ASbGncu0qEWX1cJSZHdznjYbc531ZkFtYVm3WsaDIJX06myGgfqAakf5hYHuZS5wO0z
	LwYDjH29b2d9L9HYS8YdaSyWQkJ4F8itcUJf1KWIN1toeanGCTFZ/KbZyA23tD1mHGNnr+pL2Cy
	AlPCbt7AgmA2uVaif9m14F00QFrn4Q3PNEbIUGxlWrkMMOIHITlxmcWqdGckbLOLBAgHfkBesvt
	+5I8rGJA/J935bXK3O4ltdE4/jMTaeevLXlBDYgpDK6mUU51PDveV1PKm79S2V+NacwrqYzRE3u
	0fOoY62XLguoj0P4c8kY7ezr/TAmT1/WLgM0ZFFIDyEdC8vRNURPzCyjBkxPEmEM4M6JZZzbo5b
	B2GIa94Y9cOaX5Kx60dorp5/z/QdtoGLJoqHFwY50EzJnwZjAdUUz9yXJNqNE7KQYSvS3xjnBTH
	TiJ8WNtjINLA23feC4GlKTLHQoNrkzGuzzmwZeWp7v
X-Google-Smtp-Source: AGHT+IE79jPCzMHBD/fsA5aPpEpqjYmYKs2VFMbtLytkBXtUVVSTaFaoRCu0Ogm4FIUss6gEAn0CSQ==
X-Received: by 2002:aa7:9063:0:b0:7ab:995a:46b0 with SMTP id d2e1a72fcca58-7e00dbe88eamr11336729b3a.15.1764926934642;
        Fri, 05 Dec 2025 01:28:54 -0800 (PST)
Received: from ehlo.thunderbird.net ([49.206.130.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2a062ac40sm4580839b3a.25.2025.12.05.01.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 01:28:54 -0800 (PST)
Date: Fri, 05 Dec 2025 14:58:51 +0530
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Bello Olamide <belkid98@gmail.com>, git@vger.kernel.org,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Christain Couder <christian.couder@gmail.com>
CC: Taylor Blau <me@ttaylorr.com>
Subject: =?US-ASCII?Q?Re=3A_=5BOutreachy=5D_Git_Internship=3A_Refacto?=
 =?US-ASCII?Q?r_in_order_to_reduce_Git=27s_global_state?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAD=f0L_-b5d5qVdL0TASS5iA8rWQxianT4_2zmhMtwN8p_TYbw@mail.gmail.com>
References: <CAD=f0L_-b5d5qVdL0TASS5iA8rWQxianT4_2zmhMtwN8p_TYbw@mail.gmail.com>
Message-ID: <0D20055E-51C1-4503-815D-F7B4CBBF4C1E@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Olamide Bello,

On 2 December 2025 3:10:15 pm IST, Bello Olamide <belkid98@gmail=2Ecom> wr=
ote:
>
>I write to you with great joy, humility and gratitude to have been select=
ed
>as an Outreachy intern for the December 2025 - March 2026 Internship prog=
ram=2E
>Working on this renowned project gives me the privilege of working with,
>and being guided by, some of the best and most impactful engineers=2E
>

Kudos on being selected! I hope you have a great learning experience :-)

If you need anything / have any doubts, always feel free to reach out to y=
our mentors (or) one of the coordinators:

- Christian Couder
- Taylor Blau (in Cc)
- Kaartic Sivaraam (myself)

Cheers,
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
