Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E003B5835
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208402; cv=none; b=DT33HdlHf2GVGi8Uud4DSDIwNB/M4kxuYWf+3K7L4DcpBYjaklOryM4nWvZID57ya0Dif2/BF/Wt9DKf+BwNWuYljWlPK2x07utUtzr8GtJYCZ23AZwyE0Uh0oiQi41p02J42MDthfRybqjiVlExBoH3ID6l8V9z480BGiKrZ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208402; c=relaxed/simple;
	bh=PVB+oGjRUVPXjl9H++rsgho0p00aGZ8vLzGvUIPXFXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXBVHo7TCUrP+a4OhybqjkBKbJQo+ZjktRqrMXUTLIzumNn3LsZjAgRBEgdzUAXQANKDP/HKy5rQOjYTpNNZKWt5A+gSit0lxKCOEHmPoBH6G3PJ6D68hWThK/jJmC7Cb6FSpppseq37hhieJXZF5erULUXqkQ1lHZwQjHU6tjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R1emazm6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tk9LcvJ6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R1emazm6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tk9LcvJ6"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E6CDEC012D;
	Thu, 20 Aug 2026 02:46:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 20 Aug 2026 02:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787208399; x=1787294799; bh=IvdPgN+EQ9
	b9aHlCxCBFnvvt7+deT69WwwOpPJg4n3I=; b=R1emazm6I+0YAGWfqQcRk7V9Fg
	lOQRq8EINMMpmK2ILhRctdfcWDJamfoSmaRayZTSR6mhE8P7cMVHw4fUxuHPVWT+
	wt63ciYDkoQY66TkmPDWoMXXPUoA8IXpokrUPml2YVqZ97H7mZffJEJIE09OyWkK
	VQeFBY8lkrQz0B1dWNVN7MAUDNQvFFM6jj+hPEHpiWTRGASrkh/5znqQGiV8bInC
	i0Vdt+QQW/SzBcluty/HzHiIXe3q33jdm/m3NJUxftwQ1kN73jkguJsHfUlv0u4o
	ODbcPF4TdgwZD4crvZmPDjbxkn7RDS65UEYj5L+LoCxzQUi/snH0PGkemjug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787208399; x=1787294799; bh=IvdPgN+EQ9b9aHlCxCBFnvvt7+deT69WwwO
	pPJg4n3I=; b=Tk9LcvJ6IBlaQ9rh+gk1v/nsgXWBUgApc3x9iDUQ0w3uJSOdZN1
	b0lU9eruVbEiS3vkpttKODWR0ziqXy+TZnXTRPqj4PDk49QgVAGHSSF+4wAzl4+j
	+G0iJbEa7m45FQ1/Eq4UD0WcdUOMrYmeNNVG8aQ7jWTFfBY6AjrZFZ14wMaCIP7R
	4XX564DblRDp0FUuQnzxDKmDy1V5Qeev4S2wXUhMu8n0LSkh6R0DY/udIZHL3ZB4
	fMtvZ3O4k4UD1njkQYp5/XLYHcSWgk2cflF4rBfZIBVpuctJAYwk2MBRdatBnVwE
	gCB0ek1GcNWbTGdAxJ+uab7pNTBtXur0Tdw==
X-ME-Sender: <xms:z6KGaiueSg6rO0TV_23BtOjLa8FaTCALGRRrtxyL8WQUwFriITAyWA>
    <xme:z6KGau7xVes40uDxADhMbs0TrtTxe8QasBMwPLMe-uY4lFtgKsNvmbVGFEZ66ykH1
    AZHrjKRF7A0MPKlg6NSkvaojMRSjd-gtYNPscDgQRDRPbSvz0UD>
