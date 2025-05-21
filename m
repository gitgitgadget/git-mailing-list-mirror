Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352E1CD1E4
	for <git@vger.kernel.org>; Wed, 21 May 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847022; cv=none; b=OWQ8bqfNlmEqo0mEJp8akSZVzT/+tl8SMX0q3+V/iP6YR1jeDgvha/DOn0t2oX85eXZNJYeKLkrIalpxH3+xj9qttyQEzz1g+QDEEjWRpimEv01mKpUd16SSgu7rq0k2SnpMuQ9elUCL0WhXweZehRP+AcxbWa4M9cG5VbaDDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847022; c=relaxed/simple;
	bh=A4mDuiVKcMTmyzjqeqEmgunLeqG41ocYCUlIDbh3RuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ua/1oavvd1/017++DcoM0bgHn/aNNOstidKpIMlw9F1Yf2mWa7swmpw1qE/jQm/SdpErHt8xgtAE16h57gz9U9PzxKy8E/uYC0LAEN/9w87Yw8G7zK9OVtstnZQdN4ptrdL3ioaER7gXqNq8YeGdLgm52zJ2fMJAviqUTB9N3Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MpodCwL9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jUhuE4qF; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MpodCwL9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jUhuE4qF"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 500C11140142;
	Wed, 21 May 2025 13:03:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 21 May 2025 13:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747847018;
	 x=1747933418; bh=4zaq4V8ArAGm/IokPJIhcgI1cvVRKmNjWmeWOaoookI=; b=
	MpodCwL9yHPrcw+sGc2l4YXSuvlIjaCEXGZGfqE8Npu+PtwhPv9k/fmyembAkDdp
	HPTHhTTbtY9hW6oZunz9UmUSZiI7d6UVuPxysPUV/fyyBAjb0R6LpXqKnjqqGaPB
	nG8sEDhTdbr784CrRYHoFf34uVEwDAk+Aue/1OzFDdwtXXWQ5a0buTob/kPEH5mA
	I/7/eDD7gq5bBraqWVB3ajzsbWEC5zyPZslHrXAb81aKrUfOJ/BFTfHbxZNSRIvp
	S611sLPBp6x3hK0Zutz0Nolxf+ug7CN0+IR1MjINLT9d9N0kZR02vC+uvX9gb9Nc
	C8jaTwgTZLaeh06Obw/F6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747847018; x=
	1747933418; bh=4zaq4V8ArAGm/IokPJIhcgI1cvVRKmNjWmeWOaoookI=; b=j
	UhuE4qF9hgGQYyG5NlRbJ2KwJq0uoW+EqS+QzgT7s91gjpC5FxTuFO3qM03bRaW2
	M3XejNIc3ULlh5qUs5OL9HxydDvprWBy1B8uhLJ25+RF4eTv+t9GFV7/zk8vcgs2
	zPw3EHKjUYCTF1FzFzWjyOwVNo5VUYVDAjxo8UYrweTx/g9DGWqSev4AsRZKIJ3f
	p9onSwPjnTWiWBODKXvqHYZKdhW8awKl8GKj9anXbEHRUtvElE2Vw8M99jwIEpP/
	w3wGgo0IxL4wN525Tov4m+N2MVb8udPdEA/VhTygbHD4BmXnjHxRz+znKCsnYjdT
	MZQebB+2DMOf6B6wOXWuQ==
X-ME-Sender: <xms:aQcuaOWYxpX8ZIwRkBRbxGh4oUfYsqgzLdmwQpWJTkN5FAw95qD32g>
    <xme:aQcuaKnz_gOj-r3p60EBiEt-V74DeVonqh2XevjTxF8C5qyEq96cwKN98NzDGToar
    Kgc0VEVfeaj35ZGQA>
X-ME-Received: <xmr:aQcuaCbto-cSJusxRk6qYulJ53Qutl5R6SdGzi506-wkViT8ZymhN9Fcfj2fDSkndGTmEkG7brilDlQyuvTtzqOxcq51MfLPGvN9bfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteeg
    vddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhpohhhohhrvghlse
    hrvgguhhgrthdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:agcuaFWJx7_RYbPCbS1H4weHOndO2pGqj-rP_TslRVPi9n-GQ2f96w>
    <xmx:agcuaImb93nS5zXPOeej7j1-Co2vDXs_pGRdHYeU98yJj9eD9GHuMw>
    <xmx:agcuaKfrXBWCpwIwGsC4akTwOkuMsVt5C7LkaCNkDe29zgELCVB0eA>
    <xmx:agcuaKHx2RYRKCe6_93cVWa1bVoAm_p1RUMMMc3SDyVRRzXKRBD7pw>
    <xmx:agcuaJIYjs--nrfdxflAtVoyC9F-KeiNzle2BHvdF8vL6pl9cIkbzKZH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 13:03:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= via GitGitGadget
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?=
 <opohorel@redhat.com>
Subject: Re: [PATCH v2] cvsserver: avoid precedence problem between ! and %s
In-Reply-To: <xmqqh61ear4s.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	21 May 2025 09:02:43 -0700")
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
	<pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
	<xmqqh61ear4s.fsf@gitster.g>
Date: Wed, 21 May 2025 10:03:35 -0700
Message-ID: <xmqq1pshc2vs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> "Ondřej Pohořelský via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> From: =?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>
>>
>> With perl-5.41.4 and newer, git-cvsserver fails to build because of
>> possible precedence problem[0]
>
> What is the exact symptom?  As Perl is not a language to compile and
> run separately, "fails to build" does not look like what exactly is
> going on.  "gives a warning and then refuses to run"?  "gives a warning
> before running"?  Something else?

Stepping back a bit, the original that the new warning complains
about is this:

-    if(! $refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)

And the complaint is that due to operator binding precedence, this
does

    (!$refname) =~ /pattern/

Unless the behaviour has changed as well as warning, which is highly
unlikely, doesn't it mean that the code was wrong, with or without
the warning, all along?  The intent of the code was to see if the
refname conformed to dotted decimal, and if it does not, the refname
gets munged in the block guarded by that if (condition).  But the
condition was a total nonsense.  !$refname would most likely to be
an empty string (unless $refname contains '0' or an empty string),
which would not match the /^[1-9][0-9]*(\.[1-9][0-9]*)*$/ pattern,
so we probably have always munged the $refName in escapeRefName sub.

Which I do not see used anywhere in the program, though.  There is a
call to unescapeRefname method, but it seems to me that
escapeRefName is never called.

What made you send a patch for this program?  Do you or anybody you
know use git-cvsserver?  Unless I am reading the program
incorrectly, despite the claim in front of that escapeRefName sub
that we avoid sending a tag whose name is not something CVS would be
happy with, we did not sanitize the refs and relied solely on the
users' repository to use only safe characters in the refs to keep
CVS clients happy, and the fact that this expression used as if()
condition is totally broken does not really make any difference,
since it is in an unused sub.  I have to wonder if (1) it is a
better fix to just remove the unused sub, and/or (2) perhaps nobody
uses cvsserver to allow cvs clients to talk to a Git repository?

>> Added parentheses avoid this issue.
>
> We phrase such "this is how the patch addresses the issue" statement
> in imperative, as if we are telling the codebase to become-like-so,
> e.g., "Enclose the pattern matching =~ in parentheses to force the
> right order of binding", or something like that.
