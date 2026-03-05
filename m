Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12327EFEE
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738265; cv=none; b=PdrrUSq6Nlyf7ILOuM9YrnsdQJCBu4sDaZW9pkDpirPBZP0nkb0UfOt3BOrmLZ/PqeBWWnPRwpC+ZQI04Ec2W5pbuaweBOjFIl+eDPv/SMWdYHdERlJqKwyvtE0JE3E85oLG6u9Qq7DA8ASo8sqoVhAlgKfQbo/NV0rlVX8yGGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738265; c=relaxed/simple;
	bh=D8+rJyianV9XgFwip1ltNw06qLB3CYQQLklfWFM0+Jk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t0+rPHgf1i1mBU2pj3nxv5r2BciF4S5W1ZjgcETmQgnQmaCIYJDsyxTS2m5nKDH281sQM2NFITAK69ZTPMLaU5FPE0Owx0C2E6Uwz73xJpUPUkupSxCW8jmEnNDvGbR5CsRxGBUfepd28snWTtPlapbMs3y21TeJL/wnKI/pMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AUUpZc0g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IzGS5mv0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AUUpZc0g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IzGS5mv0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DE8E8EC060B;
	Thu,  5 Mar 2026 14:17:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 14:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772738263; x=1772824663; bh=UKIVPiRn3b
	rNouiXBd6D+3c9/nVYODQ8QV9CKiu/EAo=; b=AUUpZc0geN7+GC0cGApqJtBEvm
	8HUXLTuS7nwBeuvQMrZV45mgMUp1hDGu3mCpwTfxzwjnlRCsG6pGNla25A/vARkn
	itKmtMXDFfkzhyq7t0SjgMmVq9T6w7tsIWV9KCUFFn7C9h4z9eo7/npsD7wiExZC
	up/DjOHmVRDNR9JZ424ULNkJ6sbW/FL6naIK4vmRUvK4X0VSbxjsxUYIrvhsUaks
	Q++8peOZy19ESn0xEMGfXB9GNfnxqthciDrA6y4i7lP6es9z79waOJSDqO5o7BJH
	yCyNoDhS5vyr2U4DbPvV8RFvSaAuiRahGt1iKzF3VrjzsfmWHU1WSW1wgPZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772738263; x=1772824663; bh=UKIVPiRn3brNouiXBd6D+3c9/nVYODQ8QV9
	CKiu/EAo=; b=IzGS5mv0XcC26Hi3wczCAk+mvfGdAbTz2eMW6lqzxsEDe9YclOi
	iFHG9CokEHPgA+L5/qCoPJ9Yu6lpWYaYhjs3mLtns8jf9idAeAL+UlFsqvWyXj2b
	qXltqkAKv6cFtEgII89i4oMtymb4d6LPc9nqUYMXPv3vlHYUqtEloeyOlxchVWfn
	wLOhdcJLYR7lcKO6R6LlDkgMQQSiGAtep3Nc0qkCD2rp9VAh2WJs5GpgujxC+hea
	YPEQ7P8lTep1tk3tAcOFtJUelgPf7FNi8LYhFPi1LlpVWkitDJ/b2xYKd++VbDSd
	ZAZMoAMfi/IyPg5Cyy5pLR7XbqB40Ah47Kg==
X-ME-Sender: <xms:19apad1aBm0IR-NzeXR16qfRlsu16GSmyXx9TOcF-FA5kwfvp68CMA>
    <xme:19apabH-Qe7kKx7fpEbkmPniUb1GegDiFprkt1NnIUWzxCPfnFT7NEjx0O426-Ar3
    eAwKSjq7N0mtDntzYEQQK9U-jzjr7RD5KP5D2B5uVD3fP5abmnOKtY>
X-ME-Received: <xmr:19apaS6FAnTRrwJVh4fnfCMLGhHH8jk6i9hlh-3o_vLogbWbLVfVqvVYS557MYN0baIWEpgVySeGKGWtd2FTmuTAWLj-D-HEfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:19apaZsWQizRZa9HmFUhQ7vjCXbb32uIrXDqimpdsZMvDpY1FiMUuw>
    <xmx:19apab4XmCbPTlg05nnlSflOYgEAmSetLNvsah6-j76G-t9242Ittw>
    <xmx:19apacUd1QkYxO8hIKho2HORVRBjn1K8IOi-wzoDT40WiHEHKkSzTg>
    <xmx:19apaV--A3hzQbBDhPtukP1hndZgq5MZXUhvyipxex0a0vTspCWSOQ>
    <xmx:19apaeawIJsgvXdKjGV_arpeEEjw6HDRk_iA3ZdqAaSvowHHnTs1KTlv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 14:17:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 0/2] oidmap: migrate cleanup to oidmap_clear_with_free()
In-Reply-To: <20260305100526.102130-1-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Thu, 5 Mar 2026 11:05:24 +0100")
References: <20260302200018.75731-1-kuforiji98@gmail.com>
	<20260305100526.102130-1-kuforiji98@gmail.com>
Date: Thu, 05 Mar 2026 11:17:42 -0800
Message-ID: <xmqq1phy3x2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> Range-diff against v2:
> 1:  1d544ef7d2 = 1:  a050491441 oidmap: make entry cleanup explicit in oidmap_clear
> 2:  f2c3a699bd ! 2:  b592d765e3 builtin/rev-list: migrate missing_objects cleanup to oidmap_clear_with_free()
>     @@ builtin/rev-list.c: static int arg_print_omitted; /* print objects omitted by fi
>       	unsigned type;
>       };
>      +
>     -+static void free_missing_objects_entry(void *e)
>     ++static void missing_objects_map_entry_free(void *e)
>      +{
>      +	struct missing_objects_map_entry *entry =
>      +		container_of(e, struct missing_objects_map_entry, entry);
>     @@ builtin/rev-list.c: int cmd_rev_list(int argc,
>       		}
>       
>      -		oidmap_clear(&missing_objects, true);
>     -+		oidmap_clear_with_free(&missing_objects, free_missing_objects_entry);
>     ++		oidmap_clear_with_free(&missing_objects, missing_objects_map_entry_free);
>       	}
>       
>       	stop_progress(&progress);
> 3:  a4e426bcca < -:  ---------- list-objects-filter: use oidmap_clear_with_free() for cleanup
> 4:  4116e5491d < -:  ---------- odb: use oidmap_clear_with_free() to release replace_map entries
> 5:  ad1f776a19 < -:  ---------- sequencer: use oidmap_clear_with_free() for string_entry cleanup

I think these cover everything Patrick pointed out, and I agree with
what these remaining two patches do.  Will queue.

Let me mark the topic for 'next'.

Thanks.
