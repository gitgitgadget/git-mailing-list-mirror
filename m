Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB352BD5BD
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969170; cv=none; b=hPuSyeFRebgsKUxwyMcHsuile2z9++ik7SEOXy8ol5nv4ftLd7omCkyiPVXek8DAo29GlQoefECQKmGhTn6cGha/iWVL16qbDYKF0UAhrNnFjXs4lh8vUkZm877g6NtJzWLWW6BKBFMIxNV06PYdfGlwghHMr/EVdN3AIYkFW0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969170; c=relaxed/simple;
	bh=rt6eFRUeVVqKUQNye3i3lMoUFOgyKHF1EoQklmvqgwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mslgs7Gh7mQHyJvo8Rf2rMER63+ReZhYPK38/cxUCL8kukcBt22bbZ91n75rb8Lm84m/QG+Pn6jAGx8x8IzJPXDyWydbsdEeXnwE4w52qd5iEuaefarwlEc+CT8etkNQJ34zz3EHHeqgcN8vh2jjOjZAm0PuoqZ1yA5opCDwndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kwvdf/zy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MBB26K1K; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kwvdf/zy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MBB26K1K"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F9AA7A0047;
	Fri,  9 Jan 2026 09:32:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 09 Jan 2026 09:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767969162; x=1768055562; bh=zK16xHQ9gl
	NNXlbJRye5NGtcKlChRLwxKyCMWRUAX7c=; b=Kwvdf/zy9bC5rJjBWwuV+98e0E
	dyaemTEwfMnLsGFBVjwOKE2Km+t0BfecxPKhFVYMEKf/EDLO7C6k4T/er3o0osFG
	+H7p4jJgM4gwX3ahsogZ1GL3iBLjtup1feZVfvVl4RFYDaoqa+rIAMotl7x0+fQv
	cjErDnW8vzsZJTYUue7ZFsbaSNcV1WUelJRDV2655cByCmZdmuPRSs71X7bXQxnF
	2wJkjUsyu24koN05bMgIG/x06dKzy+ps5rekSP2T6X+lio7eqhm0oW1g5EQBjC/v
	MlOWtsLlRRs0wuDiOrAsIm3TowsAzF8A4BPSHef7RU11OrcMlUesRAbCX8qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767969162; x=1768055562; bh=zK16xHQ9glNNXlbJRye5NGtcKlChRLwxKyC
	MWRUAX7c=; b=MBB26K1KVIyTZR5QAeFpqzfKNgLQDmdcN4FqVw8H4bavqzd5JrS
	NV4BKT4E/CgnZ4gCXapXED7SISmZZQxHQGymaWaKmSHper98GIDbH9tyRcGqjNsX
	U1GW25IwBYAszZVz9D+Czw7RxIR6xuW2EATYNWDA4y/wUaMcZe39g2lfI1a45X1/
	BeFgq1flwFr9dHJ9ifBKghgFbuMEzdtbPCk20eizR4sOyj8FuzbR3pOK1toEYgDi
	ucMJTC+LVe0yiBbK3qUNmulAFWOlkVWTCxju8pJDjeCHl5f18Kaht2hzgM9Is04N
	3MYJ/BXfqwDcMMIXFjOBaWUwfaudgRlxmiQ==
X-ME-Sender: <xms:ihFhaVw6SUXKhv8gcPCfhEA0oJU-8FMMsIS_l5W6W4B25x1xrBYm_g>
    <xme:ihFhact4PpHMTpbw0OkSlfheaHHaJ-mGZOwzFvNx8w0ge0fDEtXsIZ78rH0NvYRff
    o0CsN3o8YhZfR1VfCSL4n03bN7tby4kGuXzQ5ZE2mnS3C6DogA7>
X-ME-Received: <xmr:ihFhacvYwZHzTGUqjRAp7y80b4ehI5G0coEXqZoRHA1jTbmuFqXF05007H9joe8Y1umYniZlRhYeRrUrQjAq9_5Aj9ljuStpoZiSHCs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:ihFhaRM0PgZ3Mh-L26JxPcqZZXGa5zbOo9KeVxAR86x5Q56jY1mn8g>
    <xmx:ihFhaa25KnG_Npd51mJ3FhkiIATSqez_-2b7l3H5_08fIVZWzKWPDA>
    <xmx:ihFhadP9D86aBMdLou1IOqBAny6l_kKs0C2CqogPe57TJMP9JVIUzg>
    <xmx:ihFhaa2uMYFZ8L3I2QVTKxJ5kORKkH__0SS9IKjt1DSJJ3yaPjfFeQ>
    <xmx:ihFhaa5vZBOugo6c8b_f-6DhpfaYvug6i35ZKB0EecFt1xj7D8nhaamZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:32:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] gitfaq: document using stash import/export to sync
 working tree
