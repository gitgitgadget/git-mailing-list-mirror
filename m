Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE92283686
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762498218; cv=none; b=MhNr2I+R7VwbK/E/aXJElFra03ZbkyHabNQq7ojzgPbwk9AUYW4UsmiFsoeuOnpxYr5QdA0BiogzUC2I3JtXu1A69lrOszIyNGVPgg9wvVFHAEb0qbj4QldcGDPzDGMnFV2TwP/JpmgEuwWC1XXPjPQx2PutBoVHUC7NiTLYOUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762498218; c=relaxed/simple;
	bh=ZX9rHRjncf6aUHw6fviOzIcR5mg/Rem9I5AE6N26or4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKazrIiWuaUPkw34B3McMThrAwGt0YRgqTebPnj8DvPF5rMhJB0bNBwZ1aBYzYAejsSY0HCVbkwivw6g56o/bb7Dy+iRK94LKCz0qxlN1RHg+22dAzMiSj8t8EURKiPXQR7DsidtooxoB1IvmALviFMCYxVnNdbY9inHujA092I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RbNStZFB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bSQwV/ON; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RbNStZFB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bSQwV/ON"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CEEE9EC0495;
	Fri,  7 Nov 2025 01:50:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 01:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762498214; x=1762584614; bh=uIohSJs0mf
	ceP0rw1zKC8ClPDVdFDsQsan58eGaDgw4=; b=RbNStZFBTxn/9G50QcnEdDxEhU
	eaauxnOrd+4Zc8626S43EjMS5TsRTvqyEWtf1z60g0V6LQPLu9V042T9UOVC7iOJ
	KQGY9MnB3zcJnJ0rb47Bnm/2J35zkDZNbwkfBDf292s1y/bmp1wwVXkK3ld1tAlW
	53JQnjmRVglyrTELYyIyx+bF51UbonB8datp3NbUNqjt8PTD59gL3KATbu4J+bKx
	la01+lW0kAl8j+QmVJWHF9+jqKqk1c90aH9482Q8zA66uHhLKInDtkN5vY8o4vVA
	1VwuePRt0y+qJ9wcCIUGHpZlXWksG30dKJAIa3+W1mVfHxiPlNE9IOxQ0LqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762498214; x=1762584614; bh=uIohSJs0mfceP0rw1zKC8ClPDVdFDsQsan5
	8eGaDgw4=; b=bSQwV/ONYZk+Zqwp7we+Zvau+eBrhJhC+l0hJvtDfP1edUgH/6l
	19QkRFY9f0UJjF1AKr3hLbx9+zOZa00zPRtVkS5W+njyI7zPcLrXGRrZ9PAAgh8D
	6hryV7WUH0HbVRh0brG+fNV3/nlEYeqrret+XT+CBadG7+HM3w/sdlDJQWQ0QhaM
	Kg91CaqRdrNMPz0thnKw5BwG4mGcI9dKvGJU+4Jyw7xvOPFyORWONPtpf2PSmo3c
	VH/0loAxD2JTIjLQkf/SosaOYZxcEF1d78X/JRj86SKkua+/71Tn8hCRNUzNXvOt
	YqF4qZNXr/RaGcETFdyNwy6xISb8WnuRjXQ==
X-ME-Sender: <xms:ppYNaeKmPHHsP1P542bi67h48j5BxQMgAdlCi4job0RJiwAFjZwsMg>
    <xme:ppYNacK5rWH3H6WCcRyWwJ1okJsAEX6FodOzxf4r-X-cMy0sytotmi_dazluuDWGj
    Y04N3ex7wvucsiJwErK9vfkyICitT6MbsGEsTnkPks0qF7GIMFU>
