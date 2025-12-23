Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F1342505
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497285; cv=none; b=EYqd55CKMXaeko8W5dMbqsfEHrPzYRYjNFZFh9G/ELMN0SHhgWckBsfVkCwGRmYqWQwgzURExBmEAOaulJu9Ly536oM4dVmXF1kvx3MZeofFHnXdfBc4k/Z93Mw1lzUImQg5ybev6Hh1j/WiPju3SqkmnTE08syJxyYWy6YxwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497285; c=relaxed/simple;
	bh=D2aZsleSTcVIDlUG2WENiyRmDrgglePS6/Mvmh3ds1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LcsLqBjghs9wwpelbDhn7EtO/I8TUeWQW8kWv8Yy2kD6a0Pgc7pihPsOFHWF4JXHbDhjp9o/ifJh1NUiNRkSWCylP9ZxElOdZdTXkm9nkhk7EQ94Lbb+xM8CgooIbqDma0vwoHcYbmyVg0RX2GkEXQicu5P1LP2A+n+iZCC9SjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JJqGZ6HG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M/hD2hG2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JJqGZ6HG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M/hD2hG2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 80DCBEC00C2;
	Tue, 23 Dec 2025 08:41:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 23 Dec 2025 08:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766497281; x=1766583681; bh=Mj3THcCIat
	p0BwcExAzWt4X+SeUdT7Nxmy9JBUq48GU=; b=JJqGZ6HG99J2XnHh0rBi9556kq
	qNicXKPFAt5ZR3zHgurpqVXD1EhSmP20o6qBL13++JB1hDhkODvDdgLdW1bLEUAq
	mB+d1b1MsSSKE6LMGrb2+hhUJo771owYZ5U+D53Pz7wVCY4BmzkOMayg/a9L20rg
	3wbOnqpBk6pN4plvZQASLRWMP48tUrEi/amcm9bAE82uhJajQuJemISxFWuxWDtk
	srg6U8JQxqs5LcdU/HZYYTETOnpQDOYopKqHDgmdFNKIrBNYCocMXj9cQGSBiwUS
	xus7CnpcBYXtc8TVV2nekG522TxrH5eDquSYC+UOUJqWCq0p7BOLNU/VPUPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766497281; x=1766583681; bh=Mj3THcCIatp0BwcExAzWt4X+SeUdT7Nxmy9
	JBUq48GU=; b=M/hD2hG2bOfQtqzyLwb1nHdYF+feP+g7cRnkWkPBjaLbfpe4xF1
	AXdspnFC9vjX44GzwfEHkwW7PDd4/WnNVaReAUErjxElUGXnKQy+GmVjWEBoISKS
	2VaLWmfJ0Qz8Z44ToRR59mEl/XOTGjRKLj1SB9XoSebbCalV8sNahUC2Jb/woUQs
	YxCm4/8dYvd2d5hQ4Lf4Xm9jw7egK1yhrP1FwTOmtgZSeqw904Mp+LR7MEg/gd6A
	in5ojMnb9b1T2jpoWM1h+NzenpCHFawRqaI1iVqwNMJQxvhEEeG2P4CVgXRWSRbS
	Bb4CChK6gBghnzHCPXu9GXSmhqqGJy9d6tA==
X-ME-Sender: <xms:AZxKaVT0n7tC31fpcx2GjBJnu5UzhRhGI5FzBQ8SRUXHg6V2hG-dzw>
    <xme:AZxKad16dzyA_fj0QxuYZhUAqp9TJ8qS09d7zH45Lb2U5vAlq_YVV_Rx3-6NEEfU5
    QxrBEd4tkwNnpdFTrZi5LcgGNOOS00rgUotQjzzk6AS41Q3fw>
X-ME-Received: <xmr:AZxKaRCcipRLoLJlM4fAzhPwfv8XhUPenyulRefK1loE0sE7PwNbfBoI4bnSaTBJwn97JuIb34dkR_ql61-z-zlM4JQ-5wPNgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehleeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghs
    thhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:AZxKaZjw4_ohkQy9uua3AGe0v9grSpGncHRSZXrGkG8i-_6sew5EKA>
    <xmx:AZxKaTOPlGFK87DVSAZEmjdSGY2KpD1hcIZ8jFBUFPZkM1TqV6C_Yw>
    <xmx:AZxKaZ_IpCJLG4aZYbGZGSqacvJq32vU_Md8Z1Z6Yh-ueHFknF4aQQ>
    <xmx:AZxKaUeWvyPFulXPMH-DIlqIM8sLIOHuk2qMrspGqc9fBWv_FWJSYw>
    <xmx:AZxKaYR70GNvQwyEFyjKm8AveIU5QqvfIccDDEypNxpTbyoc8YvudpGG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Dec 2025 08:41:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  christian.couder@gmail.com,
  newren@gmail.com,  Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: Re: [PATCH 1/2] replay: die descriptively when invalid commit-ish
In-Reply-To: <a5822145-5a5c-4a2b-84b9-7c061b3bab97@gmail.com> (Phillip Wood's
	message of "Tue, 23 Dec 2025 10:52:13 +0000")
References: <CV_replay_die_descr.13f@msgid.xyz>
	<replay_die_descr.140@msgid.xyz> <xmqqikdxriw3.fsf@gitster.g>
	<a5822145-5a5c-4a2b-84b9-7c061b3bab97@gmail.com>
Date: Tue, 23 Dec 2025 22:41:19 +0900
Message-ID: <xmqqpl85pb7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> There are only two callers so I think that is a good idea. If you give 
> an invalid commit name to "--advance" then it dies with
>
>      fatal: argument to --advance must be a reference
>
> so arguably we only need to check the return value when parsing "--onto"

So, in determine_replay_mode(), ...

	if (onto_name) {
		*onto = peel_committish(repo, onto_name);

... here is where we must see *onto is NULL and barf and then ...

		if (rinfo.positive_refexprs <
		    strset_get_size(&rinfo.positive_refs))
			die(_("all positive revisions given must be references"));
	} else if (*advance_name) {
		struct object_id oid;
		char *fullname = NULL;

		*onto = peel_committish(repo, *advance_name);

... for symmetry, we would want to do the same.  

In addition, we probably would want to let the following code that
uses the same *advance_name (and requires that it just not names a
commit-ish object, but is actually a ref, which is a different
requirement that is probably a bit tighter) ...

		if (repo_dwim_ref(repo, *advance_name, strlen(*advance_name),
			     &oid, &fullname, 0) == 1) {
			free(*advance_name);
			*advance_name = fullname;
		} else {
			die(_("argument to --advance must be a reference"));
		}

... first, and then compute *onto after that by moving code a bit,
perhaps?

Thanks.
