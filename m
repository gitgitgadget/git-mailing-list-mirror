Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C29763F8
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897195; cv=none; b=rIB8wl/850NCh7O0b4gMUAj6+T5bLc0trilkx+AvYelKjgLdzyxjxGUebRFhGHUNzSRdFZMAc+Hzi2IU3PswKwiEF82ssmUAQyuoN2/h8sCezAP6MZ/oCxPaD0JcioBEIkUa4ykcM/w0kreN5BfFXYi+XA4WmHmgJXPTQYXTcNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897195; c=relaxed/simple;
	bh=6/mkdUCNJ+jxpjYzxn/ItU3CFLxRGYlu6MKTZ3HPX8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tZJohB7rBAH+MpA7RHpLJg4WgOnRl99ugTEowJBYgrCHSe0vw0kvdjONb3Kjo5yHQE+Ge4LJFCtYjryh6GHCDn5ni8N2i/IvK39dJthEMVxHc+xpVREmWkTf2t6myaisNH3q0xN4aNSbSBKM5ZlVamUxkkrotFAb9Gxh7NN1CE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MLD3tWOv; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MLD3tWOv"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F30A27577;
	Mon,  9 Sep 2024 11:53:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6/mkdUCNJ+jx
	pjYzxn/ItU3CFLxRGYlu6MKTZ3HPX8E=; b=MLD3tWOvIEVkUMpetdCaaWnQbMl/
	s75Cuc6e1yL0gFuLwGoIIUoWc6Px5NHMHZYvzh5UpTgI4fbdzOY3dX7sB77rnlUv
	9Tn03EzyYCOFgsgs5HVNYlWkRJSTtWo7desPQiW/5bU1TwgNu5+XelfzvsOGqcF3
	gQdiUGmeAAI0Lno=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3585B27574;
	Mon,  9 Sep 2024 11:53:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7DC4627573;
	Mon,  9 Sep 2024 11:53:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>,  git@vger.kernel.org,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: Re*: What's cooking draft as of 2024-09-06 late night
In-Reply-To: <125aab1b-d017-45c1-b93c-ee43fef9bd71@gmail.com> (Phillip Wood's
	message of "Mon, 9 Sep 2024 10:13:07 +0100")
References: <xmqq7cboyq9s.fsf@gitster.g>
	<899eb2c2-bb18-4666-98d8-9255dedfac53@gmail.com>
	<xmqq8qw3xvob.fsf_-_@gitster.g>
	<CAG=Um+0X3Umt-2TQ-BGeefqdGxfVoy2Ug0tGKLycrX=_pj=oJw@mail.gmail.com>
	<125aab1b-d017-45c1-b93c-ee43fef9bd71@gmail.com>
Date: Mon, 09 Sep 2024 08:53:11 -0700
Message-ID: <xmqqseu8u8m0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9E4D97CC-6EC3-11EF-BAD5-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> writes:

>> The only place `skipFetchAll` is currently documented is in this large
>> master list of configs that are easy to miss =E2=80=94
>> https://git-scm.com/docs/git-config.
>
> We could perhaps expand the documentation of `git fetch --all` to
> mention skipFetchAll

Like this (interdiff at the end)?

--- >8 ---
Subject: [PATCH v2] doc: remote.*.skip{DefaultUpdate,FetchAll} stops pref=
etch

Back when 7cc91a2f (Add the configuration option skipFetchAll,
2009-11-09) added for the sole purpose of adding skipFetchAll as a
synonym to skipDefaultUpdate, there was no explanation about the
reason why it was needed., but these two configuration variables
mean exactly the same thing.

Also, when we taught the "prefetch" task to "git maintenance" later,
we did make it pay attention to the setting, but we forgot to
document it.

Document these variables as synonyms that collectively implements
the last-one-wins semantics, and also clarify that the prefetch task
is also controlled by this variable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/remote.txt   | 13 +++++++------
 Documentation/fetch-options.txt   |  5 +++--
 Documentation/git-maintenance.txt |  3 +++
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remot=
e.txt
index 8efc53e836..36e771556c 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -42,14 +42,15 @@ remote.<name>.mirror::
 	as if the `--mirror` option was given on the command line.
=20
 remote.<name>.skipDefaultUpdate::
-	If true, this remote will be skipped by default when updating
-	using linkgit:git-fetch[1] or the `update` subcommand of
-	linkgit:git-remote[1].
+	A deprecated synonym to `remote.<name>.skipFetchAll` (if
+	both are set in the configuration files with different
+	values, the value of the last occurrence will be used).
=20
 remote.<name>.skipFetchAll::
-	If true, this remote will be skipped by default when updating
-	using linkgit:git-fetch[1] or the `update` subcommand of
-	linkgit:git-remote[1].
+	If true, this remote will be skipped when updating
+	using linkgit:git-fetch[1], the `update` subcommand of
+	linkgit:git-remote[1], and ignored by the prefetch task
+	of `git maitenance`.
=20
 remote.<name>.receivepack::
 	The default program to execute on the remote side when pushing.  See
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-option=
s.txt
index e22b217fba..80838fe37e 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,6 +1,7 @@
 --[no-]all::
-	Fetch all remotes. This overrides the configuration variable
-	`fetch.all`.
+	Fetch all remotes, except for the ones that has the
+	`remote.<name>.skipFetchAll` configuration variable set.
+	This overrides the configuration variable fetch.all`.
=20
 -a::
 --append::
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-mainte=
nance.txt
index 51d0f7e94b..9d96819133 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -107,6 +107,9 @@ with the prefetch task, the objects necessary to comp=
lete a later real fetch
 would already be obtained, making the real fetch faster.  In the ideal c=
ase,
 it will just become an update to a bunch of remote-tracking branches wit=
hout
 any object transfer.
++
+The `remote.<name>.skipFetchAll` configuration can be used to
+exclude a particular remote from getting prefetched.
=20
 gc::
 	Clean up unnecessary files and optimize the local repository. "GC"

Interdiff:
  diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
  index e22b217fba..80838fe37e 100644
  --- a/Documentation/fetch-options.txt
  +++ b/Documentation/fetch-options.txt
  @@ -1,6 +1,7 @@
   --[no-]all::
  -	Fetch all remotes. This overrides the configuration variable
  -	`fetch.all`.
  +	Fetch all remotes, except for the ones that has the
  +	`remote.<name>.skipFetchAll` configuration variable set.
  +	This overrides the configuration variable fetch.all`.
  =20
   -a::
   --append::
--=20
2.46.0-694-g7ca3d1f4f8

