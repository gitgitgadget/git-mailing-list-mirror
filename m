Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D92D0C67
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422733; cv=none; b=izOCvGP7AFGiYUHxSuTzm99QZeDdmV2uHjW2jUHmqSjosWru8bW1n5DIXzR88G+3rOjvKOkB8gvzWVhJHN6BWCvOL3Zdt6KX6Lyur73vM+vhwC0H+T03jh9ErfAoTz4dag4TMo2hycWJRPIT+R/2vAGBXPmn3xQAuObYeE3R4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422733; c=relaxed/simple;
	bh=GJ5judaZhsQoJhBk8Vq5Uv2l1NBJbbqYO0Sg1fyENtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lIg6ZMvg3kDqwkudK4/7GbvvHlegooOnh9HVWK7NiKW7EnenfeGDRV/8ln+XJVkhFmVI/7FIg4AwgG13KqoiTqDcKGIvYgxBRGZaXIKgzr/qmvVcFIdjvaZhVhIDUC2SpTkWRGskkYFua8k8G5xpihYkwKw/VtLPreCo8r0/Ntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=3gZ1Q7h1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=niQfetu3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="3gZ1Q7h1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="niQfetu3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1652D1D000B1;
	Thu, 28 Aug 2025 19:12:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 19:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756422729; x=1756509129; bh=kAnIkgBBMs
	PvFX4on8YsHSJfONGaZlXj7qd0jr57PoY=; b=3gZ1Q7h1r+HPUue/gENKca64mZ
	NYFi80004oQs6HrPPoSKpAnKLaYasYCeuderdpOtA4OOgS0BMjwj1FtIp3S+L6kS
	OpMVHbjgCxbAkWk+3Dv/+XBXbT2PBjuKuJ23gcXy1TUv1InW1JVcYiHNv6DK/1tS
	kqgsWANSq/xcDl/gyxzaRqSVOF+SFP8aEjW4v3H9Nv7ksSpuOp3kMOmluyoSNsbf
	SAyvuCKQaTN/GkC5qqu2HFj6BAv5pZuHc6Y3Y02f8uvggllBo2yEOyWrZ2p3IKsJ
	GiFhQ2HA2jYzMwVLba3XuLDGBueBcs+qvNRPu7Veq0LcWotLyid2j0aZP1CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756422729; x=1756509129; bh=kAnIkgBBMsPvFX4on8YsHSJfONGaZlXj7qd
	0jr57PoY=; b=niQfetu3AMCVlyAoDWPq3dithQPH9+8Isn+H+vlHMKvlOoP71mC
	xeihQndiea0coGVzG78BZyE8KE0qKu/ZGZN/qI+OyvxTWetYTZkYKO0h9XxyBOvv
	0PweTSaopkPtLaP8KLJDlizcvG7WyM94hFEyYlSqOXhgCtxUezlcBGfXTzzkfWqF
	trD/8GVvswdcIwawRRElt567Hr0yl9o96Wi0mChQOA5y6sx22lJP5rJQaLTA3STk
	CrNkzS8+JVhscA8h9/dFtCHVUkbPMXZE4Tus4hR8DqSxfHY/9Qkn1QnAjtZFyBtW
	OXvR7OyxwtWkZRgIvXf0U1W7xkgssbawjGg==
X-ME-Sender: <xms:SeKwaDly7hAVCd3WU5bpZ6PfCZi3m_n_obocSagBu6fG8p7KxOyvpg>
    <xme:SeKwaBbmm5iM3SI4ZEdOtzj8noERc27AJcJkw5aKg5sWS7rYaqlDxyYGQCghQed-l
    Va9XJkguPkfupcMkA>
