Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2F437F758
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889463; cv=none; b=kG8VFnPo6FA9xuEfUb/MmubVPhmqjkVCipw9vPN2qwCYlN4fVr42HGdzxcQhQ/wKmWNHU82+UkHPiAz5ftXNYKA95/Ktu0CWTy7P9lpJ15CTa88gp9X8x4jB4LSq7uhziHLmQRQkv3hgR/k6EIEhSjl3MNj8glaRbRIR534Dk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889463; c=relaxed/simple;
	bh=7QKKvZ32WbtOydUNei4z/VIGXQfpPg1O1+W4UeJebjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0KU11W4RPjS7H3+gwd/pCWGjRbHEYltbIESUHey5Z/RSN8f1Om5TTWlo1LUI7rBTK2/OqrvgceH9yfbOGogNzurn1F76YrnhjbuHMmtKGvXqszbdBDix2EMMLh71S11WWsBf6qtSUI9KFfDlu6bGO2/cgAXb5GlZFADE7hmssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BXhWVU98; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vLaaPpGt; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BXhWVU98";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vLaaPpGt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B2195140022E;
	Mon, 23 Feb 2026 18:31:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 18:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771889461;
	 x=1771975861; bh=4r5tYyNXFDfqOY6FnjSBajVE0DgPXQ2lB5mu2Q+tl6s=; b=
	BXhWVU98emZWEa4ptcsZGC61ZL5e+AkZFNAxrNuUTWLM1frQ8foKg77ai2pVzvTv
	WfJwUdQf66uXfdwd8MPAo9HmtSpQRFEvrIjyU6vpz/SRZTb/0o+XtQuW32EboGit
	MIwXUxf2J1IyeLPU7RIwXkUr+z3TAo0Y/PfaIhKkvP4eZAJDFUN5oI1XIrFK/PFH
	SIYkoDlRrYotfUEFBU4UwVYccCjTlkqbKEeR0JNZ3S90SxSS1qqEUOftOvyh9weL
	vRT+ivUtQjWGCAyd93Ggd6BEvJ/NGj2egKbzPAN1VvBKl498bwtOAB8gcKUA7Qkd
	7s2PJLRN527oRODIvWCAMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771889461; x=
	1771975861; bh=4r5tYyNXFDfqOY6FnjSBajVE0DgPXQ2lB5mu2Q+tl6s=; b=v
	LaaPpGt6HG9nZJ8XrVZd6vBSHXJPrA/coyIzDrhMa+d+QpY69t5ihlhwKIdwtOuR
	ooO25Oo9VUs0xD57IK2zHk+Z3QQ7MUBEpcj6MNx0VK/FYB1kcsVMfNEj1mSQTv4U
	do56YG+0Q8dIHNF1iSI99tZjl1zsrvvNBZpV5Qf5DAqz8craU1NLX49p+4/NiNrY
	4MABAWk3FnfNhKvKks4YT5374Atj49zndmaJDjX/BajMIyUpKtSyTXQYCbdt0GdA
	sBh7VXFjlL+LtE1Lm6EDalT2UQSXmxK8mbXDTQqYaSvDkHaPz5AbWRuvUtn9C/Hz
	AslfWrGan6hirbM7U9bbw==
X-ME-Sender: <xms:NeOcaZjuVjJ2_OXKBtVLnuG1uXNcYLhPMp5ONgYppxODAy341CTEqSE>
    <xme:NeOcaVceUv8v1BAUSB1wm6-GVkkL_-DH6BbOddJ8R2k0Q5Dh_SiH1lqpKxwZSlqqs
    DjKzA7RaXSrA2Gu-h-aQ6B161KHrFaI7fOEkN-9ZYOR8JLNoz_aRA>
X-ME-Received: <xmr:NeOcaWcd6xtXOHZfeq0hrNzhZTtnb3s83QnlrCEUYUnkDeOYMZfM-euBbOKaI635H8c5wT0qFnJvphYX5whqPNtVL0dZdgVKBEs91cmTOkILphicc8lRlXzCwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgf
    euieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvght
