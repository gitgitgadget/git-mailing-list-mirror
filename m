Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6715509F19
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782389; cv=none; b=GaObbgvjkzBpfbKyOzr0+AYps9AWCmrh7IZ+LJXxU8HA1ei51jB+Y59CYtJ3ND16fd7F+/UwVs9V8mOxHZ2KauehZ7gLPZbLRVIT68qXHSdm9UuUOhbI8bOLiE4jrwPTQD5c3AXqCJ0uHsXS7+PPrZI60JE2c/bqTLFtaxswILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782389; c=relaxed/simple;
	bh=NiwNPpNKeGs+gEqTSpnsJpwOj1QAIbu/Sq88IvEDfuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdU/vAUYE4gue889c8refLKQTD/gt546XVrOuyc+gki6enNRvQrlTZjrarmmDpeTso0BCzBHxjWBFdovBrUxdav0PVe+S17Bo+c5XqEE855E/LaKTDO+foLepLjtfvrcrtMNqlQrmG8o58OF4BqJmdPdtNHadj52WyxoDgt5hDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ideq0g0A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ODO+JSny; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ideq0g0A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ODO+JSny"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7BDA5140023E;
	Wed, 30 Sep 2026 11:32:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 11:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790782375; x=1790868775; bh=Fv3+P8XWTA
	JB8TY7wIY28DfZiyGIr/4JPWh4TdxvBMY=; b=ideq0g0AvAB2odtr7nCzgtkAD/
	C1A1Uv2iHeHc6Y1WbnXKJHR0krFEWoLkAL03vdu9qbWBRik5psBOw1b0rjiwROja
	wNjgeTiVm2CedBR1sc0UtFZYYI+gUQxiknTG0X37R82O1AaZxgy0oq7nEt3ymkRi
	mChVIuV0IDZ8aTZNsMYLS52CIC8KAJC1UW5DKvObqKC1VRnWd3h3hEKorLuMa2/w
	SSTkE9mhpxGaS8e60o6KttpHvki5Cuwfzyom/VvLWdLYVqhec6BfmT/7cTz/QG9G
	kqwi2qPlbbmRIwEqTX5yrtR6p/a30wlEj2wP9gzcNqkwOlg4meeZaNqWN2dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790782375; x=1790868775; bh=Fv3+P8XWTAJB8TY7wIY28DfZiyGIr/4JPWh
	4TdxvBMY=; b=ODO+JSnyHpIgbJBxUubVSV3powJj9iMxYn8YPeFxjo7RM+RUFtf
	3KAzt7YVmQ/+DEccnP+AjcwnivE2xNOQJ/Zyj3XDtFUh+TmbqIGQVhLl6PZk5ika
	pXbBVai9y1e9XH8zUUQz60KrPsNCEbWtTiAeDVPexV8UGKPYWw9wKoYquvu9XGl/
	u1W3c6ezw1TL/x6mfWMh8Wf4YhE2tnc+SGkK30/r9GIcUybQDr2nvWhZfpMqTJ4t
	DoDpIPx3yMjrEPNPn88Do0DgtfJw/3qJNaVk2o8LVaRS0/Q3PDbhbBiaTB+rX9Qc
	2Z11UvADA0LmL2QCY3zpn8QS9WBJP0T8kBA==
X-ME-Sender: <xms:pyu9ahnx408wVmOeP9lYtFheBEV9TruznzU4aGfTwjAgkDnqYcCjFw>
    <xme:pyu9akQViHFKpEgoJe6x5pGoC9Fp5A4H94b0HuJzqAMlfcx7RT_gcSapb03dgPA6v
    ObCOYnV_iV4O6T5_dbYl-OV5Lyci6ZbJ9uwCUlly-Oeqo8-q_equlc>
