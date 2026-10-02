Received: from mail-dy2-f40.google.com (mail-dy2-f40.google.com [74.125.229.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14241A501
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925218; cv=none; b=BW5E57lvq72sAGqidmFDQ3pJMDLzZRUpYrnoWyVTpuuA0nCFX3e1Ffl6SF3y+mkLVqKoyrxWI8zdrmQjAMgnxJFLeqGqhIsXQnJMNfhSB8yD63DVqzOLaExA+6nbuXICqhNijUisIdfqdHIb/XXG65RnuTM5I6UfGcCWDzsqi0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925218; c=relaxed/simple;
	bh=JB2qh43jJmR2/5EX0tzAwNASpHp9OSxQ4sNUChn5fsE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J87vTVw/fl9qPen8GbIZLfHAtfERelzBVYQdeZIGU0eSM4BijRWWVqwOIgdWevu9ZONnLxmJ9+NEcz9zH2lWDfYPtgZoWxwRts0cIxpcqzMtBZ3JM9//C1jCmY/VTSGX7nkJ1o70l36MJEkugA1A9EB+eZ7lK3q9gxN93MBCaV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLWW0mUJ; arc=none smtp.client-ip=74.125.229.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLWW0mUJ"
Received: by mail-dy2-f40.google.com with SMTP id 5a478bee46e88-34ea9118159so1516311eec.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790925206; x=1791530006; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WjPYx15o03uwEdtTOFRbD0WUNn5K/qR+N10BFAyuwLk=;
        b=LLWW0mUJbhe3fcDd8s6bxlNJ5WHTUCm/Ri8/xbDsh8gZPLIlh2dmIRtX/RiAUtHSH0
         QM7G+FDZfTOTtuz8JebP+f3wbGhXtQNRLiJhesAuXMboeqCtEKcJ3C95NeZtOQwZaM5q
         L2np9kppnICo34+UNVVw3Vy4WGAt11s2GCiVdYpxIQPN5CUUydweLJRWUXizjUFlEhMB
         HdDMfUsAzhiNnn6wAo4S3c2e+4+sTIzqZB/C/vOs/lOYZhvfsX4T2OTbvFik1EOaK2NT
         AaA9odwS3Bh7FQhdhwujaKf1Hx95U4l6/LN5S/IWr58KJXqJwkGe+nak0qRu2U2xdj0R
         5FUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790925206; x=1791530006;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjPYx15o03uwEdtTOFRbD0WUNn5K/qR+N10BFAyuwLk=;
        b=Ku2omoykzO53lEkjlG4cMPrxHRdKxIFoyGwdXu09l0BHLtWrBLa3aVRf9milH7GA3i
         +VdAAXrgbxwmHBX2vXphRUdsRFV/TEUfYyZvip6R4/990ix8V3Ju0mBekAduLa4+FZyO
         rifDRAnj8S8XMC/gS7auPp4zZARYVJmm6dQVYhdtITy2K6I2LcuPHKe3FDLTi6NE5nMU
         u534IZx+l9argPb/PnIaFLeS2eG5v3a4VFf/mftYPPBD0UR2o8f7N/8ufne3WqBHK029
         6Im1aIA03RYIwQrLQyk1QgrL2uyeKkprmlUSOdZLhUMRKgOQjj49TgT05wc55xiI0TOW
         qbYw==
X-Gm-Message-State: AFuF++nAS/32lXStfuSujUc3X2r09rC9YIAHC39DW5AMRP19djr7+sIo
	jt9gV9ZeJ5tGX9xD9PeZw/2zq5MLFdyWAQJ8MewgrZ1lLzDUM7/nLL+ZyG1ShA==
X-Gm-Gg: AYBFou3tPtxpeZKKCjF55fDe2wiTCLr/kIyZSlBQGyBjkEukWPsYpXD6MwsOmPPO9L/
	RKqr65pzPYT2K9RUInbsCoVK09qVnDxDHNgTh2LIVaarz0SOITGBBYu5YuDuHgVAHK9vA1YCZgN
	JUM+UIbe+2MkMyPg7pZ8lgmmNmRvYRqmGKxUengShdH3L8UqS3Q12kGV35wNxbldaRZnNW9JUH1
	vvgCb70juVP0F8hPCMtw4kVKD4jPhQwRcoZqr0V3W71/ORaImCPqQH3oMPHh4YdJ+TtUCin//3V
	3kBEMMtBU8kVJxRN0D90yMhraX2msWiBCAvc+ImETWKokt2A5ZCQ/F4TQZBFPx8KKU89fMPx5EU
	f1XMUXB4x5+HzUYEz/+4GBN8BHWF6l6i0roLm1RUrM7Uh1TOXCtx3jG5WfCWW/dL5O1Ik8BHFv1
	PcMr9B2X2h8ATHnqhnJUh6akVuQw1KrdF/G2jjkspOkca3AxDBHA1xb9C167S54/FkFamhZNtyv
	A==
X-Received: by 2002:a05:701b:2908:b0:149:50cb:2175 with SMTP id a92af1059eb24-14f5c2f1512mr1765359c88.33.1790925206088;
        Fri, 02 Oct 2026 00:13:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.209.71])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f45fee0afsm4478087c88.5.2026.10.02.00.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:13:25 -0700 (PDT)
