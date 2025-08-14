Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7EA14A60F
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210156; cv=none; b=Nb5jwwp2AlE5bZOU66BIZ/eEFDCrbHivDnBcYIk/YUbRRFQ57HI51bAkNHEmpsAIdx/6zb/f0FO2vA9UM70vUGy7MCEf+arjr6RE3lKU2GjTZOcqeAmHOLgsUO30MH1ADQ8mNnxmW2pc5+W/lB3ymtqKGZgkiBubJNIcAOX62DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210156; c=relaxed/simple;
	bh=RRkPiK1iD6S60HbEIPalNY1DI3tAKuyu57pGBsTttpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hNFgue4O5OITA+8H48qR+d9iEjIsGU1qkKe5QljfrL7+iVy1pcq+z1p7h38QbmpLWsHqAStQsYNCT57cU24pQ7MuVilbYZOHp6S0jZtd4vQ43riETBr5lib+UKVLIejAr6n/YilpQ7UY8XAP5tEW7KTMFiEqo87u24yeqW/0CpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d5SA+qMe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z03+z0fp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d5SA+qMe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z03+z0fp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4B5A14001AE;
	Thu, 14 Aug 2025 18:22:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 14 Aug 2025 18:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755210152; x=1755296552; bh=1KK1X1BcmY
	ffAObnqNyNTcwm7Q35R7ENZOv8ZNYJGWI=; b=d5SA+qMeLLLhgsrgonYomv9bjr
	VZblaa3SZOQhRl2GmSNlqp032Rg6nrqR2gdZrudyGtvJGQr4aKqgvydLu0quMhhk
	gC3vgm+YOXX+YRse3zSj0YVOpMKvF/E99BAOm1/s18QVNOzyKfnZLVW+Ul4fwDdS
	f0bAc0be3+AK9OyJ8ThSPS6m6/sny55SeEAp9A5IKeYZ6FAk5XJb5X/490TcDq/T
	sF/2q4BboZeBjUH5dpOv+llIR3id9tkacbkyeCnV9iNUDvBOE7FMUDSYc9STS64H
	3nG6KEFmZVqKOU3upschgXug1AC/1NMTI+4Q2uGyPs78lfEoNHWmvYh0GwhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755210152; x=1755296552; bh=1KK1X1BcmYffAObnqNyNTcwm7Q35R7ENZOv
	8ZNYJGWI=; b=Z03+z0fpMSs6GlJ2FkoeealEqeZLaCm9Kj5iCB7mZ9qLwqk7wId
	Iv+p60ScQaffoNaZ1C2rnkEVehwTD/lhLYPzx+BNJeM/qcpveFVO6z+enhOdgv4a
	IZYuB6xnBTTvwbUDbNILFpozeCRxVYYurCD+EEOMOQQfcPB8WmjDV6Zr0A5PcEue
	+94G/AxziFzeWisU2CVdGij2+9dL0OXcxN4mhEtRQVKBbAKgiRKPDJDrshhWVf6Y
	LrfFdSQJpxJ3iVx7XvJxYiVkBzLHs+aHOSu+XDuOkVNFwKnkOsTYJHSF3py+Gqdg
	/XmGpyv2PXUS5pU8Vm+m2p9yilYAUyyJ8VA==
X-ME-Sender: <xms:qGGeaKSEAbrtyKPLyZ8iTCzjFlFXHmsdpxHie8W6_-eAYEZiHBZKbA>
    <xme:qGGeaNWtRPopPu0Pq1vuYC6Y4hLysdwALf7KGraQVquPAqPdWGqaAIEM3AeiOlrlc
    HAf3dqEaOgvItjnZg>
X-ME-Received: <xmr:qGGeaOTPdsg_imEufohepWqDYBD6IdZVTcrSrzRENSC32Ls4hmNVyE0A20s9Ym95Xu51NNzSetpgUpNf-HKftyV3QDlePfIJ6Yv3aK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgv
    vgdrfhhrpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qGGeaHkwQr-4ytHK_CaEKCeESH5g-ccohRnKlDvTxOjyS3mPFV5E4w>
    <xmx:qGGeaE65lNYcQ667yq7_FqfZ51ZmAq-qats5UvIapqN8jN-2yVk2CA>
    <xmx:qGGeaNhVkeeV9xwwxruPXd4FtqKnUDIWywEav2oS_wqryYYZwUvCeQ>
    <xmx:qGGeaBGYii1-0d4UGeaNC7ANUUOIjeGuy4C3Y_5EsSC0RHNorI8ivg>
    <xmx:qGGeaLIEiNw1gKBiINNkNp1hCoQmqWzHY9xzY4DLeHLY4mP2wIfc25wE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 18:22:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chris Torek <chris.torek@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,
  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 3/4] doc: git-add: make explanation less dry
In-Reply-To: <ce1eafb02860b390da9359f92fcf098b7cdd3a94.1755127218.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Wed, 13 Aug 2025 23:20:17
	+0000")
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
	<ce1eafb02860b390da9359f92fcf098b7cdd3a94.1755127218.git.gitgitgadget@gmail.com>
Date: Thu, 14 Aug 2025 15:22:31 -0700
Message-ID: <xmqq349ty254.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -This command can be performed multiple times before a commit.  It only
> -adds the content of the specified file(s) at the time the add command is
> -run; if you want subsequent changes included in the next commit, then
> -you must run `git add` again to add the new content to the index.
> +The `git add` command only adds the changes at the time that you run it.
> +If you edit `file.c` after adding it, you need to run `git add file.c`
> +again before committing.

I somehow find the text before this change easier to understand
(except for one thing).  "If you edit `file.c` after adding it" in
the new text says the same thing as "if you want subsequent ... in
the next commit" in the original but in a much better way.

> -The `git status` command can be used to obtain a summary of which
> -files have changes that are staged for the next commit.
> +If you want to check which changes have been added, you can run
> +`git status` to print out a summary of the changes that will be committed
> +or run `git diff --staged` to see the full diff.

Rewrite "diff --staged" to "diff --cached", simply because that is
how "git diff -h" shows.  After all, "--staged" is explained as a
"synonym" (and by definition, a synonym is something that you do not
have to use, as you can use the real thing).

"status" gives paths in two groups, "changes to be committed" and
"changes not staged for commit".  Explaining the use of "diff
--cached" to inspect what the user will be committing is a great
addition here, as it is a sensible way to sanity-check the result of
your index manipulations.  In addition, we also should talk about
"diff" to inspect what the user will be leaving out---in other
words, what the user might have forgotten to add, which is equally
if not more useful sanity-check you can do before you commit.

Thanks.
