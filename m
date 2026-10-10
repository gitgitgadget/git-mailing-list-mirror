Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF632142B
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791652595; cv=none; b=Oi17WKJGIbUZIf3qi9dqbe1r+O2xMFvjXFwD6SXrxS+Ho/pMAjfA2wCcsLBbuKmurZjpCHxfiRnx64yVBMsDXWC+V+9rSd1ew3Q1uTo3d2gyQS6EpV+mX3ikXwhemL1PXp69KlJD0LJcdbv4aD76ncFa1Kq2q6UNe4bsq4Wrqnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791652595; c=relaxed/simple;
	bh=qfyOPLsc3CiNUYeKWKB7ERp34rOiBGtIyJ/kei+QuIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QJyC2lQrtCs8YGB2KBYFwQRhsG3GK90NPNODkiCnhot0LVxb/Znx41P7qlFWWJIijkNCjdu2U7sxfT4MporC8ohheibfmcR3RdXXY/7XvBBmiGKZH6L9ywQX7XnYthvppb1EnEZ0yRhrScxvnLHHW2PAt6wkJPypFaKctYPpniI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eCtMCse+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p1/7HYK0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eCtMCse+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p1/7HYK0"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C7AB414000D7
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 13:16:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sat, 10 Oct 2026 13:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791652592; x=1791738992; bh=naFBW8apsM
	6z4qbxWi1b8xgcZs5raclwEhA/VowMf40=; b=eCtMCse+2LV3SogJrygmWmyxc/
	r/BqAud6SVh2r/VWXgR52vfS40d2W+Ag2/fIGlkosDvLZUA6/D0jXvQH6biuZ2j6
	GFbSUYmHSgUAr5Q+S0z21QQ7VeOuoAqRJfegtNg5spG2kNAAGYYuT4zD04Oy8Cpk
	RBzgXa8RB/NRbDS7qlPTjqdfChfQm7HydZqaNvR3RYmLIoN34tnngwLiP/YOXw+n
	Um7LP1X7CSlyutnDwlwKxEf3yhJRwzxwMgeSE8y2ideAlFAbnTdKwRCjZjNRsGAX
	E8dnGeaZ4ofK9hEoCSpzGChOPvq0bBLHujR3l5AG4G7p0BQKXehJdbq1LMQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791652592; x=1791738992; bh=naFBW8apsM6z4qbxWi1b8xgcZs5raclwEhA
	/VowMf40=; b=p1/7HYK0LMBwCOX6eQ/YKJ5VUWeChOoBp/D3r4KMkWpMzkVFx7i
	I7B+pfSnK7avL+nAiYXUA/mKfIP3mEujBnial1y29bngelzAfXhOMpEZaHnVeMtS
	MyoxA45CWLglkmgefynGJ+gwdxXAlNktGMV3kqs+1pz7hVB6cdhvpgj61GgksdHn
	/uLh4ybIeby0UabHsnIMwPrreMZ7AeBTKfz+YGXTO3N7Wao3ix99BVgVO8MVXBjK
	bLOGVhHLVsg4QrngRf05GHdeIb71Bm8a9P44+BNLSSMEgJkcgHoWsGee4v7ofhFR
	RimkEn2h88etAVdw26Ne0JJl3qWvoAPBSOA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791652592; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LJu6QCIyMvtu1AQL8ZLtTbK0hzmEviBJlpvGOCmOyXwG4qd
	Xki7XHEsfeOpsRcylNrbbpFPjI+hYPCs2lIFbEHHshhtpZ9uciZNXDwWWE21uuss
	LsYWZNHrDLMGotY/lptirZywfOSPZlKIF0uO4zsG5CwEmDXNT7k1i+El92e8Lhbb
	Cv8WabMZSqO4sXfPLy7p61kYDRxRNHzBXG6uB0TISP/KMg0K4mJ0MBkwMlXRefvK
	Fo52RMzvpBI09YXLiJ5HquNbQq0mt0GE4tXZACcax9hLAbhBKlVtisSaHYBD+/ql
	agYFVvhwRXmvCqY7DNjU2sRwAedzu6YW4Pu1jqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:5l2/7U/8wAn4n4qoFi/MrjFenUXcf3k/HHH/q5Oj7Jo=:qfyOPLsc3CiNUYeKWKB7ERp34rOiBGtIyJ/kei+QuIE=;
