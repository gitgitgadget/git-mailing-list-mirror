Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45A51813F
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033322; cv=none; b=Xh1i2XaUIKwMJo7wJbzd5fCxwB3XzVoZ2zQphvJHWouOPkthRS1KeDir7MyhK1/Xk0q+nbl5CXWYbKzDL1hv+Gap8Vq807NQraAOWREE4zbazQ3TrgvLThvF+wjXZBF9nb4V5SbLNRe8jxyM8mtN92ftDnAe1aBn2x1S0CjyZ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033322; c=relaxed/simple;
	bh=ZmfVn+CEqoO+9kkNsZmPkbLJKlOO8F9vNtl5ekpuDrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PSgpJ3gXiyff2oBWz82biIT1FzAF2i7eeplKhfgNmdsPZogqoX8FkgYw2BsHp546eiaLWqYwNa4xu0s2drVOpqpa6apCvYr2kitncI84Uj26eDrNlKPvRs5TFDQ+Ukgcd99utGlT2lIWObSM3uExvOqNkkJ1H0zuZLdtxQ9XfgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J3UeHt28; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZ28nDyf; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J3UeHt28";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZ28nDyf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 902F5EC02D9;
	Mon, 21 Sep 2026 19:28:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 21 Sep 2026 19:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790033310; x=1790119710; bh=KNBOBh39Xd
	41wiw3JjMbiUwHPD9YNT5cJiZ6D5yEbjY=; b=J3UeHt28BOJ+cAabTv/wCFGmq/
	keesixyBh24aHByBzdDOaQxkRtx2+ntKi6Z54fXQe4ancaGyzcNbEqQbKJZLn+nE
	tL9UduC6oIug1MI15WjYQ2I3IDNoyUoxngTPsExSpLF7tYZL5ZLlzMlb60RzWFGL
	ezPfweuPvZCI9dpQOxEMVtiLtNuKevsRI2Js9E4IzUDWYdPvCaHQvYm2M2qLgV1B
	/mBwf9OozdpD4v4XbcX6ocGXFzFghlxy4mUvrMgm6OOyHC7ywPEW4vhNDW+fy1dB
	IcdLzPO4puCPCTn9K5/HZpkuky2jL2Ya9GCATtsEnAb++/ybau9EemjGWEzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790033310; x=1790119710; bh=KNBOBh39Xd41wiw3JjMbiUwHPD9YNT5cJiZ
	6D5yEbjY=; b=dZ28nDyfCnhQYbwdlrvsk9LgoBJSzku3NMwPpG7LtPsnhZQGIIi
	kklli6lgYwYNJ8W3/W5jTnCiJ2dq/hKCl/ch1j7Uub37DRdMCmu8gdKfzXBaMLKl
	WuKMeL2mgQu/03nmCNANrN0SFlGCBkO5OinnT8WZzFG6hO7+yb9vkAp722src4oX
	w2s0Tb5kVXPmDWjtqhf3hzJEbdJKLu26RmoL3v79zVkRhSufWyYeC4jNXbV2c6ym
	VJsjcrcOGYDjFDMU+Ggb6rAqI2LXPq2kOFi9mXRHNURipJA3FIqlKuikORmdEQMb
	4oCk4/Ooi2mFm0Y2KAvJJkZQWE72/DdWCJg==
X-ME-Sender: <xms:nr2xaph6S_WTTMWA3snEyApa4CB93NYMob_ElPXGAnBhP-X8Subi7w>
    <xme:nr2xalCDlnhsb48aKufgKA7xZE7fVYkb52S-PrQ93iRksy5qngS7NUh69l3lYYYth
    eegKCjsfp7eGj5ik0invpGDYg8PKjDhP2zzY8OrGBVosXCXbGnUXA>
