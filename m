Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA028AB1E
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867023; cv=none; b=cZASqkXA9lVf28S+PL5M47FtPlISH6N+wXW1ptCy3HZFHW4ajrbcthUlcAhDHTPDVqN/YgvmaaedWzMfpzIvr/PO3Ga+8/zTIdFQA0CD5a6y0V55eAwpZwFWKbHdH1/QrK9nq7zlgIKeOJlRAmSQk9Of35UrTG1/klaGV+DBQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867023; c=relaxed/simple;
	bh=wMWQ6s1S/fOwPPKJ92dAk2iy4uirVWnglmUDIWXxZcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJZzbmaW7xWr3J+xWkvToSrfZ8hNw64FnNRTf40A9MsN+wdDiW8pPwqK55rv8AThN32Hielxfv26OQAvRVFuiy0o4rKDlvz6VIeOPu7+XkGKFkSKm0v3SZhcdTBZomIu+X9fNLaK97EOVHe8c+6cXDfLSst4MUFys/Ua0McjZz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FnyR+tDM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j4665wL+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FnyR+tDM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j4665wL+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F70BEC0109;
	Fri, 22 Aug 2025 08:50:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 22 Aug 2025 08:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755867020;
	 x=1755953420; bh=QXA4hHkahVsrbB49MxciyXRYAIubM37PmmvymWWhWRw=; b=
	FnyR+tDMJaAF74YSOFqyqinuVSyY5UoqSW6E367GMqpUZevjVO1bl7nQiT63ndYK
	Xf2x7DLAmZvyLeZQfKd7Fp0QY6xZPJemGrwQ91XiW6b8II2ZOtz8LyL0BIIGclj7
	m2kKFr2/gimw8c+L2qCUKvAP5SXPrju1J+NEwROQZxG4uNpfpp4BJd1E8bNzW3bG
	ZvOQlVv1D4DGA7ab7/2WXTrodeGPjj62O2utFhqYOaDkcAs6+INrakRaHZbgo6y5
	5ZyXnqU/7qRs02W/jbfDPazs7IvNWQLve76kKFfBn9Gu3xGew4qVNM8If6JFz28C
	KXSesa3+oStJLwfANo7CDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755867020; x=
	1755953420; bh=QXA4hHkahVsrbB49MxciyXRYAIubM37PmmvymWWhWRw=; b=j
	4665wL+Kzl1zOUz8p+rqhkDGO/dhALfAFmaTZc0F0E8yTDzglbx6iiHwfhbaNtRg
	qBFiiNAk+ReJurQh/x5p1q3W75otSb/dLstImXnUFVT0kvuPQiRsJS9rwXn9CWeP
	Ro0MzxmPIc1HJBKVxegfSjk7Ff9/YosyhFIrdfCQ6lJn6nDCccPkHEJeEcPfH2hP
	NUK76WpiY9KnPgKZlsR1570vbFKTPWRbIZck+v10LtLGJRCY46OLRw/wAV1N9FJo
	2qmmOCSxLHgZUaOLRKdcnmkJaS3qnrDjSBE6qo3a/ma4MsmBIUrHtbBLKTW4IV3+
	Wj1LRVT1BDZZ4qJbNvm2g==
X-ME-Sender: <xms:jGeoaKl6FMLPzyzMGv86dpZ9kpzwTuPYhZD0GZApUG7wLLceaDPbx0A>
    <xme:jGeoaFEYNt_xG1jzh30bvIveQkqQJRRtXPrDFIDgGMMY8iT4fMmnoO8v4gatigfxX
    iwUb3094dwWCTaRJQ>
