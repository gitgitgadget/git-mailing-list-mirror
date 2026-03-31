Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E6E3F7E85
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991536; cv=none; b=DPIns+ks4MvB1UIgBXTPZ6HdcSCwt8vikJ9uKRgLlz7ki872+Q1zcDiZknAByqUJzae6tP2et31zRVyvv5hiNQQEVk1RbjOvbYMHy/vx1HUa/WExMHNNVNVZPmG8hz918nlznO58ZGBWD+dawd1rh4pq1R1dGg9F7mXO2uCBbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991536; c=relaxed/simple;
	bh=89xYHlZLG+zXc8AZGGr4GZEBmR8vam/HHDvuB//3JII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cq+aiGpAfpjoedDqIatJc5eWPkkHfnlJjQKk0vFxhwmfXgSBpt9q9CrBs/A6p8+Mx2MOMmw3abiL3wbZ76hHjxWdBEt4iPa1Ek8RKx0Xr6hHQ89QgAz6G6n7r2dC7Xz1eHv7RA8TZP+kIhZ5sF0rQ9vnmFDb7Zj91IsmoH0iLAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QMf519Bh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ie1s00f7; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QMf519Bh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ie1s00f7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id ACBC31D00144;
	Tue, 31 Mar 2026 17:12:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 31 Mar 2026 17:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774991534;
	 x=1775077934; bh=KPOLPKs10da7iufohrnN4KQGNo4LS0Sv/J1JuLvMQcg=; b=
	QMf519Bh1ooaqoZgWA7HBsBcVds/GAtCwTyJsk7gRVMRRP0ThsjA9ujKbUlZbb2H
	FlJSOIR2Zdpn6Q03ldFy5XLOYMKPcReUtlj1afjDAW9WAE8tTVmjIIfl00Qoy409
	gPh/DkCoE42XMx7oiCeWARO50mQI3PPiOEvVbBU9eNq5ZFY2Sr22qH7Lvjsq5tCW
	/HVP8+8BhvlyJPocmHGv7IpliH+MggknjLU/R05ormWH8/LUPtvCCzJ9EMqvICsy
	kORK9LWlkN+tjauyI2lp3gTTFz6MCHvIoWL6RbL/cWuqkPOoIipHl4wSWmoXAOt1
	B3kfMmx+y/0wFfgPxQg2vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774991534; x=
	1775077934; bh=KPOLPKs10da7iufohrnN4KQGNo4LS0Sv/J1JuLvMQcg=; b=i
	e1s00f7hdaKWoM43UZdV2UirYO38MdggVS0rLs5jQ0iargiYluhxtgAwwbc+12aF
	MA3R7F8AUaNd8EqGXHr6VL54RspBZyr8ltWRf5Lq5RRGcD975kgaNuecxr/0C//R
	E8cPZ8D2y0oPNoNadwdHx2Pke6FUXBpXj0kgU3XG7l+woNQvVcnDGCbQgQhBoBK1
	3Aerzuva6QwVNNNnO7uA0V1eX1yb23OYhGeYuuGUlRJMn2ggzzOMtU0irCgEp8Oh
	K6GDcRrsRnCDHp4mZCZq6c9nqiqercq7tQPlQs/JZNuGQRRAgN00qE1hNKEQhcY2
	Bs8e2XGJGDOsbb9dnLTEw==
X-ME-Sender: <xms:rjjMaUyrLV9qW29hojf_OAcw_WRd-uw-glGGaoQSutZDWaLYhyMhiA>
    <xme:rjjMafIdlXu_u-NL0cZestDaYqDxATDM-awOPhWaf2MiIa9KH491CJkGyaVnyEhhZ
    As94waRavyVjLanOq0Jv0IxN3IawKyDjCNVV6hgwAeUjI1CaQfI_c8>
X-ME-Received: <xmr:rjjMaeq-j7Gzz0H4FF1qdjVal309XDwf5s9hUVrivJs_DJDZdRBbFzmvmDyW9m7FHKBMWqfAAHWRfC0RhOrZNaMX-8dVNsTu8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttd
    erjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgf
    ekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghu
    ghhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rjjMaeKvEzGaGEA-evS8b4RTnAYC0wPwzvuvFK91VF75vyG66tqBsw>
    <xmx:rjjMaTSs1Op51YzCBeeTRWyaPUcZbQff62d6NmPy1BoEiVl8AWGFmw>
    <xmx:rjjMadtjMOvTDB1k4IrbDYqPOK17Ms0UvkO5Sg_mOZ-J6T2R2yPlBQ>
    <xmx:rjjMaUaObuszl84seCGct7nZUuiW9Lw-P0vXTv-o_zRld81Uh6BiCg>
    <xmx:rjjMaewSGnMikFOXrtWEArNjitnTANvIx44-9dstjCaGBK3Hr-5HWGuf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 17:12:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  ps@pks.im
Subject: Re: [PATCH 1/3] doc: var: link -l to git config list
In-Reply-To: <doc_var_no_config_-l.54b@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 31 Mar 2026
	22:48:08 +0200")
References: <CV_doc_deprecation_config_--list.54a@msgid.xyz>
	<doc_var_no_config_-l.54b@msgid.xyz>
Date: Tue, 31 Mar 2026 14:12:12 -0700
Message-ID: <xmqqv7ebya8j.fsf@gitster.g>
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
> The option `-l` is deprecated and links to `git config -l` as the
> replacement—which is also deprecated. Break the deprecation chain by
> linking to `git config list`, the command which has superseded `git
> config -l`.
>
> Also promote this part from a parenthetical to a warning admonition.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-var.adoc | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
> index b606c2d6499..98f4dc1a479 100644
> --- a/Documentation/git-var.adoc
> +++ b/Documentation/git-var.adoc
> @@ -21,8 +21,9 @@ OPTIONS
>  `-l`::
>  	Display the logical variables. In addition, all the
>  	variables of the Git configuration file .git/config are listed
> -	as well. (However, the configuration variables listing functionality
> -	is deprecated in favor of `git config -l`.)
> +	as well.
> ++
> +WARNING: Deprecated in favor of `git config list`.

This changes the meaning, and I am afraid in a bad way.

Use if "git var -l" to ask values of configuration variables is
deprecated, as we would encourage use of "git config [-l | list]".
"git var -l" is and will stay to be the way to ask about logical
variables.

The new text, unlike the original, does not limit the deprecation
only for asking about configuration variables.

The logical variables are called logical because their values are
synthesized from information taken from different places (e.g., you
might not have user.name configured but may have GIT_AUTHOR_NAME
environment variable set and exported or your name configured
correctly in GECOS field.  We can ask what the value of
GIT_AUTHOR_IDENT is, without knowing where that value comes from,
and the source might be outside the usual Git configuration
subsystem, which makes it "logical").

I'd prefer to see this step just stick to `git config -l` => `git config list`
rewrite without the separate WARNING: style change.


