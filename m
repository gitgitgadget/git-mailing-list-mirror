Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623314F117
	for <git@vger.kernel.org>; Mon, 12 May 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076597; cv=none; b=Ty0eKqCAv6a14OtewTMY4IpY+Md/h0e/Sv1wgMNCHIB5tfKPXbNVdApb3fh+3vBB80250z1FJdYxIq8L0aUZG4mKbhlj8YKGxcTYoLLEsAbCXjd/3SU+I+muH8HHXzqZnDgb7LByj8v+h7J0RF6D6N2XtDC6KwcfsfekzG97zG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076597; c=relaxed/simple;
	bh=4MKByQnPSFp0RqQVr3hv7QXi1CEERK5ebtzIniM6CYQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrkPaQ5ezeVGAo08qleRdstEDTL62yk0434nAOQTc96xBHR9hEc58BBYzbLxG5IlnGAztkEEUNMLHs5UQ3BpGJDWYLcz32OPhbeQx/+27KQxTwGVqWnbiosZ8Gwx+OTmadJB2h22KykSaOPr8E7e/b2re/h+oSyoC1HhlaOcfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IxybmG3n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCNxXs/9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IxybmG3n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCNxXs/9"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA9B711400EE;
	Mon, 12 May 2025 15:03:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 12 May 2025 15:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1747076593; x=
	1747162993; bh=CrlAEhrlAongqSle3F6i4Lsn40y+mn1FN+dGNVLEJvA=; b=I
	xybmG3nndZJ7wwSDNf6qz3zOM1qq5w03Epz4/Eck831KCYcd6RyJ5wOgWCzSFMS3
	N0e2Z4IhXbmdewKcblTrIUUG1dJ3XG5jElD2HYgsZnAx1fyzrcPYrZKojrbhqjkp
	LEk/kycIb2PnXAE6MPUmoTGwzO4oya2sWzR6oDsblb/U4Y284uIqUiGt9aAAOirj
	t/gkaFQKWL37GUpLI33vYsp21GHIiLPKO1d4iWnV69lBgUIRZqAJHIZleqG83Ajy
	mRjpWDTW9yrmjRDZFVkZHfDGaoZMLWoBJDh4b4LzI2u1rQBEgFGuvLn5KEHkU/mc
	1JEh5hCMAuA0+JyLE5dDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1747076593; x=1747162993; bh=CrlAEhrlAongqSle3F6i4Lsn40y+
	mn1FN+dGNVLEJvA=; b=cCNxXs/99HG/ZSXcQtV4ckca66azUvququAIgmMfGuSR
	qLkNzZMQTInfGn1Hd+jxbhjduODIJXQV8nF79czOni0OTck2QlfMM5OVgo6qHaeh
	GVjkoFuTgxrLYzZDgz5YLKoAHLC48HEChAFfz4GelFgin0eyrz4iQ1afK2qMpYN1
	SvCYFxPl5g8OcyeR0eOqxl1ZYah4aca897R9bMEVv7r4eB4IQRF5vBPKho8vZPpf
	rC5ru0MAyF9t3kD/EdIrOIVyhDBn9aLb8lt89H5Cgb1V3SakXjS3zIVTxCEnrEcU
	bjOi8WvX19KpgVRdibWIR6MWZ9YGS1VJMw3AhNi+XQ==
X-ME-Sender: <xms:8UUiaMLvSI9H960t-umUM6udnPZLSfhzk3PaDt_FvPuzm7yE_RO1PA>
    <xme:8UUiaMJ9RBRFoHl8KiuxqDQiZZwTK_tX-SHtRGkKrnbqp9eLMjFugBpqBYhGYYZ2d
    JYDmMHBSD0N7NCHGA>
X-ME-Received: <xmr:8UUiaMsvXkwNBJNyKENIrtKwYgJlcZQAfkO8J0pYB6ua-0AhC0Cwu8hPs0UXP4xrJqB3GtOSspRKEiCiqB2bcR-ohTIcEcHoT_in4y8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8UUiaJYnEoH9kLJC_uypPa3pEtaqDBLCMbuTskeMyz3ZCNbl1kYlKw>
    <xmx:8UUiaDZj1xJqIP-Xqi9bHRgLiWKn5ktHZVbcvG93tMqw7t5XCbjuLA>
    <xmx:8UUiaFBehlPkGTpBSZpvf49FMpCfbBRpWDHA-qV-VLt7xgqmf7MZzQ>
    <xmx:8UUiaJaZTw3sZHEWcaek6hUhGiC1yGebItJZAMlEePY_nDy0U4pwuw>
    <xmx:8UUiaAITC32fXcffe8ouq6NzlsvPKFXhQrZca0p6iJ4LrBon0Z3NxLLF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 15:03:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 0/6] Nominating "whatchanged" for removal
Date: Mon, 12 May 2025 12:03:05 -0700
Message-ID: <20250512190311.1451556-1-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-674-gc1e4f99c0b
In-Reply-To: <20250503005814.3030099-1-gitster@pobox.com>
References: <20250503005814.3030099-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git whatchanged" has outlived its usefulness when "git log" with
various diff-related options more than 10 years ago.  It is not even
shorter to type than its rough equivalent "git log --raw".  It is
high time to start seeing if it is still being used, declare its
official deprecation, and announce its removal in the future.

