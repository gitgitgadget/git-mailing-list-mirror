Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765BE1D554
	for <git@vger.kernel.org>; Tue, 20 May 2025 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751734; cv=none; b=bjpZhpSIOvMvOGLxjfwgObqqG3qT31KmN8arXNYBITdp5UMywBWjnMYTC4IZQ6nUwGvcPYjASXzPRc+CkkyZ+evirhILDImSdLnq30Bn/eoBwLRhPJoifSYy6KR81RU2acN+rKFgfusU+hOTFHUkWnDZIMGawFu87VxfEjEvhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751734; c=relaxed/simple;
	bh=sey84ei+6o4emT37Ns1FbJ8TEXimgE0/YGR4njZJggg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OPmq8fJjFLG5krHtsFmBFB8fI8rvPgaqvoYyCsq/rhiBBLvTLxcNce+DVPOEIXjM6Q7OxZpUXeF5e5ojMqsqZHFrgtt/gSxdwfP7cVrW8uWjhNZDsn9mDYNonZCyTI3XoA5lUz8I6GPQrgI4J/oFGMPMExvzvv3P+ir0hWkpAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nCnKXYso; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cjN7nkz3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nCnKXYso";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cjN7nkz3"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 56E9C11400FE;
	Tue, 20 May 2025 10:35:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 20 May 2025 10:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747751730; x=1747838130; bh=3VG1rxw/Ie
	SZiAkmZrERMPs2htQVA2JdT55i16wWJWo=; b=nCnKXYso4YcXkYVl8yglyYBqZs
	/H58WtT27nO0+1o7RfsX9dSBRWTqKjpWlfNLxj2+iWamzzn///P+RSmLjEoqpD6M
	ZPdyg1x0Z3VE6bmuq//vZLCbCWG77BPqgCBRpL129MCXvAMroIgiWiVZWMAd9y55
	ZWfyhF8yIHAoesQFlmwfHaBBcuoKoLnosgsqKAqltkCZXzqbjk1WCW3QtEW/cM7S
	9LT68B13rnxs3AXL3ENNJhV/cOW4kTwJEFlNY515ChafElQQ8XTZ7LRNWF18Nz9f
	rT+GKHj61w4QJW1ltn8rt2lFENaaeQWqEzQl0EzBdEpn9MkoaPCk7UYEjdnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747751730; x=1747838130; bh=3VG1rxw/IeSZiAkmZrERMPs2htQVA2JdT55
	i16wWJWo=; b=cjN7nkz3a2xEC8Zogw0Dpdcvqw9C7PZ9UXnzCgrsGB1dA3T8520
	ixRg7UAQTDAL1+Bid6k5mO5jiD4G4dynw0al3G/ZxAzQ/5DjlKp4XOngnPzVCbg/
	ZikfswSq7HRbYsazF+dr7FMyntUDkc0thN3Bc0uEbcdxIbfKx0lo5sSBAlrt6ntZ
	5vC+QbCxUPXdmMlEyBuBv1/2h5gi90rZFiA1A9sG6aPcnT0UoZLg9SKIbuJHs/IA
	MG1QxDM4M+JyUK/MbMz/uLi+nz6JtwN4uPgD+YzWxMYIbp/jySrtncMEhRuX6eEd
	O14FJzD9E7Q80dElSFvcevUbJu43eeAEYig==
X-ME-Sender: <xms:MpMsaJIbpA0kXy0jUJ3AiwczGgsOp6DlWzYty4IQ8Rysv2pifhBQLQ>
    <xme:MpMsaFIFM46nXL5oSUKEub1Rr7oUfCI9o7Qt4PCb9IvjCM-Vu1V_nmDtKjwxR-Kwf
    kKfo0GGsUXf8f0rtw>
X-ME-Received: <xmr:MpMsaBtIeV0GGLCZ84R6etvFKoTBW1ka--riBP_bc9zqX_7-m2YNOWTR4V5z_ntqPwAgusLVfaGDoXWUA_H4CdOT-9LisgWKmSjFbec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrggtohgsrdgvrdhkvg
    hllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MpMsaKZhM-u05o9kDWZatJTX7xuGTtOsWBvpbux9hcRiAmEI5JJWDg>
    <xmx:MpMsaAZ854O0Kv9Q7ErxDv2X7me80h1qPf60IODYKKH2Mo2x3fvpNA>
    <xmx:MpMsaODOay3v1Pv934y4kXTZfCbO7E0DR8Oa3mku0OxbzsH5Gu5g9w>
    <xmx:MpMsaObm4ZuPX9Q_XYiP0_CZWgp4rXtu72wAbQTpGVjdOVxFcSSIpA>
    <xmx:MpMsaES6iO2_OhKtC1YspSjkT-FXImuqhk0pz4_idzf3EVRw-KiIDo9X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 10:35:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 1/4] prefix_path: support prefixes not ending in
 trailing slash
In-Reply-To: <20250520000125.2162144-2-jacob.e.keller@intel.com> (Jacob
	Keller's message of "Mon, 19 May 2025 17:01:22 -0700")
References: <20250520000125.2162144-1-jacob.e.keller@intel.com>
	<20250520000125.2162144-2-jacob.e.keller@intel.com>
Date: Tue, 20 May 2025 07:35:28 -0700
Message-ID: <xmqqh61fl58v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> The prefix_path_gently() -- and its wrapper prefix_path() -- function
> normalizes the provided path and optionally adds the provided prefix to
> relative paths.

I find "optionally" confusing here.  The original intended use case
of this function being that "the provided path", which comes from
the end user from the command line that names a file relative to the
directory the usre started the "git" command in, needs to be
adjusted after "git" chdir's up to the top-level of the working
tree, and the way to do so is to prepend the "prefix" computed by
"git" (which always ends with a slash).  Adding the prefix to
relative paths is the central part of what it has to do.  When the
end-user supplied path goes up e.g., "../file", we may have to lose
a level or more of the prefix before prepending, but that does not
change the fact that the helper function is about prepending the
prefix.

And as you can guess from the above description, if the caller
passes prefix that does not end in a trailing slash, the caller is
buggy.

> If the prefix does not end in a trailing slash, the
> function will combine the last component of the prefix with the first
> component of the relative path. This is unlikely to produce a desirable
> result.

True, and I do not mind being lenient to buggy callers, but given
that the majority of callers (i.e. all the existing callers) not
being buggy, I wonder if it is better to check and append a slash to
the end by a new caller that feeds a prefix that directly comes from
the end user?

Unlike prefix that is internally generated by Git, we'd need to be a
lot more careful if we are taking end-user input directly and
passing it as a "prefix" (I take that the possible lack of trailing
slash as a signal that you are doing something like that in this
series).  We may need to check and correct that they do not contain
"./", "//", or "../", for example, anyway, and adding the required
trailing slash at the end sounds like something we may want to do as
part of that input validation and massaging _before_ calling these
helper functions.
