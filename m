Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0751C32
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735567545; cv=none; b=TYXrgApYaorxNCPtPNJEc/8hfTDybYXC43XT3Y5xDtlfu7D72BwsKVne0J6HIPrbCA/rtGLkEfk81v12itw5TEcszq4bRl3Wyiv1S64LP085Zc7zF5VZo1GcMUlgr9Tm5JPQlG2Cte7g6AAcZVhzcJ7EXTyn4wtMY+neHQ43B3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735567545; c=relaxed/simple;
	bh=71Po+Xj8tVEGEcf0sgqNRRgNTdmpzTH4l62w5KXbcdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dw2FV/ODLX4lhrAEvHlufnKkmkMKVA9I1ERTmspGQkW8WgFdcBCZuuVRe6UE+Bybm5opepmT7y8Rkls8BaNT8q4I0+2I5Z86cvvYPB0RE8XfK9ltq1j6Oam3wxRGZhvp/cHIXUSuB1lcaDT6H9mU0KkAbYqXM4RWvLXnakAPug8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sp/+23Ze; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lJhs+NlD; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sp/+23Ze";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lJhs+NlD"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BCCF71380715;
	Mon, 30 Dec 2024 09:05:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 30 Dec 2024 09:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735567542; x=1735653942; bh=QAG6XriGV0
	7rxi0WjjEcUC5uuCOqJ1Aa26Yq3vxQhzQ=; b=sp/+23Ze+L5rDEVlMcf9p7FtMg
	oWb4DJRNL6dhMeCDcsQDSS2rXWyAaai+qY2GGVyehtnXsdS/URE8L94lTgn13+TE
	aO4gj8bjznCWXnx2XYMnd6CNp28Yh6CAwchbb11zLvHKEZrGLuxH4thNsuVhcpVG
	DvaLqpMXGtsmpeSQ64SOr97/yz61uu7pUWXbpqH7cXcZC8hL1Q71gseceYMRMD7X
	Wd0/Ipwb7x3ArjK2iQaikgD3IsEHvpXUsZy8HMpXATglroI+mAZaDjw5tff9KBQa
	Pyq0E3qeDxnQBL/yc5Krv5tz1bougLoyglKJTenxz0YtcwfY42+tjaTivO+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735567542; x=1735653942; bh=QAG6XriGV07rxi0WjjEcUC5uuCOqJ1Aa26Y
	q3vxQhzQ=; b=lJhs+NlDQKiB2NxzTM2eZMNzJHWNSf6rFoY2F3OjEwQ3ElBlvOL
	OtTJ0Id4QBZVRRrTxPKkiR0LuwUfdF1S8b3x/bADwXLLCKC44Gd9NekVuLqdD4me
	4B2l/p+AIabrW1WTksD9xMBjjdP9ff3awrbkyLEY50Vu/G+42FjjQXvoaaswVhGx
	0U4W4eb64lGksymfqzpDxwenjHoGvs8ZIWuTURYZfuAbNvHcc7AbJdCU417j44Wp
	XGQ8DsAAD8FivA6ZKNb+E1WOqIhm3Vv4NOfOnh6emGMcT++6g6Ax+jAA9x1zkbcx
	YKRhfLhstZudNPGVNK2tUA4PKlW0oYbKl/Q==
X-ME-Sender: <xms:tqhyZ1fw5hkayCdTVnQK8hmjV-dauar1XhMP8sXJZmooP57m4OJvdg>
    <xme:tqhyZzObbM3azBg8qgnfdkuy-jJd7-AlJOLn2gVORgH8-jnEsEGRK9VfuBvN5TmS4
    D6lXaGUvTJnQxXerw>
X-ME-Received: <xmr:tqhyZ-g-Ek-Qr91NE_63ofSMmrdolkSnJCPv5ZFMFv-42ccNutzd-Ye_QDoJF5B-JRoLO3aT75--rEvP6_fBzloBozLOI7YPvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgshh
    grmhdrkhgrnhhoughirgdutdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tqhyZ--kDIIfueGEhDy0BRVBtdz3LfqzK8Uh6s_cOELoGYj8Z7Jw4Q>
    <xmx:tqhyZxu4KEZN601am--LqxA-iiTpGIZnMlSlw0biDyX4K_ovxtr1UA>
    <xmx:tqhyZ9FBiRh34tjswUUnLnntaL9zfToS5lNY7nW288k16O5L3yyTmg>
    <xmx:tqhyZ4Nd3CDWlfHO-HoAZQqTCsaTfn0irDLTFWBGrroFY-L52dz4OA>
    <xmx:tqhyZ_UyTYCaCMoPFXwcCR9-YzlGviCY-imPoR2qRaOsufPe4Qyb-F-v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:05:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Shubham Kanodia <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH v2] maintenance: add prune-remote-refs task
