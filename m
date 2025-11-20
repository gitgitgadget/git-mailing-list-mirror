Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692B36C5B6
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656028; cv=none; b=bfJX//mgbmJhd3KVy3H8exl5lLTKGpNr2eo38IngWREHAjZb2B6Nnr66raFv4SsUXrItQGDhCtIGM5LW18gRcD4iiwaEenBVYcRNe0r0nXhuZxIU6XNLvJsQuT5YehWF1teF88JwyCo8eUENkSRY5i00ltHHxaPPVTJ6Sc2vSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656028; c=relaxed/simple;
	bh=iXvUvDdjUWOuj/PAB8mgRYS5vqUDllG+WEA5FRIXlN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLHaoZIk3b9xYBFx9D2EWoTJsWM+PzkjhlpIvrdU0vuDbGHmhO9KiZiu2BBXE5lyW4yJq5h+bUe3A+yzR6ad6OXTs0oAgK8/q0xf0qckqwdzPed6hpItbKYgtgTLaUUXSHBbgmgDB5zIPc1dTLPjOvCOu44z90Wd6/BN3ix1xcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mYsA9j1n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BAt/aOvC; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mYsA9j1n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BAt/aOvC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B7807A01B7;
	Thu, 20 Nov 2025 11:27:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 20 Nov 2025 11:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763656024;
	 x=1763742424; bh=1eIKWVAxP/eBaDDev1PWqY+WvyLYtTINjk/sRewgbic=; b=
	mYsA9j1n7Ep8cfIyzA1TzPx1gic0pOWBXGUr/0tbOSL4urHJ/xYdhI2Ng+oaa3kn
	AaYtNapBqC2UMcEpQcRLnbgziIf4cGl3thIDdsEyZ9BuiLq9o8Yq++fAuTjHfYS1
	YVVOkakG8dv2zW+9UX/1BQqjBQcQHcxV2Nrfduvcoa6gXEMATVHxXinEWFEJ3F6/
	8TD0wnOyDk5+InOkBz8AMWz7pIAimxpufrHC8GnZQ50KgfY1iEOYZx5EPiBECd9O
	mC/7RkTe5JcDCcPj6H1CeMBZjaiZc8W6D5eCNzddsWwPH6WW+5njLkBpY827tqrg
	6WO1wSgQe/fR1vSp2Ih3Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763656024; x=
	1763742424; bh=1eIKWVAxP/eBaDDev1PWqY+WvyLYtTINjk/sRewgbic=; b=B
	At/aOvCT/3/reXP2PTNHZMVKIUvsgdchiJokjdRRQBYtzVTKbbo4mDSqhmnM8LJk
	au9GDhdJhKyJo7yLbz025EvVyMnBwOscvb1Aq1BFJNLDrZo3OCA074dAaw4WUnu5
	ZXPIR6NOrKa1Mr/e2coe0Hauva1JI4lqXjL6xPmCEyUrrEQdR19kBOQyCWTJEtcj
	mk/SbYFimEgmvCIQHWiBbA3g49Jh5IWzeNO7GFdEZx5ip4MKTtw8JjQBUwlDA0Cq
	RAThMlBI36VOzNcmFp7yZha8sRSdc8jSw7X1YHq2BwjMgpzAypV/UjB9yZFnVO9j
	Ech4W6wekBSE+iuXbFTeQ==
X-ME-Sender: <xms:V0EfaY9bGSTvvmjJH--oM6V9Twg0_KBPE_uN5yUqfgk3orjv5AbMqFA>
    <xme:V0EfaSOggxZxz2MQCTr94ahmimgBthVdDLgrzLLB97zteWMDUZEEoaLeUwfOOS3og
    q-w0ZTiLhPSuWPe8sTYf6cXWA6W6nYtBZJR9ZQGfqpfqHIVhRNIoQ>
