Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1920B16EB7C
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744725133; cv=none; b=Z0jTuz9YsmZNkMN1CuWhsY725f+s3W4F1p+1KphCYokBD/bRMUNsvK8qyv2uIly57gYix0WT2KLS2nRikcldLreYwOq9AvxIfNilQmoI9hzC/oDYQZRyoPQyAOFZyS+SX+k0jyidtaWI5ux2pCezKfo4ZL4xxDAZIUnI35uhjiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744725133; c=relaxed/simple;
	bh=6IywNmLsNdvn6bZknmDW64AaJdmwtYDgTADYytGG/18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OrYQHrR49dM2kq6oa1YmIVKuSk8/rIU+r0jdGiegDBENJmNsxyJaJV5xS0WvtvfzzYji75aTnmjyUfMdf7yatq17WsMaQBeqX1QkGZUrkqbZKD3hRvmrbq5jsjGH9zhCgRDs27x/u6YP7NnrQAqtPkIA6X2CSYhtnMZ7bSX/tUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fp+NWbMD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GYhQByNc; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fp+NWbMD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GYhQByNc"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1AB7C11400F5;
	Tue, 15 Apr 2025 09:52:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 15 Apr 2025 09:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744725129; x=1744811529; bh=VviUj4hADs
	D8qQC9KFhfDzO7NsQ1Ufs0dIL/FvLQLss=; b=Fp+NWbMDMNl4Q9CGumHlthEx+Q
	883ZCMI7ja8v5FfzRb48aPot+rbaC92M/nqQdfxY7aKDUoLAFVB9PDntuFpJ4XE4
	BLoeaiu4AaySKVn7fWSzoJa6TgKBLXx4TMBbuamZt8kvADc1d17dhYh/hScI9r/H
	d6xwm6WOBOpZJcarg4x+mjEDQxmSbxnGhxTMc2sNHII6YJPay+zGNcujC4sr2TBq
	n0BCdFMs9OMaiB9Y2msW5WwnFSwIjWHpOrQpz2mEcvHaYndqCg2H+wEBGOxPdRUL
	EGY7jCAD7kUDxrph+MrgH9Ze9vjctpWF4XExG6OV33j0EmLUmbJsINKXAW6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744725129; x=1744811529; bh=VviUj4hADsD8qQC9KFhfDzO7NsQ1Ufs0dIL
	/FvLQLss=; b=GYhQByNcgvVX/6y0KyaUEyrF9cHt01nxE1m/s8ZbATI/xF0KrRF
	sAnP4iJX1NbaZWM+CEPcvYB6r7nTD3XvuFE+nJQagIJeF5YgK2aI1QIWnMKwwx3K
	cD9YQDtIQNCh4ecjQhnj/6iKlR6zlI001Rds/a7MSPODxev2vafImVvcnrfkb+lD
	exspRPorkSzKv6fwJFAFrKGCVMsoMmnOXQjkOoAgdwrDHzy5jUuXzk8SFmjJ5Qn3
	5CRNJ5EVZKyBnZ1EzJISAtPxvnYKW/Ly4EfEOmuM6HTbhZQG1UwC4YY5wpUj69ye
	vzF1zREwNX/Z6PDm3Bj9oFb/Ubo/EVEuOTg==
X-ME-Sender: <xms:iWT-Z_qlPusRrLRYkAfX7srmlx9bvQ9DPySn-Q-qe399NAW8AQbCIA>
    <xme:iWT-Z5pjOYnvCrK0aZIDVMkInhkODfcm3N9nX0pEd8LVSnBEKME2pJPnJmf4iyEYK
    WZv74kvb3hkUyiMuw>
X-ME-Received: <xmr:iWT-Z8McRFKxCeMTa4JMDb7yQ4F0uRnN7PyAOvtJjAQXnDXqHO56GfMl2LBnc9agfhAS7XkaLS4Myrt7de3HrhNJ0axHefB59cIi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopeihuhgvleefjeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:iWT-Zy7dfhvpWKzrm26qBh7m2RFXy_DqfRmsGsiPPsRqA3hEL_1-Yw>
    <xmx:iWT-Z-5EZ7Zwp0UGyeF4htLoUuNmW49SPTJH0hCFcaVIBkyGPEE3UA>
    <xmx:iWT-Z6jJNOJCO6aOJBSAlEqpGFyRj43nmtueTzHmCEeuX2uasdiw4w>
    <xmx:iWT-Zw5eJMeyVo1ySJeMQ_ALHvwsTWUuXvKzuOGtg11u_rrsUizveA>
    <xmx:iWT-Z9WTca_w3f-kRyEBfeHH2zgUiKuUFOy3ORtZkIkclRj8csQHjvLh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 09:52:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: mu gsh <yue937@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git merge bug report
In-Reply-To: <CAE8aReXOwM8ByyObxrb8NhRMYfK1OB_6B9eOO07mYXMkp_E8EA@mail.gmail.com>
	(mu gsh's message of "Tue, 15 Apr 2025 20:23:30 +0800")
References: <CAE8aReXOwM8ByyObxrb8NhRMYfK1OB_6B9eOO07mYXMkp_E8EA@mail.gmail.com>
Date: Tue, 15 Apr 2025 06:52:08 -0700
Message-ID: <xmqqtt6po7lj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

mu gsh <yue937@gmail.com> writes:

> cat > models.py <<EOF
> class User:
>     name = "str"
>
>
> class Product:
>     id = 0
> EOF
> git add models.py
> git commit -m "initial: User and Product class"
>
> # feature1
> git checkout -b feature
> cat > models.py <<EOF
> class User:
>     name = "str"
>
>     def user_method(self):
>         return
>
>
> class Product:
>     id = 0
> EOF
> git commit -am "feature: add method to User"
>
> # feature 2
> git checkout master
> cat > models.py <<EOF
> class User:
>     name = "str"
>     bugger = "fix me"
>
>
> class NoMethod:
>     pass
>
>
> class Product:
>     id = 0
> EOF
> git commit -am "master: add field to User and new class"
>
> git merge feature
> echo
> echo "==== merged, user_method into NoMethod class  ===="
> cat models.py
> ```
>
> Actual Result
>
> After the merge, the user_method ends up inside the NoMethod class,
> which is incorrect and unexpected.
>
>
> Please let me know if any additional information is needed. Thank you
> for your time and help.

I think this is very much expected, unfortunately.  Git is language
agnostic in the sense that it does not know the meaning of the
contents of the file it is thrown at.  With the merge, what it was
asked to do is:

 - The other branch, "feature1", added three lines, an empty
   user_method() definition and a blank line around it, before
   lines that have 'class product:' and '  id = 0' (or after lines
   that have 'class User:' and '  name = str' followed by a blank
   line).

 - In the meantime, you added some stuff in feature2.

 - Please replay what the other branch did on top of what we have.

But after your feature2, the precontext lines that it can use as an
anchor no longer exist (the blank line after 'class User:' and '
name = str' is gone). while the post context lines ("blank followed
by 'class Product: followed by 'id = 0'") are still intact.
Wiggling the added three lines there would be a more natural choice
than having to deal with "bugger = 'fix me'" whose disposition is
totally unclear to unthinking non-mind that is a mechanical merge
machinery in Git.

