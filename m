Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EAB2F0681
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029257; cv=none; b=ZxLVps3xYKZ+CgALQBq3NawC5med/zpVWyWro9DGeCYjQhTnlsuRsI9+BY28Z9tvPwLy5XNt6GDO9kJShjguGygMtHjDy94OS7pBdLJ15cioRo2IuRiYJpEmpuu7742BKAO2kg2dq4ytiZIcichkQmrHvi+32HpZeNki7U4mZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029257; c=relaxed/simple;
	bh=awV2yBlnTdIXe0T5n7J9Hv6osLnt7OW0d8XiD8pjxlE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Njwy1xIRyGIfQgLLmKuaf7O5+JCufRVJkNlndDHenD0Yf9m2lGw8SvZVBUgqYlzHV2dTl/e7GDF+SzfL4RZQ+JAzAtN+m0rhawcg1ZmKhVM8Do2XTRXNtFxjOYGHiXHCIbLQwcQMMi2H5LuDIGc1iVRKmW4FGZG+VusV91wdnVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpYYAjiJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpYYAjiJ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9170db547so104151f8f.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755029254; x=1755634054; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOBCvD2LVrl764D9p67V+jeDTKx0VxtxCT23k5zDDbs=;
        b=JpYYAjiJ983Bm3kQGzf1m9H4F59Xi7beDpo8o7pfd+idjehB9VG9o+iG2pfWT1QfEh
         UsLmpFyUFXRZl7UX77Ek72+K5w9+ZbbQEb1Ux2xBq8p/t+u8/WXwjDQt+ejSNs6us1NI
         6+NkOXBYIBhThNnkMoPD4Ha9bkWRdiZqXdn+bW1stIl2ylE/Q9i9/tAmHCkXzXrmj+xX
         BeuxhQz6VN0fUDWE8Lw+2IHnP35NBJqlf4lKy9MpMlwyoSVpP7icsDCkx+4kp2wU+iIY
         4LhAqYIuJrfFqy+/Y0X9r88MBO52cwbOEPu+fXrhyOCV8DXvLmjejCCHlQZWKRFhNxKw
         y/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755029254; x=1755634054;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOBCvD2LVrl764D9p67V+jeDTKx0VxtxCT23k5zDDbs=;
        b=izO2egnCAvLUio/1phqx+Rm/Lw1mwgcNqxkNlTXj51DOyMNGKqITnib1qeyJD0FVIE
         QPSjx4dc6zhJdZtfTNt5A5IZmqtlJfxf+NjPMjgjE1nXqQMcrWxqpZIS4+G6Mabm294y
         MWX4/KvzV3bOKTlmTorYdo/KBr7LAgeE71OEic7ZEEzX0jQnTJqmBiYl2fp5r0vDue/2
         m6YQLM8LB9hpQb3p5wT37OQgIbUHkDca2Gzcd8gIyeE88Ueq6tTY9nG3kVCUDhyxaZPN
         uPewAsEI0QJs4aaj7X1MqTvlIUKiwep0U9NB4opcgLsqQBMhvwzClAQ+FigH5BKyGLMH
         1IBQ==
X-Gm-Message-State: AOJu0YwtEfJNEXVH6iU6oo8SHpeyE5EXaOgGk5SSyYDb0zsFAURgXrOJ
	JOwAzTcXKfx6LOgbd6Q29oxhDshyXBHzlbukDAFu1Kfo0gpw+ByzQ4yPOVG5NQ==
X-Gm-Gg: ASbGncvUsmahWPkWvAl6Qp7+6XNfMdCQF7HJxjAGeJK11ecqawOMjusS0o+IpuoT0ux
	LQxQ5K6bDKwgfDKQ03pLHDEHh37jqTbB4XjmR8094eiRcmIOlkyq0ZnYYh+8IgpxJ8F5CRsQ3LQ
	7JqOEYCwhB5LFvbHb+BYOwMcpCk/FCEkHPI/U4uu9ctYmdImXI+QhZsYFh4itVBEJjSdMz3Jw7S
	w1k9a+6QAQ3y/Z4DuK0RTVa58BK9utuI21DGJ/21T6FgSwU0eMDrOTVa94wdqWGsjSkkPQpM5mN
	814qQ9zuMfWUjhWwNkZQphQuMW+bn5B2DLucbc+z2bqaoRg/N4K0P3k/t3Urf83/LG2mO4L8Sfh
	eNArDL+htLnfFi0OmOLtrvXw=
X-Google-Smtp-Source: AGHT+IEtsyiRskkOV9cR2c3g4LK3fy+VcBke1ARGXbavbztAYhLXUw07CHECa1G2eae8QpNd4v3/Kw==
X-Received: by 2002:a5d:5f88:0:b0:3b8:f864:9a19 with SMTP id ffacd0b85a97d-3b917205b0dmr522644f8f.22.1755029253878;
        Tue, 12 Aug 2025 13:07:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c46ee84sm44188921f8f.57.2025.08.12.13.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:07:33 -0700 (PDT)
Message-Id: <34b09deb61abfee8146cbbd6e1583c1c43fda197.1755029249.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 20:07:28 +0000
Subject: [PATCH 4/5] doc: git-add: make explanation less dry
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- use examples
- mention `git diff --staged`
- link to git diff man page

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-add.adoc | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 0c4ca1794c91..77cadbfee8e3 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -26,13 +26,13 @@ You can also add only part of your changes to a file with `git add -p`.
 Please see linkgit:git-commit[1] for alternative ways to add content to
 a commit.
 
-This command can be performed multiple times before a commit.  It only
-adds the content of the specified file(s) at the time the add command is
-run; if you want subsequent changes included in the next commit, then
-you must run `git add` again to add the new content to the index.
+`git add` only adds the changes at the time that you run it. If you edit
+`file.c` after adding it, you need to run `git add file.c` again before
+committing.
 
-The `git status` command can be used to obtain a summary of which
-files have changes that are staged for the next commit.
+If you want to check which changes have been added, you can run
+`git status` to print out a summary of the changes that will be committed
+or run `git diff --staged` to see the full diff.
 
 `git add` will not add ignored files by default. You can use the
 `--force` option to add ignored files. If you explicitly specify the
@@ -443,6 +443,7 @@ linkgit:git-rm[1]
 linkgit:git-reset[1]
 linkgit:git-mv[1]
 linkgit:git-commit[1]
+linkgit:git-diff[1]
 linkgit:git-update-index[1]
 
 GIT
-- 
gitgitgadget

