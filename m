Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821DA372
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 04:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723003332; cv=none; b=LA6q65gfalLLPGhpISGpbm6XKcjdNoE1LZ1cb9C+QIfK4Oo2KMXtXKzb9+Z4GUz8X+z8rVcFZliBHgBeY5R4S8ie+uNPBxZtwgAV2b17r85+pATUfaeKn6qs1X1hYNhAuW7Z0j0OMWH8Fs8nQ6bUmiSAbBMKlFZzRvU4NtHqylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723003332; c=relaxed/simple;
	bh=Ho89BMEhxpdZfk7tRrCDIv8ujLrWVhiHS/CYoizSIUU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=hiejuV8BiOhnyPP20RpzVfx4/aZFJk+74UH6BuBuNySylY9p5vIW1KMrEhLWMN8+KI2oHeRaD885fpWW4u5oWcYLnEnDSXOmBxP4Yu5edGbC+JxKcuqjxcrHPYKiEcjnUz65CrluyPctpoiywBMeZd/6cFMjKEAZXf0b7BYfKTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=d4Gsopx9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QWaIFvKQ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="d4Gsopx9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QWaIFvKQ"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8EA9C138FD10;
	Wed,  7 Aug 2024 00:02:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 07 Aug 2024 00:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723003329;
	 x=1723089729; bh=NF50fKFSN4KvihZ/yQ+slT6MaiB+kzF85yLisrbcm3A=; b=
	d4Gsopx9zVHCKYb8lvw6iRu4sqTBMO1fEqG3S1okHd3hGYznSrb4uxbTQUS+RfUQ
	EHrSexiCQ+MTBN/Jk4EDh8/q6NfXSlRejYMwvXHZlkAka/xZZ0CMx6k4hQlfxbP5
	Tcfey2ni2kRlIltWMus6R+rkHK6R+muWD6tfh2V2lCNiUo1oePh1aTIICAktLAot
	9lulfRYD5c8LDyMa0UKHYqapW0wZEctwlENIh2GRpA6ro3wCRWMroDAOCkWQDeoF
	DzfbQcvZ17X3sRFRbGx3qIzp8RBet+crPOFsREvX5BgumON8pAAEilJk/6a4YUoc
	0FlbMTUNUFnhDm3hEb+k0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723003329; x=
	1723089729; bh=NF50fKFSN4KvihZ/yQ+slT6MaiB+kzF85yLisrbcm3A=; b=Q
	WaIFvKQ95xRnPpC6//a2h3s5naKVWpMO0MZrkmTvD49RcOt3qyRaIJ7TB1OSi+Ry
	IlYxr3tEjBl9JoV+mGGgo+mpKg9texw07QAJbBrE96UgXw0lluDp4WWU9+CuaPil
	/Cgkc95kV+EW4KUdL/0nI0c3MJgOH19xLtKuuSn/8eHjdxRVrH7W4pILbAWrYYze
	eRAXuUkGfH1TrOv0acctYj7wkhAay82Nl69l0+IcQ66C1h2tHFR4Wk1MPzscj4Gh
	k8x4VBYG/lFYsOpQLwVybwEKG5nYlvDE3AyuRuu319o1Y6jErbviVyTimjx+chOv
	RmHGgacTzKFa/rBUkD2Vw==
X-ME-Sender: <xms:wfGyZtujPv2rQ98V1NRCLfPqYe_AX8OcGNedrkQ2vYNPmAYG_-_NYQ>
    <xme:wfGyZmeivFqqjbXo_h4nIXYL4hb9WhAlSjQY6RusRsvlMh8DbP04y1n9oAG7KesDn
    0FJpstyr-4eohUCzQ>
X-ME-Received: <xmr:wfGyZgwIjhwikZf911piD74rZq8szl4zX_iLTG9mr2RUGMt-c-5kuO3d3NKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgrmhgv
    shcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrthhtvg
    hrnhephfetueehudeltedtjeekudelueeihfevheeugfehhedvieektedtvdevgeeileet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmh
    gvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:wfGyZkOhp9uPWdNVbnDYXXLus1Edr5TpPHpoHHNa4AgIR5bSbLw6rQ>
    <xmx:wfGyZt-fSSEqbqAVpHpcT3KED7TPUuOadhfFv7U9mAu1U_fahPeYNA>
    <xmx:wfGyZkUIdpbUJf4zsbMM6wM1lHW24ZQtoJMS9faBSXuBG-Wn9XaLRw>
    <xmx:wfGyZucU6QORKR0eyrzZxi17joPIW6WIX4NJREFfCwSpoX9sOGth-w>
    <xmx:wfGyZvIpz13Upih0RE6yRFYDC5yNgi_rJm7h2MOohFoCIWEtoxJoNJkm>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 00:02:08 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Aug 2024 14:02:06 +1000
Message-Id: <D39DPCW06C28.2EYBPWPBSQ5G6@jamesliu.io>
Subject: Re: [PATCH 02/22] git: fix leaking system paths
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1722933642.git.ps@pks.im>
 <D39DO1E1ESC8.1CBYB3MBFD60V@pks.im>
In-Reply-To: <9574995a246d96b90f03827bf0ba591593d6c4d9.1722933642.git.ps@pks.im>

On Tue Aug 6, 2024 at 6:59 PM AEST, Patrick Steinhardt wrote:
> Git has some flags to make it output system paths as they have been
> compiled into Git. This is done by calling `system_path()`, which
> returns an allocated string. This string isn't ever free'd though,
> creating a memory leak.
>
> Plug those leaks. While they are surfaced by t0211, there are more
> memory leaks looming exposed by that test suite and it thus does not yet
> pass with the memory leak checker enabled.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  git.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/git.c b/git.c
> index e35af9b0e5..5eab88b472 100644
> --- a/git.c
> +++ b/git.c
> @@ -173,15 +173,21 @@ static int handle_options(const char ***argv, int *=
argc, int *envchanged)
>  				exit(0);
>  			}
>  		} else if (!strcmp(cmd, "--html-path")) {
> -			puts(system_path(GIT_HTML_PATH));
> +			char *path =3D system_path(GIT_HTML_PATH);
> +			puts(path);
> +			free(path);
>  			trace2_cmd_name("_query_");
>  			exit(0);
>  		} else if (!strcmp(cmd, "--man-path")) {
> -			puts(system_path(GIT_MAN_PATH));
> +			char *path =3D system_path(GIT_MAN_PATH);
> +			puts(path);
> +			free(path);
>  			trace2_cmd_name("_query_");
>  			exit(0);
>  		} else if (!strcmp(cmd, "--info-path")) {
> -			puts(system_path(GIT_INFO_PATH));
> +			char *path =3D system_path(GIT_INFO_PATH);
> +			puts(path);
> +			free(path);
>  			trace2_cmd_name("_query_");
>  			exit(0);
>  		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {

Oh interesting. These don't immediately stand out as leaky due to the
absence of intermediate variables, but nevertheless an allocation took
place that we need to free.

