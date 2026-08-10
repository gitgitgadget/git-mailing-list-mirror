Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AE4248896
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 01:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786326854; cv=none; b=Cd9LobU8bUE9OJvF03Q1omnPRsz6yPYZXyBr2y8MU5tT3Ef3m+b+PY4QJvUQt01r2aFTiZTlqCrTZrC8KKAji8VztVUpT5uDed4uyOg8cySyO+7OzDGxh+sheBh2jI/UAJ6urW7yDhUA0tdYrcMDopxNTDqkwRBdXOTUEeKFIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786326854; c=relaxed/simple;
	bh=WW28myy3UR9USbfftGuIpULbec6Ua1NW9VCAHIJtQFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AjfE6ezsYutCpkr0GRk3DCTgc8Yx1lPIduKdE1CXZnvbQZXFhzK2OWEFeKsGBGguorcmc/akB82OTsGsR8tFSgQ8m5u5BFMvtbl9/4BvTAdT2F4YsDFSc3IJToloO66vCvgV1RCNITcbH+hhSlWK4j9822t17aQrS0DfBdeKPs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MxjL405K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YGVdwrPX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MxjL405K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YGVdwrPX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B276B1400049;
	Sun,  9 Aug 2026 21:54:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 09 Aug 2026 21:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786326851; x=1786413251; bh=zb1Th6A/0t
	tSR1XskRXH0eiLcb635kT3zF8CSey6iUw=; b=MxjL405KelL/o6r3lFYP2uzbgi
	r1NrgUV/5YB3a4zLkA1nnH4gM/ss23i84zHLit1byPiQTTk3h9i3xcGO1W8I/QXa
	vlm8HY5KuLmzwScO0zXmcKbS5o5Ej6xnmEvla6I9t1dPpE4e8X30+mzdDexKVQUv
	6I6uTt5eOZ68U0YdhVZBguQlPoRe0FzT+zMlQU05I8K4IdvuwbJZE+07JPpdaub5
	HrmETR3oKxVI2Tx5/CTZ/QYwkZQ0VDcz+lMy8yKWQ4MerSa2pfqEoWCN0Q8Pvm48
	vCpTFusFcIZI/TZAJlFvyJ2+Qk1h/Vcd3XLm3K3+RuRmpFakxYIc88nj9sMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786326851; x=1786413251; bh=zb1Th6A/0ttSR1XskRXH0eiLcb635kT3zF8
	CSey6iUw=; b=YGVdwrPXY6aM65cox2AsRhbIm8CuB7Uhr/teT3vMjRxULN+FeS8
	HQOD1yzBnKXuyfKoKTkW4DSVQeR/K5JFynOWao4OAQkbaCgM17YiiBMpcVI3pmwd
	zoBdZNERvUI8P7xyd/7MRn7KKwSC3h9b2Eb/45ecyX2vva4cNEhCEZdWbMMw2+Jo
	YfrxriNBU1ix4fgzqhWXW6gVpd3qxKmE4bf4VsXeOkCpJf9CHyScSzMKWBUCm80o
	OFmLgHr1OoNED107dR1hR0gA+ess1Vpy+Tgo3ZwhSDp5EL/ibP9WSUplHBQusz8i
	lpOG1x7WTyPLp60ERvIm6zlwPYn13V5dK3A==
X-ME-Sender: <xms:Qy95ajRmuKZfsYA03Tc2XYcFJQ-g6AC_orFnAR3bszs-rdr3ii-JqQ>
    <xme:Qy95arz8dFsNwYEJLCDNos4Jy1h5xlRtB6Pw3q3ourNUxx-Ob3TloH5-DnCHddBov
    CUMxazIb1j2DjEoU4KhrMr9ppfyxgIp0ljpnMjAafkEXiWQQ17WFw>
