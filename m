Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE826F2B2
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542453; cv=none; b=Q7b0sQilueKI+jnSztiPgjHR4fAuFzP64vQtRI1iWXMnpgZIOnH6DKGqx5pW4hRB8sORZzVovrAZSD0YRcxDpDxqnbiim8olyqFnJr4vQFzWVxKMnwJ+UWufaG5tvDIheCZtDcXlisIGuDyv2zTDIxROvBih4e48Yc2TuTBV0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542453; c=relaxed/simple;
	bh=GdOFsMlMD7DTiMFXaVhdJwP90yqiE3ORzTp9PXMpDOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FhOniKHde0Gc7whgmEzISCkP7xPpUGptjRfW1PI979bGlldFpZwZbKbZXkYVvryLseku5pvwvcpwlLoirn7vmppjj9coF3So0CJTIH3ew5+zKXtjpHm54HE1edDJVofa5kVxNUxY/TR6O1MSKvdDHsiXJ9BuI80gLKhOlkRvc5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z8y2FQ1r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OFl64EKR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z8y2FQ1r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OFl64EKR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BBC22EC018E;
	Wed, 15 Oct 2025 11:34:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 15 Oct 2025 11:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760542449; x=1760628849; bh=etRGreSoEe
	i/uyEaCUO30M3zkl7XG/yIZFR9ss4m+U4=; b=Z8y2FQ1rTAZCxNw23apltvt/98
	e23V/ckPylYJCbSecSBAA4MtLDn3d50XI3uKK41P+3lK6yZfkfXv7zngz0CZOlTB
	DXM+82TzXY8OaN3+tX/IFwrOR+ResVU41iROste3StjqAzn+KVpoO75NmLW1H0FL
	4In5YcV/hSTTfVfsIS5Q8CpZVGEcUPZnIW3CWkcLFd5BOjZRCJj4pqKRVg7T7MzL
	BvAGnPw9mvVImsWzuB8b8kl6ASU9E2Qqbgqljzebf2sSDStRpZ/1Lz7SvCen3iis
	ck2N17ZMnG0vrmX5WEZ56o+N8Z02bbyDUmriECbg985Z0hXn2Lk3N0pBJKoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760542449; x=1760628849; bh=etRGreSoEei/uyEaCUO30M3zkl7XG/yIZFR
	9ss4m+U4=; b=OFl64EKRWejLAaMe3/TeMRDnrXOctoR282egwLT8mMOEU7ffg2e
	3uHjimCBUdCtjgI5YHUB7dKOwcjFQ5H6if71EN1tr3ibACN+8LazVlJfiy8R3t8M
	8uqYuWFlrjM4mxdz5qHkSPzIrakvc9fkAdEA/aqFbe9fBsy1NJJbCUj4SszHq4up
	tk9+RC6TSpOGfgd4ryFEikYJyjq1H0irjChhRbsgGHY8syIxOJajLeM6LWeXDcP+
	ojoVdb7w6dvZloHjrhg3G6Gr+7eQQBB2PDmADLPO7n16m38/VcKgcgQGlMla71zg
	GcrnenKaFBmwSozHT7od7QIC6MxUB84x0sQ==
X-ME-Sender: <xms:8b7vaHUrV5JP-mcOkvgSVdw6XsSih_jbVjA27oUtqSOLeN-qla9hmg>
    <xme:8b7vaB2j0iREpqZdYwdGn5cp07i0vk5YJJXy5jkqGCjvITEuiq95Ujmz9Vr-6pIT4
    WJ4Q_KElHGkB0Xc8ZFZ5YQW9pfPIoSp6xNTOg2Ed7uNNhQdtL8tsQ>
X-ME-Received: <xmr:8b7vaFpdO1zSMgO2RJJY5LLmLJmDWySrBNy53iqXSw2-Au5tbXry461D-A0VVuJxJmk-HKjkmqPWdQ8v0NLP7ojBa7yVKVWaV3oU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8b7vaIUJzURMYqaZxADCrt0rXXHdeGj_vSejTF9EzS06B5C44fTLmg>
    <xmx:8b7vaAZgK-ZeuF7i1cMosN4suytnKZc05wJ3OybKvgvaFwZiD83JiA>
    <xmx:8b7vaFemkgQLLnjmHWefBtBBxwPaDQZugH__8AGFntfb3mRR34ckBw>
    <xmx:8b7vaK1Y8fFireajtcDszrpusPiy-1Nhl6kQnbThjs_ZihI5Yv2yJw>
    <xmx:8b7vaFoNlakfygMWllVkG9WiExG6QLOcM8PJgPORGpb-lA3PPGjAx_HI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 11:34:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3] doc: add a explanation of Git's data model
In-Reply-To: <aO8-NtJPNBAM2tVn@pks.im> (Patrick Steinhardt's message of "Wed,
	15 Oct 2025 08:24:54 +0200")
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
	<pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
	<aO8-NtJPNBAM2tVn@pks.im>
Date: Wed, 15 Oct 2025 08:34:08 -0700
Message-ID: <xmqqsefkuqkv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +Like all other objects, commits can never be changed after they're created.
>> +For example, "amending" a commit with `git commit --amend` creates a new
>> +commit with the same parent.
>
> Let's say "parents" instead of "parent" here so that it also works for
> root and merge commits.

I just found it amusing that parents can be 0 ;-)

>> +NOTE: By default, Git references are stored as files in the `.git` directory.
>> +For example, the branch `main` is stored in `.git/refs/heads/main`.
>> +This means that you can't have branches named both `maya` and `maya/some-task`,
>> +because there can't be a file and a directory with the same name.
>
> Hm. I think mentioning this can help, but it may also creates questions
> when someone has a "main" branch but is unable find it in
> ".git/refs/heads/main" because it has either been packed, or because the
> repository uses reftables.

I had the same thought.  The only thing we want to stress here is
that the names of refs _behave_ like filesystem entities.  So how
about saying just

    Note: when you have a branch with <name>, you cannot have any
    branch whose name begins with "<name>/".

and stop at it?  It may look like an arbitrary limitation, and once
in a distant future ref-files gets retired, it will become one (as
there is no inherent reason why reftable backend must retain it; it
only enforces the same limitation to ensure that the names it stores
interoperate with another clone that uses ref-files backend).  At
the data-model level (which is the theme of this document), it is
just as immaterial as refnames may be case insensitive on some
systems.

Mentioning the limitation may be good, but the data model document
is not the right place to explain where this limitation comes from
(i.e. to be compatible with and expressible in ref-files backend).
We do not say "you may not be able to have 'maya' branch and 'mAYa'
branch at the same time on some systems", either ;-).

>> +Git stores a history called a "reflog" for every branch, remote-tracking
>
> I think it's a bit unclear what "history" means here. Maybe:

"records of updates", perhaps?
