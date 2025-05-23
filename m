Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D187297B75
	for <git@vger.kernel.org>; Fri, 23 May 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020681; cv=none; b=pNoZpi54Q1ryqAgbSmhCpvJMt8WARirb07giO8V966re+QEd36bGnYWUcx8fD02QixC/N8llGDHmFvnyEWpCRoXb1k5Pdw3DF+ph1bVWItMIJ3ZaqgXJqi2kODL9RXOO/e1iZYL1MZomrUGQy3wTfqgaTCRZPVMH0TPZd+k6ErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020681; c=relaxed/simple;
	bh=r71C8iN0k0pGnlze4UK9OVXEZVRr10sZy2AIo6f2j+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tQoZAyhGRs4H3V6lW9c5Hpd3zlHtQJ0ImTeX4BMpX+5aZmMJ+oICvHIvSkEYo2OOB9M+MMw6zYR+RjQUi2h7kAr+d1H5nfA9eH73opSUfnHCpLkjIfkWMFzKeSyIOGNC2gcB847vUkgu9mC4jVgl4rhQR85BVP92/wBrd21dwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SNLPKBF2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hSTEw/8e; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SNLPKBF2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hSTEw/8e"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC0302540149;
	Fri, 23 May 2025 13:17:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 23 May 2025 13:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748020677; x=1748107077; bh=3G9CUgXGSr
	2+NQFwcXzDASGRFs/sohsjLBTk3wzgjFA=; b=SNLPKBF2mEWgX5kvAJx43ba788
	XA/UjrmpxrsVBFz2WzoCy2CFKyWunxDg5HDAuZGvC84fxo338aWfdY1+5C+4l2iN
	zcRaY2i5yyQiWF9RbIaCL3aOnpBHIPw7JYziBtqa+XrB+1srutHclz73g3jITKTW
	2H+G2hmYhq7JCdOBde3+kyuP2KCl6TpP+Oo3v/oh/GVxRHfdeTESa3CwinytOZiH
	XE4tR1LjqrWGlp73pxQmZ5Gnv2G/kHuhgIFN3Za4e3dEZTMQqrlW3kcQSqEncIDO
	tLTJG/lchQ9G+K+UfPv3DDavAp9fCjPQGgUs46da4vSyGkehPE9WZZc538vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748020677; x=1748107077; bh=3G9CUgXGSr2+NQFwcXzDASGRFs/sohsjLBT
	k3wzgjFA=; b=hSTEw/8ethHXOSOD2FfwGBn13keIhyrR7P6PoqJPNaA5Mn4R7kJ
	bbbkaFGCjQUvn98Q3pr0juMGYZLVzYsmzr635Hpi+WRsLyr7Lt/xcSQ0j0owJLuL
	56mrg5YJERoBPwo71ZEwO9Vh4aezwIhqgs1DBVz4ktzRHRP7PSYbOvuyKv4f8ic2
	YiUFtja41U87oSRXnpDBKTS/Z1xIVWdH6rexDzF/R9hmNv55VyB9BB6avrVqF+72
	Z4PSp7vs+ZcrC2f0zzjYRmGf4kVL6lygZ4wBsc31Zpl1MmJsQsi5PlzIHI6yr5fM
	79ucjyZdTwIkKdgA3n+/0dgXk3Wl8yza/cw==
X-ME-Sender: <xms:xa0waKb7oMmlzYLFw9itidznyk27hVwdMZ4Lv_-exG9_4vttyZ_RDA>
    <xme:xa0waNZloLRpopqTqd7yyC2x6WJzh32AsORN-eZafIKU3ZuIuncmggrKh33F2pC7Y
    CgqHQ74qZAc9d344w>
X-ME-Received: <xmr:xa0waE_4cXDJqszw3Y-xCbU3vWGJdCWBeGfjQVsfgAcXLZqtBAlByUc5xJp6HK2SIJyNGn5uprW3fY2irIcfWclYUrHCW_Xes6pYq8s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelgeefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefl
    uhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdt
    udfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprhhosggvrhhtrdgsvghllhesuggvlhhlrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xa0waMofVfXTcMFKXb17gRjhRgXGmh6T9DWKJw2XARAKgWa6xjTrjA>
    <xmx:xa0waFrJSaZLFa82t5ygT5BYiaYwkGEKFTm9BThuY6VngUcsjTDdNA>
    <xmx:xa0waKQzMEThExaqfVMrce32aCss9iuFxTuwm07p01TLT5oGEFtLEA>
    <xmx:xa0waFrmuJw1jTr14F_sw_goXs91X9FwP_VF9sIuXdnKznBykfweUg>
    <xmx:xa0waKNY3bdHRDV3_5LGiK5LWQwE0NjFmVW5a6l8ou9NQ5_TibwZphwA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 13:17:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Bell, Bob (ISG)" <Robert.Bell@dell.com>, Jeff King <peff@peff.net>
Cc: <git@vger.kernel.org>
Subject: Re: Bug Report: git show unnecessarily requires parent tree
In-Reply-To: <IA1PR19MB88859FF5C7E547010E555E7F8198A@IA1PR19MB8885.namprd19.prod.outlook.com>
	(Bob Bell's message of "Fri, 23 May 2025 06:15:04 +0000")
References: <IA1PR19MB88859FF5C7E547010E555E7F8198A@IA1PR19MB8885.namprd19.prod.outlook.com>
Date: Fri, 23 May 2025 10:17:55 -0700
Message-ID: <xmqqldqnxn3w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bell, Bob (ISG)" <Robert.Bell@dell.com> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
> Tree-less git partial clone: git clone --filter=tree:0 https://...
> Remove the promisor to prevent retrieving more objects: git config --local --unset remote.origin.promisor

At this point, your repository is officially corrupt, but it is a
very effective way to demonstrate the underlying issue that exists
even if your repository weren't corrupt.

I do agree with you that "git show -s", without any other options
like --diff-filter that affects the commit selection [*], should not
have to look into its tree.  Unlike "git log -p", it should not have
to see the tree of the commit is the same or different from the tree
of the parent commit in order to decide if the commit should be
shown.

The fact that it gave an error "attempting to read the tree" is your
own making by corrupting your repository ;-), but it is done as an
easy way to demonstrate the underlying issue, which is that it is
suboptimal for it to try to access the tree of the commit in a case
where it should not have to.

Is this essentially the same issue as these?

https://lore.kernel.org/git/YqEyh5opAaJxph2+@coredump.intra.peff.net/
https://lore.kernel.org/git/20250504082715.GA6257@coredump.intra.peff.net/


[Footnote]

 * "git show -s --diff-filter=D" on a commit that does not delete
   any paths is silent.  "-s" merely says "do not show the output
   from the diff machinery".  The same for pathspec, to wit:

   $ git commit --allow-empty -m empty
   $ git show -s .

   It asks "if there are any changes to paths that match the
   pathspec, show the commit but do not show the diff output".