X-ME-Sender: <xms:8HLKarRYNfFa2XN0y7GxCNwcK_tw3HRD0D2T87eQ2bWj33fnVHSmOw>
    <xme:8HLKage-yXYZw7_y_AzvXdSRgu6TUCFPfXFzjAa7vzc0LVep49lqoRQApNLgeBMQD
    Cs3qkY7p7zNbRxhRfEaHsHxy6UK8GE0CtdeCkKVq5d6r0xVAGecBVI>
X-ME-Received: <xmr:8HLKaqqN1130ffo5U46wg_7jJo5_Uf9xLrAqVCH3-c8VXD2aVXZ7QyZwF-OwCERhL4x73_nK0A9YotwYjF57uFqsoza4Sk8jyjH->
X-ME-Proxy-Cause: dmFkZTFtVvbYToXjoW55hvEP+qMlqeCmBX3jzP6akFPI+J09p5BPrmv3I5YwtBE5c9tSyB
    I2HhIg/WNrjOYUXh+kI1baBHval9bb6l65BkuQPSV23JU+MVwETCI03ADsqaqNMfhsjr2q
    AsJz+HfkdXVPpDGarj8W39QVSi4ZuePmzpYJGuTAlWxs6j5YHPNT7/R2PWUgZvfZMAEAFU
    9lf+j94V3w2v2ug4kbeXctvpJbQPQ5GfVSVpHCzWSbiba/gYEjPDVmFBpihYXXws8xEtMo
    QRKI0FLKrsVDxRH1HIqYGeznM6MzrW51La4uO1dI687tAvsI/fz3gD8KLHRINYLDaNbnUm
    W2uAlYflbnGDxfqXWz43BG6m4w6hD6equeXLNiA39NTnDg9hhVBF/+hYEd15nq4+lic/R3
    lNdrh1AmGhSe+cDRG9VmT5dD0I6x+6DUvqjlSpur1s48v9QA6M8BQxqLqngxc6rIe56Ibd
    JVAwx7FkI96HWVBgZI/dRtxORs2jp7sl0oSY3BP8qKkf5bPz1Vry0ivypRZ4xAi1n4mil+
    7EGXSFpA/Prksdm0CBzdj5fERvb3wybvOGVVMkedhz01WD8lK2Lvb0XGRnmLH7/meQWWYO
    jcaVc/6mJMu2wcD8xIhhLJt9D0ewMzA9VC7i7GKxrS7L/M6XFq//n5nbQ67w
X-ME-Proxy: <xmx:8HLKah99s4bokukDqy2KcI3KIGV5Q0HbcAZwjTVH2uUo4GbPCQrcKA>
    <xmx:8HLKamfv3z1QtektI2TavGxT67lBSuu3mbpg2xdlzNry-gN4vKrVUg>
    <xmx:8HLKarKXkx3WBQgO4emy4ZpwmZSorvDfPIzzStbqje7F9sRQriU36A>
    <xmx:8HLKamj5QXSkYlnp1dcXIA5_wEYjbQGFoziOw60MCdpnvjv7QLg7Dw>
    <xmx:8HLKak06YRLo9LAxmXN_pw_QbauohT6ckQI7LX2D6DHPMqfzx9Kb98Gx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Oct 2026 13:16:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v8 4/5] remote: add "git remote add --limited-fetch"
In-Reply-To: <2b974bbe0a1ff1f70944a2db9d996c0c283bd3fa.1791619334.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sat, 10 Oct 2026
	08:02:13 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v8.git.git.1791619334.gitgitgadget@gmail.com>
	<2b974bbe0a1ff1f70944a2db9d996c0c283bd3fa.1791619334.git.gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 10:16:31 -0700
Message-ID: <xmqqecdxiihc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> A remote added the ordinary way tracks every branch it has, via a
> wildcard remote.<name>.fetch refspec. That is wasteful for a remote
> whose history is only worth following for the branches actually in
> use locally, and it can make "git fetch" negotiate history for
> branches nobody asked for.
>
> Give "git remote add" a --limited-fetch option that sets up
> remote.<name>.refmap instead of remote.<name>.fetch, so that
> "git fetch <name>" only fetches the branches already tracked, as
> described in the previous commit. It is rejected together with
> -t/--track or --mirror, since those already say explicitly what to
> fetch.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  Documentation/git-remote.adoc |  8 +++++++-
>  builtin/remote.c              | 28 ++++++++++++++++++++++------
>  t/t5505-remote.sh             | 16 ++++++++++++++++
>  3 files changed, 45 insertions(+), 7 deletions(-)

This step looks quite straight-forward and nicely done.  I didn't
look at the tests, though.
