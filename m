Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257612CD8B
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990449; cv=none; b=cQVCQOdkerWbsuNewY5R8VJcLuFXTdR7BU/X2wHN7ZOf5qD1xO0quBjuPwuoTs1HBgv3hzvC1o/4C8svGptD/sfw8MEEfNeAO9gCMbo89pIqGZupjoFroKWwRcxVaHDsY9XD2qjELqBNsISPqP1oUVP7WHWfUrNbn4JuT31NyZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990449; c=relaxed/simple;
	bh=y540aCT0yYyBGjgkeCdWC8nOTGMk/Y36aotqyi6ttWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FzgC369k4WFjjj1D2rlZFGlvCbXd+g8CsYWmK3slKc9dQma0GZA5Gpahbj4S89I1BdveVPvvvV3TfIr7bAnUvqc/nL8JP4pwxH1KEtL3Gnn7cFuP2oWf9Ct/uvy5fridoF5bJkC4a+I3OaWLmvQfxRajoJepYVKYnT6Ra6WFjaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e3KaKtc6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PvU+Gfhm; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e3KaKtc6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PvU+Gfhm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C3A67A0281;
	Tue,  8 Jul 2025 12:00:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 12:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751990446;
	 x=1752076846; bh=/Nw18WT95XE/UoVcTR5Vb7BYJ9lA2xIri2UZjc3E1AY=; b=
	e3KaKtc6W1ic7YUUPnAZ+XWtJAEWe+BKOVqMR9ru/FoOb+9mr1EG4tuXrDZZxCxx
	jxrZXS6w7rgZ1t9A77ILr3xqbFry5Wyqr1iKv6BFOPjaE6Ylb4ZPJdVRG9EvaW/R
	Z+D1pyoV/E2uhZXU/arzH6mY0ZRbZZotsOMPnmtAcVG58V1G192ttaTx76drdkM6
	OzWB1BvGgVS9yZkhLG9jC5ntdK1yiiD15B4GGd2ZvIfwSFgKPX+bUkhlGgJfJ3gp
	yrIr5qvouBy0Xsf2JvPl2AmJxUrtEpARBKip6TyNKGylMoomAkYIRaLoMbJMpb5Y
	PfgyvFyayX6LfCx5dfO+9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751990446; x=
	1752076846; bh=/Nw18WT95XE/UoVcTR5Vb7BYJ9lA2xIri2UZjc3E1AY=; b=P
	vU+Gfhmo43YWgbxiGOO6K55N7JpNRK2oj4vRKBdKyx02nhKtF8RSnVilXZYfSgYX
	83AfKl4/RUr9yB8YWW/a1opqC5Xy5NoqYpAYagbjHCCO3SqTKn2XJSVXq5NHu8QA
	Ue2thG7VCaqKxu0MiuUC+MG2hsL1RYqY7/CPq/ssnEUZpcOxWQgEhkHbLwlnWNuL
	R6xRzo3iLAcVaWjmCMyP2Nbo6hQjRD8zzckU9GjiB15mPqup5qXmwggVAgdBX0Yq
	JDapGDgTjizkhq28agEgj8NSxB+sE8WUr4iH7IEwnuz65rzcqlnupHvDX98G7q5I
	Li6sTddjWKxZu7T5AwTMg==
X-ME-Sender: <xms:rUBtaPbvzc-UC0TUBpGdvClu--JHot2oJnInw5T-3oD3NMAF0Lk30A>
    <xme:rUBtaBo4jD9QDl8XpQuL6li3UKS7f0LDSEdhMlD-bTo9UABHSKVv1VBRZXNGEVicv
    6nNJpOk6cgTYRznvA>
X-ME-Received: <xmr:rUBtaLbC3TVXpBlzO5mpEOtgde0QtAyWVM3-aj9S8CSeOv1u4Fh6Jqs1smdGqS0M7OxPCKSozpGFJdlIy7kPxt88wHIuC7ZzxFOniec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjmhdrrghr
    mhhijhhordhfsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rUBtaBTnhOp2yEXDYoIl9ut2OxDZT-mJDVDYG3vXI_03mVVq-ZCnsw>
    <xmx:rUBtaK7cM6sU9lUs15JGV_ouLMrNK1dg2lD-VXP6W3-zAfpNZg4uBw>
    <xmx:rUBtaOxTlD-klVywz8nW8mIcK9KwzYK1MaAou3dGl5kxj8mKI_n5uA>
    <xmx:rUBtaBSETL7XuknoyLV3A5MfT5vaGpSN4qNc2lVC0BDSrrLMpg4UIw>
    <xmx:rkBtaCQRVGj9Y7Ml0iM7plJcqZZwqHRRp-NLJXR13Ww8Id3QQmQgIYh5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 12:00:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jos=C3=A9?= Miguel Armijo Fidalgo <jm.armijo.f@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: "git stash create" ignores "message" argument