Message-Id: <8c2a144eb7d9010ce1239d92aadd1288108921c3.1790925198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v5.git.git.1790925198.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v5.git.git.1790925198.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 07:13:18 +0000
Subject: [PATCH v5 4/4] remote: default to --limited-fetch in a shallow
 repository
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Adding a second remote to a shallow, single-branch clone used to
still fetch every branch that remote has, since "git remote add"
always set up a wildcard remote.<name>.fetch refspec regardless of
how shallow the repository already was. That defeats the purpose of
having cloned shallow and single-branch in the first place, and can
make a plain "git fetch" on that remote hang or take a very long
time on a repository with many branches.

Turn --limited-fetch on by default when the repository is already
shallow and neither -t/--track nor --mirror was given, so that
adding a remote there does not by itself commit to following every
branch it has. --no-limited-fetch keeps the previous behavior for
whoever wants it.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-remote.adoc |  8 ++++-
 builtin/remote.c              |  5 ++-
 t/t5505-remote.sh             | 60 +++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index 4255f8b3e6..80f8a4a183 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -52,6 +52,11 @@ Add a remote named _<name>_ for the repository at
 _<URL>_.  The command `git fetch <name>` can then be used to create and
 update remote-tracking branches `<name>/<branch>`.
 +
+If the repository is already a shallow repository (see linkgit:git-clone[1]
+`--depth`) and neither `-t`, `--mirror` nor `--no-limited-fetch` is given,
+`--limited-fetch` is turned on by default, so that `git fetch <name>` does
+not need to negotiate history for every branch the remote has.
++
 With `-f` option, `git fetch <name>` is run immediately after
 the remote information is set up.
 +
@@ -74,7 +79,8 @@ With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
 that tracks all branches, `remote.<name>.refmap` is set up so that a
 refspec-less `git fetch <name>` only fetches branches our local branches
 are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
-details.
+details. `--no-limited-fetch` explicitly disables this, overriding the
+shallow-repository default described above.
 +
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
diff --git a/builtin/remote.c b/builtin/remote.c
index f036dd5d6f..0cf1126976 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -16,6 +16,7 @@
 #include "rebase.h"
 #include "refs.h"
 #include "refspec.h"
+#include "shallow.h"
 #include "odb.h"
 #include "strvec.h"
 #include "commit-reach.h"
@@ -238,7 +239,9 @@ static int add(int argc, const char **argv, const char *prefix,
 
 	if (!mirror || mirror & MIRROR_FETCH) {
 		int use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
-			limited_fetch == 1;
+			(limited_fetch == 1 ||
+			 (limited_fetch == -1 &&
+			  is_repository_shallow(the_repository)));
 
 		strbuf_reset(&buf);
 		if (use_limited_fetch) {
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 0168d5abfe..f3b5905e9e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -137,6 +137,66 @@ test_expect_success 'filters are listed by git remote -v only' '
 	test_grep ! "\[blob:none\]" out
 '
 
+test_expect_success 'add remote -t keeps an explicit refspec in a shallow repository' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add -t main upstream ../two &&
+		test_cmp_config "+refs/heads/main:refs/remotes/upstream/main" \
+			remote.upstream.fetch
+	)
+'
+
+test_expect_success 'add remote keeps the wildcard refspec in a full repository' '
+	test_when_finished "rm -rf full-add" &&
+	git clone --no-local one full-add &&
+	(
+		cd full-add &&
+		git remote add upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.fetch
+	)
+'
+
+test_expect_success 'a remote added in a shallow repository defaults to --limited-fetch' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.refmap &&
+		test_must_fail git config get remote.upstream.fetch &&
+		git fetch upstream main &&
+		git branch --set-upstream-to=upstream/main &&
+		test_cmp_config upstream branch.main.remote &&
+		test_cmp_config refs/heads/main branch.main.merge &&
+		git fetch upstream &&
+		git for-each-ref --format="%(refname)" refs/remotes/upstream >actual &&
+		cat >expect <<-\EOF &&
+		refs/remotes/upstream/HEAD
+		refs/remotes/upstream/main
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--no-limited-fetch overrides the shallow-repository default' '
+	test_when_finished "rm -rf shallow-add" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		one shallow-add &&
+	(
+		cd shallow-add &&
+		git remote add --no-limited-fetch upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.fetch &&
+		test_must_fail git config get remote.upstream.refmap
+	)
+'
+
 test_expect_success '--limited-fetch works in a full repository too' '
 	test_when_finished "rm -rf full-add" &&
 	git clone --no-local one full-add &&
-- 
gitgitgadget
