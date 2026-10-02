Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5551FC110
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790904494; cv=none; b=hmPUMLU1y1IGgz/Q20dGV0GKQzkollmn73q7fJXn/OVR8j1kIuR8IaFNJY78NPj0PlYk/tXOfS4+SUNwr3ZYOQsBRZTNWmg9Pnc/MsCLYN6HtfrTtFJsZ5+zpqfZ/imD3cHLw/L15v97Y6Ru7sAt03uhFeQDcneFDzhebUw5ICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790904494; c=relaxed/simple;
	bh=pz+9ISoRHs8Dlz2iuc1dRUTb9kQPNqs4kSxVqMCoN1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qx5GD2u+XN3cq0xijNgWuvYz/h/DpBUdh9RzZFRElP6P6Q9p9SJaasHnHwtDrAtFtiCXx+4soBreVCViazhqAiF9Ho3xBU7BSIPoKVYY9xzoLjQLZxDmYogHGy8kH5Hw+XJrU2sRX1TXOuWeoN/OQgu/OKcceeeyTXF+WqMEm0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ihy/rShw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mwyNaMYp; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ihy/rShw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mwyNaMYp"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BCAD07A012F
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 21:28:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 01 Oct 2026 21:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790904491; x=1790990891; bh=BoxJ2XUpVJ
	3ClW+vCmdE18vSSsQuQwWUWbhUFgmQ/g4=; b=Ihy/rShwFnNu/fnWXJ9VMay4yi
	Aly6qE2s/fMh6o+xiqiJ3u2k4lr1UGNhuT07gszRwpAgp6SbHUanAt1WbTYXN6ue
	mV5SIefMAL1JCNSnv8mPXq7XPEd9VbbetiawTZDvkv3ED+Tc2Il4/YNf2SWd6fOA
	Sajsxy4U8Z2Vu9bLov9mrQboC4NJGGtCOelr25YNKR/eoJHBa7ahSH3ZieDVwQ5E
	lRPNM3UfGJ3w/M23mFrKL2K30bgJAMoStJuZAfpOsIx2TvyeUGz3gP+kEwEOrXfx
	48zRt6Ly+fuPrCZD9IRwC54sFAUSZMLv5bfYCUKmYPE2U5T8LWWLMsg/rOAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790904491; x=1790990891; bh=BoxJ2XUpVJ3ClW+vCmdE18vSSsQuQwWUWbh
	UFgmQ/g4=; b=mwyNaMYpMXog9EoQIV3jLHdo+pHSD0UXKCBXTqzB/kPcbjW/7vi
	b+A4rZacjDSJniD2R2Uk1Um/T+j+OaDgAjUpYgRqm6wKJv4eVacbF7JIz4+/adQX
	x+md+KgwjCppE+J2wJA0UEpZ1vUBCo0iN9jvG9o4EqUhO8BOEzpaykg/Dw6FcVbz
	T3Lswly73IW/4hMzhjTyySPHQrZaydWiNUoo89eI+XxnssqLxhpNZXJ3NHFQ2v58
	1uae2p5iERerOLQe43zfVb2/bCBfOJnp0oB6ZZXztFf/3vXiFkFEuh3yckvRQTgC
	oCEOk0bgx9yY7GdKFmcQsvp4XYun5mjHGMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790904491; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:f1cXR/Q0uaj4/ihIIFhJf3eSiT4a8+1WaLKrsVzqS8kAFl3
	/lwkWTzwJyqCieLVp5Wd50WSIgI50+C3E/K5qoJ2QvY5nLBzlOKNm9sqN78eK8/R
	KH8T24TGbT0pVEFy8VDnYx/zDo//BR0hg7frixo1IwZBJTRX7myzZLN+9JJ6f2z6
	GOg2s8JXf0n5LpNq9cLwYNsuJMFKdaXo1x7QHTJ+V6Kwd8PRMGcxk+3sxuegnIzM
	F8rQ8V7ZCQmwhqs7jdmxIm/xiJTmmWeysJYnkm2bvt8InksY+3LYtHgdhbxWFFcM
	4dIuo5ooCEaG/qZbXgy36IDiFIipr8ZGVu/Vh9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:+klFeVIPPmmsRqNNWVBZGyhaZANvJYxV4Y+KDKHXX4U=:pz+9ISoRHs8Dlz2iuc1dRUTb9kQPNqs4kSxVqMCoN1o=;
