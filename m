Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F226B764
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025235; cv=none; b=lzOdNxOQr8/n6SzwHAgfzfDm7PdjdbeHh3eLUTz6zF4v3+DDXibZY55vAkPV4mDpnU/ufSPRZydQn4mdUkX/HMjuaotlg6xwgqBB34zyvYgfc+MGcAubTF1e1/XNdOS4j69QN/2gv8bHevf0GRCenUO4wolpKvxXgavsktK4+jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025235; c=relaxed/simple;
	bh=4TkyQ11SCVW3wRPouFxLzpHRX6YzeT2yjut9jThLjnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHOikE5tFayfpuRN1rGxitkTWe0I9hwREA9M5RM8RYsQIfr8OF2aSiEx2hgJtGkImR5TCxtVYm43ZnnK+Y/bcC3vMQj9qPYgUZb60DKq4BPn0XJlZUSMAkxKUWogdITC1PQEhiDUkl89bBs1MhlwqU/tg3k5AmA9HilOC7/W6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PgAmmjfY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PgAmmjfY"
Received: (qmail 66927 invoked by uid 109); 25 Feb 2026 13:13:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4TkyQ11SCVW3wRPouFxLzpHRX6YzeT2yjut9jThLjnI=; b=PgAmmjfYS6cge3Ox7Xbfg7CfJ4J3234SFDuU4cAc3DV9ZVSyN5x/kRNKzzkkYwHi2SXl0hn/yz3A+yNNax0R+7/qbICk9R0nxSZ7+i+Zt9HSy+FGa270STsDzwpouyCmhsT1x9c8ARC+hWNXr4erJUjM8vdnz0lAvotrbX/hR7vYyJoxggOG0UPDRVHOdl5OPf68P28qufjIqH/Dcb3ZhDRig0YKLhmIkpQkYX0ukH2dVfCjKvTVARjWRQLLKIb/DKQt9HwZp8DLOpGFCjfkjYuFWwRlYhtUTfJXqTLb2cJ7FJJoPfwZOsfr9szrYSOs06yqvm/N+wCr4Nat7nxXbA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Feb 2026 13:13:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 198672 invoked by uid 111); 25 Feb 2026 13:13:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Feb 2026 08:13:44 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 25 Feb 2026 08:13:44 -0500
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, fastcat@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/2] for-each-repo: work correctly in a worktree
Message-ID: <20260225131344.GA2139176@coredump.intra.peff.net>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
 <xmqqv7flervq.fsf@gitster.g>
 <eeebc30a-40bf-40ac-a16b-ca5e128c3c01@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eeebc30a-40bf-40ac-a16b-ca5e128c3c01@gmail.com>

On Wed, Feb 25, 2026 at 06:44:51AM -0500, Derrick Stolee wrote:

> > Looking at run-command.c:prep_childenv(), it seems that you can pass
> > "VAR=VAL" to "export VAR=VAL" in the child, and pass "VAR" to "unset
> > VAR" in the child.
> 
> You're right. Here's a much simpler implementation:
> 
> static int run_command_on_repo(const char *path, int argc, const char ** argv)
> {
> 	int i = 0;
> 	struct child_process child = CHILD_PROCESS_INIT;
> 	char *abspath = interpolate_path(path, 0);
> 
> 	while (local_repo_env[i]) {
> 		strvec_push(&child.env, local_repo_env[i]);
> 		i++;
> 	}

You can actually just use strvec_pushv() to do this as a one-liner
(though annoyingly you need a cast because of how const works; you can
easily find an example with grep).

But I really think you should consider keeping config-related variables
in place, as prepare_other_repo_env() does. Otherwise something like:

  git -c pack.threads=1 for-each-repo repack -ad

will ignore that config in the sub-processes (whereas it currently is
respected).

And for that, you do need to loop yourself.

-Peff
