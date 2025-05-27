Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9055126C02
	for <git@vger.kernel.org>; Tue, 27 May 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358260; cv=none; b=YZRUcRr80M8mn7GJxJwj4+tGA8KDnUlz81NVwTPUBFLq3JoE+DdzFITDq6NpMEWqKkIFVnT49cPJ8EpQEwrhhJz9bNBjDaFKvB5yODJn2yZGi5LPnrJgozc30XPFPFv5ngxaMNrr4t+DDzJr59ZzAOcqYbPT/Sx+LB17UhoTtYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358260; c=relaxed/simple;
	bh=r1Z07ou4ptnVzkBtC51g6VH5hHE1wDrALQc+K9VQiTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L8G9VaNgnoPIfjhggkh8EaOXNTBX3iwueSuY5aYmcjJbK07mIJAyysuzcXj/ZETvUQBPDZR+tt2IJKqVMSBsWtgJui56qJ4MXHLC5PWPdu8OO8u4DKiVRHxQ8mnT+19Vzn8d7/Sui7NLAaoDJBD7PU+9vYPiRBDEEEHL+dcZKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bR60sq/H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZuTiXjfU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bR60sq/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZuTiXjfU"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id ED8F21140126;
	Tue, 27 May 2025 11:04:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 27 May 2025 11:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748358256; x=1748444656; bh=rpZ8uJpcWP
	7M1TSMot6X0d4TZvBCiKHT/f/fWHPepnM=; b=bR60sq/HX67IoP994alF1Zogl9
	9a/vP4nG7PAzLZOJ1DncpPk5BfJiS2Tj5mfu+CWH9d7SoVT6yUmHbOrHIBVTlcn3
	eWsQmoR9kueoZky2G9XK7I6I75PRmqPX13D5OmD0WjqChDZscxISIt9puzVVnzuK
	KtrMZJwhwKvTWTSk1OQS5dyRR9x/A63wybfWrgKD2bdyPFBQYpeuJAOnMy+5W6ta
	k/GIJwwgtE38A228gRH7sFyGgyLSU86LLg+mMYk3kH76r8dpEKEizc0Om0Denti6
	/aKRPDgACc7+pGhi8yHEJfwCaLwTt9lwE/spZhXAlQ9k3H3OH2+QuNcdSzjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748358256; x=1748444656; bh=rpZ8uJpcWP7M1TSMot6X0d4TZvBCiKHT/f/
	fWHPepnM=; b=ZuTiXjfUOFr4DBI8AY7aHg+iVGSwUQiIF3907RiTeEqiLwVo1/F
	6XkiNjm4RuvBC2u6xFcXXiGItvKSK4YeynGI+bAu+GOoFEG05MpaHUu9lT9zsbVJ
	VpdSZS/eafIX93CGcHPy0R/UunfQzfLJhtySrWB5RrJfTXWizzhwxdWPQkVY5qGL
	7VpPbeu6IYbOhv+7uOc6scU87KZnoD/Us75nRH67i0XoooUV+yG+wPPCidqZrbmS
	g205+IiklK06Ja6h9bUvIJrwuagzpyYKEhpa/Mh2+baMIZfgrLoTkJmWgBMZ3Qlw
	XZQLVsl8eZGsPb8slRTc0WOYozBfsCa6Wow==
X-ME-Sender: <xms:cNQ1aFFPqPtyVEFlfIzw7GCnFCXelxXi5fdPO4_Ss_EIjovriRFoLg>
    <xme:cNQ1aKWnjgILjgVSH9aVfywKnobOa_GQ7CBWtXdrUXzhBqByDbt24dx9HNucIarO9
    Iir0khce7jb2JX6uA>
X-ME-Received: <xmr:cNQ1aHL319oK2RBI94TNJNjSPvsD15M_bEsQvVy3TwO_AMpM1nqdGUs_Z_tP_qUMcefmtlAjzTi7UNrcYfpySO1nlSFN7m8CV10xpcE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdeileculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomhep
    lfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqne
    cuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefg
    gfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtg
    hpthhtoheprhhoughrihhgohhrshgutgesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:cNQ1aLEzQHRdVdENvikG-ZyWdcnj-Dis38t31-M-dJMiCYzxRhw7Dg>
    <xmx:cNQ1aLXMNo_b7y2tDUkD5yKw76AhGCHFwuCrIH_bnXpyEgsv9qk2GA>
    <xmx:cNQ1aGNjAmTci5OF4nirVy4tM2HyVHChFuk0voHI7qc4dWbzRuVaOQ>
    <xmx:cNQ1aK3UMKZs1_yeIwjoxwkGjuvo_mIaN_e_134QbBXHMOawFSukIQ>
    <xmx:cNQ1aLo6HBNlDTBqVsPibYu_Ew6a3YyiRGtPjZ-zGIAoEqwTY67z1kgN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 11:04:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Rodrigo Carvalho <rodrigorsdc@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] userdiff: add support for R programming language
In-Reply-To: <385d7189-98fa-4863-8bcf-905c76eccbc8@kdbg.org> (Johannes Sixt's
	message of "Mon, 26 May 2025 07:57:33 +0200")
References: <20250525210236.116342-1-rodrigorsdc@gmail.com>
	<385d7189-98fa-4863-8bcf-905c76eccbc8@kdbg.org>
Date: Tue, 27 May 2025 08:04:14 -0700
Message-ID: <xmqq4ix6rt75.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

>> +	"^[ \t]*([a-zA-z][a-zA-Z0-9_.]*[ \t]*<-[ \t]*function.*)$",
>
> I wonder how useful this is in practice. Unlike C or Java for example,
> code can live outside of functions in R scripts. If you have a script
> without any functions, there would not be any hunk headers. If you have
> a script with a mix of functions and code outside of functions, the code
> after a function would be attributed to the function. I'm not saying
> that this is bad, but just asking if this is part of the plan.

Isn't it the same as shell, perl, python, e-lisp and perhaps others?

If we can reliably detect that we are outside of any function and
set it to an empty string that would be great ;-).

>> +	/* -- */
>> +	"[a-zA-Z_][a-zA-Z0-9_.]*"),
>
> This singles out identifiers. Every single other characters would be its
> own word. I'd consider this a disimprovement. If you are not prepared to
> provide worddiff patterns, I recommend to use "[^ \t]+", which roughly
> amounts to the default behavior. It can be improved incrementally in
> later patches.

Good point.

> Please squash the test cases into this patch. Don't forget to test an
> indented function, and while at it, test a function definition *nested*
> in a function definition: that documents what the expected outcome is.

Again, good point.

Thanks.
