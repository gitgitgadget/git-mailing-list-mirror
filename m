Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2545353A8E
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642696; cv=none; b=ggSfaQ6dEsvcBZ8sq/gwHqBi24a6QwtnFHK5/FCet8BOyBwj9O6BIgBW6gWfZviUKN/L6FZDjlNi4b556NV5RaFTRDOCJg+5Xi9l3kXcOxnH+LpLw2B/kT5LEr0I2CWW9kwiyyCCwAsX+AikJEmZOjgyHD4fmOYgr/7nOfNiwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642696; c=relaxed/simple;
	bh=rdXItg6M9Z1jtrUJc6r2/BrL16Cl+mr5hP5uwoSacOA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=RY1D363F/YknFV6eAuzjR8gjxpXsuOGSN3ekdEdyOp9/G5U3r2s+liUffLFDFon7B09jX69ztr2HAiU97KBErFJjYNsuPg7mkGPpbygWFmKI0sAMgqO6gMlCyJi3/bDE1jw6wzt7g7H5FmmJddF3TxmOhuV3/z2/dOI4b5b/4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ijVuKqZE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HiC6pVe+; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ijVuKqZE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HiC6pVe+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id D2B931300040
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 10:31:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 10 Oct 2026 10:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791642693;
	 x=1791646293; bh=nIP2+rmFbYRvCtTPUac19NvAvcBhtAr0m7/CAP6bmbA=; b=
	ijVuKqZEWFi8erbyW/fPkMu70imRTeAX/gMSDW71C3ysx47eoHMffA+adUPfs7Yq
	BGSIWWQSk47jsgkRWJYltrtDqzeTSw6w7A8K/lhmB6td2J3pBYZnUXchTcrxjm5g
	WJiXA4P/2PiEudMsjhlILoa4nYYdqcnADY7hB4vHI5uTfZzGeZleh/FuQV6shePr
	LaOfspAKn1yFq0t7XqTSZ9XHcXoAaBC96hjf7Z1H7VHHtLp8N4FXgi+R9pyocH1O
	IY/xkLt3WAKfOdrooarVoPYepyj3xJmN7TrqwEytaUZdpOYNcouv+U7Z73xSVxF6
	Cqak4CWob0Yp4x9AW9VAVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791642693; x=
	1791646293; bh=nIP2+rmFbYRvCtTPUac19NvAvcBhtAr0m7/CAP6bmbA=; b=H
	iC6pVe+k8WxGOUmHJQU7seSsZNrGom3Ik+w5r14ZikZ6VgVuLUfNEkJwJ+gIUrAd
	pYvT/HkTtK9OSOdl2ycUtMAPMd0NzWjBkcpouTjiyhsbjlQlCQH4fGYKhgCm4rvS
	d440Sj78K6s2q65xdhBAVWdQURHcvJaLPnk8GiuRtOYXXglCCPfMxD4cJU+iQm+o
	i9DLrs9SW43QE0a4s30xW/z0I1w4Y/fMrFqZgcD6BcgNwr5lj329US474ymYJHMc
	4gZe/SbOdNO+dQFvwtA/9SqdfNdY27pYqdypoYbqrsg+QY0JZTADLwxDhmLMIivJ
	8igdfRxZqJ7kUUtoxK/Lw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791642693; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YKvmyuzbOLNhe3yXFfsLRHhmv+pah5gmRQTjGHVyc9blvWl
	KVEPOPA2Wcfcr/A+Osb5cjvy57STMLV0zKLSX0rvqplYR28L8GRZyxSZloZrzy0g
	d9XxWHijPS/QqXRBUGc7D6iYO520C5XcAogcMmyPZmW8AMPoFeZYo2hIIrmwBI7z
	uwJL7dgcO0BzbmNSIkOzoihuceaW4T0dXOVXkxd4QaVox1/oaQHgdMBxKyVd/7AX
	jEgJqB9hdDkM9iDTkgN2xu3hywB6/ksBXInB5+wDGJYy5r9WsLMiLit9jFHLrAVN
	uyTTnNetFONgk7FMjvisKYgVHSZ659aIFKKAlYQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/6756KugSAfdaN74chKVIcG6GyaaguwG5ab9TsF8hxw=:rdXItg6M9Z1jtrUJc6r2/BrL16Cl+mr5hP5uwoSacOA=;
X-ME-Sender: <xms:REzKaqsKRPxDUbmIFt-Dy9xA4_tHLiBBi0hm3tPnH0jWKfzkr3NLdg>
    <xme:REzKamUTX8Wbeb8EuE-99PylmlG4iePegiHFDaEeUWDTucmaO7TtUlJ_StiGX9AXP
    BqJG1fztsqrcpprThDjXamhDx4tpilebYTIrR467UXUAlr8N76611k>