X-ME-Received: <xmr:V0EfaeFdRAexC2uyQD_fkU8TAkMVORJeMSluv9TLgsBM-WRBBllfbAOgbUMgs-ahTWPcGnjcSf8QmW4IzWegBCwq5cW08XMHCCeT8pM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgf
    euieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehjiehtsehkuggsghdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:V0EfaYR43DGYpQYNGjjuZKRVrEc9T61k4zK8s6Ma4f4NXzeX8AIrGA>
    <xmx:V0EfaTswDzeWV-ILEG6nt9ekGBG69MG966WKldQn05HIDMMR6_uXpw>
    <xmx:V0EfaYLMoa7SeV8OxR8wyPfzDkduJjpLSjQTCu4RVeO3YyNT8LH6-w>
    <xmx:V0EfaQk6PEUo85RtR0HeRsSV8uTKOd01PxD45Mc_FP0kwPf602JNSg>
    <xmx:WEEfaQizELHVawaNC6PkI5lk7tJVP08U_-xzh5qqexD1COFwzFnOQyQ->
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 11:27:01 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	j6t@kdbg.org,
	Junio C Hamano <gitster@pobox.com>,
	phillip.wood@dunelm.org.uk
Subject: [PATCH v2] doc: warn against --committer-date-is-author-date
Date: Thu, 20 Nov 2025 17:26:49 +0100
Message-ID: <V2_committer-date-is-author-date.1@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <d17060d9b72.1759952528.git.code@khaugsbakk.name>
References: <d17060d9b72.1759952528.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This option could create a commit history which violates the assumption
that commits have non-decreasing commit timestamps. Warn against that in
both git-am(1) and git-rebase(1).

The genesis of this option is from git-am(1) and was added in
3f01ad66 (am: Add --committer-date-is-author-date option,
2009-01-22). The commit message doesn’t give us an example
of a use case, but the thread starter does:[1]

    I've a big set of patches in a mbox file: there's sufficient info
    inside for git-am to work.

    Yet, each time I do import these, my sha1sums are changing because of
    different commit dates.

    I'd like to force the commit date to match the info/date from the time
    I received the email (and therefore always get back the right
    sha1sums).

[1]: https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com/

So the motivation was to treat git-am(1) as an import command that
creates the same commit IDs.

Putting aside the question of whether you should be using git-am(1) for
importing commits, this approach is problematic:

• you still need to apply the commits to the same base if you want the
  same hashes; and
• you need the same committer.

And if you expect the same committer, why is this person applying the
same patches multiple times with the goal of making *identical* commits?

That was all for git-am(1).

It was added to git-rebase(1) in 570ccad3 (rebase: add options passed to
git-am, 2009-03-18)[2] in order to plug options that could not be sent
on to git-am(1). At this point the utility of the option graduated to
making no sense; a use case for `git rebase --committer-date-is-author-
date` is still yet to be found.

Just warn against using this option on both commands and remind the user
to consider whether they really need it.

† 2: See also 7573cec5 (rebase -i: support
     --committer-date-is-author-date, 2020-08-17) for the commit for the
     merge backend

