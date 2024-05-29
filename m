Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B158BFF
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020190; cv=none; b=ebyr0Db37Qc+4HJnF0ahyLH3ngIAAJFn6C2RTE/XRHYH5TWv7veax7d8wYhg/EVqamvokyPHTpSgzMfMWp/S7T3tw4pDalLOxM8+HY3ipPuVkkuI70WiG+j5Xg4oGrl2EWojnfHJlqXkzPLwzThDJfsKRig4bBEwJ1JpgTnrxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020190; c=relaxed/simple;
	bh=LFsMmui6WALxKd47B7aYAfbVsYiMezp27c09mNoKORg=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=EhnjhUbUFs6Rs4wUphLrxpc9clAzEj5p9CNKBOegLGph1QHQZhGJk5G11m4roZM1Ws/wlxHTj3/sz6bOIIhmi0n59KupowzUonZQrYLNVDwKAloMyCQCnuKerV6CMt7lt/COcGY5VeKA7QZx1lg3R1bplXPNc7Pzs7yZoODPLLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dragondata.com; spf=pass smtp.mailfrom=dragondata.com; dkim=pass (2048-bit key) header.d=dragondata.com header.i=@dragondata.com header.b=fkiHxzN5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NE0BuW5/; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dragondata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dragondata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dragondata.com header.i=@dragondata.com header.b="fkiHxzN5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NE0BuW5/"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id C4E951800188
	for <git@vger.kernel.org>; Wed, 29 May 2024 18:03:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 29 May 2024 18:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dragondata.com;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1717020186; x=1717106586; bh=XT
	2TwOvF0WEnh1L6rgB0H4VXAnCkvjhXaQwjgGn7p4M=; b=fkiHxzN58SyX5kVV/w
	C+s+cZiMINlzggEisS/dgle46WvMNW2l0jLcAocGDGRi54RQFM0Yg7+j942FNpKo
	EyhDZ4hFXBZdDS1xRRcpseMoKB9ftgDvxYZ1+fFOhoo3UDXvCdmVM0Og5aM5Kldf
	lH2o4EI/RlgLFF9XOZGtuc24VeitrgyHAxnRfjwzP7a//o10jyI+Uw2Lh9Olgdtk
	IgV8hXKvUToD5z1Jjnvt3hzNcgcPbM2lszRCS2RP6LYXRVuCpY3Pa9ix9sjvYB6G
	anMx/NzRCY0nEVKHwWj4nVNr6zd2209+L/dt5kfwGrckiUgqZu58xseG6fdqoLTN
	ve5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717020186; x=1717106586; bh=XT2TwOvF0WEnh1L6rgB0H4VXAnCk
	vjhXaQwjgGn7p4M=; b=NE0BuW5/cgxcsLygg7tUo+k8iiov7D8kWa3POHadu89N
	0kG2Hk4mb3mghmNmW4+6wrVBkZHfIVzjCkXro2Es3nqqoWvIvw51nxhnjAOBN0i6
	HyzQ/X5t9GghfOSoqKrjKcqnklqdS7wHRZyOAt4sQp+gHAvgqdO7vvVCzvWOk04Y
	SAtBSLNLEubdAcswy+DkxFVSKqME45kyPiowsowhm7fPU6+M5FrB5OM2cng/WVVV
	JQAq7mMjIsFPghmRwH0wwnBrKsCjfubd4cERiSlMupPedPIvDcz0gMG9ZDi5WPth
	P7/YzOk823RCGG4HH8kuaMAJujpPI3OlWtBk0VpEwg==
X-ME-Sender: <xms:GaZXZgjoJ8BeEPnUAx8wkKXcFtF49vuH9A8eEzBYrM4otx5WgZZbiQ>
    <xme:GaZXZpAXy8quJArqcUcTiM7f2BRJ1CdLTqXxGExHX3qF34OiPK4DMn75vJm__abjP
    hwTKU0H9-XMAPFoObk>
