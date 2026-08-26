Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73D2FC00D
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787774059; cv=none; b=jlMZfJ0VQEPPIq3JhinRSvPeCxx5D6CKJw8MOhPbnOdxSlzTHHoZTM/8FPD1icnZ9ooEex9xXMsYqegHimvxj3ER4jJVeaBmHi41fkgyLhTqDCH2wUThdogcQyKjKdVe8hUz1D7f/gf+yslwFXNc011GGK63cedGx4j/reWkVl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787774059; c=relaxed/simple;
	bh=RZeUSOsLmbd3xS3hq7xDdh7Xad18PUc4oYtgd4J8ZLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hHho5xIyONObww831H1bVFdta6nS6yZxDMeCjCoMLkdNGglztitC0A3yRc98QbxgHAodow2LSBDfQqWYYur7RGmj3Kg1CC4sPl1sQoRHfibHDGIF4JgG2vUQ7TkWpxENSqb6QCkLcMsHzokAsEuMlVYkf7MYvQLlrrZj8alPUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XuiF5UqO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hRJfIXIs; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XuiF5UqO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hRJfIXIs"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D5367A0075;
	Wed, 26 Aug 2026 15:54:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 26 Aug 2026 15:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787774051; x=1787860451; bh=fEHmhlc65W
	dPIcrs4gUV70KR3BS0COqnEgzFg5jrS/U=; b=XuiF5UqOUBqgEdFQu+lJgK/RNY
	XoZtnxz0a2h8ozxPErr5962sm4FWobiTGJ28q+NncH27BUcAVRua5R06Dt9KvJFt
	Bphmdl6woZHbqzZ/IxdUht16xbGqXn70gI8I8Hrb3cE4IRDAFCr10xeNbNMnsERH
	1AhbvyjtkBhHFjH+qx3a9pTln+/bbwvagMzMXglNbL2omqLFcZuyXH2JU6ZWAWO9
	xh5SpYn2espjWYnuAxBLprxATECi8pTc3ws3m6NtpeZeTykBWvxGCsqq6Uie5bPD
	uCQArtdp0Gb68EvgMYlOl+Y0rmoRk2fYDQKJZcHfiIiUy0b3JmNO/IkBd7sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787774051; x=1787860451; bh=fEHmhlc65WdPIcrs4gUV70KR3BS0COqnEgz
	Fg5jrS/U=; b=hRJfIXIsFXUqWEl8PY2IWd0CrQOHHcu7tN5UpUje3QCbEorf6C2
	JYqolGweXT9JH5rO72UIaZHcuZAUAzK6EFY2shIBE1WW48Rd1t7AF6wn42f1GHPQ
	7tWLAKdnGtbzGodSucpmO57JuxZMThZEcWf64/krjnUtTbUcgzR+ahyblUaYfAWv
	lnToZfoED3g3DCJBDtYBmg3DTelty3LCYbgO+lNYm9eUsAS27KA1Sou8w9N/hSRD
	06nilf1UctE0X/pvCrMDgF+FF5MYGo1AGI3+ypFrcfrKO/Z60FFqRTbnYIpA4EsA
	OmUQd5tT/NQkbd3OA287d1s6HADvLZ4sl1w==
X-ME-Sender: <xms:Y0SPah9Da9E79QoQ851jccaMYHccRMVwT5pCZpceSpEInWt9SBSbIw>
    <xme:Y0SPassuvK6UOy_ekg4Yg5YrHOBlJx-OyJgdG-61ZS-Po4SZS6qKNFa3xy5VKV8ID
    IReP3htg9-akwQAy1samwnvfZSFoNSune7A23pdjWK-HYICuZDk>
