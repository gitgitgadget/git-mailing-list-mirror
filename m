Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8538C483BF7
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206760; cv=none; b=Cv3ZY/HgFllrPGXx2ZVBImxlurowJnUzA+ZLhTb3dFFFCQCujTgWqeOllslqzeY1ukQs1yO0XAq+uWBItLilOowaYQOWAvyYKr3iJpr76fwewJzsboCIFyXtwG77ftmrj/TuBDqGISwStsSDQ6nG4iNTI8eKyxSklxyW42OwaW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206760; c=relaxed/simple;
	bh=qJc2Jlw0YwWTz91df8WlVW/Ll8J+iAPmVjOeG2WI3AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+p5JtYsyHdmh67TqWsHlu59KzQOm7vfk09Fs4XYAG63uBK9Fse+t8m3XaD+QpQNiuqMv0Q+kGp2u2nzR9iqNM07hVaUor6E4qRvCbyz5VKq8m98uMYekjfWmLkIdOa7lP/HjzngaJe/2m+pFmlZpv0aOnxKsOLAkvGmh27bmkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im1ghZL3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im1ghZL3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so18466635e9.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791206701; x=1791811501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ASFgvpZyUGEuWH8rQMCQtZD5AbRRm3mVWYSwfOqWPqA=;
        b=Im1ghZL3b4gNbuQKCpcYv/EvRmUUvHJjx5SEcET2hMYzEtn9AvQG5E1FgJUTq9eKuF
         1J+bNjicvXcsZpW22ZnAlOcFHwB9aMqu58qrzMmcVNWh8Ae+BLY9UaBT+MT5wzxx2ALy
         rYBctkNLHIFdN7dbOu/HW7EqynJNaUc0n7JNh3FYwKbP+8btgP2ouO12gIHCvvFOiwGo
         gDP7UnemY7vDXsYs/S2WUVC0KELwcX/jk90G9TgBr6YAUFSN5f2E6da0T/weSoIocpLl
         K6IJNhOTAFTdM06SqIKGE7L21tvc5U0Nvw9yzLseXnPpvE3DlqgEFDR2Kj3jODmiH2+6
         jm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791206701; x=1791811501;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASFgvpZyUGEuWH8rQMCQtZD5AbRRm3mVWYSwfOqWPqA=;
        b=cJRFBYvdkYB/VixtlK5O7UQYbCoaa+8bm4f1zo+qEeCxnbnY0/MVnUoEzswmJLh+Xt
         CXFSCAjkK/miuCMTL5f1dter/LpCpcwyEweItONq2Vy/j5XVhbE1fZt6tPBfOAt/+JZw
         oe7ZuiVlC34AUFSxPGPJv7VKChYfVcyMy7DJmbExet0SvVQNP237y0erJDtuNlDT0keK
         JMhG4wv6aBgOuDlNRJRAAaPy2PUqoJVX/9Vs5lhtC7rBe2nEBr8ChqIEsDIKMD0I0CHO
         yA3Hhf7x3mFD8guNrJVzFMMJH6BvaKaWqeRHzKZBvsRk5Gyde1hUnqCpvqhOImqL5Q6X
         vsng==
X-Gm-Message-State: AFuF++kCzikAFO8mNxOVHWRc5X46e5ErmVqiPQKOoLM36DsdNOLNY9u6
	2K/8h4jaCwg7jPSRGRmRRiJtxZTZZfhRihc9NwkKxxL4Thpz1u8LHGf7kb7YmxV3
X-Gm-Gg: AYBFou3ZI7YCX8GteBzoUeEs8wpM9gaTv7XKmcx4NUouWJ7KwbfJ+Lre9MjmbuXyIrr
	b/zNAs4CwtQtPrdbzKO4VCmRAFzRn0kqNQsu2lnP6epbrt0LzJ9jMU7G9ttbVvJIjKdjdMhN1R+
	jeoFUVp/J67bxnszRgPfH5OOKEIkFgVxi0HzqVfm5s8yH+/n2c6YjwZ0PeeYnsUys5wF3Sa47KQ
	GWh9z50+MRsObpL2BJluq3ptzhZwO9cJwNWzhnsAnM8LoV4b2Tsh13GaWksFkan5veNpDhsy5ML
	pZLbwShao0mniwBqy/62vUHMrLdBTbY7HH+SozxYUHM4n1qA96O5/Fju8kNk/8HkAnk9ctDHkqQ
	RbJx8GIxTazPYed2Zucq7AfQCeGOW4aUFO1ffOsa6N+LdVuvMazHMUWwkGB8Y5ekXvSX428XocU
	Kyi4EeWq5w4UdN0+xRcMxGp/zHxqwrq3mFLLAZPWwTGz4iVPFnvIoQqX1INP8CGvfhKl8xq6d7n
	WI=
X-Received: by 2002:a05:600c:e557:20b0:4a1:73b2:aaaa with SMTP id 5b1f17b1804b1-4a173b2ad0dmr23059605e9.13.1791206701112;
        Mon, 05 Oct 2026 06:25:01 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280b2e3csm398123325e9.5.2026.10.05.06.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:25:00 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 0/2] checkout -m: recreate conflict labels
Date: Mon,  5 Oct 2026 14:24:47 +0100
Message-ID: <cover.1791206658.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "git checkout -m <path>" recreates a merge conflict, it uses
the labels "base", "ours", "theirs", rather than the labels used by
the original merge. This short series teaches the ort machinery to
write the labels to ".git/MERGE_LABELS" when it switches to a merge
result containing conflicts, so that "git checkout -m" can then read
that file and use the same labels.

As "git checkout -m" is recreating the original conflict I wonder
if we should remember the conflict style as well so that

    git -c merge.conflictStyle=diff3 git merge topic
    git checkout -m <unmerged-path>

would recreate diff3 style conflicts, instead of using the default
config. I cannot decide if that would be convenient or confusing and
am interested to hear what others think.

Changes since V1:

 - use strbuf_getline() rather than strbuf_read_file() to read labels
   so that the newline handling of the reading and writing sides match.

NB ".git/MERGE_LABELS" is still undocumented - I'm hoping to find time
to add some documentation for all the MERGE_* files in a future series.
Johannes suggested using an index extension to store the labels,
but as we already have MERGE_MODE, MERGE_RR and MERGE_MSG I think it
is easier just to add another file.

base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fconflict-labels%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/3bc034112...18bdf7df4
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/conflict-labels/v2


Phillip Wood (2):
  remove_branch_state: convert boolean argument to flags
  merge: remember conflict labels

 branch.c           | 17 ++++++++----
 branch.h           |  4 ++-
 builtin/checkout.c | 30 ++++++++++++++++++----
 builtin/commit.c   |  1 +
 merge-ort.c        | 19 ++++++++++++++
 merge.c            | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 merge.h            |  4 +++
 path.c             |  1 +
 path.h             |  1 +
 repository.c       |  1 +
 repository.h       |  1 +
 sequencer.c        |  1 +
 t/t7201-co.sh      | 21 +++++++++++++++
 13 files changed, 154 insertions(+), 11 deletions(-)

Range-diff against v1:
1:  86ef0f848a = 1:  86ef0f848a remove_branch_state: convert boolean argument to flags
2:  fdaf3da993 ! 2:  18bdf7df49 merge: remember conflict labels
    @@ merge.c: int checkout_fast_forward(struct repository *r,
     +	return 0;
     +}
     +
    -+static int parse_merge_label_line(const char **p, char **line)
    ++static char *parse_merge_label_line(struct strbuf *buf, FILE *fp)
     +{
    -+	const char *eol = strchr(*p, '\n');
    -+
    -+	if (!eol)
    -+		return -1;
    -+
    -+	*line = xmemdupz(*p, eol - *p);
    -+	*p = eol + 1;
    -+
    -+	return 0;
    ++	if (strbuf_getline(buf, fp) == EOF)
    ++		return NULL;
    ++
    ++	return xmemdupz(buf->buf, buf->len);
     +}
     +
     +int read_merge_labels(struct repository *r,
     +		      char **pbase, char** pours, char** ptheirs)
     +{
     +	struct strbuf buf = STRBUF_INIT;
    -+	const char *p;
     +	char *base = NULL, *ours = NULL, *theirs = NULL;
     +	int ret = -1;
    ++	FILE *fp = fopen(git_path_merge_labels(r), "r");
     +
    -+	if (strbuf_read_file(&buf, git_path_merge_labels(r), 0) < 0)
    ++	if (!fp)
     +		return -1;
     +
    -+	p = buf.buf;
    -+	if (parse_merge_label_line(&p, &base))
    -+		goto out;
    -+	if (parse_merge_label_line(&p, &ours))
    -+		goto out;
    -+	if (parse_merge_label_line(&p, &theirs))
    -+		goto out;
    ++	base = parse_merge_label_line(&buf, fp);
    ++	if (!base)
    ++		goto out;
    ++
    ++	ours = parse_merge_label_line(&buf, fp);
    ++	if (!ours)
    ++		goto out;
    ++
    ++	theirs = parse_merge_label_line(&buf, fp);
    ++	if (!theirs)
    ++		goto out;
    ++
     +	ret = 0;
     +	*pbase = base;
     +	*pours = ours;
    @@ merge.c: int checkout_fast_forward(struct repository *r,
     +		free(ours);
     +		free(theirs);
     +	}
    ++	fclose(fp);
     +	strbuf_release(&buf);
     +
     +	return ret;
-- 
2.56.0.134.g299a3c16181

