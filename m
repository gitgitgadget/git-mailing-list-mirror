Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585CF22F74F
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669565; cv=none; b=qtbrCU6xkQo/J91VqD4L/BfMz8Qn5ewgCf0YXoktYl6rtU1w4k3LEUdwp4RiwfvZwRTlohbZM8j0fnegaBsyy7EhxWEU1BMm2Xn6gB5uercKCNkqGrl9tinDCg8rK3/5o7NBlUS+ZPgyoGi4rISDw295FRYiDlnp/igxT9PFYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669565; c=relaxed/simple;
	bh=PeHOp7bSSj3VZEbW6xnKme+tQvKgC96dOwXHho2Ki0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzxZSqbcstMyYJZSiwBDbkR7rqfJDjJWWs0cKqhWD/HVo0c9+EUXCaXafHnx/hyui4SUw3XJalcwNgKDBXKqSioDEIhf41AprxfAqFPirG2LWUO8f3BKdHunIfuGSkyzxdI8J07fZW8LL/lEyGlgMD4Rpk9hzC8dbZn28eY9AqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue2HkAV6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue2HkAV6"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747fba9f962so2906652b3a.0
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750669562; x=1751274362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvcN9/qLxCZf4Nr1Coa6ZBlaGIGsEHKw62idGUUgbiE=;
        b=Ue2HkAV66VDO3YLzahOBSmap6p6OW1i9yZrcfiZpMu8VkfMPjGMZ4q31pwY/ym6KHl
         26YhbPQdwU4UPtozBJkV37coKRisAfJBLdBqCzIIDSU89ayrkOd5tZ2rOa977t6KBg91
         n65PILDIMBw2kNYlEF1113kIdZMeOuP53+0H+niegBSdOIrgoICFH3JihzPZfoXPA23X
         0am8YTjwyXuy+BlTJIiJWyE4nhikmU14oWQHg2/RKNWejNBVPo+8nUM+2XQny+aspzKW
         YJTvYMj7MYqkxkNOituuiVyinkY/RMBubNKAgEL08VmxlhOM9ry+dFOq36JdPJlehmwt
         RuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669562; x=1751274362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvcN9/qLxCZf4Nr1Coa6ZBlaGIGsEHKw62idGUUgbiE=;
        b=no/2mtj0us/Tr7QXoK6TjkDeveNMw0ER+UjiODrSyQ6NmF/u2Ny8/JM7gNyDYTG2lO
         YZUM85ns7FMw2tYV8mE4jMVFO4IuONn4BcA4C7DP4+knqmjFMapcpFpzP1b5TIHgyNqV
         BQLEuKiqDngvcHqkJ8rU8VkMY7jTXRHX6NTYGtUy16g3NeqaaED59GeMBqq5sIs1JAUq
         CEZrBjMTrgNiq75wEwUyNJPUl7otR2byUx/2PWcm4bxCSwo9Gp8A8ZNEhXn77eUnkqd7
         BTjdR2bGFz82ShvekF7bklghocwUMQxadpX/Pt+7ne9ZgUWaDDDFVMBdO8ON6KoHh+xB
         PaAw==
X-Forwarded-Encrypted: i=1; AJvYcCVKOCHWkY1vFFVbYlcOJLnVQYwU9dxpoWDo3+QSBNLnUIQhhVBRtucqwh6lYE7jTcXMU1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz35UzWYvacD7yW+uSASj8ZcH8sUJKrxWu2XtDX0IVmUdy0Xynl
	fPr1zsSIVa8FmI28p2G37gVQay9wotioi54DpE2IcUVYb3EgzY85wSI5
X-Gm-Gg: ASbGncsiMszAJx3UWLp7awMPjaRimY8mLOeZ5766YfY2VQ9ljwHGKqyzcYXhR/E3f4k
	v0CtCSakvFhcTKuL71nOI2RmwGmfRjWvjsk8NN1pO6MI5HW5yWQS65FX0mDX4xBKQyDh44+Vdwi
	8JbSDxNQHc5HoeA1ujwtRk7n0ozuUsDN1ZvHkgyq+JwsSz8XCPNIUZPRaOZM8XFgpF8o5NYfj5p
	er50a6APT9/2EUt2RAi2eCz2U62jPw6Q8MLwjjXMUdea3c9Ir2orCsHzsLFeV2UDabD9y95u+K8
	aVntGTrOqqxXCrorT7jufla6VFHU0QcHt+5zABVfkWtpzkblpqBFOiUT16ecPqfvDWKPudeFW8l
	c1WFyI+ZVbhvg40CyvILZXQ==