X-ME-Proxy: <xmx:NeOcaX-SRHXP4AuDN9wsJYsje1d0163OJpuHkU-XJm1YQHR9VIKhWg>
    <xmx:NeOcaan1RSPhyIdD-LkxVi4MWivZwFdHM-LvixvK3fP0ehx7Q-KFHA>
    <xmx:NeOcaR_w3O8xizGaq2kBJx-Azh8Yq6Rrjy8Y6ovECSKzBD8YTzOI0w>
    <xmx:NeOcaQkhNU2Uj6dGZBQG4Gg5DNKkeeJ5v_RspwJhXoHJTrW2xjnSxA>
    <xmx:NeOcaQMaSGxdtvtDWn5BRliB8UMjilg3WePnK1TqhghOO_h9mH_NwP4L>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 18:31:00 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] format-patch: make boolean and mention in diff-options.adoc
Date: Tue, 24 Feb 2026 00:30:49 +0100
Message-ID: <V2_CV_format.noprefix_boolean.421@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <CV_format.noprefix_boolean.39c@msgid.xyz>
References: <CV_format.noprefix_boolean.39c@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

See: https://lore.kernel.org/git/a9602602-5fea-40c0-a505-34133ed4d58c@app.fastmail.com/

Topic name (applied): kh/format-patch-noprefix-is-boolean

Topic summary: The config `format.noprefix` should act like a
boolean. But now it is active no matter what the value is. Change it to
act like a boolean like `diff.noprefix`. Also mention it instead of
`diff.noprefix` in git-format-patch(1) doc.

§ Changes in v2

Got feedback from Junio.

Copied from note on Patch 1/2:

• Use `advise()` for the hint; you get the `hint:` prefix and color
• Rework the hint, or the advise, to say that any value *used to be*
  treated as `true`. That better helps people who maybe set `nope` when
  they meant, “no, I don’t want any prefix” (for example)

Also a commit message tweak on Patch 2/2.

§ Link to v1

https://lore.kernel.org/git/CV_format.noprefix_boolean.39c@msgid.xyz/

§ Breaking change (unchanged since v1)

This is a breaking change. But I have opted to die if the config is not
a boolean and just hint about the change. See also Peff’s comment on
such a breaking change in that link.

I have also asked here about marking breaking changes:

https://lore.kernel.org/git/3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page/T/#ma8856238748d0794a0da6c64e1c0c8a4824b996f

Kristoffer Haugsbakk (2):
  format-patch: make format.noprefix a boolean
  doc: diff-options.adoc: show format.noprefix for format-patch

 Documentation/diff-options.adoc |  4 +++-
 builtin/log.c                   | 14 +++++++++++++-
 t/t4014-format-patch.sh         | 16 ++++++++++++++++
 3 files changed, 32 insertions(+), 2 deletions(-)

Interdiff against v1:
diff --git a/builtin/log.c b/builtin/log.c
index e56af7465ae..275122b807e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -40,6 +40,7 @@
 #include "mailmap.h"
 #include "progress.h"
 #include "commit-slab.h"
+#include "advice.h"
 
 #include "commit-reach.h"
 #include "range-diff.h"
@@ -1101,11 +1102,11 @@ static int git_format_config(const char *var, const char *value,
 			int status = die_message(
 				_("bad boolean config value '%s' for '%s'"),
 				value, var);
-			fprintf(stderr,
-				_("hint: '%s' used to accept any value but "
-				  "now only\n"
-				  "hint: accepts boolean values, like '%s'\n"),
-				var, "diff.noprefix");
+			advise(_("'%s' used to accept any value and "
+				 "treat that as 'true'.\n"
+				 "Now it only accepts boolean values, "
+				 "like what '%s' does.\n"),
+			       var, "diff.noprefix");
 			exit(status);
 		}
 		return 0;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 645ac402a19..c20091e36fe 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2555,8 +2555,8 @@ test_expect_success 'format-patch --default-prefix overrides format.noprefix' '
 test_expect_success 'errors on format.noprefix which is not boolean' '
 	cat >expect <<-EOF &&
 	fatal: bad boolean config value ${SQ}not-a-bool${SQ} for ${SQ}format.noprefix${SQ}
