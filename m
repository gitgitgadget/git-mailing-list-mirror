Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A9347C6
	for <git@vger.kernel.org>; Sun, 10 May 2026 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778374880; cv=none; b=XHMuPpfR2q3sel+pwXFpF2iq3Q+ya7K4UPVaLjsNZHghYreD5MQw+ocVN/CjU9hOfEeO6Erbcqp4Q/HeeMHRRPafPs2wDi0atB+xbTr1kmjDRmpYqNJFCNAsWQFuW6A4MQezaUENmzeS5OTmiwF6e1t17mVx61rBvGmNQ71ioBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778374880; c=relaxed/simple;
	bh=1wJI0EUuWNY7nGuflZpZsQ3VONIabb4dZj1jAqATt8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LiCjOtMJ5CZnSNhsSwiEYvFUvQsLhiIbKNDxpeI7mSn3ZaRLcUHwecpMaVhP51353xCgzmNiIlMzVMmVOwOn+1fmGdI2G44ccu8eHvdjIXQOf5VCoEkfP96lc3fIBNbIKtMM6WLNIzvonhQ9INmYB5DfUmdJTx9qrgWl3m4sXEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g0Zs46DZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ODtH4rXu; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g0Zs46DZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ODtH4rXu"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D00F1400139;
	Sat,  9 May 2026 21:01:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 09 May 2026 21:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778374878; x=1778461278; bh=MSB0d0Q24l
	eB1K10nnH70clace/l/8qVv6i8kIl2xUQ=; b=g0Zs46DZ6Z1XRgz5+8a8EqNNoX
	zjsO0XiJ7zbxxlx2w/RCR/7LjL+mBdpzAtlKaKRDDxlwwGxHhl5hGPleJKaAu0J8
	CE2MgFd+ZzyStHkIbk67deSxQNFpDYX4/iH67LWd1sot0XTlNB4gdLwNr10U7rVD
	i25JudtV2XYlCxa/fV079QqTYyJ6LuxZYLMiPrWM6tVplJJ7i96C/4zODxusYXaL
	iUoekKhV+YhOjaCeLtspnWn2kwW8GgZKzcUTHgXNOw1k5B7urAS0bBhtFyCl5buz
	p6V9ULmW3ID9jqcLzGd8CHAwmSV5JNt71934/7EIDHpApO/GbwxVBs9+2Icg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778374878; x=1778461278; bh=MSB0d0Q24leB1K10nnH70clace/l/8qVv6i
	8kIl2xUQ=; b=ODtH4rXuRRFpxLD8SL69d+ZG2YTHJ3SLaoMTwBufsFIymMQ0ZqO
	/llMCqUAoFztnPUD+eozTSYQyNEuuynGtyWdWvVg1cxE6VG0q33kAjkdofZnmQZy
	186aDNE0dkR5VapQpguA7RWRpR/WsrVBD8dKxs+J4e/BE/KqD7SNyLB5X8BSTUQM
	C54Y/NlBKEEgjowgLtGNXfuthb3LuUC6MOmU5ayzH8tVAzIIDIr9KWkTGm1B04KF
	jwRrIN0WvkDF9UG07RBK8uxGdkt74A+f+Ye4544D5NK/uwELyyRslnPTe0w5QFZ+
	FkgoCmMOm/qLWTfqeau20fiO0NUfllrOeaQ==
X-ME-Sender: <xms:3tj_aVWV7Ta-mpc9jIUhfLAyfGyjdBkhV3_ju_G4z6qUOLkkFuCThA>
    <xme:3tj_acmz3ZqYkggw9xLust3s5-mJl4itwHeZlEGW9JCjbbjN6Wc3lBcWtgTeuyPQk
    LAPwHP8ISsmQ-IAquiKS8GtPwOU_uNJ6o4yjX3CPQ9132K00yeHDQ>
