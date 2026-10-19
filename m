Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC953D6CB4
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390498; cv=none; b=ayqu4zrGckGOH7LFKJH7o1EjOXskmPIBGREnzmtJr8NbTFHsBbbrgllLU+feBqsHcnuxE5+w1Ebc3V9ALlJnWbul9CmNKBjPQTm9/z1u6zHld8Be0BbidSWGscqHDCSs40AgH9PpSeJ0rHjuuxHUbWKR4n/yndZc3DArT/bajPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390498; c=relaxed/simple;
	bh=4eRejK7BZUDTVsU2Dbe+7O0AQbHCfhM3N47qnSYH+k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZIhAqXfcizvFmSi5kPTSeHIISHKi82QKLQFRmQn9dQK9lb1ug1y/5SdjSggPe0cAXBwmp7NVDiDKZ0sLG8a9yZKe27JUM38zfGZRD5xE3+rkyMFjX6MGR+YpvN+h29rvBaIBli97QgvrJv+U4sxks1m/lbWr/PYcsq6AXtOMXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b2ltP9Au; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r0IXpvF7; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b2ltP9Au";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r0IXpvF7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4C12A7A014C
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:14:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 19 Oct 2026 02:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792390496; x=1792476896; bh=EXzu/fKJp8
	s6QQLQyV8Pcdllkc8C7Fg5pvSDmcIm4ww=; b=b2ltP9AuDT/slWL2pmuGB513CS
	SgkBWbGYcuZvhhbxDsMruWYaaBguNqgw6kU8MeuOiE1t+9sLLU0AB5JrVqxVFZHQ
	dSg3WRy57inTGstWTcRfxgFy4SvpR2zbLHc4FB4fZjFcqF792mo6kZvxWTQhpQTB
	KfWEk2bqzzyVeACWPNCzkW3tvpYxOG4fUDa4lTD7M6pUFuT2G0bQlKRwSZh9nT12
	RVZ2sJanXVrDWgy1rjYDubqNJTHNV2znwxWq7Lzlsj8klUXVagVrIFx9Awi3yout
	HYS/7hdO6VQUfQD8UyJhr/cFuNntLRxxs0hmxk9NqMOFMndWWGDeEjcL1MVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792390496; x=1792476896; bh=EXzu/fKJp8s6QQLQyV8Pcdllkc8C7Fg5pvS
	DmcIm4ww=; b=r0IXpvF78KKhKBBl7MTXyk4yym97I+bloxFDQLjeoYfoao4t5cS
	317SA1zJ0uQGf0dYPlCp/RPdz2xwrNt+hNAX7qOyPcx1z8FvKOb1Y0qWsXyimqer
	3fCPr/CVTeO2XIk/+RQiaKjynkP5Fy5jTSBkq13b9Ky/LF+k/qRBtpblPG20qkyS
	He8Kcctoo+J8u7dIvGOSgIekrdTecS/0J0/vFd+mDW5+1noSWUeWgtBTaGEvyf4W
	P8XxA1YlG1aCmALmn3homiwsDAL9CgH9MIhq1GB0GJ3g1cCs/WVxxQRegOgzoZ+o
	iW2yCKsYzYmMo0yvyt3XlFtgYK8eCAztu+A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792390496; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sFDGtHmH6yivID5xZJmKqgOUhH7+T2aXaUl/JPtKXib0ERZ
	o2fmE2Ab6NNUUHUyRK2fLE0DWyjzRG62XwFcTtCFqAiBWjL77CvRwOtkUa2UpHWV
	rHIk6ZjyWDLC9OJFXDETC49BTRQqs1Z8K8N3mTshw81WxdrBStCIfhfd4W5irYZw
	HE5luOzZ9hyVN/Rr3uuBfMWCXE3iVTkGGaVVRmsrHaoTpraKgrXjU21nb6luagfo
	SGSTkcXMk6tyHdsLl09BLFm4kqMZhdWPXdKF89xwTHW7N1H6ZjzaJ6jkax9HPYWB
	aM4FYaSHS1ZslqOwRFoVYeNRk3Dg1D1DUopDnUg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:equE/nMXmESmXx95p7whSJgodrYxb8NI+hCiqSMtbn0=:4eRejK7BZUDTVsU2Dbe+7O0AQbHCfhM3N47qnSYH+k8=;
