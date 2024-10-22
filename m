Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4E1474BC
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597531; cv=none; b=peOKLTSKcsNb+cD9xHmv95CYCqvzuUlhYELW9wtpFTpiPAsDMONtzZqyAWW9i6rdd6A5rTPhoPyYVuzStUAtfB/MUhvIqQ2bziemamT9krqINJPWZi/c+XntKtsxyQRpTxWKpgzNyuUQNdSRNICS6PLWMI+9fqmvcovcFBnJ1rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597531; c=relaxed/simple;
	bh=4C9XIR43BnA7NbyRW5S7XPskjmR+R4BkK/DuWRaJCZY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LrCcFBAz0QOxK+ogRVEXJq5eJwMXg+zpR6Y8PoP44IW25ePPX9V/PrWP1hmyZfypDQTq9ar76o1YfrdNl5GpJMkfnM5QrUf9QNtKK4eonbFf+l6avlNsCpg+NWYHUVlq64FluyePcjaBwb2AAHNztIbPXbM8BsOLAyTa3PuOhMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcBhJvXt; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcBhJvXt"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4a47fff85d2so1738609137.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 04:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729597526; x=1730202326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4C9XIR43BnA7NbyRW5S7XPskjmR+R4BkK/DuWRaJCZY=;
        b=UcBhJvXtkGv/P9nMHerMTWq8JgzxHYK8m9Rdgsyqhz6X8tSxmEJxtXFmVLiz8JgYj/
         0t84rIqeUgj4MAxT/Q/NOLtqeAU1PbgYBVmgkiKCwqoRY8BTw3s4Snj0B+6lFUoHPIP+
         cTuX6XvPu6OtWMfDmFYkqrdG4/zsHr+cab99hbxt0bI6P8dVtK9PgiAFm4t9xuVM5NBK
         tLZgJwf6JrY/9PqQflYyyy3PhLZbV8PShCgFmfL8VbAmLAy2DYR+jfKX3TSj0T3GD1Nm
         uSUAe92Ipvo5KEmgSgmUK3CQ+d6Q45hilv0EC6w9S2sDeUucrGZ64CfrXcrZKkjjCO2u
         WFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729597526; x=1730202326;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4C9XIR43BnA7NbyRW5S7XPskjmR+R4BkK/DuWRaJCZY=;
        b=DCSfBeOuI414lTkjTNzV8AdsIziZbYKp9HCSDaiSoVJ/xv8wJgsBG1EgyfgsfIbf0A
         zOICDxl6krGpqtDZ5b/Sv7eszPXzAJlc5EynJo3qLJHLnUpQejncz6052i8FYEzrBBT0
         mJLcOww7ZrMHqMPxK2rFXw9dJab+G6FxspfLIQJYMX2XcEpfT7bY0Sm1eIRaUJJDSlIA
         H2vW0z0qjRn1Xd9Cq5+h2DO1lC0JDkmpMjY4to1SWNnb7jLg/KFXZjDoTXK66B5zvWa3
         MP+d629B36r/1NAYVQ9jSEAi9NzJbrbuPxAH4FqAUOhrCfYET4rIDozS84oJ7VYpXJfV
         1CXQ==
X-Gm-Message-State: AOJu0Yxu+R3ntydyQrhMPapzloQ4oYzZz9hwRC4fBZgJGtm/01O9JAI4
	HznIQNOs0OufUlrBdDYxPoV2E8mIvXT3OgliTdX6d56NSShHVSv2PERmrSGUsDizodWXKjfTQkw
	pWuGOCuAOGaar0tAVot9kbYc6V8TL/A4j24U=
X-Google-Smtp-Source: AGHT+IFdVeKxVbaMO4hmfjqo1SUh4M6V8PEPdTRi6pA2a9FgWHumi/gMYkEsSiNWDi1A6/v8n7YIPHpLkFseBOR4OKw=
X-Received: by 2002:a05:6102:304b:b0:4a3:d82f:c68f with SMTP id
 ada2fe7eead31-4a73fa8b39emr3770320137.9.1729597526228; Tue, 22 Oct 2024
 04:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 22 Oct 2024 11:45:14 +0000
Message-ID: <CAPSxiM-kf8U=vzp5MoD3tUuOtnNjcCgPhLdriyeQo5CGf=EhyQ@mail.gmail.com>
Subject: [Outreachy][RFC]: Final Applications expectations.
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

I hope you're doing well. As the deadline for the final Outreachy
application is approaching (Oct 29), I had a few questions regarding
submitting the final application, specifically for Git projects:

Is there a specific way we should record our contributions? For
example, should we include a link to the public mailing list
discussion of a patch?
Are there any community-specific questions or expectations we should
be aware of?
How should we go about detailing the project timeline in our application?
Is there anything specific that mentors are looking for in the final
application that we should take note of?

Thank you for your time and guidance!

Best regards,
Usman Akinyemi
