Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85C50AC33
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869263; cv=none; b=UAOoBJU3vMqnGZs3lx64xbixMHjUUq8YYpy2KIIM8yogx8OuT5VU5r/Ft4XbuE+HoHA3sDMNNYY3Op/TB3AlKvR89dzozNjUUaLyujv2QLO/2NF6CU2ViLlGwHh4mGog5lRm0w7NYvworsz+VVuYnb0YY00Xasf66PnjIYCNMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869263; c=relaxed/simple;
	bh=6IVTdB1qSGMHDoIQZlYMj7HJlDkGh7WZbNhsfJBqXz8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YjmtTzjEC3pi7TpbedIhIK/7KhBr+6ncT/BdbfaB/TtP50kj99Buf0hV6Q3Vts3RUwOn4EOcvmo5P74bsg1lEctyuklAFU66S31r57aM4XWjqIjrqFfnu/evQL+LzdqFGgtk62bDV52Aw9HRueN+0AynK/CD7mijc/TA1TL7HOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TIS9AV/k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V3M1foiJ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TIS9AV/k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V3M1foiJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DBBE2EC0180
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 11:41:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 01 Oct 2026 11:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790869260; x=1790955660; bh=/mAdagCW/P
	y3TrwR+opFpdgaliWj+PRBAOUO0bjzdoQ=; b=TIS9AV/k/2mEVBHOmgVzG00ZZ9
	U++l3hJHrXCHes7I3jSC994+z19gwiWRm8buVq+JfUbEur0izzeju/iXD3d4pXHI
	EKBwGaXQSHEVhLQl6Pl4oz1n4HdqtOX6/vIzSFIv5vKbK4/92DIrZcg8DHqDIOit
	+LNCoQ5AKaRHdhE9qTLOIsJw5Ge/5RA8qxzK73QZVwUX7apHQx5lBaF2U1AA9OUz
	m24nfHynU2xtGaUYAks8dJ8JSY0EYDGm72ubGaRUtGpO55Ja6V6Nxy2dv7aaLQ7j
	vfxQbL/XoCYP7LHbQyqBc/RLUwUAVfZWDfZeA8s0SMMLfFK+fhR74lXcxtyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790869260; x=1790955660; bh=/mAdagCW/Py3TrwR+opFpdgaliWj+PRBAOU
	O0bjzdoQ=; b=V3M1foiJdw6RVFr4xGCW1+AgHhvG6OgSLpO8kkAItR3WsWmXdHP
	YgBMD9YvKyUVm7pHVcc1Q+hMA9hopU+26rx5kDV+9ERDdf+VFjebnBIkaFvBuyKE
	RXme1C2VS2ZpOZSdgiAqSm+gptR03vP9CncztucIHXB4UBkPT//kXIAvTUjA+4H1
	xQwilEQ/9dDyCgh6pKHQ3rloDkAHVM4DPaBlfyNXWnegr9yUhcb2EUDJZcyzpnYk
	p62/8EYdhrKuHCTHVoRmeJ9bvdU4lHqh9jD00xng2BDxj9nAAi7//oAxTScwvz+y
	sOM94QDX1jsjLIKG9tJtff+2Y4/FBLqfeyw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790869260; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:isW/adC6klZQJ+riydHXlP+NQhdo2wZE6RjfmKJsTHOmX8e
	bHjfIG/pT8CE4J6q04Er52QVHQ/hZg+q0t52k/trwqa9zA0M2l4l0PYUCcU4lBPd
	LQob+AMZwTut9x2DTQfoUpJmdWdHWuC9GEwCvDbvNbASm3i85RCD93CXv3i11FHA
	CxfsVy6sE+LqVMdLonApn9Nvzphescb3fIssPrO3lr++pbrqZnixKyn3Nqyn4X4N
	WnQcIr/fD16tMdEU96qC4OjChAUq8BouAN/Qc+oNsLMLaY3PWaxHTWxDifbtswT2
	5COrstYYn2BJG7A0QU4ARJQSmJBIVBOpKcJBP+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:9LyZA+YlECuW47AHRwjS7Biabi537zBFYsR7H0B010o=:6IVTdB1qSGMHDoIQZlYMj7HJlDkGh7WZbNhsfJBqXz8=;
X-ME-Sender: <xms:DH--auOISlsNZ3WcYqkZNm5Nr3GC1KCXj-zxFr2-Ptsh8ZlAPEpQNA>
    <xme:DH--aj0hKfxCn3rXl1TmalWdKzO7EklGEYS2PXYMx-2ivytPFkgNU3VvrQJcAoAUD
    e3CzkCPLu37n2bJqO2M2QWWnOnbKQPMhxq4QdDwTdoYXyG2ro_BQCs>
