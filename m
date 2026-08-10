Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF9A156661
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786334525; cv=none; b=rYEjJupUXXDE4tznckd4r1C2ILCbalEVReqCjdI6GZEQIDSbZNvdspE3JTi4tHx2lIp6yYS5cdPW7pRxTEAhim/j7vos2lPe/Ei6nE7zYTF3RvXbfIGjn3tiu/I5bi6HOp0IlvEUK49oRI0vX9QjXLOI1q6uxewv1LVpGOhml4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786334525; c=relaxed/simple;
	bh=KLI5/nvBsBmrP9QHfT2bRV36VC0NpeuDxPeyLNpcaAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DGYZHuF6O1iZ9+s6kp8dzj8yNaEpYrwpIlkvINZtdFka5Fb1l8BISDzPhhjZbZLrXOymAoCrV3blhj/PsCTWC9sVRrQnwy2xZ9BVamFsdNAjXsk0ZMO6dljHEd74NVGpCp6oc1mP7/p75UqRK6Uf4JeTB4LFur8dkweStms04Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M8+ZNYNL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hhbhLLT4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M8+ZNYNL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hhbhLLT4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 73C1C140002B;
	Mon, 10 Aug 2026 00:02:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 10 Aug 2026 00:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786334522; x=1786420922; bh=tyUjb9GJYf
	wCnIGo8WIapgMQmmQXMGSiu090+fWY0Bs=; b=M8+ZNYNLTJ+yjHFqOTwyLD5a7z
	eEeeZ1r//aOsXRRG7xMwO1PlRf9cTQ7rsBsSAWVD8YyNmWV689dWmJTuuA1S/cAF
	CGi47E6HZ/LcnbwuIpoLCNPcam9N0nQvCwJ/Rm6p5ZU+kWGGGJqsTi+8Gn/mxy9w
	HLCyUnnpYtiegOWvIvl3/1WZOYKw/9YIue1Auwc9GeqHLGHt2gcMxycFBwwBhGG9
	8EoXNyhsnrJ9oBRRGUTck5TNzfQcmWMAUcXeh5vehl66pdWbI5gPREKoxMQbu6Lr
	TV00yP3lMaiX0zz6EceSPx9Llus/jt/PQzoSgucR/744w2nuzjBQiTuM0NgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786334522; x=1786420922; bh=tyUjb9GJYfwCnIGo8WIapgMQmmQXMGSiu09
	0+fWY0Bs=; b=hhbhLLT4X/Roqamme+kZxGRqmJTrm92dox0F7iHQCGPFtO3Wmoo
	1LzRgi+y/qmQtZdTOamirEIaAonviyxYByMC+GrP4uNsZaru0WLssfHl3smy7Nl0
	kGT59+DyuTfVHS52sGFlZ9IeGYyRXmYGtHA5r0BRtFeIyyTMz2pbnRQZjfVqiG5e
	sIqdvf/cxas2QFUUcWe6QxSSyN4hqOuGmMB4iIXdUEPHcNg8nPjvosHMUp7u6KOL
	hwAwxSwDjj6UN0qLu895VgBgPVKH4mVh/LsUZgboTlhbSFb1TXSzsspbO+vbCO4s
	CK+1ng9IRI5EY20EIOEmpbFyxUHZ6pJhJpQ==
X-ME-Sender: <xms:Ok15auTIorKDvOUxQGG_xbCxUgGYTxl9gSiLy8ruadgKYhLY1hQ8qA>
    <xme:Ok15aqwhK53ccU3N8YKTT-mYYy7h9lcLo9NFnrhjd2rl6aBFddT3-GY-i4-StACUc
    j4TlIqaXhSg8zQ8io9OASY1Fba8hnL7Gyrqs9JXZZj4i-CyuBOiCg>
