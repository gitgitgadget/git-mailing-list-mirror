Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612921A449
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447260; cv=none; b=hO/j41Fd7U6w9cvolM4IVEnfo562xoK+g4hgch7GioqxwdSJGcCby8ZuQADakRPIgRr8Nd+z5xg6+Pl0D39Uq2TLZ4c9jTOcUOLd380mVWULXRO4FWhWNATc12bHtlSlhyNg9GhdgGflIvhjYOG1nUQUww1kGmyHqcNo4IJRdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447260; c=relaxed/simple;
	bh=/gN/ggXE3Ykbf27hQvr1HmBpK5a23UJ0MlGUrb7Bu4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRdktaeuP/r+zOdVM6ExrPNhnwqQetuUSkulLgQwQtu5AAdnxSMrKAydLrtjU9l/dWoll63t3QUaL4tQdhLQvql9J1x1pTSWRIomqGsnrAKRwatHTW1yaioEBase2Fix8h2ENU4mK3W8GYkUALlgOVHZbD+2pNLxtX9Tfldpxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BfRoi4RW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZL8WHPbq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BfRoi4RW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZL8WHPbq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 608F0EC00CC;
	Tue,  9 Sep 2025 15:47:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 15:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757447257;
	 x=1757533657; bh=orPfxwheKyKrIWdNaJQ1S9z7ip1qtf2aZFhLKDxBVO4=; b=
	BfRoi4RWs4rfa2jHlwYvusgBclrf3jK6DTbzal97MUrZClhSR9R+sJhT9fBvMhX6
	gYJ6gTordBCleyfV24p0CwifqhgaQ3PArbuIHiEWjH+BoIwuN9WlaaroINmh6/G8
	EyAH9ot3ToYMJK+axDkEG508psiqGE/1ey0S2Tp/iH2VtHdJt2FKJl14QfD4lb8S
	6XkMPHfcCJLHHQ63UFUz3w0kHjbqEEwjjoM/WDAQ+qOYJXr1TQuaGVOlgXsgv1nW
	ECnyqgyS/Xpt5Y58mAIC/oBFxzWmisqMssrp1VKlWybFZvkx1BSMV2xJE9MEqwGr
	UixujJS2lVIo1s8V4sP5mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757447257; x=
	1757533657; bh=orPfxwheKyKrIWdNaJQ1S9z7ip1qtf2aZFhLKDxBVO4=; b=Z
	L8WHPbqCz11FI+jcDHjjT4D9zZ/6gKQEl8kPqtU/jBhWbg4vtP4YoDx/P/vmwmHH
	F7ffn6idrxOcPPVgllUa/8iFgBaQmXdf1COli313WVYe6q9DoZvHbyxEJ5OnBVXb
	JcZVVKOBXhsU/3PM8NKzk7UqWsY7h7EP/v6MU37LEOTOxabWHkoWJMGHjS617Ol7
	l9spvA4A8+o4LWkdVSowSfYNjgmIuRHEMiI/eKfgZkpOtk2B57LFJdPxNqMcmiFx
	YVl/bwgTFShkz67sv+MZ6aQ972r0SKgvUF2kXF4ZBXaQYjbQde6bcLBuMqz0Bq6K
	tFh8qT8uvPYfrb0iyf1fw==
X-ME-Sender: <xms:WYTAaHlkzcgrK3ti_hDLpwc4NRrQ5vmLj6U6wK05rMnhNGbYpu_zRLI>
    <xme:WYTAaGUQVzjKFTHvblqujd_1ReDcg0EVa6-yA02z6_FbObcPoXnZo2zwR0cNyXGKg
    fMRopnuMSRZ3XxD7w>
X-ME-Received: <xmr:WYTAaEHjiW6mMxnhPe1tactK8ZJoYMzU-FxZDp4rdkEVC5koxyjEaAykzdNAxxZaMUr81KnCF0rVtfO3rafwkeu3CJuZuLFq1oMnDrYge8H4vAEUfN_eOrquzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepieegvdffvedvvdetjedtieeigeejjeelgfeugfevlefhtedvieeiteehvedtiedt
    necuffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    ephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WYTAaKfl4wVYTc8yufY7ZMBPw7ndJMucgv9S8W7_RK5t95sPs19KgA>
    <xmx:WYTAaNIrTc7cb8edCP-1nynjW1ywud5dt57JMYvkY64A68jjtbDLdA>
    <xmx:WYTAaHGcCwTg8g6A81DYRPAmznkdoShDS98iMObe0sBO-U00BLKS6g>
    <xmx:WYTAaIBjHFUu1wwFwkx5OQbyAznQzN5R46L65qGcYorMMyOCilE8yQ>
    <xmx:WYTAaONKBsH9m9-MtILAVt3BCxJns1teL0nGX7p9GHPwA9IyHQ79dFsy>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 15:47:35 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 4/7] you-still-use-that??: help the user help themselves
