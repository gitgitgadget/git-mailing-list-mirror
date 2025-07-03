Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20915295524
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539481; cv=none; b=kupRBVZVe1aGadqym9dwsZcmByoJgtHyy4p3w74WNZCVEmqWfEBcHpYFi9e4Z/KwaFaCQG71yUMPuiqTVsus/uknil70Cov7IOAm9a22+CFgVs43sHeZI3GkOH/BwrRENN++7bC2Ys7Jro0xREAkzNloDeDXD3+B/9dI+AqOTPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539481; c=relaxed/simple;
	bh=qb59xcDlRU1iREwD1dyM+IfgsGey2MuxQ9aUHNWQBPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d98y9r8bmsPgLCU0e1tgYcrZdu2279ZzonciOQDIvxpXtrb8gl6/6C83cNcqtHpZJ1xZi6zFD5WO/BzDnIki0Z8IbBS3c+BZA+UhlB8A2srTrKNAAGc0Y84/YseNUXCocgE3k8MzhB8AOMz/o2Bw7LwDU1QjvpXDJa8Az+te2Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=StVt+5w6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I2Bfe16G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=StVt+5w6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I2Bfe16G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="StVt+5w6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I2Bfe16G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="StVt+5w6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I2Bfe16G"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3171D1F458;
	Thu,  3 Jul 2025 10:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751539477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldQhJ/jrkscbjrHuGZZRgQs537PmWiJi7KyHTjtdSXc=;
	b=StVt+5w6VALxqDGx7AZRFky7KojqDnAkf+waFsJWL4zJ/YDp7tncTzw8MXhIxQNFsWWH35
	2f340GjMx0eB8ZINz4Gjw7b9rT47xL3x+SLKF3XtfTFCoQ0E+10Fj4hEO00AvCsgtJovuT
	NTpdtpPZLpMO7fTL65uTMmgRQ2ZFtAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751539477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldQhJ/jrkscbjrHuGZZRgQs537PmWiJi7KyHTjtdSXc=;
	b=I2Bfe16GblSN+XJTpuWooCafEqLjJE6XUlCU6NJKftkPYu1H2NTsWVMyLhTV7CxerRNDvC
	zQwsis6KZeCWGAAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751539477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldQhJ/jrkscbjrHuGZZRgQs537PmWiJi7KyHTjtdSXc=;
	b=StVt+5w6VALxqDGx7AZRFky7KojqDnAkf+waFsJWL4zJ/YDp7tncTzw8MXhIxQNFsWWH35
	2f340GjMx0eB8ZINz4Gjw7b9rT47xL3x+SLKF3XtfTFCoQ0E+10Fj4hEO00AvCsgtJovuT
	NTpdtpPZLpMO7fTL65uTMmgRQ2ZFtAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751539477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldQhJ/jrkscbjrHuGZZRgQs537PmWiJi7KyHTjtdSXc=;
	b=I2Bfe16GblSN+XJTpuWooCafEqLjJE6XUlCU6NJKftkPYu1H2NTsWVMyLhTV7CxerRNDvC
	zQwsis6KZeCWGAAw==
Date: Thu, 3 Jul 2025 12:44:36 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Failing to push to a repository erases authentication helper
 credentials
Message-ID: <aGZfFNRvDlFLvlBm@kitsune.suse.cz>
References: <aGKU-o9eXB1VHuN9@kitsune.suse.cz>
 <aGKfs5VRdmnw6Pqc@fruit.crustytoothpaste.net>
 <aGKokqPJPh5fQ3fc@kitsune.suse.cz>
 <aGLXmiYuM2C_xfWJ@fruit.crustytoothpaste.net>
 <aGOGMpibpUM2JJuV@kitsune.suse.cz>
 <xmqqjz4rly5a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqjz4rly5a.fsf@gitster.g>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Tue, Jul 01, 2025 at 08:38:09AM -0700, Junio C Hamano wrote:
> Michal Suchánek <msuchanek@suse.de> writes:
> 
> > Is there any way to see what the server is returning?
> 
> If this is going over http(s)://, then
> 
>     export GIT_TRACE_CURL=true
> 

With that I can see that the forge instance in question reports
indiscriminately 401 while their demo site running the current
development code correctly returns 403.

Probably a case for upgrading to a more recent version.

Thanks

Michal
