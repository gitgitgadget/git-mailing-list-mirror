Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDE61F8690
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954601; cv=none; b=XqbavHrnx4FMHkjhNKfytBRubazI+dNNcr2VGwquhATZDdLLYtqkep7PWHj5JzRkdInqjUKXHphA2dMlRsYKvDZo4vl6v6VASumcy0g3LTk7oJOvJbW8qkTbTFNy/8jO6AN4fJd+yDA3uimD9WGdluMv58SyNfFvWXROOzVTD8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954601; c=relaxed/simple;
	bh=HLOamjvcfoZ5QM+Zl0hmmAja8TErcad2g3QWMWMNwrU=;
	h=Content-Disposition:Content-Type:MIME-Version:Date:From:To:
	 Subject:Message-Id; b=OQVCuzTXZij1I70A5Ek5Aqoy0VxcBnq3iWIEmzFpOewkFORu+gFR2WXCYlWsjXGjUVYYlQVOBCsUEEAwOusmgo2K7Vwj3unDb6pG5ckuZ63F65nPUQyNxZXb4OzT5/vDhT1ceVvQawp4KHjbKMDwnKf63SJYAgMLsroJ9dFs/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVwLhL+E; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVwLhL+E"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b783ea502eso445857f8f.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 02:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753954595; x=1754559395; darn=vger.kernel.org;
        h=message-id:subject:to:from:date:mime-version
         :content-transfer-encoding:content-disposition:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HLOamjvcfoZ5QM+Zl0hmmAja8TErcad2g3QWMWMNwrU=;
        b=VVwLhL+Eq2hZrNLUcepfFOHaIfUlu8+91Fxegzj3eXhQhspYbNJDCUtOvhQlnIctkL
         mtI2xWWgVKrEq32m/S681v8aj5lwVIXS+hXQNteGE8w6VZNxTpwFo+0vDJqiiC+Xu/Fr
         PAzTe1pSpGWKMjHR8OkikwZl3kjHX1ABCh8bNRGUUwrU+sMq4DwUgOHhsDD43vnC2JWd
         0nDZlJ1jjD9NTR4QlJsbzloPndhw3a8kzdOZYyF8AkrRN2WW4X2GC3o+42G1leXTstCY
         +FTCMg4Dx/oVR9GKtH6ju2SMj5Z9rjv09H8IO2QlJizqbJQzFvA8NOxa+UxIfdYtUBge
         x8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753954595; x=1754559395;
        h=message-id:subject:to:from:date:mime-version
         :content-transfer-encoding:content-disposition:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLOamjvcfoZ5QM+Zl0hmmAja8TErcad2g3QWMWMNwrU=;
        b=AlQ3ajKa9GYaKvTSYyHTAXOZ8qnBwbmucAZSnZNRqcfwoDQDNvRUOVEnepCY1/czYn
         ZmGTdJeDU5xoJ/FqA5uhhJIIeLlY1/pdhT+O+FEAuU3LwVom27t4Jt2AlhubG4rRXs46
         hj2sHH0C9iUWi3mRnz3AYUtoY4Cswlr8lPaEdLhm6YotO3ZlTEFdlUGwt/TJT6/kOrgc
         n7h2x4s4U8T2OawqUlpWryzod+6sc0Fo4AFGCYZedsOePl1U3dThh+6S0b70BDc2n6YR
         tVmxWZ/u9KI22k3bcQw2MwJAa4apQ4/zCHdVau4OZ4dmF1Zq9o7NlKCT+GqIA0RY8PWb
         e5UA==
X-Gm-Message-State: AOJu0Yw5zmFuzV6FYccvrEkNR/YXyf6pyZbQt+LTZGFfBkTPfz9+SCaP
	GFoskj9IUkiMGJpnrQCYOj5UuIM9zKTq/KhYlOCo7WEYBB+NITDArLmeUvx8+g==
X-Gm-Gg: ASbGncs8yWgF7IsDIv5q/m3vsN4CScPVRdTdFsvUt9RfZS0NsndcyDXrkRftpxGuARA
	aU8zyGClRhmfBC3x204VAuQGSeuIzaBqp2UeG5KmwoOtoqfi8yO+jLvrvYL1GpRZFbksdj1UbTv
	B98EiX5xcL0h+8wxFHKLbx2aCz1HarIR6KSRazhOreZq5YQG/fl5gMO+/oNYJl5xTUv+x5Qxd12
	mfRMOtKesokmKu8ZtjDjSllAtgWoonb1SboSoB9+wyA7GhVzO2BNqdcMY6Ifw2q+taSQ6YYOkar
	xLGBb9f0FaT64D3TRE6ici8gsDVqQcRJHg/fGiXRd6atUZUtHCso/H/dHSXp9MK6cVBLwO2uu9l
	9pA6zujEdKOxqfIuJqQR42cT5ss6ylaGcPHKRD6dg2CotH8e2V+jNmhXsBLQxiRk3ka7gWsXBW+
	o=
X-Google-Smtp-Source: AGHT+IFLK4c+ONXUXVLvc9nBT0YCLP3XXQFdmYXL5mlid3VhH0i9lfxXpx7X6AEx5OWP4zaoOgriWA==
X-Received: by 2002:adf:a11e:0:b0:3b7:9d87:9808 with SMTP id ffacd0b85a97d-3b79d879e93mr867685f8f.15.1753954594618;
        Thu, 31 Jul 2025 02:36:34 -0700 (PDT)
Received: from localhost (92-184-105-156.mobile.fr.orangecustomers.net. [92.184.105.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee4f16fsm19527565e9.19.2025.07.31.02.36.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:36:34 -0700 (PDT)
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 31 Jul 2025 11:36:28 +0200
From: Victor Duprez <duprezvictor4@gmail.com>
To: git@vger.kernel.org
Subject: [RFC v2] git-secure: extend interactive authentication to more Git operations
X-Mailer: smtp-cli 3.10, see http://smtp-cli.logix.cz
Message-Id: <1753954588-934281@smtp-cli>

Subject: [RFC v2] git-secure: extend interactive authentication to more Git=
 operations
To: git@vger.kernel.org
From: Victor Duprez <duprezvictor4@gmail.com>

Hello Git community,

Following up on my initial RFC [1], I would like to submit a v2 of the git-=
secure concept =E2=80=94 a secure wrapper for sensitive Git operations.

=F0=9F=86=95 What=E2=80=99s changed:
- Support for more operations: now also covers pull, fetch, and submodule u=
pdates.
- Verifies token validity before proceeding.
- Shows explicit error messages on authentication failure.
- English & French READMEs added, with usage examples.
- Working script and repo here: https://github.com/VictorNafs/git-secure-hub

=F0=9F=92=AC I would greatly appreciate feedback on:
- Making this concept native (via optional plumbing commands or flags),
- Security model consistency with Git=E2=80=99s philosophy,
- Integration possibilities or risks.

Thanks again for your attention and guidance.

Best regards,=20=20
Victor Duprez

[1] https://lore.kernel.org/git/1753544769-115114@smtp-cli