In-Reply-To: <CAKMuBmQadPerSrOsMmLkJzPChr0TWRH3dy1mRYFx4Hfn6DoBPw@mail.gmail.com>
	(=?utf-8?Q?=22Jos=C3=A9?= Miguel Armijo Fidalgo"'s message of "Tue, 8 Jul
 2025 16:26:49
	+1000")
References: <CAKMuBmSeFh63212_GhBHfOTbW5VaqvQjo7jz4aowm8bntCXkVw@mail.gmail.com>
	<f9a6c8a1-bdbe-4892-bb71-39a6307a5452@ryz.dev>
	<CAKMuBmQadPerSrOsMmLkJzPChr0TWRH3dy1mRYFx4Hfn6DoBPw@mail.gmail.com>
Date: Tue, 08 Jul 2025 09:00:44 -0700
Message-ID: <xmqqv7o2wu37.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

José Miguel Armijo Fidalgo <jm.armijo.f@gmail.com> writes:

>> You won't see the custom message in `git stash list`
> If this is working as expected, maybe this is a documentation bug?

The documentation says "a short description of the commit the entry
was based on", which dates back to pretty much the day one of the
stash command 09ccdb63 (Document git-stash, 2007-07-01), and hasn't
been updated or enhanced at all ever since.

Back then, the world was simpler.  The command has a single very
focused purpose: I am in the middle of doing something, my boss
descends on me, I say "git stash" to clear away everything I am
doing so that I can start working on a totally different thing and I
want to do so as quickly as possible---without even wasting any time
to write any "commit log message".

So "a short description" was just that.  Automatically generated
identifier to let you identify the stash entry, so that you can get
back to the state immediately before that emergency.  As long as
what is shown serves that purpose, I would say it is working as
expected, as you are not even supposed to _care_ what that message
exactly say ;-)

Readers may compare today's documentation and the original at
09ccdb63 and they will notice that, even the explanation of the
`list` subcommand hasn't changed much, the accompanying example has.
That comes from the code change made at ec96e0f6 (Document "git
stash message...", 2007-07-17) when the command learned "git stash
[save] <message>" to quickly leave a custom note.  The description
for the command overall was updated to say that by default we say
"WIP on ..." but a custom message can be used, but the commit did
not update the description for `list`, so the wording "the commit
the entry was based on" was left behind, which may be a
documentation bug.

It is also a bit unfortunate that "git stash create <message>" is
exposed without enough documentation.  The only reason that
subcommand exists is to allow scripts to reimplement "git stash
save/push -m <message>", which internally (1) creates a commit that
is to be used as a stash entry and (2) stores it as a stash entry in
the refs/stash.  Since both of these suboperations need some
message, "git stash save/push" take a single message and use that
for both.  Anybody who is emulating save/push by using create
followed by store can do the same, i.e. use the same message, but
that is not documented clearly.

We may want to update the documentation to say something like the
attached patch.

 Documentation/git-stash.adoc | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git c/Documentation/git-stash.adoc w/Documentation/git-stash.adoc
index e5e6c9d37f..e7a9165b71 100644
--- c/Documentation/git-stash.adoc
+++ w/Documentation/git-stash.adoc
@@ -38,9 +38,9 @@ The modifications stashed away by this command can be listed with
 `git stash list`, inspected with `git stash show`, and restored
 (potentially on top of a different commit) with `git stash apply`.
 Calling `git stash` without any arguments is equivalent to `git stash push`.
-A stash is by default listed as "WIP on 'branchname' ...", but
-you can give a more descriptive message on the command line when
-you create one.
+A stash is by default given "WIP on 'branchname' ..." as its message, but
+you can give a more descriptive message on the command line when you run
+"git stash push", "git stash save", or "git stash store".
 
 The latest stash you created is stored in `refs/stash`; older
 stashes are found in the reflog of this reference and can be named using
@@ -76,7 +76,8 @@ list [<log-options>]::
 
 	List the stash entries that you currently have.  Each 'stash entry' is
 	listed with its name (e.g. `stash@{0}` is the latest entry, `stash@{1}` is
-	the one before, etc.), the name of the branch that was current when the
+	the one before, etc.), and the message given to the entry with `save`,
+	`push`, or `store` when the
 	entry was made, and a short description of the commit the entry was
 	based on.
 +
@@ -146,8 +147,11 @@ create::
 	Create a stash entry (which is a regular commit object) and
 	return its object name, without storing it anywhere in the ref
 	namespace.
-	This is intended to be useful for scripts.  It is probably not
-	the command you want to use; see "push" above.
+	This is intended to be useful for scripts.  It actually takes
+	a _<message>_ argument, but that is for the sole consumption
+	for internal use by `push` and `save` command, so it is not 
+	documented here.  This is probably not the command you want
+	to use; see "push" above.
 
 store::
 