X-ME-Received: <xmr:3tj_aWYwIplg_PN42Cn3LmKiXLN-5Xq6eq1N31NQbuNikMIoJzX-mSk5NbQ3mRdziw_H_cV2AEVn8NUUmNWgmOWWKFSVBXiInQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhmohhnthgrlhgsohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3tj_aXNNMtZtWAkQw_GMJOGpc8bNbjhhqokRbLugF-F5T0eyaVDICg>
    <xmx:3tj_abaBRTLCaerCq4ILsFeDe2QmXR_fQi19XnRQ9k7dwVNfTSGMrw>
    <xmx:3tj_aV0MgJBlZirMNBlzMUr5TwEofxXccQak_Rq0Cwunhio0Pw-wBw>
    <xmx:3tj_aRflRyXPeYD2Lmqj2J99BdYw9yZpH_cnq0dSFKzTmyx_rg0WAA>
    <xmx:3tj_aR6SGWZT-qml0GPsFlwZEMz1JqD6DOmRCfc_5soQL4WiqrA6NdKx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 21:01:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH 0/4] diff: reject negative context values
In-Reply-To: <pull.2105.git.1778022144.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Tue, 05 May 2026 23:02:20
	+0000")
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
Date: Sun, 10 May 2026 10:01:17 +0900
Message-ID: <xmqqv7cw9ixu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Negative values for -U and --inter-hunk-context are silently accepted
> and produce structurally invalid diff output.
>
> Malformed hunk headers:
>
> $ wc -l GIT-VERSION-GEN
> 106
> $ git log -1 -p -U-500 -- GIT-VERSION-GEN | grep '^@@'                                                         
> @@ -503,999- +503,999- @@

It may not matter in the cover letter, but why do you need ~60
whitespace characters at the end of the command line, and many other
lines in the message?



>
>
> Line 503 of a 106-line file, count "999-" is not a valid integer.
>
> Overlapping hunks that cannot be applied:
>
> $ git log -1 -p -U3 --inter-hunk-context=100 791aeddfa2 \                                                      
>     -- git-compat-util.h | git apply --check --reverse
> (success)                                                                                                      
>                                                                                                              
> $ git log -1 -p -U3 --inter-hunk-context=-100 791aeddfa2 \                                                     
>     -- git-compat-util.h | git apply --check --reverse                                                       
> error: patch failed: git-compat-util.h:118                                                                     
> error: git-compat-util.h: patch does not apply                                                               
>
>
> Both options were originally parsed via opt_arg() which gated on
> isdigit(), making negative values impossible. When they were converted
> to OPT_INTEGER_F / OPT_CALLBACK in d473e2e0e8 (diff.c: convert
> -U|--unified, 2019-01-27) and 16ed6c97cc (diff-parseopt: convert
> --inter-hunk-context, 2019-03-24), the implicit rejection was lost.
> PARSE_OPT_NONEG was added but only prevents the --no-* boolean form,
> not negative numeric arguments.
>
> This series restores the original invariant with stronger guarantees:
>
> 1/4  diff: reject negative values for --inter-hunk-context                                                     
>      Change type to unsigned int, switch to OPT_UNSIGNED.                                                    
>                                                                                                                
> 2/4  diff: reject negative values for -U/--unified                                                             
>      Change type to unsigned int, add range check in callback.                                                 
>                                                                                                                
> 3/4  xdiff: guard against negative context lengths                                                           
>      BUG() in xdl_get_hunk() as defense in depth.
>                                                                                                                
> 4/4  parse-options: clarify PARSE_OPT_NONEG does not reject                                                    
>      negative numbers                                                                                          
>      Documentation fix.                                                                                        
>
>
> The config variables diff.context and diff.interHunkContext have
> always rejected negative values. This series brings the CLI options in line.
>
> Michael Montalbo (4):
>   diff: reject negative values for --inter-hunk-context
>   diff: reject negative values for -U/--unified
>   xdiff: guard against negative context lengths
>   parse-options: clarify PARSE_OPT_NONEG does not reject negative
>     numbers
>
>  diff.c                             | 25 ++++++++++++++-----------
>  diff.h                             |  4 ++--
>  parse-options.h                    |  5 ++++-
>  t/t4032-diff-inter-hunk-context.sh |  6 ++++++
>  t/t4055-diff-context.sh            |  5 +++++
>  xdiff/xemit.c                      | 16 ++++++++++++----
>  6 files changed, 43 insertions(+), 18 deletions(-)
>
>
> base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2105%2Fmmontalbo%2Fmm%2Freject-negative-interhunk-context-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2105/mmontalbo/mm/reject-negative-interhunk-context-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2105