X-ME-Received: <xmr:pyu9alAuOmHiqYSQ-cMWDOKJgr4AebBk-uPFnitvSSPFnyMMI0lGVQ>
X-ME-Proxy-Cause: dmFkZTGa8Y2Qcg/BV/xbMY2HiAErV9l9soJz6ZsrijsSNi+3ggOx2QCtQAXEL4JL8tpsvZ
    jqoyJ/2K6+4XijuLEeHkfLr5GrqiVReZaCkpcbT+W83O4eEEWM7LqKA9BTcH0nHB0luYih
    KK5Evl4id9bLYGidVoYO0+3Ip2nQQl7bg0sha32MViSQiIWluS/+81CChnnNpqsBM3hUqx
    Nalbk9W19myc2gpAvAtCvb7LcZdWgvuTN4ocOPswN2vX6b+BCsQ6wduT4YKr7ihysCMItH
    93yYIian88My0Neiv/H4g7ANZTHFJ6r2UcRkftXWmHK0h7QfRLU8Bo6biVe5ez6zah2dnZ
    e0kczJ+/K+ZabTJIRt/t9eyQtkMC2pNwc1GR8wIWc1bTic4HdZfqAL0Fi4pfenIOGCbE/K
    UQxiucBHT1L7cX3/mKWqHAMl/bUCPmLU1EzSKEviP/3bKBDZ9Cbs+3r3SyN3Tg90FAoyaE
    wCr5G3LQ7tOQCHHfe9MoeikXTqPnAy7fGxMI+17ZpeiPtKkRyaRvnSTySUCnxF6/2Y+CjI
    roN77cvL8usnAC8HfUuvpO6WeGpJNKGOQohbslB74a2QXDTDGtnLs1lOLCTiFshWKlnM9O
    A7ZjFGbwhKY8rmxdhgO2/0t2xRkWjrasfW3qEy8QeH9T926i8CS2HqTxAcyA
X-ME-Proxy: <xmx:pyu9arQb7KWrHd-TcP-9J384LdXyr49DF-ZMujAtVUfVyLMcIPYKdA>
    <xmx:pyu9ajr_vNKMoaxa4a5OgmDUPhL0QyYwnJ0rTxJGzpQpwatm_oCxxw>
    <xmx:pyu9atxI0CfiGMAp0sNpNXqcdB5tnlrhkmsLAIzrL0HLmKH40Edvhw>
    <xmx:pyu9aoK3x3X6zIX2rv4FtOHzEVAnm8rCibt97mhxkAdB1IlDX0NSmw>
    <xmx:pyu9ah8_NnhMKTXyAKT80GlKr0wROlArVXhrJUvMZxvqyOSws9E2fNTE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 11:32:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7e6d164 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 15:32:52 +0000 (UTC)
Date: Wed, 30 Sep 2026 17:32:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/5] xdiff: replace mmbuffer_t with mmfile_t
Message-ID: <ar0roZKCwALv0n_A@pks.im>
References: <20260929064935.GA1276867@coredump.intra.peff.net>
 <20260929065239.GB1697497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929065239.GB1697497@coredump.intra.peff.net>

On Tue, Sep 29, 2026 at 02:52:39AM -0400, Jeff King wrote:
> Our import of xdiff has two identical buffer structures: mmfile_t and
> mmbuffer_t. In upstream xdiff these were actually different, but the
> import in 3443546f6e (Use a *real* built-in diff generator, 2006-03-24)
> simplified mmfile_t to a simple buffer.
> 
> In xdiff we usually use mmfile_t for input and mmbuffer_t for output,
> but they are really both just a ptr/len pair. I don't think that having
> different types is buying us anything in terms of type safety or
> semantics, and having two makes it awkward to use the same helpers for
> both. In particular, an external merge driver's output is read from a
> file, but we can't easily use read_mmfile(), since we want the result in
> an mmbuffer_t.
> 
> Let's use mmfile_t for both cases and drop mmbuffer_t. The latter is
> probably a more descriptive name, but we have many more uses of
> mmfile_t (and helpers like read_mmfile). So let's consolidate using that
> name; we can always change it to something more sensible later.

Yeah, that was my initial reaction, too. `mmbuffer_t` is indeed a better
name as `mmfile_t` indicates that it's coming from... well, a file. And
that's not necessarily true.

I do wonder whether we should just aim for gradual improvement and use
`mmbuffer_t` regardless or even shoot for something altogether different
like `struct xdiff_buf` and then simply not mind the fact that we're
being inconsistent. That would at least be an initial step into a better
direction in my opinion, and we can then touch up things over some time.

But I won't insist on any change like that, I'm okay with keeping
`mmfile_t`.

Patrick
