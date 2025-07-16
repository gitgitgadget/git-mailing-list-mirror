Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8E25CC64
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679721; cv=none; b=MA6wS1Cqb9UmQgIi5iRJVZUIUazXacidDaLnJT0d2wCskV1OAhmkQ+KX18mh0WiGKxuObReLeYktglLRNv4dTcBXOCrU2nxNaBrun1ux1n6JVclCwg7uRnXogBF34obNZ1XtyUuGZ/CakvFrAenvD7HduxP0GvzrU+5mNOtfp2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679721; c=relaxed/simple;
	bh=bv/mSGa1jPxmUPPkKBJfare6smpnf05j4myajiGvJBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p74iBJve/1q3PKk8uA2rcjreynQA3qZIk96lifLigoLuOpBTDzaBDVuMN1DMfKCOa9VIY6ZhqIYfosUgS6zL9UIkCBbapv+d4Gr9bGEUhS+bZMF1+802U9f2Zu/CqVVjIpczDtDgniN+OoHNDnTf7y0WYigFVOyxfMDgSPDqapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IPzm2XKG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C6K7dB9q; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IPzm2XKG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C6K7dB9q"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 309F27A00B5;
	Wed, 16 Jul 2025 11:28:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 16 Jul 2025 11:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752679718; x=1752766118; bh=JUBYRD06H3
	FNKyl+bvvBOMjkwTHkYQUQn9pLGPBaIqs=; b=IPzm2XKG6QHQj7ZoTtPwoJlQzU
	DF4MyZ06lAOErD+wuwx0MCYcE4Tok+qs9Rb/AzVDPzH2h83/1UabzObF5oIyzcib
	xMaBZX4IGqlKlNYIA6QmVip75xxVY1g56/hSnL11xizVHWv9Ubq4GuFgkGLOxr3V
	VcMA7f4fPfaKtnxCDlmEnHQJKh95w153+MjWIGRvvG7aLV+pxP4NJtBX26hKypaL
	amY/DAdXkCu6lVAFe/ppdc37AkFgE5sBumSM0GnpHxteMLZb3BvN5nqY6H0PFwVB
	Zp5bvCmCDKqTbCC+O9hsNBFYvqIo2A5P3vEK12/A2yx91Qyk43XpwFUONWew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752679718; x=1752766118; bh=JUBYRD06H3FNKyl+bvvBOMjkwTHkYQUQn9p
	LGPBaIqs=; b=C6K7dB9qfp4cUAZbSA9KWtrk/K9hDd5S5tMygkXEfs7/c4NGlvb
	E/z56u15ScBI0IuO31rAacCQAqeruLxfGnfLcF6mJXdS9ZWF53x10emuzC796tdL
	w8LFHojAPqB1zObbXScKNTnoGqmEt5YYTGaBboqJY9209qBcQ2+O2SMJ0skIh4WK
	htOKhWM3F8meFHguH1t958ybqyr/rfjxeczT86esoeUzmHcfKKY+9dogQCwDbcR2
	5PH8uQh2yXk6sRK6bsmIuAqjKMfZscwmNlNwXb2ytex4AoRQpxQmy1eLYSRyCHgV
	JXGDyKM2wSCtOgyB8jru9imkKalVmBaTU6A==
X-ME-Sender: <xms:JcV3aHzd6vR1FlnO6zls-aEw7TmvUAy1R5QWeNvSwtgb5o-6BXh_pA>
    <xme:JcV3aEdEjCnbsviOCXHqk5PtgDUzJoe2i5ovK5EdU2CQySPkJTNe8j59JcnLtaIyw
    b8-vXbv7aFsXlcR1g>
X-ME-Received: <xmr:JcV3aCPaPBr_xE1o_OB1Py7t5-FvqbpyeplPyQLdsjKmpEJ8PAQ8M9yNuxB3VjG7n8sgJK8FoYqdM61miJy3FDDQ73x_Cnia00Cv_Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprgihuh
    drtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhi
    rghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuh
    hnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:JcV3aHuj68yjgpYNH-9b-mfBcKLsFbOHjoqsztwrc1DfTjQLSNT3cQ>
    <xmx:JcV3aLD9TIfkNvZH5KwZ7wJmFE6LW6jxE9P3ziP-bRayyE-PC3OAzQ>
    <xmx:JcV3aOb4Ec0_QQ1r1jP1Wj2DCTPPLgw7n1wkms42_yOuzQloBGeGWw>
    <xmx:JcV3aGVT2muyumrPnuxyBvsaVD9UbzAdUOkz8IU0LNJYxvHAywvtkw>
    <xmx:JsV3aMMPorcKac3eLBI8EvlDStc84jGdH56OlpntQDvziDahSVpJsynL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 11:28:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  shyamthakkar001@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [GSOC PATCH v5 2/2] config: set comment_line_str to "#" when
 core.commentChar=auto
In-Reply-To: <ffe16a257f5cff54630aac0b9af601705b2865d6.1752665506.git.ayu.chandekar@gmail.com>
	(Ayush Chandekar's message of "Wed, 16 Jul 2025 17:13:29 +0530")
References: <cover.1752665506.git.ayu.chandekar@gmail.com>
	<ffe16a257f5cff54630aac0b9af601705b2865d6.1752665506.git.ayu.chandekar@gmail.com>
Date: Wed, 16 Jul 2025 08:28:36 -0700
Message-ID: <xmqqwm88cfyz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> If conflict comments already use a comment character that isn't "#", and
> ...
> The patch text is based on Phillip Wood's message:
> https://lore.kernel.org/git/9e96aaab-79a2-4632-94cd-d016d4a63b30@gmail.com/
> and the commit log message is wriiten by me.
>
> Based-on-a-patch-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---

Earlier in response to your "Phillip should actually get the primary
credit" I said to ask for his sign-off, because I took it as you are
actually making Phillip the author of the patch.  But it is fine
either way.  Phillip has given his permission to add a sign-off, so
we have everything to move this topic forward.

Thanks, all!


>  config.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index eb60c293ab..bb75bdc65d 100644
> --- a/config.c
> +++ b/config.c
> @@ -1537,9 +1537,11 @@ static int git_default_core_config(const char *var, const char *value,
>  	    !strcmp(var, "core.commentstring")) {
>  		if (!value)
>  			return config_error_nonbool(var);
> -		else if (!strcasecmp(value, "auto"))
> +		else if (!strcasecmp(value, "auto")) {
>  			auto_comment_line_char = 1;
> -		else if (value[0]) {
> +			FREE_AND_NULL(comment_line_str_to_free);
> +			comment_line_str = "#";
> +		} else if (value[0]) {
>  			if (strchr(value, '\n'))
>  				return error(_("%s cannot contain newline"), var);
>  			comment_line_str = value;
