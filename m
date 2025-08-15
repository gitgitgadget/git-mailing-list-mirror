Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321941114
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256249; cv=none; b=Vt/C21LXKlzDEEnEESW54jPmuodrYOI9D8L1kdudtibCPPnqhL/SWd34066Aiq+wwgHJUlp7/BsByUO4xDrHxSXauZzWJXafpDjvQ2IJA3Guo3ioRYdzA3oNQleNu/hJ/Jq+EeqECQNSZ3FCP/iGzUVpVqmO4ZXNsmsyVPg7IRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256249; c=relaxed/simple;
	bh=T1ss0yXEDPcb3f8tgsuuQLf7QWL3LWZoGcFvALtGbqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVyP1q6us2+X4fOA+LKVYmeGQ9dzXV2D9WuyKLrVre8sW6USVzrZq8XFsa36MF8QIkFIM+21LOa6VCnhwYWz65uK8OFDakugrrKZVkrnvyxyYNN8T81/8HTDV+8oYbOCBxP6EvVRPLeAFnPi6qFJCw268Nai6iyTCMCwDc6PbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XmWVq9am; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X4RibAVB; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XmWVq9am";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X4RibAVB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 349291D000DA;
	Fri, 15 Aug 2025 07:10:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 15 Aug 2025 07:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755256246;
	 x=1755342646; bh=KsYddCEdzGnUXcEH5MhzVHtirjP+8cXMSecm7o+k1IE=; b=
	XmWVq9amfsD/5N1c/cAeK+hsBDJOmNjyUPhJcA+zLpxlXKyHX5xPe63acPP1VQdC
	pkV6cSeQZLtH5FHvniECUoKRXlAkkHKqjRqnMQsZiVjAvCdakV1GHHnZTCs4qs7r
	FWvSuHXcypY7cLj8yB41OFO4FEa36BlbBLhb0HNpPGbhjtlLM8X8Rr4JMfdmfdwS
	kCEk/CfFmPR7ZHuIYH/rhufp1fKQRx6Iu3i7Kzr3M4to1xgRUaHIa51wVqULM+hK
	o1Wlb/JWlqbsC6KONgAcA1jTuFTR4Lnj2OJUT2JVeGg53ev4sl7zKsYqaQLaPcYV
	G2xecZEaRN7Rwpc9LLXCQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755256246; x=
	1755342646; bh=KsYddCEdzGnUXcEH5MhzVHtirjP+8cXMSecm7o+k1IE=; b=X
	4RibAVB0sZt3AKXck0MvPwqvB+0Bq0NLRXqui+a/MczSNETFqFTp1zZ6mF+8Q82T
	KJZ7UdbmwNgVfijOJVIhYCUM85JSqrqfWMXIO5SYUNrRmqGRJolD6HABZi1WyOvi
	VTJLHNktJZpHal3ZSFFa0tOlVmf8knmkTjSVD644Q+rpNrlhh6WvVxvNdZoVRsll
	iwm7Peit0ZHcrbZf3jjlbkYbaNlYqXMbdO1d3LDFgrOsQtbNFHuENTyMvl34wd9Y
	bspIqYGp+AKZVJIG5HzICYpXh23XDHWg/ZrVjSamhcyfzTkW/qQwUT+k/q058Q8J
	hzlB3S8Q+wQwnSY1nbkAQ==
X-ME-Sender: <xms:tRWfaEvIlSOE6BJ3huHtvDiOCx0UHfHvbj_SkIRN0iZLpeHcGVpVhlw>
    <xme:tRWfaEuyW5xtLURkYhvbuu3OE-KJX1W9RUGQqiGd-esQLIPPzRXa5CBR8NrsCr4AC
    Fpgjv3bo41KT5WjEw>
X-ME-Received: <xmr:tRWfaJPPKEWyE0ShKfhhNkOEQ8VKTH9dIvH631WzV1_ODaeZL-UgOFVU7U32k7gdyhxJEhPnn1P9fj67VU6jNplJ8m1oWRpE_-gztKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesthekre
    dtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetie
    ehgeeftdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepfhgvlhhiphgv
    rdgtohhnthhrvghrrghssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tRWfaC3vw1z_0dZgDAzqXeSdQhNVlLi8zLYnh1liBwjRXKJRDt6kTw>
    <xmx:tRWfaFPFXBZ7uMLpFMPlRUkYzZAun0G3Q6KKstpVbtzmWMwfQBh8lQ>
    <xmx:tRWfaC2gHy9iXg8gZfhV_ShOAjfhGmNxUczf3ct3kVSUnwrKqeBsQw>
    <xmx:tRWfaMFhCo0sZuUkeeW8PXzOuLMu4SxrG3NFiQI_Nba72tqLvbBZxQ>
    <xmx:thWfaJXSnnr9l9SCLK_MIisv7DrqVo63bZXKmfTva06bB_aI_055WBje>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 07:10:44 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2] bugreport: use quoted line prefixes
Date: Fri, 15 Aug 2025 13:10:15 +0200
Message-ID: <52a6177e706d8653251c61bc660f10b703ea6a9e.1755256099.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <20210723175950.64955-1-felipe.contreras@gmail.com>
References: <20210723175950.64955-1-felipe.contreras@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Quoted line prefixes make it easier to distinguish between the questions
and the answers, both for the reporter and for the readers.

