Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9E3B1029
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869951; cv=none; b=sYiOHSspKHRDCvu4/cFSxOjHEC3MpemN61fzzXNXn0wCGHQERooWc5ooH4j3S4VDU019wQl2kjzdIz8Fot9kcZNCjyt6kSponivQQoH6zu/JynyLvZpyDU9kCNX5uuZ1bjTpizGv7n4jJ/mmcqkxgeENgbYNQcrQU0Ly0vNw/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869951; c=relaxed/simple;
	bh=XexCRLw5fPVTKpLv2cqdSUXKKWWW81hdGK62qdMK3nA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zze1evssY7R3iN8lgFkq/jAotDYCGyhWF/i3So4V58Hn0QmxnEwmnNShViKucp2w1/mgkAE9nZBvp6Ivf4ImBbeJysEeszsLRhYrqFohISrYgaVzcIuuHyS17RT11QMX3HbVigMsmuMXzBWYMuHnXVnPLpqVY16Rwuj3bCi4jxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPm10TwY; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPm10TwY"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b0503e39fso1223329f8f.0
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869947; x=1791474747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+dhJI48dzgKFAn/XIjHMoI4geTNoxLVQ+2x1Nd6Is6c=;
        b=oPm10TwYfzo5D290v0isEtTJosBJvVtGRwqDqa4G6owpQJdbfSqxNanYaNxkuS7mrt
         UEBduMJ70RA3DWXXulmURtk1jqNjGTVFzYOUberwzJ2fgqbcHpagE2zlZ62RNOujOyQD
         FpjgP5MPgpUHr1jb1kei+RakzsHSiaT+2YHN8Q+SMfITxOR2lrlFJgUHaJtMAp3hQNlR
         iIzFThlpnrvbDcEKyfuwEZbmTgBpFdqBnqM1/R8S2/IhCPwFeuOYSHMqnJtmWdQ81QeU
         RqDYj3qmWiX73huzRH+FuJiyKho61sm8RRs30SmcAtZsbF0v1fo6niMoPtS8doGILZVE
         kivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869947; x=1791474747;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+dhJI48dzgKFAn/XIjHMoI4geTNoxLVQ+2x1Nd6Is6c=;
        b=Y8OTr4ieKngh8Mbz6y3NGtNq05lEi99dIIk5KvIQ2uWi4L2sW0VmlqXgbus8rc8GVi
         ZPtEbvfnI3vWjNastXGUnVFbbHl6RvM0wKSAO6TItWcaCtnKQHeCNG02XBnxqcKDksPY
         109THNU3d02GUSUPHI9v6SDKE4ogie4tRNiNgJH3dVU7mTmbjVWLuOtilUnZCM9Nqkwr
         FMTRe9PqUyU0nneV1PItRuRcqhxpYD/mdAlP+Uz5cPH66xRDJFqEIWIl+3L2omOyVsou
         GggmZ68vP5J6OhC/fEHBqDB3EDWip1Z5RtN8J7WSpmfwIqnki0ddQUk1D8f2TT/exLXy
         mS2g==
X-Forwarded-Encrypted: i=1; AKwUvBy8oaUhTsOubHhadzu9AsHom6DnS2BF0W50Cq9PG+koXueWGFcgMpz4fZScu+nh+BeM+BA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9Ck92F5Xv1IR0e9nL0r/V9HPG/kOWXxWn+yh53Z/W2b3JlKFs
	naeGXtBPqwSrl4yebs5xn22FkJ8KZ4Ud1b6KHCiCu/38UoKxcYMOas9j
X-Gm-Gg: AYBFou3gc/Lr4xzAly9Y/mOCkmVlCFBdWo3qIE7NFFrIPxF2g1Fp+q/dlr1vlKs6Sy6
	tAUs/WfK2CMzViGDBORo2RAAzjm/qhCD9i23Nps5Pwf2NMAnSkFOIQbH8f4WcOc6jTQRww1FDDS
	VG+ZK16PRKygI3/GnWB8XJM4h41y4jfhBnAnf/l7XLUnpeh5lkRtYhBtxoDnd9LeYGZNzGrPvm4
	kYREXY/oS0dDVSZPqKnnrNnu09sExGe9aaxaIZM8kGIxZitoScCaMlGBOcn39dlMDC1E3+3KGtc
	fhj+WzHopDyE617L3fusy44JKwY4PPY5u91TxsLOWa/Z0uEh3jj+ONrxH8o/2a2eSPf/sR4u0Lb
	n7BdZp9bETrZur/3/S/S6vNMg8yYRAhLfIj44JlK0z05KNlQG31SuRxM2v+lVGSwgxokAyBu+KF
	yzjdJGmaMGOtDn9UIZFEz22HoHPf9GiOe/wLxOQmcGVyJ7SHuicJ8oNy1Km0Avz5xwTobeqs+zt
	djIcZhal6rvIhn8Ndll5dG1xouEUJN1fKcjYM3CZ/k5Ay1MM51RKw==