X-ME-Received: <xmr:ppYNacVZ_Vr2gyeQHgYHSKhyjXFnxTQsiuOkRzSfJBJnv49oStrPD2e7Z4Vv7eW5EocYJL2xq4TSVBfRr358KSMUrBWJ3sJCIqsvnUUZYowLAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeekleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejkedvtdetvdekvdetfeelveegfeegudeive
    dvueekhedtudeitedvgfeivdejvdenucffohhmrghinhepmhgvrhhgvggurdgukhdpfigv
    lhhlrdhpshdpmhgvrhhgvggurdhpshenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ppYNaeh__Bs4bM2-XKJhR8-Lq27MpU62dF9l4gCydysSkfoC3jPIOg>
    <xmx:ppYNaX9jE8kxkOBkEeY9dJ090Wct7e2OAYRQu3c33RiRsJ1PQE2pTw>
    <xmx:ppYNaYBiUYFFpNOp5HhduY9zQx_YR1k0T2uwdkZR3ag2KoV6aToNLg>
    <xmx:ppYNaUKjute5D9tUc3Hg-zYny7CxseuaaPHsdBxb8ACGxRpN_Ia-Uw>
    <xmx:ppYNaRjOKEZfnT36PUiWkgBSOFWgdO93HsIhCnVVWakBYV7BL2TgHocj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 01:50:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 18226ed1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 7 Nov 2025 06:50:12 +0000 (UTC)
Date: Fri, 7 Nov 2025 07:50:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #02; Thu, 6)
Message-ID: <aQ2WkAmkEep4AWqT@pks.im>
References: <xmqqms4zhxp4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms4zhxp4.fsf@gitster.g>

On Thu, Nov 06, 2025 at 09:34:31AM -0800, Junio C Hamano wrote:
> * dk/make-git-contacts-executable (2025-11-04) 1 commit
>  - perl: also mark git-contacts executable
> 
>  Building "git contacts" script (in contrib/) leaves the resulting
>  file unexecutable, which has been corrected.
> 
>  Will merge to 'next'?
>  source: <7fbb341e8f05fcde3a1543e3bb4e5a3ec1101692.1762280097.git.ben.knoble+github@gmail.com>

Yup. I see you fixed up the grammar issue in the commit message, so I'm
good with this being merged.

> * dk/meson-html-dir (2025-11-04) 1 commit
>  - meson: make GIT_HTML_PATH configurable
> 
>  The build procedure based on meson learned to allow builders to
>  specify the directory to install HTML documents.
> 
>  Will merge to 'next'?
>  source: <385992f6020703558f0ba75a1be6c4f9dae08b83.1762264709.git.ben.knoble+github@gmail.com>

Likewise, you've fixed the ordering of the Meson options, which was my
only nit. So this looks good to me, as well.

> * ps/object-source-loose (2025-11-02) 13 commits
>  - object-file: refactor writing objects via a stream
>  - object-file: rename `write_object_file()`
>  - object-file: refactor freshening of objects
>  - object-file: rename `has_loose_object()`
>  - object-file: read objects via the loose object source
>  - object-file: move loose object map into loose source
>  - object-file: hide internals when we need to reprepare loose sources
>  - object-file: move loose object cache into loose source
>  - object-file: introduce `struct odb_source_loose`
>  - object-file: move `fetch_if_missing`
>  - odb: adjust naming to free object sources
>  - odb: introduce `odb_source_new()`
>  - odb: fix subtle logic to check whether an alternate is usable
> 
>  A part of code paths that deals with loose objects has been cleaned
>  up.
> 
>  Will merge to 'next'?
>  source: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>

Yup, I think v3 is ready to be merged.

> * ps/rust-cbindgen (2025-10-24) 6 commits
>  . rust: generate bindings via cbindgen
>  . meson: rename Rust library target
>  . ci: use Debian instead of deprecated i386/ubuntu
>  . gitlab-ci: backfill missing Linux jobs
>  . gitlab-ci: reorder Linux job matrix to match GitHub's order
>  . Merge branch 'ps/ci-rust' into ps/rust-cbindgen
> 
>  Introduce cbindgen in the build framework to help interfacing with
>  Rust.
> 
>  More discussion?
>  cf. <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
>  source: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>

Yeah. I'll probably have to introduce workspaces as Ezekiel explained,
but I didn't have the time recently to handle this yet.

Thanks!

Patrick
