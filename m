Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB23D43B498
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702336; cv=none; b=EKfItjlGm2vr5eM3npf9+Y+RnP2fRN9HKdoR5rQ7WYBhtGYknXumv7xLToya/ziX5mQl8qLropIaRUqIt/5P+NAkimnWk3yfuuUX02yhLJfMPg7IZCcfnqtCH0Hr5fwGqdqgUUqwR+8rx6L8c6JUTVXHSfqwOlYEhQZSnzSpifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702336; c=relaxed/simple;
	bh=ojBXoqm2ONbR80i0AxcxuH6iYUf5ohvDoLarJw9cYMM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QFA4vUd61vPbl060yiQrvAJv9vzjTf7W4j5vxIAPFC2175dn7L1BQFjNUOxGQdnGid8Rg5Do2C31SMQ5tG+947T+QYNWJlWRyzEtf7RAlCyjOebLNeZIEatzPVjRrHMU4uJ9pUzKNPHQRxNqbAdBjHAzEPHqmvl8q/GPX37d/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bBsBwukE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kEy6Y55O; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bBsBwukE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kEy6Y55O"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id B2DBEEC0183;
	Fri, 10 Jul 2026 12:52:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 10 Jul 2026 12:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783702333; x=1783788733; bh=00+54WCGhj
	J/mJ0gE8LOUdwQX84A7kC3h2SCbsoMm3M=; b=bBsBwukEmW19AmnhzODbpR0daJ
	tDoZ84Vbpf2Ik1/91sqaNxAzm1q8XUy7knP8eyJ/nsfYJf4Q2OIcQKuJBWFeZ8gE
	VbQ5WjWJSHF37xkMS1rjq5X04aPosr49H0LqnsBoAptz8dTKUSh7lNltUf7BhR7z
	lsHQeX5MHgpIs8x4swH+9BdCjQAaO3cWff76GILRxINWc4xlKEhr4Dj8ANw5BV2z
	rZbqvZ1mJT/eZFlNxvPJiCzsf0MFlau2YrSW8Tqwd9u9RZcsh5T7NB1uy79h7ybO
	PF1MqIA0XW8hngMI0HfHNqJQlnAnnN4sRVo0gp0fgeqPQhczjRk5b7sLcqjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783702333; x=1783788733; bh=00+54WCGhjJ/mJ0gE8LOUdwQX84A7kC3h2S
	CbsoMm3M=; b=kEy6Y55O6+ZkClPxe6s+Vg7ECJ3xpAzWhgn1ZgwYQeUFqg5Hq4h
	gzUj1baiL4w4zpMpdLSRgtmtQZgXaWqrWRcwhgioNYFGgnWkvH5xmX8OOVoqFr6k
	HVYRi3shrlaId7zCzPny3FPmHGXZWtrbFmY01cruUgOprp7fh4QSGxIWX2JSUuGH
	C730y2hiAmB6Leh5ogQuc2p6g8tVMYkUt//sNhFYOX5k6tYTRYh+Ra0LG9LCyFsA
	bKNfolfTCpdFFbFQxHGzwhV7Z/BffPytNNjHzwLiormKGzSn8NC6+RCEAT+jEC0R
	3zNvTLxyhOeASQZdpvoYGquaP3gD7IDvPAw==
X-ME-Sender: <xms:PSNRahn1qUhdgMs9c36Vq9Ez4xQ8nh0Q3q5nwIUhLRxoDN0qEjQkwA>
    <xme:PSNRaj2SzKbzJLVK0l5jurzwV3qYvivddmTvMKS70JQYh_CbZDfKG9GlPeULLD-LJ
    D3zwCwmRTl718SQTCKw4LuOvdZsI7YTCeFoNqmDnJjxhpL_-E7INA>
