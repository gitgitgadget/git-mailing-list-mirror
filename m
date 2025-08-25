Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880802980A8
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107910; cv=none; b=meNFLAFtjGvCWwDtWaauJS+STPTz0jDNOxfhxCFgp0U+vDOtNQOgwrMs5WRdGZySJD1g8dpyA85cvByqMdI/IOfSw/Mjw+mHAY632mjS3eT2Kr9zkJVaqmAql5laJrgkjmXwfoW08Ljw/36lUqa+yAKmhluxZZQ0arsJGVQtYwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107910; c=relaxed/simple;
	bh=w0Z3yHJfn5DVSGbtaMOChMqsALbxCjQfAr/QGXz5iBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GartBCXJUISBgVfc+fJr0zLX4ZlT1l8T46g9pjZsLr9jtR90SXhJ5jPo1G9NzNRdBhMo+Vn4KZ51x5Bb6KpTA4RgegL1+2DdOOJ1J2sb58WjBwGdU8rPZHKDz7fwHOfVBW9S9lmsRwimjqpx+Z3/cE5ci2Xmk6Sttko3hHhZvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PCuZ8pfL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JkUoa8du; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PCuZ8pfL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JkUoa8du; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PCuZ8pfL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JkUoa8du";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PCuZ8pfL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JkUoa8du"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0553D21215;
	Mon, 25 Aug 2025 07:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756107907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0Z3yHJfn5DVSGbtaMOChMqsALbxCjQfAr/QGXz5iBA=;
	b=PCuZ8pfLClMu2NQTxSfD6aywgrt1jXzAXTiDzBLSEBaFNAPYrjazVyxF9DELyo2CaW62D5
	oBBW2Nu/Pf1eG+UiKM/4eWVBSVpeov5xmv6NOQUaCoC8hTLNIyUgtZm/4bP3BPi5y1n4/4
	ikHGmVE59MCrLKSSYOb7UZ9OzLHkdLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756107907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0Z3yHJfn5DVSGbtaMOChMqsALbxCjQfAr/QGXz5iBA=;
	b=JkUoa8duMt1czQCgcGdLKJVKnen87b9mVARqbVlv77gm6xDoTqebcdQxzJiT6XEgQZwMb9
	p4KIeRoYd05qjBDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756107907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0Z3yHJfn5DVSGbtaMOChMqsALbxCjQfAr/QGXz5iBA=;
	b=PCuZ8pfLClMu2NQTxSfD6aywgrt1jXzAXTiDzBLSEBaFNAPYrjazVyxF9DELyo2CaW62D5
	oBBW2Nu/Pf1eG+UiKM/4eWVBSVpeov5xmv6NOQUaCoC8hTLNIyUgtZm/4bP3BPi5y1n4/4
	ikHGmVE59MCrLKSSYOb7UZ9OzLHkdLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756107907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w0Z3yHJfn5DVSGbtaMOChMqsALbxCjQfAr/QGXz5iBA=;
	b=JkUoa8duMt1czQCgcGdLKJVKnen87b9mVARqbVlv77gm6xDoTqebcdQxzJiT6XEgQZwMb9
	p4KIeRoYd05qjBDg==
Date: Mon, 25 Aug 2025 09:45:05 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Isaac Oscar Gariano <isaacoscar@live.com.au>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [feature request] allow directly committing untracked files
Message-ID: <aKwUgSt2MnfRX4K7@kitsune.suse.cz>
References: <SYBP282MB2963ABA12BD14594F62E47B08C3CA@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBP282MB2963ABA12BD14594F62E47B08C3CA@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[live.com.au];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[live.com.au]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Sat, Aug 23, 2025 at 06:45:30AM +0000, Isaac Oscar Gariano wrote:
> I often use 'git commit some-file -m 'some message'" to quickly make a commit, but this is annoying as it doesn't work if some-file is untracked, you first have to do 'git add some-file'.
> It would also be nice to do this with the `-a` option as well.
> Is there any reason why git does not let you do this?
> Would people be open to me making a patch that ads this? Would it need to be behind an option for backwards-compatibility?

Hello,

if the exposed index gets in your way you can consider some porcelain
that hides the index, such as jujutsu.

Thanks

Michal
