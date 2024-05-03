Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089CEBA2F
	for <git@vger.kernel.org>; Fri,  3 May 2024 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702011; cv=none; b=ACUqkJqfHlCDmEBjXe7CV7QDwlKe34z7FCkxFv0PoiXBJPi/MLefxe+inKuBDlvPax2xLofTQYcxfjO4BRw1VLTD7Shqx/ewJ7C+xuYP2cp0PaDnKUX5Ofo8l/U2DkPse7clFmTqfaxBPpFPpJfbcUkt8yL9dIQlx6/8xbDNMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702011; c=relaxed/simple;
	bh=9epNSOmkyxN/Ec7t1id64vJGgasoMK/ZIoCvcza1Lpw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QJFVLvQWCvJG7ic2/RALWp4a0rnXAgg0oiGDA3CiMv+dflAGZqU4a2AC/dQtSdZEVqNpBOUBFs9Q5sEZ+s89hAllWoCawSZUleaGfoFKETWAqHKwpo9xQt1sFdYvQav280UdJ6oBq86GrDn6HkvNkAnnjTj+zUpAlGZuACYVowk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaH4M4WT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaH4M4WT"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a58eb9a42d9so884048066b.0
        for <git@vger.kernel.org>; Thu, 02 May 2024 19:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714702008; x=1715306808; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9epNSOmkyxN/Ec7t1id64vJGgasoMK/ZIoCvcza1Lpw=;
        b=QaH4M4WT0N+SILZXizrQ007A+bWTOhp0XPQ3rxEMlPw7KMwSpjPCGVK5Gsl/EWliOB
         M4rWgASM5FpFZ6qwp5Tm1RzE0eDb3x15z5eIkAtp2Dp6DJAhVXDdTgpTCfZwE3htmNSH
         sm8OgLRZVQmhyy3ersEXsWdo0jMW5ejwGAdtIj+3kNXG/+7RcieUyMCmVnic+ifadTfd
         /qMmkmReiJpy0sVE3/UYc4WVBg046Dw3qLKs716xFJZrstocKX2BAxDQ+WO1vEerLDXS
         kjYg22QtDWAu0N7rQ7LFKcPJ10h59w6FkL88DVg+Mu4SEdAmWVw1FNUlu1TAdijlkA2o
         846A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714702008; x=1715306808;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9epNSOmkyxN/Ec7t1id64vJGgasoMK/ZIoCvcza1Lpw=;
        b=jKDFvhRwoE4M6JEeIuCnWRkxD055dFGJpvb4zPKJdTHMzk20htPbPHjxTDk3shyedf
         drhaMKjZ9sgeswAhP7HhArcCB7IoPS8NiDjIYRY1TGss6MgUvhDBDG5PV9gRd2bVmjql
         GCVQTMaIpgdRdtpEO6VU7Ih5c1BhfJT9PAHbljZtrVoSSVHA3AEDXT+Sk8rmcSgR6im+
         NUaW6QMpvvCXUbcDjRcNQAPVkDcPoucM5mYPCx94B4CmQ7gxgg718YJH383qj2tViAlH
         Jvf45WResUSDW9BM0WFQZ9PwsIg8Ue3twudx9u2I5I4YTsqsnMbdp4egxdRAUp3HtbfI
         0Jsw==
X-Gm-Message-State: AOJu0YwWT8C+KryWU6zHHKlQK+OtAOl+YGggB3mtlBBeTP3wEQgZPeWT
	POLSATsCc0UwP7J4e+YN91VIBzlz4dZ2DU/80rwwMa5PolGJgmyIVbUO+dHWjEbkB3cAcFNMJyM
	dq9S5GsxytAF+zZiJF3bwO79l4fIlelpN
X-Google-Smtp-Source: AGHT+IGgxxCyBKg8dTAiGLKBTKI+HFmiCZwuYeYz+8DyJu56UzAzjkMyPU43nIppKczYFyZafV5M9vIMDQ+yJlV5b6A=
X-Received: by 2002:a17:906:35da:b0:a58:7832:c278 with SMTP id
 p26-20020a17090635da00b00a587832c278mr751065ejb.63.1714702007910; Thu, 02 May
 2024 19:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kang-Che Sung <explorer09@gmail.com>
Date: Fri, 3 May 2024 10:06:37 +0800
Message-ID: <CADDzAfNz3R5yj1SdJYbBe0f8m3Sp-R+X6dRpYoJ8Foj6zijcDA@mail.gmail.com>
Subject: Combined diff format: Show all filenames by default?
To: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear Git developers,

I have a humble feature request, perhaps to address a usability
problem that annoyed me a lot.

When Git shows merge commits, it often present a diff called a
"combined diff" format. The documentation has an example
(https://git-scm.com/docs/diff-format#_combined_diff_format)

```
diff --combined describe.c
index fabadb8,cc95eb0..4866510
--- a/describe.c
+++ b/describe.c
@@@ -98,10 -98,8 +98,10 @@@
return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
 }

- static void describe(char *arg)
-static void describe(struct commit *cmit, int last_one)
++static void describe(char *arg, int last_one)
 {
+ unsigned char sha1[20];
+ struct commit *cmit;
struct commit_list *list;
static int initialized = 0;
struct commit_name *n;
```

The from-file/to-file header is my main concern. It shows two lines by default:

```
--- a/describe.c
+++ b/describe.c
```

Although the documentation says it allows `--combined-all-paths`
option to show all N+1 lines:

```
--- a/file
--- a/file
--- a/file
+++ b/file
```

Why isn't this the default? I am requesting it to show the filenames
of all parent by default, for the line-by-line combined diff format.

My reason for making it default:

1. When the format is an N-way diff format, we can make it obvious
that the comparison is N-way, not two-way, by listing more than two
filenames.

2. Even though the duplicated `--- a/file` filename lines might look
redundant, it's the _number_ of those lines that matters - how many
files are involved in a diff comparison. (In contrast, showing only
two filenames is confusing.)

As the "combined diff" format is likely to last for a long time, it
would be good for Git to set a right default for presenting this
format.

Thank you.
