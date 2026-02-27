Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6446AEEA
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221921; cv=none; b=f45YOXUa0jZoLWtZy1GS9iEMvghhLJCAiZa5hU/IInqgthreOG4cNxFZ9HZ9m308Lg1IU9ZXb42Nru0rtINcVSIsJTUsrxQ+XL/xo+ALopbremu2z9ETiDZRWXTe0xom14Pnb3QD2vtXjhmFmWPrPd4eOFcGClAZ9nHW/4Fkmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221921; c=relaxed/simple;
	bh=nX5q9sda5cMHymV7QqafEeJBeghzudSpJqwCpUYLe6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dLCNPh7dpinOTasbaYIZWuzVzeVSxAg+4AqYSGLO609NN/qPfqLM3gUAPoFcP1F9sV4U07cxHA6YyPjpZsLo5+6rBGKjxrHSrJqvirCqiFlgzMKq9ebz8O0DDESs7PHGjkg9aZBjr8J0Ya2V7hkPcVtb0gwqM2PpTSu+8na443s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rK4RIg6O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eg8Xhb67; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rK4RIg6O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eg8Xhb67"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 901951D0023B;
	Fri, 27 Feb 2026 14:51:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 27 Feb 2026 14:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772221919; x=1772308319; bh=xgicB20tgT
	NxXVBuI4Jehx+XRr2Tz8j+FmWBeuNVVGA=; b=rK4RIg6OoODD6I7ZSBI6qDVz9r
	j0gpBUw9HDq9JkgkLbIGCg2Z4oKVRM581F51DCTBIj51laj149SLhRREaOWS/YTw
	slJKy+pVRPpqvMYhZiu4/yt/UujJS1i9bWtNmGF5DXvhI4/mYdRiRJxkWiAojLDh
	AEKxidptNown9wMVtLJ2v3ceJfiaW/NUoM77TbMUv4IEP5EtBl/lOyHXhY0SLZrp
	l7SLt54rWVova1GOU1l0PhLHRSyQ1zWBxVXBJgRObfYMYWY8MNYVzJNEcJPDX5b0
	ak68xbX+9G2TP5QHTJJA9rFRbfKoPcCUtrk6WtTJeGiOaTwVU0wAKlJLhXnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772221919; x=1772308319; bh=xgicB20tgTNxXVBuI4Jehx+XRr2Tz8j+FmW
	BeuNVVGA=; b=Eg8Xhb67LJ6E0yATb0DwiKTbwTRcCth/YC2ZWSJB9zCft0alJTZ
	A9Lrg3BOEHO1ZyYyVWyEJaaYoU6ARojIzMZmx1y7v3C5atHOfrHUbxsVO8gWTMdP
	kGMD1FOh6o3mLyXS1uLEQLcfj+quE4/fL81tEO0hYp7REpIYglN0PvafKyPmWniZ
	cvUoiRdibIuB1Ju6KOgl51L3LB9qcMjVsB3q3LG+Pw333pr9gegNDYxQK3eGkwZA
	xtQnSjpna72vcri8x+oRmTRYgtGRj4Yr4AqEDmOWUB6IucuTdNGUcRs49uLViTa8
	aULk2Tt6eYxVV7n7bl5oCR7+ezGpPp+xR0g==
X-ME-Sender: <xms:3_WhaUndh_tb9doY9Qtb33V_v3zRfKGCrCJaHIlqea1-HipG2KecNw>
    <xme:3_Whaau0IZIQLy4QKOtLsZCHu2lmw3Rhp0_5ijlI5Z92eaDqGURQO2fPmdXwku2tP
    FS3EZ8Tv4oMTAT9lp91IXzQMY6MJzb5i_R1BSLpkZ4MqYMU6nS2VtQ>
