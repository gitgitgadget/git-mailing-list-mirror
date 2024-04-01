Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656847A57
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988268; cv=none; b=Q2Va+S6asSxr9GLJhb9T6WV7ocjy0XylBw3gdQG6jUcDwV8sNXe50dtwxW2NzivbxT+71u15xDRq85IPIshuoprOeuV05/MJ9Mf6FTnG95SxsummZYsz4o+6qjYK/zr4xLVUnWDtDcGaOM7J0vB+cg/U0OZYRy8fa1f9dOdzsAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988268; c=relaxed/simple;
	bh=Oc2YEs5inPtSZHWmuzSBMPtY6euVdJjX0H9wXpJJjZI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UB4N9QAojSSG9WbZ6U+Y+7GYTtcbuDM/MK6kyReRN/7NZwtdRIlhqEKrMnrXoC1GJMcHC8KEun75jmW8gJiUfvXOxyvZjO6YmUhyNjDkYMebQ5oUB4P4fqThpYnx/TE3EzIiV+c8nFv/7BnrBmx/gWS0Vb9OfQYP95enHWRVAtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L+3S9w6t; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L+3S9w6t"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 88AC21D456;
	Mon,  1 Apr 2024 12:17:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Oc2YEs5inPtSZHWmuzSBMPtY6euVdJjX0H9wXp
	JJjZI=; b=L+3S9w6tXp0KNH9sHzYNtKTnp72NG5k61aNpNPQxhJm3uqE2qmbpKt
	PDjumoioGRmQiGoqFFI+KHrylrba3gdqQYZvjgSHBspUU3oBRp/I/d/Mo6fngxIj
	kZO+tmV5A9E2NVmDCKERrudHq92d6UE2PN+edZa/vr8ySMYoS0Brw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 805EC1D455;
	Mon,  1 Apr 2024 12:17:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D932D1D451;
	Mon,  1 Apr 2024 12:17:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
In-Reply-To: <CAOLa=ZTLv39b4Q=AAUA39tXKgOSuu54xk3-r9OUenzxR-6qcag@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 1 Apr 2024 04:48:02 -0700")
References: <20240330224623.579457-1-knayak@gitlab.com>
	<20240330224623.579457-8-knayak@gitlab.com>
	<xmqqy19yf40l.fsf@gitster.g>
	<CAOLa=ZTLv39b4Q=AAUA39tXKgOSuu54xk3-r9OUenzxR-6qcag@mail.gmail.com>
Date: Mon, 01 Apr 2024 09:17:41 -0700
Message-ID: <xmqqv851awgq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5E3480A0-F043-11EE-91BF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> So perhaps we can say "update with a concrete <old-oid> will ensure
>> that the <ref> poitns at <old-oid> before proceeding, but update
>> with 0{40} as <old-oid> to ensure creation is deprecated.  update
>> with 0{40} as <new-oid> as deletion is also deprecated.  Use create
>> and delete for these two deprecated operation modes".
>>
>> This assumes that create and delete currently ensures that what is
>> asked to be created does not exist, and what is asked to be deleted
>> does exist, before the operation.  If we are loosely doing these two
>> operations, then we cannot easily deprecate the checking-update,
>> without breaking existing users.

Note that I did not (and do not) know if "create" and "delete" have
such checks; I expected somebody (other than me) to check before
going forward.

> But this still means we need to think of the best output for the
> reference transaction hook (following commit).
>
> My current implementation of:
>    <symref-target> SP <ref-name> LF
> Should be changed to:
>    <old-ref> SP <new-ref> LF
>
> But this means, for creation of symrefs <old-ref> needs to be "zero"
> value. Also there is no way for clients to differentiate between regular
> refs and symrefs here. I wonder if it makes sense to do something like:
>
>    symref SP <old-ref> SP <new-ref> LF

What do clients see for a regular ref?  "<old-oid> SP <new-oid> LF"?
That would be OK, as "symref" cannot be an object name, I guess?

> Where symref is a fixed string at the start, used as a differentiator.
> This however still would leave us to deal with "zero" values for
> creation and deletion.

Are these two <old-ref> and <new-ref> values optional in the context
of your discussion?  The review comment was on input from the end-user
that made it optional to validate the precondition, but this is what
you produce as a result---if these are not optional, then an empty
string can be a reasonable "zero" value.  I am confused...

> Perhaps the best way here to actually be a lot more verbose and have the
> hook output the following:
>
>    symref-create SP <new-ref> LF
>    symref-delete SP <old-ref> LF
>    symref-update SP <old-ref> SP <new-ref> LF
>    symref-update-forced <new-ref> LF

It is unfortunate that the input to the hook for a normal reference
update uses syntax different from the "--stdin" input format, i.e.,

    <old-oid> SP <new-oid> SP <ref> LF

but it is way too late to change it now.  So to be consistent,

    symref-create SP <new-ref> SP <ref> LF
    symref-delete SP <old-ref> SP <ref> LF
    symref-update SP <old-ref> SP <new-ref> SP <ref> LF

would be the three operations.

But this is not an end-user input that tells Git "I do not care
about precondition, I did not even bother to learn the current state
to give you as <old-something>, just force it".  The input to hook
is what we tell the hook what we are planning to do (so that it can
decline), and we do not need the ability to say "I do not know what
the current state is".  So I do not think you need any "zero" value
in the input to the reference-transaction hook.  And I do not see a
need for the "symref-update-forced" variant, either.

By the way, if we were to use symref-{create,delete,update} here,
wouldn't it make more sense to name the command on the "--stdin"
side the same, i.e., not "update-symref" but "symref-update"?

What I suspect that needs more thought is what should happen when
you request via "--stdin" to create, update, or delete a symref,
but <ref> is a regular ref, e.g., "symref-delete <ref>".  For
"symref-create <ref> <new-ref>", we would fail if <ref> exists,
whether it is a symref or a normal ref, so that is OK.  For
"symref-delete <ref> <old-ref>", we would fail if <ref> is *not*
a symref to <old-ref>, so the case where <ref> is a normal ref
is already covered. 

Should we support "symref-update <ref> <new-ref> <old-oid>" that
makes <ref> a symref that points at <new-ref>, but ensures that
<ref> before the operation is a normal ref that points at <old-oid>?

Or should "symref-update" work only on <ref> that is an existing
symref?

I think I am OK if the answer was "You can only give a precondition
in the form of <old-ref>, which means you can only turn an existing
symref to point at a different ref with precondition protection. If
you want to turn a normal ref into a symref, you have to force it by
not having a precondition, or delete the ref and then (re)create it
as a symref".  But we need to decide the semantics and document it.

Thanks.


