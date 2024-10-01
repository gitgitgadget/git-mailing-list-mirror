Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE771C463D
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805179; cv=none; b=V46DgMqz0Z/+QZhvy4RE/UTM+i8J9VLGXmFw7sDbuShZ91CN7/q1nlGLMeM8kdVJW/CnIY0ui2vHDvKoCIcrF0wW8BL5B0VF4W+VFonUo9ngxfzMsHtSqQ/4P9kqOqWE0PX7Nbiu9WNSnIDmmoRkzj+SlesdF2VI75u9/wekCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805179; c=relaxed/simple;
	bh=PGo6hZC+wtNP6xQPouMeZM7h6dJTnjWMHxNgWFzQTPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFQWMqpGuCw/MqC6ykZsSLZ/xy48SqAHAsUCp1eBOBlZMr6eMiwy/dYOgzYW/tSzrkc8MnHCl4t/BE8VtKWR5T18WERLY7vjMNnshvQrsf5SxSlXOy3L5V3w0/7CRz/+kWmIC1ZhrOlLaVKOSWzZ/KdLvK8rJT6AZZOZqcBIegU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y7JMhcF8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MmMx6nNu; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y7JMhcF8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MmMx6nNu"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C40513813D6;
	Tue,  1 Oct 2024 13:52:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 01 Oct 2024 13:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727805176; x=1727891576; bh=lSsrn1Y9b+
	8+M0PQlnzh8N49/1443jfzJ8XxcCW2cbI=; b=Y7JMhcF8V0ge09527+QCplPO/+
	fn0Ta/secjMzLG1urdVfnICTbFUAYKHI/Krxt7QkNBAUNcbhR9bTYEekyvzOnkq9
	DYrDDXQS7ifz7ft+BaSxfATIb2TiT7TiQxIUqwhY7iJBTqJP9DS9ZSlIxrb+E3nV
	wKxMn/IskT5uSl9qDmST9V1t45MRzNOGmgV002U+tiZsP17+YtcbwCl/sKXAjB0+
	zT0ptH1vk48OO3AK8paP84YKYy7Fz5cQ+gxY7tSy8BLG7YZYWhMIV0+/7PgNo/f2
	OKInxHs3w7km1NWLKevRVVHjTk1MHNDOLwvW1RNPCp2RTke1+6FR2O1/OZTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727805176; x=1727891576; bh=lSsrn1Y9b+8+M0PQlnzh8N49/144
	3jfzJ8XxcCW2cbI=; b=MmMx6nNut1D1N/1NOSOegbdg7Vv/wYapxSSXikOtoUbW
	8l1hAANYr/jmlJH5Of5DaEaxlzVvwD2Bs2s1Q8OBqjaagbuMR21lZpU785q+F48U
	Y6eVaEDMkB2ANl+aEAhilqrdWZmhyrOYClAZIK4LmuI/0elrBVCGnCoi7Xmxv0k9
	VDQq7wTqgTR8dWl7sp1eodzeoMnJM3fSlcOCQO7enagQ3nGRWALepMxTpmih0iJI
	BDVDuBDL2jLgTsX2uc3bDdw80Gok46YuEnslHIMpxLLRpchm0d6FABVYpAOWsG8R
	rDGtrcWqMD5cLYJ7rG5qZ40PN3btIdjbnEjlwhwb+A==
X-ME-Sender: <xms:9zb8ZlzoOnWxWiX1Td_2aL60kuf50q1igCFaaANaeaQwWbVPFJtNNw>
    <xme:9zb8ZlSznRvPtKk5jKctUIKWPe0fFBaEgBSHHYHS-WOk8HW6rZLDUple5fTkzOcKi
    xGiVUxga01VdZIDpg>
X-ME-Received: <xmr:9zb8ZvUqE5LmCyCXC7ua3QBxXNKu0QQqV-bIKBtSEJoN3GSqMvsGMkDNchkhQCgiE1ObRAHwIvp5mxtL64UmRNlI-nFPOF0GRxppWUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhope
    hlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:9zb8ZnjUgL9kSGcM6TwlsWMEeW2gBRTHybJqr51HJM-X_0JwrZUFuA>
    <xmx:9zb8ZnALonOH3D7GwqLYP5jUvQJlsLyfba1ZG9fTKkSTZ8Z57ds5yA>
    <xmx:9zb8ZgIbbP4rYJUKd2Hbdq69HW59ctl5SKNDq17zC5wjBYjbSvCaNA>
    <xmx:9zb8ZmDdwIiWsH3E9kNjHaTbaUhNVcn-0QN11Mgk9QgHH1XEKGrCaA>
    <xmx:-Db8Zi6cIQjWV720HK2lszF0LrXUDscCYU5eyowJG4LZik4l3QcTwhKm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 13:52:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 00/25] reftable: handle allocation errors
In-Reply-To: <cover.1727774935.git.ps@pks.im> (Patrick Steinhardt's message of
	"Tue, 1 Oct 2024 11:41:42 +0200")
References: <cover.1726489647.git.ps@pks.im> <cover.1727774935.git.ps@pks.im>
Date: Tue, 01 Oct 2024 10:52:53 -0700
Message-ID: <xmqqzfnnyakq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this is the fourth version of this patch series that converts the
> reftable library to start handling allocation errors. This is done such
> that the reftable library can truly behave like a library and let its
> callers handle such conditions.
>
> Changes compared to v3:
>
>   - Fix some additional sites where we use strdup(3P)/free(3P) by
>     accident.
>
>   - Convert preexisting callsites of free(3P) to use reftable_free().
>
>   - Introduce a REFTABLE_FREE_AND_NULL() macro and use it.
>
>   - Ban standard allocators in reftable code "banned.h"-style.

With this patch, there is only one hit from

    $ git grep '[^_]free(' reftable/

and no hits from

    $ git grep '[^_]FREE_AND_NULL(' reftable/

which is just as expected.  Nicely done.

Shouldn't we add FREE_AND_NULL() to the banned list as well in the
last step?

Thanks.


