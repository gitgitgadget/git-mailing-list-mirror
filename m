Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9C71DF258
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750872736; cv=none; b=GBHlVbaFIa1BmRpbutrgjKLwT5LIrh1kOCGp8zdXwcIL++eyzcbxTee8ZgRNrqrzX0vIXawahcws/apnlvbquqTdsUHujmFExKnp7jxMcfvtRxj88vjHi2v/SEeqqnbN10wx8mxFVeAhoyg3MSTpHyi7cSfHnbmIoJJMsV0peXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750872736; c=relaxed/simple;
	bh=q2PAHpo9uDE6wmRcZ1v/QFujlRh6YseaRBuh7nK/ywA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JDgSu/uVJC3VoAZraXluVAPq34U+TWluT8x/8xD88zJe07blhsf+je262TwYnvya7AO2MogbnoKDYiYuWQK3MWWtblrhvPZhGy3Rw/l6a6R2+AIgtgoVHpqOs3kI/AssR03sYFhnYFe+iDxK0bSkfVMVVA48sCxDo8QS58eTTQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HvnkNsDo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bgVqrUa2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HvnkNsDo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bgVqrUa2"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E494EC01C2;
	Wed, 25 Jun 2025 13:32:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 25 Jun 2025 13:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750872733; x=1750959133; bh=rHBIahAe9l
	cZ4AhTNbZbKKymQycrGVV90AgWSQdbqF4=; b=HvnkNsDoS+nGRw4hssuInfZyrl
	0b7CqB80c0x7gZJmUPfNIgDzBYcpvemnbq4sJiCdOBYmiFgo3afUE5wy2Ff7HOSF
	H0sJxf5DvdyAnxo4m2ChfWRiIk/jwMXao+4DmFhC7TWZFdSRTQ2B+vZKXNE/g2ge
	6H+71yEX+JYAa0P5R0krHuoawivmthUGj6I2LLSqdml9bMnls9Kxe0PTqxR2mEcC
	ZGlKq6mLJORGbXhz1Bz13YzuT+jx80zMANWXDybuSCs0UCdoWWwLPbx4/mNlcE52
	tuBncMtm5YNy7otQsCpbOj7TZClubstZFplrT1HB1fL/JOzFzdSUSk1Cd04Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750872733; x=1750959133; bh=rHBIahAe9lcZ4AhTNbZbKKymQycrGVV90Ag
	WSQdbqF4=; b=bgVqrUa2pAqUMVnIwaPqh8TNKyWhsbsCJXx+xdYSmmmn31BxWqh
	vs6fnYycgwBgMTVjKJ0gEwdAA/tdDVOBMR/Qa4r+5ctTLo39hMfbjefm08cLPb9C
	soYvMLUrv90wzGdC3XGiXudrd0TpDFExreUIEykFnN2bkE+IyGMJDfOfFjS507Q5
	7Zb65mhT/EiawtmF51AigxHRTF8VAwK+xRx1RlqBdkWsSnA11qHURs/dTqdI9cRv
	nB5tiS0XahCl8a7e4a//ci5r+F9gYWIxzFyZ+fnM/6cqDadlOF0tuNxVJRMYTgjV
	xiuJbz6A39B94yJTs5kYOOpuF7D03DWAfFQ==
X-ME-Sender: <xms:nDJcaFb4ncNoyPMPn6nieGMmZ_JexNqRShphn8b8cenirDK5sGaJlQ>
    <xme:nDJcaMYcngKta5xvUMmYY-L_sZ0fl8HZ6sjX5yXpphUUcazLt7vbEhkBjziuYBz9x
    OdndqQTByotPKBurg>
X-ME-Received: <xmr:nDJcaH98FF1TsFSRNiyu-4VPaPdtb7_PhObPUHCrDDaXK6B0MM720guQYHvbzqWBSiOVWqHwj3R81QIsSYEu1qDZ_8qgg2wKPJVfZOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihlug
    hhohhmvgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopeehtddvtddvgeeffedttdehieesshhmrghilh
    drnhhjuhdrvgguuhdrtghnpdhrtghpthhtohepkhgrihhkohhpohhnvghnsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nDJcaDqIijUmii98SclBZuqCt6Fu2IURuRRMiocE4FNzywlYcWVNrw>
    <xmx:nDJcaArhG2Dky0tvypuS1kgxITB6r5NLK3uGWwegOOX6DInrWN99aA>
    <xmx:nDJcaJRpLJrZJ4Se8pk7RtJ6oURDU1gQp_DZgsECW2zuYV-MQSBmtw>
    <xmx:nDJcaIp90aqucNMV9GtxDF2wvz1kgbPqVRH-xmzFXqirtYWNSb_Jsw>
    <xmx:nTJcaN7uiUv22nYV3PYC-G1c4m5S5V3L7o5al3xgkQCX4xGvHZOUQBeR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 13:32:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>,  Kai
 Koponen <kaikoponen@google.com>
Subject: Re: [PATCH 0/2] bloom: use bloom filter given multiple pathspec
In-Reply-To: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn> (Lidong
	Yan's message of "Wed, 25 Jun 2025 20:55:39 +0800")
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
Date: Wed, 25 Jun 2025 10:32:10 -0700
Message-ID: <xmqq7c0zviat.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> git won't use bloom filter for multiple pathspec, which makes the command

Let's get the terminology straight.  A pathspec consists of one or
more pathspec elements (or pathspec items).

Also, "git won't" is overly general.  The series title shares the
same issue ("given multiple pathspec" does not even hint that this
is about revision traversal---you are not making filter used with
pathspec with more than one element in other code paths).

Perhaps like:

    The revision traversal limited by pathspec has optimization when
    the pathspec has only one element, it does not use any pathspec
    magic (other than literal), and there is no wildcard.

    While it is much harder to lift the latter two limitations,
    supporting a pathspec with multiple elements is relatively easy.
    Just make sure we hash each of them separately and ask the bloom
    filter about them, and if we see none of them can possibly be
    affected by the commit, we can skip without tree comparison.

or something along that line?

>   git log -- file1 file2
> significantly slower than
>   git log -- file1 && git log -- file2
>
> This issue is raised by Kai Koponen at
>   https://lore.kernel.org/git/CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com/
>
> To fix this, revs->bloom_keys[] needs to become an array of bloom_keys[],
> one for each literal pathspec element. For convenience, first commit
> creates a new struct bloom_keyvec to hold all bloom keys for a single
> pathspec. The second commit add for loop to check if any pathspec's keyvec
> is contained in a commit's bloom filter, along with code that initialize
> destory and test multiple pathspec bloom keyvecs.

It is nice to outline an approach to the solution one day, and see
an almost exact implementation of it appear on the list a few days
later.  I wish all the development would go like this ;-)

>  bloom.c              |  47 +++++++++++++++++
>  bloom.h              |  14 +++++
>  revision.c           | 121 ++++++++++++++++++++++++-------------------
>  revision.h           |   5 +-
>  t/t4216-log-bloom.sh |  10 ++--

Can we have a set of real tests to make sure that the updated filter
code still identifies commits that touch the files without false
negatives?  False positives are OK as we will follow them with real
tree comparison to determine what exactly got changed, but false
negatives are absolute no-no.

Testing to see that the filter code path is activated is much less
interesting than the filter code path still functions correctly with
these changes presented here.  I have a feeling that with the
changes to the test in this series, you wouldn't even find a bug
where you simply added subpaths for all pathspec elements into a
single array and use the original "bloom has to say 'possibly yes'
to all array elements" logic (which would incorrectly require that
both file1 and file2 must be modified).

Thanks.
