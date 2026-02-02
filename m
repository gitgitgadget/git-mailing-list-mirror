Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8505309EFA
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770066482; cv=none; b=EnFA/FBBUOjCMazbqbx1dZbhhw97/k44tL4o43lv/w4ORL8QV/LeJxGW5nqWqn1aPHbHwVmvY3reh4V+RMuaezT08RcwSp/gpLIP4BduHVU4CPN9UYXa7e37mMFACToyuPjEaul6KE5ITQLZY4RmslzW4in2Cc50zsx9NOIC69g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770066482; c=relaxed/simple;
	bh=Zu0WahAfz/D2SrBjunwH1P4/lfMQZw3uxd2Pf9fEU8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZPkqWP5Tfa1VpVBkGev7+zzTPdezPQa1zYnIVqPs1sMWx5v6mzp5/CAnuR+ry8JL9mvLgHkfvgYysTRARqug4oQM6e4jUxwHO6T8qYBN4h1IAvbYOvqSVnisZm9UcIbjQun3sOlrXLXbsfrtnh0ZzlpjJfhQwJXAzVHdXndpJWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xzA+4GOb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HR6uSh7i; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xzA+4GOb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HR6uSh7i"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E79191D0012D;
	Mon,  2 Feb 2026 16:07:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Feb 2026 16:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770066479; x=1770152879; bh=5yHjOT2tLg
	Zdscokp1KD2q2+XjO4oJ64lep4UU+l6uM=; b=xzA+4GObHUJi7QF29DF3YXrYoQ
	yATfuTliYeY7jVel1Fo/Qte5WDYSQikNlTsdXmzFz/Cab4CmcI9W+3wpUfpInqJJ
	rX5+FjlHZd9Ex1s3CBYHK2zY4sVxvfQgbeGaG0Wl3mx5+1w5hX+4vK9dUNsRzKKL
	LbDki4PpkHL2UiUQov9o/BdzuObmVeL+AKHmqGTvZbZXv4Y5V9H5uUNSRdLzwAuI
	YgGjZpj6UB/oLXX92YVepNLt63sOnriJkZ28jFix2YipHrx8um3ty1XQu6qCBd7b
	KGi5JgG4bva6KKwBIlFi01Uc9cwZovQB2DWmozBOP2vm9dx4gTQTWrIw671Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770066479; x=1770152879; bh=5yHjOT2tLgZdscokp1KD2q2+XjO4oJ64lep
	4UU+l6uM=; b=HR6uSh7iBrIC7HQq7dZbSmj+5G+dw9UvIxfFIgULM49U0+votKI
	DiSX2KVzlWOTkF89nIE+wkw//vRm8B93RM5lcb3TaQGJzk20PCvfGpANbARGBbiO
	Bd3a0HjA/sU20nKUltydc+5UJ0r0riVHy8PJ1mf1jn9CUd3FQ4BZ5eqFUrpTuvjk
	DvL4z92UFAc2CIGojVzL6ryQux9+dq+8D84QHjqBDz5+BCtNefo4X27caadvSchX
	Zdd+T9Dl2FltyGJLe1pXnrxxyuORLJS3kIWR1goNIo8A8UXzXzg9fP31e/0n84in
	sIo1WH0srjBFtzCLGEzr065wPtS4wa6ID4w==
X-ME-Sender: <xms:LxKBaSD7UFyn07ZPTxGLqrmlo6UoTaPSKiO9wC6WBCGqsdcm04sJZw>
    <xme:LxKBaThtyLTQTIyXygDlUwueDLvrucKAXiZGunaTMfu_1l3WXltnDuT2L90BVmfBH
    UItwtoIRONhxhsv5bzVKFeNyJ6vC2Ig4TIRPZVpugjicqMA_Rm7e4U>
X-ME-Received: <xmr:LxKBaaneALl9LYzNbys261QTM6ekNa3UUYRBFEqbt3MMO7R_Tvj4EQhCfb4kKugfs6C7WtLfGX1YKNUBnOnyGp63SrqkB2maxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehpuhhshhhkrghrkhhumhgrrhhsihhnghhhudeljedtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LxKBafqxVjg9PvmivvhjszrmA5Hpii-D7wRmrQObvw7DMnLPgfUhwA>
    <xmx:LxKBaTGZiWy7-pKh_-kKAZiW49JlmGq-Nu-xGKWh8srKPJLSdDbg-g>
    <xmx:LxKBabyN-tuH4tFQGc4UK3l1sMEt3rYj2vz0CUXK01i_cn1hoBWNWg>
    <xmx:LxKBaYpUQP4CkAAMqHByfY4j9f30jZEaKxXcrhpCKdRmfiQnRGPdQw>
    <xmx:LxKBad0UbYWg03DSbxdUSAPL6yUiwx8TgdN5WgMoBL6Zg-6hjumSdQvd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 16:07:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Pushkar Singh <pushkarkumarsingh1970@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3] subtree: validate --prefix against commit in split
