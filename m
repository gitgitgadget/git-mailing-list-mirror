Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53AC1DE2A5
	for <git@vger.kernel.org>; Sat,  4 Oct 2025 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759601337; cv=none; b=hQNKzF/8d0kakD7Vxj4xYHjak9b/dCS/As4O4/biI4fg/j6UfYgX5Ca6plwi/XQx90wFtLwOx9QJIVRGTTPCSLR7c92Lv8fzclkXHk1Nm94+GwGThwe5bqPVW7dR86o+7BLfpo7dkaTtPpJOa+j+p+mn0NFVdkYi2Bov//3yq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759601337; c=relaxed/simple;
	bh=/8jFnbqQZc3I9Vje+39jkBHTQcyMgF32+G3qwaqp25A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uhkFOBKFbxULnOypuF0p33e7gqt1Lz19d8lWDBLzpvHICBHXgfyeHWxN5aFwNrXFtzOaQ2aMK6A6ddL6Qi1KoKeWaGMVFe+JFFi+Dr+Iicy31u1VMnxT2hCaEggHvVMlWc4qwwLaDqn2BvPyDOkhmTZ+i0NPv/Z5Xdwy9AVcTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgyPkgRp; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgyPkgRp"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-279e2554c8fso31619095ad.2
        for <git@vger.kernel.org>; Sat, 04 Oct 2025 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759601335; x=1760206135; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/8jFnbqQZc3I9Vje+39jkBHTQcyMgF32+G3qwaqp25A=;
        b=OgyPkgRpKkNq0YSAHyVRoBAQE2mZDWsp0P9Wbds8b5nc84HNK9MaSItJSQG0Bybu+G
         ukvtuqS6r688o/0X3wy1eJH4vof7/y9/mUjJdYcBo+ZbDzaiAtuwG1/S6GDB58RgH+0C
         pZ6CdFab7aWAamyCMN5g6X6vQz1USfdTB0paMAgMC4zPMRt0GqGlqWecErK/tBVilXwP
         HOvFLTsRpHYpGzFQoLUGdjQ+ApleQ44MJAku80eVouiTAkFMPQxqRJSNapCa41aqSiTm
         G4msRrKLDUWOEkBcHspLz1V8RVJ9cQuC6DVl1aBQM1y5bq+X7IyI6YmOJkuYLvjfpqGu
         xgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759601335; x=1760206135;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8jFnbqQZc3I9Vje+39jkBHTQcyMgF32+G3qwaqp25A=;
        b=X/o6iKZKqf27uOkcw8LSRrRMKQUVG0gDnYo/SvM9qLGl35ZEuyAXcrBSUkwIhyiLXL
         n0jGYGO5O7Tbwh/Mo/KhcKAzyePvBNwg+7t4t2z+DnSq85Kd3QjAR5/QjUabzFb7Jlo6
         9dhhCmylzU+Jrxd5Ai4bp+74bLtoodyNkeC4Ai/yevouE49XZ+f/MroJlRsTRbvM8gPZ
         8Wma/YBBplALXsOqciP8ZzmXb4gKmSxEwa1p65/zmY7SxbB3aO7NnXoesImJ5AIi30Im
         HnBppIN+4MUio2lYCRkJkXfz4iF9vXpu3VxO787gNbUevzaTuCZEkuVp783o1GiBDlxf
         ehPA==
X-Gm-Message-State: AOJu0YydH7eLDDhhnqzgsP1aG1OnQXIkrs+lfSK+7eeFnrhM4p3jha3J
	sicw94wDyup0cTIebh2Zv7U4BEQx+FE4yHhfEzK5TX2LLxS66rSkuwHaQs9bmAE/P1X4BlCemYX
	gDdGK6B6EKP7w/yi0Rr8LXirGe3k9TaP2kfEGuHA=
X-Gm-Gg: ASbGncvqvtzXFH7v19tHfKIOYIkb0Oo8sVqcIP/6dgKJN9lz/DRQaIcs8Ds5yG/a2iD
	4XLr93B4pkXPWtsBi/k1Qj+EcA/QDonKXsSK5A0WwjQNx+snQuceAprw4p1ShEjl3yKpoEv8+BV
	fZOh4nAcznvqnXdmYNYf4KXZMdkOmbQWihP532lEEikF0GNKBff2lz4aPP49DPhDh5mnhdjUQSK
	Aa6XfurAPAbKNyh1OldfxMqlCK8cF3akSpwp74gWE1aEcgr/cDQ1okdpCeJuocg
X-Google-Smtp-Source: AGHT+IGZPl0xj3B8lcCQXMvya6mvqlb8RIiLtFU2t+qzL9AKOX1HNQupIAQSWXS7DdJA4jXRweWgjPJHTQHWWLUE51E=
X-Received: by 2002:a17:903:3c48:b0:28a:8ae7:4034 with SMTP id
 d9443c01a7336-28e9a593f57mr91055915ad.25.1759601334758; Sat, 04 Oct 2025
 11:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vedansh singh <vedh2o2@gmail.com>
Date: Sat, 4 Oct 2025 23:38:46 +0530
X-Gm-Features: AS18NWBVfJpJ7n1XDvSdUZL6V8943XBQZxXI9P3nzjcP0m8EmjuEx2A-BT_xl4o
Message-ID: <CAMWvevL03vRzX35tiRCkoU6CKucKim+GfacEVuN6wwm9r+1a6Q@mail.gmail.com>
Subject: [Outreachy]Microproject: modernize path checks in t1410-reflog.sh
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm Vedansh and I'm interested in contributing to Git through Outreachy 2025.

I have successfully built Git from source on Ubuntu (via WSL2) and run
the test suite. All tests pass.

For my microproject, I'd like to modernize the path checking in
t/t1410-reflog.sh by replacing 'test -f' with test_path_is_file in
lines 133-136 (in the 'rewind' test).

I found 4 instances that are assertions (part of && chains):
- test -f C
- test -f A/B/E
- ! test -f F
- ! test -f A/G

I've verified these are test assertions, not flow control statements,
and the test currently passes on my system.

Is this appropriate for a microproject?

Thanks,
Vedansh
