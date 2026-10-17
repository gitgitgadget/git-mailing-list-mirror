Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABFB18D62A
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792210316; cv=none; b=RYuH2rXdTqUD23WE7zANQ/o4mloan7A7zedZP5agnbEZkb/KAq5oJXjkeBDmlsitKtvrH52frNyqEm4CDQdIjQli5q6rpp5+5+xmVyoD8pyaD0v75ijf1E35jAnelqHcBRvrnyP3vQgqu8L/ttf3NyNcBgmxIJYEIO7HCW1Xois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792210316; c=relaxed/simple;
	bh=H2sXScczpp1S8vdlVbAOZy27uUSDJB92S0p/vRJyZBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k07uJ7yslX4KJN8QY0vFeOg/FLJ32xHLe+lqRGtI78tIwmfxTQpcepGY9OB49Pq/OkHDTcN1Hv2mFdNzIkDiVUgxZebNiNRNAfzJbfkH3wgfrVO2Sm0SE26X+gvi7vaelIbWYlg8ORFSFJI4cPpsnLejSKprXL2jLhhbV+9S38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BGD9hY/i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fZVWAnn/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BGD9hY/i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fZVWAnn/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C6F77A0156
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 00:11:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 17 Oct 2026 00:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792210313; x=1792296713; bh=OIBGJt1PFq
	2wGG1ejt/+zPPB3NV4t3SxJAR710TqGag=; b=BGD9hY/ibGD/LT5fdxO1UbWeb/
	USN1Zgpba4xIdPSgFmUM4QhM9j35dynKx1EnXZIwn9z8+Q3kienmD5DI8MMzNmTA
	OmvgXL6Fn7t/sexmjLvxoBKVLKkvSKvIurRHyw0EgjYIJNeaEiIAu8MJGVxhwlRQ
	KcGF20CwzGxXY9/rDGt1z1BWkd/SWoV8i9+i4ULxbcKl7a5GZX35qk841f0WhELV
	TNKZg+uohm8+PzoNHum0+YnhMXcrBOliigRLAx3KqCCAiapgzf7JvMjD3FSzk8m0
	ilNb9cYfZaZb4KPG86v3ZM7zJll0SI3/4g5apEG+ZBxb81MoGsGWd5sNjaWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792210313; x=1792296713; bh=OIBGJt1PFq2wGG1ejt/+zPPB3NV4t3SxJAR
	710TqGag=; b=fZVWAnn/SBrXolzJZb7Nzo3khv7hLcpDf8Yy9xRQIGhWz5PWyjA
	UQWzqcm380DCt0Yq/hdKWrzNoEKBPUWlgNF6X+5uG877+P3BzH/Iw28JK9LDF+zS
	bQ517Qs+K1XG4gFVGWRKqd58mDpN11wnrl7/bF0ydSYV+PHTdvHQ2Nw7zI+VQdJC
	LxOYxquF4Je198xyd1QKQE720HrX013i6T5OVf5TKk5/r3jDTmHIUF/EzYYn8tnR
	INneNCxkDGknMCGLZJJ+1wYOz/UkPW+oAjjp9PMCf24qDYc3ewagYzEQNR5nsehm
	YDkmMRcmHQTqun41f0OPRK5PLdgTR/lbeMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792210313; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:iQ4O43VFrFT61TpuuFa5u0Bd5X5tVpGSi0zlz0z66np8yTs
	3zpPgk05tzBfuhUJUesu/KqR9wj5P7QsLa9sLqT48TXwao74kXKApuZ72dHRGNO/
	cxJh+VVUwM7zeIA8gOA7JNVKXWzBFCcMMaRwBYCrX3ydkk4NSXFUqkZrXulNRJVm
	IO+M/ZynDxIbfBwP1E1BFc/hbS3m0xe13c0f0j6RajRc/848RsXRa34vM/PfZeR0
	ytTQ9Fuz0jPS8EOCBpgkV59wCKJa2OAIzqiNlkZHL5EvcaiXvViV63i5Y23+90Qv
	dpkvP9Cduoe//Cun0LM99X4FsYOwSvUUaEhGq6w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ZABGK+m/g177UJQYYGY7ZWS8ewYZ8/uT8Q7az6AaqoE=:H2sXScczpp1S8vdlVbAOZy27uUSDJB92S0p/vRJyZBo=;
X-ME-Sender: <xms:ifXSasmwWWXcEv-aGIlg2MkN_0CVVia-tkePENiwuUPcSZ0eWGoiug>
    <xme:ifXSavgcwvrphIdLY3f-nF8wsqHC2PExOCpj8mxO4IA8jmBqjxOHxDCpOWHPsLv8v
    D-3t5rz8nLGJwfqSzOmY071oj9CUiDLb7az7rsJ7tUWgsphNwBeRos>
X-ME-Received: <xmr:ifXSakeAEDgpXgQdmvjzPlPBCtlBApm0Zj2mXQh53RGx_FBfPvHKbcg6z_ag-qDXYBB3oIECCJoNYdga5XXcCjpGqki4XvPtxZqU>
X-ME-Proxy-Cause: dmFkZTELMn2o4KoA2cHMaL5K8fKuQY8M+6mcEff3S93JbGaqf/5Q5eVNWepNy74NzRi1Sy
    yqbLJrA9x9ks4SwfXC4NU3ILEAetPwe34alc2b9xjij3W/b9UgG9kyd/k4U5vUhCIujPdm
    wDvJApX91udRmAkHYl3zjj61z19VKloSAGXeL+LrvEHWVb5YnvLw4J9US64v+DekLimEzq
    94o377zIMYOP62u8P1Wmu6iVwJSLPS2dxruqHECHVwNzs8cftr/TVK0xlq9eqoD8WnoaQP
    a214sL5GWMD8f4ui2t4Vl/LYHzqZrh30eUtsdCdlq9Bd6Un4QyavQSDsFLX5TPVn+wI+Sn
    lehywjC+DTBpvcwRT2Hjg++1JoadVBPwYi02SS3NyFeXc/ad/aScwmKeIGgEpSS9P0s5jG
    dGmlHr3ZhZeivx0V/ik9TSiwhcnm7km77h5JLM0ff2SokNczGDvizseULtLdJTf8Lnhaxb
    kAyuuPGEBulNdWVUJjyqMzPZba7+5H8tCP6Npimn/dORtmgs5e4CTE7HCxDQ2Pp/0rPGTE
    AjhVP22mvQ/TFXWuigybCXzKbga7UbF06sH8fYOkSOW1qf6Vzj7waYslkS8r72B+rlqx+U
    EBjYPpwv8AAtLwlZbEf34T2AuBxLIKIcKfd2YKzD19nl4kmn10dmyDWMWe4w
X-ME-Proxy: <xmx:ifXSavjXp2m3lAuu-2hfjD3qOZurQWJmydS3wK-_Ux9S6-E0kyYk5w>
    <xmx:ifXSasyTlVfRcN3D6dJ3ityEFGQH9M2WHl3by3JCzmr0NemQP3dhDg>
    <xmx:ifXSarNUuWR1hfplUyWwYsX_Yykmxj1bj1UQGuathzhBwCT8d7wjQw>
    <xmx:ifXSatVYDsKfy8AtuGW-8B6fBnhc88JkUguS71l_gUcg9tbaZVyyvQ>
    <xmx:ifXSaqdHAc2UDX2qnlv5J00J6EBz-3zw20Peqv4Lm1nW7DfsH8FYXPgS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Oct 2026 00:11:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: Patrick Steinhardt <ps@pks.im>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/5] http: use `size_t` for byte position in
 fwrite_sha1_file
In-Reply-To: <395b47c0-6dc7-4a1b-b547-e5e68e7356f5@hogyros.de> (Simon
	Richter's message of "Sat, 17 Oct 2026 09:18:41 +0900")
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<70a909de18e8cd8d282439fb51a9399baa8c7be8.1791958171.git.gitgitgadget@gmail.com>
	<atHiiye4oi_lF5FP@pks.im> <xmqq1p9pk99q.fsf@gitster.g>
	<395b47c0-6dc7-4a1b-b547-e5e68e7356f5@hogyros.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 16 Oct 2026 21:11:52 -0700
Message-ID: <xmqqv771aruf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Richter <Simon.Richter@hogyros.de> writes:

>> I agree that changing the type of posn from int to size_t is the
>> right move.
>
> It is a position in a file that is being read as binary data[1], so 
> off_t would be the best choice I think.

Interesting.

The function writes out eltsize * nmemb bytes (both of type
size_t), which means the product could theoretically exceed the
range of size_t.  However, posn is used in xwrite() to offset
into a contiguous in-core buffer starting at ptr:

        ssize_t retval = xwrite(freq->localfile,
                                (char *) ptr + posn,
                                size - posn);

Because we are indexing into an allocated in-core region, any
valid offset must fit within size_t.  If posn were to exceed
the bounds of size_t, the pointer arithmetic ptr + posn would
already be invalid.  As posn only runs up to the allocation
size of the region, it indeed should be measured in size_t, no?

