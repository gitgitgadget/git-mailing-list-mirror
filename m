Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510231C3F28
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 06:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898818; cv=none; b=gYWUeiJS+KISemLsYrHawsGery68PporHMJpsAVDfD5a+pg+3YceTP3R6d8Qmnt3YEWrkyNOYXuByZOULpDOL03rgf5KS7KKhU6hPz6AUMmqX47ICWTjVrlOhzrnJPUdcJA0HV0fxD3O/hcljdO3yeqWPQpI7h4RjAUqgBN4fws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898818; c=relaxed/simple;
	bh=qNHepjje6v/hI1D/Al/3ZrT8hH1pmBhJIDhcmiiNpKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3w5Z+GZkNqZlh/DxHQUtadHQ8iD1P0k5OUgYnzVWOL99iZVuedhF/2v+YKF1dIXY0i9tFsEFfZdhNTn8RzEbYvAyHv+FDCL50j8ZWdvVhD80Ie7lBGSK5ZZEO2Tv6M1odrt1HD15pfBRF7iqGHqgg+D7I9aKXkCLZLgb9Axxco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L80GXmub; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L80GXmub"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0bf4ec53fso1097375a12.0
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 22:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733898815; x=1734503615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfmoO7SSpqj7sDW794NPOYR5uJxpDYt/mSXxGzm3qnQ=;
        b=L80GXmubWzMvQO9e5bHWnAtKZ+eH7Pllg348HRiNuOKqjB2xNfGIxt9DCgzggcA/zZ
         9bSueOqlckz9fvezAQxLifNj4/9S41BjtWWDjuGNg41KbJYqDJpp7fnYczDGrpECWcJv
         7hRdNtfGTl7tv8C56Ua8VWrim6LbkeGePUUBqaDbtV+xxQN9NU62M1N+XvN0fZiDPcsl
         6m6tkXsK8NUp64uMqYbzcwuTrbC8Or2swlhRTh5dVhlLgB8oMnikF6ArD+Jjr1T3hqNV
         N4UFFid1rI6s1VmCtA/REOdBO2RXDQA2nxV4ciLhb7n5dWcdncOMLzUjrR77aywjF32K
         MIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733898815; x=1734503615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfmoO7SSpqj7sDW794NPOYR5uJxpDYt/mSXxGzm3qnQ=;
        b=Wbc49PQtjilW9tgm6aM2ZIArB4gQLjeJq3SNSl/3A/UKvAZ6cGiFOZnvGAEHpaobs7
         oIAoyPkO2WXZQJr3CR2++F5jXHULhJubOLkiVaLlcaoXhHWtT+MZyRhfdRxdEErlSZwz
         5YzMZfuh9qvnwPjwFwv9O5HqtNW/Uk77QbM32PN1QZ8YbONP7jPSrzsmVvI8QqLjR8bw
         HOzdbtgIZTkuu9SKI+ZPOvarRUfAOkgux4wqnQzYEeOnXflARcOzJJ6MGxigjD9dOm4x
         p+Bdx6NyIJfvUfixgsKZ/Fi10gRIdOVk/Z1z+qaf4nxm7FcwEHQu3B2WPh6E9PuJnWww
         S2/Q==
X-Gm-Message-State: AOJu0YyE6nVvB2Mf+BxCa8Wv1SAKYkx0O6f0CFdmK00+xoRVtD8+48q9
	1IGFJ+Tjo8gtC+MBcJckbqdCn7JoUEAslcNnNkEySI/bTFm8do41N3ropO+U
X-Gm-Gg: ASbGnctRKSxmu3o9uhh+rPjXxjikqwp91SivOB5Q9/lpI3tMANgWI2rc43Uakckae6x
	hDpDwhux5gMCFLfSBO+RAO6WZNGmiqMYZDIoVHLJze0pf36HfaycZzgMQO7nopGFb3cuA8L3gMO
	MC1sptyleRCXGJs6k2tI0QicjrrGDvw6qYXhqqLaOi3XFpuzkfU5CtMYVxIJGcvt8KgevVNMXVK
	vg3SNhw2IuZkK7G9Xkej8MIiAKYOkXtBoeuQtg2Ilt8nzXirvVO1Yzsum93S3w=
X-Google-Smtp-Source: AGHT+IG8p/RLjSf0vVoWIZAEcQH8TiIsQT1MlyiTwpdoWc2CSVDx2AaP52aYGYZqLkgCg7autReaig==
X-Received: by 2002:a05:6402:3553:b0:5ce:f524:c15d with SMTP id 4fb4d7f45d1cf-5d433179922mr381685a12.11.1733898815102;
        Tue, 10 Dec 2024 22:33:35 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d00a0370sm6875803a12.6.2024.12.10.22.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 22:33:34 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v4 0/7] git-submodule.sh: improve parsing of options
Date: Wed, 11 Dec 2024 08:32:27 +0200
Message-Id: <20241211063234.7610-1-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241210184442.10723-1-royeldar0@gmail.com>
References: <20241210184442.10723-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we run "git submodule", the script parses the various options and
then invokes "git-submodule--helper". Unlike most builtin git commands
which parse short/long options using parse-options.c, the parsing of
arguments is completely done within git-submodule.sh; therefore, there
are some inconsistencies with the rest of the commands, in particular
the parsing of option arguments given to various options.

Improve the handling of option arguments for both long & short options;
for example, passing flags such as "--branch=master" or "-j8" now works.

Changes since v3:

- Minor typos in some switch case patterns.

Link to v3:

https://lore.kernel.org/git/20241210184442.10723-1-royeldar0@gmail.com

Roy Eldar (7):
  git-submodule.sh: improve parsing of some long options
  git-submodule.sh: improve parsing of short options
  git-submodule.sh: get rid of isnumber
  git-submodule.sh: get rid of unused variable
  git-submodule.sh: add some comments
  git-submodule.sh: improve variables readability
  git-submodule.sh: rename some variables

 git-submodule.sh | 216 +++++++++++++++++++++++------------------------
 1 file changed, 105 insertions(+), 111 deletions(-)

-- 
2.30.2

