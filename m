Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3281261B9B
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770973982; cv=none; b=c5HSBT/kb+GqHyqHIjs8GWEW7qpLVu+pJuSZ4HbW2EJri1hySqpxdK12+EPtz324Bi96fVNlGKOg26H2EP6cU6vydQWDRjVjVGCyMbpzOgoO+nL5NyHCnBLiInYlLMH82ngR6BGvxDs4GW2Ezlk5QVXRMNXUZrmogXEzno9Ncjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770973982; c=relaxed/simple;
	bh=0t4WGfhA0xWYwTyi3gGY+wHSRO0BOeGrRvmIBdZER5I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=oYGgmFVzoJPUXa06USgM5rmzihBzGmDnWQtBlwQBQIzJoI5Jysp3CSyE7nkwMphq6lCQJNlWoSkr5AkyN8b7ln7ebqcpnO3fQC43C6d+EtZa2AVeL6Cin99yRTQYCr/csbDNJWbUXiG4gd7zi8ZllutKkGEL9cOXwZUv6ipRQZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ukjkkb0F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NOcv8IT3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ukjkkb0F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NOcv8IT3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 21A2414000CE;
	Fri, 13 Feb 2026 04:12:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 13 Feb 2026 04:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770973979;
	 x=1771060379; bh=Y1lLPop3LilMNA0TMC3JJnk33WOnSZ+Sk+bWTSWSnlo=; b=
	Ukjkkb0FoLKfhMKXf3x20Klk/LfwrJiEt+m84RJtIhxNAcEDN064KG8X7mlWZT6O
	Y0cmWvFtjUfGx/mwrabvnq38Bz3hW6ImDYJVEcGD1txLumRZ/EqtJIvVsk8RG4mx
	Uwns7MgCc/FLHs8Laf68g/J4J9JYO8w1wPYs+fB1TIRyYzUrAQnse2aJEwWeUenM
	V0OQ3Lc7P27xNXfWL+Zf5k4yMnDQ4uD7IOF4uYbhM8YFvA5LFaKzAe4YaWmTwF0c
	Vi708H3UWA9CjRMK3J6dg5zx7x3pGm5rHzBtTkxquuhP3ezJkOnfn+x/lV1/scZB
	9cIgG5/8cBrXl69NBkIVbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770973979; x=
	1771060379; bh=Y1lLPop3LilMNA0TMC3JJnk33WOnSZ+Sk+bWTSWSnlo=; b=N
	Ocv8IT36fCj20WVFDIBwgey1rKGnFC+iJX0yXD60rlJyMYtDu6+ZSBU0rknDqYuL
	+4FsRC58ZdIvmgl2wAF9K/0urIzhmKFaFWBayRdBP2ZDNOtCb1YUK52Z6NuI7cea
	zPPT1lkKDGKefnF9TZi2yuaJ31FybuwF6rso240wkVDST4Of+sPtdce2aRnhsiN+
	OJqTmXEYzFD1eKu4JAiY/b4exWCD6RqDURIAd77lLmy+5t34KuxJqcZPPCBcqW8J
	mL00W2FiA5w8cXgirp8niC3zTaGdKzPyLYrQijn5IqsIQe/RVETjkbmrqbMdh5yJ
	gjXpp6k/wm0z3QSg4rz0w==
X-ME-Sender: <xms:GuuOaSGCtPsTJOQZskUTfE-zidkbJEAQiw4GUAKGqezcKFd2BhUSHA>
    <xme:GuuOaawFA587Ec2Kd25Z3yzVImLiB59PPqFgOlqAvZ1NSSnJIYo596kEkixX03cAX
    ZpFe73ieRiFHuPQXXvnOuVDs0ko-et6gisgbF_XQbvFGIpCSNejUQ>
X-ME-Received: <xmr:GuuOaZj6bwJ_4N58110lxjhVmB_5G2Km064149hLKigG45TCgnSDvR-3Xc8ZDtl5KrpWp9vk_tUCc5tvogWDh92ma4fuSv5aAWJHr9J42NCf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GuuOaVzGvGGt1wOSK5iDPctHdUrB4kKFfdV8z3014gqbOIEPomLpOg>
    <xmx:GuuOacKYyEYKj1saoTa1ZFIodFBINURBTOHKAk4-zcYCMEkdW-A7Sw>
    <xmx:GuuOacTXEHZAPRf9ZChgPMC4pxl3d4Y7NC1zXv5DkzALa9iub0LXzA>
    <xmx:GuuOaUoAibXFHxe143sVLgPas6jSQwo0ttBohdCrye_E-y0SahqN8Q>
    <xmx:G-uOaez-48cN9KDx9xwh8ZnLGejNfEGFcZjvsLh-esVqTN73v33_PNGZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 04:12:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96a99076 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 09:12:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] builtin/history: some smaller UI improvements
