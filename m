Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F82566E9
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140721; cv=none; b=YZ6NtMVPXVqT3cbZGoUCrl5B8OchI66UJ9QozA9+yrmRdcAFeYlD3ydM4PcpMXekpKf+sOKW3RST4ppxqes3Hm2ZTp7wz7UEd2KKTKf0zPq6gQ6YAV01evVkXLh6emDBEB9slOv7vJQReXmiRp1mgqhZtlK6fFvoZY5VtBxqRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140721; c=relaxed/simple;
	bh=5waXIm4IEFWs22eijnHaa6swZncCBo4wumaV0pqrXM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUWtIXEJDv8ma+pGJCV8AFOKFlljnt27hVVB8fdEBmYNiu/qNziYq2cfou8NlxU4e5C6xYxFa8TcibnpPyWTJFh6aGYQjh453sXF+23fUp3xNqULfHGgQ7k7x74T9LDMe2nIaXFVdm0izj3uNOCzCb0g6VfGVAxvVEIQkBbgMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=B5sRuJ3Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iMDl3I4W; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="B5sRuJ3Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMDl3I4W"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id E5E6AEC027B;
	Wed, 17 Sep 2025 16:25:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 17 Sep 2025 16:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758140717;
	 x=1758227117; bh=bYn/FAEhRTahzj6D9rKi3aMD2pijJs8gpTcIcF5beyc=; b=
	B5sRuJ3YlC5hPoeJCgYPDgjjg+7v6Jj86BZv8Q9RO4zrK8jhQThyxC8M8V4WEIhN
	7pSSm3u0JDVGeA4JHHFHXQ/8mPsTlfCt0OrExqPxdNLLDRZX9GDiAptwzmH5ENeR
	BRsPxy+pnMW0YH4i8f9k/duBNBjc1r8d5di5U1N9LZAWmpRQEdX0u/7/itkCEiW9
	FJC6iQVia4wrI7A7omx8rFxL0xwXxCyZt/I7utPLBSgjBJ8BgjzexvrSgvKimEdQ
	SeG3kLz2pHkdjedgbs7akZFjSWhLG9tP+CJsOzL0mjDprTFP7h6nU5GE8P9obwJ+
	NTxaGl9OxAwN0GQuGcSb5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758140717; x=
	1758227117; bh=bYn/FAEhRTahzj6D9rKi3aMD2pijJs8gpTcIcF5beyc=; b=i
	MDl3I4W9x9YnHFszN6eEBFLnnCB7so77QYtIup2ALabFK5yiKcGtZeYeUZ9xLHt4
	i/siCyUvoIgijQvJxGk2CXAGfSyBnnf9Ud/KN7PYVjnetAQxrCqyfCjRioayIBMZ
	8NvRBsKD6UwpKQT+vin/GICn+3z/Cx05IwJHEvgxnBD7gHfSZcR+LeYy+QVKbxp9
	b1a7bFGfDdoDR3b9I1KHlZ8Iqlm35Fu3ELBuKJzStO7FcysimO7i1KVfs6xDRpzH
	E72KTeDlhndnMIR9seYF18KhA02uKbRJucAg+/19RMM821LBn1bihR+086w5EBma
	65eQWaPmI85qf8t+QcD3A==
X-ME-Sender: <xms:LRnLaDRaxVo0bZDtfgSD6AOPJLba9aw-EJ98SKSAc_COVlP2Ridphos>
    <xme:LRnLaNN6xX2P27Hd2pSvXAc3A76-zKlbl9QbjX5ay1EJQ-4wC8NY6LLucew58E15P
    OEw_-ex2ohsh9EdDA>
X-ME-Received: <xmr:LRnLaJRN4BEvCGps1poH8iw-4vzRxreUe5x4WFelkaF6EwB-PwnOwaJAg0mbQiez8nvwL3gOPAn9Azk-BQjt3cpms0D-r26hp-hZC2um4_NQJ2-th9dZcglMNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeegtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:LRnLaDjPGWUrtvYZAXkRtvFzHi8UfZO1zv4sxVs_Mf7FmNRHG2Df2A>
    <xmx:LRnLaK-p-WJgf3lEic2KpMPO6BK-JbbNQgv2GykK8OTagakbfYhCKA>
    <xmx:LRnLaCHwHLBvattW-E9pzp5Y3WvGikk2nPgbMBTPxPgurPeOLNk3eA>
    <xmx:LRnLaFnoSfeEPfH8dAkkg3uWF3ly1_MaoFXI1FnvO6C_jx7pL92DtA>
    <xmx:LRnLaHoG9v4DdAf8h8Eb1V7-OEyuf_G2HkiR6moLR9Cux6dA-BPkCxSu>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 16:25:15 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 0/9] you-still-use-that??: improve breaking changes troubleshooting
Date: Wed, 17 Sep 2025 22:24:10 +0200
Message-ID: <cover.1758139856.short.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.274.gdcb64e51a0f
In-Reply-To: <cover.1757879060.git.code@khaugsbakk.name>
References: <cover.1757879060.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Based on the recent i-still-use-that reports about whatchanged, improve
the error reporting with this command in mind:

1. Give more possible actions instead of just (only) asking them to send
   an email
2. Hint how to replace their git-whatchanged(1) use with git-log(1) or
   an alias `whatchanged` (you can alias deprecated commands now)
3. Minor documentation changes
4. Add `deprecated` to `git --list-cmds`
5. (new in v6) Don’t list git-whatchanged(1) as a builtin when
   `WITH_BREAKING_CHANGES`

§ What the errors now look like

    $ ./git whatchanged
    'git whatchanged' is nominated for removal.

    hint: You can replace 'git whatchanged <opts>' with:
    hint:   git log <opts> --raw --no-merges
    hint: Or make an alias:
    hint:   git config set --global alias.whatchanged 'log --raw --no-merges'

    If you still use this command, here's what you can do:

    - read https://git-scm.com/docs/BreakingChanges.html
    - check if anyone has discussed this on the mailing
      list and if they came up with something that can
      help you: https://lore.kernel.org/git/?q=git%20whatchanged
    - send an email to <git@vger.kernel.org> to let us
      know that you still use this command and were unable
      to determine a suitable replacement

    fatal: refusing to run without --i-still-use-this
    $ ./git pack-redundant
    'git pack-redundant' is nominated for removal.
    If you still use this command, here's what you can do:

    - read https://git-scm.com/docs/BreakingChanges.html
    - check if anyone has discussed this on the mailing
      list and if they came up with something that can
      help you: https://lore.kernel.org/git/?q=git%20pack-redundant
    - send an email to <git@vger.kernel.org> to let us
      know that you still use this command and were unable
      to determine a suitable replacement

    fatal: refusing to run without --i-still-use-this

§ Changes in v6

Use Peff’s patch to get rid of “the extra output”.[1]  Update commit
messages to not mention that.

Also use another fix from Peff (patch 1); don’t list git-whatchanged(1)
as a builtin when `WITH_BREAKING_CHANGES`.

🔗 1: https://lore.kernel.org/git/cover.1757446619.git.code@khaugsbakk.name/T/#mb3ac9c32c8527675a1f9cdf7709f2c74b3dd2a6c

Thanks

Kristoffer Haugsbakk (9):
  Makefile: don’t add whatchanged after it has been removed
  git: add `deprecated` category to --list-cmds
  git: move seen-alias bookkeeping into handle_alias(...)
  git: allow alias-shadowing deprecated builtins
  t0014: test shadowing of aliases for a sample of builtins
  you-still-use-that??: help the user help themselves
  whatchanged: hint about git-log(1) and aliasing
  whatchanged: remove not-even-shorter clause
  BreakingChanges: remove claim about whatchanged reports

 Documentation/BreakingChanges.adoc |  2 +-
 Documentation/config/alias.adoc    |  3 +-
 Documentation/git-whatchanged.adoc |  8 ++-
 Documentation/git.adoc             |  3 +-
 Makefile                           |  2 +
 builtin/log.c                      |  8 ++-
 builtin/pack-redundant.c           |  2 +-
 git-compat-util.h                  |  2 +-
 git.c                              | 91 ++++++++++++++++++++----------
 t/t0014-alias.sh                   | 57 +++++++++++++++++++
 usage.c                            | 33 ++++++++---
 11 files changed, 165 insertions(+), 46 deletions(-)

Interdiff against v5:
diff --git a/Makefile b/Makefile
index e11340c1ae7..9311da5bb15 100644
--- a/Makefile
+++ b/Makefile
@@ -883,7 +883,9 @@ BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-switch$X
 BUILT_INS += git-version$X
+ifndef WITH_BREAKING_CHANGES
 BUILT_INS += git-whatchanged$X
+endif
 
 # what 'all' will build but not install in gitexecdir
 OTHER_PROGRAMS += git$X
