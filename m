Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04FB1891A9
	for <git@vger.kernel.org>; Fri,  9 May 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746819077; cv=none; b=j4m/gOCWJb7yyPR/G8iWeUSc8i49YR9jJ5I/QTHtZ/xkJ+QomkhzCWPgxC2pPqVTy8CLXvvYZzRGNum6Tvasrwsmkb+HRiX3uisNRbrT79FmSAK//o6xSxzuht3J+wAvxQVymhCXy81f7xdcua5aOF9ZtCVVtq5XfVEx0zbOXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746819077; c=relaxed/simple;
	bh=HXdzVmOuOS2LeiMpdpo7T1CEH84Z3RHky5EusnIIXlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LYVcECZX3t6a3QiNe8Tv2yL+bEJu8sY9mY8jjd8UPeHncxxIqo7gT05/Z0JpEmPyDHcy1uxzUK90OIcumnZEMRV9eGKGwfbJYqZ1g/b9Abf2RJSX9BXiQK1daRReKzT/NdGq1o3NtheJtL2qE/MJp0sz9jSk4OeAalptXBILp+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RLQZlnYk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEWWffUH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RLQZlnYk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEWWffUH"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 80C4213800C9;
	Fri,  9 May 2025 15:31:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 09 May 2025 15:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746819073; x=1746905473; bh=hk2lxDgZaD
	h3OTm9xnt8aDWj6kN0k113k5zS0EkseEo=; b=RLQZlnYklMheUpYYf1mjLVJrKI
	hPox5WajvvQ+fUgjEY/IvVDN6+Xqv8qe4yLuBPHAr/AOeaSJG5Q47kpBEp/+PtNi
	uNKGSfMhJzGIox2/PC8a1NFe6kXn/SHxHNG/UzAigmDJ/kxs+bXBqASCtv8t5ZAM
	6Cppn05RLRgi5LkTHW2i7tWRwFA4kDdKdzVZxh51E6+828oFNcfGVqcJnM4Hxkm/
	qqERGFZxaDNcSUSTd3yKWTvR5k/Ob+M4MnXQ7IlMiDmND3y3a5qOSoBVAOzNdQI5
	du8mS2n2SeaqbO5ipCzyn0tp7w+KeZZTxwbt8vp4yMlQbgBumA50cgfKIV/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746819073; x=1746905473; bh=hk2lxDgZaDh3OTm9xnt8aDWj6kN0k113k5z
	S0EkseEo=; b=UEWWffUHwgZh0Qis0nvIx3i+ZSvKa+yLApwoMLZRz5uSTgHIdt8
	2Nt3UcgXlMfuYzdRei8LuuoAT7RGOX9Ql2OUeGlhzezOQcmP8qoJDNyM402yMRgh
	75gvYfnslceXc7zH+5QRalkAwTDVU5gLjH8cTiB648cMMSJN6D/7KXnG14bVQa2+
	rcTOyZ4yhp2O+1xx4L+udvC4qQmNtbtbZMqpZEZ7HGFAf5V6m5KorrQ047bAdrPI
	jVazhwYvJdZq7y6zdp5HjPTE0eNhXljFk3UDqJzz+JEylP3GeKtSiqoRvXLMdUqw
	vU4BBscIAATMJ2MOeKDig1ewNXMgIhoRiEA==
X-ME-Sender: <xms:AVgeaHdBHIbAvupR40pXPtIy9dhguiB2yR8mISXDOwb9iEi1soBodA>
    <xme:AVgeaNPlglASmvRyz2k8WkTMu6kxyRq1ZPa0-9YA2As8Uk_DD87z9P-84034-jc8C
    zM60ORu8xhUdLgieA>
