Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D42914AD2D
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312228; cv=none; b=P8Dyc4TSLi4l28GNc9lQk/3qjurka0eL44WfDm1fHfSZO2B7wiu+pKN78AnmJV+VmrYoMOxCGNgFfBhScUe4VIz6mQCVXl4mpEKYrfO9VoeFKfr0iNE/UNGwV60UL6vgrDIthfHeV2Tf5dCZcgnj1+mIG6kPO7xmkPdgYvxZ2sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312228; c=relaxed/simple;
	bh=nmYMsL20Kb+PbY1agnCJ7pWEQv0WDcTNHaB5ATteqnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1vtbJRSHuOu03/oRiaCRZ2X5WDeEgTbvp4Foa5XJhfQB9UTobFbirNdbhKehXZkBQ3hviPHcXHm9USHuhsQAtJem3pLqtKEt4geX9LApGM3X6xsTF07gdPZsq7CIKtxN7XT88v3080YfFg8D4cL8V2CLu5N33IXDgNk7WPW4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gPWBxZbo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WzztextY; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gPWBxZbo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WzztextY"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C25E2EC03A5;
	Wed, 27 Aug 2025 12:30:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 27 Aug 2025 12:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756312225;
	 x=1756398625; bh=tUAD46KvbDaXxi+WLgAkZDmBMlJgpbCyvC6ZQR8uf/0=; b=
	gPWBxZbotU/r8SMEgYmCzAKaZ5T8FVU+mjmiSNj48nHCpN0127Sjh7jMh2TdFGsu
	aTStssQXV855VqaW3qMs/Qlkvo9BJQr9JMbe9T61Hhnxz/REkdETIyqg9/KgLUlf
	/l01zNC8/Q6kvWnXZX8xLXtNIU3+MF/Zbk3vFHWu0t2+h6Z8BYRVCLKTDYwDaIqh
	us6vzihqrWF4Mj84U4YpeGbF+Uc/hcbG76w0SuNBjQSz7BO6TFliYKlfUaoMVLwr
	nLabr/S0ebSTZ27gTiANPh/qJzZrWgYIrAO3WPiA6fBuF8UUwQJI6xXbaPAwjClZ
	ypUb9BLPK9kN8bpydl+KxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756312225; x=
	1756398625; bh=tUAD46KvbDaXxi+WLgAkZDmBMlJgpbCyvC6ZQR8uf/0=; b=W
	zztextYASUWA+N1r+8FqRInAMMMQ5szJ3HWkC3icq2fpzUyVhxWqgyGTvzoqulyo
	o8fqcERQzExoEZJ1cDlf/0zTzWrBuzB8sOQLx49f1I6+2SFAqClyQxh/LLjVN/pF
	opyBkqEROIWaBMyv6FmJUMk/8zwXGZWN5oC2FY1TYQ8T4PZ0IRR7sFdwwFsLZyng
	o0+VFsBF1IAXrpSJrVGCrkKzjzAkJIssvSVPPidPrjiU4QYL1FjpH+/oUkquZt79
	RIDZofgq/iRaUXBZt55D+uTRmB2X2vqqFM+tnhAJ7Oa5GDdxWsrkLKDJncUVhRqm
	C/Aum23PB80bDEl927dDg==
X-ME-Sender: <xms:oTKvaLCCDgpLsG1Kt83jTMDKpu4aNlrrV9gFnpmEHczbeslbPIMY09o>
    <xme:oTKvaBu7IKDibAWEK6DIFuFerpwcfAujpzsHD8O5kY_teThXthGyQYbmhPSiX9zlw
    Y6BLoFCF4A6r54zug>
X-ME-Received: <xmr:oTKvaIY1yKTqxgyUotx-LfC6kMEiM2SOFzBQtDsnRZk1-juwOxBtA1WSw2346Y2AnBAASt0uGtQa8MLEHKQ8-ls2qsqUxVMZeVUkr3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesthekre
    dtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepieegvdffvedvvdetjedtieeigeejje
    elgfeugfevlefhtedvieeiteehvedtiedtnecuffhomhgrihhnpehgihhtqdhstghmrdgt
    ohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:oTKvaMWro34jHBincxFRgWByAHEJq7c81425LYr561EIDkXd9xSjOQ>
    <xmx:oTKvaE4MN8WREM3ylPGH0lo_e7R6gTQt16qk04SrqAQqSi_W7h9CLA>
    <xmx:oTKvaPgD-0REkPCw9DZBfHqZtUTRyf8vrDnT9ch1bQGWG4OFofpI6Q>
    <xmx:oTKvaDd4405xfertbcFLg5MnP8CTYi0coPA42fscp1aB1p5OEAE8QQ>
    <xmx:oTKvaFmWJh6QMBhMWpoML5XlgMXtWZ2reFz1XBiD1d_I1a4hZeRCyttZ>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 12:30:24 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/4] usage: help the user help themselves
Date: Wed, 27 Aug 2025 18:29:46 +0200
Message-ID: <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.11.g23cedd8a747
In-Reply-To: <cover.1756311355.git.code@khaugsbakk.name>
References: <cover.1756311355.git.code@khaugsbakk.name>
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

[1]: git-scm has a disclaimer for these internal documents that says
    that “This information is specific to the Git project”.  That’s
    misleading in this particular case.  But users are unlikely to get
    discouraged from reading about why they (or their programs) cannot
    run a command any more; it clearly concerns them.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    An alternative to linking to git-scm is to move this document to a
    regular installed man page:
    
        gitbreaking-changes(7)
    
    What do you think?
    
    I would then have to base my topic on the in-flight
    pw/3.0-commentchar-auto-deprecation, which in turn depends on
    ps/config-wo-the-repository.
    
    Or just wait a bit for these to settle in.

 usage.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/usage.c b/usage.c
index 81913236a4a..29988395f19 100644
--- a/usage.c
+++ b/usage.c
@@ -7,6 +7,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "trace2.h"
+#include "strbuf.h"
 
 static void vfreportf(FILE *f, const char *prefix, const char *err, va_list params)
 {
@@ -377,12 +378,22 @@ void bug_fl(const char *file, int line, const char *fmt, ...)
 
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
+		  "- send an email to <git@vger.kernel.org>\n"
+		  "\n"),
+		command_name, percent_encoded.buf);
+	strbuf_release(&percent_encoded);
 	die(_("refusing to run without --i-still-use-this"));
 }
-- 
2.51.0.11.g23cedd8a747