X-ME-Sender: <xms:qwi_avqt-VjX4sbyC40H9rqLcI8OC3OXEY-yU5ylstfJdd8dH_ZAwQ>
    <xme:qwi_ahGn5xQ3k5hL5YPqbH97X4ly0dd5SDzCzNULnyHsoYLXvKFg7yYwVAYM8QDwx
    lohmKtBuyW40oo8pEaSXGEGOnLFzoa120lxBdX3GGEeBbMwmudYeyU>
X-ME-Received: <xmr:qwi_aplw5fy6gSYqpo3LdOos3NER5efxYZ09lpCNpP--xa-9OniY9M7YDV_YBq7R8144wDXHbWCFIaHkIP6ZxqFzJrGl8DIbOpgm>
X-ME-Proxy-Cause: dmFkZTF4TM+4Xm+eK8H6KuYpsnSfEC7idwfgqSTot3aLyuQbWui4v1Mo8tf1IADzoGWdKz
    tO0aKyGwk+fzDa1qOPj/TsTAcguQ6NTcO7NTF3pZJbEzolBzmDJABz/MNVY2s6jO0HP6AL
    OdrQ/zNyfYL32ynpk1OKgtBUqDQI6dKnOZ4QKfLDSck67KhhWibmZPdBQKeqLInuQHGqxR
    ViTN1mMF1eSNjT8/NysHPr6jteTTMs8Ak6nk6iIjf/LZhsFYf8NCAQdVBAoc6iaPNAV0ru
    EHdTOPvR9PXkcGlX6pB7mSYJFqyybNyrvMhDXACcH2AOvDE8VjXT3lSXiF8ugrFMXehHZr
    nuua2IUpVb5dPVFeXr6lTsFdkb/5UGDm4KlSV+jpYqK4drT92xiL6zBehmnhOd8eWFPnJ6
    mO8EsWklCKdZnbsd91vnzYu8lAzWo2xyUs29S1BgLL47Gn9oMqYjzOpUS7ZV5TKuOhNVPK
    0mrsy75kd9bIpefb6hB6f1hARiVvmnzKI2RPEv+ULwJ/UgKgskLsRyj3TjILfTtBtjsIii
    ofqcMEm4S3tBgcORw0IcqyhykazlsVw6sMMZvF+1Pd5jO4opewSkRe7cDEE356/lUwZm3u
    OGs2TG4q8a4Y7DrqDKuF60P6ji8a3c8HqcORjSO6a+1JAK3m5dDv4bggdnRQ
X-ME-Proxy: <xmx:qwi_asnqsDRLQxxG2uJYkx0heZ-dtYSYpzKBdh7hhO0e_tOwQtmuPA>
    <xmx:qwi_aisJ8osRF-JXym5YusyPBKR5ArtldGaB_JNn3bYtUM_gWbueZQ>
    <xmx:qwi_ankKgNIM_qUQ7ON7tJDRvyywk4_LrnWLhgcsHgbTw10RJ7svzg>
    <xmx:qwi_als1TK3ofaHhhK9f99YhhR6XFhNk0EUfjlooZP9GpVSdnUHo1A>
    <xmx:qwi_aptkOccZBXJnMHismkG8bkIlwFkuo2ecgIpt7d8oJlrtxTruKCYY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 21:28:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] Preserve per-file historical mtimes from Git history
In-Reply-To: <011ad911-2d62-4179-b3a7-e14aab79f18a@gmx.com> (Artem
	S. Tashkinov's message of "Thu, 1 Oct 2026 09:43:25 +0000")
References: <011ad911-2d62-4179-b3a7-e14aab79f18a@gmx.com>
Date: Thu, 01 Oct 2026 18:28:09 -0700
Message-ID: <xmqqqzi83n86.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Artem S. Tashkinov" <aros@gmx.com> writes:

Omitting parts and details that are not interesting (to me) from the
list.

>    3. How should rename following behave across complicated/non-linear
>       history?

You'd also want to think about what should happen when somebody
concatenates two files to create one.  No new contents are
introduced to the tree.

As to the definition of the historical times, I would find it a lot
more natural if they behaved as if you did this:

 * Prepare "git rev-list --first-parent --reverse HEAD" to prepare
   a list of commits that historically appeared at the tip of the
   trunk.

 * Make a checkout of the first commit in the list; give all the
   working tree files the committer timestamp of that commit.

 * Repeatedly run "git checkout" of the next commit, which should
   replace the paths that differ from the previous commit.  Give
   these paths the committer timestamp of the current commit.
   Repeat this process until you run out of the list.

and then looked at timestamp of each surviving paths in the working
tree.

>    5. Would it make sense for `git archive` to optionally use these
>       historical per-file timestamps for archive members?

Yes, it would be interesting to teach "git archive" to produce a
tarball with these synthesized timestamps.