Date: Fri, 13 Feb 2026 10:12:46 +0100
Message-Id: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA7rjmkC/4WNTQrCMBCFr1Jm7UgyqUFceY/SRZOMdhDbkmhQS
 u5uLO5dvMX3eD8rJI7CCU7NCpGzJJmnCrRrwI/DdGWUUBlIkVWkCV2Lyy3hKOkxxzeGqvickNy
 xVXwwamALtbxEvshrG+76yr/89pP11/07mTUq1J6VCdZor925pvZyh76U8gFJTXGxuQAAAA==
X-Change-ID: 20260212-b4-pks-history-dry-run-2b840e530ae6
In-Reply-To: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this patch series contains a small set of UI improvements for
git-history(1):

  - The first two commits adapt git-history(1) so that it performs
    verifications before asking the user for input.

  - The last two commits rework the "--ref-action=" option to instead be
    split up into "--dry-run" and "--update-refs=" so that the option is
    less focussed on technical implementation details.

I decided to send this patch series as a small incremental step before
sending `git history split`, also because that series conflicts with
aa/add-p-no-auto-advance.

Changes in v2:
  - Use `strvec_pushv()` instead of looping around `strvec_push()`.
  - Document that "--dry-run" writes objects for later use.
  - Document the default value of "--update-refs=".
  - Mention the subtlety around false(1) in the commit messages.
  - Link to v1: https://lore.kernel.org/r/20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      builtin/history: perform revwalk checks before asking for user input
      builtin/history: check for merges before asking for user input
      builtin/history: replace "--ref-action=print" with "--dry-run"
      builtin/history: rename "--ref-action=" to "--update-refs="
      Documentation/git-history: document default for "--update-refs="

 Documentation/git-history.adoc |  14 ++-
 builtin/history.c              | 254 ++++++++++++++++++++++++++---------------
 t/t3451-history-reword.sh      |  20 +++-
 3 files changed, 182 insertions(+), 106 deletions(-)

Range-diff versus v1:

1:  a4b0654c49 ! 1:  495a8e7a1a builtin/history: perform revwalk checks before asking for user input
    @@ Commit message
         Extract the function to set up the revision walk and call it before we
         ask for user input to fix this.
     
    +    Adapt one of the tests that is expected to fail because of this check
    +    to use false(1) as editor. If the editor had been executed by Git, it
    +    would fail with the error message "Aborting commit as launching the
    +    editor failed."
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/history.c ##
2:  3ea8f7740a ! 2:  13c5edbe7b builtin/history: check for merges before asking for user input
    @@ Commit message
         Fix this by checking whether the revwalk contains merge commits before
         we ask for user input.
     
    +    Adapt one of the tests that is expected to fail because of this check
    +    to use false(1) as editor. If the editor had been executed by Git, it
    +    would fail with the error message "Aborting commit as launching the
    +    editor failed."
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/history.c ##
    @@ builtin/history.c: static int parse_ref_action(const struct option *opt, const c
     +	struct rev_info revs;
     +	int ret;
     +
    -+	for (size_t i = 0; i < revwalk_args->nr; i++)
    -+		strvec_push(&args, revwalk_args->v[i]);
    ++	strvec_pushv(&args, revwalk_args->v);
     +	strvec_push(&args, "--min-parents=2");
     +
     +	repo_init_revisions(repo, &revs, NULL);
3:  4e605e65e0 ! 3:  7226c4d1af builtin/history: replace "--ref-action=print" with "--dry-run"
    @@ Commit message
         Add a test to verify that both "--ref-action=" values behave as
         expected.
     
    +    This patch is best viewed with "--ignore-space-change".
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Documentation/git-history.adoc ##
    @@ Documentation/git-history.adoc: The following commands are available to rewrite
     -`--ref-action=(branches|head|print)`::
     +`--dry-run`::
     +	Do not update any references, but instead print any ref updates in a
    -+	format that can be consumed by linkgit:git-update-ref[1].
    ++	format that can be consumed by linkgit:git-update-ref[1]. Necessary new
    ++	objects will be written into the repository, so applying these printed
    ++	ref updates is generally safe.
     +
     +`--ref-action=(branches|head)`::
      	Control which references will be updated by the command, if any. With
4:  1da7284902 ! 4:  7f41026981 builtin/history: rename "--ref-action=" to "--update-refs="
    @@ Documentation/git-history.adoc: git-history - EXPERIMENTAL: Rewrite history
      DESCRIPTION
      -----------
     @@ Documentation/git-history.adoc: OPTIONS
    - 	Do not update any references, but instead print any ref updates in a
    - 	format that can be consumed by linkgit:git-update-ref[1].
    + 	objects will be written into the repository, so applying these printed
    + 	ref updates is generally safe.
      
     -`--ref-action=(branches|head)`::
     +`--update-refs=(branches|head)`::
-:  ---------- > 5:  0bc831fcab Documentation/git-history: document default for "--update-refs="

---
base-commit: 6fcee4785280a08e7f271bd015a4dc33753e2886
change-id: 20260212-b4-pks-history-dry-run-2b840e530ae6

