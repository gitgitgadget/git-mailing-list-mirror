Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06BB277808
	for <git@vger.kernel.org>; Wed, 14 May 2025 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227541; cv=none; b=TAmT2T+6qBSgARXT2YrI6rDUd39FR9tt6b+c5UAUJwlsdX1qQ2BmgfaAJCgzuFVgSDTvtm5iagcZohmYyONOdTRbPuuqvq9BIIzAalYz4yClVoEwh9tzTDoQxcrxFqwyCQhf3YpXRnlYyvu3xug2XfkFiop6rOjlXfN3rOHmbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227541; c=relaxed/simple;
	bh=n6qmixKZvZ0jPmSUz3tvxU0ca2uX8v2Kz7PmmT2mWPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HETjEY0tmjFjajGSWfQr0NQ0EEz2xv9c4tosSGUZSVzAncc+R+cXTxSe5vbFW4iv6eopgYWejSMCmLHlKy6S+bAncvfMr41PGuiJ9vzZsp5CwtH54omN82NuhOW8yqXQow9Tq2w8BVbPHkDM8W10g1L/1Bqly+VItMFWsfDF8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MT/Gp88c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijqGUjiU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MT/Gp88c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijqGUjiU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E0BBB1140152;
	Wed, 14 May 2025 08:58:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 08:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747227538; x=1747313938; bh=MeELXb/FcI
	VtPlnqGl/lk3qgQ732erxR3pfAgmlN1p0=; b=MT/Gp88crHrB3ksPYHWv8xfvRc
	vpuEmnovjq0M5UlZpS+gEj4IULBqmkD9aLmxBFefpmChQXbA8iB4geIIlAx04mbC
	YUfY5KzIRga0qatR7B1pIi4SucOn5g9rRBz+ODWPhQ+SGp1Cdn8htrFzGIB8WJsC
	532Q2V9mm7FXWEe2IZgCxSrAGaIOGZocofOvvEzocCZ6Ep2E/Fm0llX90DWVfECT
	F60QOxyA2ZDpVfIob3e66lLJasLHQNXdkMjwUbxNW3niyrcbrQscQSAA5tJX3y36
	4HLRlMG/K+2gkcJnrXL8WYhgdHEc38zgDlz+jBnd7r06o5ae7pYl1GAybd0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747227538; x=1747313938; bh=MeELXb/FcIVtPlnqGl/lk3qgQ732erxR3pf
	AgmlN1p0=; b=ijqGUjiUBpt8olYA28gQ6DIIZx7F37JwywjMU883LsdpDB3et91
	Wk5gOnRDO8afy8ZDQJTTj7f8waH1zGvKTQqdA1NqKENXyFkQKg4B9mhPho3R50Ri
	KWyQm0IF/vB4gLJs1J20NePCEzoKA/YdVq3acMIUahnN6Z0chvyTg7lIjLOeUrDT
	EqJd92VULdo+yTtpxepjE9DHOCVOx5hPpIv1omWcbR5F/EMQunEbn5gT7Wl4cmu2
	X2GNuQrXRNL200QVAaf8Px4fXkWEsyKv3vVzwyk4qV5W6clYfmx7oYkpXKqDFAD7
	vW9qzJBeUuZaTJxFzHbMTSkCO84MpLxdmSg==
X-ME-Sender: <xms:kpMkaEPBxEM7Pm3idB0HeqfcQlH_R4Bs96mjzxqMRQMXzyB2cnkdrQ>
    <xme:kpMkaK-XIixdNIJaneFkkp69ld8hnyABFptMRjnNGqTEFF9L7N-Wh_13F1h23LC3J
    qvoFonetXQJyCXjXw>
X-ME-Received: <xmr:kpMkaLQntm3tIk8COxiPi-Ho0WAINmTMRoce4zVhxRri69AVh97cC6NW-4qyOdZG0kOgUSbtZUTDwLcALB-5jj2jH8qD7hr4oUT-Ozs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhephfeugfehkedtffdtuedtveekteelfffh
    fefhvedvhfekjefhieevgeevuefhueeunecuffhomhgrihhnpeihrghhohhordgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhulh
    hirghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgv
    sehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopeiiihihrghoseguihhsrhhooh
    htrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhooh
    hthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:kpMkaMsLDlWR6lpTpKBDKvAd6zuNlTlWP3y8OjSRA7k4dtgPajJrpA>
    <xmx:kpMkaMcr-_qExZyEzYPhzpuqEslfRH69xgDIKGOsdJr1SiWr9VHCSg>
    <xmx:kpMkaA0KofTr7HBZQ6RhMzAbIMfN2xUHJIljstSAhBAwVKQxzoMglQ>
    <xmx:kpMkaA-HMtRoRlllln6U-uPC5eO3-ACdRgk1p06dMtCKdtoO8z8YFw>
    <xmx:kpMkaHKxuBiRU0nafgNe0qHk5bjAq9XfCkUqY-42fQu9_gXzXYpz5U4d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 08:58:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Julian Swagemakers <julian@swagemakers.org>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  sandals@crustytoothpaste.net
Subject: Re: [PATCH] docs: add instructions to use Yahoo with send-mail
In-Reply-To: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 13 May 2025 23:58:44 +0530")
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 14 May 2025 05:58:56 -0700
Message-ID: <xmqqo6vvcprj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Just like Gmail and Outlook, Yahoo is another popular email service
> provider. This commit adds instructions for Yahoo users to be able
> to use it with `git send-email`. It also adds instructions for
> OAauth2.0 authentication for the same, and adds a link for a
> credential helper.

Heh, I didn't know they are still around ;-)

    $ git checkout master
    $ for p in yahoo.com outlook.com gmail.com
      do
        echo "@$p"
        git log --oneline --since=5.years --no-merges --author=@$p |
        wc -l
      done
    @yahoo.com
    12
    @outlook.com
    16
    @gmail.com
    4765

> diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
> index 26fda63c2f..61a2d03546 100644
> --- a/Documentation/git-send-email.adoc
> +++ b/Documentation/git-send-email.adoc
> @@ -561,6 +561,35 @@ SMTP server with `git send-email`:
>  	smtpAuth = XOAUTH2
>  ----
>  
> +Use Yahoo as the SMTP Server
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Just like Gmail, you can use an app-specific password for Yahoo as well. Visit
> +https://help.yahoo.com/kb/SLN15241.html to get instructions for generating
> +them. After generating, edit `~/.gitconfig` to specify your account settings
> +for Yahoo and use its SMTP server with `git send-email`:

I am starting to doubt the wisdom of giving one section per
provider, especially since the delta between the section is so small
(essentially, the server address, the smtpAuth supported, and their
official documentation URL).  Would it make more sense to just have
a template example with placeholders, and a table of placeholder
values that has one row per provider?

> +
> +----
> +[sendemail]
> +	smtpEncryption = tls
> +	smtpServer = smtp.mail.yahoo.com
> +	smtpUser = yourname@yahoo.com
> +	smtpServerPort = 587
> +----
> +
> +If you wish to use OAuth2.0 rather than an app-specific password, you can use
> +either `OAUTHBEARER` or `XOAUTH2` as the authentication method. As an example,
> +if you want to use `OAUTHBEARER`, edit your `~/.gitconfig` file and add
> +`smtpAuth = OAUTHBEARER` to your account settings:
