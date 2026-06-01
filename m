Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB83CAA54
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327349; cv=none; b=akT+HxBdZYIxL9KzZvyZ21nFfxqirK0mEMc9XwgAJrw++WnvLpGUCmSCKno2MieZGMg9fRw4avNFqmHYX6I96Ld8IXEHXWkNv0535OkWNxBF5QkLmkZDFaHOyMcvX3lScR3ZzwZH7oUrvR11i/G6OKgNcdn2JNYpk1Dan+dRW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327349; c=relaxed/simple;
	bh=JtZ154cUxIDvN4q79Y31zlsA7daSUz3/abG6xyy+Ll8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGBG3GYz57U+gGBKhEkfblUvALX8JilaQMkd/IbLG6f++cl0Y1Yj4rlNZtlF7HU4Iyi1FyDCAcYFNLhTLUPcukq44ZdOMiF8bs90TG1ZO7E1VixobArp/Qzqlf6WlF/gOlWY7fbU5cxGa+e3AJN6ko1z0Y/boMkaDxBzyca36TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fzo+qmPw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzo+qmPw"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-842319576d5so782019b3a.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327346; x=1780932146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uz15SSlegH2g+svRJH3CkjBytCvtwgzGNFxROBXqFY4=;
        b=Fzo+qmPwud8AYnpUN6unskrSHKbAPrPmHSC62d1U4MdK6PfKSzi+uBvZL+s+r/+M6Y
         kiGFYdxbzzbRbI6ViS3fS3z1Dg/bzVeLSlMQudRhkC9WYkVq2cw0wLx3patfLnE8UaBn
         P1uoED4VR8Ja4rsMVgYxnYju1QOEkVztNHyaX0OrveldFDAJsy1rdYeotQp2iHBzImyH
         HKykpYhbgimOcMyMb6dfDmK1PWfFRJCV6jgS6qfTlNUw4Uk8TDPuM2Gom3DbQkzneUzH
         m1kOc66302fTBl79q1UNv7QV+mtDkNqB8nAsDRU6TF6Lhijjd1gy2w+goSTQrCKPt7ss
         oMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327346; x=1780932146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uz15SSlegH2g+svRJH3CkjBytCvtwgzGNFxROBXqFY4=;
        b=dOI+UQUj/qYkDYqja9C6vaNRy2/8jvHihJ9D0iNb/JMxSO6ieKouAa+3lsoR24jN8P
         R31AGLbz/2TI/jU66j/skvTXM7sBXOumeIo3pHWyCIgdrbqQbhV+3gDtJJokas/TZTCE
         /xwXbQUen2cZXK/klkKzHRu3f37kkUsORXHrcx2vwRAFoqabmt8/HHVh8GerE/txZ+So
         UcwyveMfrKszc9lCmKYC16hIiRYgbiWDYlXaotniGEQCAn3IbBSwFh0ys+dIfKyeq0RD
         w0Fgt4+6blvoPMScoc9DZzyfKGp2zildvk1k4ulwD4gAkdF1NvZo6ypfMiaC2IM0LZja
         QySA==
X-Gm-Message-State: AOJu0YwghhYaq11PeuRmBozaBkzAc0xgKidi6IG7614Kt5wMm993KCem
	CMrpmhgVCIZ7PBECykyPsKXHuZFLk//xr0Gage04Nz3AGYowfBg+oZdo2izu5Q==
X-Gm-Gg: Acq92OGZO19x1DSK4eDQyUNrsnPw53nNcrvzTpMVaexh52Q4gmLxnQFDJ6azSKE+7oA
	O9vVACGwQUxyMnWenGBohDXcBTVk/qDByhJs+YaJuHPJ0NU/rwo1Tp/Itgbtlz45IkE6V8ZmEKr
	3ohUJUKf7Xa3UuHtzvuFOEb1ni/CVw4PGXXHXKqCjiPNqZWCbYZlWdeNbNmut14dP9r5LayDE+B
	qoC5YbMn6OpL2lbmRAb01cpqyCPBjPi6VcAFWK9cFQq1fZmXqNLx7Dr5Z+iSW/RSQo1YPR/9HCU
	ZQFZnXAn5yL2EiK1w3ditqlwRFbpdyTBaV7iavdNhV52XaAA/ImOBJnuLm3KvDCdyHi6Hki1Iyx
	j7J9p7RKJkzQf13j1ZKrNDcxZiqN2om/+SxLDgDjY/t4K0kuGzjV7Au47s2OBIuPHMOl6j9OISe
	yuoviFOmiLJz4TCTvBW8G1AAhMHHDCT1zJuqkeXs7dWIn5YbNxQAsZMd75Ybjc/YopwTpczfLM+
	yNmvt3hVwq8BX9CXMERlBVzoUqlKmYpMJDcPA8+tj2W