diff --git a/git.c b/git.c
index 1310363e5c4..8c85da84c30 100644
--- a/git.c
+++ b/git.c
@@ -425,7 +425,10 @@ static int handle_alias(struct strvec *args, struct string_list *expanded_aliase
 		if (!strcmp(alias_command, new_argv[0]))
 			die(_("recursive alias: %s"), alias_command);
 
-		seen = unsorted_string_list_lookup(expanded_aliases, args->v[0]);
+		string_list_append(expanded_aliases, alias_command);
+		seen = unsorted_string_list_lookup(expanded_aliases,
+						   new_argv[0]);
+
 		if (seen) {
 			struct strbuf sb = STRBUF_INIT;
 			for (size_t i = 0; i < expanded_aliases->nr; i++) {
@@ -441,8 +444,6 @@ static int handle_alias(struct strvec *args, struct string_list *expanded_aliase
 			      " not terminate:%s"), expanded_aliases->items[0].string, sb.buf);
 		}
 
-		string_list_append(expanded_aliases, args->v[0]);
-
 		trace_argv_printf(new_argv,
 				  "trace: alias expansion: %s =>",
 				  alias_command);
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 1ac739a2737..07a53e7366e 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -33,7 +33,6 @@ test_expect_success 'looping aliases - deprecated builtins' '
 	cat >expect <<-EOF &&
 	${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
 	${SQ}pack-redundant${SQ} is aliased to ${SQ}whatchanged${SQ}
-	${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
 	fatal: alias loop detected: expansion of ${SQ}whatchanged${SQ} does not terminate:
 	  whatchanged <==
 	  pack-redundant ==>
Range-diff against v5:
 -:  ----------- >  1:  8b34edf876e Makefile: don’t add whatchanged after it has been removed
 1:  13682553018 =  2:  c10a24018ce git: add `deprecated` category to --list-cmds
 2:  7f82ef6e96f !  3:  90e35bfc063 git: move seen-alias bookkeeping into handle_alias(...)
    @@ Commit message
         The code in the `while(1)` speculatively adds commands to the list
         before finding out if it’s an alias.  Let’s instead move it inside
         `handle_alias(...)`—where it conceptually belongs anyway—and in turn
    -    only run this logic when we have found an alias.[2][3]
    +    only run this logic when we have found an alias.[2]
     
         [1]: We will do that with an additional call to `handle_alias(1)` inside
             the loop.  *Not* moving this code leaves a blind spot; we will miss
             alias looping crafted via deprecated builtin names
         [2]: Also rename the list to a more descriptive name
    -    [3]: The error output `'<cmd1>' is aliased to '<cmd2>'` is used for the
    -        `<cmd2> -h` case.  We will get one more (redundant) line of output
    -        in the case of alias looping; that is covered in the test “looping
    -        aliases - deprecated builtins” in the next commit
     
         Based-on-patch-by: Jeff King <peff@peff.net>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v6:
    +
    +    Apply Peff’s patch[1] in order to get rid of the extra output line.
    +
    +    Drop the footnote from the commit message now that we don’t have that
    +    problem any more.
    +
    +    🔗 1: https://lore.kernel.org/git/cover.1757446619.git.code@khaugsbakk.name/T/#mb3ac9c32c8527675a1f9cdf7709f2c74b3dd2a6c
    +
         v5 (new):
     
         Do a preliminary code movement in order to avoid loop aliasing in the
    @@ git.c: static int handle_alias(struct strvec *args)
      		if (!strcmp(alias_command, new_argv[0]))
      			die(_("recursive alias: %s"), alias_command);
      
    -+		seen = unsorted_string_list_lookup(expanded_aliases, args->v[0]);
    ++		string_list_append(expanded_aliases, alias_command);
    ++		seen = unsorted_string_list_lookup(expanded_aliases,
    ++						   new_argv[0]);
    ++
     +		if (seen) {
     +			struct strbuf sb = STRBUF_INIT;
     +			for (size_t i = 0; i < expanded_aliases->nr; i++) {
    @@ git.c: static int handle_alias(struct strvec *args)
     +			die(_("alias loop detected: expansion of '%s' does"
     +			      " not terminate:%s"), expanded_aliases->items[0].string, sb.buf);
     +		}
    -+
    -+		string_list_append(expanded_aliases, args->v[0]);
     +
      		trace_argv_printf(new_argv,
      				  "trace: alias expansion: %s =>",
 3:  4bfe36cccd0 !  4:  2cac74d731c git: allow alias-shadowing deprecated builtins
    @@ Commit message
         the command is removed for good.
     
         Let’s lift this limitation by allowing *deprecated* builtins to be
    -    shadowed by aliases.[4]
    +    shadowed by aliases.
     
         The only observed demand for aliasing has been for git-whatchanged(1),
         not for git-pack-redundant(1).  But let’s be consistent and treat all
    @@ Commit message
              have empty commits (no changes)[2]
         [2]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.net/
         [3]: https://lore.kernel.org/git/BL3P221MB0449288C8B0FA448A227FD48833AA@BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM/
    -    [4]: The test “looping aliases - deprecated builtins” covers the
    -        case of the extra output mentioned in footnote number 3 of the
    -        previous commit
     
         Based-on-patch-by: Jeff King <peff@peff.net>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v6:
    +
    +    Drop footnote now that we don’t have the “extra output line” problem.
    +
         v5:
     
         Fix a leak caused by calling `alias_lookup(...)` without freeing the
    @@ t/t0014-alias.sh: test_expect_success 'looping aliases - internal execution' '
     +	cat >expect <<-EOF &&
     +	${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
     +	${SQ}pack-redundant${SQ} is aliased to ${SQ}whatchanged${SQ}
    -+	${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
     +	fatal: alias loop detected: expansion of ${SQ}whatchanged${SQ} does not terminate:
     +	  whatchanged <==
     +	  pack-redundant ==>
 4:  a04c6ae968e =  5:  3576439add5 t0014: test shadowing of aliases for a sample of builtins
 5:  2f78ab2e28c =  6:  7499890ed49 you-still-use-that??: help the user help themselves
 6:  34443066645 =  7:  b0831e8967a whatchanged: hint about git-log(1) and aliasing
 7:  b0aabd793f0 =  8:  2f281944fbf whatchanged: remove not-even-shorter clause
 8:  5021647c245 =  9:  7dc3d03d626 BreakingChanges: remove claim about whatchanged reports

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0.274.gdcb64e51a0f