X-ME-Received: <xmr:Ok15ag3sF0whrokjKwMkOExjcVcj9zn3i4yrgDG0K_o9kvNEEEMYary7ZJPeWiT6nDmqX2FXDRlMh7JiAKDVKeEEvxwbrlopBw>
X-ME-Proxy-Cause: dmFkZTFbEreCc9yOEHrJXFgQYifDReW/se18Gyg3dqukVGvgHKSL6m07O9TrfxFJwD+Yjn
    SGrKo7AzUb8jTXTYojeJO/Y2kQev/1Qgw1dArwxYotmVWgHMx5hcQNZWLgDKB7bdCIiW6O
    ye7CE1SW69QYHLIFKmBmJvSGfowVeMMlWDxTABjKhUe8C4wBB32h0/9JZLUkPuLlpP76p5
    +XziufGmlkFGLnqJBr2C+6kgHAcNJpjWXKpkoW3JrYc+hdPBE/xvCcXkv7h1AEbMQhwoZ7
    JZ/OXjllKR47S9tx3jnXvhGcRZ47KNb1RsZd5cRxX0QyeG3WoAVmH7n3PUnpP8G2kSRKHm
    4Ft/koKr2+nQB3PQMpgdvgzpq9/u0SDuwKeMvDB8GLNY9d1gxVj4QFF54fTRozlSTjGmgQ
    g+DVptaNZBc6e+zsWM2MFe9H35b1czNbB2+oRD4LHmgZxBj3hs8z0H6TbSOA0eX8BkQD4c
    m2pIcKpXcwsABAPxDXkC8nmqda1VSMKdu7yniAttxHDpMkX739i5RrKMI+sO68+yMe4cyk
    RZoJgVOoJk2cQTVMi54eETf5HwtUX+bqKiKTJ5Z7X+2AVDHas4zC6vHR+dOGkjosO/YPfn
    6Ts9k6n0FupiJanxMsWqi5xMD+ckW6UvvHjJz1TsssWuXk6emYVbM8o4aeUA
X-ME-Proxy: <xmx:Ok15ao49X59VJvd39MxMqOui04LfuXZxNM0rAOUGSbet297_kC7WSw>
    <xmx:Ok15ajX_A_0CUU7lhhlbR77b0MqlMxWL2zRu-hk-fhk7kmTESiNEdA>
    <xmx:Ok15anCVb9tIRCjKekwc5DIuKRSkD9CrQY2MWhsyTve8oqqepUvb7Q>
    <xmx:Ok15ai5U8Bm-NKM6jNgPuywoj6SmJmesBUBrSOVuMRBNBKeG__oi0g>
    <xmx:Ok15atiovzfJ4EdvvCtK_yQkLIio2v7E3ORkWQ4UoQTxZGV4l29N_9HS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 00:02:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 7/7] odb/transaction: add transaction interface to
 write packfiles
In-Reply-To: <20260809190106.1565882-8-jltobler@gmail.com> (Justin Tobler's
	message of "Sun, 9 Aug 2026 14:01:06 -0500")
References: <20260806213859.816157-1-jltobler@gmail.com>
	<20260809190106.1565882-1-jltobler@gmail.com>
	<20260809190106.1565882-8-jltobler@gmail.com>
Date: Sun, 09 Aug 2026 21:02:00 -0700
Message-ID: <xmqqwlty7hdz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> .... Note that a packfile
> written via git-index-pack(1) is kept in place by a ".keep" lockfile
> that must be retained until references are updated. To faciliate this in
> an ODB backend agnostic manner, the "files" transaction backend takes
> ownership of these lockfiles and removes them post-commit through its
> release callback.

The above is confusing and I am lost.  Care to explain a bit more?

> +		status = start_command(&child);
> +		if (status) {
> +			strbuf_addstr(err_msg, "index-pack fork failed");
> +			return -1;
> +		}
> +
> +		lockfile = index_pack_lockfile(repo, child.out, NULL);
> +		if (lockfile) {
> +			ALLOC_GROW(transaction->pack_lockfiles,
> +				   transaction->pack_lockfiles_nr + 1,
> +				   transaction->pack_lockfiles_alloc);
> +			transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
> +				register_tempfile(lockfile);
> +			free(lockfile);
> +		}

Here we add the .keep file to the list of lockfiles.  We have
finalization step laer in odb_transaction_files_finalize() that
deletes the tempfiles when we are done, which comes after
the transaction is committed.

But isn't the odb_transaction_files_commit() where the migration of
tmp_objdir_migrate() happens?  Everything in the quarantine directory
including these .keep files are "migrated" (either link-to-the-new
followed by unlink-of-the-old, or rename-old-to-new) there.

And then ...

> +static int odb_transaction_files_finalize(struct odb_transaction *base)
> +{
> +	struct odb_transaction_files *transaction =
> +		container_of(base, struct odb_transaction_files, base);
> +	int ret = 0;
> +
> +	for (size_t i = 0; i < transaction->pack_lockfiles_nr; i++)
> +		ret |= delete_tempfile(&transaction->pack_lockfiles[i]);
> +
> +	free(transaction->pack_lockfiles);
> +
> +	return ret;
> +}

... we do the deletion of tempfile but has anybody migrated the path
to these files recorded in the lockfile structure?  How are we
removing the .keep files that were "migrated" when the transaction
was committed?

Puzzled and confused...

