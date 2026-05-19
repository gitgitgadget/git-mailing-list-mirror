Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CEE37C906
	for <git@vger.kernel.org>; Tue, 19 May 2026 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171493; cv=pass; b=uTSerWjWdDMaxi0cLb0HXwOKIVLlQdjELQUYX6+j1tIu4BLQWCEgIiW0/afMUHhwF0WMm8k6EVdQb3fzyXc4WCLyW2bTpsk0bCYzIkBXJhDKTCpqsgGWZ7X/iXMXHzf7NkiTTPutlDE4i9OWpMe5ua1Ov6jNXHVeg0VT9KsjG7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171493; c=relaxed/simple;
	bh=2IIwHo46Pki/TiyfVZB5DhIGX/mh2Hbo4LhHDI4xTyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1nJuRfyu8z+6esk9oEllg1RoWpW6jrZllpa0pJFkS4DjKBXVVjM3Ae6qGLGilogcZG8psLcMWpbSpY3+2LO0wnh/WPItTkjZ0RYm3Uo3EB3ms9y0aQ05v/OWsO/3GFpNlR/UpyT2QsfRwvC7OVQz+Y82voMoMAHt2s/DIajz2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b=SuCmeX4/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b="SuCmeX4/"
ARC-Seal: i=1; a=rsa-sha256; t=1779171479; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Sghgl9qMEQTVR9w1kUy2KCRFwEEPz3VGMDrI8zYUgXJ14I8GHn97+ndnpPHG90jhn1ng0JwD4ABmROwYof5dC2P4ox5u5oITXg68GA0FLmexpuCOc2kxvxXttJsVnK1sKhAG47Vuqxi2yJslr1ao78aw8cYzFecW22rMv0ghDoI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779171479; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bW1Vm4/rwPfEA4vOrnTF4itI8Tazk5LMmiOwkVhhRdc=; 
	b=guXsB4sZWC/GKo1Q30a03e+7MxO3f6MShtB8Hwdxh0Jg1dNDabDxwcNeJ6I4I4/4BGQwBZWkC/+g08eg6g5bhJGhN1ogGLeB5uNDKvlwPfuDuhQoBg5DQg+TOPUJu5lgegRAgzPRqyG98LALdZOS+QC5Xpcn28UeEsN0n8OFlDU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779171479;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=bW1Vm4/rwPfEA4vOrnTF4itI8Tazk5LMmiOwkVhhRdc=;
	b=SuCmeX4/X49Sw6Do8mIORCOETms82v2Bo7u8IrGrl8HcWF0uZcNCwuIpQlNnpWMQ
	KtyfApa+mPh7w/QFG+f9s8F3gQL75tGiCoqs7Z9bm5xqpWGRksEzgo8L3Xgb8YRxtoR
	++psJA6ZMoJSMHdYeKbPj02fcs+BqCGdS7m4S8AE=
Received: by mx.zohomail.com with SMTPS id 177917147703688.99365757710211;
	Mon, 18 May 2026 23:17:57 -0700 (PDT)
Date: Tue, 19 May 2026 08:17:52 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] log: let --follow follow renames in merge commits
Message-ID: <agwAkHzjrJQPVtCS@collabora.com>
References: <agLU58gbG1y7KLz-@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agLU58gbG1y7KLz-@collabora.com>
X-ZohoMailClient: External

Hi Junio,

On Tue, May 12, 2026 at 09:21:17AM +0200, Miklos Vajna <vmiklos@collabora.com> wrote:
> I sent this out a week ago at
> <https://lore.kernel.org/git/afmfSa-p-9vuDL3E@collabora.com/T/#u>, I
> didn't get any reply to it -- so I'm somewhat optimistic that the patch
> itself is a good idea, seeing no negative comments.
> 
> So this is a resend, this time to you, CC'ing the list, rather than the
> other way around.
> 
> Could you please review this?

I'm a bit confused regarding what can be a next step here. I
understanding you were away for 3 weeks, so there is a lot to process.
:-) Should I just wait more or should I resend this?

Thanks,

Miklos
