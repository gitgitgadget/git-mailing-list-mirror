Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4D3911AA
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414541; cv=none; b=HDcvFuB9VF8In4gYsaX3v29yezcqWkDhBuq7++wLEe5oyYZH4Um7wYR2QZc4oOu96M1kiuYlO5GVU8F6LbNkUD+SoZvh824t0xzNocD0R1m63jqgn/85jYxbIVt0wZFZfbE24d/Zv0+cLcgyCNj/d9sJZeCUfOJJ/jW4tGzGRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414541; c=relaxed/simple;
	bh=LCSlTe9GRr9lLLWocQ11qnq16MEGdT4oDuJIwNywbxU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=utjCa1jPZrpRAvffwPumNhWPUQZtnXcWvtZg10/WntFAZOjryuQAE3XBMDIXkKKTUvv98moJqks0fEHRaH6jQQVPh0nhRshTj6OLMvXi3yFzFmIdI/37qfkQHC9Rp5bo75nUC8WFbNxja0E7GhkWLj1N2T6aY08mAcOLBZbGZzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ebp1z2Sj; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebp1z2Sj"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb7so317753485a.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789414538; x=1790019338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=23493zbbNa0sPxn7uDxk8mI06d9KS1143yL4AgOOuzA=;
        b=Ebp1z2SjGsrEfioPxwtsLSkMy1t8hPWOfWAt8L/+/d9001k7SCbTGp+GkKP4guVOx5
         g+ki5HWaoAWl4yCUE4zmaZAG461IPcyaKAfpj11XsAiPkQkmKcao5plR+Az7GV65fLiL
         TRBcwJDe8f3GEkotdD/4ZGGS859abgg33nlNoQGRv8uyuZ1O1HKgVx6W6F5KS5HjZVHg
         HYOvjRM/av2UCBsFj9g6ZxvlFDkCmk4axBSM1YVpy/73AwfRzEovmYYmguUARX9pZgq7
         u8jntzzg/39yjEJDCknDuHxRrJqPCp75XcSNJIyx+gHZ2+L1R6jcATKOxYXjYYSRykKO
         L0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789414538; x=1790019338;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=23493zbbNa0sPxn7uDxk8mI06d9KS1143yL4AgOOuzA=;
        b=YLKzXB2Z3tLK5hHSKar/meDckbTrM3geFaIWWOThTfa9KTmlnVlNqCvuGz+JcltkIm
         swhbQyOSQ8msVo9crR4F857vnZNCZQki2ioeyqIU1mEnRjnzcznwVVAptMFioutuiPxF
         4BFTBVQRT5HCOjTLZEeu5NK8NTlUcCQxo7yX2eCcLLfJPnB9gFSCQkS/h83RsWoaeKyt
         RNzBkeHk8/Cxxu96BccvFm5rnQEWsUQgMsxvICqiZVkD+XEF35y4SOvHq4NwWxUX9ErT
         i3UkV2wwdKsz2t2616FSoJz1qSMBUb2IdTGizjHZI68I/87KUHNBSWkeeGt9PVKdISG2
         zxVg==
X-Gm-Message-State: AFuF++mh8exUszIRSFTgf+rCqrUwXHLDpUvB8inJsS4FiPGq44Zymr3C
	9Fywf29bBooJ1SipAT+W4BRIUiuSaRgTE3Uq09TmhghZ/+p/t8yUnKgojFAk+A==
X-Gm-Gg: AYBFou0W4gMNYK/d1LGFiSB+gGNh4lvkX3Kzgs66CTCoafAE/5bpY9VVbeSPUe/ucZd
	jIaPAuWUqJD9EZdWScxcMG+e0TcXUT8jqrNGIXHf271Cd0S4eghZHu8ykoRB66relUtt4Zapmhl
	wXj9gVftYUJ7ZMZD+Z24Cvt4RAwQ09QwO2LBenvpw0HLPaEbmSDplkl2jzWqd7Vc76Ih3HsqJk0
	5UqREi4U4sEQKTRCFbfh77MWWjf0I/Up4JeFaLtE8afdA6EmJEW0tdcJZKJr0T+UEyUra+MW1q4
	INQusAxrKcaTN2MAvFU2Zo4i0TjFIJeoPKQElG3Ql4Y3BXLD9O6zm8IcYQ9B6GiHf2s8+d0hNZt
	l77WpU3/Qi1ZjOsdy2DRDzYfeVs9bFN37J/bx+BKHi6QoQedfS7wuyQzO4v9uJOgAW8Doem3hNx
	cSa3Mnxh8fuCx9dEfFz7BZxv83fJCXgQGJtZPWqLWm7j7QNwhKcsHymUkoNoovW5zNaoIFhUTDx
	g==
X-Received: by 2002:a05:620a:2702:b0:93a:abf:8163 with SMTP id af79cd13be357-93a29a05868mr704831985a.36.1789414538530;
        Mon, 14 Sep 2026 12:35:38 -0700 (PDT)
Received: from [127.0.0.1] ([48.211.213.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a26921baesm297190385a.24.2026.09.14.12.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 12:35:37 -0700 (PDT)
Message-Id: <pull.2218.v2.git.1789414536838.gitgitgadget@gmail.com>
In-Reply-To: <pull.2218.git.1789171955370.gitgitgadget@gmail.com>
References: <pull.2218.git.1789171955370.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 19:35:36 +0000
Subject: [PATCH v2] completion: complete 'git worktree repair'
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

The completion scripts do not complete the "repair" subcommand for
git-worktree(1). Add support for it.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    completion: complete 'git worktree repair'

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2218%2Fyoichi%2Fcomplete-worktree-repair-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2218/yoichi/complete-worktree-repair-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2218

Range-diff vs v1:

 1:  84cfa0da2d ! 1:  4f3f233065 completion: complete 'git worktree repair'
     @@ Metadata
       ## Commit message ##
          completion: complete 'git worktree repair'
      
     -    Added completion support for the 'repair' subcommand of worktree. It
     -    optionally receives a list of paths to linked worktrees or paths to
     -    worktrees with broken links.
     +    The completion scripts do not complete the "repair" subcommand for
     +    git-worktree(1). Add support for it.
      
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      


 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f8b9b50ff..c3a49e2e22 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3816,7 +3816,7 @@ __git_complete_worktree_paths ()
 
 _git_worktree ()
 {
-	local subcommands="add list lock move prune remove unlock"
+	local subcommands="add list lock move prune remove repair unlock"
 	local subcommand subcommand_idx
 
 	subcommand="$(__git_find_on_cmdline --show-idx "$subcommands")"
@@ -3866,7 +3866,7 @@ _git_worktree ()
 			;;
 		esac
 		;;
-	lock,*|remove,*|unlock,*)
+	lock,*|remove,*|repair,*|unlock,*)
 		__git_complete_worktree_paths
 		;;
 	move,*)

base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
-- 
gitgitgadget
