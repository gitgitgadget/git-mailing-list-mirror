Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4DB640
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092375; cv=none; b=eSov2tMTzECOm17xM0lNXeUnSQJovAvj5fCw/0UXePfoweo0/k59gddPDwsb9mtPLavFiqYZI11UZ4FmtKO8O5lI1IROVUDO2RtBQCm4Cx3lOZj82gLyViH4lEOuaXG0Tr2HyUU/UsRPSp+WcvH0vd1XJsq2MDiGuzQhMB5f1DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092375; c=relaxed/simple;
	bh=XwBUmcJTtXiFhthJfE9eeEY3dYkCUSUS3Kueyrb92tk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XhEsIipi+PI786Gg52twOi/s7RTsRyYtibN7+IVgHKJKn079E82ADyKZnl/hzZoJsIUY2X3odMooaWbUEnwkhuhel0Xsm82kBVhy0rKHiWov8ifBhRQxhvC7ftGimOHT+mIuGmzU6LFYU4TSfdsf0/wWY/dxBtNLfrQlCow7+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3kBKyQ2; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3kBKyQ2"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6eeca49d8baso14935277b3.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 04:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734092373; x=1734697173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XwBUmcJTtXiFhthJfE9eeEY3dYkCUSUS3Kueyrb92tk=;
        b=I3kBKyQ282ENluDKQ/R9tIZcXzRKazKCpzl54qZBTzFAzEO5qwAKbpmTvka0g9pgWG
         qAeLdH20HmrbOunHoYeWCCjHfV/6K8OWV523R6hUhHjEth3DkZ0ZyBHF2GrXSoSxmt65
         O0kpehlDKuBy2lP2pbTxKFhKxFj7YeRZcPb7Zg3dNW6KdVWt+7pBUIafdhgrioDWZOEz
         Aowdy+kKrYk8ZxPaDtbBjlNrG2QoBHIF+eOuvZGfTI/xW7kauyG82rwxGV+0MKH0+cQK
         r+I4VQOaD87O4bw4AG2s/RjvvGVnFQyzSB7cAZmo2vS7v8ickzGUCqfmwcG4+xG7k+UE
         UtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734092373; x=1734697173;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwBUmcJTtXiFhthJfE9eeEY3dYkCUSUS3Kueyrb92tk=;
        b=Xc8A5UC+FkLaJzm3XJHESZPzcv7lYk2aXJhHD8Jnj1rPqG4aXEO6kp/MsZ6+pc6/tu
         +zrsQYBxfjFFNLa1Z124eOHqVac/obwgSwBNGMJceIyXvW1RB2TF1UZw0Qe/xJvGyHYS
         m+8ku6RdrW791p+VZs1QLwpRVG5V6eOmEKJGeam6vwPuXjDj0MItS0fSQBXER+0gbsrW
         JBErFTaIU077BX9TDPVahHSmw5sO3fO0b2MNLYHofXTvy9loPVu1ER+Imfw6ezNwGTJr
         PP0DQKVGBNpdq9p54Zb5jrWCaAvJCtSGt0ntNWwyGqi08A0ao0SpkLT8b0H+AM8KZEam
         FYwQ==
X-Gm-Message-State: AOJu0YzGLzQ93l+kk6FLlHzRSPXNcWN13IBo4OnpMoCspnEadF/RwSW+
	zfChX3WdTVmDuX16RYcVAywEnclZ3NipBkLY34Elkv/wFmgXT0CQi+uiscf6M2zU6VzUzszpOsY
	Bb2YYkyWn/hMuuNF6rVzPAHOvdVWzxUh5ldUXvw==
X-Gm-Gg: ASbGncuz1xFZtGxl8Bm8f/+YPaH1UmBlG54SGvcvCAvRDTtETZsz9+WMKjd8Dvyekrw
	I0BigxbzCjtno6TiK6V2nemyxPQYSMEaScy9pYQ==
X-Google-Smtp-Source: AGHT+IHvvtgTeCeiu6kU1KnSmzyFwxX3y90wwAne8zPvfm6X5ZmysaWxBZlSDpr/JErqbdsW4I3UThIuFUo1mtBZyxM=
X-Received: by 2002:a05:690c:4c0f:b0:6ef:f020:601e with SMTP id
 00721157ae682-6f275efcd43mr40474377b3.19.1734092372940; Fri, 13 Dec 2024
 04:19:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Fri, 13 Dec 2024 13:19:19 +0100
Message-ID: <CAGedMtcdbbAbH-RefZ4ErZ_p0HLNCVA-iPJokNwkuNJqLUw8_A@mail.gmail.com>
Subject: [Outreachy] Blog: Converting homegrown unit tests to use Clar
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

I just published a new blog post on the internship project scope, my
plans, and what I've been up to so far. I would love for you to check
it out and share your thoughts!

Find the link here:
https://seyi-kuforiji-902b48.gitlab.io/posts/Test-conversion-project-scope

Thanks
Seyi
