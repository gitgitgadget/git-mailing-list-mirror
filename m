Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDC01E5B8A
	for <git@vger.kernel.org>; Tue, 13 May 2025 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124294; cv=none; b=qBzncqeACBiHzafpDMO6I3Fdl1iDjl8GLGUWlOAiKLhCWJn+VSlWZBTovmNMLwmSl1WOz/8sTM/IYIz7mjqf8+MWE8+cQ4Kcu077pGF9C6oK4nQLquNZF9glV8YrbPIvZGEmz7flISkqrDenXEFoeCQCRzIIXHC9rfunETCAnkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124294; c=relaxed/simple;
	bh=54WiEJdQKVarr7n3/hR4sk1lUSVyVRwlD1jVwiQu3ik=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LdLRjPE0kMnW3Y3LMK+EBEQz0ZAlzozNjbbgkinjCVuNMzPJfb0a+a0Ruv+zMfl/4Ciicel5tk2TdfBvYvR34gSwEquhTts54tVSfHWu3mi/9Od2DdbDveVX0eX9AuaxtpFlPbRtjWmhTxJQx8Jfx/6UK318Rz4M062s+fF40p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCj0N42a; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCj0N42a"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b200178c011so4436464a12.3
        for <git@vger.kernel.org>; Tue, 13 May 2025 01:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747124292; x=1747729092; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=54WiEJdQKVarr7n3/hR4sk1lUSVyVRwlD1jVwiQu3ik=;
        b=mCj0N42aQowDccEUyLTW7Wg+9fSK8Vhvuur+LyTqmmQrtsi3YbIBAcyIpseI0PwLBU
         bZlLfRRZZMrRntaREu+MYa9OXAZgocztOrYpijylaiquuD2OJZIIKud9tlcL/aYPQwCi
         /i4yyEJyu2Zc36GvQTiD7V8DdkT96uL4mbcqGd5/PV3wrDp2WUDcxBDROYhovY2Y1oje
         cCQWY/CRN7F6avlVe311PnRcfTm/kDo1L7JnjM5GgyJk16xDA3VmjvUMygpIT8dsPq8K
         XHYNyY0iaJWo2LTUajmRr4CRMILqSm9+ys3CwHa2ULev2yOURwW0jOTEbs1z1N8lFT3U
         nrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747124292; x=1747729092;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54WiEJdQKVarr7n3/hR4sk1lUSVyVRwlD1jVwiQu3ik=;
        b=bnx/xTfXiBEJ3OhUBZyA6SZqhAQaHEMJntinoOqkEPfkgYq1FLdAKWeYKJtduys6l3
         Ph9Rf3m0T74GH/PGMpsyUzhDHhcWXDSawTpYo0bzX9hvzZVI4U1Aii1Vmrtdwm+z078B
         VE4NnxJazWu+/KncNAWo9MDzWUgwbTuBN3+ESYWC9MueK6m944pqBWciEnQA6PHXz7pf
         ohDx31G35p9OKaBpB9OS5V90Uh+OM/sWbUpEiIu9MYd5zK8ZSPlKcrDHOnc5uXQc2pJs
         u7X0AEMy5hXiIJAfrb6GE1O4T9mfyIqfEGBZ/NjjFl/LSZ5Fv54m4yIK6mnvsaCXK/27
         3rIw==
X-Gm-Message-State: AOJu0YwYFtmta250iR3KPlNG6ka4KDFThcXVhsamqnwWtxR7vfqUNHv9
	cjCQirbl3wprvgRHGiAbV39//DjHh5d47Gs4fPJAhSeLEdUaiG0uqS8QK5VhGGZnczdgXX6DJUY
	WYghub8MdrHqtc/+Ra0Ysi8YL49hGkzhx
X-Gm-Gg: ASbGncuqbRKvccloccBioYuvVrS/3bXhdAysKdWbRW05J+sT71yISWc02iICWze8PkW
	EXl6Kwh1ImDHABrAoAiO01xmyW8ZmXdlgj65Y60CaEquIEKuWMpaT1lW75aa0y52sK9kWnxM0V4
	HEuvEi47XFThS73bZEcT6Fz0TAVZQO4nEU
X-Google-Smtp-Source: AGHT+IHSA/LLzmKfrii6JlTAUcBw8D09uYCA46cdcuDcmHiMcIMd40SPOTPRz2b4k4NWY/h7zGa4qnlXZA5v9Bdsygk=
X-Received: by 2002:a17:902:f64d:b0:223:53fb:e1dd with SMTP id
 d9443c01a7336-22fc8afee39mr185250225ad.9.1747124292141; Tue, 13 May 2025
 01:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nathan Royce <nroycea+kernel@gmail.com>
Date: Tue, 13 May 2025 03:17:36 -0500
X-Gm-Features: AX0GCFtNuIcoY4BLdPmkosvCZWYi9dDEp9hqYlNOt-ryZ4iK-YXBLO39las-L5Q
Message-ID: <CALaQ_hp2dgPS5HYpYPzztCS52SCnR9vF2ovAHZOBPpS8MRLSrA@mail.gmail.com>
Subject: "POSIXLY_CORRECT" - "msgfmt: msgfmt: --tcl requires a "-l locale" specification"
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Order matters with POSIX. Arguments come before source/target.

Success: `msgfmt --statistics --tcl -l bg -d po/ po/bg.po`
vs
Fail: `msgfmt --statistics --tcl po/bg.po -l bg -d po/`

build/gitk-git
make[1]: *** [Makefile:76: po/bg.msg] Error 1
make: *** [Makefile:2466: all] Error 2
