Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929161C860F
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495437; cv=none; b=T47Hgks1LD8hF+YR2Vtl/WmYrCyvUMnGwcR8D2vlAbl9QvPBi5laN7vQJgkDDKxxk4feWQVjAnlsCHkai2No1ypY7IpEwmkfA/v6CR88crONZsDYw8rxcTNtDkdvBdw64xrPlla0AMf7nou3R8OVZPs64974rmCP4IUG50t9ESU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495437; c=relaxed/simple;
	bh=J3fHGN+17bK7NY8nXzAV2c6EK5xIhzx6PBvayPABZ7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LvvPSyOP0gLJ25ujMtMiodCXTGb9vLU7DsznRIZmwcVc3qziS0EvXlTl0YSvrxCc3VSJ7VvdIaAmmlwxndC985JDzrHeH/sNOjquj66qG5YmclIvF0uyLXJ/oCITwyBqW1WGhsGaam6Cpq+YjZqMOhNjB2u0esq1yMiq5ZKBIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UNjSOOQQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FQQ3prcR; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UNjSOOQQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FQQ3prcR"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6411D11401D5;
	Mon,  9 Jun 2025 14:57:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 09 Jun 2025 14:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749495434; x=1749581834; bh=Erxb0yk1Fc
	RssoZ+MAVI5SwAKu1awskH9lmuvngOWoY=; b=UNjSOOQQ+rWsXioOTmvEo0OL8E
	nTip51U/nrJKsfh0yx6vuyA0bsjuBIkXwgn6jmhH3BI9ahhCjDAIIo+8FSCe0Qkg
	tjog1k1IJY7syX8LqBsV/kTWkgFw/HEF7FkahuSqwis3ATqgOpc7wYLISoPTojCj
	01eZ+/yOY1Ls9xADpzGhtpC0tZGx673MOBQ8xkFDo7gZuq/O6jkXpLmDgnxCh1ji
	ONNAWJAbVImIvFKhy5/CaExT8Tz9wTXN0pRuCwXLTN0Y6GiZKa7zde7Q9yv4vniE
	zI1ErLtHgTmCDZhDFJYNl/zkUZTe3aRsSDRcb9vuRFMNusjwwbijakA7qmyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749495434; x=1749581834; bh=Erxb0yk1FcRssoZ+MAVI5SwAKu1awskH9lm
	uvngOWoY=; b=FQQ3prcR9vaZEUjS3sB68rRT6iRqVWcNX2xNooYjoMa2VuLq2Ud
	GlSBF3UtBCn0PiqI86jwDdSGviKnKGlS/lI34Mu0oa31jeyA6DvWkyM/AOzJATKw
	DQJLA/TzXA1AjIsUUcbpmTz/IVCPLGLtK1f3CSXTP7O0Oa4DGDwCUgHn0FNRtY2T
	9LtsjHuQbEYoBv9UAKzeXmwDk0me/Km9VVk61dwqZrPOaH9TPMQ1rEudvfe0MVVI
	IbmR6Ybylid1os9OGKHJiYNgJn1zECxuGJyrmmjgThudMUhKRzRsCd4LcjFEzAnL
	gjARwWjcd8UZSA0fjkM62gJ3/ydeun7v7qA==
X-ME-Sender: <xms:iS5HaGIvSrWLw6R9IJro0jVV_QNh1v9UB_RNLm-rOgx1GN4VOPrqcA>
    <xme:iS5HaOJUdsl52Sd9--mrNS4Pw7yjJ_Zw7nMRJuEcg-iEUTBscN0m6vZePMU5RVkze
    mpPZR2btI1haS3Qvg>
X-ME-Received: <xmr:iS5HaGuIXUsiE9DCFSsTN1urcIkoxjrW_TgvH2y-tuGa-WSf8GbxGytuUvXZruvdy5lGrnuunKPNg2AVz_sdFJNcN6oFhVFU9PYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iS5HaLaj6vAanuMuEIugRC1YTgDAa6Abkx6toYsTJ4GjVXbJDdjQyw>
    <xmx:iS5HaNb8CF_rA4iLgbFYKeiczoxmdglL00GreSo0jeV5gDWqkf46ow>
    <xmx:iS5HaHCHKrQN4baGTVk78eIPDEWWsXxWKBs37mJRGppPTwLICdV_TQ>
    <xmx:iS5HaDbcp1kNn7R0KpCxUXAgC-0qxWV5YfAzHjOOOSisOe5Sspk7fA>
    <xmx:ii5HaLl6BsgJ7Pg8GfZSZ3NBJRtkLPb-Ewu99EcCcGdF6PDEmrICbqFJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 14:57:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Zi Yao
 <ziyao@disroot.org>,  "brian m . carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v16 09/10] imap-send: display the destination mailbox
 when sending a message
In-Reply-To: <PN3PR01MB9597647A1FE9451BF9EB1C6DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 9 Jun 2025 07:20:40 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597647A1FE9451BF9EB1C6DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 09 Jun 2025 11:57:12 -0700
Message-ID: <xmqq4iworbef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Whenever we sent a message using the `imap-send` command, it would
> display a log showing the number of messages which are to be sent.
> For example:
>
>     sending 1 message
>      100% (1/1) done
>
> This had been made more informative by adding the name of the destination
> folder as well:
>
>     Sending 1 message to Drafts folder...
>      100% (1/1) done
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  imap-send.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Hmph, I have to wonder how much value this adds.  It is not like we
extended imap-send to allow it to stuff messages to multiple imap
folders during the same session (in which case, "sending ... to A"
followed by "sending ... to B" may give a good feel of progress).

But that is minor, not an objection strong enough to shoot down a
piece of code that has already been written.  Capitalizing "Sending"
certainly is a vast cosmetic improvement ;-).

> diff --git a/imap-send.c b/imap-send.c
> index 9807012169..3d6bcd7e88 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1563,7 +1563,8 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
>  	}
>  	ctx->name = server->folder;
>  
> -	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
> +	fprintf(stderr, "Sending %d message%s to %s folder...\n",
> +		total, (total != 1) ? "s" : "", server->folder);

Totally outside the topic, but as #leftoverbits we may want to i18n/l10n
the messages from this program after the dust settles from this series.
