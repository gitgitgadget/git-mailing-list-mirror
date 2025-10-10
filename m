Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C931547F2
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760074479; cv=none; b=MNcQW2NIVcbxuGajipP8yP+aXYfNDaE+/p8X5zqcHJxpKC20dueMVDwIyjhk+EzaRwVddpiXNU4QJDtn5brpAfefJ6LIKPKLTvl3EXjiKTbn+NabOBQtqgl5cxZ/XPXLkh1FDQFLoNixEu5eq3HupfuSfP38AHKFK5/5sKZzEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760074479; c=relaxed/simple;
	bh=wRC1kpYBG/Khyn0ph5IlwE6U3Kwwyy8hSrD6Mgr2Bt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EygyhzGWjn2FlzVUTJlwjZIch49mYwhb1K3q3rOh1tH1Ndv9UnxyNl4KPOeOaz7uvT34CDA3wNteTCaYjfB9L0pVPDnWSnT6/O+/7clxEj91W8MLvz6i7dMgukYs1CaukUtDpup74wAP3j1lyLmNTeOEjHEMSezia50huQwOR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MohzIp4J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SGw1dDCy; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MohzIp4J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SGw1dDCy"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 91AEC1400210;
	Fri, 10 Oct 2025 01:34:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 10 Oct 2025 01:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760074476; x=1760160876; bh=GTfvVWHON5
	yeiSmzjoyeP25JWLQwz3RIfYvbGU10jUk=; b=MohzIp4JzmdnVwMwD1MzdxpOLq
	jonhlJMZl3lhDnAJpalbPpIFxc21lCiWZ9mb8Jrz5VWsc7Hvlr8nQufmiahf+9KE
	qOtOGGyepNVIozm/Kop5+CWkII8Y8krqd7tuAR73WNWNnB8Wva1cOYetEvWdlPBX
	NqeDXTpu6IHe011f5nHnSY/1lBK+y+YKvktlB37QHaCubwmO3NCjoeVeUqZl5O8h
	Dm4wHPIStqZY3glu8DUwrgWQjb0VaeVAmoQZXYeWZis0BmB7EyQfaKsrzOYMYuKw
	BcFzwMe9hNmPG8JebYrCB3riDP3geYZpNrKWWkTXyoPGhulbEySXbP+X60mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760074476; x=1760160876; bh=GTfvVWHON5yeiSmzjoyeP25JWLQwz3RIfYv
	bGU10jUk=; b=SGw1dDCyIJBA4ZYqsIZITMCj67zgstHOdYy6xo+gzQQnLEZrxoT
	v6WqhoMW7Boly3uczIKAAnOvclZ/yvsnZ/DtliAleSGOOO8ZsWTnQwg1QC5eMpVX
	a7ymhFYwccztGmQyH4iCcXm4RjZgJRbcAIS/Pqw3yYfAXLp/doBN1Oa/cD14N8NH
	sn+TXAdsSfa+6hXfg/IKsQhGi+O7WzM6kWegr1gxwCwQuEwd38VPBLQFTXGQSj3l
	ucRka66T+3o0JCBLF8hk19u64d2jYq8uBHR+pKzbEGWsvyBxGUsiVw2svk+KPPl0
	c2Ngx6efGxE5iEE3iXqenaefWE+0qm5xjfg==
X-ME-Sender: <xms:7JroaHA5wUZPciavDcxIFyfFDmOFuSKQgbGv6wqyn0VncrrKqHRB-g>
    <xme:7JroaE8M8n4DbRJFrtpmbyslVJk0FfHQbhJEuLH0sNIwBeaD1EpuS4aDNIzDaFzX8
    OeaPuEv7kmG_GUct5wLCe7nE68FwnnqWEKEfP7afzVft99bXN50sQ>
X-ME-Received: <xmr:7JroaP8_cJMxcwQo5MHpczQWYeyY8qUx_e8YzDVoRKtNmzXpf51Np3N071EJhA7PQnf2szEsxnU7cmc0u3J9MBGzutYQuDBs6rfnryFjKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgt
    hhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:7JroaDfdKKowxoB9vj3tRcLbZx1v1fbxz3i47XIxKCZ2snQIspgZmg>
    <xmx:7JroaAEWOzWGEPLut5pTl04_EUXsaOR3It6udCHBudXJ8ZmgUKCACA>
    <xmx:7JroaJfFavGvp-jJvEWJMM4FTSgLmGXmoD8wVJKLLm6TJN2W_zeP7A>
    <xmx:7JroaCHVAj9x24Enaoj50GH4DNDT-P5WpF6Xo9GcOD0mE5Dz1U9j3g>
    <xmx:7JroaBeDKCqXYP_m3Cjj6ihipmTVuvshzDbtUHRhdX7qYYvaSr6AQFBD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 01:34:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ef4134f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 05:34:34 +0000 (UTC)
Date: Fri, 10 Oct 2025 07:34:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] refs: forbid clang to complain about unreachable code
Message-ID: <aOia55_sjFQjw1UQ@pks.im>
References: <pull.1984.git.1759995982220.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1984.git.1759995982220.gitgitgadget@gmail.com>

On Thu, Oct 09, 2025 at 07:46:22AM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 088b52c740..814decf323 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3186,7 +3186,13 @@ static int files_transaction_finish(struct ref_store *ref_store,
>  		 * next update. If not, we try and create a regular symref.
>  		 */
>  		if (update->new_target && refs->prefer_symlink_refs)
> -			if (!create_ref_symlink(lock, update->new_target))
> +			/*
> +			 * By using the `NOT_CONSTANT()` trick, we can avoid
> +			 * errors by `clang`'s `-Wunreachable` logic that would
> +			 * report that the `continue` statement is not reachable
> +			 * when `NO_SYMLINK_HEAD` is `#define`d.
> +			 */
> +			if (NOT_CONSTANT(!create_ref_symlink(lock, update->new_target)))
>  				continue;

An alternative could be to fix this at the source, e.g. like the below
(untested) patch. But I don't mind this too much, especially given that
this here is the only callsite of that function anyway. So please feel
free to disregard.

Thanks!

Patrick

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bb2bec3807..cb402a2a54 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2115,7 +2115,7 @@ static int commit_ref_update(struct files_ref_store *refs,
 }
 
 #ifdef NO_SYMLINK_HEAD
-#define create_ref_symlink(a, b) (-1)
+#define create_ref_symlink(a, b) NOT_CONSTANT(-1)
 #else
 static int create_ref_symlink(struct ref_lock *lock, const char *target)
 {

