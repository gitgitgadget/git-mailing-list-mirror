Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC5212D97
	for <git@vger.kernel.org>; Wed,  7 May 2025 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601609; cv=none; b=TwtfD85+qGI4JhXbZCrLMnf+h9rwsvAxStVhdOuDk/+Fcu4onHgwFn9q7e9WVHr4a5icVSDpq7ahhYJCc750WLdD4Hs9HSRWrL+GRULkCTWnHmhDyZc9birjfPzguUZU77+BhD5MSaadNl0Uzbd05Ji4jPqVgngrzz5v0WH+5jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601609; c=relaxed/simple;
	bh=IK1TgXArwFViju/z/tfXmoJfomb4zvVFtJWb02kSHTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAYPzRzUyj1+GrOLcjnzpb0lrH0yydCXlfKV9qfrHH06HbVPl2tVoduIu9y50m4leE+ysxUXo8Y/sohKNkEF9Gc8XjIR2FcRgNQOza2iI5SIr0YjAbpo+NYrKPk6EIyRNPsnrKv5HWLa5c//31sP3yWDAn02TT15BMWMy6kA14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=3UqZuuQ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cWFotBdz; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="3UqZuuQ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cWFotBdz"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B9AC25400F3;
	Wed,  7 May 2025 03:06:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 07 May 2025 03:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746601606;
	 x=1746688006; bh=/AhDpLv+cBQyijCs26xmwhkZkPqe7GwO/BQubkg0VEI=; b=
	3UqZuuQ8/p+jZXhQMkIcoiFlISv4jWXGGmIzoHoHHrI11f/HLSOl+Nk/pZN4hKgd
	JI0thaZQkLgpulyesfw3VqNRojAWrsgy7GpPHS76olQh24sWD0iILJWqttjr7DtR
	Ve/tcSX6paNX4X6scgMlsanOQ8BchPMM5WdF7eKjv2RwrUOprwUEVWRHZSkn2UMj
	iUSvJw216Db2owLoe4aKAILB46EQ8MTaeArOAExbmYAI9Qop6gFc1Lq/Et728HDK
	Y8IXpIRAoDwFd9EaTN9FIbEmvNuZ+6gpUgpdQ1AQY2R0Ud2L28uNBSYq9o3wwx5u
	VTRhxVeQ1nB38ObPJywJSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746601606; x=
	1746688006; bh=/AhDpLv+cBQyijCs26xmwhkZkPqe7GwO/BQubkg0VEI=; b=c
	WFotBdz3V0fIjn3ZUSJ4mkUHwT0TKxWKijbkd8dOnJnbZ50NmDu41yYw0TGJbClc
	uozDl8NwwJP+xjiwwMQsknw1XyMBDVLXaWm8aOkEFBGXmkNkP3zpGfYwgUkNs000
	iIW4/vID5eb4yObwna+GPi+bfQy9HT4n3CwKzIH8t+Qxw4cqm3yBUWRy40N7Od57
	E0ldfb6V1U+2SOK5TKbvfmqPgBPj9ZKJSVdVlEXg4bf3IZ4woW9XYXycfoCMu8EN
	FCObXRhEzlG9dTzIFpg+VNaa6V0SZp63uJVXJYpkz6aAiefzh+sXqtpAJgKoVFij
	ZoJxlmfppPDj/rz4ThmWg==
X-ME-Sender: <xms:hgYbaPkIPL2yFjNA8U-mOTumik0YvP7c9ouJvXVPozeHyzGZqDfI0w>
    <xme:hgYbaC2kIf4_Ys8gUmBdcGm6ZjjSqcbH7SkTGYbCgCsAbcdj-p1qEm_HaD8lXNmJW
    Ntd3qkbCEFN2kJqzQ>
X-ME-Received: <xmr:hgYbaFqtr8T8ij7iIRV5KOMLOVbGnbdcAUIf_6HTANNdqXOqiRZBffsROXO2DDpAk9WJuFcFP_vhcCPNlzDVE7MCVYrYTmx6Dl02NfbTp4yIww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeivdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpefgteelhedvkeelvdeukefgtdffhefhheehvedt
    vedugefhvedtveelheejfeeuveenucffohhmrghinhepfihorhhkthhrvggvqdhprhhunh
    gvrdgruhhtohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehsthholh
    gvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:hgYbaHkXZ7QOWnD3eE3mCmVoXmoaYvmeZ2yHzQNGPMKbMn93ywa15Q>
    <xmx:hgYbaN14yzwf9QRdLMvSpjwtR_MjbHUcH13JXeaHs_-ReWt02VgluA>
    <xmx:hgYbaGug20O9u4nLxB3vVV9fTpwlN98ClxTxOHzrzhm0D_Laqvz7-g>
    <xmx:hgYbaBUB5VVm_1p5PPwt5pvamNTKgS3oMFl83xxPCLQMYgWNg8zQyw>
    <xmx:hgYbaIabGAlXEnKyVuzaDL_PMWmNB-Gbtxr57Bch-lBdLeUVoRIDV1g8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 03:06:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5830997a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 07:06:41 +0000 (UTC)
Date: Wed, 7 May 2025 09:06:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/7] builtin/maintenance: introduce "worktree-prune"
 task
Message-ID: <aBsGg7w_4uKyQSaQ@pks.im>
References: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
 <20250502-pks-maintenance-missing-tasks-v3-5-13e130d36640@pks.im>
 <CAPig+cScor=E2i4w99NCrsaUd-Po=FqhkrLSyT69PSo1+h2dRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cScor=E2i4w99NCrsaUd-Po=FqhkrLSyT69PSo1+h2dRw@mail.gmail.com>

On Mon, May 05, 2025 at 04:59:14AM -0400, Eric Sunshine wrote:
> On Fri, May 2, 2025 at 4:44 AM Patrick Steinhardt <ps@pks.im> wrote:
> > +                       limit--;
> > +
> > +                       if (!limit) {
> > +                               should_prune = 1;
> > +                               goto out;
> > +                       }
> > +               }
> > +               free(wtpath);
> 
> This leaks `wtpath` when it takes the `goto out` arm.

Good catch, fixed now.

> > +       }
> > +
> > +out:
> > +       strvec_clear(&worktrees);
> > +       strbuf_release(&reason);
> > +       return should_prune;
> > +}
> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > @@ -493,6 +493,77 @@ test_expect_success 'reflog-expire task --auto only packs when exceeding limits'
> > +test_expect_success 'worktree-prune task with --auto honors maintenance.worktree-prune.auto' '
> > +       # A negative value should always prune.
> > +       test_expect_worktree_prune git -c maintenance.worktree-prune.auto=-1 maintenance run --auto --task=worktree-prune &&
> > +
> > +       mkdir .git/worktrees &&
> > +       : >.git/worktrees/first &&
> > +       : >.git/worktrees/second &&
> > +       : >.git/worktrees/third &&
> > +
> > +       # Zero should never prune.
> > +       test_expect_worktree_prune ! git -c maintenance.worktree-prune.auto=0 maintenance run --auto --task=worktree-prune &&
> > +       # A positive value should require at least this man prunable worktrees.
> 
> s/man/many/

Fixed, as well.

Patrick