Suggested-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name: kh/committer-author-date
    
    Topic summary: "--committer-date-is-author-date" can create a history
    with commit timestamps that are not strictly increasing. That doesn't
    play well with the revision walking machinery. Warn against that.
    
    (See https://lore.kernel.org/git/cover.1759873165.git.me@ttaylorr.com/ )
    
    -----
    
    v2:
    
    Add sentence “You should consider if you really need to use this option.”
    in front of “[make sure you] only use this option to ...”.
    
    The problem here is whether to:
    
    1. Go over the history of why it exists
    2. Say don’t use it
    3. Prod them to think about why they are using it
    
    Opt for (3) in the spirit of giving the user the rope they may think
    they need, just with a reminder to consider what they are actually
    trying to achieve.[0]
    
    There was a discussion about deprecating it. But this version still
    just warns.[0]
    
    And:
    
    • Commit message: Drop “legitimate uses” after reviewer feedback and
      discussion. The message goes into why the reported use case does not make
      enough sense
    • Use `WARNING` as a callout instead of `NOTE`[1]
    • Put the warning paragraph second/last[2]
    • Commit message: Use “override” instead of “lie”.[3] Either works but
      “override” is more neutral[4] and not less forthright.
    • Drop “clock skew” and git-rev-list(1) mention[5]
    • Commit message: Tweak “The genesis” paragraph: “is from git-am(1)” since
      most of the explanation goes over the git-am(1) option
    • Use “non-decreasing commit timestamps”. I guess “strictly increasing”
      means that the commit timestamps need to be greater for each.  But a commit
      B that follows A can have the same timestamp, that’s ok.
    • s/applying commits/rebasing commits/ in git-rebase(1)[6]
    
    🔗 0: https://lore.kernel.org/git/xmqqbjm695p4.fsf@gitster.g/#t
    🔗 1: https://lore.kernel.org/git/601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org/
    🔗 2: https://lore.kernel.org/git/601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org/
    🔗 3: https://lore.kernel.org/git/3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com/
    🔗 4: https://lore.kernel.org/git/6a921119-6fba-4f82-916f-d80d3f46d54d@app.fastmail.com/
    🔗 5: https://lore.kernel.org/git/3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com/
    🔗 6: https://lore.kernel.org/git/3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com/
    
    v1:
    
    I thought about marking it as deprecated but eventually found out why it
    was added. And it wasn’t for some (still unknown) dedication or
    not-explained *want* to keep the committer date and author date in synch
    just-because (as I thought[1]).
    
    Hannes asked[2] why it is a porcelain option? (You can after all script
    the same behavior with a little effort.) Personally I think the Git
    porcelain is not shy about providing facilities for crafting made-up
    histories to its users. And I personally think that’s a good thing.
    
    This does seem to indicate that this option doesn’t make much sense for
    git-rebase(1) though, no? Given that it will `--force-rebase`, i.e. will
    force new commit IDs.
    
    🔗 1: https://lore.kernel.org/git/93041214-4774-49eb-b8bd-24648134cded@app.fastmail.com/
    🔗 2: https://lore.kernel.org/git/6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org/

 Documentation/git-am.adoc     | 7 +++++++
 Documentation/git-rebase.adoc | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 221070de481..264d21a7de7 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -161,6 +161,13 @@ Valid <action> for the `--whitespace` option are:
 	commit creation as the committer date. This allows the
 	user to lie about the committer date by using the same
 	value as the author date.
++
+WARNING: The history walking machinery assumes that commits have
+non-decreasing commit timestamps. You should consider if you really need
+to use this option. Then you should only use this option to override the
+committer date when applying commits on top of a base which commit is
+older (in terms of the commit date) than the oldest patch you are
+applying.
 
 --ignore-date::
 	By default the command records the date from the e-mail
diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 956d3048f5a..0f808c82b28 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -507,6 +507,13 @@ See also INCOMPATIBLE OPTIONS below.
 	Instead of using the current time as the committer date, use
 	the author date of the commit being rebased as the committer
 	date. This option implies `--force-rebase`.
++
+WARNING: The history walking machinery assumes that commits have
+non-decreasing commit timestamps. You should consider if you really need
+to use this option. Then you should only use this option to override the
+committer date when rebasing commits on top of a base which commit is
+older (in terms of the commit date) than the oldest commit you are
+applying (in terms of the author date).
 
 --ignore-date::
 --reset-author-date::

Interdiff against v1:
  diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
  index c36ae679cfb..264d21a7de7 100644
  --- a/Documentation/git-am.adoc
  +++ b/Documentation/git-am.adoc
  @@ -156,18 +156,18 @@ Valid <action> for the `--whitespace` option are:
   	See also linkgit:githooks[5].
   
   --committer-date-is-author-date::
  -	NOTE: The history walking machinery assumes that commits have
  -	strictly increasing commit timestamps, with some tolerance for
  -	clock skew (see linkgit:git-rev-list[1]). You should only use
  -	this option to lie about the committer date when applying
  -	commits on top of a base which commit is older (in terms of the
  -	commit date) than the oldest patch you are applying.
  +	By default the command records the date from the e-mail
  +	message as the commit author date, and uses the time of
  +	commit creation as the committer date. This allows the
  +	user to lie about the committer date by using the same
  +	value as the author date.
   +
  -By default the command records the date from the e-mail
  -message as the commit author date, and uses the time of
  -commit creation as the committer date. This allows the
  -user to lie about the committer date by using the same
  -value as the author date.
  +WARNING: The history walking machinery assumes that commits have
  +non-decreasing commit timestamps. You should consider if you really need
  +to use this option. Then you should only use this option to override the
  +committer date when applying commits on top of a base which commit is
  +older (in terms of the commit date) than the oldest patch you are
  +applying.
   
   --ignore-date::
   	By default the command records the date from the e-mail
  diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
  index 336ee90f7e3..0f808c82b28 100644
  --- a/Documentation/git-rebase.adoc
  +++ b/Documentation/git-rebase.adoc
  @@ -504,17 +504,16 @@ merge backend;;
   See also INCOMPATIBLE OPTIONS below.
   
   --committer-date-is-author-date::
  -	NOTE: The history walking machinery assumes that commits have
  -	strictly increasing commit timestamps, with some tolerance for
  -	clock skew (see linkgit:git-rev-list[1]). You should only use
  -	this option to lie about the committer date when applying
  -	commits on top of a base which commit is older (in terms of the
  -	commit date) than the oldest commit you are applying (in
  -	terms of the author date).
  +	Instead of using the current time as the committer date, use
  +	the author date of the commit being rebased as the committer
  +	date. This option implies `--force-rebase`.
   +
  -Instead of using the current time as the committer date, use
  -the author date of the commit being rebased as the committer
  -date. This option implies `--force-rebase`.
  +WARNING: The history walking machinery assumes that commits have
  +non-decreasing commit timestamps. You should consider if you really need
  +to use this option. Then you should only use this option to override the
  +committer date when rebasing commits on top of a base which commit is
  +older (in terms of the commit date) than the oldest commit you are
  +applying (in terms of the author date).
   
   --ignore-date::
   --reset-author-date::

Range-diff against v1:
1:  d17060d9b72 ! 1:  203a9b9db2c doc: warn against --committer-date-is-author-date
    @@ Metadata
      ## Commit message ##
         doc: warn against --committer-date-is-author-date
     
    -    This option has legitimate uses but could create a commit history which
    -    violates the assumption that commits are strictly increasing in terms of
    -    commit timestamps. Warn against that in both git-am(1) and git-rebase(1).
    +    This option could create a commit history which violates the assumption
    +    that commits have non-decreasing commit timestamps. Warn against that in
    +    both git-am(1) and git-rebase(1).
     
    -    ❦
    -
    -    The genesis of this option is 3f01ad66 (am: Add --committer-date-is-
    -    author-date option, 2009-01-22). The commit message doesn’t give us an
    -    example of a use case, but the thread starter does:[1]
    +    The genesis of this option is from git-am(1) and was added in
    +    3f01ad66 (am: Add --committer-date-is-author-date option,
    +    2009-01-22). The commit message doesn’t give us an example
    +    of a use case, but the thread starter does:[1]
     
             I've a big set of patches in a mbox file: there's sufficient info
             inside for git-am to work.
    @@ Commit message
             I received the email (and therefore always get back the right
             sha1sums).
     
    +    [1]: https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com/
    +
         So the motivation was to treat git-am(1) as an import command that
    -    creates the same commit IDs given the same base and committer.
    +    creates the same commit IDs.
     
    -    [1]: https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com/
    +    Putting aside the question of whether you should be using git-am(1) for
    +    importing commits, this approach is problematic:
    +
    +    • you still need to apply the commits to the same base if you want the
    +      same hashes; and
    +    • you need the same committer.
    +
    +    And if you expect the same committer, why is this person applying the
    +    same patches multiple times with the goal of making *identical* commits?
    +
    +    That was all for git-am(1).
    +
    +    It was added to git-rebase(1) in 570ccad3 (rebase: add options passed to
    +    git-am, 2009-03-18)[2] in order to plug options that could not be sent
    +    on to git-am(1). At this point the utility of the option graduated to
    +    making no sense; a use case for `git rebase --committer-date-is-author-
    +    date` is still yet to be found.
    +
    +    Just warn against using this option on both commands and remind the user
    +    to consider whether they really need it.
    +
    +    † 2: See also 7573cec5 (rebase -i: support
    +         --committer-date-is-author-date, 2020-08-17) for the commit for the
    +         merge backend
     
         Suggested-by: Johannes Sixt <j6t@kdbg.org>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
    @@ Notes (series)
     
         v2:
     
    -    • Deprecate in addition to warning
    +    Add sentence “You should consider if you really need to use this option.”
    +    in front of “[make sure you] only use this option to ...”.
    +
    +    The problem here is whether to:
    +
    +    1. Go over the history of why it exists
    +    2. Say don’t use it
    +    3. Prod them to think about why they are using it
    +
    +    Opt for (3) in the spirit of giving the user the rope they may think
    +    they need, just with a reminder to consider what they are actually
    +    trying to achieve.[0]
    +
    +    There was a discussion about deprecating it. But this version still
    +    just warns.[0]
    +
    +    And:
    +
    +    • Commit message: Drop “legitimate uses” after reviewer feedback and
    +      discussion. The message goes into why the reported use case does not make
    +      enough sense
         • Use `WARNING` as a callout instead of `NOTE`[1]
         • Put the warning paragraph second/last[2]
    -    • Use “override” instead of “lie”.[3] Either works but “override” is
    -      more neutral[4] and not less forthright.
    +    • Commit message: Use “override” instead of “lie”.[3] Either works but
    +      “override” is more neutral[4] and not less forthright.
         • Drop “clock skew” and git-rev-list(1) mention[5]
    -
    +    • Commit message: Tweak “The genesis” paragraph: “is from git-am(1)” since
    +      most of the explanation goes over the git-am(1) option
    +    • Use “non-decreasing commit timestamps”. I guess “strictly increasing”
    +      means that the commit timestamps need to be greater for each.  But a commit
    +      B that follows A can have the same timestamp, that’s ok.
    +    • s/applying commits/rebasing commits/ in git-rebase(1)[6]
    +
    +    🔗 0: https://lore.kernel.org/git/xmqqbjm695p4.fsf@gitster.g/#t
         🔗 1: https://lore.kernel.org/git/601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org/
         🔗 2: https://lore.kernel.org/git/601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org/
         🔗 3: https://lore.kernel.org/git/3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com/
         🔗 4: https://lore.kernel.org/git/6a921119-6fba-4f82-916f-d80d3f46d54d@app.fastmail.com/
         🔗 5: https://lore.kernel.org/git/3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com/
    +    🔗 6: https://lore.kernel.org/git/3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com/
     
         v1:
     
    @@ Notes (series)
     
      ## Documentation/git-am.adoc ##
     @@ Documentation/git-am.adoc: Valid <action> for the `--whitespace` option are:
    - 	See also linkgit:githooks[5].
    - 
    - --committer-date-is-author-date::
    --	By default the command records the date from the e-mail
    --	message as the commit author date, and uses the time of
    --	commit creation as the committer date. This allows the
    --	user to lie about the committer date by using the same
    --	value as the author date.
    -+	NOTE: The history walking machinery assumes that commits have
    -+	strictly increasing commit timestamps, with some tolerance for
    -+	clock skew (see linkgit:git-rev-list[1]). You should only use
    -+	this option to lie about the committer date when applying
    -+	commits on top of a base which commit is older (in terms of the
    -+	commit date) than the oldest patch you are applying.
    + 	commit creation as the committer date. This allows the
    + 	user to lie about the committer date by using the same
    + 	value as the author date.
     ++
    -+By default the command records the date from the e-mail
    -+message as the commit author date, and uses the time of
    -+commit creation as the committer date. This allows the
    -+user to lie about the committer date by using the same
    -+value as the author date.
    ++WARNING: The history walking machinery assumes that commits have
    ++non-decreasing commit timestamps. You should consider if you really need
    ++to use this option. Then you should only use this option to override the
    ++committer date when applying commits on top of a base which commit is
    ++older (in terms of the commit date) than the oldest patch you are
    ++applying.
      
      --ignore-date::
      	By default the command records the date from the e-mail
     
      ## Documentation/git-rebase.adoc ##
    -@@ Documentation/git-rebase.adoc: merge backend;;
    - See also INCOMPATIBLE OPTIONS below.
    - 
    - --committer-date-is-author-date::
    --	Instead of using the current time as the committer date, use
    --	the author date of the commit being rebased as the committer
    --	date. This option implies `--force-rebase`.
    -+	NOTE: The history walking machinery assumes that commits have
    -+	strictly increasing commit timestamps, with some tolerance for
    -+	clock skew (see linkgit:git-rev-list[1]). You should only use
    -+	this option to lie about the committer date when applying
    -+	commits on top of a base which commit is older (in terms of the
    -+	commit date) than the oldest commit you are applying (in
    -+	terms of the author date).
    +@@ Documentation/git-rebase.adoc: See also INCOMPATIBLE OPTIONS below.
    + 	Instead of using the current time as the committer date, use
    + 	the author date of the commit being rebased as the committer
    + 	date. This option implies `--force-rebase`.
     ++
    -+Instead of using the current time as the committer date, use
    -+the author date of the commit being rebased as the committer
    -+date. This option implies `--force-rebase`.
    ++WARNING: The history walking machinery assumes that commits have
    ++non-decreasing commit timestamps. You should consider if you really need
    ++to use this option. Then you should only use this option to override the
    ++committer date when rebasing commits on top of a base which commit is
    ++older (in terms of the commit date) than the oldest commit you are
    ++applying (in terms of the author date).
      
      --ignore-date::
      --reset-author-date::

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.52.0.10.g08704017180

