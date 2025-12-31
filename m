Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DB22538F
	for <git@vger.kernel.org>; Wed, 31 Dec 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767208218; cv=none; b=LZ2Elw/k6tt9XE8RjEly/7UtbadQkFdhKdMJMMk9NaJ7lCKvo5Cret00Vjh67qKf68e8vWItthH0/C66hEiQCJtkfjeUt8VrtCGr3COdsia1OJb0vmgOJahuc4TQ8U9xg8Cvk21lt5pVcQu5MMz1vE0z5pJ9Yib/NVfs4mqI+N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767208218; c=relaxed/simple;
	bh=NLioj61s26GXMuWZXgdPTC0Kp3uR8PXsn4qq/BD9DVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnYO01yvi81xel1N5xjXGcVr2HYrraII7zZrafZuFB9G2BO1xyvAebScNyB44FbnckSFvUR0QWGivefgWJPQA5j1oxJ7AINcH0loctOXzF9k7mCYr/mPZzqkzUbA4T4WJLhFOGVqgdBTegqw8xOTFbQePqP2jsNUGPSIkK7qZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org; spf=pass smtp.mailfrom=dinwoodie.org; dkim=pass (2048-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b=Ag3srFbF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b="Ag3srFbF"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso1453547166b.3
        for <git@vger.kernel.org>; Wed, 31 Dec 2025 11:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google; t=1767208213; x=1767813013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=461bAdqibp+q0ZOB9aRpeGoJP4qPj/z7Az67Qzx9lz8=;
        b=Ag3srFbFgTnl+zUW5lROLJdCC60knPbBMutexIkRyf6C32LEuetsHx/wt+4ic5ad/e
         1TXDDArATfBRsBnBa6DDkfrSceRhMHfDlxTXXYdHJaZCNPVWns2VF1p8d91aB6dum2MC
         EypCUtISv+AGsGDj/7iBAlxlM4kp6l1gUFQqrwIFag5b9cZ3NdzRPaN9Cou5nqIc30OO
         r05oFx+E9KG1w6dZdQ8bh++vlylRG/qYLf39zlFFzMi2hNWIKJzYxnPwNJ2ZFU7oju7a
         0kAKJnefYTGztEu+GnaFutbsX0gH0m9uqXFZmSMH6h7n2y8M+kGOe3YJAGifX5Fuv4ve
         YafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767208213; x=1767813013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=461bAdqibp+q0ZOB9aRpeGoJP4qPj/z7Az67Qzx9lz8=;
        b=Bp/WzMOxo2Wqc3uVQjuc7V6vObAe7+Cc3+LbcxcffMHLuuI3ecCNgCLP9zumdAFxzY
         9k2yCqQw2M1xDnCQuMph3fA8ZfHGt80VwW0OXNudZdXhepx+RL9+r3oV8vFkSpdektyX
         dF1MdLdyLxqfc/ZbOE41g8x4Tc42+MfrPUYBphnjU1BoAS4t6HrMp+56tFGRJJhQaYD6
         4CbUtxjglvgWD3BIhAPXBJKtaYfsc5pqYsNb/fqPd34e8VjSroqWMBbTueMquPnOi1Q7
         PrlDLl2R1FFWSKRdWeAmdeNiqzsJPUScsRL9q0PpdfqruGv10dCJCjWz0VUl6dG35u7Z
         PquA==
X-Gm-Message-State: AOJu0YzPyKkRj5ihh8XqP1R82pyP2vPXf8ik7M0TXIlCo+J/VZl03LPM
	UQXedYjq3H+VWWYT9AxRBCOzm14G5EWMgEGg2RmMMCU29R6/RpwBSeVRijPpXZrT+NeIXcNLpRU
	hWp3CZSj4VhzAwLz0M87+ya3RLMNr8XEMGp279C904t6W/HeIai0JRt8/
X-Gm-Gg: AY/fxX7W6GcwmMIe0rCag184K3McYybaJS4oBVTH3HtYXl9qSNYzESEa8CiDgYy2Jt8
	dPVD7Uq5FmoDmU5yaf2oHdGcKNcEfzZQbkmNArVytU0P5giVd9S1LGMum3fZtSrq0Y6/igUTVul
	R+o2tBqK6pme45Wus9PotSHNP5YFbwBf/31zA1DOuWCzAHbsb8sb51ZZy0wC+JiKRap3spvLbid
	HdzPncFDmsrevCrr3i7yRTewTZr0fWp4Ob2UNl7vZB8bTCc8obGiSqEu7gGzf1T/ubq+uZaVqhJ
	z4EseSzxTb6QDVRXLveacz7sTwaSJAk5RRSrg9dB/FNwZuqiO2M3cmeAecHr
X-Google-Smtp-Source: AGHT+IE2qzjUTCIUL+dXk+8v8k04uw6Xc39fIKJGDjmoYQ6FJ3QwCQcRr/8nTBFDTsdiurW6Qlwzf9Kcbm5LKf137I8=
X-Received: by 2002:a17:906:209a:b0:b80:40ea:1de9 with SMTP id
 a640c23a62f3a-b8040ea1e7emr2510912566b.48.1767208212274; Wed, 31 Dec 2025
 11:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201031040.1120091-1-brianmlyles@gmail.com>
In-Reply-To: <20251201031040.1120091-1-brianmlyles@gmail.com>
From: Adam Dinwoodie <adam@dinwoodie.org>
Date: Wed, 31 Dec 2025 19:09:36 +0000
X-Gm-Features: AQt7F2oAejTmsngIogsYV2ASllCYWT1n9yQG6i_rQCkfftMjEwTGAt7uWwWNb_U
Message-ID: <CA+kUOanGT2eOHexpXk3jEKY6CZjutN_099Sihy2V=R0M9593pg@mail.gmail.com>
Subject: Re: [PATCH] t/t1517: indicate that `gui--askyesno` fails with GIT_TEST_INSTALLED
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>, hvoigt@hvoigt.net
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Dec 2025 at 03:10, Brian Lyles <brianmlyles@gmail.com> wrote:
>
> Commit e749c87e75 (git-gui: provide question helper for retry fallback
> on Windows, 2025-08-28) causes `git-gui--askyesno` to be installed when
> running `make install`. This triggers a new occurrence of the issue
> noted in commit c4cf8caadd (t/t1517: mark tests that fail with
> GIT_TEST_INSTALLED, 2025-08-19), which prevents Git v2.52.0 from
> building in nixpkgs [1]. Indicate that this is an expected failure.
>
> [1]: https://github.com/NixOS/nixpkgs/issues/465178#issuecomment-3580790826
>
> Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
> ---
>
> Note that while this does allow nixpkgs to build v2.52.0, I suspect that
> this sort of issue is likely to crop up again in the future. I wonder if
> it may be beneficial to make some more fundamental change to this test
> to avoid future occurrences. If that is preferred (and something that
> someone has time to tackle in the near future), I am happy to allow this
> patch to be obviated by such a change.
>
>  t/t1517-outside-repo.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Notwithstanding the discussion at
https://lore.kernel.org/git/xmqqect7fhnp.fsf@gitster.g/ et seq, it'd
be good to get this fix in a release. Ideally we'd have a better
long-term fix, but I don't think that should prevent fixing the
problems we have right now.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