X-ME-Received: <xmr:AVgeaAjFG7JIvezjkQo6N9fdC4WiW132FArkOoz5Vd_PcF-WAPkXV1w5iXOWUNrfxlNfQQRD_INEjXn1rqsn3xwbtlKLZBtE4iCv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleefgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:AVgeaI-AG6H4fCTXMONgEgIdNtiDlmU7Nyrae5Hn8vGLwewNfDSZ7Q>
    <xmx:AVgeaDv7TRBInZLbPKK-pCMuDsN2McN6hpfw2seO-0htZQ0DvrF3Ew>
    <xmx:AVgeaHGWNUbWrcDWviq17mEHUzDeXSQUZ4VTMFv5oFkzeM-hnzuTog>
    <xmx:AVgeaKMlxCrysJOsG1USNIKzD1NXDksmJpYBnAb1F1dG0HJFOOa3QA>
    <xmx:AVgeaCDnY5O414S_-NaCH0oMMDityYOmxc0PTc5uSkvlVYDqmZxtZvQE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 15:31:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 3/4] builtin/stash: provide a way to export stashes
 to a ref
In-Reply-To: <20250508234458.3665894-4-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 8 May 2025 23:44:56 +0000")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250508234458.3665894-4-sandals@crustytoothpaste.net>
Date: Fri, 09 May 2025 12:31:11 -0700
Message-ID: <xmqqecwx1szk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +static int do_export_stash(struct repository *r,
> +			   const char *ref,
> +			   int argc,
> +			   const char **argv)
> +{
> +...
> +	if (argc) {
> +		/*
> +		 * Find each specified stash, and load data into the array.
> +		 */
> +		for (i = 0; i < argc; i++) {
> +			struct object_id oid;
> +			if (parse_revision(&revision, argv[i], 1) ||
> +			    get_oid_with_context(r, revision.buf,
> +						 GET_OID_QUIETLY | GET_OID_GENTLY,
> +						 &oid, &unused)) {
> +				res = error(_("unable to find stash entry %s"), argv[i]);
> +				goto out;
> +			}
> +			oid_array_append(&items, &oid);
> +		}

Grabbing individual reflog entry given on the command line looks
trivial, but ...

> +	} else {
> +		/*
> +		 * Walk the reflog, finding each stash entry, and load data into the
> +		 * array.
> +		 */
> +		for (i = 0;; i++) {
> +			char buf[32];
> +			struct object_id oid;
> +
> +			snprintf(buf, sizeof(buf), "%d", i);
> +			if (parse_revision(&revision, buf, 1) ||
> +			    get_oid_with_context(r, revision.buf,
> +						 GET_OID_QUIETLY | GET_OID_GENTLY,
> +						 &oid, &unused))
> +				break;
> +			oid_array_append(&items, &oid);
> +		}

... have you considered reusing reflog-walk.c:read_complete_reflog()
as a helper function?  

Doing so of would be more efficient than going from int to string
back to int to call read_ref_at() and iterate over the same reflog
entries with refs_for_each_reflog_ent().

> +	}
> +
> +	/*
> +	 * Now, create a set of commits identical to the regular stash commits,
> +	 * but where their first parents form a chain to our original empty
> +	 * base commit.
> +	 */
> +	for (i = items.nr - 1; i >= 0; i--) {
> +		struct commit_list *parents = NULL;
> +		struct commit_list **next = &parents;
> +		struct object_id out;
> +		const struct object_id *oid = items.oid + i;
> +
> +		next = commit_list_append(prev, next);
> +		next = commit_list_append(lookup_commit_reference(r, oid), next);

The individual-reflog-entry mode above was fairly strict in that a
list of reflog entries with even one unreadable commit caused the
whole command to fail, but reflog-walk mode assumed that a failure
to read an entry must always be due to reflog entries running out
due to the index incremented to a large enough number.  I suspect
get_oid_with_context() can give you oid obtained out of a reflog
entry without actually parsing the object or checking if it exists.

Should we be a bit more defensinve here in lookup_commit_reference()
call, which would silently throw a NULL back at us if the commit
cannot be found without complaining?

