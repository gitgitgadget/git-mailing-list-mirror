Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C813B298
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742746100; cv=none; b=kSVQnfDQyRf4VUjQ3XwkNpojK6CR3XGWDk5GiSCCZgUauMjOWlbdxG+wJzDYvTXnLzLuncHzDumBp7vc4aYz8KC16NJzA3XoZ8mlehEssliXwKsyLFrgwdXwB8GMOXcB7xhDx0ttJt+iCjbNoB2fO8y3lahGMZo2M8yUcbHspcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742746100; c=relaxed/simple;
	bh=x6elT5j/dMUdXKKls76jqI+GtWfgV/KVQGTcSQh527I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sdGJ1hM43YCA+T34QOeSNMIE6qNu/+EqPF0Uqld3N2Dgo1W3hQzxfy8YdzloDRkuIrbYBH+oh3pAciQ490Hsvu5dpTapKIKFNX8KYGDlgLrmsMDexnc/sof1kngXBCTPFv+cpC7ssdagU2jwAiNDzpWxKV6bGGunE5sBDkW757c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoSx6C9v; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoSx6C9v"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso6186340a91.3
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742746098; x=1743350898; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6elT5j/dMUdXKKls76jqI+GtWfgV/KVQGTcSQh527I=;
        b=AoSx6C9vhPcxYv9hA16/9LjU1YkMXwa4WGF0jcusk/LclqOJQ96VeL/x3HCnqn1WhH
         vjb1qh7UrPqBh5rchrjxMhQ7i3p43pmCmVSveEELPUMf1ByWh9siZRjlBlpFjnueNePg
         OXFVA3Bq7ypacswsetefKpSbF2UJY6pTRy7l+JNyW5vagEVF22bp/qZzyr44sQect3g4
         mNHAgMuySoKwqCIIyxq5Ra58Dt5T8QkHODG3vogqXfbfuvn37FfAcYK1vzjqbxmlw4KT
         dP0YtAYbNgCpzqaHTRU3ta1ugJb7Er4hIQFah87wDH7nrIMO/YkBZRSjd4acJlpgEl2H
         BFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742746098; x=1743350898;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6elT5j/dMUdXKKls76jqI+GtWfgV/KVQGTcSQh527I=;
        b=ILLzI3erNtYgqF4s5o0hKjcIbPyG4YjmzVrKzefC3i6ke8Hklw68v4jG8zvzSsN9vx
         NswLcGX99cwUOOA9YIBYlrcnExQ0WBXKcCl6XcyKET//vxOyjE788lXa6IxbQcOT9lyK
         rb/mAKaxoF8KRnvaRAtsZ/MuP4AysRyN/iW+gDF7WYrjE0G9s1N8R2Xf0yOiazQBiNx7
         Sg9OQYj+hF5I/9swdy3Zv8r+oRPbPeKXqpFIvtnX3/aos5jqB28ii2eaymwzCTA8S0pF
         Xr4AJeqXBUnXRmOh8/ZkLQJXGMaJAZiCa39yYB6P3uT8jqf2UkehvJfCYIzWZxut70ax
         KUjg==
X-Gm-Message-State: AOJu0YyZ5tHaHbH68HyvaQVxD/C+7QIWPFJgCY7bFrfLE+MIVdzVZxSb
	XEAOWh+Tr5A7OOBJS1OxamD/kCns1i3eMd60CPYeqHk5Q1rNov+63btYcA==
X-Gm-Gg: ASbGncszX1hl3E+y5H2UdRB3vegPBfgwXcY/bRyP1MBZUwJmBfOTrlMMBuCeVDkE6WU
	duFCAHlu5c/dwb+5wUl/aGV27sRyYC46cQAfieJ2xIDViLA0fa4I7jC8x4FZCbDbjyQizavtFkb
	PqJioFKNOqmLp4cGED9b15ZGHJLFP9GKt7smPCtdUsj7e2BL3Ee7onBD1dZBGyqkeXi89wpDAQN
	MlqJIgkKK5hrfBZIMJ/m9bVrO3FA+79+LSjQzCVWZ4Eg0L65igrubB2JXoYj7ZUSkk4zpWhSyXw
	rhIpUfgu7C9oIx8+uPe/EPblfvHwyCiOjGwuGwx+GQiHjWIXypCko04C1hhnXVIr52mD9vQZ9sC
	lfsesyMQf+BJX2Q57bU7W
X-Google-Smtp-Source: AGHT+IEVwulr8LyM+pp74cBQfox5m4ALAlpuM2AJiPzlc4zWCIkaR7yGkHVtzQc666QlA8IVqblH9Q==
X-Received: by 2002:a17:90b:1811:b0:2ff:4f04:4261 with SMTP id 98e67ed59e1d1-3030ff1129emr12436713a91.34.1742746097842;
        Sun, 23 Mar 2025 09:08:17 -0700 (PDT)
Received: from smtpclient.apple ([2804:7f0:b77d:1b50:1d6c:cbd3:c52f:6b5d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a44csm10207687a91.37.2025.03.23.09.08.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Mar 2025 09:08:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [GSoC PATCH 2/2] t4018: add tests for gitconfig in userdiff
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <Z9vUAzt-5FNgSEKd@pks.im>
Date: Sun, 23 Mar 2025 13:08:04 -0300
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <204EB04B-40E5-4D10-8C2F-46D6F2E3F77C@gmail.com>
References: <20250319172016.2115-1-lucasseikioshiro@gmail.com>
 <20250319172016.2115-3-lucasseikioshiro@gmail.com> <Z9vUAzt-5FNgSEKd@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> I think it would make sense to suqash this commit into the first one.

Ok! I'll do that in a v2.

> You're missing newlines at the end of al test files. I don't think this
> is intentional, is it?

No... somehow my text editor is not configured to do that. I'll fix it.


