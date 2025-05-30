Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A280258A
	for <git@vger.kernel.org>; Fri, 30 May 2025 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622500; cv=none; b=YLl9Sqre5red6ajrwmK4kePKzl3SujTeawNUNyxKvAoNUEjxMSeDU98bicj/MGDvJx8fVG8kcAnIXVrjhVzSWG2LRHRhWeiWd/AjN/Q4V6LSV9HSPFkPfuIMBmzcRq4Hqazi1UIKAAu2Ck6KpU/7tMRpzq0LU0YcoAjqapip3w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622500; c=relaxed/simple;
	bh=W8MEBzY1MeU7nXZY1J2E8KdWMVmxKbm20cr9PxMN/RI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qLA1URpjRfoTe+fWbzDX28UOgKUs/1ielLL4x2biK13m+huMzztNIXFZQ9g5zduUaNv+yAKNw8EBLr79ZtHl8gR5aE1s1TLPKLnTb1B0ZSE9Re0Jq3RqlbluKAhjCHDMUe7qQ4iOfsZopApbB8YMybHrGjhsI9fJN838PgmK7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2G7l1ZjU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UYOP0Vxw; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2G7l1ZjU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UYOP0Vxw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DC50E1140180;
	Fri, 30 May 2025 12:28:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 30 May 2025 12:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748622495; x=1748708895; bh=Ys5QuwEH2Q
	CnV6QMcHtaloLdLIZ13PjJqixzW9jalds=; b=2G7l1ZjUxwoLQ2JfuIx96cWfRB
	iCWaf9GyJadMLLp9H2AXh9PrIhQwcAOEK189NgXYUIo4o+LYmgzD1umi2IqbdOeK
	TncFbVT9kuw9ZmUVSO2i/Zl9n2FBnFz2L2V1D1lXOah/ciY3GrfxXjRSF8Y8Kq7f
	hfdefu2coge4ypWi57r1ShHomoxm4bXlcnzDumCqWtUWTk1wA2D/OitByq7vh58V
	7O8RcEK8IvpkWH/A8EcwScU0lW/xBtl3IlkkQtOx5Lh1TR8/O6AEepeNxug9RQue
	PbzR9sYxnqLyvKFnhWEYpRicnYBEBwn1lLakgJMG/9zpisMEVWnvJ1c9lrtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748622495; x=1748708895; bh=Ys5QuwEH2QCnV6QMcHtaloLdLIZ13PjJqix
	zW9jalds=; b=UYOP0Vxw7HroSW+agQHoODz6gl9uhsyWzVn5xWtdIKpuhezbzD4
	c92xQpFX8A/r+ufI/8S0Z4tF2XvV2V+9gySFhAj4I2ora87g7nBKj8OuyzwFVNFd
	MkZ45w1fdsel/7G6EstZsMw63LXSkjpi4Xkrcz5gW0n0vk/trvbzDcfAAlWlTc6F
	AF8BfiYFNwmXpBfm+eLsqAwhk5dTSNzl7bDKlBgVyEfgDQL4dUbJw14ki4gA6X3y
	Cys+RIRuRo5lCmintiWjvRzJri9yy90yJCUrnZAAgFDoy/bN+75J49mVEc6VwtK7
	fsOPzQU0/0Ou9xybjwVxDgSRazg38K6ADog==
X-ME-Sender: <xms:n9w5aMFHtH1ZYkP125TRAP0-phaDsjB7-1lvO6liEWqhaFEFqDXTTA>
    <xme:n9w5aFUPHErvexKNVk4yLKM7PPpawlky69W3FbQH_H8MbJwmBNPQQLf_IEdWkxM9D
    SEeCQ-AYBSXSH3CMw>
X-ME-Received: <xmr:n9w5aGI9dZNqQ1f0lX7xSQZ65-IOq7pJNlb16t9C69rHcbNSOZHlgS3sRa2qRDA1xv6uomlwjG85dAAdI0NeHTuI82F2xbq2O5f5kbY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleegleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:n9w5aOGaTPV584KbN7J_fVblSxt6q8Nd6OiRqQ8J3c5SOuVp5BK5zA>
    <xmx:n9w5aCXcc2bzOR4_WT5kSTuxCg2xb2sHWwEbl-0aRhPmWV_S7ZiMNQ>
    <xmx:n9w5aBOWIEBJQ9Zy-mJcui0JQs7Y730BHcJ7yUK8407H4yw0BdK9Bw>
    <xmx:n9w5aJ2J1tqcih7nZXAgbiAgftuz27yOfgjlohYHXK5gDFLobXTkAQ>
    <xmx:n9w5aNyZiJ5KvPhVF96KtacMT2DPBMYp-SqSeaijPM_EE41ZoC4YAkWq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 12:28:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (May 2025, #07; Fri, 23)
In-Reply-To: <aDl-yd2fh4qVRB_V@pks.im> (Patrick Steinhardt's message of "Fri,
	30 May 2025 11:47:53 +0200")
References: <xmqqtt5au523.fsf@gitster.g> <aDV0jwaQ2DlcM0lZ@pks.im>
	<xmqqtt56ov4k.fsf@gitster.g>
	<shpx4piigp5sqgpbzx4vdgu4zdn7z3ykxhu2cdyjh5vpr6zbqb@rf2sxg6hukpd>
	<aDl-yd2fh4qVRB_V@pks.im>
Date: Fri, 30 May 2025 09:28:13 -0700
Message-ID: <xmqqwm9yf4gy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Yeah, I understand that confusion indeed. I don't think that the other
> proposals we've got are a lot better, either:
>
>   - `odb_backend` was shot down because it may cause the association
>     that one object database has one backend. But backends are per
>     alternate, so there's a mismatch in expectations.

I do not see where that association would come from, though.  But I
agree with the other objection that the word "backend" is more about
implementation and less about an instance that is realized by that
implementation, i.e. two such components that runs the code for a
single backend may be part of a single object database.

>   - `odb_source` is better, but we now have the problem that we use
>     "alternate" interchangably in most cases where we also use
>     `odb_source`. This will likely lead to somewhat awkward interfaces.
>
> The problem with `odb_source` might eventually go away once we clearly
> distinguish the "alternates" concept from the low-level mechanism to
> access objects. But I'm just not certain at all whether it won't cause
> more confusion when in most cases "alternates" and "sources" can be used
> somewhat interchangably.
>
> I dunno. The more I think about this the more I start to like the
> `odb_source` name.

Yeah, I do not mind calling the instantiation backed by a backend
implementation a odb_source.

In any case, when deciding the terminology, we should look at what
we currently have in the glossary and imagine how they should look
like in the updated world.  Currently,

 - "alternate object database" is described as inheriting the
   entirety of another "object database" (we deliberately do not say
   that this other object database belongs to another repository, as
   a standalone object database is a valid option).

 - "object database" is described as what holds a set of "objects".
   There is no complication here ;-)

When treating the set of objects stored in $GIT_DIR/objects/??/
directories (i.e. "loose objects") and the set of objects stored in
$GIT_DIR/objects/pack/ directory (i.e. "packed objects") as two
separate odb_something, with a vision that we may add different
implementations of such collection later, it would be very confusing
to call each of them "an alternate".  "source" may not be ideal, but
it is the best among what we collectively have come up with, I think.
