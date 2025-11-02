Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6770810
	for <git@vger.kernel.org>; Sun,  2 Nov 2025 03:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762055919; cv=none; b=Nlp90jtbGviHQFKB9frus1MleYlQmfxFf5hhaxwLKeIje7q8ZRRlQgl9OR/IBhi7K/TLpTtbu+PMPdEum2n8bADt+4nnSLVCHnVnIcB/QfZRgRAMS6ij+S/raS/wFGZMFuTGMMVghmQoJR5emOdOkBooo3r+u//RhhtCtIZczUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762055919; c=relaxed/simple;
	bh=37mdxYNpc4wC57SsD5u713bb2jHy/QxpPphRDCBzLoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UWuXEZrCJSTmyB+zoFi2WpGqjezzTJfCJwdxu2UvnRo1Az1NqII7R0TCKtuKMfpt0WrbuZ3ZRFmXT2cArfdTKMNvT/OEbKI8SWeIztUh0nYHBUbqXzuFCObZDyK1Ezh44sWBP9hKguVaaAiJ1LRMCatqwvgvs8P701/iUWdJaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OqMhgf67; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JzseKZME; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OqMhgf67";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JzseKZME"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B91A4EC01C4;
	Sat,  1 Nov 2025 23:58:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 01 Nov 2025 23:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762055915;
	 x=1762142315; bh=c35q6h5zCOXtN1PaaP+KoNyeR0iRSXe7Gx1FD18FnU8=; b=
	OqMhgf67ZODqk4mtc7SFLWr0WZC4Yumfhw63H/ov7t+rusMezOMONf+k8gs3RBcD
	pSjMN25ac2RWPZezBOfBlolxG5I/8mE2WEVb05F67whSC++IU+72Idk+Gf9sjtH/
	sAF+fxNUO5PSMFTW6U/z3n8hxnfPC+NyRyrupPNyXAa2DzRGgZYtG43SgBIn1I1z
	bf5Hw7l/OGT1QyshWrDfY4Z87WTwb084QhtdVEru96EvyV+ps+HkVgKWdnixm3al
	rmmsRq/oYiS+Nufku8MMkhVGJYwYe0BiWy66yxuZMZLU/fkYBYHR45dKijajwCY8
	wFL2n3DP9nSxeqsXaE+Fqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762055915; x=
	1762142315; bh=c35q6h5zCOXtN1PaaP+KoNyeR0iRSXe7Gx1FD18FnU8=; b=J
	zseKZMEXZagmH3PkAoflYcSQt7PI0k/8ibMUnZ6BCPZ8AhyoH6+bWqvK8cyqridE
	unDfSFoG8GyefH87oZTAJtdwTyPHjr8YmRajLQuNa/DQWEWq/+STgBmWRaPZVsd7
	tl7PkGDCBdFlnHB6gfd6vrZlQw+ZDdZlkUkNQ2VtwYYH7IrYSu/Kw/6cmI81iGZ1
	v7IvUlOTT5CB83qTd7lfKJlVuBP+XWjaaYtHM54eIYLB3uQFXsbyncFGZZzAF/GI
	DePwteEWWJpCsf49LXPQ74SoPMuxQLvPxh/RmmN/7ZtfG9WXJS36IHsDiTRwquho
	er77AztySsycJ2cJKsorg==
X-ME-Sender: <xms:69YGaXV7UHZajPMbBwcteyQgKwBL5zlkKeVrESWiUztjCX7fj0zXMw>
    <xme:69YGaRHZrHpfLUkVxwaF8mwIGawqXHVWOmP2kNAVpPur50SuachUh5qS6Azi6n64B
    cYkd1zoTmckRT3uVESaYvKPimRfYcMbzj5fVgXCmSZA11eATDnjon8>