X-ME-Received: <xmr:jGeoaCGkVzWzk7-p5cY4MBCxkmXTBQag5kHGf3i9Fbes2j9PtDOvXDTspRasjEUeHg7Ze6dRi31s-KX-UKSOemnJRqbCA3DEbo8xly8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefkedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:jGeoaKMDlMoqNNbnAsxk7hptPjGEK7PtoGRgJ4Ikmj0JLqi-dvnOsw>
    <xmx:jGeoaJF_H_u-fNEHLZdQTQU70XqJgMsaymIICYa_0aOqWY6q5blkHw>
    <xmx:jGeoaJOghP6wV6-JEADuXzszGcPO3dLL8F69KwWOkhezRQhqdISamA>
    <xmx:jGeoaC8xb2vY_91pLVxNNcfVX3TeNhKh1ZKEgi_OU3vg1ussR5L6MQ>
    <xmx:jGeoaBu8bHr8qZtpTgBnHdg6bBIEJ2CU0eZOhq4mNBxqXWB1z9XAj-z->
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 08:50:19 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3] bugreport: use quoted line prefixes & more blank lines
Date: Fri, 22 Aug 2025 14:49:58 +0200
Message-ID: <3d00cdbe8535fda8f9e72b5243090e6d953c133e.1755866791.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.11.g23cedd8a747
In-Reply-To: <52a6177e706d8653251c61bc660f10b703ea6a9e.1755256099.git.code@khaugsbakk.name>
References: <52a6177e706d8653251c61bc660f10b703ea6a9e.1755256099.git.code@khaugsbakk.name>
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

Also try to nudge the user to submit a report with a blank line
separating the end of the question, the answer, and the next
question.[1]  (Or leave optional answers empty, i.e. with three
blank lines.  That should be fine too.)

[1]: Suggested by Junio

Based-on-patch-by: Felipe Contreras <felipe.contreras@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    § Changes in v3
    
    • Don’t quote the introduction (not a question and not needed)
    • Also try to nudge the user to leave enough blank lines
    • Keep using one single patch for less test file churn even though these
      are two changes in one
    
    I considered being cute with the footnote:
    
        ...
        question.[1] ...
    
        Based-on-patch-by: Felipe Contreras <felipe.contreras@gmail.com>
        [1]:
        Suggested-by: Junio C Hamano <gitster@pobox.com>
        Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
    
    § Changes in v2
    
    • Update test which wasn’t there when v1 was made
    • Rewrite commit message to one single sentence
    • “use” in the subject is slightly more declarative than “add” (?)

 builtin/bugreport.c  | 27 ++++++++++++++++++++-------
 t/t0091-bugreport.sh | 27 ++++++++++++++++++++-------
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index f78c3f2aed6..694ab85d8cb 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -67,19 +67,32 @@ static int get_bug_template(struct strbuf *template)
 	const char template_text[] = N_(
 "Thank you for filling out a Git bug report!\n"
 "Please answer the following questions to help us understand your issue.\n"
+"There are three blank lines after each question; please write your\n"
+"response on the second line and keep a blank line betweeen the question\n"
+"and the answer (beginning and end).\n"
 "\n"
-"What did you do before the bug happened? (Steps to reproduce your issue)\n"
+"> What did you do before the bug happened? (Steps to reproduce your issue)\n"
 "\n"
-"What did you expect to happen? (Expected behavior)\n"
 "\n"
-"What happened instead? (Actual behavior)\n"
 "\n"
-"What's different between what you expected and what actually happened?\n"
+"> What did you expect to happen? (Expected behavior)\n"
 "\n"
-"Anything else you want to add:\n"
 "\n"
-"Please review the rest of the bug report below.\n"
-"You can delete any lines you don't wish to share.\n");
+"\n"
+"> What happened instead? (Actual behavior)\n"
+"\n"
+"\n"
+"\n"
+"> What's different between what you expected and what actually happened?\n"
+"\n"
+"\n"
+"\n"
+"> Anything else you want to add:\n"
+"\n"
+"\n"
+"\n"
+"> Please review the rest of the bug report below.\n"
+"> You can delete any lines you don't wish to share.\n");
 
 	strbuf_addstr(template, _(template_text));
 	return 0;
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index e38ca7a9018..facaf1a5373 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -14,19 +14,32 @@ test_expect_success 'report contains wanted template (before first section)' '
 	cat >expect <<-\EOF &&
 	Thank you for filling out a Git bug report!
 	Please answer the following questions to help us understand your issue.
+	There are three blank lines after each question; please write your
+	response on the second line and keep a blank line betweeen the question
+	and the answer (beginning and end).
 
-	What did you do before the bug happened? (Steps to reproduce your issue)
+	> What did you do before the bug happened? (Steps to reproduce your issue)
 
-	What did you expect to happen? (Expected behavior)
 
-	What happened instead? (Actual behavior)
 
-	What'\''s different between what you expected and what actually happened?
+	> What did you expect to happen? (Expected behavior)
 
-	Anything else you want to add:
 
