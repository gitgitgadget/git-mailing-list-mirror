Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5938D007
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495056; cv=none; b=WKRqGB/nSP/UB2Wr8hUH4b8wBE91K7IjSCA81OVbVGdvGza56bYmnxulijJKK91oo1AS6rvPTVjfpi6F4jQXOLiG1d32GKw7Gy5DUsSOV+f6e9tNY5H9Kh8jXMFsEqbqEoxkicVWm05LWgbJZ5xqvbDcxRRJdAwMMAD1Q93Z8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495056; c=relaxed/simple;
	bh=mf1rkiI3c45GnLwybfBxU5aoavqCJHKYAdvA5aCCLqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EcApOXxDtOVs4kJ+N4DrSPZPrY3ptLYPHJy+O7Prwih9ecscON5+1jS5t3Z/REeUPo28aKh5JFxjptENkpXzIJ5LWJeezPOwSBgDuJwAvq0QoY1iEHhVcAln+mmzpYbooznSRPkMPEHuu/uSeIpDggrkKGgUD7jmPhAW90y8qv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FnaSAl3A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=En/gofJ3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FnaSAl3A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="En/gofJ3"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A3BD7A025A;
	Mon,  6 Apr 2026 13:04:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 06 Apr 2026 13:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775495052;
	 x=1775581452; bh=99bvwPZZJsXQqW1JYEDHv5EpYa4Bxd4EFKIRMxq7V8I=; b=
	FnaSAl3AJM0ZrhuMWO/ATbnBBWIlIRKcPUK6Jiqmtj93VOydaIINHSDpxgN/LABH
	/H2W/5NxmsoJLa6Rfj4UWCcBbGNHouv/YwIa9EyqtlLkBE7yI5aSS7+k4MyNhOIR
	lCtEiZ34dy1FLhjifJl0jursHUc+tNS5pO2wwd6KLNKJ6JGdgyEtmnh+yvdyqCOZ
	dCYOEllWKfPLVJs++XLgemjW7IwA8i8WNlm9NsN0InluPdpKeSSqW7TMBPS5S67x
	pSWutG2dWhlhfBTgnFPa9nrs94wzbRf4AUm2Dr7tfra3nlMuzDSX7gR6ri0oPiqO
	Pg8x9RNNz1MOY351O7iDsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775495052; x=
	1775581452; bh=99bvwPZZJsXQqW1JYEDHv5EpYa4Bxd4EFKIRMxq7V8I=; b=E
	n/gofJ3/SJbdhrA/XigWX4LdNt2EY5T1busRi9OeOp6rt6Vl4wYvM9kwHKLd0yE7
	QkA0ftFYOoz97XtMyPP2gIhm8r4ObOJZTp+lKo9fc/Fif9tLsrcrmOMURYOo0cE5
	KZ6YmSzvpFdbIAeoKIh33Zcws7Dm/Jq3q9S700nU4QWudcoPnSK16ReHzQRWvxGH
	d6o4Kdd9FQ75r0cBhc4uU1rTwnN/600hI9vwXwp0KaGutOUYihseAJlFh/hq15aN
	R7ap53FyCFBEGbSHKL+Dr0PqMy1kSFaby8J/LNpkUWQdGmcoVHw+xJInf4jBYTjN
	r4F9oz1HjSdm26tZtquQw==
X-ME-Sender: <xms:i-fTaVg_P5ojV8rEMvORsV0j53UtobHHvo410OMIPlNoVX7kx2U1HQ>
    <xme:i-fTaRDJJZi3xRcWTeCEve96TNL7u-Q4EWRl5P36G_sDmuKTNXa9CpaZ-n6HNeYz6
    98599NBKxGrDo1QeaZZ5RQH-F7cpeT7q3z9HhbOFEnjYor8TJnE>
X-ME-Received: <xmr:i-fTaaEJZWMaJMwdQJPxMR_fqv3Yf7Ye35TbfeH-nRXtjGelykumgtbLhZn6uj-LynRSlVxD_FuGPxmM6akRh8EWtflW7jMdDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgr
    uhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:i-fTaZLNN3DT2qHRSuyzT4JixDdpk8cCh7OUzAWnWLm_Wi-_fNznpA>
    <xmx:i-fTaenoTLY0N08_Pja5Bid055vybFWW8Q3wPD1KGoyzPn8beU44DA>
    <xmx:i-fTaRTPYss0RYID04opg5_JGF72vF8PG_C8vhR5AQBQgEG_R1XkzA>
    <xmx:i-fTaQI3eSVyn2ABFta9rUw0XnnFQSiRZaOhBh887fL2BeRD7lrP2Q>
    <xmx:jOfTaYvilIwOCPN5C7eRhNoiH_5UoDkaQLUGVr7c0TiCgd9QBhUoySj_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 13:04:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2 2/2] doc: gitcvs-migration: rephrase =?utf-8?B?4oCc?=
 =?utf-8?B?bWFuIHBhZ2XigJ0=?=
In-Reply-To: <V2_gitcvs_doc_link.56b@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 5 Apr 2026
	12:32:00 +0200")
References: <CV_doc_deprecation_config_--list.54a@msgid.xyz>
	<V2_CV_doc_deprecation_config_--list.569@msgid.xyz>
	<V2_gitcvs_doc_link.56b@msgid.xyz>
Date: Mon, 06 Apr 2026 10:04:10 -0700
Message-ID: <xmqqy0j0aulx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Let’s change the phrasing around the `linkgit` while we’re visiting this
> file (see previous commit[1]).
>
> We use the section syntax to refer to man pages, so writing “man page”
> next to it is a bit redundant. We can be more concise and just lean on
> the preposition “in”.

Being succinct is better ;-).

> And in order to avoid this double “git”:
>
>     see `git config list` in git-config(1) ...
>
> We can rephrase to the subcommand, which is a typical pattern (config or
> option followed by “in git-command(1)”).

Again, being succinct is very good.

> † 1: Which also discusses why we do not change a similar phrasing
>      in gittutorial(7)
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     v2:
>     • Just the “man page” change, which now comes after the --list/-l change
>     • Restructure commit message paragraph so that it leads with “section
>       syntax” and has a simpler structure.
>     • Footnote to remind what was discussed on the previous commit
>     v1: (combined --list/-l change and “man page” change)
>
>  Documentation/gitcvs-migration.adoc | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/gitcvs-migration.adoc b/Documentation/gitcvs-migration.adoc
> index 2883834b714..905d08cd5f9 100644
> --- a/Documentation/gitcvs-migration.adoc
> +++ b/Documentation/gitcvs-migration.adoc
> @@ -49,8 +49,7 @@ them first before running git pull.
>  ================================
>  The 'pull' command knows where to get updates from because of certain
>  configuration variables that were set by the first 'git clone'
> -command; see `git config list` and the linkgit:git-config[1] man
> -page for details.
> +command; see the subcommand `list` in linkgit:git-config[1] for details.
>  ================================
>  
>  You can update the shared repository with your changes by first committing
