Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACFD2931F7
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551168; cv=none; b=n3n3sG1IoczrKAmwj5kbDLeLnG98ov7gX2tRY9tUZlaaYlDkdOqcEgv4G6Oe8HNCEE0c2jVHKJMdyIuML/SF72MXdQLlLMI5EWJehcGPVkE4nHwhrnT3Apptytn37QiFl36nyxfNLGbZkdMeQzjxjKdrfvjRXdLZq9NjtIi+mC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551168; c=relaxed/simple;
	bh=XRNyPuP+GJ8AzGaSco3/wM4DoQcmMB0D6AXtEdUzvOA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gch0UNHarIKCfpHZRABCySnveuDWJd5zdSMEQrmrizuk1lkZhcPuCH8QupcxrmzA/BUVH8iC+iPSsIW1U3mm/7LAGpL4+m8+E0vy/MARk+ErJgyLLingj/CGwhNKs8kVZMchcZKSsTjr2hjq+mBWawIow3eykLdKW5pxQaxGa/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=Fkjv0hkZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vWQyNzIL; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="Fkjv0hkZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vWQyNzIL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DE7CBEC09D3
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 09:06:05 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 09 Oct 2026 09:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791551165;
	 x=1791637565; bh=bDao9z8MqoY8Yau+BbktrD3BG1V76D6L52jGDa9mNl0=; b=
	Fkjv0hkZNHaP/h6A2jVhB2Z81nh9gZfq+KTzRjEGqMGYofCwauG7zIQM1E65QNxD
	dXL/k0N2Yy62bl0gTWZDbaWeU/fUlj8ybUKT0GOWupMHOmMvZSlmeib4j36d1reY
	lHLCmFdK6F8kkP3hBAd1K76UK78itJ0j9Jr57aFED2Lbn8A3go2XgkAV0lC73hon
	PIEKWuAIhEgLxm71DRkA0Oe3MzuaTbhPqQXx6qw4sNeXXOzKE0CTdj5SaVdLOUwK
	w2kpfH9qVX3tSvABpTeq+N/OGsqY5W36Eohzn+Zm/t4vSg/7JdsYkE8L/KkmUOMz
	MqlwelY6FukzUKT6Es8epg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791551165; x=
	1791637565; bh=bDao9z8MqoY8Yau+BbktrD3BG1V76D6L52jGDa9mNl0=; b=v
	WQyNzILGUZ5DfoEfgTfr1/n2tOLuqJAZgjXsNbhFNnF5o0GPduxdS5uZiuRHcijA
	c5oh9mZr1ieRS25fh7yLCOrbs4QHdcQswuf48L5TdSQG7o0RRaHrjLVzRs4Uh6DL
	R9gAtDyBY+musOahdumemKrxf0JkL8WxhdDNktGhQIZj36h/VlIlxTLtGrFTFvUt
	zBO9yiX2qIkZISBpgCYa1D6U3CBOEo7db9GDUAscyh7mq4nVMv1EIMbVNqMKqzqc
	o2KFD8t2wQEi58nYQoU5bVN+UfgnIkpSVt8p7IjEzJgFgx0KD2jpwS6wg811Dvjz
	MbvaTwE+wy5q638nG4PAQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791551165; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GB5oEsrCOL1qsJ+gUpi/h/1ZAEaGzf0q4sxNtju2QB8ADb7
	1pqf7kdRzyzCnaFjc1MGP5WddQRJUbFXQ/zF1ZdpBFloI/k/E6Arojqjry1R1pCG
	SL2cSrEziqaO2JnD3hjIK1vKk0Rc476iZQU2VjvKrbySA6KSMf68EBovcux6p6lm
	i+D+WireN/JcAfugCep4Ia1udYbFUztTTus7QO458pInPHLmCdFvUDCgSiEG64Jp
	/GY5THhEJdouZ0cIG11GRwFJ8528jubhcnp3+83JXFa4G/f1AdFzASYwzl4YGbrR
	/B2K/ESK/oyzQCixFBauo4dx4HHO/ZhEm1EVmQQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:A3+A0R8H4kaRzKZz4+5TosKhmptIpR8IggrNCNMDrpU=:XRNyPuP+GJ8AzGaSco3/wM4DoQcmMB0D6AXtEdUzvOA=;
