Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A04C956C
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203641; cv=none; b=IcPEPIy2ydE22VMZzT3BYB0XWYCZY/qtXq4Z6I5s7ieSOYtyoqb75tQkTYnw5yjfkZydjF1w6WV1rh45ok2FWhyxcglCZt6lrx8vP/nnpnsa9efuyaOMc1gT/elRrGzJJFrS86e665WK77jM84bEKDS9yAm9tnk5CnsBm/CVT/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203641; c=relaxed/simple;
	bh=tFnHGU4BGfMxTQDt/lsGawiFSmWvLNoV6cN0N2sSii8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J1ApeDRfjTlsuOsxYn82V1i+eMkdv9X82iBeSlSfxTe6VGaMtkHe/IZvsqUoDwCscFEIhWaTfkKUeFVMRsa84N/TtnDVfPvyIEc8h75XWIC5Q5K3ZU2WxLRmSQjZM/Ko1SZckEYRehtrayQVsodgWV/jbHhD18XNZdm7XEDn8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cLd7+9mf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GmmJsK0P; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cLd7+9mf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GmmJsK0P"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B85E41400023;
	Thu, 11 Jun 2026 14:47:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 11 Jun 2026 14:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781203638; x=1781290038; bh=LT5oRx7oZi
	15vGJZx4nxa9OqLgYru2yiYFqVkp/KQ+o=; b=cLd7+9mfbloL1X94PYjHbXPJcr
	8rORKo0i3+/geD5xO3AYvKiFidKRhIzkPWQm6Fkb5uI1FzQTkXKUYXD0gtwPLkQS
	uukyVfnpCtaB2DnE/H1Zxfr50LtVLv7WZTe4vLV5bjgmHeG6vrFdjqqbpkvHaFD9
	NPVX4Ub16QQKwmsBaI2aaVkqA1YEkTgZAnyBIsH9yvRRsCt1oOYMbNI08WszEsFw
	E5wXfGANc/u9UeczB0PuLzZaaqPzBMhAQdELf6Pg36JWu1RiUwCf+Vp3fRRpsExI
	jtFlPYky2yhZx+8X4ZqPhfUWEx10zb0xMoQfOxFYQ4W80E/4J6n3wieUN5cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781203638; x=1781290038; bh=LT5oRx7oZi15vGJZx4nxa9OqLgYru2yiYFq
	Vkp/KQ+o=; b=GmmJsK0PMXGumwQpw7Wsyt6lzpuXnSPICJqih1AycYEtyl924yR
	Sw2bZmS/Eh1J7r5YR5Dub4LZppzJETpN3HBAQLceGpLUhnKljqvw/7REKZQ7lOsW
	VYneG00EcIoC/+nvRj1Nl6+phdXVHPU9fJiCIvl+iFkbVYeCl3iLrz3OD0CjnRX2
	PrZshRAEWX+a+h6ytLvlFyPG5Te45+/Jo62ka/nHDFhPbzozhQjF/80T2EhBRZu+
	2eHlvJILRIxc/MJgIy2DCiid/FJWjnqg8M7lWYLYzqYCJldMKNXTlMZEOA8Oei0f
	cpaltfyphHM7yMwQ+JOSTxzQz9brZqCeusg==
X-ME-Sender: <xms:tgIraqh9o47GsYmPN-NcPME8cFYIJnmHn_2EBFJ8x1iHo-vGuP-gRQ>
    <xme:tgIraidoM9d8__qIz8VciiILJ8wXFr1EKKMHennQivL_UkfmQB2txTgOApacuFBxl
    RDxMNU9zMRkk82p0_uW8N7Ld4ajNsrENVmrXpxrkDJLptRkgHRP>
