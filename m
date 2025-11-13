Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D2326940
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074645; cv=none; b=C+nJmfDHAiZJJTmMjLaIZFA2dEinzJrIUYgaueAKPzFZY8J6BcPF7w1IR+wtsyQnAPmMVsmGrC6rlDzGlKEw5Ly5iBRMjFy7N+WM/BQwaXZYxcwxjyRVi+s223YhayqqLHr6X0fsWbeC7XZ2H71GE1ZPs7JXTTUR1La4SVCB4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074645; c=relaxed/simple;
	bh=4RYxz1gRCYL+TuNNrDR0+slevvvv2H1jWcgPMldQzZ4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FtBDnANM3fUQD6As2dUmAcDSasYF2HtsAA8tHNbFboqK6xt52X47RbP8GbXj3IxoBEiizQ4t7aKxBSANDHWeHFHwouqGQ/dzyv1xC28oJmq0XbansRrq9Q8Vu3vtc6W074GvMp+RN2ujGnJM7QczJB7Txe7lDUcyiaiW47k/Df0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SKR0kzdy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SKR0kzdy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SKR0kzdy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SKR0kzdy"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3763C1F38A;
	Thu, 13 Nov 2025 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763074640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RYxz1gRCYL+TuNNrDR0+slevvvv2H1jWcgPMldQzZ4=;
	b=SKR0kzdy381woeb8i7n94yg1hryvsDMkFx0RgTXPac/F8n+xCTwyLe0XLJOIn0dWdVx+Wb
	6v41MUOGFkVvhpzMY09zSEtJR2VKmjIgVyZZON27ZckSmb9c1OaFEVrJQAG5QIBfV+JcjK
	wP9XH2TIxDWqdJgOo3DkFf1fSxh4h9Y=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SKR0kzdy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763074640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RYxz1gRCYL+TuNNrDR0+slevvvv2H1jWcgPMldQzZ4=;
	b=SKR0kzdy381woeb8i7n94yg1hryvsDMkFx0RgTXPac/F8n+xCTwyLe0XLJOIn0dWdVx+Wb
	6v41MUOGFkVvhpzMY09zSEtJR2VKmjIgVyZZON27ZckSmb9c1OaFEVrJQAG5QIBfV+JcjK
	wP9XH2TIxDWqdJgOo3DkFf1fSxh4h9Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10A813EA61;
	Thu, 13 Nov 2025 22:57:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1y2lAlBiFmknCAAAD6G6ig
	(envelope-from <mwilck@suse.com>); Thu, 13 Nov 2025 22:57:20 +0000
Message-ID: <1cf41aad10ab0d32cbb7334cd59144c35629c9b5.camel@suse.com>
Subject: Re: git fails to checkout SHA1 submodule in SHA256 repo with
 --depth=1
From: Martin Wilck <mwilck@suse.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano	
 <gitster@pobox.com>, git@vger.kernel.org, Adrian Schroeter <adrian@suse.com>
Date: Thu, 13 Nov 2025 23:57:19 +0100
In-Reply-To: <aRZhAEpm8PbBQcIM@fruit.crustytoothpaste.net>
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
	 <xmqq7bvvtdoe.fsf@gitster.g> <aRUaR6IfH9imrF5A@fruit.crustytoothpaste.net>
	 <a1c0440a6eef8f306f53793b2f96636945d4ced4.camel@suse.com>
	 <aRZhAEpm8PbBQcIM@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3763C1F38A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On Thu, 2025-11-13 at 22:51 +0000, brian m. carlson wrote:
> On 2025-11-13 at 10:15:30, Martin Wilck wrote:
> >=20
> > I get it that the concept is flawed and unsupported. Up to now,
> > that
> > wasn't obvious to me.
>=20
> It wasn't obvious to a lot of people because the assumption is only
> documented in the transition plan.=C2=A0 Mixed algorithm submodules are
> something we should have thought about earlier on, but we didn't.
>=20
> The original transition plan was to have full interoperability
> support
> early on, in which case this wouldn't have been a problem, but for
> technical reasons it ended up being much easier to have SHA-256-only
> repositories, so we finished that first.=C2=A0 I then lost interest in th=
e
> project for many years (having kind of burnt out on the work) and,
> with
> the exception of one set of patches that were sent in, nobody else
> picked it up either.=C2=A0 So this ideally would have been implemented
> sooner
> under the original plan, but it wasn't.=C2=A0 This is one of the pitfalls
> of
> open source projects, as we all know.
>
> [...]

Thank you for the detailed response, and good luck finding some support
for this very important project.

Martin