In-Reply-To: <Z3JIpDQTDrQuoEN2@pks.im> (Patrick Steinhardt's message of "Mon,
	30 Dec 2024 08:15:55 +0100")
References: <pull.1838.git.1734946566885.gitgitgadget@gmail.com>
	<pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com>
	<Z3JIpDQTDrQuoEN2@pks.im>
Date: Mon, 30 Dec 2024 06:05:40 -0800
Message-ID: <xmqqh66l1d1n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Dec 28, 2024 at 10:07:41AM +0000, Shubham Kanodia via GitGitGadget wrote:
>> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
>> index 6e6651309d3..8b3e496c8ef 100644
>> --- a/Documentation/git-maintenance.txt
>> +++ b/Documentation/git-maintenance.txt
>> @@ -158,6 +158,26 @@ pack-refs::
>>  	need to iterate across many references. See linkgit:git-pack-refs[1]
>>  	for more information.
>>  
>> +prune-remote-refs::
>> +	The `prune-remote-refs` task runs `git remote prune` on each remote
>> +	repository registered in the local repository. This task helps clean
>> +	up deleted remote branches, improving the performance of operations
>> +	that iterate through the refs. See linkgit:git-remote[1] for more
>> +	information. This task is disabled by default.
>> ++
>> +NOTE: This task is opt-in to prevent unexpected removal of remote refs
>> +for users of git-maintenance. For most users, configuring `fetch.prune=true`
>
> Do we want to make this linkgit:git-maintenance[1] even though this is
> self-referential?

That certainly is a thought---the rule could be "whenever we refer
to a Git command, we refer to it in a uniform way".  An alternative
would be "of git-maintenance" -> "of this command" to weaken it.

This refers to those users who want to use the command for other
reasons (you use the scheduled tasks driven by 'git maintenance'
only because you wanted the 'gc' and 'pack-refs' tasks to run, you
do not necessarily want to run a new kind of task the new version of
Git started supporting, especially when the task is destructive,
like this one).  We might want to stress that point, perhaps?  If a
reader reads this part of the documentation, finds this task useful
and decides to use 'git maintenance', the note would sound somewhat
nonsensical to them---"I thought about the ramifications, I decided
I wanted to use the command, why would it be opt-in?" is a plausible
confusion.

>> +is a acceptable solution, as it will automatically clean up stale remote-tracking
>> +branches during normal fetch operations. However, this task can be useful in
>> +specific scenarios:
>> ++
>> +--
>> +* When using selective fetching (e.g., `git fetch origin +foo:refs/remotes/origin/foo`)
>> +  where `fetch.prune` would only affect refs that are explicitly fetched.
>> +* When third-party tools might perform unexpected full fetches, and you want
>> +  periodic cleanup independently of fetch operations.
>> +--
>
> Nicely explained. I wish we had more such documentation that is taking
> the user by their hand and explains why they may or may not want to have
> a specific thing.

Yes, a configuration or an option that are not for everybody and for
every situation need such a guidance, and this one is done nicely.

>> +static int maintenance_task_prune_remote(struct maintenance_run_opts *opts,
>> +					 struct gc_config *cfg UNUSED)
>> +{
>> +	if (for_each_remote(prune_remote, opts)) {
>> +		error(_("failed to prune remotes"));
>> +		return 1;
>
> I wonder whether we should adapt the loop to be eager. Erroring out on
> the first failed remote would potentially mean that none of the other
> remotes may get pruned. So if you had a now-unreachable remote as first
> remote then none of your remotes would be pruned.

I think the structure, hence the behaviour, is shared with an
existing prefetch task.  I think the current way is OK-ish, but
given that we are not in a hurry, we may want to correct the
semantics for both of them before unleashing this new task to the
world.

For that, we need the callback functions given to for_each_remote
(i.e., fetch_remote and prune_remote) to always return "success" in
the sense to tell "I am done with this remote" to allow the loop to
continue to the next remote, and convey the failure from the
subcommand via some other means (like flipping a bit in the cbdata).

Thanks.