X-Received: by 2002:a05:6a00:1485:b0:841:f876:a899 with SMTP id d2e1a72fcca58-842251b44a4mr10589652b3a.0.1780327346287;
        Mon, 01 Jun 2026 08:22:26 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84232ef8172sm7352779b3a.12.2026.06.01.08.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:22:24 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC][PATCH 3/4] repo: add path.gitdir with absolute and relative suffix formatting
Date: Mon,  1 Jun 2026 20:49:49 +0530
Message-ID: <20260601151950.30686-4-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce path-related metadata fields to `git repo info` by adding
explicit `path.gitdir.absolute` and `path.gitdir.relative` keys. This
replaces dynamic prefix parsing machinery with individual, predictable
lexicographically-sorted keys that map directly to dedicated formatting
callbacks.

To calculate paths relative to the current working directory, update
`builtin/repo.c` to include `setup.h` and supply `startup_info->prefix`
to the path-formatting engine. Both explicit variants automatically
populate bulk dumps via `--all` and output predictably under `--keys`.

Update `t/t1900-repo-info.sh` to use a modernized, function-based loop
helper (`test_repo_info_path`) and `test_grep` to cleanly assert separate
path variation lookups.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  6 ++++++
 builtin/repo.c              | 26 ++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 31 +++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 42262c1983..a0dca7ce88 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -104,6 +104,12 @@ values that they return:
 `object.format`::
 	The object format (hash algorithm) used in the repository.
 
+`path.gitdir.absolute`::
+	The canonical absolute path to the Git repository directory (the `.git` directory).
+
+`path.gitdir.relative`::
+	The path to the Git repository directory relative to the current working directory.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 71a5c1c29c..c141ef892a 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -7,12 +7,14 @@
 #include "hex.h"
 #include "odb.h"
 #include "parse-options.h"
+#include "path.h"
 #include "path-walk.h"
 #include "progress.h"
 #include "quote.h"
 #include "ref-filter.h"
 #include "refs.h"
 #include "revision.h"
+#include "setup.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
@@ -75,6 +77,28 @@ static int get_object_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
+{
+	const char *git_dir = repo_get_git_dir(repo);
+
+	if (!git_dir)
+		return error(_("unable to get git directory"));
+
+	strbuf_add_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_CANONICAL, PATH_DEFAULT_UNMODIFIED);
+	return 0;
+}
+
+static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
+{
+	const char *git_dir = repo_get_git_dir(repo);
+
+	if (!git_dir)
+		return error(_("unable to get git directory"));
+
+	strbuf_add_path(buf, git_dir, startup_info->prefix, PATH_FORMAT_RELATIVE, PATH_DEFAULT_UNMODIFIED);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -87,6 +111,8 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.gitdir.absolute", get_path_gitdir_absolute },
+	{ "path.gitdir.relative", get_path_gitdir_relative },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 39bb77dda0..7c7dfbb052 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -155,4 +155,35 @@ test_expect_success 'git repo info -h shows only repo info usage' '
 	test_grep ! "git repo structure" actual
 '
 
+test_repo_info_path () {
+	field_name=$1
+	expect_relative=$2
+
+	test_expect_success "query individual key: path.$field_name.absolute" '
+		(
+			cd test-repo/sub &&
+			expect_absolute=$(cd .. && pwd)/.git &&
+			echo "path.$field_name.absolute=$expect_absolute" >expect &&
+			git repo info path.$field_name.absolute >actual &&
+			test_cmp expect actual
+		)
+	'
+
+	test_expect_success "query individual key: path.$field_name.relative" '
+		(
+			cd test-repo/sub &&
+			echo "path.$field_name.relative=$expect_relative" >expect &&
+			git repo info path.$field_name.relative >actual &&
+			test_cmp expect actual
+		)
+	'
+}
+
+test_expect_success 'setup test repository layout for path fields' '
+	git init test-repo &&
+	mkdir -p test-repo/sub
+'
+
+test_repo_info_path 'gitdir' '../.git'
+
 test_done
-- 
2.54.0

