Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23465476CF1
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163160; cv=none; b=FNuAiPk5Blyebfdsb8KcTpqulEdzKUgVyzoKCD+0Pfz8zqD6bcuDNu1lWrNv6g8X9L9fkrxbp57Fr+2AuKtZuzQU0S+t6EukL3e95J/GcaBZgvZhM0Le2rQNSPTUWdKZEH91a0sgQuT/CpSvu8CDwYQ3KY38b+EH/Ox2sk7KCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163160; c=relaxed/simple;
	bh=gKxkqUyxQp1gPcbrCZsS3hRTMVgSTuvCLYADmyT/LrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Svuo2DLXR79ArdwXmzqK7hWNHjUYTSTqCPPCTzbCiMmhRwFLjaUbrLMSNUI0fjF3XcZDQ7jRJotY5EVPvINxPTH7nDXe/hIKfkVSAXwj2ZbK3HVatWIhhppWxAHV5gdfoFL0SpI5spWu54c5K8kKuMHJW3yIvpzRTNLRwvF5+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QzCHZsSu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oH/sQmLF; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QzCHZsSu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oH/sQmLF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3FAF3EC0102
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 11:05:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 16 Oct 2026 11:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792163158; x=1792249558; bh=gKxkqUyxQp
	1gPcbrCZsS3hRTMVgSTuvCLYADmyT/LrA=; b=QzCHZsSuvJplgNC+DYAZApr0dJ
	PB+V2GZFwJjaFW1apLDiQM+j/Ufn9TuTzXkDq4tdvxPJ8125iaLip66g7uPKE/Jk
	nbBTOcG+xZU5OplN3PkBl3yo68TicAOiYgkUPwuCCZG/jMiRblQK6VtckNEm1k6L
	uE1DCEPIWha04mqm5u3R8+c7dJ4t1A16u6689WJ10ZA3bVHVHl1IZ6GUkSnpYMtv
	4S4MH+xhXqCS7JOTsoofpayFBhHmjLENgjjJg4QWnyCLxmkw73K5j3U0jevBAqu6
	WIptlxkQRPdDAxQ4nwTzP/OFyX7Wh78Ffn/zZASV01RfpBKG/GpWp86M53eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792163158; x=1792249558; bh=gKxkqUyxQp1gPcbrCZsS3hRTMVgSTuvCLYA
	DmyT/LrA=; b=oH/sQmLFCTCdg24ZRnUlfXopIkOh1dfqNGIozFMo70OH6I63200
	iqW0ixdYmQcJrvXjsOwgXj5NoMcFr/jiaGut9yZfauwzqVwSMxcp8av7frq+w7xN
	/iLmfDr2+dNn6/4rUD6jQqEwvJTvRXP9ZsRbRVKIbwszUVgA5nXinpaTdMxwCSO8
	AsUT8ug5A3mUODrAPtIWSnhBPPbocCdA51Wg78GdGyK1+xkozTfDILDwvOB5nIQS
	HoHfqgig+KrP7lGkL3sVjajSN6oql/1OBuUDaZ6/lWgAsVtmOmTQpzeFmkBHks5y
	JheNMFur8kCjcVzICH7NWzUqr/juWrOD8Ow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792163158; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:oux0yXXe+Ow4dwkchfYTSwPi60avWTPnA9bIvGH2xTqmp1X
	WnEFbde3eIcC8OWo2CDU4fhqXnB5OMAQRNy1GMCgbN8YaKf5z5v/0dggS4vm4CKD
	rtQdd48EWkLxoYGEJpN58cT7kzqPj5eLe6p0lt1qxorNGKMZ0eCHfKxD/ogb0RcY
	S+j20kLcpO+L88lFyj6I+OjJLM1AxzTmjDeqLSMlEYh/RLxdlJngL049xW3TVDdW
	OT+ryJ1yzq6f1SfyQ0CcnzvwLNi5toqrnv/wqiCOmO+y2TLeLX0hLTiLVExUWjzi
	OsB8MFDD7j5eHPMEUDibTCOF9WMrovWbtHTfoKA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:DveiyDCJR7ccmBNLfuZ7Q4TycMxM2nipGnCEvVXaBYs=:gKxkqUyxQp1gPcbrCZsS3hRTMVgSTuvCLYADmyT/LrA=;
X-ME-Sender: <xms:Vj3SatMBXsSBRPo6KUXOUeBBG3eZ9zPMVCkZbJmvbVU3paTjs_nl4w>
    <xme:Vj3Sam0_W9VfI64DRPWqS2HsxWXYf2tY_-nF4vTuwEG196VDQGcrKp5UsBnAYQbMb
    KvPX1qtBKA1u70YK7SuZ8-SjHRhmyNHqMsnJ6_iW4PmAboHYF3T7Y4>
