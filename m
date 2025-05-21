Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A028FA91
	for <git@vger.kernel.org>; Wed, 21 May 2025 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747857160; cv=none; b=NMzRxMj+Y2WZOCccBv/IgCxxJhdH1lmlcYvW+rShqmYPaNsbC/5m1WdnZP0q0xx1kmLGPAIlRP0DjdXoIf2piAd+vNYBbKx+0iMx5sRVFJLG/z3sgZlkoAyESA6Cdat3CbCGoNsXEsG2EEm+VZTC6z5Vzh9fMoCBHpDeOy+E64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747857160; c=relaxed/simple;
	bh=dgmQD5Bf0gbhHwOzZybaE0oHLwH0WVN9LJM6AjLKMJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i7Ry7Bi3Dww8+SQ8X3ell7gjSOpI78Od/eWE+O8Ixk58elZR7AZgXU2ZcMzJywljvCB7bLWKjRF75WcAbaU/xen4m8PZOf1/KEPaP3viqlJUgFemoEYiUlGagxluJNyGRpcb+IGmyz4letCqNH3J+dv8fTukhm6KNMgH0NFX9xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CSg7UOg+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BXyF0Y5U; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CSg7UOg+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BXyF0Y5U"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B26F71380412;
	Wed, 21 May 2025 15:52:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 21 May 2025 15:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747857156; x=1747943556; bh=qj79tZliZo
	TIUepA6znNJdHV5qalbvDoV+xwXh9juZ0=; b=CSg7UOg+mH7TZ8lmnCDXIST0Z5
	TqC6vq5T21v5rRj2E1HQVKS4UVeN+vVSDVJwpus25Z7d/ij5+3rbVqJvD2/FMegz
	JYLoZ6XiT7Yu+qszkxiW5cyT9cP9zABMcnlo8sC0HLLAxqj99woFUwbfHyVT2TqI
	oLGOOXaiKeBNYBsO3uo/J6CvDubYQfZWggcTk68NH41kdTicq9NAZpnUD//IMVQ7
	FW1F3n6fuVa8CK51hzWI/BrbXcc/Poum9dkvqkQFz8HcGe4OzjLk8CbudnmK8mnW
	DjlD+63kLiEEdtehk9zw9OVhPQJ9pOH0aFxxIMACLPEx3LcH0bVsiufcEDwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747857156; x=1747943556; bh=qj79tZliZoTIUepA6znNJdHV5qalbvDoV+x
	wXh9juZ0=; b=BXyF0Y5UW77ibjD9yCrmT7aspjMgwZjz5yFkabtm2jaTcLBGZlx
	2O1T+XUZ5HU/hXs1+l9pfceOzgT5gyoyIFA32POfdlkEYkcBDGqOQQA+SA0VoCqo
	OVy2repcMzlsBKBWIdwqsLgp0dRqe4pbGb0t/HPcaO8Lxd+7hEcYavoiocCSFpx8
	2vmbbhgm/DuM1WfObZfq5DrEyThv8NRA8TDHljLdCQn46uwecaCf4dH/wc/rIJvr
	IS8nmSeCmdhrn4/Aw6mDhx4N7WOfERVLlhILuXHIRAoDHYqTHqqhDFezg8rakcvm
	uMK4KIgVP6fK8jpr/gRAEyd4puW4Bu9MvNw==
X-ME-Sender: <xms:BC8uaI1tMduE3_gmGncbqVFeymusZvANUqXVwHL4gXF6yAZIRFkOAQ>
    <xme:BC8uaDFvakidB20vngZ4A4_jZZGM4Co1QLe9VZ7FRx-QaLjLLdC_aCWekUGIx7mxn
    OuIfiVkJ2z370a5-g>
X-ME-Received: <xmr:BC8uaA62w2vfb2EcHcIOiBkiK4bYNgX1_L99hDmGALUSNH_mK9S38PK5ozWmi5Z_7IHijoSiw4iZgJXi2mtNcTvz5XPYmOTWwurslPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfet
    vdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:BC8uaB2EsPXfTYLPNx5m-O3KMrwKBYnLyzk7MhdLOkZxH0WJ6rWsDw>
    <xmx:BC8uaLES2l_DE2LRYZqnRtNZjnMFYdYD7CYTrajoDP9bEDdoqCdbFg>
    <xmx:BC8uaK-Xt_bN7WOiR2i-CZ0lUDz2dfkKJrrp0fWxMFHkjGXUl2dcmg>
    <xmx:BC8uaAlhZAhmlMzfe4OgY7Fk9SZ7wwEk9Md_jqV3iGf5QRu2X7iAvg>
    <xmx:BC8uaKEWU7lQ_ihaj8xwbk-6HmBZnRK3bZS-bMSQk2ifNQ2cOONG9HI6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 15:52:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Add git imap-get-recipients command
In-Reply-To: <PN3PR01MB9597D5EBF0A8D91737E4FE52B89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 22 May 2025 00:53:57 +0530")
References: <PN3PR01MB9597D5EBF0A8D91737E4FE52B89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 21 May 2025 12:52:34 -0700
Message-ID: <xmqqikltaghp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> I was wondering if it would be acceptable for the maintainers to add a git imap-get-recipients
> command.
>
> I currently am working on it, and it would be a perl script. It would do a very simple thing,
> take the message id as an input, and output the To: and Cc: recipients of that message ID.

If you are selling this tool, you should clarify what the sources
are for the information.  There has to be a database of some sort
that you can query with a message-ID and get addresses in that
message.  What are you using as that database (e.g., your personal
mailbox?  lore archive?  an imap mailbox at your provider?) and how
extensive and configurable is the data source?  What data are you
picking up from that database to come up with To/Cc addresses?

> This can be useful to be used alongwith git-send-email, when you send a v2 and you don't have to
> type all the sender mails again.

FWIW, if you're only duplicating the To/Cc list of the previous
round, then I do not need it, and I do not want to see anybody,
including you, to be using it.  To come up with a list of To/Cc
addresses to use in v2, you should start from those who commented on
v1, in addition to To/Cc used in v1, and then whittle it down.

Again, the description of the "tool" in the first paragraph was so
sketchy that I cannot tell where you are gathering the To/Cc
addresses from or if the tool is using only the named message, or
considers messages sent as response to that named message, so it is
impossible to give a meaningful response.  We cannot tell if the
tool will be useful with given information.

A more generic version of the response follows to outline the
general principle for those who are watching from sidelines.

----------------------------------------------------------------
[make us come to you, begging]

I've seen from time to time people ask "I am thinking of doing this;
will a patch be accepted?  If so, I'll work on it." before showing
any work, and my response always has been:

 (1) We don't know how useful and interesting your contribution would
     be for our audience, until we see it; and

 (2) If you truly believe in your work (find it useful, find writing
     it fun, etc.), that would be incentive enough for you to work
     on it, whether or not the result will land in my tree.  You
     should instead aim for something so brilliant that we would
     come to you begging for your permission to include it in our
     project.

