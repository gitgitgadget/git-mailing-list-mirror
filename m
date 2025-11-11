Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B57262A
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822963; cv=none; b=sZCQd1aRGWN1U3sBDe6asORl3oSyUMpBaz+GTrLJ1J+2RaDKfnZc8AX0YqCNq/oLdktLYKFzf905r+bQ+idR+jYtlVTaqzIZTXmNPYJns04aIXM++xPUpM1RiHXzY5tc4hVBOCiQfBlUUAElf63sGM3dAA5+9mMYYLwswi9qM9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822963; c=relaxed/simple;
	bh=KBQRwX/JDkgy2wUHCUUSnM9YUktru5H8CNoPzSlu3H4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k1rpQ+VuKYo9lYlRQ8zqkU1hKkaAIUmB7Y7K7RF67BpUoNRTF5aUgjCOa++xpMvgOnP+Qf9AS1xFW9od4LO+93cIYauxxRAoBCCi3YJl6KC0UQVenqtDvVW/vlGL9jLoKYf3YTsjApRvuLqApbWxNlZGALDklBZo9k+PF7C/R5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P21NGxyl; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P21NGxyl"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-787f586532bso16892877b3.1
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 17:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762822961; x=1763427761; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m5QZU03ODWX/r8g4PqBCIrjMNtbwwYmlOQNPiTFvVxE=;
        b=P21NGxylrWqHL0UvFP0+ngumOYVQ11dIV16tUfJZ3zJGt/UvHKqjpVSXS/e1OsCa9t
         w0j0pOLYc+/GuTYhj1h+3ULQjaAANCpwkElQrhc8yVtYzQ2KkHco0fsfgrIKOPsFbNhB
         s8fQYcmQiDgII286eAgDpwIbhLIDCAh7+0WCOpXaanmHrZgVqv6V4N7XQrgdvrqfLqxX
         zWwPqHl+N0T9tUF6VzOZNkNaOEqtodoFI9UaWHe/k/HZYNFXvxkCjIXm6z4Dg3SFtV4+
         VxsHU96kJXFFV267XJMVZH5QTj1tnIjOGBxWrLYkS2HWcUh/6kyUanEw7VC5QZ3ITRrZ
         pl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762822961; x=1763427761;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5QZU03ODWX/r8g4PqBCIrjMNtbwwYmlOQNPiTFvVxE=;
        b=glt3rOk3D81Q2VMcSLRbQ7VIEOoisT0jnyDwua4BBjESoZ5vwJRpvsJIzK7Yxk732b
         zEJ8QLBtPBEpdSGdjAdhfrYMzKkh5t6nMuY7vx2AsFGMxYO5ce14xHRTFoKJHeWi6/qq
         iihYqYt79diMDmFFdKrR7a6tyubOQj23V3xarxC1Nl83ARISC5oUEzKA88WYEJJWpYxV
         0yfrQFBVGgTpHZQF1qNv4aEDhg2uhU5yl+XVCm9vXW1zHf8JuSIXLss+nr/Jq4E4734v
         mDovribPpKBot9axGdSc6NHRvXON1zKb9lzEDqTG/OfoHVShxRRtNWWoyouxBxsx2gmZ
         hh7Q==
X-Gm-Message-State: AOJu0Yyn+wukcBwQm2l2laFQlAzZHQNUDXWbSBqze45kY7gUPx+el2ER
	k3z79p/jFJaVHscdugpipSaKr9c8iK7qZZMVXSS6ieINhQQWtBqFNJgLwCXzwXak
X-Gm-Gg: ASbGnct7ixdKVZUOMN8npcJJOtJaWSQdeGLnuJJjwCD6lHVmaSVZt7grrYJuOEEMH7l
	5x4/XkQJBNXaPvpdXc/hU7rgrBsNGjvi0NX/8Ki0/7bvc9h3aw4KLo+mqyDVGvrq8vXu5RnrfqV
	jwF9SaXNKUw6k3AuAw8VBp8o49C7pmhvXUYlat6SzsmsmmRldecwTrzHLBUiO/WKqgeQVleRZcM
	wdwg0ypdjDMKQXnQ7ILgiHT7KGUNa9K7QUN6Xq/45luW4xpCRF2FU4raQElQUujvPZybO5EEw+x
	4umvD07blIri1roRLMYMmBXcfnvr76jGRIGrQKSjA61zQfvzXnjPvWtsAQle46BsDIX0+ukZjpd
	NBcOPu0tmsZ/CEvae/yfd0Hz88ARUsl5wruHu2dgbkFMiPOw6SaSuOCy9VG80KtrPOJoNcy4+xB
	1gX+SBauuu1P+bdU5DhQMXXbdWgocAyL4Ukpq+sqDnqSd2DPBEVWkqqvnwAZHeZZof+bHoThftc
	EZs14C9xEZdKVQ=
