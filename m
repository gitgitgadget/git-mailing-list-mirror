Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A802322A24
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480917; cv=none; b=jR9TzuXmn5giNVfhjRHafVxmIqLt2lckVSWwM8DG6+wULIQ0G5CxMfKt1MVYKfAR+jQPaqqYYkvtIWGC3EfWKGUCcSX0XB4z8pE84VgJ0h+5ZP+z0EH/azfoq0HC3y57Oal/dL3ZE1CabY2a/xieDHegT7PWOzW16GeX85IcOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480917; c=relaxed/simple;
	bh=/gN/ggXE3Ykbf27hQvr1HmBpK5a23UJ0MlGUrb7Bu4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbRStVLt4UrjYw1Z/104OMmbgkRBsU7mkL0p6Dv5EeLwO7WFmQYZedvPRj++wY7qf1eK+gvpyXxmMFlrdxpKIboW9w+JwZhjqsx24KKJ3myF/WenRbg/atKoOW6Icrq9H8/AFPomXp3JymwdGO9N3CZ9tHt0K5bZsSRJiwsJwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XB7vFuF7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kZGFPbgi; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XB7vFuF7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kZGFPbgi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A0D6FEC02E2;
	Fri, 29 Aug 2025 11:21:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 29 Aug 2025 11:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756480914;
	 x=1756567314; bh=orPfxwheKyKrIWdNaJQ1S9z7ip1qtf2aZFhLKDxBVO4=; b=
	XB7vFuF7JTLEpAu35Y4nBtw/H25ZNFBJJmI6x6VWK+A7w07AOtxuB0E7Se6w3Biu
	mZxl6vm/JU3Xb5hxLffQ/2oKV5HsDBrLms2KNL5+RL1R3RzmhkzFq1Gw7IjnOn7T
	ThRw5FISeH8cYgJr1G2UOJESeQI/GT42lLKHoEXviu/8e6TpUv2LOc474CtKLzmp
	lJN/uTwzXl2XcURqPtv+B/R1QfV/Khio+RcEzF6Eh8TD9YkK5c6McFi42aD7yMAo
	5P/gEUxop/j6lPXHsuJdoaO3djUvh20Fd2/oemBttxZEofSkUnMnifDoKH2Xm1pq
	6F960aRfVwnVQrEg6gLuhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756480914; x=
	1756567314; bh=orPfxwheKyKrIWdNaJQ1S9z7ip1qtf2aZFhLKDxBVO4=; b=k
	ZGFPbgiWVyCEGMpt3k1/RbYdSwAtEq2bT/3ONDFIwatbPqtN1VQF6PpA4x3+SXeL
	pNeigL8gr7T2olg9Vab9Ez+heYhsfDIUzdLVwJ2tHV13BLAaaVT8SHs1IlAWLUBR
	wFAQhYXLu+egmGmvaQ6TVAmHUpTRGpoz2nbITeunnUPFK2aLysl1BVxzKMrM6SSC
	Ng4VGCY6yDlZcYfBnLEKmaXJyAqkMHZi1ZPjUboEKlQAubERpctFBiMA5EEdFalk
	vPi/YBfrmQKB/sO19TjTi66EHler6fi/XN7V+Cmspi4D9s3hFJKKa5i/BddsLh3j
	EI67/7icsmwjDsR5MrjhA==
X-ME-Sender: <xms:ksWxaGSXIPseHeUDZr0hJbyMbThfShITObYQ5MSSMuvA9bJCwh7KYGo>
    <xme:ksWxaPBVkrGyTZ7EnzYaghUlkiUNk1HF87xUmU0h9X1hM0RDlm1oOJinafoVV3HEW
    DdomzddF8XxgRm93g>
X-ME-Received: <xmr:ksWxaNS6jlbS50UkD-NhChQuJ6tOvhKtPCzQt3sca38BFmvJz6UQYofFmOjUGxbFotWI4vYyj3AemL8o5yHauC_7fhu6mM6rtieDtuQWudsMjqVueD4nsLR5pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtth
    gvrhhnpeeigedvffevvddvteejtdeiieegjeejlefguefgveelhfetvdeiieetheevtdei
    tdenucffohhmrghinhepghhithdqshgtmhdrtghomhdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:ksWxaNp_cZT6BYoMvdxTdLsDgDoSsJ4v-p_725cUIHJZsnAUEEfc0Q>
    <xmx:ksWxaPzMuiArFVgVU6GfP7S7Vc1fcf7MzXsdtRWyOhGWDKK5MqZkLA>
    <xmx:ksWxaCK51rHwILZdKEUAfmWyY-CFIXDkxEV9cpZ2yThnkJggkME-fA>
    <xmx:ksWxaBIgSC1QCf5DKKNfhk6KG--iD5OFfzYO2kosPo3gTYrPTHNC2Q>
    <xmx:ksWxaCRl4vv6pq14bl166Cnlrh9CRRRmsoBqRKRMII_KGyqpeH_N-iHp>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 11:21:53 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/4] you-still-use-that??: help the user help themselves
Date: Fri, 29 Aug 2025 17:21:03 +0200
Message-ID: <6803e2cc6c32d8ef6b7e6ceadc9e1b1a9d17d7b0.1756480827.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1756480827.git.code@khaugsbakk.name>
References: <cover.1756311355.git.code@khaugsbakk.name> <cover.1756480827.git.code@khaugsbakk.name>
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

