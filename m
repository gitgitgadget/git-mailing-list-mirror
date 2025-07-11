Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3E24886C
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251835; cv=none; b=WyAehVHoL+2Vv+hdvlpjI6Hgn2uG52aif4Q5O8YwtYIxFs7gIhDvv8B6kIb3C77llmjqyZV3pWBFUDci3ogyMoQ15m0FogyFXXPvqc993seaxiiGx0oUNRw/rqW8GUVoJ+yrVRDZsuMwXUi4bp2hvA2AZPcVnKrhnADofOu27dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251835; c=relaxed/simple;
	bh=x0ylt7vssmQG606Xp6AOkujE5s8abWdyPizg8ttEqoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NtpS/gf8JRuYOwo9NHLWaM/ygv+DMSDvit8UIlwaa+9PSQ57MFrRvB9IZO6LDWDG2yF5Xq7mH06pCWERxCZUmPdbG5G5ei6VZAdRtUZaJ2K6+I3cUQY7FYb0cp5EDVlgblpU7TVHwOgYLRxRCocSI3gUqK+jmR6M0q87jZFiQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MPgRA+IS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NcS42045; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MPgRA+IS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NcS42045"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 79957EC024A;
	Fri, 11 Jul 2025 12:37:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 11 Jul 2025 12:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752251832; x=1752338232; bh=a2uxGH7v5b
	pyD/b8jxhHJbhyrShA+MG61Z0mLrNfvwE=; b=MPgRA+IS5TTpReKQTi2921E8s4
	eKsKbAE4n5moxdG44Qgf02hv0XxkOfypM+v1QRgg/uTiGlFeqZtQoMD47NX0rGvh
	Iua6GL3muXwMHY3PXGwcRLWemaaSiln6Y9V4Cx/q1kTb4VIcMJY2o60I5PprtiJI
	yX9i0GKhYOoSHzs8zT6k/rdbSfv6p2gRj3y0xSlA+XOk8aa3HPQts2qzFzWMVDu+
	QZyOXq7UNFeC0/p4XUEIlp7mvxFg4sTsvDT6vXPRu+SowoTt+z7ErdS6CYulBTag
	rZwo+NhFZz87IzV4Y+7Z32rYf3cSkdza9urXJZM9LwR3KC9Cx9+VjtestYHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752251832; x=1752338232; bh=a2uxGH7v5bpyD/b8jxhHJbhyrShA+MG61Z0
	mLrNfvwE=; b=NcS42045wgBvaJ/FnEoo9WcZE3MkS6HRHTOxRsHjN41hDNbF3sX
	TmYvG4ZH99kyItmLqrLTf6GHE41OwQtrROTx3dyt/GqcXv0TuvJb5ejH7OTkGgni
	saiWjwXzBuFiYDdPBdU/jFMu44smkaswEzJl0FFUJGhhRDkzDUnrulfgOAC6wft8
	4Ksuy1SmqU5Kr8gx7SpG5ZeQxV9xXc17PO8kc6bM+Er6XkzSU/fo9X9EaI0lHooS
	fn+txJsFSaxydfqOrAkGewDbuNteUySQNj2RQNfohniHJ+CiNHnTO4brOxLz00VD
	NEmNAEURrjmd1LbCAB9JGEWE/eaPptYUdNg==
X-ME-Sender: <xms:tz1xaD9bfGgEJcX27cotkZ_ZRvbY3JnJwGKOUxNca4B-vE7KCfFcCA>
    <xme:tz1xaNRPReLU1m80S4Cd-R-2yeOpQcKbD2b1FKqeI38F9tdp5x008TWKjDuTZiUSO
    LmMnRqpjrY-AmjRLg>
X-ME-Received: <xmr:tz1xaHfjWpuc0uJ0HCjjeZEIP6nJejeimIwTDpSA_sJ-ChBQTp07MP8xvK3dadOYAX4HqYcRI_KP50KC2BnQSv1CJikzS7L8SBnD9Gs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejfeekteegkedtjeevgeekudduudefhfdvueefieeuteetveelieelfeekveef
    ieenucffohhmrghinhephhhtthhpqdhpuhhshhhinhhithdquggsihhnshhtrgifvggsrd
    hshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tz1xaBCYePmMevKq6n2RGLi6o2_t5rJrqjcqNFRE7DS5MIhE6KD6LQ>
    <xmx:tz1xaJl-BPIKc7XQ1GviyQYYKf8ZlGaL9LTu1Dcj0GavGmMXNwsljw>
    <xmx:tz1xaMe4jez5m-_J_203JCmxRi1wuRrbjjNI9Id8h9eCeIUQsXuGmw>
    <xmx:tz1xaNRxN4R2NMRuDcsrTDIKLsBZqSwsN0pdVfnTOOBKWAEr5jv7Fw>
    <xmx:uD1xaHAY1EYfI5GvUU-7CBz2NlOdW18yeEOgMuPGR6PLUcPt63JIP51A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 12:37:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  chriscool@tuxfamily.org,
  christian.couder@gmail.com,  me@ttaylorr.com,  ps@pks.im
Subject: Re: [PATCH v3 6/7] t/t1517: move verify-commit -h test to t1517
In-Reply-To: <CAPSxiM_ZZrbFpgvxqYgZ8oeTbRs+HW=rM+9Dud0G_Qr7eq3=FA@mail.gmail.com>
	(Usman Akinyemi's message of "Fri, 11 Jul 2025 04:29:30 +0530")
References: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
	<20250706215039.715732-1-usmanakinyemi202@gmail.com>
	<20250706215039.715732-7-usmanakinyemi202@gmail.com>
	<xmqqtt3o3rqm.fsf@gitster.g>
	<CAPSxiM_ZZrbFpgvxqYgZ8oeTbRs+HW=rM+9Dud0G_Qr7eq3=FA@mail.gmail.com>
Date: Fri, 11 Jul 2025 09:37:10 -0700
Message-ID: <xmqqcya63cqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>> But in the longer run, we are very much likely that we'd want to
>> test something that needs things that require prerequisites (like
>> "do this only where XYZ is installed") but ought to work outside a
>> repository, which means t1517 would need to pull in things like
>> lib-gpg.sh only because it has a few tests about verify-blah
>> command.  These tend to accumulate over time.
>
> I understand the concern and I felt we should at least decide where to
> put the "verify -h" because, right now, we have some of them in the
> t1517 and also some in their respective test files.

If t1517 were only about "git subcmd -h outside a repository" for
various subcommands, that would be a happy arrangement.  I think we
even have a way to iterate over all Git subcommands, current or
future, so your patch may become "we've sprinkled 'subcmd -h' tests
in various scripts, but now t1517 will do that automatically so
anybody who add a new command do not have to do anything".

But if t1517 currently (before your series) already has other things
tested, that changes the story somewhat.  Especially if we aim for
the automated solution, we may want to move existing tests in 1517
that is not about "subcmd -h" out to different scripts.  Obvious
two choices are:

 - We spread them to existing test scripts for the command being
   tested (e.g. "does patch-id work correctly outside a repo?"
   moves to t4204-patch-id, and "does update-server-info work OK
   inside and outside a repo?" can be split and one half moves to
   t5200-update-server-info).

 - We move them all to a new test script that is dedicated for "do
   various subcommands work outside a repo to do things other than
   responding to '-h'?".

and I would favour the former.

The only reason why you moved these to t1517 is because the set-up
part of that script sets up the ceiling just once properly and let
its tests do as if they are running outsie a repository, and having
to arrange the ceiling correctly to add a few test in various
scripts so that each of these scripts can test their single
subcommand pretending that it is running outside a repository looked
cumbersome, right?  And I do agree with you, if that was the reason,
that it is annoying to have to set up the ceiling manually in each
test script.  But then can we do it less annoying?  We already made
a nongit test helper and it may be good enough to help existing
tests in t1517.

As an illustration, here is what the beginning of the former
approach may look like.


 t/t1517-outside-repo.sh       | 27 +++++++++++++++++++++------
 t/t5200-update-server-info.sh |  5 +++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git c/t/t1517-outside-repo.sh w/t/t1517-outside-repo.sh
index 6824581317..c1294d5761 100755
--- c/t/t1517-outside-repo.sh
+++ w/t/t1517-outside-repo.sh
@@ -107,11 +107,26 @@ test_expect_success LIBCURL 'remote-http outside repository' '
 	test_grep "^error: remote-curl" actual
 '
 
-test_expect_success 'update-server-info does not crash with -h' '
-	test_expect_code 129 git update-server-info -h >usage &&
-	test_grep "[Uu]sage: git update-server-info " usage &&
-	test_expect_code 129 nongit git update-server-info -h >usage &&
-	test_grep "[Uu]sage: git update-server-info " usage
-'
+for cmd in $(git --list-cmds=main)
+do
+	cmd=${cmd%.*} # strip .sh, .perl, etc.
+	case "$cmd" in
+	archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
+	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
+	http-backend | http-fetch | http-push | init-db | instaweb.sh | \
+	merge-octopus | merge-one-file | merge-resolve | mergetool | \
+	mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-ftps | \
+	remote-http | remote-https | replay | request-pull | send-email | \
+	sh-i18n--envsubst | shell | show | stage | submodule | svn | \
+	upload-archive--writer | upload-pack | web--browse | whatchanged)
+		expect_outcome=expect_failure ;;
+	*)
+		expect_outcome=expect_success ;;
+	esac
+	test_$expect_outcome "'git $cmd -h' outside a repository" '
+		test_expect_code 129 nongit git $cmd -h >usage &&
+		test_grep "[Uu]sage: git $cmd " usage
+	'
+done
 
 test_done
diff --git c/t/t5200-update-server-info.sh w/t/t5200-update-server-info.sh
index 8365907055..a551e955b5 100755
--- c/t/t5200-update-server-info.sh
+++ w/t/t5200-update-server-info.sh
@@ -46,4 +46,9 @@ test_expect_success 'midx does not create duplicate pack entries' '
 	test_must_be_empty dups
 '
 
+test_expect_success 'update-server-info does not crash with -h' '
+	test_expect_code 129 git update-server-info -h >usage &&
+	test_grep "[Uu]sage: git update-server-info " usage
+'
+
 test_done
