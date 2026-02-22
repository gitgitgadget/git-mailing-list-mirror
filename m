Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109917A300
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771738948; cv=none; b=Flp16xPhpVncPfpoyu2fvdV0na1MesYTX8pzMQnuERWi87q5BN6iMcG1VEYAf/2sUz9JAo09O6RdXtz5Qj81LU1FuT4uz6isK4L6C9kpKwigPLWm2Hs3oV7NVMgWhdbPrMsNQ3FiPtn50PaBmwaO5Yl7RzEDk1VjBeeNlbLf+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771738948; c=relaxed/simple;
	bh=2ybYEeQhMrURilsMgZwrZVp04r0Fq5lWuKL7jkYZDCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f0wToHS2HYkWADD5vxAelqOgphHHvF8wcQ6rIEhoN+K0uH6+ElXWeAHWVNspstyGTlu757HFZxZ9daGNhARARyHgocBe+RMev92wNu/7hHv/GUSC57VXDApg2Gd8T61zdwbNBmVOdQ5Z7+YwTfe+zqnn5S3ibmoTI+l+DJHux7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CMdIFVkb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FwyYYxKQ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CMdIFVkb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FwyYYxKQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C43B1D00061;
	Sun, 22 Feb 2026 00:42:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 22 Feb 2026 00:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771738946; x=1771825346; bh=cDss9LR/dA
	bKJ6oN1WBIkKwqxJw8fsoDn9fZ/Pw9v5M=; b=CMdIFVkbz/c71vQF0SAKyG65OJ
	Qnpuf7a3oIeKofoO8dYdX5xg8V92a615eV86vWvsDinWGCBu7vo1Ah5AoNRcYg1S
	4fvuxTtF0pz27ztk6jxIM/n+ID4o+qjm+IzepI8wCW/gPF9EZIFHk7oK+yjebRrT
	NyFRKOQCMBtfZHWGJclcYp0X9OZbBN5roP6fREBXpng5i7RTAtx7xRFCGeqztk1e
	pYrvPFbr4ciYI4PuG1JDy4CFQ6BiCE56YQ6qMsw6D64zlHbmXOdbM4mOVvDPqEiA
	Tu9PhZ3J4FWvqL22Y72mvpiIlqoO97gPfLECFAtEuzoswNRIOfCGHgXduSvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771738946; x=1771825346; bh=cDss9LR/dAbKJ6oN1WBIkKwqxJw8fsoDn9f
	Z/Pw9v5M=; b=FwyYYxKQRKwnqSMZiAP3Dx9zvk3RHSMYYgkJ4dGhOSGZ44lIlRb
	NeopQw124FZ/9HfmmOj4fwBJw92HROJJEQR1+aL45NqdCrMB3LhccovX5rgICj8f
	4IbTxuC5Ro1fiHvjVYrOQJBzhE6lU8T1ko8Z+g763pFRoRXcDGzAInUx3IjDw0jg
	BuT7KbrcBjQc1NFw+rcGxvAIECZEQeymehQrTBUxPB0otnkYT7scwfvA95U4Sg1/
	vX4XTXQR6XFVQOm8O/n8UhXhQyCzWvzNcplrD9gYwlDs5/qKbbbjs20yWPPijxXy
	bexASaR7YXUfGH2Kx+1/rgA9rVhTnif0yOw==
X-ME-Sender: <xms:QpeaadOQgmayKJGehaoakqj7zem455HVSa6i4mFKO2xN8rxC4OZ0Xg>
    <xme:QpeaaW_8Z9PnHIOC-GYFad_U-_aQmW5NwBvBe9tM_nVw_pzkPPzJhsJmpwx_eqwK7
    WghetOe-AkHGADdDraElw2hWYHGuE_NvwRtgpwEIJwv7JTY2KCZEw>