X-Google-Smtp-Source: AGHT+IHXQQXMiEUXVCizjoyZWN5A03JdZG2+CoADO+nqDAERDunVC6n+WvOMdZPvvUspnVXZ4jqtow==
X-Received: by 2002:a05:690c:dc1:b0:787:cef1:61c3 with SMTP id 00721157ae682-787d538fc4dmr97760517b3.31.1762822960621;
        Mon, 10 Nov 2025 17:02:40 -0800 (PST)
Received: from DS0PR03MB7290.namprd03.prod.outlook.com ([2603:1036:5:36::5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d687e26esm28203397b3.27.2025.11.10.17.02.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 17:02:40 -0800 (PST)
From: Ryan Johnson <ryan.johnson.code@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: gitignore redesign proposal
Thread-Topic: gitignore redesign proposal
Thread-Index: AQHcUoI72+h+S5qsykmOqSwLzYwrZA==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 11 Nov 2025 01:02:39 +0000
Message-ID:
	<DS0PR03MB7290A11407D68F7F3623FD9CA3CEA@DS0PR03MB7290.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

I have 4 proposed changes to the gitignore feature:=0A=
=0A=
1. Integrate a hard-coded .gitignore.local option for quietly ignoring user=
 files. Automatically ignore this file, or require users to exclude it in t=
he main .gitignore.=0A=
=0A=
2. Change .gitignore to just gitignore. This is because gitignore is not a =
system configuration file. Users are expected to interact with it. Dot-file=
s are typically not user-facing files. They are expected to be hidden on Li=
nux systems, which is inconsistent with the expectation of user interaction=
. They are entirely avoided on Windows systems for user-facing configuratio=
n files. When a user sees ".file" on Windows, they know they should be usin=
g a GUI to edit the config, not hand-hacking. Additionally, dot-files are a=
mbiguous: they could contain key-value pairs or scripts. The point is, don'=
t put essential controls in a room labeled "For personnel use only" while e=
xpecting customers to go touch it to get anything done. gitignore is fundam=
entally different from the .git folder in intent.=0A=
=0A=
3. Implement gitignore.yaml as an alternative to basic gitignore file, for =
the following reasons:=0A=
=0A=
  - Ability to include other YAML ignore files=0A=
  - Clearer organization=0A=
=0A=
4. Every gitignore file should be initialized with a link to the gitignore =
templates on GitHub.=0A=
=0A=
=0A=
=0A=
Why YAML?=0A=
=0A=
Being able to include other files in a main ignore file is necessary collab=
orative environments. Teams need two things:=0A=
=0A=
1. To be able to include templates that are provided by authoritative sourc=
es (such as next.js, zig, unity, etc). Veteran coders know to pull template=
s from this repository: https://github.com/github/gitignore --- a repositor=
y that is not self-evident in any respect for a beginner software developer=
. Beginners have to just *magically* happen upon the repository or search f=
or gitignore templates in a search engine. This intuition is not a guarante=
e, so every gitignore file should be initialized by git with a link to that=
 repository to maintain good practice.=0A=
=0A=
2. To be able to organize their gitignores hierarchically. At present, peop=
le just randomly stick items in the file, so it's a visual mess that result=
s in duplicates being added. Removing a duplicate doesn't guarantee the rem=
oval of the other in very large gitignore files, which can cause problems.=
=0A=
=0A=
I previously requested an include feature in the existing gitignore parser,=
 but I saw that people are afraid to implement it by modifying the normal g=
itignore syntax to accommodate. To deal with this, I recommend implementing=
 a YAML alternative to the traditional gitignore file. YAML already has a u=
sable syntax, parser, etc. This extension would exist concurrently to the c=
urrent gitignore implementation so that it can be adopted gradually.=0A=
=0A=
This is a totally reasonable path forward to make gitignore robust for coll=
aborative development. You have a good idea and a fail-proof way to introdu=
ce it.=0A=
=0A=
Thank you,=0A=
Ryan Johnson=0A=
