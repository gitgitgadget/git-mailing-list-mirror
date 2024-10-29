Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003D8FC0A
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213898; cv=none; b=tcOLh5ytjc+6qSi32NPvm/GbKiFOFvEDIZDFl1V806d4JfVKlIMlkCPl/qHx+Y+QwZCjISdBjUlmjfyTO9Qwqb5LXvvtRkQW/qQzDt/aPMN2Y8RXMWwqR9UdmtDgZerAR2f5V1R+HdD//pOQGY19oGK+XhjdGfPdaC4aWj12TNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213898; c=relaxed/simple;
	bh=zd035MT4s/8rI7WOlFynJ71g9Fb2o3aTzcfBEdOn6jQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMF+IrDFsHifGxc+igmEeUaZg9qqb/or8WMe8GohZfld5Pm/qIDg8QxUjDMpjFzjHIfx02quhE8QUqGVV9joz24zzyKpK0M2ZLqS5Aa7EXfLtqNypt4/GWNQQ9NFFxeM7YBgz6x4HeAtq45o7CZvZ+BP+CFsazYtPvSyJ0mFYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=pMvZ3Eqb; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="pMvZ3Eqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730213893; x=1730473093;
	bh=zd035MT4s/8rI7WOlFynJ71g9Fb2o3aTzcfBEdOn6jQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pMvZ3Eqb8/tRiK3/6A0JWKDvSuL7O5LNhBaYA+YBZN9TO2dXMXsmH+u7NXGWryO/y
	 4yxPP1ZL9bMVe3QOtY7WgvwXLnikKa0VGDbk3TlwixqLXEsKdNP55LKEMoRSSm0t7E
	 xnMc361wh/kq/sttWyII1v6Gsy9AX2vzJWxwhsdwXDeakj6N/Nkd/KNPQ6H7xn4nXB
	 nRvvRfhj6sc/aVohc4Pa9MxmYT9bAO8gdFVAezCuNhCT83fNxWvdEEPVKrs4qocGzO
	 mEOeysqMLVcTntaw7LqKjuJB8KUOU3evdPEbrwRj0nwf8IFzpSFQ/7/OFLaNnyzzoV
	 Q3hsqEswcgT/Q==
Date: Tue, 29 Oct 2024 14:58:09 +0000
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/5] worktree: add tests for worktrees with relative paths
Message-ID: <D58DMTM9YPBE.8L5WT8ZNG1CU@pm.me>
In-Reply-To: <985646c7-8a16-4014-a379-644408157934@gmail.com>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me> <20241028-wt_relative_options-v2-3-33a5021bd7bb@pm.me> <985646c7-8a16-4014-a379-644408157934@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: ec8311642c1851ca286ad2563f94b8a38c3f0742
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Oct 29, 2024 at 9:52 AM CDT, Phillip Wood wrote:
> Hi Caleb
>
> On 28/10/2024 19:09, Caleb White wrote:
>> This patch expands the test coverage by adding cases that specifically
>> handle relative paths. These tests verify correct behavior in a variety
>> of operations, including: adding, listing, pruning, moving, and
>> repairing worktrees with relative paths configured.
>>
>> This also adds a test case for reinitializing a repository that has
>> relative worktrees.
>
> It's nice to see new tests being added. If they were added with the code
> changes they test that would help reader understand the changes being
> made I think.

I had received feedback that the original patch was too large, so I
was trying to split it up into smaller, more digestible pieces. I could=20
go either way so it's really what the reviewers would prefer.

Best,
Caleb

