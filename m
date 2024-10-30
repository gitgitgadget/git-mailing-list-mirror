Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FD1D1731
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319699; cv=none; b=cDbxpvsmoK0TqOf/0PgBFzH6ZEq01SoriBo6mnL+pZofzfKcdI9CpziQCwu+x2s5pN/MbPr9qOsLt4clnju1SHgIsHBYezB5NzI5kw0FocUW90B09+knfv56X7JdITTL/UVhIz/5pBBU6vQhf3TPWT/7/kPZ5yZ8Pz6kLm9uXiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319699; c=relaxed/simple;
	bh=ESeBnN2ftIdOL+xaU3eScPNgFkLIRRYvmiegN4kI+N8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHENcZj+vy3gAQKAI6qM2jHzzyr+v5uofZKrB8TYFX/VSnCGgqiiAL7I+7ZhM67uqq250ObXDBd14QZY9McLTV8UpVk3DEHnnkqXoP4APm/r0Umpfz2O0ejSe4jMAU9rZ7nKwhm4k10aGdM+TKSC6ipzxBDwPRmctOZ5/NmRI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=bGpaX8xA; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="bGpaX8xA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730319694; x=1730578894;
	bh=P83M95nsEvZ1XkwmtP6oIyXdRjGGwk1H2FdfwR2Z6+I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bGpaX8xALp15yBZSafuGxiHnOGv3FUjjdZXbE5A4SGlA0HoGcw7UXMxHCyb5zznw3
	 UesumBRnZUvM9Tb8kZ2axdpf1ptvfns0PGAkTqRbuYyv9MEY9QMpYxkbSHpk3+RA81
	 V9g/wejzh4GlTSXL7WgzrN3M7mJMLepGH/wfu+9y9Qib/jE7VB/XmmO9635BhIE47Z
	 u6j08P9MRiB9m6Ij3j0bdZQgM33SQh1a7W0ZTFoplZy5Zxo1EoCw5AnFZ/fQrE5tjX
	 mAMJ7TsqkOPbqBKsfDmQGMfBCotKbnaD7N5409yh0PnF8eRUA55cIUeoW+ZCDluuwW
	 WdoTL76UQp70Q==
Date: Wed, 30 Oct 2024 20:21:28 +0000
To: Taylor Blau <me@ttaylorr.com>
From: Caleb White <cdwhite3@pm.me>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] worktree: add CLI/config options for relative path linking
Message-ID: <D59F4X1I5COT.1QECM7J128ZIG@pm.me>
In-Reply-To: <ZyKUEbXedFuzY9Oz@nand.local>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me> <20241028-wt_relative_options-v2-1-33a5021bd7bb@pm.me> <0bea06b8-11d0-497f-88e1-153cb61eb06d@gmail.com> <D58W4HPIF8VX.2TWFTU2A2VSYY@pm.me> <ZyKUEbXedFuzY9Oz@nand.local>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: a60ebd6b044d88fe712ea2bb6dfc2e44e9c586be
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Oct 30, 2024 at 3:16 PM CDT, Taylor Blau wrote:
> On Wed, Oct 30, 2024 at 05:27:33AM +0000, Caleb White wrote:
>> >> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> >> index dae63dedf4cac2621f51f95a39aa456b33acd894..c1130be5890c905c0b648=
782a834eb8dfcd79ba5 100644
>> >> --- a/builtin/worktree.c
>> >> +++ b/builtin/worktree.c
>> >> @@ -134,6 +134,9 @@ static int git_worktree_config(const char *var, c=
onst char *value,
>> >>   =09if (!strcmp(var, "worktree.guessremote")) {
>> >>   =09=09guess_remote =3D git_config_bool(var, value);
>> >>   =09=09return 0;
>> >> +=09} else if (!strcmp(var, "worktree.userelativepaths")) {
>> >> +=09=09use_relative_paths =3D git_config_bool(var, value);
>> >
>> > As we're trying to remove global variables from libgit.a as part of th=
e
>> > libification effort I'd be much happier if "use_relative_paths" was
>> > declared as a "static int" in this file and then passed down to the
>> > functions that need it rather than declaring it as a global in "worktr=
ee.c".
>>
>> I can create a getter/setter in the worktree API to handle this, but
>> I'd rather not pass it as an argument to every function that needs it as
>> that would be a lot of changes. All of these functions would need their
>> signatures updated to include the new parameter:
>>
>> - `add_worktree()`
>> - `update_worktree_location()`
>> - `repair_worktree_at_path()`
>> - `repair_worktrees()`
>> - `repair_worktree()`
>> - `write_worktree_linking_files()`
>
> There is no reason to have a "getter" and "setter" for a extern'd
> variable.
>
> I agree that it would be preferable to have use_relative_paths be a
> static int within this compilation unit and to pass it to the above
> functions.

If I created a getter/setter then the variable would no longer be
extern'd.

To be clear, you're advocating that I change the function signature
for all of the functions listed above to include the new parameter? That
seems like a lot of parameter bloat when I could just set the variable
in this compilation unit and access it directly in the
`write_worktree_linking_files()` function.

Best,
Caleb