X-ME-Received: <xmr:tgIravdq6NqWNvwfhMlVo69e5UX3nJLWhePNa-DQHoTLiv-_aAAsUpkCB8DmLNS7RSm-PKXw4ORS00-fluxV-vfchw99KgAqjXMS>
X-ME-Proxy-Cause: dmFkZTFxowFcH+szduN7vTPokc54b8XQr1YFyzlilPLQxjV7ryoGOrRwA6KpbwwS7vbHLA
    5oBMXklA9RNEUX8YlwmUcE+OuN2m2iDqPgsKu3BWP0uUyHHO+n33n+NXolOID2eNB5cRsZ
    Sm7wknq1Gb48kCJhDmPChFyRLOPcrAYOU3x81oodu0Ovp9Zy5YvThzZZjfSPE4AgrmT0V7
    OTxaisFnz0WNUF7YdnE3Zbiwf3sDf/o/nJnKS9Ohm6XoFf4TefeKZgaxzza0aCz6aN1j1g
    hPWwHPunaOWV9rMyArFKY3j6FYJ2JhNnWYUBVsIp9X4ZlwAA+jmR+mc6zeKjOCkB7PpYVt
    ViJUGrEsaEtHbEf8M78ZMm0VyYQuhDF2F12nLtVD2lPfTga7zAelBCG35XSsxKAKrDACyJ
    o53TXT970HKdvQXAk7szG+r5N++/9DNATR+MHZjuOKwMayP6uPbrV0ZARuESt12VSis2lR
    dVj1G7gQrWo1ZxhxNExK0A1RNgMPb40LnfEkMUxJLiVySYw3HgazYgfogvPczvC9Atee1n
    wxJYbibzlO3shC8y+Cv680xDrqfSoR3kzv3kjBn4bUMcB+rkZVaPAEgqPI4TI9raUMQxgS
    a7OcAItlBJOwNMGSGW+LOFfBBm9fNjaXwnMxEg8wSxWLUi/oL/wjrMakfRlA
X-ME-Proxy: <xmx:tgIras_4jbvk49yOX_xehUtUTj6pOPp8uen3LVIaVWELEll6-uq6GA>
    <xmx:tgIrarllMrRGobDe04cwyGmAAaivL5CwmcB_7zZhja3RTW4tDal4wg>
    <xmx:tgIrau8G9z-X9ePPBJSxOplMFD_1m3Opi6mfzdmcUW9ahTcEAarGeA>
    <xmx:tgIrapm3j0AuZlxRSqop8M44MGIF5uVFTdyxiKXT1JUIsbxAxzsupQ>
    <xmx:tgIraqn1YEukGUbbwufo5heEdGo15brA9Zxw6xW-9FVFPgBhuEvjCEsE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 14:47:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] update-ref: add --rename option
In-Reply-To: <aiqytJD-rcEirhgE@pks.im> (Patrick Steinhardt's message of "Thu,
	11 Jun 2026 15:05:56 +0200")
References: <xmqqv7brz9ba.fsf@gitster.g>
	<20260610212800.2892146-1-gitster@pobox.com> <aiqytJD-rcEirhgE@pks.im>
Date: Thu, 11 Jun 2026 11:47:16 -0700
Message-ID: <xmqqwlw4nccr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> One thing that I'm missing from the commit message: what's the
> motivation for this new mode?

Maintenance of merge-fix database, a kludgy way to manage evil
merges that are needed to deal with inter-topic semantic crashes.

If you are really interested, see the appendix.

>> diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
>> index 37a5019a8b..0c27efaa52 100644
>> --- a/Documentation/git-update-ref.adoc
>> +++ b/Documentation/git-update-ref.adoc
>> @@ -39,6 +40,14 @@ the result of following the symbolic pointers.
>>  With `-d`, it deletes the named <ref> after verifying that it
>>  still contains <old-oid>.
>>  
>> +With `--rename`, it renames <old-refname> together with its reflog to
>> +<new-refname>.  The command fails if <old-refname> does not exist, or
>> +if <new-refname> already exists.  Because `git update-ref` does not
>> +update active worktree `HEAD` symbolic references or `.git/config`
>> +tracking settings when you rename a local branch in the `refs/heads/`
>> +hierarchy, think twice before using this command to rename a local
>> +branch (use `git branch -m` instead).
>
> I'd rephrase this slightly to first document behaviour and then draw the
> conclusion that it shouldn't be used in many cases separately. For
> example:
>
>     This command does not update any symbolic references pointing to
>     the renamed reference, and neither does it update `.git/config`
>     tracking settings. It is thus not recommended to use it for renaming
>     local branches. Use `git branch -m` instead.

Thanks, that is much better.

>> +		if (!refs_ref_exists(get_main_ref_store(the_repository), oldref))
>> +			die("no ref named '%s'", oldref);
>> +
>> +		if (refs_ref_exists(get_main_ref_store(the_repository), newref))
>> +			die("ref '%s' already exists", newref);
>> +
>> +		if (refs_rename_ref(get_main_ref_store(the_repository),
>> +				    oldref, newref, msg))
>> +			die("rename failed");
>> +		return 0;
>> +	}
>
> Hm. I think we're not using "--deref" / "--no-deref" at all, but we
> document this flag as accepted in the synopsis.