X-ME-Received: <xmr:SeKwaGPJgBRN01d7O5CKUJs65C7eocjbTVMSlmE428ylQkZToGG57P4b42KFRhRhuMMToVSc3e91L9KVEDD5Lc39PBA8Fh0umZ0LX-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SeKwaObmSZ6lAC5YWUngJPD2vPc7-umJFK6zqK8aJYr-VAh7eViIaA>
    <xmx:SeKwaM1BiGlkTdqV6IvzY_b3pZZzCYPtmRBZWZrkWDEk6zGcrZObig>
    <xmx:SeKwaMdFCVH_WVpVvizPPaGSsh206LSX1yMkrwS7K5oKAYmKtGweNg>
    <xmx:SeKwaFFmRNZqVgnftLIDelUKPjjbGA1fiSjDzv7T98G1BXHL39ozDg>
    <xmx:SeKwaJYypdBNn3XYzaCcuyE0Gi_BengRsivvFFgB8vV2WTo2Ac9M_ySk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 19:12:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t0450: add allowlist for builtins with missing
 .adoc
In-Reply-To: <aJs5D2jPh8Uom96p@pks.im> (Patrick Steinhardt's message of "Tue,
	12 Aug 2025 14:52:31 +0200")
References: <20250804073002.1586332-1-toon@iotcl.com>
	<20250808095943.3312265-3-toon@iotcl.com> <xmqq7bzdfoxe.fsf@gitster.g>
	<aJs5D2jPh8Uom96p@pks.im>
Date: Thu, 28 Aug 2025 16:12:08 -0700
Message-ID: <xmqq8qj3rqgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > To ensure no new builtins are added without documentation, add an
>> > allowlist: t0450/adoc-missing...
>> > ...
>> >  t/t0450-txt-doc-vs-help.sh | 8 +++++++-
>> >  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> Forgot to add something?
>
> Indeed. Toon is currently out of office, so I had a look at what it
> takes. The below patch is what I ended up with -- note that I also had
> to reverse the `grep` condition to set the prereq in the else branch.
>
> Let me know whether you're fine with just squashing these changes in or
> whether I shall send another version.

I've marked this topic in the What's cooking report to be expecting
a reroll after 2.51 final gets tagged, which has now done.  If the
fixup! sitting at the tip of the topic is good to Toon's eyes, then
I can squash it in and mark the topic for 'next' without waiting for
a reroll.  If not, please do send in a hopefully small and final
update.

Thanks.

From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Aug 2025 14:52:31 +0200
Subject: [PATCH] fixup! t0450: add allowlist for builtins with missing .adoc

---
 t/t0450-txt-doc-vs-help.sh | 17 ++++++++++-------
 t/t0450/adoc-missing       |  9 +++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 t/t0450/adoc-missing

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 980130be78..e12e18f97f 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -112,16 +112,19 @@ do
 	adoc="$(builtin_to_adoc "$builtin")" &&
 	preq="$(echo BUILTIN_ADOC_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
 
-	# if and only if *.adoc is missing, builtin shall be listed in t0450/adoc-missing
-	result=success
+	# If and only if *.adoc is missing, builtin shall be listed in t0450/adoc-missing.
 	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/adoc-missing
 	then
+		test_expect_success "$builtin appropriately marked as not having .adoc" '
+			! test -f "$adoc"
+		'
+	else
 		test_set_prereq "$preq"
-		result=failure
-	fi &&
-	test_expect_$result "$builtin appropriately marked as having missing .adoc" '
-		test -f "$adoc"
-	'
+
+		test_expect_success "$builtin appropriately marked as having .adoc" '
+			test -f "$adoc"
+		'
+	fi
 
 	# *.adoc output assertions
 	test_expect_success "$preq" "$builtin *.adoc SYNOPSIS has dashed labels" '
diff --git a/t/t0450/adoc-missing b/t/t0450/adoc-missing
new file mode 100644
index 0000000000..1ec9f8dcf3
--- /dev/null
+++ b/t/t0450/adoc-missing
@@ -0,0 +1,9 @@
+checkout--worker
+merge-ours
+merge-recursive
+merge-recursive-ours
+merge-recursive-theirs
+merge-subtree
+pickaxe
+submodule--helper
+upload-archive--writer
-- 
2.51.0-262-gbae8ff527a