Date: Tue,  9 Sep 2025 21:45:54 +0200
Message-ID: <6bdcaf7f80f48a10cea75ea179e6f06d8b998fbb.1757446619.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757446619.git.code@khaugsbakk.name>
References: <cover.1757345711.git.code@khaugsbakk.name> <cover.1757446619.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Give the user a list of suggestions for what to do when they run a
deprecated command.

The first order of action will be to check the breaking changes
document;[1] this short error message says nothing about why this
command is deprecated, and in any case going into any kind of detail
might overwhelm the user.

Then they can find out if this has been discussed on the mailing list.
Then users who e.g. are using git-whatchanged(1) can learn that this is
arguably a plug-in replacement:

    git log <opts> --raw --no-merges

Finally they are invited to send an email to the mailing list.

Also drop the “please add” part in favor of just using the “refusing”
die-message; these two would have been right after each other in this
new version.

Also drop “Thanks” since it now would require a new paragraph.

[1]: www.git-scm.com has a disclaimer for these internal documents that
    says that “This information is specific to the Git project”.  That’s
    misleading in this particular case.  But users are unlikely to get
    discouraged from reading about why they (or their programs) cannot run a
    command any more; it clearly concerns them.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    
    I had second thoughts about the bullet point about send-an-email.
    Change it to the one Eric Sunshine proposed;[1] make sure to spell
    out that you can send an email conditioned on not finding a suitable
    replacement.
    
    Also change the area to something more pointed.
    
    And also use a clear URL to refer to www.git-scm.com.
    
    [1]: https://lore.kernel.org/git/CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com/
    
    • Change send-an-email bullet point
    • Change the area
    • Use www.git-scm.com, not simply git-scm
    
    v1:
    
    An alternative to linking to www.git-scm.com is to move this document to
    a regular installed man page:
    
        gitbreaking-changes(7)
    
    What do you think?
    
    I would then have to base my topic on the in-flight
    pw/3.0-commentchar-auto-deprecation, which in turn depends on
    ps/config-wo-the-repository.
    
    Or just wait a bit for these to settle in.

 usage.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/usage.c b/usage.c
index 81913236a4a..35dc57eb07e 100644
--- a/usage.c
+++ b/usage.c
@@ -7,6 +7,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "trace2.h"
+#include "strbuf.h"
 
 static void vfreportf(FILE *f, const char *prefix, const char *err, va_list params)
 {
@@ -377,12 +378,24 @@ void bug_fl(const char *file, int line, const char *fmt, ...)
 
 NORETURN void you_still_use_that(const char *command_name)
 {
+	struct strbuf percent_encoded = STRBUF_INIT;
+	strbuf_add_percentencode(&percent_encoded,
+				 command_name,
+				 STRBUF_ENCODE_SLASH);
+
 	fprintf(stderr,
 		_("'%s' is nominated for removal.\n"
-		  "If you still use this command, please add an extra\n"
-		  "option, '--i-still-use-this', on the command line\n"
-		  "and let us know you still use it by sending an e-mail\n"
-		  "to <git@vger.kernel.org>.  Thanks.\n"),
-		command_name);
+		  "If you still use this command, here's what you can do:\n"
+		  "\n"
+		  "- read https://git-scm.com/docs/BreakingChanges.html\n"
+		  "- check if anyone has discussed this on the mailing\n"
+		  "  list and if they came up with something that can\n"
+		  "  help you: https://lore.kernel.org/git/?q=%s\n"
+		  "- send an email to <git@vger.kernel.org> to let us\n"
+		  "  know that you still use this command and were unable\n"
+		  "  to determine a suitable replacement\n"
+		  "\n"),
+		command_name, percent_encoded.buf);
+	strbuf_release(&percent_encoded);
 	die(_("refusing to run without --i-still-use-this"));
 }
-- 
2.51.0.16.gcd94ab5bf81