X-ME-Received: <xmr:PSNRasofo_QjHJlCjsJBKoe9l8LdZa1prFIWDbvFGfwDkKiH0nd6W3r-VrpoRebMNYRG-TnPNLqaQ6eGjjKBDUWiUkxjPuW6fBmYjkc>
X-ME-Proxy-Cause: dmFkZTENMrUIag1y80ks3y6Gej5/2N5plugUEJes8kQ8t1JuCOCjIEcgNBFzrjyqCQ5vya
    NkAZq5Ch5vu7XjvYyen8sAyMB+xVHHOb2/563PRzWRDYjw0rfAotRTWirLNKDKhBqks3Im
    40LsktI+kNK1006XqIcDe1xRxyRogJsKuE8v993rYvDRmvhBzC1qjU2WzpK5dKmYO8UesJ
    eTEQ5KhoSzkqgd/gCbyFoY+OBYclmazAjq7wgK6TOD7Xim4QMYobFZbkOls3knv19gQ0z7
    j8jFOVtqforaNM737cZPd16JrSnT6xMjrbhi65MJ8RbSWWzoA+kfqIXDHv7kTDZQM8kEGb
    yCwtdHi8PIt1/X9/XpwNU2U0WPYGGrZmYTLWu52w0GmtNe6rGqOOl+oXLlf3cLxs1WSLZB
    xFWfyCx1Bzkd/+OH0P2y95/dKgGPrPh+NCwXxf6bODTSFIWABb4X4Ca80GuhuFBBYPT+q8
    QoV49CmG7wY03MFHt+08Rf2qnh4jhxthbJGhg9SiPwvAiwd5cW3onSUPgMlgf5+GNJgcB6
    zWVYXvcfRVNJBm3YvhfITnBt94+0meHb6jmODSetGjG/J5JEFTMdncWMl+QbYIw9us9FDY
    OrHpo/LzHhMbtwIy1cQ2+A4SeCKXMlmsM4tdQ7eFz9sCvC452N388DESNF4Q
X-ME-Proxy: <xmx:PSNRagcTXAuaKVcZEBciK1PlU-XEiWr0O4iV8-6cF7vV4Ijqd1K9sg>
    <xmx:PSNRarqZAdkxcfVezbVkVh64VZvtHhocYwFSgLnzUzKUfPxqx0e71Q>
    <xmx:PSNRahHe2SePBzsSAUk0xTqBtiNTxGoWOQS_n8W9bCi2-EZTIdwC1A>
    <xmx:PSNRarvm3bKlF7Wk-zd_y7Pu_AthpFGTiI0wZkKY5MzAzgAW5grQ9g>
    <xmx:PSNRaoImdvzvvYlJUuEk4bdWTt54D8_175cTinQ9e_HPqhKH1aJgTE2D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 12:52:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 11/11] builtin/receive-pack: stage incoming objects
 via ODB transactions
In-Reply-To: <alEBEbwOMFkVfuk9@denethor> (Justin Tobler's message of "Fri, 10
	Jul 2026 09:37:19 -0500")
References: <20260708041412.1157499-1-jltobler@gmail.com>
	<20260708235925.3992097-1-jltobler@gmail.com>
	<20260708235925.3992097-12-jltobler@gmail.com>
	<xmqq33xsrfeu.fsf@gitster.g> <alEBEbwOMFkVfuk9@denethor>
Date: Fri, 10 Jul 2026 09:52:12 -0700
Message-ID: <xmqqtsq6dbyb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 26/07/08 08:49PM, Junio C Hamano wrote:
>> Justin Tobler <jltobler@gmail.com> writes:
>> >  			update_shallow_info(commands, &si, &ref);
>> >  		}
>> >  		use_keepalive = KEEPALIVE_ALWAYS;
>> > -		execute_commands(commands, unpack_status, &si,
>> > +		execute_commands(commands, unpack_status, &si, transaction,
>> >  				 &push_options);
>> 
>> And in such a case, execute_commands() returns without committing
>> the transaction.  Is there a need to add and make an
>> odb_transaction_abort() call or something in such a case?
>> Everything should be cleaned up upon process exit, and on file based
>> backends, we probably let the tempfile/lockfile API do their thing
>> to clean up, but are there other things we may want to clean up?
>
> As you mentioned, if we exit before committing the ODB transaction, the
> temporary directory will get cleaned up when the process exits. I don't
> think there is anything else we need to cleanup that wouldn't be handled
> at exit though. Regardless, I do plan to add `odb_transaction_abort()`
> in a followup series and I think it would be nice to have an explicit
> "abort" here when we know that we are not going to commit anyways. I
> would like to defer this to my next series though.

Sounds good.  We cannot trigger receive-pack as a subroutine call in
a long running daemon until that happens, but that is OK for now.
One step at a time.
