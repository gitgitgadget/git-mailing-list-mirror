Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1330342538
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108746; cv=none; b=r7z/ihpW1f8HYv0ytyODHtWhkoP13OAraU/hpgwXr5UtbX4sFxPhqOqXyilSaP4hRuRNiV7C8lSCj/evtYggZ4Apuy/KouuR9Toq7HDemPTVHFnt7NJfjvpSuS3C9t2keLo1NnXZVCnTt3au0FFeTplbqtInoniVrya0GMg/puM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108746; c=relaxed/simple;
	bh=mnPDVdWrPAsDDbDRXpTAbaW3GZdj1dxKAnhKiF5+MPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KEQ/isHmcrBEgwbRfymH7QFn7hl14+E1TVc1TwFQgzGt0RVa0jE3YPEEd9yeSI09npEGcY0Mb8KJl4MQXsPC7yorM/hy8tW9woLBVklAWiJ1xahlPXDYWn6nUK9qMBUzxvyESB0EmTWeIRIgGld6uNP1gw1e6Merd7fhvm59OpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QJegD9F8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UbwcdU3r; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QJegD9F8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UbwcdU3r"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 218061400108;
	Wed, 10 Jun 2026 12:25:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 12:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781108744; x=1781195144; bh=wyOyypWo9l
	xiq45lYOF3tAUXxSKhUAX7EAER2d1ZHy4=; b=QJegD9F8NwLpsxQ5MkCq2RN7op
	n+/0jJqiBO2pED9X+rhYT+nJCg+wr++mte09pSKh0CxmKeMV6cpt6Z139gLzm4QV
	XWaZSYObVRbQ8Qx/IFW6pY/n6MB+Gr2GmB3D7sKTU9+tpY4HUvynnD98LYaSRtOH
	CFgpGUP3JFi0X1dMVJpSHZDkJhOjHWtG8iywFUc42c3PNWpfrX7yLGPyX4JzdpcX
	qXmAG9lDQdGTJ8Vkej3W3ggN7Cgq9p1UEDZ4vY2sV4/IXoway++F15UPKe0BQTqE
	809JNoHTtDYkOut1HYcPl5QRklTMjisUKLlWkDSyQ9DS1fwWeKQgOEdz31ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781108744; x=1781195144; bh=wyOyypWo9lxiq45lYOF3tAUXxSKhUAX7EAE
	R2d1ZHy4=; b=UbwcdU3rHHCEK3MmyjlSJq7sFzD5UezM6iRAWUYpZpnbapotjTf
	4ELtQ5yEpBv9V5QD+OZk2pofNnZVxbnj9AO4RVXNbD11c6nZbR28Z9JEBPfaDW+J
	SnOccGbMOIgq3zs9vJzO8kSyclduAOVrApuxKODSRtuIM7GfgTYTAYwkoQxo0WVJ
	yV+Rf2krDDb4sbO3chguHk4ai+6ra/v1Fz6ACwK1vK0+OV632wFWUnvz3WfXW78A
	ZPhvMxu99hhog933z3f+//31fLoNg2Gj7IyexJ+DWRoTc9kCl9FOTuHzK+HBIoSE
	B3HO1sQNnOy5pFY2K5Y7jKaSLmYSfZukSxQ==
X-ME-Sender: <xms:B5ApajidR_p7HiAez6lCKL4f6e7II6kI19hncSxNzZLgzWLlVbBHRw>
    <xme:B5ApapWwS0thAwkS8gW05wpKLmnJbvtKE9QfhdgS9BfKeMp0-MQFd5KkGh5nI263a
    eXLn1-R6HigtV-C-9JoOBKQ5qg7Rr9b7ZtoKFi9sqmhC9nCj8Gm-g>
