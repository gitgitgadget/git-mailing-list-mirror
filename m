Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A39B27293C
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739314819; cv=none; b=ckrCrW++Q1X4HeOcp6eo5wSnQPqJcHbq6gh6+OEDXATE5PRZnlcnoJm0cM+A4G4+VeRgbK0FqkeHnAVyoSmrGuyWD7YVQRrNYsGjb7V+kwZURGdGCp0S83VYArD7Fvh6anLqEwOLY7OdjqUk3OHe/SI25o2CilrfAqQcFk36c1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739314819; c=relaxed/simple;
	bh=w8VciQ+M19HxcTSBU2gndZ87H40SPcIkMDXXGqeq4E4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g7zoAvQSpF1dT+69fjwbASEDuaib/qyP/oaeufV+4oFairVs5ta2C5HNKQwIv368Y1FdPgZ7+oivhGTaGyOaD8ojfT1rpeDpJbGzzF/xETAv/tjczo0HQzhLTPzVGjFSt/JHQZf84BYk+3eAFMy5fCiGGVq4Ioj1BKjK3LU2EN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gu5itZjW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f4T3uac3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gu5itZjW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f4T3uac3"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7312911401BA;
	Tue, 11 Feb 2025 18:00:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 11 Feb 2025 18:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739314813; x=1739401213; bh=pCbL5CkcjV
	2odkaPXWFMcro5zn7Cwk+BM9rBjH8NC3w=; b=Gu5itZjWMPXz5T8q2v2LeBgTDw
	f7sDwijtMoqNI3POMnXwl+xKIoUMdek43JZE4c7mQGVcvyieJULSxtKqeB8q4wPM
	6l6Q5c0Ak+ojHNjTOVEIqdD73Ue4OV8pLo80/xChrD3G7XnnZe2uvO+krhOkCoHH
	qOAxqrrwp1uBCEUd9TdTi3G4q20udTVg1v60+OLzQdCu7/6jeePL/3HZcZwfPoyN
	ZhZocAtTXMXI+qDlsNZ13TUuJKeQZPIpVYpwj14/3VVOsZdJAEHNeloD8srE8tLD
	6cHe8NCmjpQpqF9OJxITrjrDH4/fyL+H0c2F9Lp9jCJtYnafTlEwnaXBeErw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739314813; x=1739401213; bh=pCbL5CkcjV2odkaPXWFMcro5zn7Cwk+BM9r
	BjH8NC3w=; b=f4T3uac36SexnmsRioXOFh8GAOlIl+WZ06bYqOc1tH+EICFqLWn
	b/0u069x6VrVK6V/5+R8m6cX9zF8/coYYWo0lEnkybhvFFm5ufLnPnRMPx2ynI7F
	ODYh0SSiDzrLvSTIMiqGFETd1eD46zoG5kResvDXwd1vGkk0MpOvvYeCqdy4q44n
	ZV0ksfg5IREGfCjIc7WZtXpkBMunL2SzpVFQ49TBGsG0ovtNUIJVnpGUakdbKkx3
	42kOrSiEEU6jgiMJc1H6MwO7gGfeW+IHFnjP+9AUOzji3QNRAxqToQNxWVr8X/vh
	ROFlwID7YvrI5FdXs/Sa/wU4ehmw9NpTwBQ==
X-ME-Sender: <xms:fdarZ-4WhVGQ8wvZ1s9Y2B1i9Nga8B9DV75SsyYpwl1Mq_aRNucBtg>
    <xme:fdarZ36zohcHA6kpKJnRdS9WcJOzBw50h5e42IWYyzD6yjVo9XCZPIr8oy2Z9Ad9b
    irfCcRNTlp4SSWTYA>
X-ME-Received: <xmr:fdarZ9f4EfFjlUuYoCHfn4s3nimqDTgeaYxRvotaCVhxv80knqy6Wible6pZLUHVpz7Gq2TeMEyDIqKNQp5IPoLGzvjWccW8br-uX_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepihhnthgvlhhfgiesihhnthgvlhhfgidrnhgrmhgvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrvhgrrhgrsges
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fdarZ7KJT-eMp8CwsHNSwsV2Fe01qcZ9ZZf7YxVn_EEUrPZDLyb2ug>
    <xmx:fdarZyJR73qbQEL-odlDPiFZkvsmOV5M5TE2CxJtqdwk1lcA8GGVyw>
    <xmx:fdarZ8yzCCN9-xasZYx927BbYVEJffHzqu8tEehBP3ADOBVaTg-sAg>
    <xmx:fdarZ2Jn69bgZhKvRBEB5AKmR_8hV2NaP_kCQ9I8fvGth3NKwD8VkQ>
    <xmx:fdarZ3HAqQ0PQ1DJ-eAcSwBWcK53GHSy0aVJWDVqE6X00uaG5-mW2xT_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 18:00:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 3/3] clean: add `config.exclude` and `--remove-excluded`