X-Received: by 2002:adf:e195:0:b0:48b:e25:21d6 with SMTP id ffacd0b85a97d-48b0e25257bmr4246635f8f.41.1790869947229;
        Thu, 01 Oct 2026 08:52:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0692b5c8sm5806744f8f.29.2026.10.01.08.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 08:52:26 -0700 (PDT)
Message-ID: <d3adb734-2b84-4d7b-b245-5407ee410eb4@gmail.com>
Date: Thu, 1 Oct 2026 16:52:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/4] stash: clean up index-mode test merge
To: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Cc: Eli Barzilay <eli@barzilay.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <cover.1789853192.git.ben.knoble@gmail.com>
 <cover.1790803471.git.ben.knoble@gmail.com>
Content-Language: en-US
In-Reply-To: <cover.1790803471.git.ben.knoble@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 30/09/2026 22:24, D. Ben Knoble wrote:
> 
> Changes in v5:
> • Rebase on synthetic merge for the test interaction with t5520
>    (dropping old 4/5) [59d1ce1b6e (Merge branch 'tb/t5520-reflog-expire'
>    into dk/stash-apply-index-incore, 2026-09-29)]
> • Fix handling of tri-state merge_result.clean

The range-diff below looks as expected, thanks for working on this, I'm 
really pleased to see us removing some subprocesses from "git stash".

Thanks

Phillip

> Changes in v4:
> • Drop merge verbosity changes altogether. I was going to
>    save-and-restore, but when looking at the index-merge test case (more
>    below) closer, I noticed that "git apply --cached" reports conflicts
>    on stderr. That is, "git stash apply --index" would report conflicts,
>    and silencing the merge takes that away. So instead let's leave the
>    configured verbosity alone.
> • Only copy resulting index merge tree OID when successful
> • Fix interaction with t5520 (new patch 4/5)
> • Squash test from 3/5 into 5/5, since it requires actually merging
>    trees. I've elected to keep it a separate test for now (contrary to
>    Phillip's suggestion) since it's written and working. Adapting
>    existing tests requires quite a bit more digging into implicit context
>    assumptions ;)
> 
> Changes in v3:
> 
> • Change conflict label for current index
> • Fix memory leak of merge_result
> • Fix order of trees to make the correct merge (cherry-pick)
>      • New test (3/5) to validate this
> • Fix test in 4/5 to assert more details of expected state
> 
> Changes in v2:
> 
> • Do give branch labels for the incore merge, although they are never
>    seen (and clarify commit message as a result, also keeping the
>    merge-ort asserts). Phillip was right: without those, we do segfault
>    on conflicts.
> • Use the ui merge options to keep the same diff algorithm.
> • Use merge_finalize instead of clear_merge_options, and reuse the
>    options between merge calls if they are already initialized.
> • Add a new 2/4 to simplify merge options initialization.
> • Add a new 3/4 with a test case for conflicted index merges.
> 
> v1: <cover.1789853192.git.ben.knoble@gmail.com>
> v2: <cover.1790168285.git.ben.knoble@gmail.com>
> v3: <cover.1790425008.git.ben.knoble@gmail.com>
> v4: <cover.1790684309.git.ben.knoble@gmail.com>
> 
> [1/4] builtin/stash: remove unused header
> [2/4] stash: prepare merge options earlier
> [3/4] t3903: test failed "stash apply --index"
> [4/4] builtin/stash: merge index in-core
> 
>   builtin/stash.c  | 94 +++++++++++++-----------------------------------
>   t/t3903-stash.sh | 42 ++++++++++++++++++++++
>   t/t7600-merge.sh |  9 +++++
>   3 files changed, 76 insertions(+), 69 deletions(-)
> 
> Diff-intervalle contre v4 :
> 1:  6a165c4df4 = 1:  d8f4c36459 builtin/stash: remove unused header
> 2:  35b64ae321 = 2:  8e99033ef0 stash: prepare merge options earlier
> 3:  7b0b317ce0 = 3:  ee28d0a840 t3903: test failed "stash apply --index"
> 4:  2ac371d2dc < -:  ---------- t5520: don't expire reflogs where it matters
> 5:  e21b832a6e ! 4:  ca3de1d4a3 builtin/stash: merge index in-core
>      @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
>       +			merge_incore_nonrecursive(&o, merge_base, head, merge,
>       +						  &result);
>       +
>      -+			if (!result.clean) {
>      ++			if (result.clean < 0) {
>      ++				merge_finalize(&o, &result);
>      ++				return error(_("index merge failed"));
>      ++			} else if (!result.clean) {
>       +				merge_finalize(&o, &result);
>        				return error(_("conflicts in index. "
>        					       "Try without --index."));
> 
> base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
> prerequisite-patch-id: 601853fa5478b0dbfb260ba02632418e90338219

