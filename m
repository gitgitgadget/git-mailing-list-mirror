Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED253C3BF3
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417815; cv=none; b=AvJVaUCmfA9hHjfyklFpPHmqctrIvxAHOPn/9YwtfcWD/yKZWbIcw0JuFUNeIEQ8p1Uf+9Az4X9NUyu8Juhs73LWjHtHwf44xM81JkutTqrzETBDOUCaljkI2TZl+xVcjWjTRymXja1LpzhhdvdO7dIcwemPAN8OPu/VddlfXh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417815; c=relaxed/simple;
	bh=lpzoOeKdX0RW7lOl5dydOl1Z4nPKbAKJYHu0LDe8HR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dTeQKcECWq1x/I/rsIcDczVT1kekOlkAi6i/P7wRc9dEIJxAQDhql1U4n+kAJwJpBe6vrNB3u3cpbUsXM2Bk4va3h5Yb9hhIAVloHpSKRSNntGXfqe99JeiKskIUXSU8twti413Ldj5BKRNHjafvPRpM46a1hjR3+Zg4qSqIlUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZG2akG2g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JF+YRHtR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZG2akG2g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JF+YRHtR"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D7763EC0617;
	Fri, 13 Mar 2026 12:03:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 13 Mar 2026 12:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773417813; x=1773504213; bh=Zolqd3dRbI
	aBJ/OvngDV0YjATk9WhTOGQUYiRkpGqAE=; b=ZG2akG2ggtGWpN9IgO6xO2PyLV
	Aur3MGC6SAAtcpOYctpCd1q1Ywv0o5E9Kk9veh8Abt/xDY55KJ/uajMKZXXqRD7f
	f1LVq7M9PJ0m/5h6IEMKnGhQmZ9k+r0KinRq4iFjrw4MQ1vyqIwvARRehtD7azyZ
	yBw2rc2YVItUsW0s0jaeAWnyo9REGRjw/Oc6btNknvHEt5VHAHC+Z0FIGPsyTFo+
	NBTnRatLJww7KRyV4GtP4joKHm4bijdfSGmy8r8Uv5ABo4b2a/olKA3urHcnaAhi
	IbmoD+wDTXFpMcgjv1fO3ajWHDAprkmcj/KkcaQiboTpnd3LbHOrUMOPga2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773417813; x=1773504213; bh=Zolqd3dRbIaBJ/OvngDV0YjATk9WhTOGQUY
	iRkpGqAE=; b=JF+YRHtR1FPV8FNlY40lel7PK0CJ2z6+gqSP6ustIf/e0MHdJgE
	4Miev8dfXvWxg949w4JyJ9djTcWNWVY0xqlXGI6uIbDxWzHsiAc0D0rZfa+WP7XB
	lyrNPieRpz8jxYxU2ucynMCrqlY01QT06ExUWIPoViBVi/csGDiGjNAk2Wv7v74W
	oHLVnhq7r6JzlZkXPoNlJja/9UAJXsfa46C45d0EZ6t3JG4czc/+mBv1H+jTOt6L
	s+2+bLG5H9InsQeJtVuWLWvz3c96SxZRh0jHRf/Y24gmV62RQXal66HffC75lW81
	2RRDJSpYHZe01mu6arqXHwtV6+IySy+IHTg==
X-ME-Sender: <xms:VTW0aQI-rpLWCobgKHjKMHRfLiXl-UsoTXUrhy6xYY9Jhy4xx6FnOQ>
    <xme:VTW0aQ2hbXSa3QtX3nirLZzu5ckjrXbQPMoIU7PAmbf38SSpahoE7x8ywPkf4Qc5r
    Rie6r90C9C9hU53M8fiM49-uYbKB_Nv8At2M5VIo_iuMEMzV_P7>
X-ME-Received: <xmr:VTW0ae4UEBeHHXsGKn_JctkLbIOKWopjKfKNQ_VBhU-opWIS0kFeqQshnhjcIt2clqhlAJ0VsJZSjZB9AuweYnnSX-rjSWIM-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledttdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:VTW0aR8dXEZMX_FewTKJPNWzLximezrpGaVJHyLTDGZdzrOf3AKBdA>
    <xmx:VTW0adWb0OXoMIkRIG4_Q_XG_e9GMAPCIP7K-ohjK_ex7YIlvJwpPQ>
    <xmx:VTW0acqymDI5k19ipRIo7QVyhxC9LBGBRf6taO4nKsvvf7Gua5-TlA>
    <xmx:VTW0aflZak1yi3RbA3AiXrAQdhN2aneFtrt7HvNK4pRORJczVoQs_A>
    <xmx:VTW0aY1kMTOjSL7H5jILNhUx7lwf7llKv1Azg5bPRiEqfSNDnz_wCqev>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 12:03:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  karthik.188@gmail.com,  phillip.wood@dunelm.org.uk,  jltobler@gmail.com
Subject: Re: [PATCH v1] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
In-Reply-To: <af2c4ae3-c273-40ba-bbca-cbbf687b1b91@malon.dev> (Tian Yuchen's
	message of "Fri, 13 Mar 2026 00:21:41 +0800")
References: <20260311181704.958509-1-cat@malon.dev> <abJjYNq_sxeH8yLQ@pks.im>
	<af2c4ae3-c273-40ba-bbca-cbbf687b1b91@malon.dev>
Date: Fri, 13 Mar 2026 09:03:29 -0700
Message-ID: <xmqqpl577m3y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

>> That is, can `repo` ever be `NULL`? For that
>> you have to look at "git.c" and figure out whether or not the command
>> requires a repository to exist.
> I checked git.c and found that there is:
>
> { "mktree", cmd_mktree, RUN_SETUP }
>
> in commands[]. If my understanding is correct, before cmd_mktree is 
> called, setup_git_directory() must have been fully executed. In that 
> case, if the current directory isn't a valid repository (NULL), it 
> should have already exited at an earlier stage, right?

There is one corner case; upon "git foo -h", your cmd_foo() will get
repo==NULL when the command is run outside a repository.  As long as
your cmd_foo() asks parse_options() to react to "-h" (which gives
the help message and then exits) before it uses repo assuming it
cannot be NULL, you are safe.