Based-on-patch-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    § Changes in v2
    
    • Update test which wasn’t there when v1 was made
    • Rewrite commit message to one single sentence
    • “use” in the subject is slightly more declarative than “add” (?)

 builtin/bugreport.c  | 18 +++++++++---------
 t/t0091-bugreport.sh | 18 +++++++++---------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index f78c3f2aed6..44be7eb4859 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -65,21 +65,21 @@ static const char * const bugreport_usage[] = {
 static int get_bug_template(struct strbuf *template)
 {
 	const char template_text[] = N_(
-"Thank you for filling out a Git bug report!\n"
-"Please answer the following questions to help us understand your issue.\n"
+"> Thank you for filling out a Git bug report!\n"
+"> Please answer the following questions to help us understand your issue.\n"
 "\n"
-"What did you do before the bug happened? (Steps to reproduce your issue)\n"
+"> What did you do before the bug happened? (Steps to reproduce your issue)\n"
 "\n"
-"What did you expect to happen? (Expected behavior)\n"
+"> What did you expect to happen? (Expected behavior)\n"
 "\n"
-"What happened instead? (Actual behavior)\n"
+"> What happened instead? (Actual behavior)\n"
 "\n"
-"What's different between what you expected and what actually happened?\n"
+"> What's different between what you expected and what actually happened?\n"
 "\n"
-"Anything else you want to add:\n"
+"> Anything else you want to add:\n"
 "\n"
-"Please review the rest of the bug report below.\n"
-"You can delete any lines you don't wish to share.\n");
+"> Please review the rest of the bug report below.\n"
+"> You can delete any lines you don't wish to share.\n");
 
 	strbuf_addstr(template, _(template_text));
 	return 0;
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index e38ca7a9018..9d7008f3592 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -12,21 +12,21 @@ test_expect_success 'create a report' '
 test_expect_success 'report contains wanted template (before first section)' '
 	sed -ne "/^\[/q;p" git-bugreport-format.txt >actual &&
 	cat >expect <<-\EOF &&
-	Thank you for filling out a Git bug report!
-	Please answer the following questions to help us understand your issue.
+	> Thank you for filling out a Git bug report!
+	> Please answer the following questions to help us understand your issue.
 
-	What did you do before the bug happened? (Steps to reproduce your issue)
+	> What did you do before the bug happened? (Steps to reproduce your issue)
 
-	What did you expect to happen? (Expected behavior)
+	> What did you expect to happen? (Expected behavior)
 
-	What happened instead? (Actual behavior)
+	> What happened instead? (Actual behavior)
 
-	What'\''s different between what you expected and what actually happened?
+	> What'\''s different between what you expected and what actually happened?
 
-	Anything else you want to add:
+	> Anything else you want to add:
 
-	Please review the rest of the bug report below.
-	You can delete any lines you don'\''t wish to share.
+	> Please review the rest of the bug report below.
+	> You can delete any lines you don'\''t wish to share.
 
 
 	EOF

Range-diff against v1:
1:  ef7a1cbd9d4 ! 1:  52a6177e706 bugreport: add quoted line prefixes
    @@
      ## Metadata ##
    -Author: Felipe Contreras <felipe.contreras@gmail.com>
    +Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    bugreport: add quoted line prefixes
    +    bugreport: use quoted line prefixes
     
    -    With quoted line prefixes it's easier to distinguish what are the
    -    standard questions, and what are the user responses.
    +    Quoted line prefixes make it easier to distinguish between the questions
    +    and the answers, both for the reporter and for the readers.
     
    -    Additionally it's easier for the reporter to visualize what has she
    -    responded.
    +    Based-on-patch-by: Felipe Contreras <felipe.contreras@gmail.com>
    +    Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    -    Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
    +
    + ## Notes (series) ##
    +    § Changes in v2
    +
    +    • Update test which wasn’t there when v1 was made
    +    • Rewrite commit message to one single sentence
    +    • “use” in the subject is slightly more declarative than “add” (?)
     
      ## builtin/bugreport.c ##
     @@ builtin/bugreport.c: static const char * const bugreport_usage[] = {
    @@ builtin/bugreport.c: static const char * const bugreport_usage[] = {
      
      	strbuf_addstr(template, _(template_text));
      	return 0;
    +
    + ## t/t0091-bugreport.sh ##
    +@@ t/t0091-bugreport.sh: test_expect_success 'create a report' '
    + test_expect_success 'report contains wanted template (before first section)' '
    + 	sed -ne "/^\[/q;p" git-bugreport-format.txt >actual &&
    + 	cat >expect <<-\EOF &&
    +-	Thank you for filling out a Git bug report!
    +-	Please answer the following questions to help us understand your issue.
    ++	> Thank you for filling out a Git bug report!
    ++	> Please answer the following questions to help us understand your issue.
    + 
    +-	What did you do before the bug happened? (Steps to reproduce your issue)
    ++	> What did you do before the bug happened? (Steps to reproduce your issue)
    + 
    +-	What did you expect to happen? (Expected behavior)
    ++	> What did you expect to happen? (Expected behavior)
    + 
    +-	What happened instead? (Actual behavior)
    ++	> What happened instead? (Actual behavior)
    + 
    +-	What'\''s different between what you expected and what actually happened?
    ++	> What'\''s different between what you expected and what actually happened?
    + 
    +-	Anything else you want to add:
    ++	> Anything else you want to add:
    + 
    +-	Please review the rest of the bug report below.
    +-	You can delete any lines you don'\''t wish to share.
    ++	> Please review the rest of the bug report below.
    ++	> You can delete any lines you don'\''t wish to share.
    + 
    + 
    + 	EOF

base-commit: 724518f3884d8707c5f51428ba98c115818229b8
-- 
2.50.1

