Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C8207E1D
	for <git@vger.kernel.org>; Wed, 28 May 2025 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469777; cv=none; b=Tf1EscpoXsKuHXU7UkNvuOZNNx7GN1LxR/Dx8bzSZhwcZgu2ln3zVWe157uaeq6IfI+v+qV+Sqh+FtT7M66S6HX0jiyuJiovvDurjYkrGrXcrwSFle/lf7fG1b8yNaW3VmfUIChs7UHeeXi/J5HOfzcKvoCFwQTyvJDVU8kgXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469777; c=relaxed/simple;
	bh=6CsZ3bNX+1pt1ijAG377qwxYqtIde3rflurCSgD92zY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T/7MURXE/3AE/zU8GS4k4+MaWmTyQUVQRrBSHatYH1VBYtZP61+SV4RHpK8XhrIOHZaV+F1OSnB+xYVxir/dVwDhaJhnGvs0+igET85OxVwlrZIgGM4dv1iNIqHjOooOO0X3hGBraC/Y7rWw4vg78p8i4aQp/jll771ONqf/2iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=y4ZQXHOv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R7o0STYb; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="y4ZQXHOv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R7o0STYb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3881311400D9;
	Wed, 28 May 2025 18:02:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 28 May 2025 18:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748469774;
	 x=1748556174; bh=59ouDEEd4uuvnd/XI85IXn9PBhYxopLnFcu+SPixVEA=; b=
	y4ZQXHOvdcsg4f8XMmRe0zwH2NFaBC9FthaouWdzyVrk99sqHvdVoMq6iBfcMqAu
	BFmrC8L6hx/DrxtYpnAmRtLQJUr7gbmIGmzqyAzSiss9mos5oT57XdxzQMzro+Cp
	aKkPdaCwVdzCyKNSuRvvoqNqnY66DAjitUfJ1y4yYMeIhDX54DyeYB7qgYRkkIZQ
	fETNjEzcTrKGQ+AVnFduuyAtKZBOvxJ4EhZ77wOtgRmNm2ZRUIB4dxu915SBZc09
	wY9eYNJDffkNNy4QlRieRRhNjK8dKAKfT5qB/LORhrarg9T7XBPkMePJB0Z/UOcR
	+n+AMz2fTzLn+G5SWZqmng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748469774; x=
	1748556174; bh=59ouDEEd4uuvnd/XI85IXn9PBhYxopLnFcu+SPixVEA=; b=R
	7o0STYbV9qEuSrAi/ZcoKkOF1VjZsiNLUJ98tNY7RyLcgomYlUTwTJYg6c+o7gno
	KrwjrkK1SOFBHTmUP8MQknc90KRiSLPGXRdK4qejM73hNxcztEiuK1KKpA8FiUJz
	lAY4J5JqeXHckgYLSnFoKWrANm3uJC3x+o4I+9oWwB8tDh9dec5cTqfW5RP6uWQb
	3SwIa+5geP6Ih6GmFHiTnxzEWfPT34TJ+7Qt7glCwLjfkbvXMkNXHnrcErCx3nen
	tX6mNAZLWHhB+s9lnGcQdwN257D7f/bJx9r4Odpx1X/fw3NCD0jSYA91ikNOg2Sw
	Lrp31riBnzPnnHwZgTjfQ==
X-ME-Sender: <xms:DYg3aKh_4JzsQWiHPVO9cuY7gcb8XNssSyL6J1dJ5rFep9x6Ci9Xcw>
    <xme:DYg3aLBmHSXvrsTBbvPVf1l3-DwlaBeod61bYT0VXfOcsdGJY6rr498LgPXuP3Pkw
    i6Dux_Igo6M4qcyUA>
X-ME-Received: <xmr:DYg3aCExZ3mMn5J2gPRqWH27IoE-EXpD7TWnBdeWO7_2yt5yAcU3JyvM9FRhL1PrsaKSOMO6j0tDyAcr_zUOljBs7wCMtfiGRegUOTI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvgeegtdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouc
    eoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdet
    gedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:DYg3aDT9YpRsw_dstR2Ri7rv4AphiLa3_WAuSZph4X0llfeOeKH2eA>
    <xmx:DYg3aHxL1t2ktCZLhIc8CFWvfQ_Z3OcCIvvT2QzA1kLC2jH1wP3P-A>
    <xmx:DYg3aB4oRptNYtKEwRt38qOscXzUSxm4bv1eBvvyLmufRe6_O8D_qQ>
    <xmx:DYg3aEyaL5eaCA1F3_dnPGKZMU4Inaj-kaAmu2_axagY-4-Qh7uynA>
    <xmx:Dog3aDXt-wF2GZ1LPi344kNoNB-1evWEPTLPn-CK-srJTWuNFKqL2PYM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 18:02:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2025, #08; Tue, 27)
In-Reply-To: <12673686.O9o76ZdvQC@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Wed, 28 May 2025 23:01:32 +0200")
References: <xmqqfrgptv10.fsf@gitster.g> <12673686.O9o76ZdvQC@cayenne>
Date: Wed, 28 May 2025 15:02:52 -0700
Message-ID: <xmqqzfewpf5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

> Junio, I haven't seen your series about git-verify-* and others integrated. 
> Are there any remaining points to be fixed?

Which ones?  These ...

88ce8dfe29 git-daemon doc: update mark-up of synopsis option descriptions
914c549ac1 git-{var,write-tree} docs: update mark-up of synopsis option descriptions
7e7f47a488 git-verify-* doc: update mark-up of synopsis option descriptions
20e4e9ad0b git-var doc: fix usage of $ENV_VAR vs ENV_VAR

... are part of v2.50.0-rc0~9
