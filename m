Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60E824B47
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651276; cv=none; b=p+SG288LxKEVZ5eyNX7VhounM5kMJ+IPTZaJApcdtQ+KwDFauRaZSWarqr0MW1szp9MnMwcZE5q6LWY8+u0BaEqRjYpRUKnqF+HAHr6hl6uIxp0tZUWxInxSusXdPWAlS19OFyFxYxDAmvSSQdFvmqkY2IC7HRvPjOyNkgAwVyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651276; c=relaxed/simple;
	bh=QItCdOmZnK3esGU8A81hEiuvgxXu01xMpGb7Wm3ND4E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=q3UUnqsjlF22eJWMUQnMtR5AjFmqoEiVMkjR5c2KQ3Xn0phgBZijhXwm8HVXH3u7LIvowkYzaNG4spg8ELQK/Eg5ovtr04KGnP5ot903XY0Eufcu04Ki5d36TwGCCPN11crTCUkINW2LPK6ujHZ0H7wjE1lBBLiD9ZjrZDuO9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDEmWm0p; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDEmWm0p"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso582053e87.1
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 00:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705651272; x=1706256072; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o0bp56/Y9we4cxbIpWnHEnqlvHjyxUZwjKLP0r73MrI=;
        b=EDEmWm0pyDjEFDR3Yn0i1YNKPxvSKV2alSYSD64OUMS3LxtfgoHV3c1ptH2UC72Ua5
         PIMmbZz1wRDHW10h5H0zjp/x7a3rQVdw+0VMNqzB/GKpfdEHSBGN2G+iXKZdK9rUwvEI
         ZxWnyUvS80nL8FhzEkEplPOEsUBf6CZ3PYQwhAfpq3Txv+S/CR5P9jdNOkjA9mHi8CHz
         Za5dGBahnpaaN5jwaxTuE92ZYw6rWjy7u9K7yUCdF4akvReG/fgYOKR0uJh+HPa1fshn
         WtxJIWwc+Yhxg0W/v1x+yrnnS22/s1JW/lwDGrFvwFclFsYmyQGXknuWv8elcOop1t0K
         jLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705651272; x=1706256072;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0bp56/Y9we4cxbIpWnHEnqlvHjyxUZwjKLP0r73MrI=;
        b=o0kl6nSfGDGHYduB1GonPM150G9dCCelp2R2gY4Nr3uD+fOI7zuZm9M74XqfgyyLjq
         9JyeVE++/vlwWqvigH4qp6pI3EAfokxxdkI2szb/fAE9AckiJV/bF4l4vXDS/rb27r4I
         cRgwEW+lkpCzmJjrLh6EVTM6npJ5Zt77XdJ0Lwj4eVd+za8vZ5r9KRI1uwOZqt5HluFj
         zDDZosPYCjiN2VFW7HJhAWkjFjew7pvCAK8dc4sMnpDajyqCWn3pFoM9RYLFzwge8FD1
         iegbc43yg8IlhuISR2pKdzbKgFafi0s8RAfoNfQeUvfEU24vU2EhUuQ0dIOsYumDPCsa
         Pk/Q==
X-Gm-Message-State: AOJu0YxebVDISJRmmi4EqgK3wNLcnfpxzaZNMvkKr2f1BYcWvsLSABUu
	NsTWNOHgsoI8Pj/WlJzWKiVlP9ZGM8a4QFKQqVk6lRjnUqTyHgQpLubgQ4eE1Ne6vz70fUzgzWv
	CrRE+U8Xo5WE8lbOIE72+h3G6+J5mp/hhA2iJgDc6
X-Google-Smtp-Source: AGHT+IFU0TXaig/CkK39yCTsARhf6IYmZDl1KhbDOUOsGTayZZkbMQkqol5+Me+CkJn9Jnrenp7mfCvQIcv+S1Fogu4=
X-Received: by 2002:a19:f507:0:b0:50f:d65:895c with SMTP id
 j7-20020a19f507000000b0050f0d65895cmr421674lfb.69.1705651272262; Fri, 19 Jan
 2024 00:01:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: M Hickford <mirth.hickford@gmail.com>
Date: Fri, 19 Jan 2024 08:00:00 +0000
Message-ID: <CAGJzqsmd0mEjH-iB2RZLTkGw37W6y_vVvS1vDKgObofAfprBnw@mail.gmail.com>
Subject: [Help wanted] git-credential-osxkeychain support for attributes
 password_expiry_utc and oauth_refresh_token
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi. Git 2.41 introduced credential attributes password_expiry_utc and
oauth_refresh_token [1]. Credential helper git-credential-osxkeychain
currently silently discards these attributes. Is any keen macOS
developer interested in adding support? This would greatly help
git-credential-oauth users on macOS [2].

Details: the design could follow git-credential-libsecret [3]. There
are already tests in t030-credential-external [4].

The work is small enough it might count as a microproject, though it's
atypical because it's platform specific to macOS.
https://git.github.io/General-Microproject-Information/

Kind regards
-M

[1]  https://git-scm.com/docs/git-credential/#IOFMT
[2] https://github.com/hickford/git-credential-oauth/issues/42
[3] https://github.com/git/git/blob/a54a84b333adbecf7bc4483c0e36ed5878cac17b/contrib/credential/libsecret/git-credential-libsecret.c#L157-L177
[4] https://github.com/git/git/blob/a54a84b333adbecf7bc4483c0e36ed5878cac17b/t/lib-credential.sh#L436-L538