X-ME-Received: <xmr:69YGaTdvX5UQcHVLvjHNjtNsZvIWBZ6B9nXZI1a6GIm9FhYwoOk_wriAYwGfwe8lGHMnQaqFHhCCvtJMQYzpHOSwbFYvtZltlKr5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeegvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhu
    ugihkhgvihhtrgesphhrohhtohhnrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepohhuthhrvggrtghhhiesghhithhgihhtghgr
    ughgvghtrdhgihhthhhusgdrihhopdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:69YGaSIePpSVbdhyeRrqD_5xfrM51fVTRmkbsij-_I4FAIatUf1Cgw>
    <xmx:69YGaYGoFoeShAC7fDAeVHRqbupyd-xViIB-7qvQf55HAxk3GwF2Xg>
    <xmx:69YGaVDmZgyg38-p22XgOpJlZr7qgnhisiWfcGUc4cw5EDQpBGKmKA>
    <xmx:69YGab9KP7VH2hL6osNQjORY_M4wFmjbp85PJDXQy3kZjZ8tFRtJ9w>
    <xmx:69YGaVITfEZgfhAx9ubOJMWQGjdY-8I-mlAvOufiw_zz7KQuZMcDB3Wv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Nov 2025 23:58:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: keita <rudykeita@proton.me>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  "outreachy@gitgitgadget.github.io"
 <outreachy@gitgitgadget.github.io>
Subject: Re: [PATCH] fsck: use starts_with() in fsck_commit()
In-Reply-To: <CAP8UFD0CqC2tgERkPHuoOPO2ON9NNw_C1R-6UpBXjpgYEM8yxQ@mail.gmail.com>
	(Christian Couder's message of "Sat, 1 Nov 2025 15:59:43 +0100")
References: <q4heOh8stc94r_P5mX-tucCyqQ1JdGP2dJ9Dot3WTyDboRWsboWMAIoCQIXuyuRvNRmN5AGQYjhmAnjuxgOXNooUDjPAEEvKPc2k_DCDEtY=@proton.me>
	<CAP8UFD0CqC2tgERkPHuoOPO2ON9NNw_C1R-6UpBXjpgYEM8yxQ@mail.gmail.com>
Date: Sat, 01 Nov 2025 20:58:33 -0700
Message-ID: <xmqqseexw0eu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> Hi,
>
> On Fri, Oct 31, 2025 at 11:01 PM keita <rudykeita@proton.me> wrote:
>
>> From 30136adebaffb97edacae2c58c4ea491e39e3f5b Mon Sep 17 00:00:00 2001From: Songiso Cooper Lyambai <rudykeita@proton.me>
>> Date: Fri, 31 Oct 2025 23:45:23 +0200
>> Subject: [PATCH] fsck: use starts_with() in fsck_commit()
>
> If this is related to Outreachy, it would be better to put
> "[Outreachy]" at the start of the subject.

Plus there is a lot more important thing to be said for this part fo
the lines that you forgot to point out.  They should *NOT* be part
of the e-mail body.  The Subject: header of the e-mail seems to be
set to the same as this line, so the sender only needs to delete all
these four lines from the e-mail body and correct the subject.

>>  {
>> - struct object_id tree_oid, parent_oid;
>> - unsigned author_count;
>> - int err;
>> - const char *buffer_begin = buffer;
>> - const char *buffer_end = buffer + size;
>> - const char *p;
>> +    struct object_id tree_oid, parent_oid;
>> +    unsigned author_count = 0;
>> +    int err = 0;
>> +    const char *buffer_end = buffer + size;
>> +    const char *p;
>
> Here also I suspect that the indentation changes are not necessary.
> They are also making it ...

Does the preimage even match our code?  There is no C code in our
codebase that uses a single space indent, so I would not expect
these 7 lines of preimage to be found in fsck.c or anywhere in our
codebase.

Hence, another more important thing to point out is that the patch
would not apply.  A suggestion to the author (and other aspiring
folks who want to become Git developers) is to

 - Send the patch you are planning to submit, but not to the list
   but only to yourself.

 - Subscribe to the list and then observe the traffic for a day or
   two to find patch e-mails from others.  Find other patch e-mails
   from each of these people at https://lore.kernel.org/git and pick
   the author who is highly regarded.

 - Compare the e-mailed patch you received from yourself, and the
   one you received from the list written by that highly regarded
   author you picked.  I am reasonably sure that they do not have
   the e-mail headers repeated.

 - In your clone of Git, check out an appropriate target; if you are
   fixing something, you want to use a tag that corresponds to a
   released version, if you are proposing a new feature, you want to
   build on the latest released version.  Use "git am" to apply the
   e-mailed patch you received from yourself.

We may want to #leftoverbits add something like the above to the
MyFirstContribution document near the part that it teachs to send
patches.

> Please make sure you send patches that don't change the indentation
> for no good reason.

A good suggestion that applies much wider than the indentation.
Your patch should not do anything related to the theme of the patch,
whcih you explained in your proposed log message.
