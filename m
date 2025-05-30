Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F41DA5F
	for <git@vger.kernel.org>; Fri, 30 May 2025 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748598480; cv=none; b=VeGWjynmXVWKraeWXvgzScffSUAoDH+fdyUgiWIno+x7fzbCCGJbXG8eflX1dK261ke353D1C3wk+cU8yHFKuUbpR7CLFLcWBce0XE3p/XQu8XJ0Bf9PNk9zzQQ2+UjkCynOXXCZz25GcUxdncHS0SkHFF3nvZYqgXiSjbQLgts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748598480; c=relaxed/simple;
	bh=JQL8L/EDqQzOAH/Qv4MjIVhjJwZPd8Ld0q9zh5hfOsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOOptyBvQ6sEzZ1VUUUjMkOW+gYxEQPtTCSV5JIyoNHm4EUnisT0dNa3JxXCnmtp/z4Gf+JEs9GisTg6060NEEmYOxxQcIv1wG/qBQVfhCfQBt7qpbpahRFlGKc+IKcrQGPABfNeeZeQnNyE368V+PR7+sS3Fo/nRpEILPuF0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GRojU4jy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GGv+OrXt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GRojU4jy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GGv+OrXt"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BE4341380315;
	Fri, 30 May 2025 05:47:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 30 May 2025 05:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748598476; x=1748684876; bh=XoK1fN9dL/
	TSV16lg6aKmcZyEDPXnglMagRg61qv66M=; b=GRojU4jyRtk/dT39DEMaB3THDW
	/mhebtnBsdRBtAbvr8WCNXKYx/9HNt8z0QQfCBBZUlOkeB2ai2YKj/rCUbkneQ3B
	j5rJ02dV7jbewcQAxaSLZhCAimq2WJyWef8l6HEhHyv801fw9/TCmbn98F4EI6ab
	qRdAkzwbVE8RCOZMawGePhSzNGxzIGqP6WpRMtUzL5TXUoXzMiQZ8TaYsu6TOU4P
	2fdbJoCoeLj8k/8VBXxFOG2n4N18e37GJuWsPgw1yd1mJd4KllHJnvhWBneAMknk
	rmAL4Kgo7qLr4sgTJnBRxroGS6LVD66kPjFbFccyyrJBCrsHUseAgZxrecsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748598476; x=1748684876; bh=XoK1fN9dL/TSV16lg6aKmcZyEDPXnglMagR
	g61qv66M=; b=GGv+OrXtz+t34Ndd/R2E3o43BEpU7Z/eYrDQFf1S3jWYOLuLCnZ
	FIvUW6rSWHZvFr9hJX5TwmrIDi+g8rdShySB9HEfUu1lbrVtsUXzKJQe9FFkH7kM
	W08hdFHrXro3m05mwgKXh9cJAbC8/XlpuSTUCC33fBB6iEXfibFpOzo893tfsNNl
	bTmO3MQ/0Zxrm/84DNNxKadGwsvzyaRKcyoGnpOXxDVKCCcLYabbK0WFwA0hPagM
	9sT/A3Hbpjujc2+eb92Va7fs833QPOhWDSXq91WFFj2RyC8TStvGS9+uF/ToZA6V
	J0xadqmO7U17ejCy5kl5pnYr9Ytd5+Fcmwg==
X-ME-Sender: <xms:zH45aN3J-I9WVoO3l_Csh4irorNf8oHNUFbX9P35fUH5qTV0tvn7ng>
    <xme:zH45aEGd_NfNrQM9ZBtEDg7kVby-CcLTsTwLUaoLRR_p13UJAmgpauLHXeQW2s4MF
    dhUkfIzGfHlaJak1g>