X-ME-Received: <xmr:3_Whaa8hYvtsknQo0Rp1l6ghQw6uUUwtOZgn77nc8AOq-Nf96dGQ-jT7CLTWZPkzYJSZ-DJP2qPwo-J85Ign_k5Hjvo-GO8TDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvg
    hslhgrmhdrrhgvuggrrdguihhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3_WhacO7AIheAdmzt59KE_Y9l-f56hMUHCVzf-Dr_lz_UUeyqpycAQ>
    <xmx:3_WhaQHh2vcOg5X1uwVu9JCny2QfPxA_H7jKwIQ8_UYrbZGnXrcVsQ>
    <xmx:3_WhaSQNQX0v2xZZUf5uECIsPlit5Yih3M8l3C8AUj9xbzPp9ToZOg>
    <xmx:3_WhaVs46nENZ6SgQB3dLChBCVstcZGZ4bA-XcORGvHCWj7Wzu3UHQ>
    <xmx:3_WhabdPU0kv0_J1GMECaJ5BBo7JzGycGZDzelMS3hz41KH04wGEafGN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 14:51:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Eslam reda ragheb via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  eslam reda <eslam.reda.div@gmail.com>
Subject: Re: [PATCH v4 02/10] repo: add path keys to repo info
In-Reply-To: <3c4d4909-4eb1-47f4-b601-8f877a07ddd5@gmail.com> (Phillip Wood's
	message of "Fri, 27 Feb 2026 09:04:04 +0000")
References: <pull.2208.v3.git.git.1771875812.gitgitgadget@gmail.com>
	<pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
	<6d5b9ff07566e1cc28a672cf1f47988e9c8c45da.1772140487.git.gitgitgadget@gmail.com>
	<3c4d4909-4eb1-47f4-b601-8f877a07ddd5@gmail.com>
Date: Fri, 27 Feb 2026 11:51:57 -0800
Message-ID: <xmqqldgeotgi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +	{ "path.common-dir", get_path_common_dir },
>> +	{ "path.config-file", get_path_config_file },
>> +	{ "path.git-dir", get_path_git_dir },
>> +	{ "path.git-prefix", get_path_git_prefix },
>
> I'm not sure about calling this 'git-prefix', 'prefix' might be more 
> appropriate as it is about prefixing paths in the worktree rather than 
> the git_dir.

True.

>> +	{ "path.grafts-file", get_path_grafts_file },
>> +	{ "path.hooks-directory", get_path_hooks_directory },
>> +	{ "path.index-file", get_path_index_file },
>> +	{ "path.logs-directory", get_path_logs_directory },
>
> We're moving away from file based refs and reflogs so I'm not sure 
> adding this, pick-refs-file or refs-directory is a good idea as we 
> should not be encouraging people to access these files directly.
>
>> +	{ "path.objects-directory", get_path_objects_directory },
>> +	{ "path.packed-refs-file", get_path_packed_refs_file },
>> +	{ "path.refs-directory", get_path_refs_directory },

The same comment applies to these entries as well, as the pluggable
object database support is just beyond the horizon if I understand
correctly.

>> +	{ "path.shallow-file", get_path_shallow_file },
>> +	{ "path.superproject-working-tree", get_path_superproject_working_tree },
>> +	{ "path.toplevel", get_path_toplevel },
>
> 'path.toplevel' matches the git-rev-parse option but 'path.work-tree' 
> might be more descriptive?

I think the "git repo" thrust comes primarily from being unfamiliar
with "rev-parse" (and I wouldn't particularly encourage new people
to become familiar with it---it grew pretty much organically driven
by scripting needs without taking UI cleanliness into consideration
very much), so not many folks would find it disturbing that
"--toplevel" corresponds to "topOfTheWorkingTree".  Given that we
have a token to ask for superproject's working tree, giving a name
made after the same phrasing philosophy for the current project's
working tree would be a good thing, i.e., "path.working-tree".

> What happens if 'path.toplevel' is requested in a bare repository?

FWIW "git rev-parse --show-toplevel" dies with "must be run in a
work tree".  Better or worse, 

	rm -fr new
	git init new
	cd new/.git && git rev-parse --show-toplevel

also dies the same way, which I am not sure we want to inherit when
we are making a new interrogator command.

Thanks.