In-Reply-To: <20260109014608.42773-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 9 Jan 2026 01:46:08 +0000")
References: <20260109014608.42773-1-sandals@crustytoothpaste.net>
Date: Fri, 09 Jan 2026 06:32:40 -0800
Message-ID: <xmqqseceua9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Git 2.51 learned how to import and export stashes.  This is a
> secure and robust way to transfer working tree states across machines

Here "secure" in "secure and robust" triggered my "huh?" sensor.  It
is a robust way, but is there something particularly "secure" about
it, other than "it is less likely to break your repository" in the
sense that is already covered by "robust".

Everything else in this patch (including the patch text, of course)
I found superbly good.  Thanks.

> and comes with almost none of the pitfalls of rsync or other tools.
> Recommend this as an alternative in the FAQ.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/gitfaq.adoc | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/gitfaq.adoc b/Documentation/gitfaq.adoc
> index 8d3647d359..f6c9b9d9f7 100644
> --- a/Documentation/gitfaq.adoc
> +++ b/Documentation/gitfaq.adoc
> @@ -233,14 +233,30 @@ of refs, such that both sides end up with different commits on a branch that
>  the other doesn't have.  This can result in important objects becoming
>  unreferenced and possibly pruned by `git gc`, causing data loss.
>  +
> -Therefore, it's better to push your work to either the other system or a central
> -server using the normal push and pull mechanism.  However, this doesn't always
> -preserve important data, like stashes, so some people prefer to share a working
> -tree across systems.
> +Therefore, it's better to push your work to either the other system or a
> +central server using the normal push and pull mechanism.  In Git 2.51, Git
> +learned to import and export stashes, so it's possible to synchronize the state
> +of the working tree by stashing it with `git stash`, then exporting either all
> +stashes with `git stash export --to-ref refs/heads/stashes` (assuming you want
> +to export to the `stashes` branch) or selecting stashes by adding their numbers
> +to the end of that command.  It's also possible to include untracked files by
> +using the `--include-untracked` argument when stashing the data in the first
> +place, but be careful not to do this if any of these contain sensitive
> +information.
>  +
> -If you do this, the recommended approach is to use `rsync -a --delete-after`
> -(ideally with an encrypted connection such as with `ssh`) on the root of
> -repository.  You should ensure several things when you do this:
> +You can then push the `stashes` branch (or whatever branch you've exported to),
> +fetch them to the local system (such as with `git fetch origin
> ++stashes:stashes`), and import the stashes on the other system with `git stash
> +import stashes` (again, changing the name as necessary).  Applying the changes
> +to the working tree can be done with `git stash pop` or `git stash apply`.
> +This is the approach that is most robust and most likely to avoid unintended
> +problems.
> ++
> +Having said that, there are some cases where people nevertheless prefer to
> +share a working tree across systems.  If you do this, the recommended approach
> +is to use `rsync -a --delete-after` (ideally with an encrypted connection such
> +as with `ssh`) on the root of repository.  You should ensure several things
> +when you do this:
>  +
>  * If you have additional worktrees or a separate Git directory, they must be
>    synced at the same time as the main working tree and repository.
> @@ -251,10 +267,11 @@ repository.  You should ensure several things when you do this:
>    any sort are taking place on it, including background operations like `git
>    gc` and operations invoked by your editor).
>  +
> -Be aware that even with these recommendations, syncing in this way has some risk
> -since it bypasses Git's normal integrity checking for repositories, so having
> -backups is advised.  You may also wish to do a `git fsck` to verify the
> -integrity of your data on the destination system after syncing.
> +Be aware that even with these recommendations, syncing working trees in this
> +way has some risk since it bypasses Git's normal integrity checking for
> +repositories, so having backups is advised.  You may also wish to do a `git
> +fsck` to verify the integrity of your data on the destination system after
> +syncing.
>  
>  Common Issues
>  -------------
