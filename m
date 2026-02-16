Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37693328E7
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258722; cv=none; b=ogBbsax+YRXS4BTqbjqCpMxVYAwmf+lKqx2S6qe+MdMzvy2VzlPgbvsajfdk72JsQWx/OrhRTeowx7VpB4Yl18586Uug2MQ1GuZ0IKyCD9LnZpISMuEX5MwDziL7eqo8pbnPDR18LBU7xWhEacTlKFUMzbp0MMRWK2NJ3KyHuDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258722; c=relaxed/simple;
	bh=0t1k9ysdWeEzXjXk1A4FOAU9N9Nzxg9jTliJEZembLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBQ8d6PsTAGAxmvYPZ3Pkb7wlj++CKe/6rROw4io4BUx914taV1HereznV/LSRbodlNGA1UguaJo/PC19hqN/t84XeqdMHNB3aVvKejQhHBxIBbHUbnSSnwNNwv8zgfuE/CeGp670D42g2+fvF3a/H/0TZIp3dFsi/1yKRI21Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbT7lrlY; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbT7lrlY"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-436356740e6so4002093f8f.2
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 08:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771258719; x=1771863519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ClP5J6lQ/pNuITuPh3Rw0/2ZXiQL93zHbqqL1ZIPj0s=;
        b=NbT7lrlYvMGCoLuTlpW/LOG1nN+OCmL3T9Iiv4Sx1Wii+EiMMW0pY4pepLY5T+oPzE
         5xLxxzLJNFR+oSsPEWqdhZUVCpT7hY8wlvwFJlBVldKOPxegoXW5VsBz3k7IGkhqO3q6
         9oMcSm+2KcVmCgtTLFTXu9bMxt4vyDrXgvSlz73ns7kon2035CrCsY5NMhNEg2ZGo2I2
         XqVohpknTWbFn68cuUASwYHSP0GFgjlkNdQUF5kxiu69SM77Sf0kt0viYsMGqVjsl9IT
         UuCWVkmL6NWqRUHvD/hX0h7o3oAKUBAKLTxf/A8RA6csrhGdzkh+rlv2vdAhVdAthUSC
         sLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771258719; x=1771863519;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ClP5J6lQ/pNuITuPh3Rw0/2ZXiQL93zHbqqL1ZIPj0s=;
        b=RSciTIqX/K2KO5a2nonDo8E2pBIo30E6LqKSltd8jX7N8ouswheBCsay+x7hSdb8C/
         UvrtIaFb+iRCyn1I6pSzctLeypNkFdrRuaGkW6hCaidOZKQC1CbnjyGtLtXRoCyBkcNq
         4Vey6D2HuG26XX/4vbA551EaIJLID1rkbdICSTTPHm/AKm9eW5fiGe3SGmmsGwFFDFBj
         TjExlyq1oQ9Eqg5UEOZkLS62KTc9OhgmgWK2QFxbKOAznafWEmuabzxOKrONZTLoGzfU
         SYAM6T07V2AZiy45ZLkw9mTT4cnB2u05QtS/75pAFzWA9gLd+d10s2U/oCr6AhrWhztA
         g03A==
X-Gm-Message-State: AOJu0YxanW8IqUBQ04uyp/6YwZtKvfZRfL87YozWiQImwBM3q7NNUP34
	kMkNAYz5Fz1MFLkWL5qEjDBPsK/X0MHFw4AF75a5Z7ktkxQyoMRZb0eBO0J5ZW2x
X-Gm-Gg: AZuq6aKyG5jptxmc95stb9WzqN5lxu00GEaWiplBMR3YcZANJ+9Gbmg2AtEGaZVE6Am
	r1N3JcIKMymVQGjuKiNjSEnep6CLH2jXsEgFmdwXTt75oBdpuwbqr9pZnVhjTOskIqmocEyiKXk
	5QSSF/8lsAfWXDJDQX1Hz+bs8ruLMXTpHO8vQ8nxsCi44HHDjUnaBGPdG4qmpkEvdYLWOgkq4Om
	yUpHbnSh1xRPD/Jj4YfcyovBnVd7zMkr9bEhVIqJJVWz1L1wyjmmcDLsz4G+OfcdLT/HROr6ROe
	onXjX/SH1fGf6lgXJwlUUqg95qauHLxR9P8I1DMGSBW2QcV6MiLC2tXSwUnFuizsK/FcYKq+3Y1
	T55Detb5sf5hQL6/WpQkV1mwQ1B1xFo7JeLsS9rwmJBQ24u7+Y1ktivACFyZLCBDNJbylEkU3Y+
	nDyND9F1zzmS9g8UG10eIUjOYu9d0=
X-Received: by 2002:a05:6000:1844:b0:434:32cc:6c86 with SMTP id ffacd0b85a97d-4379db61567mr13732578f8f.14.1771258718754;
        Mon, 16 Feb 2026 08:18:38 -0800 (PST)
Received: from berwick ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc8b1sm29396714f8f.23.2026.02.16.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 08:18:38 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/2] worktree_git_path(): remove repository argument
Date: Mon, 16 Feb 2026 16:18:08 +0000
Message-ID: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
References: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

On 14/02/2026 14:30, Phillip Wood wrote:
>
> I think that we should add a new function
>
> struct worktree *get_current_worktree(struct repository*);
>
> to worktree.c that constructs a struct worktree using repo->gitdir etc.
> The worktree id is the last path component of repo->gitdir when the
> repo->gitdir and repo->commondir differ, otherwise it is NULL. Then we
> can use that function to get the current worktree rather than passing
> NULL when we call wt_status_check_{rebase,bisect} from
> wt_status_get_state().

Here's what that looks like, the first patch adds
get_worktree_from_repository() and uses it to avoid passing a NULL
worktree to worktree_git_path(). The second patch then removes the
repository argument from that function and always uses wt->repo instead.

Shreyansh - I think your patches to clean up wt-status.c can probably proceed
separately to these if you remove the changes to
wt_status_check_{bisect,rebase}().

Base-Commit: 852829b3dd2fe4e7c7fc4d8badde644cf1b66c74
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fget-current-worktree%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/852829b3d...23b8a355b
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/get-current-worktree/v1


Phillip Wood (2):
  wt-status: avoid passing NULL worktree
  path: remove repository argument from worktree_git_path()

 builtin/fsck.c     |  2 +-
 builtin/worktree.c |  4 ++--
 path.c             |  9 ++++-----
 path.h             |  8 +++-----
 revision.c         |  2 +-
 worktree.c         | 22 +++++++++++++++++++++-
 worktree.h         |  5 ++++-
 wt-status.c        | 29 +++++++++++++++++++----------
 8 files changed, 55 insertions(+), 26 deletions(-)

-- 
2.52.0.362.g884e03848a9