X-ME-Sender: <xms:vebIaqLJqHEw5-W1dq3TUi6iuuR-QBmLTequf8ni2QNLuDlfcX_aEQ>
    <xme:vebIas857EJ6eU9ObLF60Mtp-Eq--r0riVcPcpq-DksKOUIhY0e6NGxgfBXbQkNkf
    y14n-6VQJyrZEdFpJdLiyALIVX62yxOZ9h6GBovthBJNVSxuHMtXawC>
X-ME-Proxy-Cause: dmFkZTGJiIpE19LNQ0czhe2m76CoMTrZ/LfiruruHD4AQ/X+KJ2Lcsj+T18npIDy9YCAPS
    Y0FT7vPRNRpkhV28/2uckelQVMo+gEuGKyLwOkiDNCFAAyQJ8AVhzA8X+ARIRjH3HGtkw5
    Fp+QbGhoLRIjTDUcEDPDoixZj8z2aHq9+w1Mk/I1DD8V5pMPKAQKQgAdSPyEU07LDRCV70
    2UKtk8e/MyAwS3KfDWoV425YtA5//D/23oWA3CAImwygZTPMiF2WbUVvxOyQk04Ir0KyOQ
    fMFk432X2vGAopiBsi8itD5swT4DjmciCZ1MveDbC322KbsLKvzcmJx7gxWAa/iAs/3pAF
    0Kw0WOJqYhb6a9yNGEtcBNNQZZ90ONWD3w5zxnomaJcOFSGVVoCmloaJS+ig5jS8LwouyT
    /7bFJVDIEVY2k/hvQFO9RvxxBKo7vI5+j4BMvKEJ1rjz85p34N60lvrgzLw4doe556vC6k
    YOebVd4VytRuKzYW2Wh4I2qvvpT85QvDjOC10izCFWj1trjwBS4xVGLT27izZrDrMqwsYH
    VWAfAFi0oehfnynddGtA+A56KSux6u8vbtVZfqzhafgP1xP3JA5jWX+zl1R/mWQLIuzEfd
    AENCPGfXlmrvhtEoR+Zto5tu8UJX3jAtIt0shNPrTZLfinnhijxBavTmdBLw
X-ME-Proxy: <xmx:vebIaltFpM6YioMhLlZsIBEBd8Gsu4ntiKriVhuGqhZgJFXLjLMq0A>
    <xmx:vebIaj1dEPQiSNDspY_SQ6bV1oaOG8EmZQh4ajoI0WhRofUw_VgCCA>
    <xmx:vebIao9nJZQTEhhgH3gmPpFA47NpqfejJU_1MNCSyEyfI75eJcJyeQ>
    <xmx:vebIasMk3ss7gepEYOS1HqtCFntNkJ1Z_FZTqwF-7moByPZGsDxz5Q>
    <xmx:vebIaoe61wIWucZJ2xnOQrduq8AFWsyF1H4pFFzFep9RvPWEa7HgRtbg>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6BFD3780070; Fri,  9 Oct 2026 09:06:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aisr1WIbeEPB
Date: Fri, 09 Oct 2026 09:05:45 -0400
From: "Julia Evans" <julia@jvns.ca>
To: phillip.wood@dunelm.org.uk, "Julia Evans" <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <2423115b-aed4-4af3-a200-15939824d1b5@app.fastmail.com>
In-Reply-To: <3a716db0-4c40-4407-9237-f83c0dd37ad8@gmail.com>
References: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
 <3a716db0-4c40-4407-9237-f83c0dd37ad8@gmail.com>
Subject: Re: [PATCH] status: suggest `git merge --continue`, not `git commit`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


>> During a merge conflict, we suggest using --continue to continue the
>> merge for rebase, revert, and cherry-pick.
>> 
>> Change the `git merge` advice to be consistent.
>> Commit 367ff694281ce569edd8f6e444fc770f92f5d215 says that
>
> When we use the output of "git show -s --format=reference" when 
> referring to previous commits, so this would be
>
> 367ff69428 (merge: add '--continue' option as a synonym for 'git 
> commit', 2016-12-14)

Thanks, will fix in v2.

>> `git merge --continue` is intended to be a synonym for `git commit`,
>> and the `git merge` man page already suggests to use
>> `git merge --continue`.
>
> This looks like a sensible improvement. I wonder if we should fix the 
> grammar at the same time so it says
>
>      (use "git merge --continue" to conclude the merge)
>
> rather than
>
>      (use "git merge --continue" to conclude merge)


Makes sense to me, will change that too.
