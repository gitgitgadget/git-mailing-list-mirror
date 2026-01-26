Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B22D979F
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 21:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462749; cv=none; b=SPS8jxb8zWJR1WKcCGIb6z8rzfKYBn7n/zloKUwzfKTVCJwIwhm0vkd+oMSXtOUacxxdlQYA6EBAVqP2BQivM6C04SzcMXO4CSlM8YKo1KIbinS1kWxbJE1mNSZMKqz+lu5Msb84oQFZ1yREDvECbHVUtjgwR5M9Tehhtc4ONsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462749; c=relaxed/simple;
	bh=26j+blwJPR6Q9Sq6cuegvnPgfzoqlFgZt1HPTBZDZtY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=YmSUuZO1vsK7501NzoJOY/R2YXqy5MHj/Lr2M6e+IYpTOFdle+aYIHS5I2YJFKrvEQlTDkIrQpmOsjZJy+WZd7pOoZTPAzFvNjBbJERCKMKk5OP4JJ5zGU3ONO6KtvMwL8OiPORXZvRe0OaioxAdOQ2c6E6RSYr4UIebjyXuIhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDzclANu; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDzclANu"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b6b0500e06so6529713eec.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 13:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769462747; x=1770067547; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdMatIttoVRUwU8qSX3eHzdKT+kdkJ1SqvSdPnM8Q5A=;
        b=XDzclANuh7GuQT/zLf8QFMmJuvPYU4x12KIKE5WLUh9xzcT8nXwcRTs6yZvqtfr338
         /CNSFz3uiWJuNw9EopaQ6MPa47hpJaQrixSfkwM7SCt2U/6OcGdzIkssvnFrldZZ1tlZ
         xexwpX4BVKdnVPxUqMqfltNuffApT+gDYWYQS4JZt3Pv2vOC80J6W99bsGHYsFZFgV1p
         Xfw3Bs/8YwRmx6XqEg6bMakGE8mkGxIEm4HuN3PqiY2h/Z5PNNVuKKKo76Jpsp+0Q6n9
         q2knDNz03o0c7OwPXd1xzN55Q2fMjToIgDA9D2BHhvpkWtwfdCBNuQqp2w4cfLmKEgXv
         mDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769462747; x=1770067547;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TdMatIttoVRUwU8qSX3eHzdKT+kdkJ1SqvSdPnM8Q5A=;
        b=trVdH0oFOcCJvVV90ILPvXdpo+guu/04yfNuels02sJGoT8Rb5CQ2MVLm273Pd0u1q
         /TCQTKJ/4+1yxvq8TtLltCviLFftllgHbHvD7+gMqughwAZxr9cq5NJi+1acmW7ALAY2
         cvWKYJe7GUf5QzXyQefMlDMS/hyylmZYOeE6VB3gFkryS+Ew8enPZfsQmilD7+8Zrhr/
         MNJfvuPtCx6UDJ/ZQHrkhuXi12d7VleU+wE7gcyR8JAasbH02uJSeU28tRhcExIGr94Y
         C7qy7hii0tLbxEhid4fxKcHXO7I8oVWi8zSSsDIIxLVIp39wnGp9GJyGRXxZAzrN1bEW
         tjRw==
X-Gm-Message-State: AOJu0Yz6Iakrwn26NIYyB1uCcpf7U+epn3uyCIpNAZ3C6wSQzCnw+1A5
	UDdPyH2tA3Jz+e9b24Bp9cCSpH9VejTK7z7Zyy6CDfpFqG8x/5dL5rQDkF74nA==
X-Gm-Gg: AZuq6aKI07eMCIEIzq1y7OoKN5FG+sngoSUodvdIu5NJJDHdo1Oa5H+ec4Wb/ni6ffD
	16uqR5wKaaYzYYGprrCbOdfreLuHEkzvj4dEFB2KDKaz86aWiokX6l2jj9JOu0VWJljiIDE3IZT
	nVohcAYXHe+deV69+F05i6/5638glJ9NA+lEqLcJQJoVJ0c+nwsxmPZ4zQoQo5aNv4ENTJSnOKV
	bVcdDn2ioMFfLE8GsP25TxKmMws7LTnlx8E/a4rYK+CvvoLL7Z69nIbZ+97uowTBdUBRag5GYXO
	sEM0dZ5dCSghK2LW6pvQoy4zHgKGvItOVZkvarkiykqb0jeSlgf1iwoJzR5XKg4QKFrT8an1jeJ
	RVkKh/ReqLWvpZiNeGQYP6fetwm0tIwRAwJWb0Ec50sykVBVhHJ5tT1kVuomyS8G46fBJYdCSbx
	bsYeJx9NM0Sb4Q