X-ME-Received: <xmr:zH45aN6yIzl_RkSvOm1w-b7sK2Vh6RRzEiDgb2qKTA4ku9DAS0PMb6GN6SyAmA6dShFxwaX4Msr_wPmFXI7uHn10YJmG2sZnZamqIPOLpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkeeikeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:zH45aK0IchTsQDnQPUr-elstz5VGpfops_EkWyKOLTg-9OJQlEW0LQ>
    <xmx:zH45aAHkGGpkYAFnw7IAA0Q4H-keN2sFxXVh9sTgMZ_kxddbqk_gMQ>
    <xmx:zH45aL-WRBkv6UzE2B_5Sx22BMuFWI-tlUOS5nzx8XPW169hltkD3g>
    <xmx:zH45aNlaVW7XzvC6MoAnjontXAoi9IKXuAYJCv1j9AdKZpX8dwHzXw>
    <xmx:zH45aO1RtpKtvBmHhgEymvEpVCgeQIsT-yspIu_I4Z3toG7WdmdIq7aG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 05:47:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5b6ddc34 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 09:47:54 +0000 (UTC)
Date: Fri, 30 May 2025 11:47:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (May 2025, #07; Fri, 23)
Message-ID: <aDl-yd2fh4qVRB_V@pks.im>
References: <xmqqtt5au523.fsf@gitster.g>
 <aDV0jwaQ2DlcM0lZ@pks.im>
 <xmqqtt56ov4k.fsf@gitster.g>
 <shpx4piigp5sqgpbzx4vdgu4zdn7z3ykxhu2cdyjh5vpr6zbqb@rf2sxg6hukpd>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shpx4piigp5sqgpbzx4vdgu4zdn7z3ykxhu2cdyjh5vpr6zbqb@rf2sxg6hukpd>

On Tue, May 27, 2025 at 02:45:43PM -0500, Justin Tobler wrote:
> On 25/05/27 09:50AM, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > > I think the only outstanding discussion is whether to name things
> > > `odb_alternate` or `odb_source` [1]. In case others agree that
> > > `odb_source` is a better name I'm happy to revise, but if not I'd rather
> > > keep it as-is.
> > 
> > The model in which the term "alternates" was born is "A repository
> > has its own object directory, the primary one, and in addition it
> > can borrow from zero or more alternate object directories that are
> > used by other repositories".  The presence of the primary makes the
> > word "alternate" meaningful.
> > 
> > Is the model now "A repository has one object store, which consists
> > of one or more X, all of which are equals"?  If there is no primary
> > that is more special than others, then calling X an "alternate" may
> > indeed sound funny, although (1) I do not find it terribly confusing
> > and (2) I do not find "source" much better, either.
> 
> My understanding is that the object store still has a primary X and zero
> or more alternative X. The idea is that eventually, with pluggable ODBs,
> X can be a different backend/provider instead of just being "files". If
> this is the case, calling X an "alternate" would mean we have a primary
> "alternate" and potentially a set of "alternate" alternates.
> 
> This sounds a bit odd and doesn't quite match what I would intuitively
> expect. But, I also don't find it super confusing either.

Yeah, I understand that confusion indeed. I don't think that the other
proposals we've got are a lot better, either:

  - `odb_backend` was shot down because it may cause the association
    that one object database has one backend. But backends are per
    alternate, so there's a mismatch in expectations.

  - `odb_source` is better, but we now have the problem that we use
    "alternate" interchangably in most cases where we also use
    `odb_source`. This will likely lead to somewhat awkward interfaces.

The problem with `odb_source` might eventually go away once we clearly
distinguish the "alternates" concept from the low-level mechanism to
access objects. But I'm just not certain at all whether it won't cause
more confusion when in most cases "alternates" and "sources" can be used
somewhat interchangably.

I dunno. The more I think about this the more I start to like the
`odb_source` name.

> > The names we use to call the collection and the underlying
> > implementations of the collection in the reference world
> > unfortunately does not quite help to guide us, as we do not take two
> > implementations and compose into one unified view, which is what we
> > are doing in the object store.  Hmmm...
> 
> Similar to references, I still think of a pluggable ODB as a "backend".
> The main difference being that with references there is only a single
> backend active ("file" or "reftables") at a time, while for the object
> store there could be multiple.

Yeah, that's basically the major source of confusion I want to avoid
with the "backend" terminology. I really do want to make it explicit
that there is not only one backend, but multiple ones.

Patrick
