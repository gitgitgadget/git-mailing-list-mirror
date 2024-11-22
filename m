Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBA9AD2F
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732285913; cv=none; b=k1aSd6LYMgl1HTK3DpWntZ/nT/EYMysKgv+wDM6UOtTJovZMBGevPOsiZRQr10lkLY08C5uNBejabVa+z6jPpyeM3snnBhfe+etDcvoiKRi6KcfGTH3WQdEGechyfYaJPwp2zT+9TIk99U7AvnR+YIwp/ZTUkTdlW+87umwEWbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732285913; c=relaxed/simple;
	bh=eWLqMtfmxZQ0luFmcK2GgDn8DzrR2rwN5uUKoNSo874=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qUEJ2LecaS3dXbIO2t7oGd2gAlKLObdiquXqZwuouS5BvCqY9M8YIHy5PBA/1MRC/yWNy4kCw1MFxD5YP+/8aL/lQsM8qviCGlyFGcLYjYe4iwREz/uCUMipfJ032dQW3nLFL7+1+O1FvuMDlTdxj2UFJhauLRAThTg7JtY0bXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GX6lIKj8; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GX6lIKj8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732285909; x=1732545109;
	bh=dY0Th6qd552uowIC1YAlm6GMBK1voud53v1TdzEdZzE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=GX6lIKj8jxFFbkA4FmlKehLMyOBGI+cAsem9uZNY5ZnhmEKjn4peiJH7J2CsmDKqf
	 PUZ7G1tvoSXZRqQDOv7l4aSqj8u00+mU0dnoapcjgX3tgMXGirODGPuUFMvV6g7ixR
	 MlcG0Nqg9QdKNqa84OJRI/g8WjXK/ODzGbgduhpYfskMt0UrDEpTOvvrthUu0g5q76
	 Uv/G5m/Sn5BCPIlCF0YaPCtlLKIbUrvwQ6yIwfpPde4nsWzfaHeR+YQ6/qU4EVtGvx
	 Qs+sWmec28VfAdih6ym7NCtjlLZhrOAtRZps8GdTYX4wQRFfFFXSIIQbja9R+WHuMG
	 osw6+G+zBMn5w==
Date: Fri, 22 Nov 2024 14:31:45 +0000
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2024, #08; Fri, 22)
Message-ID: <D5SS3P7WQG4F.1I20Z59IDQMD1@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 37965e7ab0025e0f0685028bd16a70fc5775036d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 22, 2024 at 4:11 AM CST, Junio C Hamano wrote:
> * cw/worktree-extension (2024-11-01) 9 commits
>  - worktree: refactor `repair_worktree_after_gitdir_move()`
>  - worktree: add relative cli/config options to `repair` command
>  - worktree: add relative cli/config options to `move` command
>  - worktree: add relative cli/config options to `add` command
>  - worktree: add `write_worktree_linking_files()` function
>  - worktree: refactor infer_backlink return
>  - worktree: add `relativeWorktrees` extension
>  - setup: correctly reinitialize repository version
>  - Merge branch 'cw/config-extensions' into cw/worktree
>
>  Introduce a new repository extension to prevent older Git versions
>  from mis-interpreting worktrees created with relative paths.
>
>  Needs review.
>  source: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>

This latest round has been reviewed by Philip (cc'd) and I've addressed
his comments (mainly in regards to using test functions I was unaware
of). I was waiting for more comments before rerolling but if I don't
hear anything in the next few days I'll go ahead and do that.

Please let me know if there's anything else I can do to help move this
along, it would be good to get this in before 2.48 is released.

Best,

Caleb

