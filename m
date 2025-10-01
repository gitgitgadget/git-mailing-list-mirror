Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2130519882B
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759337454; cv=none; b=dzkx029LE1S2ZEamOG4mLxuRnQ6S4XN1JFyfH1twOjLzfGU+SPTbODB5+6clUtMdSc4rtkA3KFjpsBvQrtaFOUKQuSg6bP0QW2x0yfsa1uFPkOApbrExlbPAiE62MNNltQjPMaHx8XyhSZZzMy8D3m3wMF5ZWbQrpPBW4ezv6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759337454; c=relaxed/simple;
	bh=R+2cWajelOujWWkKWy1XhCRRiwNqEkv4in+e9R6tD9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yv+BztZcguLznodFfputDzTkFHoUm7h+TL6wzHx4EMW/kApisVbTINglRznY+lrAWTTEFdQqFK2uiUMNAmhem8P0jy+F5LmAy6O92rV36WzV5+gm+kswmyP5VNMObNZifja8oYnUrTbDdfaiOSIcQibL2J0UV5fNQ8cDXoJtQN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Td+PqlP4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PiIYo7sD; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Td+PqlP4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PiIYo7sD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4AEAB1D00713;
	Wed,  1 Oct 2025 12:50:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 01 Oct 2025 12:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759337451; x=1759423851; bh=L5IS/ITGBz
	hTFWMlB4jmFt233pqKsJPkvzhfXy8lb7s=; b=Td+PqlP4DI8WQn3Behfz1n/weK
	KfwfabjCeezSUPvy7jQk2iszCQqcIH5WpOE8EwW1pbGhG9p6VJty1J/isLgJ4ZF+
	OoW2API1QE5Fiypcgf86bKWhCCo3j5FjupwwAjjHkUt5baHiNRaOwpq5mLon2r+M
	wRennLNkZALfD27z8bNu3wsHR0lw736iSNy79QXtbkVh4WKZpzo8XhRPZXz2YnSx
	xvBU8+v4I17CoUT3u+PIA6UnLZxiuG1HJC0YJldBfWcG1tyscdFfawZvXxDLySyb
	Fl/3k9N2XPwl545wWM1zIFhCpvigclf+YlapVzsZdV6nNdm8wo7yAr6HcA3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759337451; x=1759423851; bh=L5IS/ITGBzhTFWMlB4jmFt233pqKsJPkvzh
	fXy8lb7s=; b=PiIYo7sDiQmGbVDU+0waPkMNtKFhPJ6UJH9qCksJI46Yk5a15wT
	IMj6EgHGIBPrfFVZL7azKciPrHlmKL9LvwolagzAcBL57F3RSatsgNOARMdGOW66
	6VRHbR83B60GCUct0IZRjxPaQ24eaW33OCauaX8c6zP53z3yivVa9yZUBW1rcT7T
	9E9jivrceWKwyEFyEKISSpti11zhLC6KERbj4+3G0SOLdoImmdPrYVTq0qZdq5Kh
	8s2jxGn5lhk/PEezo+eKz8xXZRcq0NLwaoV/JvXZlVCmvP0/aDK2W4MCOJpaI3RQ
	jMgiJpk8F1H6P78Odk6YYlf3LWYCE/DoaEg==
X-ME-Sender: <xms:6lvdaJgedfDNJbyN-J8tfKzAGDnRmkiFwHwQKteLCh9bnuDKEgvbvw>
    <xme:6lvdaFBXqQJsmbsNYNGwEHhZMEtro-IAz52dw_hRWvY3N34uUOKzvtXEQoANKy7MI
    teZr_ASqHlJ3g00LV4XaRx4DE1nTHv7gKmMz29Z8mlIlsvQX5wUrg>
X-ME-Received: <xmr:6lvdaOEaNpKlxavZow_IaoM02Hb2z2PMvJW9hd2ynp6ofRq5bgSmSmDsh1S4h6YHAnv4HtmQ2ZLBl4NF23u8rWmPNgdeMWnIt4JW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhitheslh
    hohhhmrghnnhdrshhhpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6lvdaNKlu5vRZzUfspk52tt41H2uWDd3F4kJr9wb1pWXNcgEFrL0Nw>
    <xmx:6lvdaCl8uYxMyRprHoZUiJExOYyeVB4mBI-Vb9_6VkeGgQActJpj4g>
    <xmx:6lvdaFQB6eJC5A8oXGgQ90x5yeQvsmDCY_LLXsgbj9_jUuMWVjvURA>
    <xmx:6lvdaEIcwo0zPgPHjC8FlohiD4yl-5Ax0xWLf4hfHmODmJ40leVWQw>
    <xmx:61vdaFoWacFHZpxnQyFXsRZHmVtF9itRGqn_SMPhB92CPaKGaa7DLoVx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 12:50:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Michael Lohmann <git@lohmann.sh>,  git@vger.kernel.org
Subject: Re: [PATCH v3] builtin/reflog: respect user config in "write"
 subcommand
In-Reply-To: <aNzaKAuuzzX1xg6I@pks.im> (Patrick Steinhardt's message of "Wed,
	1 Oct 2025 09:37:12 +0200")
References: <xmqqplb750f2.fsf@gitster.g>
	<20250930195320.23825-1-git@lohmann.sh> <aNzaKAuuzzX1xg6I@pks.im>
Date: Wed, 01 Oct 2025 09:50:48 -0700
Message-ID: <xmqqcy7636s7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Sep 30, 2025 at 09:53:20PM +0200, Michael Lohmann wrote:
>> The reflog write recognizes only GIT_COMMITTER_NAME and
>> GIT_COMMITTER_EMAIL environment variables, but forgot to honor the
>> user.name and user.email configuration variables, due to lack of
>> repo_config() call to grab these values from the configuration files.
>> 
>> The test suite sets these variables, so this behavior was unnoticed.
>> 
>> Ensure that the reflog write also uses the values of user.name and
>> user.email if set in the Git configuration.
>> 
>> Co-authored-by: Patrick Steinhardt <ps@pks.im>
>> Signed-off-by: Michael Lohmann <git@lohmann.sh>
>
> Thanks, this version looks good to me!

Yup.  Will apply on top of the ps/reflog-migrate-fixes topic.

I didn't realize "reflog write" was so new ;-)

Thanks.