X-ME-Received: <xmr:z6KGarLe2QpkaZYrxBP050rX9bF_JUyWUhc2rdREcrdPv6Q6co6IsRrlc-ZSXbwTKPYbNlUuzaCNaqdaK0mTJFJ97vYzYJqfa2JaX1fF-A>
X-ME-Proxy-Cause: dmFkZTEkoe3yqOASusvPWtl0bxl0KxuqVZFU00oQkBEWFTAM2Cp7k/dcu1RVmgISAB0uKg
    pEdN2t+CruQFGhJZfO6waIYz9c31R0wjIf7lud/WcVNd0HkfIany+8Xr8WSJDHIJzDYChT
    U/GgQCtLffvN7SGj7QoRwpKXo+11cN/XLsSGou/lxKeKlC+9jEjifi63YhSPseBjw0oIeo
    7utCnL3k1399zKxCqO+1vBeO7etmf6JZf1OXp2q/SZ4F2Ka3XyFXCuNFi4lOGyGKGc2Lf2
    Fu78jJ4Sq9nJTCkSkR/f0fOiXQPhcsumgpzGzp3TcFywCW41jT/Ht9WKr9F2qQVLULyKpl
    z0FzKVTWjlGnPvAyH5FHG4uyIAxNvkJVWB2fP97TjwLRM2pghRodzppKi+6SxGpaFEiDDS
    Uzhk/QX4xucNIg7E+fLq/2X/9hwaj6HC0eMS6jejRuP/IdC/8Ck3B0vZ/t52KzKrgHA9KT
    lPC4fjWbUhM2P41rFUCElJErZ+CdxgqYVJXbOU+0IxMw7UDcKQuhlsLGLdoPBl1wNaBUnN
    0admLq4ZA2c58xoBqZBXjnpJS7SCcPfP3BPTi/B9ddGO+/W2XvnOasL2nFhi4oOx7J6t4p
    8mNRLmQ8nkOhCrPXAxhkv38tlrAuaNBY+MRiNLOOGmLG9A+wvia+d31AfHGg
X-ME-Proxy: <xmx:z6KGam5Buu0-fZeV0Dtry3gHblg-LacuxHpjP6JfX4JPpPHm2KpHtA>
    <xmx:z6KGamwr4K7AGXlBqFWuvVQLS2IKNKEROwS55MuTlyIW5Wud17rliw>
    <xmx:z6KGaiYGl5bLdiSO6YItIvxYR5LeTJX2ZDdSdkIgIF5PkTWUy_8L0w>
    <xmx:z6KGagTMrtrwBSYDXEnYXEj3IKy56tTDwumsf8MlzbQvglmOIAzpiw>
    <xmx:z6KGarzlIkm0p3t0yxnBzd-ATm2T9PW8Mz3rGqj0S2yY27B2D-Bo5n4X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 02:46:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08e0cb72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 06:46:37 +0000 (UTC)
Date: Thu, 20 Aug 2026 08:46:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 2/9] odb/transaction: add transaction finalize
 interface
Message-ID: <aoaiy1wmSXjL30-m@pks.im>
References: <20260811175415.2044235-1-jltobler@gmail.com>
 <20260819215311.3880274-1-jltobler@gmail.com>
 <20260819215311.3880274-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819215311.3880274-3-jltobler@gmail.com>

On Wed, Aug 19, 2026 at 04:53:04PM -0500, Justin Tobler wrote:
> When committing an ODB transaction via `odb_transaction_commit()`, the
> staged objects are made visible and the underlying transaction is freed
> at the same time. Coupling these two steps does not leave room for any
> post-commit transaction operations to be introduced though. Such a
> capability is useful if an ODB transaction backend needs to hold on to
> lockfiles after transaction commit until references are updated, as is
> the case with the existing "files" backend in git-receive-pack(1).
> 
> Stop freeing the transaction in `odb_transaction_commit()` and introduce
> `odb_transaction_finalize()` to explicitly clean up the transaction
> accordingly. Note that the finalize interface also provides an optional
> callback for any backend-specific deferred cleanup. In a subsequent
> commit, the "files" transaction backend will use this to remove ".keep"
> files generated for packfiles received via git-receive-pack(1) after
> references have been updated. In preparation for this, the
> `odb_transaction_finalize()` call site in git-receive-pack(1) is made
> after the reference updates are finished.
> 
> All other callers commit a transaction and immediately finalize it with
> no work in between and cannot meaningfully recover should either fail,
> so introduce an `odb_transaction_commit_and_finalize_or_die()` helper
> that performs both and dies on error. Call sites are updated
> accordingly.

That paragraph is a bit hard to read. How about:

    All other callers commit a transaction and immediately finalize it
    without any work happening in between those two operations.
    Consequently, they cannot meaningfully recover in case either of
    them would fail, and spelling out these two separate steps with
    proper error handling would be quite repetitive and pointless.
    Introduce a helper `odb_transaction_commit_and_finalize_or_die()` to
    help those call sites and update them accordingly.

Patrick
