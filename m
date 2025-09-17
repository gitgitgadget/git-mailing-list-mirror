Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA61A1A9F86
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140834; cv=none; b=Y4cQ6TZlvFs8GVk5+QVSnVMsw4twN1q5pD0FrwKrWuDu+k6NpWNyBx9tjsBPY3kFsn2SqPXGQvC4tBU2AVXFAr4O2TbiPkFdhR/wnZmso/pDMxvRn1jAJFgUcXiYBqyYW7Pt1OHWrqPzyTmFESqiL5jdAW/8tDJ9Wo0ouIWXPXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140834; c=relaxed/simple;
	bh=YQ//KIjRuaX3S0g+SDB1TegCf1pHjmDZbWfy0Ommi/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrHQRrDwQ4mT7/NZuCwgD311u74RYeXCiGmzgI7aV/s0dq7inzklYVPOBu45mDkeQySk05NtOpU/dNbpT0ORn8jRBaB0pm3GEtYRyCkZb8wII4TuTNA3KPYRrgbyIlGK/SkicrC3+e41FVJyyi/qUKSanC7L/pbutrVL0NTYrm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dKxZWvLW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X3kS1O/t; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dKxZWvLW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X3kS1O/t"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5E391400206;
	Wed, 17 Sep 2025 16:27:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 17 Sep 2025 16:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758140831;
	 x=1758227231; bh=1b/GTEc0AsAkLHkI8GvOM6H0XoLAtWndKxgnhzWt61U=; b=
	dKxZWvLWHr6PV9yhAj/9OXeBR+N15xoUyv0s1QeqqCd8sYSh2lGh/imJ6o/g6vCj
	izwx4ILcdYFNisKOxsI8GMom+6fzIP96Lw/EiTztbWo9ZCotW/+OQmOjm8mi8Ocz
	6KpT/rCEVzIuTJU5Z2iVw/vS+VsGbGkMCUmJo2ZkefmOjHxQXsvyaC7KVxAYwFJF
	rVWxbgEJzAlZmpX+codjtOuMBoW14zhIPltSCau1Syyc1QoEK+psbV8cEIopmucq
	O6Ml0Sh3kldnAxZHKAgv0/ERJHGeS3M6FMVx19iELgWHhem+vuZPTUhJg81KzfBO
	THo4F2q6TLiPNd7OhgJIaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758140831; x=
	1758227231; bh=1b/GTEc0AsAkLHkI8GvOM6H0XoLAtWndKxgnhzWt61U=; b=X
	3kS1O/t1/9kXQbXHxmAkPJHbzuw+YWhPZ6Sa0qYrAagpxQGBucKdYkRE1s57w0rK
	CncHQCcxow2aiFgiNEz2RaaqA+whUV6PMJtMauqXNFaeU1YkO5ObzJhm4bphyWx4
	fdG5gHmkL36Y0tiV7sQDBzCvRtgS2dNXYiT7wv0jT0xYA6/E1Tl56YpgfYmyhBOw
	tt/OlTgobs2vIO5E6TFLfC2TFMp2iYc1ifBBdsFYMjqEuiisJ5h7pGidAlIEyj92
	ygTiF0hAGnMy3wLwXXW4Hp75PWttzXctpH2LMMsWPvyE5lEW0Ym1rDGWTmVH79DL
	w6BiOsZuL+sINJ7yyQ3BA==
X-ME-Sender: <xms:nxnLaJuwye0h8IbuSn_Oz3FYH71NwOgFfNF5Fi6wCY6g_BARSACCs9k>
    <xme:nxnLaLzjXJDN0tfmF2BuWwP9xRTkWEkxp6LQ5qJGw6S7FuoKYUvm8Zlq94Ioddf-Z
    syERsPfr6ZxSkhHxQ>
X-ME-Received: <xmr:nxnLaECu7UsewlhiuNSM_97dcmzamrW8fYU2hg256QHn_Swv9gSYR4KlSTS8TEksxhGRqGIPKVLJjc3vlgt6Adn2TBlyV1QsOMlix2e4S3pxQDI9msYtWHkxqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeegudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:nxnLaBfQ8JBy7JFUt3Nsm4ygsSh4aZ8Hpig-8-H9JZhR4ncWXO507g>
    <xmx:nxnLaGm6ueav7_Z-_jmZG7CqYp1kCV4gCn9zUL9z6wpULmnbeM5ZnA>
    <xmx:nxnLaAG5KAAs9FGRDZwvWg14e_q6dxnp5-xLST-TKGLOrVC7d9Hk5g>
    <xmx:nxnLaG6Hvf2Nb6cYqiMYzedEOh0sS5DZAlUuHjGbge37_5mkhR1eMQ>
    <xmx:nxnLaJ9qLikCtz0_0iAVAWZvBKbxnwVKkhKsY4snwox6IpmYswz9OBth>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 16:27:09 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 6/9] you-still-use-that??: help the user help themselves
Date: Wed, 17 Sep 2025 22:24:16 +0200
Message-ID: <74998.1758139856.short.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.274.gdcb64e51a0f
In-Reply-To: <cover.1758139856.short.code@khaugsbakk.name>
References: <cover.1757879060.git.code@khaugsbakk.name> <cover.1758139856.short.code@khaugsbakk.name>
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
2.51.0.274.gdcb64e51a0f