X-ME-Received: <xmr:Vj3SakmCZHRCeK_R1fbnaKRhBS_ORcMMY6MJf2RRxo_GtE0kppf7SDI4N84HBtpjLCTiSAzQbiAQAYwv8y7RDga-uK8Iu2WPV6_g>
X-ME-Proxy-Cause: dmFkZTFBbj7gZ9YeonSG3qdVtcKqnrEeaUPuPaNs3uMFxMAAre4nKh0Xt1T9arBhtK+cBj
    cFHOc2Z560RtNiqY+8XJyRW4hu0S/H36uK/8dh4SqqnK1CHzct8kSetc103Fpxcqi3plB8
    R44+fKfY6+dlK90nG5clnrp3FwWJqtQCb3RXn5/C4B4D4aY1e78GuAP5LBIy8KS/gDVkcK
    oZl2vSFFSuuSEVPlKEXGbbuNGCUx7NaiIbzeyllqVy/m0Uk7TWwWeu35F5GaRwF+KkCWY4
    MSFYjcgsy+2hL7hqYqkQ3R1YeiZRkouCa+mdEIfP/884XvKVLug+YNhIxD6FqhGtjZVGfa
    bkG7qWxXRgV7mHp8vQLysJStGzpADSQJl2eMJOMGTD5eVX84dXtcDLrMWQKw+EOBSCXq3K
    /mJEmJWUPxTPpTMUo3FHJ83aXZEU4dArxNu/f3x+cO0vJBTEZJodt0s6GmlLP0oEf+wQnv
    R+f59GIwafXQidCUXI4DjU26jEVlSdFL/smCkJJzyC2SCRAHHSfIUR8zpjLI0L3OJ6Ozr2
    4TpDvWD5AVjpzqNIFmbqP6T0HqnLami2BfepQHxd4R8p6Szt+D8t3IVO4ZILUCNl9Ifgqf
    7pLjhRPr2JHOM0lDd7rk0wR7xjUro+5/KTv8klI8W+7uPEwCLyIKtYlNtIFA
X-ME-Proxy: <xmx:Vj3SalU5xspH07LI3G8dEEh1GuGcWrBA28oRmXmQ5CqknImlbsK9ng>
    <xmx:Vj3SaiuEWjMTTdp128Ih6UZfzcD7j8li0RABJD6IqcWZgFOTVSR3_g>
    <xmx:Vj3SagZC6VU_12vbEWIIQgha93aKx4M22jFiSgn7WnRGc-IfBYRLzA>
    <xmx:Vj3SapXIY40YlSgPI4WpEeK0imThmBxpUshp0C9jR7yht8DmY_1CgA>
    <xmx:Vj3Sasm39M2Lkol4o-XJNpNVnVe7FgQ-A3mqRq4_StfscpGoTtVxTT83>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 11:05:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Andy Koppe <andy.koppe@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH] refs/files: keep root refs out of loose ref cache
In-Reply-To: <atHLkIADa6BlO_a-@pks.im> (Patrick Steinhardt's message of "Fri,
	16 Oct 2026 09:00:32 +0200")
References: <20261014153208.2194727-1-andy.koppe@gmail.com>
	<atBraYoY1SVwnezN@pks.im> <xmqqmrseooor.fsf@gitster.g>
	<CAHWeT-Z4n=txTGaBNuGPj3jcOou91owB59gvaPvF=2_p50eFHA@mail.gmail.com>
	<atHLkIADa6BlO_a-@pks.im>
Date: Fri, 16 Oct 2026 08:05:56 -0700
Message-ID: <xmqqqzhpit2j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Oct 15, 2026 at 08:43:06PM +0100, Andy Koppe wrote:
>> Junio C Hamano <gitster@pobox.com> wrote:
>> > Patrick Steinhardt <ps@pks.im> writes:
>> > ...

So in short ...

>> >> This raises the question whether an alternative fix could have been to
>> >> teach the cache itself to skip over root refs in case the caller is not
>> >> interested in them. The answer may very well be a "no", but I would be
>> >> curious to learn why you settled on the proposed fix instead.

... with this cleared in the proposed log message of v2 iteration, ...

>> A cleaner approach might be to drop the flag and change all call sites
>> that currently ask for all refs without setting the flag, so that they
>> explicitly ask for "refs/" only. That way root refs wouldn't need as
>> much special handling. But of course that would be a much bigger and
>> more risky change.
>
> That's fair. I guess the part that triggers me is that it's called a
> "cache" whereas we don't really use it as one in this instance. But
> that's a historical wart, and I agree that the proposed solution is good
> enough.

... the topic will be ready to go?

Thanks.