Good point.  refs_rename_ref() never derefs, right?  We should drop
these two from the synopsis section.



[Appendix]

Often there are two topics, A and B, in flight that merging A into B
(or vice versa) requires changes more than the mechanical merge
needs.  If this is a one-shot merge of A into B (or B into A), then
we can just record the evil merge and be done with it, but the same
issue arises if you are merging A into 'seen' first and then later
(possibly after merging other topics on top) B into 'seen'.  The
merge of 'B' needs the same evil merge to resolve semantic
conflicts.

As those familiar with how 'seen' works in my tree, reapplying such
evil merges MUST BE automated, or the project will not work at all,
as 'seen' is rebuilt at least twice during the day, or even more
often.

So, what I do is, when I merge 'B' into 'seen' after merging 'A' and
possibly some other topics, I let the rerere database to record the
resolution of textual conflicts and make a commit.  The tree
recorded in this commit will not work, due to semantic conflicts.  I
create another commit on top of this merge to resolve the semantic
conflict to make the tree work.

Let's take ps/history-drop (A) and ps/setup-drop-global-state (B) as
an easy-to-understand example.  

	$ git checkout --detach ps/history-drop
	$ git merge ps/setup-drop-global-state

This textually merges cleanly, but the result would not compile.
The history-drop added a new call to "is_bare_repository()", while
setup-drop-global-state added an extra parameter to the function.

So a merge-fix prepared on top of this "textually clean but does
not work" merge is created and looks something like this:

diff --git a/builtin/history.c b/builtin/history.c
index 65845e7359..eece221e63 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1150,7 +1150,7 @@ static int cmd_history_drop(int argc,
 	 * inconsistent repository state. So we first perform a dry-run merge
 	 * here before updating refs.
 	 */
-	if (!is_bare_repository()) {
+	if (!is_bare_repository(repo)) {
 		ret = find_head_tree_change(repo, &result, &old_head,
 					    &new_head, &head_moves);
 		if (ret < 0)

And this commit (i.e. a commit on top of the mechanical/textual
merge result that adjusts the non-working merge result into workable
form) is pointed at by refs/merge-fix/ps/setup-drop-global-state.

Rebuilding 'seen' is driven by a script that takes a moral
equivalent of 'git log --first-parent --oneline --reverse
master..seen' and replays each merge on top of what is checked out
(to bootstrap, you would "git checkout -B seen master" and start
there).  For each topic branch found in the input, the script

 (1) skips if the topic has been merged and move on to the next
     topic.

 (2) runs "git merge" of the topic, taking resolution by the rerere
     database.  If this step leaves mechanical/textual conflicts,
     the script stops and I'll hand resolve to update my rerere
     database, and rerun the script (which will succeed the next
     time).

 (3) runs "git cherry-pick --no-commit merge-fix/$topic" if such a
     ref exists, and if successfull, runs "git commit --amend".

That is how merging ps/setup-drop-global-state into 'seen' that has
already merged ps/history-drop would automatically get the right
evil merge to resolve semantic conflicts.

The renaming of update-ref becomes needed when the order of merging
topics into 'seen' changes.  Ideally, these cherry-pickable commits
that are stored under refs/merge-fix hierarchies SHOULD be indexable
by a pair of topic (i.e. "when topic A and topic B first meets, apply
this evil merge"), but this computation is cumbersome to write, so
the above scheme has baked-in assumption that we know which topic
comes later.  Once we start merging ps/setup-drop-global-state first
and then ps/history-drop next, we would need

    $ git update-ref --rename \
	refs/merge-fix/ps/setup-drop-global-state \
	refs/merge-fix/ps/history-drop