X-ME-Received: <xmr:GaZXZoHAxF-iW1AyXDAFoQb0yoKp4z2ADyJQHXkuf8JcSsoAbc1axV5j8I_u5-BdWXcKydaMcu1fUY-W73LUcX9zc2PJWUK5JaQI9cH-aEmU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekvddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhtgfgggfukfffvffosehtqhhmtd
    hhtddvnecuhfhrohhmpefmvghvihhnucffrgihuceothhorghsthihsegurhgrghhonhgu
    rghtrgdrtghomheqnecuggftrfgrthhtvghrnhepvddvvddujeegkeefledtieehfefhie
    ejffetvdehgeegheehffefteegleevjeehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepthhorghsthihsegurhgrghhonhgurghtrgdrtghomh
X-ME-Proxy: <xmx:GaZXZhRJiSVaBTCp8ZDV4TFT7x87haMa70OaEONfUUCUka0KgYIWyA>
    <xmx:GaZXZtzZz0V2xlEq3UoxVmpNrnCIRpzYpda0OITEYj31CQHfy2Tqng>
    <xmx:GaZXZv4G8pb55mTf7ZbHqT6VMzAQ5mcRzmZlcCxBhgnPDuT4kc4DCg>
    <xmx:GaZXZqy_GuBT7UYpf39Mb6JHAqUu0fGSZaO6Nabnj5EKLak2AroR8Q>
    <xmx:GqZXZuriUDJLk1Z_nPjFN3sJG8kxexVqs2aYXengoRmuzFQrOM1yBbJn>
Feedback-ID: i862946f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 May 2024 18:03:05 -0400 (EDT)
From: Kevin Day <toasty@dragondata.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Commands using -h as an option don't work consistently
Message-Id: <52819526-4C6F-418C-8B8B-A4D5C7E371EA@dragondata.com>
Date: Wed, 29 May 2024 17:03:04 -0500
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.600.62)

Because of a bug in parse-options.c, any command that has a '-h' option =
will sometimes display the usage page instead of executing. For example, =
ls-remote has two options:

    -t, --[no-]tags       limit to tags
    -h, --[no-]heads      limit to heads

git ls-remote --heads  #works
git ls-remote --tags  #works
git ls-remote -t  #works
git ls-remote -t -h  #works
git ls-remote -h  #shows the help page

This is because of these lines in parse-options.c:

/* lone -h asks for help */
if (internal_help && ctx->total =3D=3D 1 && !strcmp(arg + 1, "h"))
goto show_usage;

This is being executed before it looks to see if there actually is a -h =
option. So if a program has a -h option, and that's the ONLY parameter =
you pass, the usage page gets displayed incorrectly. This appears to =
affect ls-remote, show-ref (it's not documented, but show-ref accepts -h =
as an alias for --heads) and grep.

I fixed this by moving the lone -h check lower down, which fixed =
everything. Except now lots and lots of tests are failing because many =
of them assume you can always pass -h to get the usage page, and now you =
can't for some commands. I don't think this actually breaks grep because =
you need to pass at least one more option other than -h to use it, but =
tests for it are still failing after fixing this bug because it's now =
showing the man page instead of the expected short usage page because =
it's erroring out at a different place.

The specific tests that are failing are t1502-rev-parse-parseopt.sh, =
t0012-help.sh and t0450-txt-doc-vs-help.sh all of which are trying to =
use -h on commands that have repurposed it.

The options I see:

1) Fix -h handling and add ignores and fixes where possible to the =
failing tests and try to not use -h as an option for anything new.

2) Change -h to -H or something, but this breaks backwards compatibility

3) Fix it so that -h works if a command uses it, and additionally make a =
new global option -? or --usage or something that always shows the usage =
page and change tests to use that, while leaving -h sometimes showing =
usage and sometimes executing the option to preserve as much backward =
compatibility as possible.



I'm happy to do the work and submit it, but this is looking more like a =
policy decision than just a bug now.

-- Kevin

