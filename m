Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A151CF7A1
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681306; cv=none; b=WYPU40CtPIlSFviR8XQJy1pV1YVc79GTBX/FavLdBngVnto4WTfT3Dq7V2X6uRa1kj8r91uidRSfnUc5zQbNkS/3+Oth44z2qssWDCJUK6o1qTguVHwWRV8QyMrWoI5GPabe0VKG1muO18yabOmaHEtSoYH7qOt+mGVjH/LnlGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681306; c=relaxed/simple;
	bh=1+zCiKjfDC7cGLbeGinV5GxqPw3w3xQp5E7rfp1kUF4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XEdNiM0066tjvThZ7nlWbJD5MIKa5iUAxwlfiW6LcF4M5/9FKEC4yDiQOJugty7OhaK/l4AW7A+UFIbpGuWR6+h+hSOfA1yOy7exiKHthxHU24gHsZUOik6zI5dapmLLnhmp9pzAS/OhDA6aqv7RenYXijS4w3iPO8CS/EX39ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZscF4nkX; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZscF4nkX"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e60825aa26so1081670b6e.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 06:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731681304; x=1732286104; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dkG3TmRJvyqQz/HjqKm+FYYZuUS6tCSklvrCg+R3Ci0=;
        b=ZscF4nkX5SSuJ46+F69bhziQT42MBEfpGxATFMGaP8M3kgYEzQ+kJkDR7xOi4ShRyb
         Ke3WGhHYq0s90nXUga02pGJTXXOWazkOa0/LuWeSpMBUquTYfdh0v/jSXZL9BNotGpFW
         GSZEQI6XYLyTXLJnsU4hagHhWNKxq9c2xqEwEPortqpRjQ8IEnD49ArpJmRJ0XHjxXAA
         yLrXtFF2dMiBbmmi9dBYsoGcbTUpg/E/1srXANwf8P2HVehog66yFSlRWugs7yYNkByj
         iEIIudXmjxv55DzG0XiIwuEUYavncZWOfsUV0evAchSRQz6RZo9LC0dMjtjmXC5g+d0n
         Okkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731681304; x=1732286104;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkG3TmRJvyqQz/HjqKm+FYYZuUS6tCSklvrCg+R3Ci0=;
        b=TDXySocCEnipdScVfLxEpgAPXX9yCr8w8aXZhVwXWstg+V9nAbbLtO0oRD9ElDEafh
         IwLcjseXay3zQqbAaIx518X9k34YPqbt7W0+o/nW7WAivtDU9fumMLT8semtoiGTghgd
         KXisKdoD6LWMGZQ39JdIpkjdAfJ1KhoGPupjhqvpq06dQRdiuj/Ze2YevyZLafzaQ/6l
         fkVNHz/w2bbIVL1JPfTO5f3B4amapYNEBleFglr9GnlUmO8Ulmzh/ZMUjtzjI/1XL9C4
         /kR1ZmP6Yza9rANfesJ3Iio1Lhwvtdjj1zG0XO4a8oXEHuIMYad/sdsH7Ljh7Qjzl7eX
         Q+8w==
X-Gm-Message-State: AOJu0Yz3gBWNXeOKBU66Ib69b/SvK88bhHo7F/KhjA1RXPaaVF9KQeXr
	CL2sv5Ja7ub5ANBWnjmBzHbbUh8TZ5m5vx3SQQslJq26UeKS1wEoBsGNVr0rCvyhPiDybMkRpQk
	+JPA/cpu3/7ND8O2uXYbAvGCtyXRlEQ3y
X-Google-Smtp-Source: AGHT+IELkDpj7d/x9qmI+9j4TE7/HkseBR4HGRm6WaIgrlSU1joGia7tJyZzyljXYUHBPE4PG846+pSC0+bpsIW2jfs=
X-Received: by 2002:a05:6871:618a:b0:25e:d90:fe70 with SMTP id
 586e51a60fabf-2962e329d37mr2718084fac.43.1731681303592; Fri, 15 Nov 2024
 06:35:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Caleb Cushing <xenoterracide@gmail.com>
Date: Fri, 15 Nov 2024 09:34:28 -0500
Message-ID: <CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=fh0UwO+9-6RRfA@mail.gmail.com>
Subject: git remote set-head automatically
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Context: recently I've been trying to develop a feature for my Gradle
plugin that derives a semantic version from git describe.  In order to
achieve my next level of feature I need the HEAD Branch. Now, I can
get this branch using git remote show <remote> and parsing the output.
I'm a firm believer that it should be possible for me to write code,
long term even, without the internet; I did this once with my job when
I needed to go home to my parents who were very rural and didn't have
internet; I was able to keep working without access. I want that for
anyone that uses this tool.

Problem: I don't want to have to do a network request every time I do
a build, in fact I'd rather almost never have to do a network request.
Gradle makes reducing the network request to less than once per build
something ... unsupported. jgit doesn't expose support for fetching
this information. Then I found out that you could do `git remote
set-head <remote> <branch>` which appears to behave exactly how I'd
want and expect. It doesn't easily solve my problem though because I
want my solution to be generally applicable.

Ideal Long-Term Solution: git remote set-head happens automatically on
lone, and even fetch if it's not set. Explicit setting would override
any automatic setting; and it might be a good idea to automatically
unset if the HEAD branch disappears from the remote.

Could this change be made? is there a reason not to?

Please cc, I'm not on the list.

-- 
Caleb Cushing

Appointments https://calendly.com/caleb-cushing
https://xenoterracide.com
