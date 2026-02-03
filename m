Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D73321A6
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117514; cv=none; b=drDKgvGXQCYPbL33LK15Ps5ScqAtbp3WnEbT++hVpVk6ThKnv9QVgSJQc94UpApamcoh1SlyaGAZBkM37eiv2KKN/Wq/Yp39cKnTVftvGjDQg96rXG8Kf7mt/PqlguUgIjroJ8E+zsmROA2EBpavYbjO3mwml6d1q0sInnSkMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117514; c=relaxed/simple;
	bh=+KrO0wD77XWreFJ1U6pWoWb3O3EHgTpz/poEZ4NFEkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVV+MjWnPhoA4Kpq2brTp6AW+DZrNSs++b3Ki9SKx7up8FcHwuSiZ3p8CNeXdRXoP6QTUyopICQdVKLGwT1HBpolbsMQGiutYRMlxsfOtLvdy5kThmU5ZgjZgUqyP0iL87+PAhVBePoNDkoaHnJiA3J1nFVWti7/QBVrGYq3e2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE0JY0q0; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE0JY0q0"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59deec3d8dcso7216545e87.3
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 03:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770117511; x=1770722311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZrfYt4e3Yr4E43bzGGKRFkOqLuqftX7of/UDsqleJA=;
        b=WE0JY0q0sDGzfbsCuMpqQhBcStKRUdSJHOQ2qnyEChkG+THjR1ds6joJjOvTS7rhhW
         PnauCnJJDKh1vxlFpLtp1Qto/0oFaKeopukAG8Tq8eKxBrJBiBfKf8xIOF0sxqFNhjO3
         QETyPZIFyMS4lQHfZ+OsiR9L1eAjSplfZi0GPEYcShtoBiCFMqCI0mIcGZtWc05YtFfZ
         a+4yZBdyQF+8z8+w30Ndj3a00d5jDMBwAvSc+2LuRzIdOFh6swtI+NxS2dMLI1p77Ecl
         wOMDIqUESwHQrgdC9o2aiaOBjtPI0KJrpJm74kq1bGSh4ayraQ8RrZLntOw8BdwwpM5j
         RrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770117511; x=1770722311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZrfYt4e3Yr4E43bzGGKRFkOqLuqftX7of/UDsqleJA=;
        b=bKCb/QkqlGy4JyjHaMWfwq2AiZ4b5gQZ8I5nKIJ5bPSUq0nQZZ2TdEpdgKk2xg77ZB
         fLORoKPG8FThtPeOZB4ZOFVaIGYja0P8a2B1gOzlcN6INphxPL1izIj0uW9cyee7TvKO
         vFlgUrCTV0LgHK4vKkSrsP/DVuck0RdmeyPc2UgE01NUhzbtuRWTb3YVPC1o/yX01a2F
         w+GMWtqXgxj86sOM7dF6e8Cco6ugLQ1KWGnTqkTtN9arDRGNkVbFTx7Im62VjVURKK6H
         ieyoItP43428w1pq8ep/tqtedQt8u63O1PdpwDSepWDDQMDHZiPqVYovKaaVdDAQAmJt
         a7Gw==
X-Gm-Message-State: AOJu0YzuwMxQHWGAEm5VCFCs3lH7H2aThtMuwSAco1xm606C2uVxFtTY
	HiZMOG6UWzdn4z5bSvcX2r5H88glQFZXrIdH6VSwuYNhyy/YnIaJL61L33os9A==
X-Gm-Gg: AZuq6aKLKHOUP7OmDcvixNv+L9jhcEuV/7DuO8LiXQQ1WkyHuEzQndq8av/O/IGIZSa
	7rAbHtd+dfif0eBhWks6FJ5YASySqT4ucy70Z3GHLBtRHJIlYLv1i0goNJZ43dJMYUXAFumn5eI
	tIFjh588jAicYe0hXiqPf/3o+dP6ruuLC1VkcPdOV/4N0D2hF/Hc6992zzGQSvHeN0y0t5kOZaz
	SUORCr1C6wxWM7LuQTovlfOUnvCMrDtGlv6r1F1JYOVyjeFEAuWR19R+Jc7dxKPdddbQ+hbUF3E
	WW8SdUdPM/6Xs4P/vBKwjxDHseTpYp10wHFm8zDSJpjBfq1HOkzuUxBOxv6wjOir5yLUDhbmeRl
	w/aH49R4H9I5y2pmQ291G+wakRixu+JxFoBc9l+FgxQmclL9yNVwV8o7Lzk6Fs9rAligVHv8VU5
	J9StPo8GZP3eZEOiBG3A2Z5lG4k113OIQ69C8XqQG1ahghlpUu6N+zvl7GDT4n0p9BML0EMYduS
	AHY
X-Received: by 2002:a05:6512:b99:b0:59b:b020:ebaf with SMTP id 2adb3069b0e04-59e163f5842mr5310347e87.5.1770117511035;
        Tue, 03 Feb 2026 03:18:31 -0800 (PST)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074bbf76sm4141109e87.87.2026.02.03.03.18.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 03:18:30 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Tue,  3 Feb 2026 12:18:29 +0100
Message-ID: <20260203111829.31088-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202225630.12507-1-haraldnordgren@gmail.com>
References: <20260202225630.12507-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I just ran into this issue when working from a detached HEAD. Maybe I can
get around it by adding "HEAD" as acceptable branches.

But it's an example that a lot of code out there requires real branches to
do things.

	$ release-it --ci
	ERROR Must be on branch release/*,hotfix/*,develop
	Documentation: https://git.io/release-it-git

	error Command failed with exit code 1.
	info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.



Harald