-	hint: ${SQ}format.noprefix${SQ} used to accept any value but now only
-	hint: accepts boolean values, like ${SQ}diff.noprefix${SQ}
+	hint: ${SQ}format.noprefix${SQ} used to accept any value and treat that as ${SQ}true${SQ}.
+	hint: Now it only accepts boolean values, like what ${SQ}diff.noprefix${SQ} does.
 	EOF
 	test_must_fail git -c format.noprefix=not-a-bool \
 		format-patch -1 --stdout 2>actual &&
Range-diff against v1:
1:  49fa161a392 ! 1:  eee61561eb3 format-patch: make format.noprefix a boolean
    @@ Commit message
           format.noprefix* (current behavior) will now have the opposite
           experience. Which is not a reasonable setup.
     
    -    Let’s only offer a breaking change fig leaf by hinting about the
    +    Let’s only offer a breaking change fig leaf by advising about the
         previous behavior before dying.
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## builtin/log.c ##
    +@@
    + #include "mailmap.h"
    + #include "progress.h"
    + #include "commit-slab.h"
    ++#include "advice.h"
    + 
    + #include "commit-reach.h"
    + #include "range-diff.h"
     @@ builtin/log.c: static int git_format_config(const char *var, const char *value,
      		return 0;
      	}
    @@ builtin/log.c: static int git_format_config(const char *var, const char *value,
     +			int status = die_message(
     +				_("bad boolean config value '%s' for '%s'"),
     +				value, var);
    -+			fprintf(stderr,
    -+				_("hint: '%s' used to accept any value but "
    -+				  "now only\n"
    -+				  "hint: accepts boolean values, like '%s'\n"),
    -+				var, "diff.noprefix");
    ++			advise(_("'%s' used to accept any value and "
    ++				 "treat that as 'true'.\n"
    ++				 "Now it only accepts boolean values, "
    ++				 "like what '%s' does.\n"),
    ++			       var, "diff.noprefix");
     +			exit(status);
     +		}
      		return 0;
    @@ t/t4014-format-patch.sh: test_expect_success 'format-patch respects format.nopre
     +test_expect_success 'errors on format.noprefix which is not boolean' '
     +	cat >expect <<-EOF &&
     +	fatal: bad boolean config value ${SQ}not-a-bool${SQ} for ${SQ}format.noprefix${SQ}
    -+	hint: ${SQ}format.noprefix${SQ} used to accept any value but now only
    -+	hint: accepts boolean values, like ${SQ}diff.noprefix${SQ}
    ++	hint: ${SQ}format.noprefix${SQ} used to accept any value and treat that as ${SQ}true${SQ}.
    ++	hint: Now it only accepts boolean values, like what ${SQ}diff.noprefix${SQ} does.
     +	EOF
     +	test_must_fail git -c format.noprefix=not-a-bool \
     +		format-patch -1 --stdout 2>actual &&
2:  0cef1915a9c ! 2:  b9b583bd007 doc: diff-options.adoc: show format.noprefix for format-patch
    @@ Commit message
         git-format-patch(1) uses `format.noprefix` and ignores `diff.noprefix`.
     
         The configuration variable `format.prefix` was added as an “escape
    -    hatch” because “it’s unlikely that anybody really wants format.
    +    hatch”, and “it’s unlikely that anybody really wants format.
         noprefix=true in the first place.”[1] Based on that there doesn’t
         seem to be a need to widely advertise this configuration variable.
     

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0.26.g2afa8602a26

