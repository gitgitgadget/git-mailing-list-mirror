Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D121E082
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605937; cv=none; b=T8cofjif+gUa9zcrcq97yClN0+l2JXmf7aqStdGi4KTtCx+dFLmkn6HwwY6+x5/cD+ua6xuFB/lapHdUQ7JvfRm0pZJX1TFau4VQb4YjgeEg+udzu1ySpdfwqJtGtJn8IwyWNRyCj2luO1eKMxf5H3w6aRMmLgDhIyRGc4zgxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605937; c=relaxed/simple;
	bh=A4ZvOsgI4eWhOiH2MdqXUINzKl1laoY1gfBV1gNAhww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GerGuBQufVKQ9KkCexJ+9y/V/zdOJoBCjNdLwC7dVRh8z/u1f0iJrnEgVKLNnou/lZaaqnz5eEyyzbXY4vi7teNIil/FQ0IefbJjVv8cLteG3lju4mau3hwxPso3qJajMQXxupKsHYUmFyegVqaGHlAYk2eXvkTPFQOFMHwl4Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LXtXrbxa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wGEJZuTC; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LXtXrbxa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wGEJZuTC"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F198B11400FA;
	Mon, 10 Mar 2025 07:25:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 10 Mar 2025 07:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741605933; x=1741692333; bh=AKTiV5xWgp
	P2F2KK0SE+7n/BioTqTat5YFPAk9aGgTM=; b=LXtXrbxaWQLru6kpIae+RFnSRc
	WJI+MFl92LcOhtMN+Pado+hzn1zRrP6J9tGZyH/ud/WP669ddxmVH7U6MbHoim6S
	1SHANB66b444SGeNoA/Fx4yh9bGLk31h1tX3RvMG5M9oCystPZ7eI2X6wpBlu7gh
	TkKWX+8UN1oPE9I+4qtbXCecvWEZ92Gd1YSpZr8gllRgNbJwmwlPlXjejnom0/Zu
	ABKRfy7xaZ9vRSAieqt4cUZ6SytmROMU+m8qR2lGTwFOjR9QTN+iJmf5C6STfwXI
	gJCYCacW7kYvUH+oveIB2Tx+6xztdC3MFvqjQ/O6ve5KhUCuSQ+ABsHr40OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741605933; x=1741692333; bh=AKTiV5xWgpP2F2KK0SE+7n/BioTqTat5YFP
	Ak9aGgTM=; b=wGEJZuTC716PtyYSizohF+iPrjvrqS71z4ABMa3FIMP0Rht46x1
	/9IU6XMu77TifCHE2ipZhOR/i+5XFVLpGrYkieZDKmaCwRI6TJccBjJTVLgIo028
	UAdx+FWe7mthIk2E6ylAPBTtoSNVtToJ85IWXCYn2dhgkzq1hkMze5Sq1eUYImOt
	9igqV4Sy5Pmc7F2mSPOJKVmlpMdDj8ymOHTI98P/X3MKTcVr3j1pEkMAAiz6WM6I
	xu4Ih7VY/2XINGPNg5ZyD613FjpRzbLrGjpvG4LAc7Ccl5JUT47+qPNNsmnsFqbf
	ilrgZFOSWD5h9J5OKxtnly77D8EGmI3xvLQ==
X-ME-Sender: <xms:LczOZ7vNXw0OXMY2JyQN4nInI9fHS-povEdW9XrSW06uPIpZtRBaNw>
    <xme:LczOZ8e2-t76spbATQq94rJfw0haKCAQN8uzPyYLpA3ouugHVgP-2ZRkWG0TBRO_M
    0yx-5PS8lV3nUOzww>
X-ME-Received: <xmr:LczOZ-z0yjklp3_z9L4GDPmD760w2TBZgIR6zKaHkUT_LZZUxRZZvLEqLGYxfRXTKARhk2OAhiMwkSLoSIpdse5hqtKJzvay9iag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvg
    hmihhlhiihhiihlhhimhgvodhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LczOZ6O86amrdCQLWhGHWZPYAbR7Mbhwhe30LayqoSrT4SRAmq0jGg>
    <xmx:LczOZ7-Hh9QB2586a3dhePXcKxdm2xLgbp4nHOPcNPCG3OCF1SGb_A>
    <xmx:LczOZ6UCpYjPWFJxkGozd2jdYZcJPdKA4cVQ7j9xlVwaIVUIFtEdKQ>
    <xmx:LczOZ8fvW2fjHRrz6Xu103AKahbpAlHZP-xNM8PP8T3-AsG95mcAxQ>
    <xmx:LczOZ3YQewJ5ZnSw3QP9utRZ1XaJhr1aHMRsQrnX4SjtV3hlglYvYJ57>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 07:25:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "emilylime via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  emilylime <emilyyyylime+git@gmail.com>
Subject: Re: [PATCH] archive: error instead of triggering a segfault in `git
 archive --remote=""`
In-Reply-To: <pull.1877.git.1741515155475.gitgitgadget@gmail.com> (emilylime
	via GitGitGadget's message of "Sun, 09 Mar 2025 10:12:35 +0000")
References: <pull.1877.git.1741515155475.gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 04:25:31 -0700
Message-ID: <xmqq34flb00k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"emilylime via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: emilylime <emilyyyylime+git@gmail.com>

Here is a place to explain what the change is about, how to
reproduce and observe the symptom, why the current code behaves the
undesirable way, etc. and then propose how to fix it.

> Signed-off-by: emilylime <emilyyyylime+git@gmail.com>

Documentation/SubmittingPatches:[[real-name]]?

> ---
>     Error instead of triggering a segfault in git archive --remote=""
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1877%2Femilyyyylime%2Ffix-archive-remote-segfault-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1877/emilyyyylime/fix-archive-remote-segfault-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1877
>
>  builtin/archive.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/builtin/archive.c b/builtin/archive.c
> index 13ea7308c8b..b6fdbfc7dca 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -97,6 +97,10 @@ int cmd_archive(int argc,
>  	argc = parse_options(argc, argv, prefix, local_opts, NULL,
>  			     PARSE_OPT_KEEP_ALL);
>  
> +	if (remote && !remote[0]) {
> +		usage(N_("Option 'remote' may not be left empty"));
> +	}

Style--useless {braces} around a single-statement block.

Style--downcase "O" in "Option".

N_() merely marks the string for translation, but yields the string
as-is to the calling function (i.e. usage()).  You probably meant to
use _() instead.  