X-Google-Smtp-Source: AGHT+IFzAKQ92wKxyQOjgjX3c3wLZjcGRzquOH58hhqepz9v8iY8fT+iJ0mOu7doTf9Jh7wSB+6JDQ==
X-Received: by 2002:a05:6a00:8783:b0:746:1c67:f6cb with SMTP id d2e1a72fcca58-7490f4bebdbmr13452819b3a.5.1750669562295;
        Mon, 23 Jun 2025 02:06:02 -0700 (PDT)
Received: from dwmfdoom.tail99f6b6.ts.net ([177.33.100.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a623e8csm7779179b3a.83.2025.06.23.02.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 02:06:01 -0700 (PDT)
From: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
To: j6t@kdbg.org
Cc: derick.william.moraes@gmail.com,
	git@vger.kernel.org
Subject: [PATCH v2 0/4] diff: create pattern for javascript language
Date: Mon, 23 Jun 2025 03:35:45 -0300
Message-ID: <20250623090538.154858-1-derick.william.moraes@gmail.com>
X-Mailer: git-send-email 2.50.0.rc0.62.g658f0ae201.dirty
In-Reply-To: <4deb24c2-98f2-40f8-b50c-c74485ebc10d@kdbg.org>
References: <4deb24c2-98f2-40f8-b50c-c74485ebc10d@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm sending a new version of the diff driver. I tried to expand
recognition of functions to more possible cases, improved tests in
t4018 for function matching of the pattern and tried to add test 
t4034 for the matching of words.

I added a lot more test for t4018, so much that I got caught up if I 
was exaggerating. I was not trying to exhaust all possibilities, I just think
that javascript has a lot of different valid syntaxes for declaring
functions and I was trying to make a somewhat complete coverage of that.
Let me know if perhaps I'm going too far along this direction.

I also tried to incorporate your feedbacks, thanks! 

> Thank you for your contribution. We have had a number of submissions for
> Javascript or Typescript drivers in the past, but none of them were
> followed through to be integrated.

> Typescript:

> https://lore.kernel.org/git/20240404163827.5855-1-utsavp0213@gmail.com/
> https://lore.kernel.org/git/pull.1746.git.git.1721061218993.gitgitgadget@gmail.com/

> Javascript:

> https://lore.kernel.org/git/20240301074048.188835-1-sergiusnyah@gmail.com/
> https://lore.kernel.org/git/20220403132508.28196-1-a97410985new@gmail.com/

> Please review these submission and the responses that they received.
> Perhaps you can find inspiration for improvement from them.

It has beeing great fun :)! I took a deep dive into the suggested
submissions. For clarity purposes, I'll be addressing them for the
following index, and sometimes for the contributor's name: 

[1] Utsav Parmar: https://lore.kernel.org/git/20240404163827.5855-1-utsavp0213@gmail.com/
[2] Mattew Hughes: https://lore.kernel.org/git/pull.1746.git.git.1721061218993.gitgitgadget@gmail.com/
[3] Sergius Nyah: https://lore.kernel.org/git/20240301074048.188835-1-sergiusnyah@gmail.com/
[4] Xing Zhi Jiang: https://lore.kernel.org/git/20220403132508.28196-1-a97410985new@gmail.com/

From contributions [1], [2] and [3] I did not found many things that are
worth noting. 

Previous to sending the v1, I had already searched through the lore and
stumbled across Xing Zhi Jiang's[4] contribution. He had a lot of things
worked out, including well recognized nested functions, that is
something still not supported here in v2. Also the discutions around it
brought up interesting points that I took into consideration:

- ESModules syntax for exporting functions (export function FUNCNAME...)
- 'exports.' and 'module.exports.' syntax from commonJS.
- What should and what should not be supported.

I called 'vanillaJS' javascript as it is defined by ECMAScript's specs,
or what you will find if you are working with JS without things like
React, Vue, jQuery, Axios. I noticed that I used this term in the last
submission but had not explained what I was talking about. There I said
I wanted to be "vanillaJS" first, as I believe ECMAs specs should be the 
focal point of a tool like this one.

This is important, because some things that live outside 'vanillaJS', like
'commonJS' for example, which is a thing in Node, add syntax to valid
function declarations in their own context. Exhausting those syntaxes might
be impossible, and I belive it's not the way to go here. Also, it would be
huge work and I don't believe that I have JS knowledge extensive enough to 
do so.

As it was pointed out inside [4] discutions, it would be nice if a
heavilly spread syntax like 'export.' and 'module.export.' from
'commonJS' were supported, even thought it is not ECMA, because it would
benefit users in more diverse situations, which I agree. That is why I
tried adding support to recognize them.

Xing tried to add in v3 patterns for supporting jQuery. As I don't have
experience working, it is not added here. Like in the above paragraph, I
think it would greatly benefit a lot of developers if jQuery was
supported, but that  raised the discussion:

What this pattern should aim to give support to outside vanillaJS,
if it should? And if yes, where do we draw the line to define what is
widespread enough to be supported? I want to know your toughts on it.

> You do not have to include single-character punctuation; these are
> recognized as words automatically.

> Personally I prefer |===| over |={3}| (and similar for the others)
> because it is easier to understand.

In userdiff.c, I cleaned from the pattern the single character punctuation
identifiers and I improved the syntax of some other identifiers (Like ={3} --> ===).
For scaped punctuations, I kept the syntax with {} as I believe it reads
more clearly (Like \\.{3} instead of \\.\\.\\.}.

> I didn't see any test cases dealing with nested functions, which might
> add some value?

I agree it would add value. As I said, [4] had it working and for the moment 
but I still could not understand the strategy and what part of the regex dealt
with it. In his v1, Xing talks about 3 negations rules he added
to the matching pattern. I think that this is the part responsible for
solving the problem, but I don't understand how. I would appreciate if
someone took a little time to maybe figure it out.

> We avoid incomplete last lines in this code base if it is not mandated
> for some reason.

I put a blank line at the end of all files in this submission.
 
> Here and in the later test cases, the word "ChangeMe" is missing. How
> did these ever pass the tests?

Here Johannes was reffering to the t4018 test cases which were missing
"ChangeMe", it was a mistake from my part. This time I added "ChangeMe"
to the t4018 tests.

Derick W. de M. Frias (4):
  userdiff: add javascript diff driver
  t4034: add tests for javascript word literals
  t4018: add tests for recognizing javascript function syntax
  t4018: add tests for javascript 'exports.', 'module.exports' and
    'export' type functions

 Documentation/gitattributes.adoc              |  2 +
 .../javascript-anonymous-assigned-function    |  4 ++
 t/t4018/javascript-arrow-assigned-function    |  4 ++
 t/t4018/javascript-arrow-assigned-function-2  |  5 ++
 t/t4018/javascript-arrow-assigned-function-3  |  1 +
 t/t4018/javascript-assigned-function          |  4 ++
 t/t4018/javascript-async-assigned-function    |  4 ++
 t/t4018/javascript-async-function             |  4 +-
 t/t4018/javascript-class-get-function         |  5 ++
 t/t4018/javascript-class-set-function         |  5 ++
 t/t4018/javascript-class-static-function      |  5 ++
 t/t4018/javascript-class-unprefixed-function  |  6 ++
 ...ascript-dotexpors-async-anonymous-function |  3 +
 .../javascript-dotexports-anonymous-function  |  3 +
 t/t4018/javascript-dotexports-arrow-function  |  4 ++
 .../javascript-dotexports-arrow-function-2    |  4 ++
 .../javascript-dotexports-arrow-function-3    |  1 +
 .../javascript-dotexports-assigned-function   |  1 +
 ...javascript-dotexports-async-arrow-function |  3 +
 ...vascript-dotexports-async-arrow-function-2 |  4 ++
 ...vascript-dotexports-async-arrow-function-3 |  1 +
 t/t4018/javascript-dotexports-async-function  |  4 ++
 ...exports-async-generator-anonymous-function |  5 ++
 ...ports-async-generator-anonymous-function-2 |  5 ++
 ...script-dotexports-async-generator-function |  5 ++
 ...ript-dotexports-async-generator-function-2 |  5 ++
 t/t4018/javascript-dotexports-function        |  4 ++
 ...pt-dotexports-generator-anonymous-function |  5 ++
 ...-dotexports-generator-anonymous-function-2 |  5 ++
 .../javascript-dotexports-generator-function  |  5 ++
 ...javascript-dotexports-generator-function-2 |  5 ++
 t/t4018/javascript-export-arrow-function      |  4 ++
 ...t-export-async-anonymous-assigned-function |  4 ++
 .../javascript-export-async-arrow-function    |  4 ++
 t/t4018/javascript-export-async-function      |  4 ++
 ...sync-generator-anonymous-assigned-function |  4 ++
 ...nc-generator-anonymous-assigned-function-2 |  4 ++
 ...t-export-async-generator-assigned-function |  5 ++
 ...export-async-generator-assigned-function-2 |  5 ++
 ...javascript-export-async-generator-function |  5 ++
 ...vascript-export-async-generator-function-2 |  5 ++
 t/t4018/javascript-export-function            |  4 ++
 ...ascript-export-generator-assigned-function |  6 ++
 ...cript-export-generator-assigned-function-2 |  6 ++
 t/t4018/javascript-export-generator-function  |  5 ++
 .../javascript-export-generator-function-2    |  5 ++
 t/t4018/javascript-function                   |  4 +-
 .../javascript-generator-assigned-function    |  5 ++
 .../javascript-generator-assigned-function-2  |  5 ++
 t/t4018/javascript-generator-function         |  4 +-
 t/t4018/javascript-generator-function-2       |  4 +-
 t/t4018/javascript-method-unprefixed-function |  6 ++
 ...cript-module-dotexports-anonymous-function |  3 +
 ...avascript-module-dotexports-arrow-function |  4 ++
 ...ascript-module-dotexports-arrow-function-2 |  4 ++
 ...ascript-module-dotexports-arrow-function-3 |  1 +
 ...script-module-dotexports-assigned-function |  1 +
 ...ipt-module-dotexports-async-arrow-function |  3 +
 ...t-module-dotexports-async-arrow-function-2 |  4 ++
 ...t-module-dotexports-async-arrow-function-3 |  1 +
 ...avascript-module-dotexports-async-function |  4 ++
 ...exports-async-generator-anonymous-function |  5 ++
 ...ports-async-generator-anonymous-function-2 |  5 ++
 ...module-dotexports-async-generator-function |  5 ++
 ...dule-dotexports-async-generator-function-2 |  5 ++
 t/t4018/javascript-module-dotexports-function |  4 ++
 ...le-dotexports-generator-anonymous-function |  5 ++
 ...-dotexports-generator-anonymous-function-2 |  5 ++
 ...cript-module-dotexports-generator-function |  5 ++
 ...ipt-module-dotexports-generator-function-2 |  5 ++
 t/t4018/javascript-skip-function-calls        |  7 +++
 t/t4018/javascript-skip-reserved-words        | 38 ++++++++++++
 t/t4034-diff-words.sh                         |  1 +
 t/t4034/javascript/expect                     | 26 ++++++--
 t/t4034/javascript/post                       | 16 +++--
 t/t4034/javascript/pre                        | 16 +++--
 userdiff.c                                    | 62 +++++++++++--------
 77 files changed, 408 insertions(+), 46 deletions(-)
 create mode 100644 t/t4018/javascript-anonymous-assigned-function
 create mode 100644 t/t4018/javascript-arrow-assigned-function
 create mode 100644 t/t4018/javascript-arrow-assigned-function-2
 create mode 100644 t/t4018/javascript-arrow-assigned-function-3
 create mode 100644 t/t4018/javascript-assigned-function
 create mode 100644 t/t4018/javascript-async-assigned-function
 create mode 100644 t/t4018/javascript-class-get-function
 create mode 100644 t/t4018/javascript-class-set-function
 create mode 100644 t/t4018/javascript-class-static-function
 create mode 100644 t/t4018/javascript-class-unprefixed-function
 create mode 100644 t/t4018/javascript-dotexpors-async-anonymous-function
 create mode 100644 t/t4018/javascript-dotexports-anonymous-function
 create mode 100644 t/t4018/javascript-dotexports-arrow-function
 create mode 100644 t/t4018/javascript-dotexports-arrow-function-2
 create mode 100644 t/t4018/javascript-dotexports-arrow-function-3
 create mode 100644 t/t4018/javascript-dotexports-assigned-function
 create mode 100644 t/t4018/javascript-dotexports-async-arrow-function
 create mode 100644 t/t4018/javascript-dotexports-async-arrow-function-2
 create mode 100644 t/t4018/javascript-dotexports-async-arrow-function-3
 create mode 100644 t/t4018/javascript-dotexports-async-function
 create mode 100644 t/t4018/javascript-dotexports-async-generator-anonymous-function
 create mode 100644 t/t4018/javascript-dotexports-async-generator-anonymous-function-2
 create mode 100644 t/t4018/javascript-dotexports-async-generator-function
 create mode 100644 t/t4018/javascript-dotexports-async-generator-function-2
 create mode 100644 t/t4018/javascript-dotexports-function
 create mode 100644 t/t4018/javascript-dotexports-generator-anonymous-function
 create mode 100644 t/t4018/javascript-dotexports-generator-anonymous-function-2
 create mode 100644 t/t4018/javascript-dotexports-generator-function
 create mode 100644 t/t4018/javascript-dotexports-generator-function-2
 create mode 100644 t/t4018/javascript-export-arrow-function
 create mode 100644 t/t4018/javascript-export-async-anonymous-assigned-function
 create mode 100644 t/t4018/javascript-export-async-arrow-function
 create mode 100644 t/t4018/javascript-export-async-function
 create mode 100644 t/t4018/javascript-export-async-generator-anonymous-assigned-function
 create mode 100644 t/t4018/javascript-export-async-generator-anonymous-assigned-function-2
 create mode 100644 t/t4018/javascript-export-async-generator-assigned-function
 create mode 100644 t/t4018/javascript-export-async-generator-assigned-function-2
 create mode 100644 t/t4018/javascript-export-async-generator-function
 create mode 100644 t/t4018/javascript-export-async-generator-function-2
 create mode 100644 t/t4018/javascript-export-function
 create mode 100644 t/t4018/javascript-export-generator-assigned-function
 create mode 100644 t/t4018/javascript-export-generator-assigned-function-2
 create mode 100644 t/t4018/javascript-export-generator-function
 create mode 100644 t/t4018/javascript-export-generator-function-2
 create mode 100644 t/t4018/javascript-generator-assigned-function
 create mode 100644 t/t4018/javascript-generator-assigned-function-2
 create mode 100644 t/t4018/javascript-method-unprefixed-function
 create mode 100644 t/t4018/javascript-module-dotexports-anonymous-function
 create mode 100644 t/t4018/javascript-module-dotexports-arrow-function
 create mode 100644 t/t4018/javascript-module-dotexports-arrow-function-2
 create mode 100644 t/t4018/javascript-module-dotexports-arrow-function-3
 create mode 100644 t/t4018/javascript-module-dotexports-assigned-function
 create mode 100644 t/t4018/javascript-module-dotexports-async-arrow-function
 create mode 100644 t/t4018/javascript-module-dotexports-async-arrow-function-2
 create mode 100644 t/t4018/javascript-module-dotexports-async-arrow-function-3
 create mode 100644 t/t4018/javascript-module-dotexports-async-function
 create mode 100644 t/t4018/javascript-module-dotexports-async-generator-anonymous-function
 create mode 100644 t/t4018/javascript-module-dotexports-async-generator-anonymous-function-2
 create mode 100644 t/t4018/javascript-module-dotexports-async-generator-function
 create mode 100644 t/t4018/javascript-module-dotexports-async-generator-function-2
 create mode 100644 t/t4018/javascript-module-dotexports-function
 create mode 100644 t/t4018/javascript-module-dotexports-generator-anonymous-function
 create mode 100644 t/t4018/javascript-module-dotexports-generator-anonymous-function-2
 create mode 100644 t/t4018/javascript-module-dotexports-generator-function
 create mode 100644 t/t4018/javascript-module-dotexports-generator-function-2
 create mode 100644 t/t4018/javascript-skip-function-calls
 create mode 100644 t/t4018/javascript-skip-reserved-words

-- 
2.50.0.rc0.62.g658f0ae201.dirty

