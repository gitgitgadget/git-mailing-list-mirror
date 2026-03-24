Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1D23D333E
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359954; cv=none; b=jzFNU8lImI+Xjhr0R2af6Ux75yQPjje9sfWfE6qhgIsqNLgx6xC2c8WIBwgkWD4kSFxC0jXb8wKwnNIDFGUQRstKWGrbwXoIvCT/CqhPudcbtWAcOao2T1nzdHhK+8NCuaf3O+c2NQlOqUxIjs5kTa3oYZnY709ZWSEBtR3mCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359954; c=relaxed/simple;
	bh=FWRyuMbotLB/TiuZQdKxnyo/3DOfy/kOmY8ieC4CNuI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ESFa6pAUwWXP2YKVpgHwztwk+wbisXybEtQF2WTsj03gBRR5fQqGXF9gApUJy/1mXtkyIxp7zxN66Fap1LFN2m983hdw0wfRgcJjjWsYn0fRY4JMEam53u6daKTYo4uRf3bHDHXzCHAq/yFx6sQmgzRlLTOStyKtPzWlbt0mJ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HrPq7tFL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xUa5GxgE; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HrPq7tFL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xUa5GxgE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 74FD814002D5;
	Tue, 24 Mar 2026 09:45:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 24 Mar 2026 09:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774359952; x=1774446352; bh=Uo+XJs15DB
	D48whCL+PnVrYWM/ZTqnVzTZgkTUPZjoc=; b=HrPq7tFLu9vDATqVFVXA33DJwn
	Nr6AsZFXhUv3mepUKzrZNuMTFBclbMXz7MbofHGenAQKw4EX7v3jgahrr23ly4MV
	zPWYgVMnlIFtGojUY9gD9SXkFeE3tbx/vIy35qn1XOm8onq3diytlXCTBVPXTkiN
	EWQ4RJ4p5JKkIQAyLjzn0El82CSS0gFOUBbWjBVTWXG/qx9K7N2eju7it7v3v+Tx
	lScXnw6eSwhbiwlU6/YXw7opwfY4/eDvDZnyddk57ullXLuLgFLpIpETtnSqzX6W
	iEXRCPIKBM0I0T4Z/NbW6lTpPw6vg6IxIl/D5oE/8FpdYWfgjLNW+NYZoQyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774359952; x=1774446352; bh=Uo+XJs15DBD48whCL+PnVrYWM/ZTqnVzTZg
	kTUPZjoc=; b=xUa5GxgErE3RRYNy41kH3tXVU3a5fCMscfeazDS6fp4FjWelN5p
	uIxoqKZOZbyQnkDD49kFPg8BvVWibabpoZjbxxFkH8mviKauKkPMP4091SRHETnP
	mBX6zV4HHA7gN6S/kH15OdQjt8KP2f1T0h/BN/ojj0H3muc1nXEsiMkrYj30xJqT
	9SdmZM/4BUqdj05bXdlQ6CdQb+VkMOCxEBkThHv/zm3PAgI+Pkpqygm9BZtGrcz+
	m17opuSufjXi+riVI8Uxp22EWOjNeHlYWt0f7atja1QbIrWmluHnsjxX0STv8MBj
	7VaG8bNI+2ZQwdTCC7QOvWns6ZAb1fgRfDA==
X-ME-Sender: <xms:kJXCaSY0MjyjDtEnUNSQwQcAWBTc5i8cFPcw-nbbS4v9AMFTexT1_w>
    <xme:kJXCacQ-b95NpB9vfazsqfZbVJ4_zdC6XcLrmJX6wu5ZGJtnQt7FXI8h2cFacoJhS
    DY66jjS2u1CZS213TS77CGxa-yDEm35vTNk3J87tW00SXZK_7YS>
X-ME-Received: <xmr:kJXCaVRkhB_fPXc2CotqSkIXgHqJw8GizZdbiw2UvEBdswS1HWJx98mq-r4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddujeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteevteehgfevhfdthfduhfetgeefjeekhfelleetueevuedttddthfdvieej
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgvrhhnvghlsehstghhlhgrrhgrfhhfvghnlhgrnh
    druggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegthhhrihhssegthhhrihhsughofihnrdhnrghmvgdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kJXCaQRakzjOTJZ6e3SM7PEPiu72uV9N2meSA33OmawRJrsqrWnzHQ>
    <xmx:kJXCaa6oYiJzOGVc_HzmpUxDEfM3hbqQGPuRd-Z37ryiOrhiZ0vkhQ>
    <xmx:kJXCac1_8q_nPnpG7k8YbS-jw0pSXnrk3eW6gXjxk287vn5cn6gheg>
    <xmx:kJXCaVDgR7YRJN5HqJLyn2FPBb52AGDU9BDG1yxlLCe7NfBz9w3Pjw>
    <xmx:kJXCaTsprgUzyK1mTzdesS-CvsqbHPHMoh3FHuVfgbkicLTOojN9-652>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 09:45:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonas Rebmann <kernel@schlaraffenlan.de>
Cc: git@vger.kernel.org,  Chris Down <chris@chrisdown.name>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 2/2] rev-parse: use selected alternate terms too look
 up refs
References: <20260323-bisect-terms-v2-0-8d6bdb2c9c7e@schlaraffenlan.de>
	<20260323-bisect-terms-v2-2-8d6bdb2c9c7e@schlaraffenlan.de>
Date: Tue, 24 Mar 2026 06:45:48 -0700
In-Reply-To: <20260323-bisect-terms-v2-2-8d6bdb2c9c7e@schlaraffenlan.de>
	(Jonas Rebmann's message of "Mon, 23 Mar 2026 23:49:00 +0100")
Message-ID: <87fr5pjq7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonas Rebmann <kernel@schlaraffenlan.de> writes:

>  #include "abspath.h"
> +#include "bisect.h"
>  #include "config.h"
>  #include "commit.h"
>  #include "environment.h"
> @@ -940,11 +941,14 @@ int cmd_rev_parse(int argc,
>  				continue;
>  			}
>  			if (!strcmp(arg, "--bisect")) {
> +				char *term_bad = NULL;
> +				char *term_good = NULL;
>  				struct refs_for_each_ref_options opts = { 0 };
> -				opts.prefix = "refs/bisect/bad";
> +				read_bisect_terms(&term_bad, &term_good);
> +				opts.prefix = xstrfmt("refs/bisect/%s", term_bad);
>  				refs_for_each_ref_ext(get_main_ref_store(the_repository),
>  						      show_reference, NULL, &opts);
> -				opts.prefix = "refs/bisect/good";
> +				opts.prefix = xstrfmt("refs/bisect/%s", term_good);
>  				refs_for_each_ref_ext(get_main_ref_store(the_repository),
>  						      anti_reference, NULL, &opts);

Aren't return values from two xstrfmt() calls leaking in this code?

>  				continue;