X-ME-Received: <xmr:Qy95at2RGn8JaManbTtGK5dgn2fwzB5o8rvGECNb8sBI0ZShnzeRZJCf8tf5JcJ1OTNUT6eZrveN6xFA1gYBk9LWoLVqseVpFQ>
X-ME-Proxy-Cause: dmFkZTGnANNqpaNsslP65VIMDMtR+cK2+RYlybfcvv5BgkyItTwwf4hqkxlg3xVEXhCRG2
    GKrOQZtO6G8Dc9OKBERnGsr7tDc+bhVbqjwQtQ9aRLxScWxI1oqfctNM5/akE+61FTD9OM
    p5bu4kIW0rxxmoPnA+z9fRkVG/vyp1SvGCv4OuQMGVnexIP1AS7EZbiop1nGZ4o/c7xZ1K
    Q78gchY6Le3l61jVLUQ7THfshk7xhmJ5ijV93f2aDw6sPfoZcNvNC8NnVyeHu1Dgs6KKOX
    c6UYGQSSf1ukAIO+Mw0lpF2O4UHkDrnBh7I55g31c4RRMROS+PjVtY3lLxgPDjj7BylgO6
    rh+9sQOTBvZ7nqEM/XKNv5OIzNliAOA/T+JVhrwt/MLbn0mWo43pkr9UNaSaJuPpR5eA38
    wdGTdGYwbVbAsaeIzt2AvzqN/H/NmhsWoS7R+ulQox5UECOZ6MaFzVEaHAJ/YUAk+4EIJa
    T4j9Sc35otRPHWKow18z8Tn9BvIlKm/MkpUr8sJzFEK+Stj+kTeP3SJh3yJhqPn837H0WK
    OvV4j0gloX3v4PVFvuMKdPRF0HLSGqibK/J3wdW8CDPA+ZASLtOMtX0gFGiEzwCCOMUINe
    iBf8QiK5oA5Wvdm0idU8ApSKE+rC9M8mO3gqRZd/N3G4IkRVZIZ9MtWnSTrQ
X-ME-Proxy: <xmx:Qy95ah63OPQTpBUdfd6KxvFp1bKv0reTRPMO9t_LhjnJgIHIllSK7g>
    <xmx:Qy95aoUhlHEg_xEfYs7jPE93ik-VBZeIBzsK-y1WVUE-QMSd7Pp3Jg>
    <xmx:Qy95aoARYv1RDJBO2UwKUkAyUSxcaF1wMGBFhz9vG85KQEzWn1GMcA>
    <xmx:Qy95av6GZaiW6gsAHjEIjooZCm1bxWwFcFcR7CUYk1xzbo97LzKeVw>
    <xmx:Qy95alXO9ncOCTBeAtgkPAV__7fma0HcHgb9eerrt8QovLuBJBU-MDRW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 21:54:11 -0400 (EDT)
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
Date: Sun, 09 Aug 2026 18:54:09 -0700
Message-ID: <xmqqa4qu91vi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> In git-receive-pack(1), the incoming packfile is written to the ODB via
> `unpack()`, which spawns git-index-pack(1) or git-unpack-objects(1)
> directly. With pluggable object databases, an alternative backend may
> need to handle writing packfile data differently though.
>
> Introduce `odb_transaction_write_pack()` as a generic interface to
> handle writing a packfile to a transaction and use the logic from
> `unpack()` as the "files" backend implementation. Note that a packfile
> written via git-index-pack(1) is kept in place by a ".keep" lockfile
> that must be retained until references are updated. To faciliate this in
> an ODB backend agnostic manner, the "files" transaction backend takes
> ownership of these lockfiles and removes them post-commit through its
> release callback.
> ...
> +static int odb_transaction_files_write_pack(struct odb_transaction *base,
> +					    int pack_fd, struct strbuf *err_msg,
> +					    const struct odb_transaction_write_pack_opts *opts)
> +{
> + ...
> +		odb_source_prepare(repo->objects->sources,
> +				   ODB_PREPARE_FLUSH_CACHES);
> +	}

This assumes that we are working with the first entry in the
'repo->objects->sources' linked list.  Should we not use the source
actually associated with the current transaction (I am guessing that
it is 'base->source' but I may be wrong)?
