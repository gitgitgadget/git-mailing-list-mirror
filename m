Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4831C2DC331
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115193; cv=none; b=LUTGaglvAR8Ds4s+GUL+ENiZy2q00flGPpiGuczGURLVe2fmWqGRYeEt9y4l7pCB4kDA5xdZzlShmobPnM2D08P+SSNGl/eeQW2iQGg8QXpMToV78eFHxeLdUcfBas+X9DtKyX8uYCth+3jKFDvxWUSad+LUaZoF/QCwDrTqG4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115193; c=relaxed/simple;
	bh=c9YHR2VCFNL7gXxHMoWt3y5PSKPRTQZEUQ5k6dndaS0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CY6Qt6BskFdOmuPF7z8+2pi7SiXKjghrYHsDnKDPFal7dJP6eFOvYk08HTHztjtRZjL5cWkliwN9/RsgiwBxdkkqOKDdY+HJja3MvCAP/4NanSkTse4SQ7xTtCYDBnUJfjJMDXhjwaIQvAAkSzzELtomxQyhTD2+4iPBzd6EVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rZl8Ecmz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DTAtjxXm; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rZl8Ecmz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DTAtjxXm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B6AF14001B2;
	Mon, 13 Apr 2026 17:19:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 13 Apr 2026 17:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1776115191; x=1776201591; bh=9H2mCKIODtI3JziZDLloJuNgSSNh4uJV
	sJ7AgKwS+TA=; b=rZl8EcmzVzhAEiPFAND1k5j+S5Hk6Y85tOq78N+JEaR+JT9N
	v96vKUs28rbOKxpfwKFvfX8pYHP4s6/xrXMFt4aj+kRbYJSDK6yzOPvxLNJh8Vg4
	lQEeAUUEicu/HZTHz709h5MT59D7iEvvqnIs2kAr0Aa+ScK0G9lOI8oqIzq4DoJX
	GZdnz82wjmgL5ogmdeyiELovX1yBeK5xWUIINH3U6nixXsaZFKu7HLWksV6Fka9X
	IwsPN/t+QjJTdau3IJUiB6DEkWtkBGCgNg6EJUkW6Y5eVZ7R7HGQ/ivhVObs6PJg
	T57aQByGimpRv0piTIAU8yXqMISxLiPx3JYwZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776115191; x=
	1776201591; bh=9H2mCKIODtI3JziZDLloJuNgSSNh4uJVsJ7AgKwS+TA=; b=D
	TAtjxXmDDt5/0ak0wjd9AG1ezMYofW2btqb8W4RAEh5TtVEUpzQE07QVzstUlxrz
	VV9d53oXBEa6JW18CiYIDt0us6UvpACN3eceA/WyZWqylha7+2TQz3AEXUjqCAXa
	WYcfbthdDr6OeUZlp7cvr2rs22li0ZD++eznITvLCowicNpYQstKlGMiqurx3WmZ
	FH0svFiQRWihweTyy/fuja3lOcMdYe0hOLs0E7oVlPCKvS1zyg7OPUHR671c/8e1
	lrpW/HOOek/FWgXCaXv3utJboztedddHffTsO/Mq54m8RSeEOwtrDkdJTePKSvYB
	ypqDO5En6BMofnwVleUyg==
X-ME-Sender: <xms:913daaa5EXAC9VMj3Gx4ci2o9NK19KYgkaOLUcvyhP4ih_QuxTvQVw>
    <xme:913daTbP8pXEsUw4SRnto19CXstwfpGgjk7Y0zYNypKL37w8Z1bjMdLcMP61wMB_b
    fDbP7eOviCFQo1AotDSXt8MjKVz4dmtaiwLqvHp1LYIOYyDiQKJkQ>
X-ME-Received: <xmr:913daSm0nQyLx96DWKj0S473JUDTGu7ATsu-zwDMckptM14qf2ccCdiYyHqkiB8lexH4VOUjmf4pcyZ9WOccPoxK0biyq1BXzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefledvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtsehttdertddtredtne
    cuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohig
    rdgtohhmqeenucggtffrrghtthgvrhhnpeelvdeftdeftdekfeeuveelgfelteeiueffff
    ekhffgkeevheekhffgteejhfffgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtph
    htthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:913daXzUqNoKkKnvhbF06wS6hFpWlQIvAEX1O9GbsgkiKJK0VhjmwQ>
    <xmx:913daYNe4BzBkVOUazgbn56U4Djbrj7qsYAdyv8bLm0YUoHpWg0alQ>
    <xmx:913daTTbzTiqV11ZZrEfxXCPef7z4ed9-go2baNJZ7-4_DAnEgXkTg>
    <xmx:913daea_GypGNnjQZ3bIC-dz4H4FzY25jtecPLUot95LvcYpaMcr_w>
    <xmx:913dadySclw6ZzeSmBUulcVlBGenZwIAqRdw00N4SpQEVsBrU6XkAt9Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 17:19:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFD] not grep but not log -S
Date: Mon, 13 Apr 2026 14:19:49 -0700
Message-ID: <xmqq4ileh822.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

If you have a series of commits that record the contents of "what's
cooking" reports (i.e., "git log origin/todo -- whats-cooking.txt" in
your clone of this project), and have a specific topic name you are
interested in (e.g., "jc/test-set-e-clean"), what's the easiest way
to find out in which issues of the "what's cooking" report the topic
appeared?

   $ git log -Sjc/test-set-e-clean -p whats-cooking.txt

would tell you when it appeared and when it went away, but does not
mention anything about the (potentially) multiple issues the topic
stayed in the report in between.  Git being a tool to track contents
but is primarily used to track _changes_ in contents, this may be
unavoidable, but it is not very satisfying.

Looking for the string in each and every version, e.g.,

    $ git grep jc/test-set-e-clean $(printf "HEAD~%d " $(seq 0 20)) \
			whats-cooking.txt

may give something close to what I want, but it makes me feel dirty
that I have to _guess_ how many is sufficient.
