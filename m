Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A58275B19
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879522; cv=none; b=Q43XA+gCKqPe5/cSmdz1vinpc7P6QzEdV781Ygp+YCHHZRUozb/7oBWkCtuEgOi/YeFzpgwf/IlArA6tjvUROqLjswZ0JXB/yD0UtkFBTv3tbKriTSyYNLoKljG4tCy+NBmFdSb79filYvLMBpQJ5fS9QR1mzWXO/nWx6mR2CmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879522; c=relaxed/simple;
	bh=/gN/ggXE3Ykbf27hQvr1HmBpK5a23UJ0MlGUrb7Bu4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEog43K3zp0JpaHCTtPlWwzcQa5HOhd1HZopuHO/XGwuRdvZDrjSsGiOwX+O+/EwCR3RQzheziTqK3Wycm1Tc5KUdxTZ4Ace4uw8aWbzysE+MNQF931GV1WloDlntQDVzVqJLt/wNzsTbFgbYKemdYcA+3jJ63NaUkGzx2q4o2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ChFoepR8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X8rdphq6; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ChFoepR8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X8rdphq6"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC13A7A0060;
	Sun, 14 Sep 2025 15:51:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 14 Sep 2025 15:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757879519;
	 x=1757965919; bh=orPfxwheKyKrIWdNaJQ1S9z7ip1qtf2aZFhLKDxBVO4=; b=
	ChFoepR8LyytS2PsWPu6caswRlHfdNmrP7OLgps/gnPdc6modnlmEAjUCj51DZIM
	Qa7VuECbZ3dqn/YwOHm2YUZO+rXHkR2T50euz2h6sI3GShseHWiko37o1DOfJhjm
	7lS7WZ0HeKDvmjZ9I0kt6Emg7n8ayfVpHo85GXVhT2Iw5Vjq98a8EEbw7chIrCzA
	2TkWoYC53OXseSbw/a8vB8tDQ84Dwb6ISkkmC+IVJCQ1bfx6Tdn2p6QbMgVbr4Ex
	EXxlpqCgupR7XjBlsy/Bzpi8XrJlZHp35IyY0vpvnm0HFu6e3E2/GvUaWjND71rP
	EpOeOrTlp7NWu5Cjoyylug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757879519; x=
	1757965919; bh=orPfxwheKyKrIWdNaJQ1S9z7ip1qtf2aZFhLKDxBVO4=; b=X
	8rdphq67cMLxB9C9SHVmnN7bd1Ws6n7GF2YwoFqgLs4y0MW348XkoBP/7uE44IGv
	zR0UaRRzMqoed5s5xevVdeVvh6SyINgL86FHKGD6Icg1WCZDq6aarAGUk1mrZgJu
	pmIgtJrH/XbK5o5ZNoSwyMNd4ulpUfYy8L48c8uoA9guAIwt4LTv9fTjjCQ41qP7
	nV1A/rRTFYqSr7uF5oO6RR8n8GBFXUCfElj8ATe/Y1mVC5Yk9XPkcPaBVw2dwSOI
	2JbQ5W3pbE4ypXaTShisNdVIfj6iT62yP6I2NF/6Ml9odj3tTnMlEbWimZZyN4/U
	3G9bC4n9s6gLvzuO1bsSA==
X-ME-Sender: <xms:3xzHaDyAOPN8UApAY_Z8jwyKgnsM8ZgUYL5An9w_M9yiJD04zAD9ugg>
    <xme:3xzHaDvcV9pLmPQu2YkfrV4lvW73KO0yzcwj2TjIrZl3Llgr3ePOuMD6eDyW4XYvP
    fCErFd1WPFHLcvNew>
X-ME-Received: <xmr:3xzHaNw2l_sNtQ4HepTNPnmrfWKW68umAYhdUedRwSQCuO5Xqbu4Qy_SAZV4jlCJ1E8Tg6crXIF7zrOkOtstwb2VEbS2bPB6cmu3qv3n7HETjnkqKkJVcSmUOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepieegvdffvedvvdetjedtieeigeejjeelgfeugfevlefhtedvieeiteehvedtiedt
    necuffhomhgrihhnpehgihhtqdhstghmrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    epiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:3xzHaODS8bsGENSD0vaWh0OKQ5b38MYlSZK4Uj33EOaL34t3NbW16A>
    <xmx:3xzHaDcoHH87EREjWe31-GRNlucL_q6djzyPe7Yn7t041UtLxHcXSw>
    <xmx:3xzHaAkA2z3kSIyK5ceA4mLn63Fwypx5TNHOB8SlksY0BsYiqClPDg>
    <xmx:3xzHaCEeYe1TMqmmlFPgeaNA6RfCXB-A7ZfDFWFJgX8PjULp-IqJww>
    <xmx:3xzHaILbP8OQ9beldG4wGJM3oXaJR-B39ra6Bqwz9AtFbQgq5xZ4KQzX>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:51:58 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 5/8] you-still-use-that??: help the user help themselves
Date: Sun, 14 Sep 2025 21:49:39 +0200
Message-ID: <2f78ab2e28c64f05d807cb9460fa62eb1011a57f.1757879060.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757879060.git.code@khaugsbakk.name>
References: <cover.1757446619.git.code@khaugsbakk.name> <cover.1757879060.git.code@khaugsbakk.name>
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

