Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA02D541B
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768674861; cv=none; b=ft2rItc+aPkxJ0ewoTF+6p6Jxq67BnTPnM0lrmQPVnkTu03eu8qEegGHlOtyQgUgz9C1ad+8XTMK66EcOx4M2UD8WGKlOkpAu4la10ip7JBbpxrnERtMA09G5allyLhW1GIRbF2VxzQ8zX6WyF+suVRZeZJFtFV5X//Vj2oXIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768674861; c=relaxed/simple;
	bh=G4cFGXTA4ax63WjiK+PL9aLwSKjVpFB7BPrKMroqRKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KoH2Ndxgvx8h6tZz/GRN2vBsBC46rkYA2ToyJRKYJ1xY2dWK4VlJXfNdtqh9pQEu1X+52G+rhQiNOccq8BIkgP3kVUASewc/fYeQbCzYo8QMFdg+N1WzEm0pkUbz5J1U+rObQDKTH842rUCwUjpzXb5JqtLv5LeEyIms+IfWpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W5BDcpUG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PADFSxmU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W5BDcpUG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PADFSxmU"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id BB441EC06C4;
	Sat, 17 Jan 2026 13:34:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 17 Jan 2026 13:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768674858; x=1768761258; bh=WfKZ0pzcOt
	nP6C6qeyq6F7knE9s2hddCCN66QgYVMUc=; b=W5BDcpUGogWGLGxK9LPN8nF9D2
	imYiMf0LtaRkCHXLWD08zzoDrTl7shYyC+vf1QBEhbTC6DBBglhbRJng/VcMvcf0
	//zh+AhZEhnhDs4GVtpG3Szizc2RSN3L3CUlqw0pry3Jx4cNLuxFnhuY0LOdUr4P
	ZSoEFluV/JD/6HBYqo9jbiC4074sQyN+/g1QUjJj/9EFFW5XlZ+D8FpV8LGEw9Lh
	7AHRor4hLDNct4GycdG2RYsvjkjg1mMPSydpjzBEXDO7R9XBpCSwqZxdyr6Krruf
	YjFNF/6XKw3GbzM11WlGYzIj4MaGcXalPWaHXFIqlEvvcL6Q0gLHuz/c472Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768674858; x=1768761258; bh=WfKZ0pzcOtnP6C6qeyq6F7knE9s2hddCCN6
	6QgYVMUc=; b=PADFSxmUFG5lpSFzFuCnZ7jcUZYAhdva0sqCDuTDfNzA/Mh0/uQ
	eA0W8payfTihQeq7+9v04Va7Smc8UpdfIEj3rIS39afQH/lb8+J3zT2s1rMGVbLZ
	9ypTI04b4SjDwgd0notrVS4eOG/ayDwpcJv2eY5PR8Srzefj81Wl1FsB4qC/6e3+
	MrmjrttQk313GEcU7Y+eW5aYiirhP/fNKCjuvfiSCZlcJL+b3EYMTPDdH5jJsyac
	JArwCfekWzZP1Cln+2ZJvJ3CCcTyMFbtVdCjZ4bj5J21QeZWaq2JKQRHBWW3/zdR
	jXZWenkRXDQv4uoBLxi0w8KsXBpJXPsMliA==
X-ME-Sender: <xms:KtZraQoHWxHIfrvjkua7s199iaOCcrBBT1RXk0K-2RyWy0tm1DoJMQ>
    <xme:KtZradjheXCwylbE4E0CCVNZZcyrGA2tdcMF1f96Yue5jYMrviLuahRAPCEGREJ7R
    63Q6T6Bl4WuIjdFy5iuw_mBicqXJBcmxGTXagvGSzI3JIHx3CcvCtM>
X-ME-Received: <xmr:KtZradjL_4q0bpB2VRMpfhGmhuRXvaa9HfzdtijV4L2LC-OeeDL7vwCwrUGDnu5bknTc4xCb30YnNmXE9MXrsEHiWEEZRTBrNgOBsew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedvheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KtZraTgFz8BOu7_K_xRwHlAzhvUu5uciy0ScLCjX4iduB0LD_Kb91A>
    <xmx:KtZradJFi6uC2XM4QmMvvduGHVlYaPuT7G7RkEvhrEjlFeZSDk--Sg>
    <xmx:KtZraSHAm6isEucfFRPL6pVbpxeQxsztIR3fxqW9oDAQnwXGkMWGIQ>
    <xmx:KtZraRS8k8uLIVixuVBKrDyLHXq4JOgl_Jx21WZIQB6cmac06UZrjg>
    <xmx:KtZraZ7jodmtTTsHEN2fQ647pauVNJxdJMyd98aB1NkKsOU6EvgVjZGv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 13:34:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(*-leaks): skip the git-svn tests to save time
In-Reply-To: <b649f137-7140-4fb6-848a-b3408e54bbe5@gmail.com> (Phillip Wood's
	message of "Sat, 17 Jan 2026 15:04:48 +0000")
References: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
	<b649f137-7140-4fb6-848a-b3408e54bbe5@gmail.com>
Date: Sat, 17 Jan 2026 10:34:17 -0800
Message-ID: <xmqqa4yc5brq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Looking at the CI logs for this PR the p4 and cvs tests account for 
> another 24 minutes of test time and I suspect they also offer little in 
> the way of extra coverage. Unfortunately there is no equivalent of 
> NO_SVN_TESTS to disable them - I wonder if building with NO_PYTHON and 
> NO_PERL would make sense for the leak test job?
>
> Either way I like the direction of this patch
>
> Thanks
>
> Phillip

Yup, I generally like this direction, and introducing NO_P4_TESTS
and NO_CVS_TESTS would not be so bad.  Here is how it looks on top
of Dscho's patch.

--- >8 ---
Subject: [PATCH] ci: skip CVS and P4 tests in leaks job, too

Looking at the CI logs, the p4 and cvs tests account for another 24
minutes of test time and they offer minimal value for quite a
similar reason as the previous step.

Let's introduce and use a mechanism to skip these tests to save
some resources.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/lib.sh       | 2 ++
 t/lib-cvs.sh    | 6 ++++++
 t/lib-git-p4.sh | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index a165c7f268..3ecbf147db 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -356,7 +356,9 @@ linux-musl-meson)
 	;;
 linux-leaks|linux-reftable-leaks)
 	export SANITIZE=leak
+	export NO_CVS_TESTS=LetsSaveSomeTime
 	export NO_SVN_TESTS=LetsSaveSomeTime
+	export NO_P4_TESTS=LetsSaveSomeTime
 	;;
 linux-asan-ubsan)
 	export SANITIZE=address,undefined
diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 57b9b2db9b..c8b4404888 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -2,6 +2,12 @@
 
 . ./test-lib.sh
 
+if test -n "$NO_CVS_TESTS"
+then
+	skip_all='skipping git cvs tests, NO_CVS_TESTS defined'
+	test_done
+fi
+
 unset CVS_SERVER
 
 if ! type cvs >/dev/null 2>&1
diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 2a5b8738ea..d22e9c684a 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -16,6 +16,11 @@ P4D_TIMEOUT=300
 
 . ./test-lib.sh
 
+if test -n "$NO_P4_TESTS"
+then
+	skip_all='skipping git p4 tests, NO_P4_TESTS defined'
+	test_done
+fi
 if ! test_have_prereq PYTHON
 then
 	skip_all='skipping git p4 tests; python not available'
-- 
2.53.0-rc0-217-gd590ba4684