X-ME-Received: <xmr:QpeaaRRDUNaoegZJvEGEv6EoO-Eyd1Lz1YcJNh58pjHbU0S6SCkYRUyd5S8KdE-FK7z9qZmMDKajUVx2TuxvGDMp7zEk7I3BBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeefgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QpeaaYmVAGRow45b8-NUb3G0p9tzjaM3UmD-hYXyZYzjTfYbtcAlng>
    <xmx:QpeaaRT3JXDWCwen-4ldEXkXwIhITsgg1vJEDkx19cSgddihtUC3Ww>
    <xmx:QpeaaWN5LEkzAgL-iV5LxPZ87P7_D5kWqsBJca4o6BEdf3mWdye-KQ>
    <xmx:QpeaaaW0LWb234u6G6Tr88FLrD6YKfNMrmCco1iiBqbZkpDKwPpm-g>
    <xmx:QpeaaUyKKkdwbFmwu9xCs8jCJ9b2heJjnQxMyzdv7gFNi5SS8ijRsASg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 00:42:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH v9] setup: improve error diagnosis for invalid .git files
In-Reply-To: <20260221083001.220061-1-a3205153416@gmail.com> (Tian Yuchen's
	message of "Sat, 21 Feb 2026 16:30:01 +0800")
References: <20260220164512.216901-1-a3205153416@gmail.com>
	<20260221083001.220061-1-a3205153416@gmail.com>
Date: Sat, 21 Feb 2026 21:42:24 -0800
Message-ID: <xmqqseatqqpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

>  void read_gitfile_error_die(int error_code, const char *path, const char *dir)
>  {
>  	switch (error_code) {
> -	case READ_GITFILE_ERR_STAT_FAILED:
> -	case READ_GITFILE_ERR_NOT_A_FILE:
> +	case READ_GITFILE_ERR_STAT_ENOENT:
> +	case READ_GITFILE_ERR_IS_A_DIR:
>  		/* non-fatal; follow return path */
>  		break;
> +	case READ_GITFILE_ERR_STAT_FAILED:
> +		die(_("error reading %s"), path);
> +	case READ_GITFILE_ERR_NOT_A_FILE:
> +		die(_("not a regular file: %s"), path);
>  	case READ_GITFILE_ERR_OPEN_FAILED:
>  		die_errno(_("error opening '%s'"), path);
>  	case READ_GITFILE_ERR_TOO_LARGE:

The changes to these two functions require us to audit callers of
them that are outside the call graph of the main focus of this
patch.  For example, we see the following code in submodule.c:

        void absorb_git_dir_into_superproject(const char *path,
                                              const char *super_prefix)
        {
                int err_code;
                const char *sub_git_dir;
                struct strbuf gitdir = STRBUF_INIT;

                if (validate_submodule_path(path) < 0)
                        exit(128);

                strbuf_addf(&gitdir, "%s/.git", path);
                sub_git_dir = resolve_gitdir_gently(gitdir.buf, &err_code);

                /* Not populated? */
                if (!sub_git_dir) {
                        const struct submodule *sub;
                        struct strbuf sub_gitdir = STRBUF_INIT;

                        if (err_code == READ_GITFILE_ERR_STAT_FAILED) {
                                /* unpopulated as expected */
                                strbuf_release(&gitdir);
                                return;
                        }

                        if (err_code != READ_GITFILE_ERR_NOT_A_REPO)
                                /* We don't know what broke here. */
                                read_gitfile_error_die(err_code, path, NULL);

Let's take a look.

ERR_STAT_FAILED used to be "If we got ENOENT, it is an unpopulated
submodule so it is OK; it is so unlikely that we get other kinds of
failure and we cannot deal with them anyway".

With the patch we have been looking at, shouldn't the above code
check for ERR_STAT_ENOENT instead, to do the same "unpopulated,
nothing to do here, happy!" return?

This is merely just one example.  All hits from "git grep" for the
functions whose semantics have been updated by the patch must be
looked at in a similar way, but I didn't look at how many releavnt
code paths there are.  It could be an easier way to find code paths
that may need to be updated to grep for ERR_STAT_FAILED and
ERR_NOT_A_FILE, the two symbols whose meaning have changed.

Thanks.

