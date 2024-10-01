Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC141CB53A
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803656; cv=none; b=u8tA/XKBwicn6cYqb23XOzAbPB7csdYEXN4C41VfXVZvdUQs7GQWqhTn+IqZEJTkowrT2OtKUj3aYB/kh9/iI89yUciBVt3JEQh2oqH2WuFhndOrR9LzYwQ+sB0jecArYbgsmas9U3XpwfXQeSRKmpDlveg4j0NJafFsJdB3YKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803656; c=relaxed/simple;
	bh=Ascln2gDMn7Sri1q3sdWR9TL+eqwCoXowsjCmytz2p0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YLjzwRoPP8XxAO5oU5ky+W92eKHyAlruQD0Q3BEflhamTQLpdHlfwKiujNQjT9bR6FQzqjbWX6cvjWUKuT5PsrVvUbYYeQGBZywM+YFZ1yzcOCOx15d8VG9tJpX/xeHeLptuCxDQmsHMlrQCF9TrJAlQ5uWeKR/+F6tVUqpZ6jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gq2vOcmV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JlPWdYX5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gq2vOcmV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JlPWdYX5"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 78B9413815D2;
	Tue,  1 Oct 2024 13:27:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 01 Oct 2024 13:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727803653; x=1727890053; bh=pmGOBTaw/A
	ZCWhjnj5iJ4nMHSjP8BORN2SI/lpqFqvo=; b=gq2vOcmVIGNyQrciXxdnqOZZ5T
	YQuOC4nGJw7uKjNWUMQZaxh1sul6q+Us2uFuBqtmHPz41aDU3CzE9/y49zokqXwM
	4h7AXRfa7Lx1tSox7rQyJQLWu94fO+a6Y8VwgUS+RIm7dXxPaxJLjEB+56an1lOo
	Jei0FHncxc3KR77DzCEhvsYc/nqpz1kCk4YeFEFXpxsBV3GYDDsU1q4eyvvb8DYo
	UQOfgRGvReieqlGGA5aBKd2DcIaL5dTcBfalRmBJ3lFDCcAZKLFtwGxBnpr3+zAK
	0kUEDSF2oWfs4nyQ+SKoI/GvbS2bQk+wTNDlmufAgIuJ1Ey2f02RF8jNi73A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727803653; x=1727890053; bh=pmGOBTaw/AZCWhjnj5iJ4nMHSjP8
	BORN2SI/lpqFqvo=; b=JlPWdYX5ev9Kg4Fj84VfUFZ4NSltqlEhVSOqlSMN3COe
	/YFH6LSi68NF44d8+NE/EpPdn6tuTdnTMWIbzbk+Eaq/7W9Zf3r5ja3OFQQ8RpL+
	4tat2u/smYPPcBF+69j6ftceETihDf8MjcKWuioJ9XlQoUN1/X92mF3ZpiQ1+odM
	eNEaZKmmy2+fas0b2qGsK5juoykNLMbPjsc2/n6tYyTF78Ha/kxyyrxwjF+QhWD3
	H/jrrq6OAHlYjT9L7COOstNY0YHF8oF+xxBEHIQaXNe2ImwzJOslcUreoEHXrHuD
	6DvV70r8e10rgR7mem6Iox9z6iDtq/KwTRqE3n715g==
X-ME-Sender: <xms:BTH8ZpZ8ICyCIcxzoLlhTeCWg-2qkECQm_nZ6Xz0Z-DCnMQBkg7VFw>
    <xme:BTH8ZgbsATDM8t7pMa69ENBz1S0oGCpVql9e59IjW26XsV-8gVUfAH8TsAxCoLGgi
    Aeow-Gi43nWYijAoA>
X-ME-Received: <xmr:BTH8Zr86x-sNxFQKk0Ja8hsdy7q0hAVgJOmlgLoFhK3za7jvSSpG2dhxNQKEEwcuXuYUMdMjMG7kL-ekhlNq520L6tF1uJ_xZrL0XaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeekueetledugeeffeeftdegvddvvdejjeeh
    vddtfeelieeffeejvddtveduvdetleenucffohhmrghinhepshhpihhnihgtshdrnhgvth
    dpkhgvrhhnvghlrdhorhhgpdhpuhgslhhitgdqihhnsghogidrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegurghnihgvlhesmhgrrhhirggusgdrohhrghdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:BTH8ZnoJk3E08Asfez76RNx1KokcB0WIMe1OyoaJfPXL4we1OTSrQA>
    <xmx:BTH8Zkpp2jpm_wzLN-t4wUhXGsrJ0ogCoySil7Ia1KoO8USMn00Jaw>
    <xmx:BTH8ZtTstQbtsiIAYk0pUfXoCPs1EnRzbh8oHN3Z74JgpE7yNE8ZrQ>
    <xmx:BTH8ZsrfSey0sZq_vaZgQeB59aS9I7PiKh8TZdrhNabA6ba1eM8QVA>
    <xmx:BTH8ZvWY16c7AVVmVGVwY1FOouSGzx09fUCWWPDnr8avZYLL_LNR-Iz4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 13:27:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Daniel Black <daniel@mariadb.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] submodule: correct remote name with fetch
In-Reply-To: <20241001072423.1165932-1-daniel@mariadb.org> (Daniel Black's
	message of "Tue, 1 Oct 2024 17:24:23 +1000")
References: <ZJQr0_aC-NlLXDgj@pweza>
	<20241001072423.1165932-1-daniel@mariadb.org>
Date: Tue, 01 Oct 2024 10:27:31 -0700
Message-ID: <xmqqed4zzqbg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Black <daniel@mariadb.org> writes:

> The fetching of submodules erroniously used
> the main repository remote name instead of the
> submodule remote name[1].

Please write the problem description in the present tense, i.e. "the
code does this, which is incorrect in this way".

> Correct this by using the correct function
> to reteive the remote name.

That's gives the same as "fix it" ;-).

Can we phrase it in end-user observable terms, for example, "instead
of grabbing the default remote of the superproject repository, ask
the default remote of the submodule we are going to run 'git fetch'
in".  It is a mere implementation detail of doing so, to call
get_default_remote_submodule() instead of get_default_remote().

> 1. https://www.spinics.net/lists/git/msg462320.html

Please use the URL that shows the Message-Id when referring to a
message in the list archive.  E.g.,

    https://lore.kernel.org/git/ZJR5SPDj4Wt_gmRO@pweza/
    https://public-inbox.org/git/ZJR5SPDj4Wt_gmRO@pweza/

> Signed-off-by: Daniel Black <daniel@mariadb.org>
> ---
>  builtin/submodule--helper.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a1ada86952..210ae2570a 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2322,7 +2322,12 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
>  		strvec_pushf(&cp.args, "--depth=%d", depth);
>  	if (oid) {
>  		char *hex = oid_to_hex(oid);
> -		char *remote = get_default_remote();
> +		char *remote;
> +		int code;
> +
> +		code = get_default_remote_submodule(module_path, &remote);
> +		if (code)
> +			return code;

We never failed in this function to return without calling
run_command().  Now we do.

Shouldn't we clean up the child_process structure we allocated and
prepared before returning like this?  It would just be the matter of
calling child_process_clear(&cp), perhaps?

>  		strvec_pushl(&cp.args, remote, hex, NULL);
>  		free(remote);

Thanks.
