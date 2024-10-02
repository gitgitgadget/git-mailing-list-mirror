Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E186B12CD88
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727896704; cv=none; b=SraGjRFWqBFl3vcXpZzKXDV4k9DFO1OtPXXUZc8U2yXlqNMTO+GiYqoI0z6a082cBtKHOe4NFaYSJrHECeU/GbKySMqJMN/Eu141MP3VMzT2iVaZXNpkliVxknbX8ie5JS8TGfIP9Tg8CMhQRlV2wSozpVoRMPUiqoCtulSJMHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727896704; c=relaxed/simple;
	bh=Egb//Nh9BWJT0T6Q/CWILj4KkbErFxhKPsihQm/pa0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUxgrnLsmjlY6laBjGHe26zWcShl75Xwkbtvylihqem0VtcJ3uOtfexoR4Bl7euFnZiWAjwRTK5/v4PLGkUjh9hzjYU7dVH7P3voIbtv5Fevn05QN1Yv0+65rA5h/gT5hfzty4Z8E8V8H3kwZiaRrKp1gx8E2/pWbgjn5lC0m34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mu4d6bPH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aurSRHg9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mu4d6bPH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aurSRHg9"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E39D913802F6;
	Wed,  2 Oct 2024 15:18:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 15:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727896700;
	 x=1727983100; bh=fTpiRCacLIU4esdLu+nNITvlf5oceOCJN/FBPvtS/Gs=; b=
	mu4d6bPHT0x64gUpg71I48nkx5aBYxads4jzcvSiBZ12Lg1oxFkFxbl2k7R3bXhF
	xy9JxEEbevb8xRF4Cts3PE+l2SBVkMC2dUv9FYvkhpmw2FtnXEXpUvPWeSEiANxk
	8Jw7VodfJrzy7pdZsJnJmf7lj+bVRclBEyIlpKz2VwYh23/gq8QVXUo7QqrZk+el
	4QN2kGoIl7dqWJ0KxLd9WWnYaSFMGFezgGpOZkhvr1f9NX8c1vxWG2rnFSvvmQUI
	a1v+8NoUuGx2fZgw1T157G/wSm+lwlhJe7uCOM2a1Zw9mYQIJ+QOQE7HWohTl/+v
	lhOa8iB8yATVJ870CFNpvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727896700; x=
	1727983100; bh=fTpiRCacLIU4esdLu+nNITvlf5oceOCJN/FBPvtS/Gs=; b=a
	urSRHg9zUJ5yk/5tOG/SluiG3z952b28F12wVapCzeo+rnmTRaAvnmRl+aRBYcRf
	0iMvlaMGWW5sgeIXPbEvo0B9x8nVi1x21XGTDi0NvEDD5aNdnRELwj3cwq1suRzR
	KiqS9p6QYr+FqqTl7x2VYSrgBFRcsS4o9u6V+DI1DSiIpfCm+j44Au/NnusB70+0
	Qj6KjCL0rDiolZF2O8x1B7DBX6n7j7YO7l/gp2Q3LnzRjCmW00yCDW8swoUy9d6E
	8J4Z/YTM++c4J8xqUN30DFloAwmFHisldySgYyIb0KNr/Q/TtphmEcGW3upj2/dv
	x9zK3F7UTWloJZV19E0Nw==
X-ME-Sender: <xms:fJz9ZselLfY-Cfbzu_rPoVPXxydFlvj7eZg9dJMTKaizpf7ItZmmTA>
    <xme:fJz9ZuN7yoEYr8WuaWvyU35g51dM3n4QrA3Kt5Sy5cqp2rhnqzDiKWgTqJMAQUVE0
    DjfOkgepuu6YSQFcQ>
X-ME-Received: <xmr:fJz9ZtgJKTXgFvY9FPbf8cGY4i8YXyF2ht22ddBmpVe-dwtpa6EucQSrm0DDCI8p2QsuWkr5adntwHyaFIt1dsX5obYTKXSOFsBp8iU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepfeef
    gegvvghvfiegvhhjsehlihgrmhgvkhgrvghnshdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:fJz9Zh-tVCkMDEbpiA-CvlOmpEr_1dJUi1gGYC5RLCbpLtGTis2cQg>
    <xmx:fJz9ZotUb2PFuKFssXJSmLWqjN8zTEbUcctNVgRMU4Vger60lbzSWQ>
    <xmx:fJz9ZoF9ZleboKAzJSwndeyAo2y1dMH62jVhLwwDb62TAtXN06DuKw>
    <xmx:fJz9ZnPn7k5xVecm6eaudwZPX3e55SqtsemaTYFMY_aKUvHHdyhQBg>
    <xmx:fJz9ZqLRHMTRTSugvjHuEonSk2swAzUze0vmIpAQGv1y14KoGl5tr8na>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 15:18:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: squeaky <334eevw4vj@liamekaens.com>,  git@vger.kernel.org
Subject: Re: git rev-list --no-walk RANGE not working as documented
In-Reply-To: <7fddacf9-55f6-4520-a288-279d3784badb@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 01 Oct 2024 17:04:15 +0200")
References: <24417-1676937251-531825@sneakemail.com>
	<7fddacf9-55f6-4520-a288-279d3784badb@app.fastmail.com>
Date: Wed, 02 Oct 2024 12:18:19 -0700
Message-ID: <xmqqzfnml3es.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Hi, I get different results based on the order:
>
>     git rev-list HERE..THERE --no-walk
>
> This (like you say) only outputs “there”.
>
> But this one outputs several:
>
>     git rev-list --no-walk HERE..THERE

Thanks, Kristoffer, for looking at the report.

The subject line says "rev-list --no-walk RANGE", but that command
line works as documented.  The real complaint in the report is about
"rev-list RANGE --no-walk".  This thread is titled incorrectly.

In this particular case, because HERE..THERE implies "--walk" (and
that is how "git show A" and "git show A..B" behave the way users
are used to.  "git show" itself behaves as if it has an implicit
"--no-walk" at the beginning, and later "--walk" overrides it), it
is understandable that

    rev-list --no-walk HERE..THERE

walks (following the usual "last one wins" rule, allowing the later
implicit "--walk" to override "--no-walk"), while

    rev-list HERE..THERE --no-walk

does not walk (again, following the usual "last one wins" rule,
the implicit "--walk" given by HERE..THERE gets overriden by an
explicit "--no-walk" that comes later).

But in general, the documentation assumes that the user follows the
usual command-line convention used throughout Git (see git help
cli---dashed options come before revs and paths).  The command line
parser still accepts command line arguments in non-canonical order
(i.e. revs are given and then an option, in the problematic example
in this thread) without complaining, but this is done primarily to
cater to old timers, those who expect the commands to keep behaving
the way they happened to behave, which may or may not appear "sane"
to untrained eyes ;-).

Thanks.
