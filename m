Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ACC19AA5F
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732982916; cv=none; b=DhnbotFCQBAj+GYPLNLU99e6DM63vGnSNjUq3yr5n11BPyRi9nwJ8LO7RpWnO4X1c97GVLd6g18N2wjn2+xNeCekSisJdgUcKLI0hUbbOTKycZD50HqoayGRNMlRbvONdsdolD5HHz3I4Gvr4uei81X39/+SEL8FJuaj6G71wsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732982916; c=relaxed/simple;
	bh=CkMJPGuV4f+5j4BNbwxCBs3R7ef0DZ5Z/7tH2MExKvw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0iFcKOvQVsYkjs1gtoGDFSrk/VCjvDnC0s7biM14X/+TRqmwnBsdau3uFpHlX9sMSWOekanL4egTVYhUzbyauaXhRnvFBbxEMg08qz2KVmqdpPlEm0wrseeLUvyV3387jq2fz6itV3aEHk1XcwHq19AKHjI/NXPneIUpk5Dwkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=mvOAg6o4; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="mvOAg6o4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732982911; x=1733242111;
	bh=CkMJPGuV4f+5j4BNbwxCBs3R7ef0DZ5Z/7tH2MExKvw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mvOAg6o4Ey+WW0NhZu5GouWuM/GMm7+eMPwToxoeKF7LFnVn4RBEQUjH36eTRzr0u
	 iHYHeDn68PWrJzv+qVMvJjfbrTP3USZymB6IB06SoHRaC91uuTc6MJXSzXj6rb1WGF
	 fKgk9gvbQPp9m27EbCua8z2gUPxmRqeROMuNPC1pSmRX2brtHNBZHEjNeg8jWKpB/h
	 jJcD/5ievYA3Gp4DcJCkWfIytS5XGvs6asGNAxhJfA7NMg38mQAgStF7Pxcp6/N/i0
	 HNzZpMx9wiZX2/7mBuuG9hvcwb06DoROUgiqMRCGzeAiOjVPaUmU0P2YbQwANN/u+W
	 QWSkkCxQ0jF5w==
Date: Sat, 30 Nov 2024 16:08:26 +0000
To: rsbecker@nexbridge.com, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: 'shejialuo' <shejialuo@gmail.com>, 'Junio C Hamano' <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Message-ID: <D5ZN60S3JMS8.UXLUSM5IOFCX@pm.me>
In-Reply-To: <00c901db42c0$38f95520$aaebff60$@nexbridge.com>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me> <00c401db42b1$99c4d5a0$cd4e80e0$@nexbridge.com> <D5Z1L479JERN.80KZ7NA9BWNJ@pm.me> <00c501db42b4$ea97e050$bfc7a0f0$@nexbridge.com> <D5Z1X36NVZ28.1FPA05CU9GFRL@pm.me> <00c801db42b8$a03539a0$e09face0$@nexbridge.com> <D5Z2R71VW1JF.1FZE1Z0V8H6Q7@pm.me> <00c901db42c0$38f95520$aaebff60$@nexbridge.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 8f83a79af82769083f801a25383a2ffb75eca16f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 29, 2024 at 6:38 PM CST, rsbecker wrote:
> On November 29, 2024 7:09 PM, Caleb White wrote:
>>If the `develop` directory is deleted, cleanup detection is handled by th=
e `git
>>worktree prune` command, which will remove worktrees under `.git/worktree=
s/*`
>>that are no longer valid. This happens automatically after the expiry tim=
e or it can be
>>executed manually. Of course, executing `git worktree remove develop` wil=
l also
>>remove the worktree and its associated worktree id.
>
> This last bit is an assumption, and not necessarily valid. Scripts that u=
se worktrees
> may maintain lists or their own pointers. It is important to be able to e=
mulate
> cleanup functions - something I discovered early in the worktree function=
s
> when released. I need to make sure that cleanup will continue to have eno=
ugh
> information - prior to git worktree cleanup - to function correctly. This=
 will
> need coordination with people who have such scripts in my community. It
> probably will not impact you, but I would have appreciated more than one
> release notice on this capability.

I'm not sure I understand the specific use-case you're talking about.
Could you provide an example?

However, I suppose I can add a config / env variable to be able to
disable this new functionality.

Best,

Caleb