X-ME-Received: <xmr:Y0SPakBcOBM2sF8iCW_DlrqDtmVfr6NGbukA9ktK_D3aSXvP6MN_JkWCfs2PJ-pK1tvFG4tLlpzCqrxhtEZTe88N2hNV_7NdzA>
X-ME-Proxy-Cause: dmFkZTGAzcCitU8wS3D2wim8LSKnCfEKQxQz3955pcPwOi9UTeypUmxroRWw7UKg/bCqvF
    xY3yE9eY3r8WayBQlkeOhKwHk3wgQVxJjYSCWKSP3RAsZMehS70l+YyztK6el9ElgRCF6T
    hqSrI8Vq4m8Wzi6FlDxSZnbclOP9frSw1Dp4D3vHg0lXz1wDejFuybp2dkjcxbH39alRPw
    9vUVXaUkGCEEM2HDzhrNk4kGo5XJZRB4Mb6RT1JrZFyW7PLXpxS5KbeIiOjCns14PMwGKa
    DUyjUONjRCAlc3aJ68hdxcq0nVMuHby/gDqBbkCCXgZbwuJSKUJStgR0bGta3ype3mJsdB
    CpK2KOAw/vPEgtqAaWHaCXil84Se57kf8wGe3lJ0w6deiewfxs5ApjxZrtejMBFYyijgNx
    D3PIrEC+QYARskANlduSE0nfHjMl93JEE27tWVO7nls/ieSzTEgfN1V8j95SnYGE+RMCyx
    u/5QQEaV909sFq4z0SJexnubKUmqmxuzl0JvdVtqe5qP8lEvnOyvgzsmGRHYXtBtDxuZRc
    5p1jMiMJfjr8MyuUcvTXR2LDU6ccmRq5Mc21i/dMs6zM04CFYLyxHNppUiKi1aSVCqAdX/
    Ho7LsIRHXtPCbOPotxvGW8j/Dx4VueUabW1qliEcP2STnwLhT0BjdMZPRWkQ
X-ME-Proxy: <xmx:Y0SPakXVADbJqTk1Bm1sgd4diN9So0uXoS_AyuZGUHmWFnruK2NIoQ>
    <xmx:Y0SPaiAC1NwLN7MFRF3V6jWvDy4dhDspXRwlShkeEnuUz4bpCB9oKw>
    <xmx:Y0SPan_1Q4Q-yXGu_GkcW2AHefd8ETCFc4lfkYkfNfNDJeMr8cW0yw>
    <xmx:Y0SPapG0flrdXt30or97sKZy8nHWIKbutkhCnr46BdyLQPqRUW_gvQ>
    <xmx:Y0SPanhSEQHN8zbb7Y1FfPizbFTFYXr3BStyafj0800w9lC3WFKH3aOP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 15:54:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] ci: cancel stale pull request workflow runs
In-Reply-To: <pull.2369.git.git.1785492641983.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Fri, 31 Jul 2026 10:10:41
	+0000")
References: <pull.2369.git.git.1785492641983.gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 12:54:10 -0700
Message-ID: <xmqqa4q8fyjh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

Nobody seems interested in reviewing this patch, and I am not
happy leaving too many topics in the "Needs review" state.  So
here is my attempt to think aloud, based primarily on what I read
in the proposed commit log message.  Consider any misunderstanding
on my part a sign that the proposed log message is lacking.

> -  group: ${{ github.sha }}
> +  group: ${{ github.workflow }}-${{ github.event.pull_request.number || github.sha }}
> +  cancel-in-progress: ${{ github.event_name == 'pull_request' }}

We used to assign each commit to its own group.  For a pull-request
event, the new configuration instead assigns it to the concurrency
group <workflow>-<pull-request-number> (e.g., "main-workflow-42"),
so if you are impatient and update an existing pull request before
the CI working on it finishes, the new request will be placed in the
same group.

For other events, <workflow>-<commit-object-name> is the group used
for the commit, which differs from the original behavior, but
arguably in a good way.  If three or more workflows sharing the same
concurrency group are triggered at the same time for the same
commit, because there will be at most one active run and one pending
run in the same group, we may see some workflows fail to run on the
commit.

  NOTE NOTE NOTE: The previous paragraph is based on my incomplete
  understanding of how GitHub Actions works, gathered from skimming
  the documentation.  It needs to be verified, and if correct, it
  should be added to the commit log message.  If it is not correct,
  a revised description discussing how this change does NOT affect
  non-PR events negatively should be included in the commit log
  message instead.

The original configuration did not specify 'cancel-in-progress' at
all, so these jobs did not cancel each other.  Now, for pull-request
events, an earlier run in the same group is canceled when another
one is triggered.  If you are impatient and update an existing pull
request before the CI working on it finishes, the new request will
cancel the currently running one and replace it.  

For non pull-request events, it is as if no 'cancel-in-progress'
were specified, as it defaults to false, so there is no regression
there.  We _might_ want to have two pushes back to back that causes
the CI work on the same commit to drop one of them, but that can be
left out as an independent issue.

Thanks.