X-ME-Received: <xmr:REzKauGSFo_5W0WDNlNYFvW7lEviPrE-vnY2xvMVHZgdyePL5bKIQbzMzl6dEzuH2CSg2x-bLjuFR8le-uN3-MZvu4rocj8x5YZrPdG7JG__lS6JkjhaPwDvOg>
X-ME-Proxy-Cause: dmFkZTFuN4GCkMiXCOcSVneuEaf2sAySmpBYQrPeOuWGAuJaEDJjXjhitGcLJMVhU9KExR
    nqIDHrwxpeZ03qBP3EkfrbJYdvhLkuf13mFjDoDr5O0LFRKpi2eJ4eC3LRIexS5ZS5pPLI
    IHTRQ7PNI4mQUSTcdzci8OL32QKkysOySqYSjkSF+SYVv1lwxCg1eC8VFLy9mys9Cy/ksH
    9k0B9g6zgNwszHseQkUqRjvXWPR4jZeHNaYHPrY4Wo1QykXoBvVYYEb4Ly74Aw2SxY7XaI
    tXlWbWVCf525qdLlGKesPx7ipBY/KUppgyhJ2HIRhVof/KkawgYC4sUumxxl3CvVj7T7FC
    KBpgNiSt+nd3GWgDN/QUKASVkypVN96ItyO8FCEF3vREmUKfeR33zi5Tp/uH7uG+4yFupc
    1UzFLq6bAj0DC67Fs/5sDOQGkLVZEtL7rq8WNmrOr0DQczR2E9eIC6ZR/ZAHnkAY1RCoLl
    gYMMZnOIVRbB3kKPZ8R/PpXJSBDvPgESqdI+m96/RFJh27RQ6G25i/o/TSKA4ri9g9HVFN
    bkB24HaK5MF2F/KiJucItMli0UHDRBL2oSQ5G0Drf/3nOt0jJWJTnWF6NPFYuDrxePKMNG
    mvJ01/u4oCzFMAt1sim0RZ9KFM9YxHBaW+UWVjWS3qi6q91Sk+m66Ovm8AdQ
X-ME-Proxy: <xmx:REzKag3anz97CJZUTye4IRAy-LeRHF2ZBIpG4gMJDIU48u3h2K61Fg>
    <xmx:RUzKaoNCCTT0Ob-mVeiARqDmwdRpUfZdme5UBc8GZ4_ak0HYDbqXdA>
    <xmx:RUzKan5dc2h8aK8gD1mbxdIgx0RuEkb0GGja1hJMC6zMoWT7AydbWA>
    <xmx:RUzKaq1Kf-lSBcXsx1_aQ0XMmRg_d-jV7CsyK0IEgr0zqeow81Rbng>
    <xmx:RUzKaqb317ctrcAVsyx_EEIVT6xhSQPcKwGaVNzddkdXKO5_Ffc5KHL4>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Oct 2026 10:31:32 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 10 Oct 2026 10:31:31 -0400
Message-Id: <DM18BTUM3WZH.3S2G5JAJ93AXC@fastmail.com>
Subject: Re: [PATCH v3 1/1] repo: add filtering options to "repo structure"
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>
Cc: <git@vger.kernel.org>, <jltobler@gmail.com>, <ps@pks.im>
X-Mailer: aerc 0.21.0
References: <20260924164503.119506-2-markchucarroll@fastmail.com>
 <20261009180951.1628134-1-markchucarroll@fastmail.com>
 <20261009180951.1628134-2-markchucarroll@fastmail.com>
 <xmqqse2elg8j.fsf@gitster.g>
In-Reply-To: <xmqqse2elg8j.fsf@gitster.g>

On Fri Oct 9, 2026 at 5:24 PM EDT, Junio C Hamano wrote:
> "Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:
>
>> diff --git a/revision.c b/revision.c
>> index ee1df92d1d..79d44b58b5 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2837,7 +2837,7 @@ static int handle_revision_pseudo_opt(struct rev_i=
nfo *revs,
>>  	 * NOTE!
>>  	 *
>>  	 * Commands like "git shortlog" will not accept the options below
>> -	 * unless parse_revision_opt queues them (as opposed to erroring
>> +	 * unless parse_revision_op	t queues them (as opposed to erroring
>>  	 * out).
>>  	 *
>>  	 * When implementing your new pseudo-option, remember to
>
> What is this change about?
>
>> diff --git a/revision.h b/revision.h
>> index e5dabd18ce..63135c5f88 100644
>> --- a/revision.h
>> +++ b/revision.h
>> @@ -125,7 +125,7 @@ struct topo_walk_info;
>> =20
>>  struct rev_info {
>>  	/*
>> -	 * Work queue of commits, stored as either a linked list or a
>> +~	 * Work queue of commits, stored as either a linked list or a
>>  	 * priority queue, but never both at the same time.
>>  	 * rev_info_commit_list_to_queue() converts list to queue.
>>  	 */
>
> Ditto.
>
> Everybody makes mistakes during their editing, and occasionally fat
> thumb hits unintended keys while the cursor is in an area one is not
> editing at all.  Mistakes happen and that is perfectly OK.
>
> But a hunk like this one in a submitted patch is a clear sign that
> even the author is not reading what they are sending out.  And this
> patch, among its 16 hunks, two are such hunks that was never
> proofread.
>
> Quite honestly, it is beyond me how anybody would expect others to
> seriously take their time to review such a patch.

I'm really sorry - I honestly don't know how this slipped through.
I went through _so_ many revisions of this patch trying to make sure
that everything was correct. I caught this mistake and fixed it, but
fat-fingered and sent the wrong version. I'm really annoyed at myself -
I've put a lot of time into this change. I got the hard parts right,
and went and found a way to screw up the simple part - sending the
right $^#&@! version.




--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com

