Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9230F943
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345982; cv=none; b=exLFoosmcBO03H9U22881OK+sB6MJyXYrIyr8Ka8iRjfat9IqzH9TzbRXWb1EsD0ss+QM4/6goWl+4viW7R7zXBbobh7AL4rz0g4MYlqR4B6TekdOV12Rw40ahwWhQzliRTABWr85sJMQJz6HtZ+rTsQ99iT8zFq2VHTBFlsTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345982; c=relaxed/simple;
	bh=/gN/ggXE3Ykbf27hQvr1HmBpK5a23UJ0MlGUrb7Bu4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFpGwG5kiPeD+tRYKoRcQzfUqiIeFwy74EsPwiIaNfBOkCEHAb2iggNfAKNxvGOKJh6vkASm1//X4FDNRLlz1Jt3D6tHo15dXgTSFq9448bQluEqM2U8tjnZjC9pEH5qvoXdn0O1hO84OouU/mCQbXjdR/Q82mBaWnJhtjZ9aTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Y1hdLvt0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GNjp8NOu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Y1hdLvt0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GNjp8NOu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 00AF0EC00D6;
	Mon,  8 Sep 2025 11:39:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 08 Sep 2025 11:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757345979;
	 x=1757432379; bh=orPfxwheKyKrIWdNaJQ1S9z7ip1qtf2aZFhLKDxBVO4=; b=
	Y1hdLvt0QmZfVhY3L6MPiamSlENaA/v11H8CXmdHGVqbIcuNdBMZCHOJUR8vNXeI
	+a1gM6RJgAJqPFOoN7D5WlwLTx+ioSzIKh7oOhZrz5PaV5xCEhL4JK1Lbulbk2du
	PCv9I/VyZx/XGnxnr2DzOaIz/GFwDa8FDFOQiyBBRhTWYydU9dwRVJ21RtR8XcR2
	itE9J4ST7U9kukD4IYx8lFr6JlrfihD8ouPg3WC+kDnABcnTurUwhtO2XlJyDTC2
	k5wIcifWYFolmCQ86q23FtVIAXVbvUiWVDDCiLFx59BS2erFtrthyMZXk/2/71ve
	MYK65dTDs5bDGMHUbbID/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757345979; x=
	1757432379; bh=orPfxwheKyKrIWdNaJQ1S9z7ip1qtf2aZFhLKDxBVO4=; b=G
	Njp8NOu75Xz8pJeHyFlAxILSvLbqia/X+9QlFEHWDpSHgL6b2vqD1bz4Okid7lJL
	NSECbcgf/+1q1eQR/1gZawINhQLvr2BIcHxw3MS/ulPXDofjIsIXznxTI9K4i4gB
	WgBO3eYpdjWi6vrLBRRMtvFA4jL4NOxJGqfKRb60CsCkRWy0kWnhfwZRsSoic9e8
	pw6JlyJdNYAzGm5dKh3y5bM34HV81uTWYZAiEOChX3MMr07/XQUxnEaeaC3QUmWA
	IjxuuARwIXD2lcqEpf/K3rRFT9NQqZAzhvsR02VTPmoyvHGbog16PdIGwR30OD3g
	6SOuHO3koe/QZ06lkt+tw==
X-ME-Sender: <xms:u_i-aNveNhcXUb9TMReVdF57a-oULJK1S8n9sYgo4ErI1r8B2FXMMa4>
    <xme:u_i-aBCzY_hcRYYZPij87zTTS7YT_rsJoEnJt_SzRYtI14NB01Ug_UwIRnlDUYXfl
    B663qHVzrwRHs3rWA>
X-ME-Received: <xmr:u_i-aNWrMyEq4s-IL_7AUv6S3SCxofMns-X9ECY_xM4P8kjMOwGqPsysaY4n_qi6XfgAtEhxmWVaPuNxOsz1oKMF39faE5XneXtIvkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepieegvdffvedvvdetjedtieeigeejjeelgfeugfevlefhtedvieeiteehvedtiedt
    necuffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    epgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:u_i-aHC9_lrOmbyGTxJ7Kd6H9FwBxw2D4Ba1Ksu1IHzxFCd0S7yqUQ>
    <xmx:u_i-aI-Wf66lLi8_zec2UMdVnqrCOUreVSDsu4nvGI25aK_8URtC3A>
    <xmx:u_i-aGGoVkNRu7qJDC6QmWq_14kNvF-jOIj4gXsk1VEmpq8pgkWKxQ>
    <xmx:u_i-aOO9xflYCpmnCldF5HFobTvi3Cu5oCrDlWtf4OhLYKq_8wTuDA>
    <xmx:u_i-aC-AcopF6vKnNTkNzjqUpzMJZzp1rl3E1b7JwcQPVMAkw1u9GaiH>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 11:39:38 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net
Subject: [PATCH v3 5/8] you-still-use-that??: help the user help themselves
Date: Mon,  8 Sep 2025 17:36:16 +0200
Message-ID: <d25ee26f98930a5ce02663ea7316ff1c5158dcce.1757345711.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757345711.git.code@khaugsbakk.name>
References: <cover.1756480827.git.code@khaugsbakk.name> <cover.1757345711.git.code@khaugsbakk.name>
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

