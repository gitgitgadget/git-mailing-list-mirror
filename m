Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40413DDAA
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355641; cv=none; b=L83+3pjUrtUWVVGuG8vhswfKbqyk0wNGxwVWjmASIr9+Z/tEJgCgsBRbUAKW3ohS/wbVqsG2sThiG/IOeTN569nAhtd9Rwqig61hxodK6sFlOudfw/sH3Yk99IIzRVhcspmYgLDmz7WOSS9BFVRtKWXFh7XVadLi0SdGt6fQra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355641; c=relaxed/simple;
	bh=/pcwpeJvRfYbFIe9cygGfZNZdBjVjhVPHTLaJnxdby0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rdy6h9/d3GQDDYKrhhlFl9bViiQeXPtF15/0/FBTDM7j2bfYHz87HeqHqQqPdGwVKGQZc10B390QcQF/sCxE/HWcehe+Epgz5yj+ro4Ty/Ye97Cai9Pxi5pq6pzyQgudW2h9slXEA68PR0nMwSYIYOhgDY0wVQ0HhmKA6SXQa4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wq15TAxn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TSqWXqL1; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wq15TAxn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TSqWXqL1"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 6295B1D000F9;
	Tue, 17 Feb 2026 14:13:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 17 Feb 2026 14:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771355639; x=1771442039; bh=ogFL7ePE1U
	hY8gYilJ1wJKZ6ephipvol14HExz+gOKI=; b=Wq15TAxn4iX7j+kvmiDOtSqhp+
	YuV9u9rQkLt7iyQrqSB3z9/7LzgOx4jfeHEsMPoSK1m6G6kNLCSphshPqpHaxFSD
	n4nRal5NBe+EsmKzD4DXl0HCzz4R2O4X2RXQ+QtLIHz62HL0jm41qkj4K9LQem3/
	olT2A0q+PNJHMwQRtFpW+JTuTlqe87kczS5/N6iLF8OAe6kwltWZfrFE83ZWhyE3
	Yb6DBAbPzc0+2fddPPuQR89/L7Ah3Kuc6y9Y4Vvdks28+eC/MPw6dFqn7yCoNF+Y
	QL3AwlHGfGaPqdxfitSVskVH4WN1MSNNJpsXDMSsbfsQuwbBX1wYRdic3wFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771355639; x=1771442039; bh=ogFL7ePE1UhY8gYilJ1wJKZ6ephipvol14H
	Exz+gOKI=; b=TSqWXqL1iMt7tY9XoYlQM6wHw36ARBAlzDzEkSsmNkOO3dKNVCr
	uY1iwXI2Qh2klkXc1+juhySwu7lZ7r/DWE3ubPHhgiZx2BLbm5zEhXFaW2c1Jyk9
	T2mnCxPepC5cgK93LzZdiPpmhFCHWTeJYynyS1SXOqRSUXJR9W1a6p6044fEBigu
	yJyG4+uvkh5fpkklhmfeoKwGsVZF1k1fOrjfUhhANyb7eYw2mpEBu5yaZkgMLYNu
	PwGoMjbu8H6JV/7V4wG933vbpuyuQ9MUV08o8DPXJFeq2tM/80KWyGbiLGhyAwOI
	dvLsuECbpkmG19f9hyFhxFxDwklZKkMsZxg==
X-ME-Sender: <xms:972UaeCsPRfcB2cIFDuc-aGkYbdS3ELN0soss0KUcCIlCJEvQhydTg>
    <xme:972UaUVGRaqkH12Lqif68it-6Yfx_D7VhZMO5JqfHWW6-o96nyVsFUpFXnnlL6yxV
    eYGSwb-LKIFUbvnaBOb43hAB1GDm0WVe8FMyFcXyqAPnvcYBz789w>
X-ME-Received: <xmr:972Uac8ijiK17-VL1kzBoThAHaglZXYVejbf1IOgeELm-eyyJ5HeYlZYXVCkZ16JYzpNGUbgA0hHhecQF565rKay5YGrhcZo7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    humhgrrhgrhihushhhjhhhrgduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvlhhkihguleeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegrhi
    hurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgr
    rhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:972UaWQJTTVb_5Cw5PJf-7Betden0cN-aJj_p3hZPNOFn8eGufndaQ>
    <xmx:972UaRRu945nY3j8cEOn8MKlBrT5LTRZnC4iRUcRZ4ZtMZl-ByBqlA>
    <xmx:972UaS6orikYX3Jep_yD2CHYN7E7vCQ0YSYy5kV98Q-h_9hYwAf_OQ>
    <xmx:972UaWX9d2Llvk7it2iRGDwCjofG_zTIOv1TZcnUGx2G06Ni5ha6NA>
    <xmx:972UaawFeHbr2F2WUUgcydG1eZ9TGjtBlLdTpo5o_ZIYunWg4P5QGdld>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 14:13:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Jha <kumarayushjha123@gmail.com>
Cc: git@vger.kernel.org,
    Phillip Wood <phillip.wood123@gmail.com>,
    Olamide Caleb Bello <belkid98@gmail.com>,
    Christian Couder <christian.couder@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [RFC GSoC PATCH] environment: move core.trustctime to
 repo_settings
In-Reply-To: <20260215112331.22-1-kumarayushjha123@gmail.com> (Ayush Jha's
	message of "Sun, 15 Feb 2026 16:53:30 +0530")
References: <20260215112331.22-1-kumarayushjha123@gmail.com>
Date: Tue, 17 Feb 2026 11:13:57 -0800
Message-ID: <xmqqpl63b2tm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Jha <kumarayushjha123@gmail.com> writes:

> The core.trustctime configuration variable is currently stored as a global in environment.c. This prevents it from being repository-specific, which is problematic when multiple repository instances are used within the same process.
>
> This change continues the effort to move global configuration into struct repo_settings, as discussed in
> <20260208062949.596-1-kumarayushjha123@gmail.com>.
>
> Move trust_ctime into struct repo_settings so that it is associated with a repository instance.
>
> Add repo_settings_get_trust_ctime() to lazily read the
> core.trustctime configuration value, defaulting to true.
>
> Update statinfo.c to use the new accessor instead of the global variable.
>
> Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
> ---
>  environment.c   | 5 -----
>  environment.h   | 1 -
>  repo-settings.c | 7 +++++++
>  repo-settings.h | 8 ++++++++
>  statinfo.c      | 4 ++--
>  5 files changed, 17 insertions(+), 8 deletions(-)

Doesn't this regress end-user experience when the configuration
variable is misspelled, e.g. "[core] trustctime = bad"?  We used to
run git_config_bool() from git_config(git_default_condfig) fairly
early in the program, and would have died before doing anythihng to
give the user a chance to fix the configuration files before going
forward.

Now we will run deep into codepath and would not notice the
misconfigured core.trustctime until the code happens to ask to
compare the filesystem stat data and in-core index stat data.

I think this is a recurring theme, e.g.

https://lore.kernel.org/git/32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com/
https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com/

That other topic Olamide has been working on seems to have settled
*not* to lazily load into repo_settings to avoid the problem.
Instead it reads and parses at the same places in the code path as
before, but into a repo_config_values structure that is associated
with the repository in question (which typically is the_repository).