X-Received: by 2002:a05:7300:b58a:b0:2b7:98d:7b54 with SMTP id 5a478bee46e88-2b76432b865mr2883415eec.14.1769462746586;
        Mon, 26 Jan 2026 13:25:46 -0800 (PST)
Received: from [127.0.0.1] ([68.220.59.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b751bc5032sm10249781eec.1.2026.01.26.13.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 13:25:45 -0800 (PST)
Message-Id: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
In-Reply-To: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
References: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Jan 2026 21:25:40 +0000
Subject: [PATCH v2 0/4] doc: some more synopsis conversions and fixes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This time, git-show and git-submodule are converted. Some mistakes on
previous work were also spotted and fixed.

Changes since V1:

 * fix mistakes spotted by Kristoffer Haugsbakk

Jean-Noël Avila (4):
  convert git-submodule doc to synopsis style
  doc: finalize git-clone documentation conversion to synopsis style
  doc: fix some style issues in git-clone and for-each-ref-options
  doc: convert git-show to synopsis style

 Documentation/asciidoc.conf.in          |   6 +
 Documentation/for-each-ref-options.adoc |   4 +-
 Documentation/git-clone.adoc            |  52 ++--
 Documentation/git-show.adoc             |  16 +-
 Documentation/git-submodule.adoc        | 369 ++++++++++++------------
 Documentation/pretty-formats.adoc       | 164 ++++++-----
 6 files changed, 321 insertions(+), 290 deletions(-)


base-commit: d8af7cadaa79d5837d73ec949e10b57dedb43e9b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2036%2Fjnavila%2Fgit_submodule-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2036/jnavila/git_submodule-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2036

Range-diff vs v1:

 1:  05e68e2825 = 1:  05e68e2825 convert git-submodule doc to synopsis style
 2:  3a5b642d05 = 2:  3a5b642d05 doc: finalize git-clone documentation conversion to synopsis style
 3:  bcd6fcd119 = 3:  bcd6fcd119 doc: fix some style issues in git-clone and for-each-ref-options
 4:  d078e1d94f ! 4:  f6314e580d doc: convert git-show to synopsis style
     @@ Documentation/pretty-formats.adoc: config option to either another format name,
      ++
      +[synopsis]
      +--
     -+`<hash> <title-line>`
     ++<hash> <title-line>
      +--
       +
       This is designed to be as compact as possible.
     @@ Documentation/pretty-formats.adoc: colon and zero or more comma-separated option
       ++%(decorate:prefix=,suffix=,tag=,separator= )++
      ---
       
     --++%(describe++`[:<option>,...]`++)++::
     -+++%(`describe++``[:<option>,...]`++)++::
     + ++%(describe++`[:<option>,...]`++)++::
       human-readable name, like linkgit:git-describe[1]; empty string for
     - undescribable commits.  The `describe` string may be followed by a colon and
     +@@ Documentation/pretty-formats.adoc: undescribable commits.  The `describe` string may be followed by a colon and
       zero or more comma-separated options.  Descriptions can be inconsistent when
       tags are added or removed at the same time.
       +
     @@ Documentation/pretty-formats.adoc: multiple times, the last occurrence wins.
          the literal formatting codes described above. To use comma as
          separator one must use `%x2C` as it would otherwise be parsed as
          next option. E.g., +%(trailers:key=Ticket,separator=%x2C )+
     -    shows all trailer lines whose key is "Ticket" separated by a comma
     +-   shows all trailer lines whose key is "Ticket" separated by a comma
     ++   shows all trailer lines whose key is `Ticket` separated by a comma
          and a space.
      -** `unfold[=<bool>]`: make it behave as if interpret-trailer's `--unfold`
      +`unfold[=<bool>]`;; make it behave as if interpret-trailer's `--unfold`

-- 
gitgitgadget