In-Reply-To: <20250210191504.309661-4-intelfx@intelfx.name> (Ivan Shapovalov's
	message of "Mon, 10 Feb 2025 23:14:39 +0400")
References: <20250210191504.309661-1-intelfx@intelfx.name>
	<20250210191504.309661-4-intelfx@intelfx.name>
Date: Tue, 11 Feb 2025 15:00:11 -0800
Message-ID: <xmqqseokw0hw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ivan Shapovalov <intelfx@intelfx.name> writes:

> Add `config.exclude` to configure "always excluded" files (same as `-e`
> on the command line), and `--remove-excluded` (intentionally without a
> short form) to "REALLY remove everything, dammit!"
>
> This might seem like euphemism treadmill, but there is a specific
> use-case for all of the exclusion methods and options:
>
> .gitignore:     files that _the project_ does not want to track or touch
>                 (build artifacts)
> clean.exclude:  files that _the user_ does not want to track or touch
>                 (IDE configuration)
> git clean -x:   remove build artifacts, but keep precious files
>                 (when a pristine build is desired)
> git clean -x --remove-excluded:
>                 remove everything, including precious files
>                 (e.g. for redistribution)
>
> Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
> ---
>  Documentation/config/clean.txt | 11 +++++++++++
>  Documentation/git-clean.txt    | 22 +++++++++++++++-------
>  builtin/clean.c                | 19 ++++++++++++++++---
>  3 files changed, 42 insertions(+), 10 deletions(-)

A few comments on the proposed semantics.

 - It is questionable to throw paths that match command line "-e"
   patterns into the 'precious' class.  It breaks backward
   compatibility and established end-user expectations, doesn't it?

 - It is nice to see that an effort is made to sift "excluded" into
   two classes.  The traditional "ignored/excluded are expendable,
   so "git clean" will remove them, "git switch", when path F is
   excluded and there is a file F, would remove it when it needs to
   check out a tree that has paths under directory F.  "git add F"
   and "git add ." would not add it unless forced.  We would want
   another class of files `precious` that are ignored in the same
   sense by "git add", but yet excempt from removal by "git clean"
   and things like "git switch".

 - On the other hand, it is a good idea to use a new source of
   patterns that the command never paid attention to, like a new
   configuration variable.  Since nobody has ever used it for
   "excluded and expendable", there is no risk of breaking end-user
   expectations.

 - This particular implementation falls far short of the ideal of
   "precious files" class, though.  Since "git clean" is the only
   thing that pays attention to clean.exclude, "git add ." would
   happily add those paths that match the pattern, and "git switch"
   to check out a directory whose pathname matches the pattern would
   happily nuke a precious file that is in the working tree at that
   path.

Earlier discussions proposed extended syntax added to .gitignore
mechanism and relevant codepaths, not just "git clean", all pay
attention to the new "precious" paths, but one idea proposed by
this series that is much better than the previous designs is the
use of separate sources of patterns---we do not have to worry about
backward compatibility issues at all with that design.

In my earlier review, I said it was clever to recognize that
precious would be of personal nature, but I now realize that there
are valid reasons why projects may _know_ what paths are precious
and would want to distribute that knowledge to its participants.
For example, our project would benefit from having config.mak marked
as precious for everybody, so that nobody commits such a file by
mistake and then ask us to pull from them.

As a configuration variable does not propagate across repositories
by design, it would not work as a way for the project to share its
idea of what paths are in the "precious" class, so in addition to
the clean.exclude (which probably is a bad name, as (1) we want not
just clean but things like add and switch also pay attention to it,
and (2) the class it defines is distinct from "exclude", and would
want to have the word "precious" in it) variable, we'd probably need
to have a way to record them in tracked files, either in .gitignore
files using some extended syntax, or separate .gitprecious files.

Thanks.