In-Reply-To: <7k7ewvrb5hj3jyesiigy6dvo5w5pl67rk7ihztsuxbtqpymafv@ey64nvhzhacg>
	(Josh Steadmon's message of "Mon, 2 Feb 2026 10:54:13 -0800")
References: <xmqqh5smdejc.fsf@gitster.g>
	<20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
	<7k7ewvrb5hj3jyesiigy6dvo5w5pl67rk7ihztsuxbtqpymafv@ey64nvhzhacg>
Date: Mon, 02 Feb 2026 13:07:58 -0800
Message-ID: <xmqqjywuyhu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> On 2026.01.15 17:52, Pushkar Singh wrote:
>> git subtree split currently validates --prefix against the working tree.
>> This breaks when splitting an older commit or when the working tree does
>> not contain the subtree, even though the commit does.
>> 
>> For example:
>> 
>>   git subtree split --prefix=pkg <commit>
>> 
>> fails if pkg was removed later, even though it exists in <commit>.
>> 
>> Fix this by validating the prefix against the specified commit using
>> git ls-tree instead of the working tree.
>> 
>> Add a test to ensure this behavior does not regress.
>> 
>> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
>
> Unfortunately, it seems this patch breaks the subtree tests. We noticed
> a failure in our build system at $WORK, and I was able to bisect the
> failure to this commit:
>
> $ git bisect start 54b18a3513eed9ed5ced5c238ade55a434fd619a 66b2238f5c17644ddf15f75a53c76faeca6d9f1e
> $ git bisect run sh -c 'make && make -C contrib/subtree && make -C contrib/subtree test'
>
> The tests fail on case 17 - split requires path given by option --prefix
> must exist.

Thanks.  I am tempted to propose us doing something like this, so
that you guys do not have to every time you import my 'next'.

--- >8 ---
Subject: [PATCH] test: optionally test contrib in CI

Recently it was reported that a topic merged to 'next' broke build
and test for contrib/subtree part of the system.

Instead of having those who run 'next' or 'master' to hit the build
and test breakage and report to us, make sure we notice breakages in
contrib/ area before they hit my tree at all, during their own
presubmit testing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * There should be a cleaner way to make sure any new Makefile with
   "test" target in contrib/* directores are added to the execution,
   but for now this should do.

 Makefile                  |  6 ++++++
 ci/run-build-and-tests.sh |  2 ++
 contrib/Makefile          | 10 ++++++++++
 3 files changed, 18 insertions(+)
 create mode 100644 contrib/Makefile

diff --git a/Makefile b/Makefile
index 8aa489f3b6..d0ab8fdb04 100644
--- a/Makefile
+++ b/Makefile
@@ -342,6 +342,9 @@ include shared.mak
 # If it isn't set, fallback to $LC_ALL, $LANG or use the first utf-8
 # locale returned by "locale -a".
 #
+# Define TEST_CONTRIB_TOO to make "make test" run tests in contrib/
+# directories.
+#
 # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime.
 #
 # Define HAVE_CLOCK_MONOTONIC if your platform has CLOCK_MONOTONIC.
@@ -3369,6 +3372,9 @@ export TEST_NO_MALLOC_CHECK
 
 test: all
 	$(MAKE) -C t/ all
+ifdef TEST_CONTRIB_TOO
+	$(MAKE) -C contrib/ test
+endif
 
 perf: all
 	$(MAKE) -C t/perf/ all
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 8bda62b921..b07b89f954 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,6 +5,8 @@
 
 . ${0%/*}/lib.sh
 
+export TEST_CONTRIB_TOO=yes
+
 case "$jobname" in
 fedora-breaking-changes-musl|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
diff --git a/contrib/Makefile b/contrib/Makefile
new file mode 100644
index 0000000000..787cd07f52
--- /dev/null
+++ b/contrib/Makefile
@@ -0,0 +1,10 @@
+all::
+
+test::
+	$(MAKE) -C diff-highlight $@
+	$(MAKE) -C subtree $@
+
+clean::
+	$(MAKE) -C contacts $@
+	$(MAKE) -C diff-highlight $@
+	$(MAKE) -C subtree $@
-- 
2.53.0-154-gaa371a4585

