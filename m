Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8E1B85DC
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725727337; cv=none; b=RyrRvPAbuwAgzU47ndOWdMy8IyQyF5N3HNhVVx+eAneLyPxC0p1k2olCCoGVqL2c1vFT0s5FHfMaxQIjUOcPuBC2zbI8TTk2NJMAXkrF5zuOBCTolzFa5xm8CD1oS08UyyD0EIY2ppZI7+pRhSV0p7pyjB0LMJZT4yBeSKrXdg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725727337; c=relaxed/simple;
	bh=a8nwNubCnJAYADW/OYYOS4+MpFpuAsQcY7ge4TcYgVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D6lI2ve5pE7+NgHgIN3sBWCN61idD2+RtjytLZPFwuXfrRMG/I8DS7H5jwcwwjSPu18pOnIYT+LWyVSG5Hoy0Ci6YFOdDQrqNFDhLlNFIEkf3dhiYMk/rNM8LDLaqEH5cP0QAAsjrPv3WNLzV1gGbCG3mgj/KYzNd7wdT2eQ4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cwbQeYk4; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cwbQeYk4"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 57F622A80A;
	Sat,  7 Sep 2024 12:42:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=a8nwNubCnJAYADW/OYYOS4+MpFpuAsQcY7ge4T
	cYgVI=; b=cwbQeYk4FEmrul90V8dTA/gCpYnmNFcGKyF6gGYVoceo8CPByR0ER+
	DWqkav/0FFBjUmF2syG9Sn7GtWQA/mM7VlFdg2SfDUBdSAxSaTy1R24ZwxgWX9Ew
	ow7ZgZ1/LpPIymowDYn1+pKLGH8dYU5bLapwW+xpAzk6c9D6PzxOU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 50DC12A809;
	Sat,  7 Sep 2024 12:42:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B39472A808;
	Sat,  7 Sep 2024 12:42:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Shubham Kanodia <shubham.kanodia10@gmail.com>,
  Derrick Stolee <stolee@gmail.com>
Subject: Re*: What's cooking draft as of 2024-09-06 late night
In-Reply-To: <899eb2c2-bb18-4666-98d8-9255dedfac53@gmail.com> (Phillip Wood's
	message of "Sat, 7 Sep 2024 10:17:32 +0100")
References: <xmqq7cboyq9s.fsf@gitster.g>
	<899eb2c2-bb18-4666-98d8-9255dedfac53@gmail.com>
Date: Sat, 07 Sep 2024 09:42:12 -0700
Message-ID: <xmqq8qw3xvob.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 229401E8-6D38-11EF-A60F-9B0F950A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio and Shubham
>
> On 07/09/2024 06:41, Junio C Hamano wrote:
>> Will merge to 'next'?
>>   - sk/enable-prefetch-per-remote                                09-05          #1
>>     <pull.1779.v4.git.1725565398681.gitgitgadget@gmail.com>
>
> I've just taken a look at this and I'm left wondering why one would
> want to skip prefetching from a remote but still fetch from it with
> "git fetch --all". I set remote.<remote>.skipFetchAll for the remotes
> I don't want to prefetch.

It is nice to see a review from somebody who fetches from multiple
remotes in real life.  Very much appreciated.  I have a few
repositories to pull from, but I never do "fetch --all", so
skipFetchAll was totally outside my awareness.

> We also have remote.<remote>.skipDefaultUpdate I don't know
> offhand if that prevents a remote from being prefetched as well.

Yuck.  And this one is described with an identical text as the
previous one.  What is going on?

    ... goes and looks ...

Ah, yes, they internally update the same .skip_default_update member
in the struct remote; the only bug is that the documentation does
not make it clear that they are synonyms to each other.

What is curious is that 7cc91a2f (Add the configuration option
skipFetchAll, 2009-11-09) added for the sole purpose of adding this
one, without explaining anything about the reason why it was needed,
and my quick browsing did not find any discussion on the topic in
the era.

In any case, a remote that has .skip_default_update member set
indeed is exempt from prefetch since 32f67888 (maintenance: respect
remote.*.skipFetchAll, 2021-04-16), so it is a viable alternative
(assuming that nobody would want to omit prefetching from a remote
even if they want to fetch from the remote with "fetch --all" or
"remote update", which is a sensible assumption) to just document
this existing behaviour to help the users.

> I think being able to specify which refs are prefectched would be
> useful.

Yes, that is what we said it is OK to punt in the first step, which
is fine to be done in the follow-up step.

--- >8 ---
Subject: doc: remote.*.skip{DefaultUpdate,FetchAll} stops prefetch

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
 * Note that "skipped by default" in the original has been rewritten
   to "skipped" (unconditional), and this is deliberate.  When there
   is no conditionality and the behaviour is the only available one,
   it is *not* "by default".

 Documentation/config/remote.txt   | 13 +++++++------
 Documentation/git-maintenance.txt |  3 +++
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git c/Documentation/config/remote.txt w/Documentation/config/remote.txt
index 8efc53e836..36e771556c 100644
--- c/Documentation/config/remote.txt
+++ w/Documentation/config/remote.txt
@@ -42,14 +42,15 @@ remote.<name>.mirror::
 	as if the `--mirror` option was given on the command line.
 
 remote.<name>.skipDefaultUpdate::
-	If true, this remote will be skipped by default when updating
-	using linkgit:git-fetch[1] or the `update` subcommand of
-	linkgit:git-remote[1].
+	A deprecated synonym to `remote.<name>.skipFetchAll` (if
+	both are set in the configuration files with different
+	values, the value of the last occurrence will be used).
 
 remote.<name>.skipFetchAll::
-	If true, this remote will be skipped by default when updating
-	using linkgit:git-fetch[1] or the `update` subcommand of
-	linkgit:git-remote[1].
+	If true, this remote will be skipped when updating
+	using linkgit:git-fetch[1], the `update` subcommand of
+	linkgit:git-remote[1], and ignored by the prefetch task
+	of `git maitenance`.
 
 remote.<name>.receivepack::
 	The default program to execute on the remote side when pushing.  See
diff --git c/Documentation/git-maintenance.txt w/Documentation/git-maintenance.txt
index 51d0f7e94b..9d96819133 100644
--- c/Documentation/git-maintenance.txt
+++ w/Documentation/git-maintenance.txt
@@ -107,6 +107,9 @@ with the prefetch task, the objects necessary to complete a later real fetch
 would already be obtained, making the real fetch faster.  In the ideal case,
 it will just become an update to a bunch of remote-tracking branches without
 any object transfer.
++
+The `remote.<name>.skipFetchAll` configuration can be used to
+exclude a particular remote from getting prefetched.
 
 gc::
 	Clean up unnecessary files and optimize the local repository. "GC"