X-ME-Sender: <xms:X7XVaqSAfygATMtetHP8ymI0DLkJcCWwd8o3nzq7ilhIJJ6qSrKl9A>
    <xme:X7XVanMV30x77XawPORt-zKiKmCygoO2srwPPqV3elmd1RfP9-gDLryYLgzlNvGSq
    m1JRhPaMG2ms8FhZ6xvtnqrroUKynuIzBrvLUatV75AkpXS3UBhZ14>
X-ME-Received: <xmr:X7XValN8w9wHQSXS8tru2OooRhusqPRe0ovcHd7kmDbt8_qg1qExrg>
X-ME-Proxy-Cause: dmFkZTEJi4fRGS7wTTegeyfeFasL15IjUZ02aaYWexyMKBHVNvf1vOEi/+0MblSc9iPN/O
    hxP2jb3Yx9X7rEJ4EKZ7jZCGb3xwf6J5RYdGV2qexbEwmA6/NKwNpQupoyAPxjXgqV5PDc
    9rpZ+CKKgGbnkfWdX75oz/xOQ56TFIOXuZU2aI0rCfJm9O+jX4oJ2fpqvp9KmOjOhcaNGZ
    7h/U2KO1hw5WvjxGcqU6ejAGcD9IZGZvqyo/A3a4HHrLL7VgbihBdJwUqx5qkM9p0SYw6l
    MHDa8tw6PzpPJWT2fTgeAuF9gUtK5KYMOW0VmKFRlYs9WQZ2+nQRKRKjYRI+bhTvCU4eXd
    Voeq+71gjVeFVCd6SYSNrHZl4SnBq6aRFN7WCRDebfFADpAO8Xnj0XumKlIHHDsZ0vNq7l
    uyxebMNBqk1zYDbX0eynryrS9ebImx4kDLZpShegrYASeTIgyi1yH8nBB2ZJmnXz3YfcK4
    uue7/z8Eb/uesFk0nmvNihK5ONTrKToqwU9a9uHoL6guDKuiGg9RcSLfHUQreokMdgwWCb
    Q+fsDO0TpJGRkH9qJLZkqWySgE7YBXZQUhbnuw53Y4fCsNB9YMES9OXnV05bepN9W0RUG5
    93Ry9IrnElU5IMZb3RPuEhIqpg22+XlNOk3ei2vZZAq1oBKtT9jTR6TbhhTA
X-ME-Proxy: <xmx:X7XVavsEPSAEDv_kDR9uflD16KXglSj7QJwLZ8fjwGMhnUnmU6-PvQ>
    <xmx:X7XVanUcOjiPHE_gbLrzRWaADN1jxysOJCsbEFmeEc1ereC32PsQSA>
    <xmx:X7XVavu8vOJMmcfgDQaxAO_QwclQREfhMgtB0ufUxxUueWuA_WG0xw>
    <xmx:X7XVarUCXWub1hKJKLFIklDnqxMDs82X_wIF1rXFPTL_e1fg0QOJOg>
    <xmx:YLXVakinfcLW5grJ8PPCOBOAe71chpfDJAYRg4mxer7MW5BU6k9S3WY8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 02:14:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fc0f3f31 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 06:14:54 +0000 (UTC)
Date: Mon, 19 Oct 2026 08:14:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Qin ShiCheng <qeesung@live.com>
Subject: Re: [PATCH v2 4/4] object-file: write ".keep" lockfiles during
 transaction commit
Message-ID: <atW1Ww74i6De0l8q@pks.im>
References: <20261016022901.3838402-1-jltobler@gmail.com>
 <20261016213716.593278-1-jltobler@gmail.com>
 <20261016213716.593278-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016213716.593278-5-jltobler@gmail.com>

On Fri, Oct 16, 2026 at 04:37:16PM -0500, Justin Tobler wrote:
> The "files" ODB backend writes a ".keep" lockfile into the transaction
> quarantine directory via `odb_transaction_files_write_pack()`. When the
> ODB transaction is committed, the ".keep" lockfile is migrated to the
> primary ODB alongside its packfile. Writing the temporary lockfile in
> this manner has a couple of downsides:
> 
>   - Migrating quarantined objects via `tmp_objdir_migrate()` doesn't
>     immediately stop if a ".keep" lockfile already exists for the same
>     packfile in the primary ODB and instead allows all the remaining
>     objects to be migrated. So even though `odb_transaction_commit()`
>     ultimately returns an error here, the objects are needlessly written
>     to the primary ODB anyways.

Thanks, this is a lot clearer now.

Patrick