X-ME-Received: <xmr:nr2xauHWuW3pbUJn6Ea5kUQQLWOUgBrKLIQa-02RArJbSlHShO8tVXFpjvQ0oPQvFJ-FwnQaG61TAPkw2fpCUjHDWQ2F1p4MKmE8>
X-ME-Proxy-Cause: dmFkZTFOTxhNggpRQ3jx0ja+GooO1vIBcDAiNl8OgNeQVrn9Jq75dzqoxMW+/VcXZLRE1r
    Rx9ibJ1RxmF19zaSpmfSFiVeN1BqCCcOrdMQtEBkAkeGy/dnhcA7iiZTQbiW+vwYNdGF+s
    LdSqngYYIYeU0pvcVTuUuVog9tLnItgnzVYFsYD6zzhw8CedE5IQC8kMX9SxIj2EFZMrJD
    Y/dn92HdH0BH609oFkm/FCnRtgqSgF2I5scb8C80pLsiu9vzDVp7t6REy9SDwN4h6ot3ld
    Kdz+N1K7uO1+QmtPhZN3n+XhRiMNQtwJ+Vy/FbWpqKIxjjjqMGbszCRvzSz95K+EnPKyJ0
    MgTcQ5UrYXsHc5+PT6l2mG5CL/3aItl9EbDa8JJmPa/SYt6cpR2/3w3oJWuzAUGPgzIpTU
    vlQuUxKfr9d/l/ljuKptFqUbK4lL3Nvmje8m20xlaZWQ0uIqjlZidikt4RiJ+vsdUwMIWt
    S1piIxj1IjBWEjHxtr+J/aG71clH4CXq3wGyya3ouO45JjiKg9iNVO2EQKigGEBlrfAce6
    QukxuTRkkWlWfR8FOepaHc9GPI/9K2dqg1iKtta45uueak7CwFjN26hrHO84HOCVteZboc
    /gQLlUA6f7DkTUtQDRzIibeRgKl0er8iSf2JWNy9V8/kXBAyNeJNKJbcbrVQ
X-ME-Proxy: <xmx:nr2xatKxur3ffr5u5DXfQN0T2ci9FjK3JsaOksXN4dP3lMH23igPNw>
    <xmx:nr2xaimYGTvYgC2BnmVXLgsnuBkP40JCoyuZ14HbGhunBhmFlhVZsQ>
    <xmx:nr2xalTt_Ep0w-7DgJF9EpYrB_JwjrNAGHnCa1ExFtaGHGWiuqs9rw>
    <xmx:nr2xakKYRVTRYzI9ehojGM_WJFpqLEfdtnKAky7g3UIIKDJmn871zA>
    <xmx:nr2xalkA-TyygwiHq0CspHFUkvBT2CkYQbDD3zIRdlyA0IjBED23og00>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 19:28:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] refs: run copy and rename through transactions
In-Reply-To: <xmqqjyoemqvu.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	21 Sep 2026 10:54:45 -0700")
References: <CAOLa=ZTN1TU2A1sgEhiw=ymMYr6Ge11cMEubSaeKqr4WNU=2EQ@mail.gmail.com>
	<20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
	<xmqqjyoemqvu.fsf@gitster.g>
Date: Mon, 21 Sep 2026 16:28:28 -0700
Message-ID: <xmqqh5jijiar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> +struct files_copy_or_rename_transaction_data {
>> +	struct ref_lock *lock;
>> +	struct object_id orig_oid;
>> +	struct object_id destination_oid;
>> +	char *destination_target;
>> +	int logmoved;
>> +	int destination_exists;
>> +	int destination_log_backed_up;
>> +};
>
> Good to have a type that can be used to hold pieces of information
> specific to the operation.  Can't we do without rename/copy specific
> addition to the generic ref_transaction struct by following the same
> principle?
>
> The comment above the members does make it understandable, but ...
>
>> @@ -240,6 +253,21 @@ struct ref_transaction {
>>  	void *backend_data;
>>  	unsigned int flags;
>>  	uint64_t max_index;
>> +
>> +	/*
>> +	 * Rename and copy operations need backend-specific reflog handling.
>> +	 * Their logical updates still live in `updates`, so hooks see the
>> +	 * operation like any other reference transaction. The fields below
>> +	 * retain the state that backends verify after taking their locks.
>> +	 */
>> +	enum ref_transaction_type type;
>> +	char *old_refname;
>> +	char *new_refname;
>> +	char *logmsg;
>> +	struct object_id source_oid;
>> +	struct object_id destination_oid;
>> +	char *destination_target;
>> +	unsigned int destination_exists:1;
>>  };
>
> ... is it the best we can do to contaminate a rather generic data
> structure for such a details relevant only to one specific
> operation?

More importantly, this structure suggests to me that you can have a
single rename (or copy) from one source to one destination in a
single transaction.  Is that correct or am I misunderstanding the
way this data structure is used?  How would one rename A, B and C
to X, Y and Z in a single transaction?  Or perhaps rename A to B
and copy C to D in a single transaction?