X-ME-Received: <xmr:B5ApaqXcsXXSnZ5881vpHXKTA0ORDzCagy7h7McSOxf6cnbbMgR_iYu-dg9dBKm_do1GsfUsSEDmj5SJLlwo0FKLBYGtoX9mFFC->
X-ME-Proxy-Cause: dmFkZTGNxSbFm+15P7cu+IevIqd8pwiTruqzX4AvLdW+AU6knWAibg9YnIHOF4R3uyK8Py
    s8+LwAWa28cAK7YnjNfRgtgSnWTV5hidNkFQJMR+a+H3OpoyXBX8eCLT97IvchSJAy/WAY
    LuOQ97sAtV58LS6QVF7uCgVBffKSXu84LB1UGFWxrSlHFJpoFfc77AOYN8fQmpsZRP3uss
    1qOF33/GqMRiyYhj4aRcWhmorC2l2u+Z6zmJcx3vjibNKs4pKOI0ZfW4izs90Qq27RO7vj
    p8LCIugtTe0G/r4qDDEznPNJP7sTYeaJvYMZAkiq8P5BFRFs9lv0BBvwZQtzkn2LIs3gSJ
    GaxWwFDszSE0fqINLKoPe0p9Llc+6Py8ief+U9h8BljXbD35J0boh7apse4ofL6zituVgS
    FaX0za76uTgTw7+C8AyTDhu8PsKTrXkx76n1+UX2L+77l5uPTxw9Vt+wGMJxS9+2klNzKt
    x1CkyMDfQAokUJia+owJoafAR9W5B4yreIgCl88Yweku1TvZz++9d0eBPlTJ9WjHee6aak
    AzuauXC8pbFHMNqfImkkpRPhQLonFihgzDV2Zyd5im3aED5MDYvmLiYh+I1pN7IPlUyrQd
    JW41rGj/ECwd5sLl9D757UctI4spkQKy+L0SQRk11HASz/Bf7ex0g/+OF4Zg
X-ME-Proxy: <xmx:B5ApahhPQ_bL9vFKjolimubSa2d-Bzn0zABpgYK13Er8XpZmtIAUFQ>
    <xmx:B5Apataz4BulNl2w-kwmfAf7hO_7f4B8V-dXPlxWMYEG0U1gWUTJ0A>
    <xmx:B5ApamraVBw1Njtohk4S5a8sqWPtetRYLKoswCjapED57CPyrRW4ZA>
    <xmx:B5ApaiMXWH1sBOAtLu0JE11MzSQK8zblQeIG8vXLdNkb-Y_Z8Vibow>
    <xmx:CJApamomhPgcktiFDLml5jwCELIghfuqcABpRoaAnz57b2bKY3tslrap>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 12:25:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Pablo Sabater <pabloosabaterr@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 09/10] builtin/history: split handling of ref updates
 into two phases
In-Reply-To: <20260610-b4-pks-history-drop-v4-9-70d5f0ae8c25@pks.im> (Patrick
	Steinhardt's message of "Wed, 10 Jun 2026 10:52:29 +0200")
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
	<20260610-b4-pks-history-drop-v4-9-70d5f0ae8c25@pks.im>
Date: Wed, 10 Jun 2026 09:25:41 -0700
Message-ID: <xmqqwlw6weey.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The function `handle_reference_updates()` is used by git-history(1) to
> update all references that refer to commits that have been rewritten. As
> such, it performs two steps:
>
>   - It gathers the references that need to be updated in the first
>     place.
>
>   - It prepares and commits the reference transaction.
>
> In a subsequent commit we'll want to handle those two steps separately.
> Prepare for this by splitting up the function into two.

OK.  I can sees how this will help doing a dry-run mode.

> +static int apply_pending_ref_updates(struct repository *repo,
> +				     const struct replay_result *result,
> +				     const char *reflog_msg,
> +				     int dry_run)
> +{
> +	struct ref_transaction *transaction = NULL;
> +	struct strbuf err = STRBUF_INIT;
> +	int ret;
> +
> +	if (!dry_run) {
> +		transaction = ref_store_transaction_begin(get_main_ref_store(repo),
> +							  0, &err);
> +		if (!transaction) {
> +			ret = error(_("failed to begin ref transaction: %s"), err.buf);
> +			goto out;
> +		}
> +	}
> +
> +	for (size_t i = 0; i < result->updates_nr; i++) {
>  		ret = handle_ref_update(transaction,
> -					decoration->name,
> -					&rewritten->object.oid,
> -					&original->object.oid,
> +					result->updates[i].refname,
> +					&result->updates[i].new_oid,
> +					&result->updates[i].old_oid,
>  					reflog_msg, &err);

Cute.

handle_ref_update() uses transaction==NULL not as a signal to update
each ref as request comes (i.e., non-transactional updates) but as a
singal to perform a dry-run, which was unexpected to my taste but it
has been that way since at least February this year ;-)

Looking good.

Thanks.