-	Please review the rest of the bug report below.
-	You can delete any lines you don'\''t wish to share.
+
+	> What happened instead? (Actual behavior)
+
+
+
+	> What'\''s different between what you expected and what actually happened?
+
+
+
+	> Anything else you want to add:
+
+
+
+	> Please review the rest of the bug report below.
+	> You can delete any lines you don'\''t wish to share.
 
 
 	EOF

Interdiff against v2:
  diff --git a/builtin/bugreport.c b/builtin/bugreport.c
  index 44be7eb4859..694ab85d8cb 100644
  --- a/builtin/bugreport.c
  +++ b/builtin/bugreport.c
  @@ -65,19 +65,32 @@ static const char * const bugreport_usage[] = {
   static int get_bug_template(struct strbuf *template)
   {
   	const char template_text[] = N_(
  -"> Thank you for filling out a Git bug report!\n"
  -"> Please answer the following questions to help us understand your issue.\n"
  +"Thank you for filling out a Git bug report!\n"
  +"Please answer the following questions to help us understand your issue.\n"
  +"There are three blank lines after each question; please write your\n"
  +"response on the second line and keep a blank line betweeen the question\n"
  +"and the answer (beginning and end).\n"
   "\n"
   "> What did you do before the bug happened? (Steps to reproduce your issue)\n"
   "\n"
  +"\n"
  +"\n"
   "> What did you expect to happen? (Expected behavior)\n"
   "\n"
  +"\n"
  +"\n"
   "> What happened instead? (Actual behavior)\n"
   "\n"
  +"\n"
  +"\n"
   "> What's different between what you expected and what actually happened?\n"
   "\n"
  +"\n"
  +"\n"
   "> Anything else you want to add:\n"
   "\n"
  +"\n"
  +"\n"
   "> Please review the rest of the bug report below.\n"
   "> You can delete any lines you don't wish to share.\n");
   
  diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
  index 9d7008f3592..facaf1a5373 100755
  --- a/t/t0091-bugreport.sh
  +++ b/t/t0091-bugreport.sh
  @@ -12,19 +12,32 @@ test_expect_success 'create a report' '
   test_expect_success 'report contains wanted template (before first section)' '
   	sed -ne "/^\[/q;p" git-bugreport-format.txt >actual &&
   	cat >expect <<-\EOF &&
  -	> Thank you for filling out a Git bug report!
  -	> Please answer the following questions to help us understand your issue.
  +	Thank you for filling out a Git bug report!
  +	Please answer the following questions to help us understand your issue.
  +	There are three blank lines after each question; please write your
  +	response on the second line and keep a blank line betweeen the question
  +	and the answer (beginning and end).
   
   	> What did you do before the bug happened? (Steps to reproduce your issue)
   
  +
  +
   	> What did you expect to happen? (Expected behavior)
   
  +
  +
   	> What happened instead? (Actual behavior)
   
  +
  +
   	> What'\''s different between what you expected and what actually happened?
   
  +
  +
   	> Anything else you want to add:
   
  +
  +
   	> Please review the rest of the bug report below.
   	> You can delete any lines you don'\''t wish to share.
   

Range-diff against v2:
1:  52a6177e706 ! 1:  3d00cdbe853 bugreport: use quoted line prefixes
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    bugreport: use quoted line prefixes
    +    bugreport: use quoted line prefixes & more blank lines
     
         Quoted line prefixes make it easier to distinguish between the questions
         and the answers, both for the reporter and for the readers.
     
    +    Also try to nudge the user to submit a report with a blank line
    +    separating the end of the question, the answer, and the next
    +    question.[1]  (Or leave optional answers empty, i.e. with three
    +    blank lines.  That should be fine too.)
    +
    +    [1]: Suggested by Junio
    +
         Based-on-patch-by: Felipe Contreras <felipe.contreras@gmail.com>
    +    Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    § Changes in v3
    +
    +    • Don’t quote the introduction (not a question and not needed)
    +    • Also try to nudge the user to leave enough blank lines
    +    • Keep using one single patch for less test file churn even though these
    +      are two changes in one
    +
    +    I considered being cute with the footnote:
    +
    +        ...
    +        question.[1] ...
    +
    +        Based-on-patch-by: Felipe Contreras <felipe.contreras@gmail.com>
    +        [1]:
    +        Suggested-by: Junio C Hamano <gitster@pobox.com>
    +        Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
    +
         § Changes in v2
     
         • Update test which wasn’t there when v1 was made
    @@ Notes (series)
         • “use” in the subject is slightly more declarative than “add” (?)
     
      ## builtin/bugreport.c ##
    -@@ builtin/bugreport.c: static const char * const bugreport_usage[] = {
    - static int get_bug_template(struct strbuf *template)
    - {
    +@@ builtin/bugreport.c: static int get_bug_template(struct strbuf *template)
      	const char template_text[] = N_(
    --"Thank you for filling out a Git bug report!\n"
    --"Please answer the following questions to help us understand your issue.\n"
    -+"> Thank you for filling out a Git bug report!\n"
    -+"> Please answer the following questions to help us understand your issue.\n"
    + "Thank you for filling out a Git bug report!\n"
    + "Please answer the following questions to help us understand your issue.\n"
    ++"There are three blank lines after each question; please write your\n"
    ++"response on the second line and keep a blank line betweeen the question\n"
    ++"and the answer (beginning and end).\n"
      "\n"
     -"What did you do before the bug happened? (Steps to reproduce your issue)\n"
     +"> What did you do before the bug happened? (Steps to reproduce your issue)\n"
      "\n"
     -"What did you expect to happen? (Expected behavior)\n"
    -+"> What did you expect to happen? (Expected behavior)\n"
      "\n"
     -"What happened instead? (Actual behavior)\n"
    -+"> What happened instead? (Actual behavior)\n"
      "\n"
     -"What's different between what you expected and what actually happened?\n"
    -+"> What's different between what you expected and what actually happened?\n"
    ++"> What did you expect to happen? (Expected behavior)\n"
      "\n"
     -"Anything else you want to add:\n"
    -+"> Anything else you want to add:\n"
      "\n"
     -"Please review the rest of the bug report below.\n"
     -"You can delete any lines you don't wish to share.\n");
    ++"\n"
    ++"> What happened instead? (Actual behavior)\n"
    ++"\n"
    ++"\n"
    ++"\n"
    ++"> What's different between what you expected and what actually happened?\n"
    ++"\n"
    ++"\n"
    ++"\n"
    ++"> Anything else you want to add:\n"
    ++"\n"
    ++"\n"
    ++"\n"
     +"> Please review the rest of the bug report below.\n"
     +"> You can delete any lines you don't wish to share.\n");
      
    @@ builtin/bugreport.c: static const char * const bugreport_usage[] = {
      	return 0;
     
      ## t/t0091-bugreport.sh ##
    -@@ t/t0091-bugreport.sh: test_expect_success 'create a report' '
    - test_expect_success 'report contains wanted template (before first section)' '
    - 	sed -ne "/^\[/q;p" git-bugreport-format.txt >actual &&
    +@@ t/t0091-bugreport.sh: test_expect_success 'report contains wanted template (before first section)' '
      	cat >expect <<-\EOF &&
    --	Thank you for filling out a Git bug report!
    --	Please answer the following questions to help us understand your issue.
    -+	> Thank you for filling out a Git bug report!
    -+	> Please answer the following questions to help us understand your issue.
    + 	Thank you for filling out a Git bug report!
    + 	Please answer the following questions to help us understand your issue.
    ++	There are three blank lines after each question; please write your
    ++	response on the second line and keep a blank line betweeen the question
    ++	and the answer (beginning and end).
      
     -	What did you do before the bug happened? (Steps to reproduce your issue)
     +	> What did you do before the bug happened? (Steps to reproduce your issue)
      
     -	What did you expect to happen? (Expected behavior)
    -+	> What did you expect to happen? (Expected behavior)
      
     -	What happened instead? (Actual behavior)
    -+	> What happened instead? (Actual behavior)
      
     -	What'\''s different between what you expected and what actually happened?
    -+	> What'\''s different between what you expected and what actually happened?
    ++	> What did you expect to happen? (Expected behavior)
      
     -	Anything else you want to add:
    -+	> Anything else you want to add:
      
     -	Please review the rest of the bug report below.
     -	You can delete any lines you don'\''t wish to share.
    ++
    ++	> What happened instead? (Actual behavior)
    ++
    ++
    ++
    ++	> What'\''s different between what you expected and what actually happened?
    ++
    ++
    ++
    ++	> Anything else you want to add:
    ++
    ++
    ++
     +	> Please review the rest of the bug report below.
     +	> You can delete any lines you don'\''t wish to share.
      

base-commit: 724518f3884d8707c5f51428ba98c115818229b8
-- 
2.50.1

