Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C920E6
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752020058; cv=none; b=rKXZsoPnjhnVK+nm6e5BS9MrWquJ8xBQMBkDmnj/tmt2UmtWRbzo+3VB+z69m83aQxt6oL2TAk5wU5vLDVa38y5pwmofsp68t8niCA0zarjMu1vOPtnzkgD/2n7X7H2Pkn5VipQ3CQ469vGSHUIEVNowsRsui6nx3wt5ihuuI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752020058; c=relaxed/simple;
	bh=77kzzYiHD1ltiPn1GDtJNL+aBjgDHIPZSZunv1Zb1yA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KDK125KER3/Z3XlJJYOsXwZbIEwV1z6eAqTU8RDeNmAcWSRT921ma+S/lYOV+1MpbLeWx5Ecz3s3KDqws5Qi3GrjtOu0E1ZtYh7gPNKYtsyLcKamDDUWDN4jdqTyA8Npkqq++Nmt1iEkoNy8DwcxdLopQpidKkVu3CazRal/xYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bChHZ4kG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JuG3SzmV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bChHZ4kG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JuG3SzmV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3655B1D001F1;
	Tue,  8 Jul 2025 20:14:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 20:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752020055;
	 x=1752106455; bh=7oqhJQ/AeGSPVSaivu1jZudMjuJnrI8RAZSPDHdmzd8=; b=
	bChHZ4kGCOo0F/skOWWBFLNFhFIN6q2+jAcxQs3/NG/jRljzLDISEeWafD9YvLXi
	YWe7T3mxqzzxGZtxuV5ZjscX99kAxccONBPkMVamE6FxaJ7p0I8fTK+Waigvgu2C
	ElsqrN4qR6wLCML1ByQI1S2y655YO3l/QdXjSdCmgZZ2RN0CQ6i58cW7B7ZE5lJF
	hxztLQ4hOgpevOik90c8AqtBVNIZHGOhrFC/x3RgMFj+OvSB6LQ5MfURscVMgw3v
	uni82EQ3/lOpOw8gSl/lOi+xzcb7bMAD+MO1SIlHD+/R6jv5wNP54cRHWKDSck8c
	L17q9imZH++p+zE/KJiMZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752020055; x=
	1752106455; bh=7oqhJQ/AeGSPVSaivu1jZudMjuJnrI8RAZSPDHdmzd8=; b=J
	uG3SzmVYvNxriUBTCR7Icc26lmI+tRibYsKaFn3WqFqpXdtWcl+jZi5PVCR+S63B
	pFm6qEVBMcoX0nCCgWQFxZEPEzwahUru+pTrfujBj5gprW/qt/2satKvccoWQRzP
	lqlGk1V0/s/6GfZaPynHQ0x5TfVv55YgOzGM9mhSkRS2RDAl17SV+SnW+N196xiM
	OVC28TTWtINOkISGg8GAGxVUCc0v/UbON7/4KSqrnTCIx6ADiuwcndkxtPfcezvf
	Ff0xX917pFpCbPnLjT+oZZrNGmyRAYG/iD9lGFXc1ZVVf1HdHaU7NMhlFsssu96S
	exdJ4NP8CdFLt0kGawvlw==
X-ME-Sender: <xms:VrRtaJCO3pKQkWab8fEFEtLh6Gk-_4Cz9n1H1Qzk4nz3zU_fiAaQzg>
    <xme:VrRtaKwbFv73PUJDJ0m8VypHjcbFlNYCxVU0tEGCUqxhlXzHbEUSCkL6ZpAtkwFLe
    xcBzX5FGXytCa3ezA>
X-ME-Received: <xmr:VrRtaODToJ-shhANzxCji0mnu_8_yi4qqEMK4iuT6jjJ1B0QXYUEcjnN-qW0Kr1D_m9TAKT0IqoOjcL1dqUW7JJwHasuAEQu3g2BVEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefiedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehohihsthif
    rgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VrRtaPbxtnLkW4e2dvqNuNYg2VC8XFj_jr2QaDr30P0OFZ-7t15P_w>
    <xmx:VrRtaOiKoaL4tP7RpCnCzh0dSPYC6fs-X9TlSU6-NF1eoFuploNWHw>
    <xmx:VrRtaJ6eRw0GGXbjmzc4Ehb9n6Ysp-hFMJj1ojHpU2mcZatxHFb99Q>
    <xmx:VrRtaN4916BdlS_QZcOiUIei4DZ6a96EHu-C9L_ouwCzOpZrohKuIA>
    <xmx:V7RtaDZf9f1bvkrW9n48FKZSUML0eb-fE7TLmarY9znjl9KoG_jTP7Zh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 20:14:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rebase: write script before initializing state
In-Reply-To: <20250609221055.136074-1-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
	message of "Tue, 10 Jun 2025 00:10:55 +0200")
References: <20250609221055.136074-1-oystwa@gmail.com>
Date: Tue, 08 Jul 2025 17:14:13 -0700
Message-ID: <xmqqfrf6qkyy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Øystein Walle <oystwa@gmail.com> writes:

> If rebase.instructionFormat is invalid the repository is left in a
> strange state when the interactive rebase fails. `git status` outputs
> boths the same as it would in the normal case *and* something related to
> interactive rebase:
>
>     $ git -c rebase.instructionFormat=blah rebase -i
>     fatal: invalid --pretty format: blah
>     $ git status
>     On branch master
>     Your branch is ahead of 'upstream/master' by 1 commit.
>       (use "git push" to publish your local commits)
>
>     git-rebase-todo is missing.
>     No commands done.
>     No commands remaining.
>     You are currently editing a commit while rebasing branch 'master' on '8db3019401'.
>       (use "git commit --amend" to amend the current commit)
>       (use "git rebase --continue" once you are satisfied with your changes)
>
> By attempting to write the rebase script before initializing the state
> this potential scenario is avoided.
> ---
> The diff looks perhaps more messy than required. The only required
> change is the filling in of make_script_args and the call to
> sequencer_make_script() above the call to init_basic_state(). But then
> the `if (ret)` looks out of place, and moving that up means adding `goto
> cleanup` which means the code that was previously the else case can be
> dedented.
>
> get_commit_format() calls die() in this case, so cleaning up the
> sequencer state isn't an option. Maybe it shouldn't call die in the
> first place, but that looks to be much larger change.

The patch has been stalled for a few weeks since Phillip's review
comments.  What's the status of this?  Will we see a response and/or
an updated patch sometime soon?

Thanks.