X-ME-Received: <xmr:DH--atmHrn4Td-SQgEkELXvIDhxNsdkkyedNkAjCcLF3VwMqg44emH3eGXLcCNx2XQU77mkEaYyxSr4YMXZIyEKrZNSQ83xBXeqL>
X-ME-Proxy-Cause: dmFkZTGukX/alvJAgAiHYTkXpBRTQpjxd9DFPcsdxKlzBY8xaBOFbAG1L+pAZcx0/f+N+b
    7BbwsZdEDLSPee1ylAzsJMHg1K08X91i1iG0aiXohETOrAbAgF2dR0GqnhPYSzWVq0qYTR
    Kdvc7bXInqupoWKZknp3ZVsj5rnT2j7XzEOAArw0u7y977OkoO4lqGxrI6Q99ndjXkmcDf
    lQO+/qDZgfWKtYu6SS5NSXzAtVPTtBzdFQ1U7896ZGR+4Fqe2UhEeU4EkjNiH14yvHEDD1
    1V2b6U1aiB62JRphBQzTFrSjGJtXzHlpEMufNM6fo7BnoyakSm6MYXlFRJ4xqvl53iLtSu
    RY4++5GieyJH02dgwavr8ZeljLSetKqGPPo0ckxOJ3sagNKhtPrZe8lLZk6Q/5kR703oJw
    idN3783RgFSQEukmBuS5PoQBpVgqa0FvOGdHvphAxWFzCs1IycB7RMgml6EMyORXa664yd
    zL1PsjXKLxQXh8Ivp84MXERK0Uzx+9V9y45d5KJufVc/EsqyFXtLAY7DblMdDtTiCVifd1
    qRxaBw4qtrSzApbihEmM3+oRtIyfj4nBD1wIYuuNTnoRNRn7NEwakVYUpnPlQqeoIhK39F
    qMf7cnnxA0w9K/SP2AN1aGEJpSiyX38AsnvLxArv8q2hDz4sT3psq2iCGmlw
X-ME-Proxy: <xmx:DH--aqX3Ca4xZT89YMzFFqwvfehficvtJLCwQ_h9IWakROQvKeGkcQ>
    <xmx:DH--ajts7qV60osCTjZqxGMFsxTrTsONmGLutYVhvwDwv0LFoeFG7w>
    <xmx:DH--atZwIdAwbud5WMEZU-rwHA7HhsItQTlCLcB0cwLsx5ciXhjfRA>
    <xmx:DH--aiWXHpmKtWCDryycoRW8lUFomeJlxelbQAfXaTvS9_78E_0MXg>
    <xmx:DH--ao2J5Pvhh9aJsjvF4zanIax4J7lwJIW68LCdhNqrl5GGU3ujR7rr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 11:41:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 2/5] xdiff: replace mmbuffer_t with mmfile_t
In-Reply-To: <20260930224613.GA765052@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 30 Sep 2026 18:46:13 -0400")
References: <20260929064935.GA1276867@coredump.intra.peff.net>
	<20260929065239.GB1697497@coredump.intra.peff.net>
	<ar0roZKCwALv0n_A@pks.im>
	<20260930224613.GA765052@coredump.intra.peff.net>
Date: Thu, 01 Oct 2026 08:40:59 -0700
Message-ID: <xmqqld8h77jo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Sep 30, 2026 at 05:32:49PM +0200, Patrick Steinhardt wrote:
>
>> > Let's use mmfile_t for both cases and drop mmbuffer_t. The latter is
>> > probably a more descriptive name, but we have many more uses of
>> > mmfile_t (and helpers like read_mmfile). So let's consolidate using that
>> > name; we can always change it to something more sensible later.
>> 
>> Yeah, that was my initial reaction, too. `mmbuffer_t` is indeed a better
>> name as `mmfile_t` indicates that it's coming from... well, a file. And
>> that's not necessarily true.
>> 
>> I do wonder whether we should just aim for gradual improvement and use
>> `mmbuffer_t` regardless or even shoot for something altogether different
>> like `struct xdiff_buf` and then simply not mind the fact that we're
>> being inconsistent. That would at least be an initial step into a better
>> direction in my opinion, and we can then touch up things over some time.
>> 
>> But I won't insist on any change like that, I'm okay with keeping
>> `mmfile_t`.
>
> I'd really prefer to punt on it for now, just because the diff would be
> _so_ big, and has so many extra rabbit holes (e.g., should "mmfile_t
> *mf" get a new variable name?).

I am happy enough with the fact that mmfile is shorter than mmbuffer ;-)

After all xdiff is about comparing two files, and if you do not have
files to compare, you create mmfile out of what you have (which may
not be a file) and pass it to xdiff, pretending it were a file.  You
tell the API that that mmfile has contents from what path etc., so
at that point, the argument that says mmbuffer_t is more generic and
can represent any non-file sources does not really matter, I would
have to say.
