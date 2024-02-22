Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746612BAE8
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620407; cv=none; b=p1AgBUsHeiEgO8UeK/r/wZKRPKZDzlOcJBkZ+oZVH6IjVwyvynJnoahDqy1EM486OM13QmsHkv4LasspDFrqBAxi755OgVYa1eWsNcGdSq4Edmva8mnDt/KNNgyxMy9PaDPQehTRDkdpprlACt2JyYJiXaI8n92mQekxU2OrDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620407; c=relaxed/simple;
	bh=f/IxnQOiZUcAGppqbDp3UCvc9SY/94vdYZuz+HtmJPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHEDUnCTgBIltF9RHsvteV9tspLHSU2L8EB4uajpTpkmWCX3AGbaDrYsYdLp/WLzEBVwSe5OqkAkg1bqdIvgDc0U0g64fB/m0R+y+0HkX2Twww5zZ4ajhZY24MW1Y9VpEzUn3lVT05SVz47CgCnhghZOah+y2OSBzQkptzcTsbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IrYLGI+x; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IrYLGI+x"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 922B51E56B;
	Thu, 22 Feb 2024 11:46:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=f/IxnQOiZUcA
	GppqbDp3UCvc9SY/94vdYZuz+HtmJPg=; b=IrYLGI+xG6BAfQ7XRAsL17E2r4LW
	om6nv5zZHasK1hMYJ7QDO/uHD9SYQTfXJGuWEa8txe8GmA1PtqJ29ClXbfqaTy0/
	cO2thkPjnXQsgSMpT5VR3upP5yOP+q115OW0/X6BSsFol11R3y5FtDut0QEBjPom
	2bJgYfj7ZKMiNMA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 89F131E56A;
	Thu, 22 Feb 2024 11:46:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2DBDD1E568;
	Thu, 22 Feb 2024 11:46:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,  Harmen Stoppels
 via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Harmen Stoppels
 <me@harmenstoppels.nl>
Subject: Re: [PATCH] rebase: make warning less passive aggressive
In-Reply-To: <7633780.EvYhyI6sBW@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Thu, 22 Feb 2024 11:01:59 +0100")
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
	<2324063.ElGaqSPkdT@cayenne> <xmqq4je1mo5p.fsf@gitster.g>
	<7633780.EvYhyI6sBW@cayenne>
Date: Thu, 22 Feb 2024 08:46:34 -0800
Message-ID: <xmqqil2gh2fp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F138A39C-D1A1-11EE-A7E0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> About "again and again", I was more refering to strings such as "could =
not=20
> stat '%s'" and then "could not stat file '%s'".

I completely agree with that.

But the message you responded was not about that kind of burden to
translators.  It was arguing that it somehow is better to update the
in-code _("string") at the same time as updating msgid and msgstr in
the same patch (it may not have been directly "arguing for", but
essentially doing so with a rhetorical question).

So your "I do not want to translate again and again" thrown into
that context utterly confused me.  I didn't quite see how the
"everything in one patch" approach would help translaters by not
having them translate "again and again".

Thanks for clearing my confusion.