This iteration is more complete than the previous two iterations:

 * The first step is to refactor the mechanism to show the message
   to ask users to contact git@vger that they still use the command,
   out of "git pack-redundant" implementation.  This message is
   shown when the "--i-still-use-this" option is not passed to a
   command that requires it.

 * The second and the third step are to remove unnecessary mentions
   of "whatchanged" from our documentation and tests.  With these,
   we have fewer places that we need to adjust when the command gets
   truly removed.

 * Then we start to require that the "--i-still-use-this" option is
   passed from the command line.  This requires adjustment for tests
   that protect the behaviour of the command, as they must now pass
   the required option just like end-users.

 * The last two steps are for a future.  In order to make sure that
   we can cleanly ditch the feature at some future date by removing
   it from the build, test, and documentation when Git is built with
   WITH_BREAKING_CHANGES.  And finally we add "whatchanged" to the
   list of features to be removed in the BreakingChanges document.

This iteration incorporates updated log messages, and a missing
period in the documentation, helped by Elijah.


Junio C Hamano (6):
  you-still-use-that??: help deprecating commands for removal
  doc: prepare for a world without whatchanged
  tests: prepare for a world without whatchanged
  whatchanged: require --i-still-use-this
  whatchanged: remove when built with WITH_BREAKING_CHANGES
  whatschanged: list it in BreakingChanges document

 Documentation/BreakingChanges.adoc           |  9 ++++++
 Documentation/MyFirstObjectWalk.adoc         |  4 +--
 Documentation/config/format.adoc             |  6 ++++
 Documentation/config/log.adoc                | 11 +++++--
 Documentation/git-whatchanged.adoc           | 10 ++++--
 Documentation/pretty-options.adoc            |  5 +++
 Documentation/rev-list-options.adoc          |  9 ++++--
 Documentation/technical/sparse-checkout.adoc |  2 +-
 Documentation/user-manual.adoc               |  2 +-
 builtin/log.c                                | 19 +++++++++++
 builtin/pack-redundant.c                     | 10 ++----
 git-compat-util.h                            |  2 ++
 git.c                                        |  2 ++
 t/t4013-diff-various.sh                      | 27 ++++++++++++++--
 t/t4202-log.sh                               | 34 ++++++++++++++------
 t/t5323-pack-redundant.sh                    |  5 +++
 t/t9300-fast-import.sh                       | 12 +++----
 t/t9301-fast-import-notes.sh                 |  2 +-
 usage.c                                      | 12 +++++++
 19 files changed, 146 insertions(+), 37 deletions(-)

Range-diff against v3:
1:  a43a2ffdab ! 1:  fedbc30d0e you-still-use-that??: help deprecating commands for removal
    @@ Metadata
      ## Commit message ##
         you-still-use-that??: help deprecating commands for removal
     
    -    A command slated for removal like "git pack-redundant" gains a
    -    command line option "--i-still-use-this", and refuses to work when
    -    the option is not given.  The message and the instruction upon
    -    seeing what to do are both rather long, so before letting another
    -    command to use the same mechanism, factor out the message+die part
    -    into a small helper function, and use that.
    +    Commands slated for removal like "git pack-redundant" now require
    +    an explicit "--i-still-use-this" option to run.  This is to
    +    discourage casual use and surface their pending deprecation to
    +    users.
     
    -    The existing pack-redundant test lacked a test to make sure that we
    -    require the --i-still-use-this option.  Add one while we are at it.
    +    The warning message is long, so factor it into a helper function
    +    you_still_use_that() to simplify reuse by other commands.
    +
    +    Also add a missing test to ensure this enforcement works for
    +    "pack-redundant".
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
2:  16ccf7d92e ! 2:  7a3897acca doc: prepare for a world without whatchanged
    @@ Metadata
      ## Commit message ##
         doc: prepare for a world without whatchanged
     
    -    These documents mention "whatchanged" as an example, that can be
    -    substituted by something else.  A new hypothetical command "walken"
    -    would come near "whatchanged" but since the latter may be going
    -    away, we can say it would come near "version", as the fictitious
    -    command sorts between them.  Similarly, we do not have to use
    -    "whatchanged" as an example of a subcommand that is also implemented
    -    in builtin/log.c file; we can instead mention "show".
    -
    -    Both of these changes allow us not to worry about adjusting these
    -    places when "whatchanged" is finally removed.
    +    Some documentation examples reference "whatchanged", either as a
    +    placeholder command or an example of source structure.
    +
    +    To reduce the need for future edits when `whatchanged` is removed,
    +    replace these references with alternatives:
    +
    +     - In `MyFirstObjectWalk.adoc`, use `version` as the nearby anchor
    +       point for `walken`, instead of `whatchanged`.
    +
    +     - In `user-manual.adoc`, cite `show` instead of `whatchanged` as
    +       a command whose source lives in the same file as `log`.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
3:  6951fb8cef ! 3:  f696eed84b tests: prepare for a world without whatchanged
    @@ Commit message
         Some tests on fast-import run "git whatchanged" without even
         checking the output from the command.  It is tempting to remove the
         calls altogether since they are not doing anything useful, but they
    -    presumably were placed while the tests were developed to manually
    +    presumably were added there while the tests were developed to manually
         sanity check which paths were touched.
     
         Replace these calls with "git log --raw", which is a rough
4:  2775f628c3 = 4:  01d4ed9acd whatchanged: require --i-still-use-this
5:  b3d4d1f46a = 5:  a7aca55d5d whatchanged: remove when built with WITH_BREAKING_CHANGES
6:  7c89054731 ! 6:  9d60f38d2f whatschanged: list it in BreakingChanges document
    @@ Documentation/BreakingChanges.adoc: references.
     +  `--i-still-use-this` option is given, and asked the users to report
     +  when they do so.  So far there hasn't been a single complaint.
     ++
    -+The command will be removed
    ++The command will be removed.
     +
      == Superseded features that will not be deprecated
      
-- 
2.49.0-674-gc1e4f99c0b

