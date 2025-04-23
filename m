Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E422212B04
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745409206; cv=none; b=QBYLZoWymN/4uk1fPE47IQyG1ZQSjoEXcCmVzeWf+LLorIjiqH4mXOhhRFGSj4syovvYiGb7Cv1gp+GXmt31AVhD1MyFbno+esBwD7n3yCFi5NZab66HnNHECzTe0dCmtmKbqLodBDk+bkIAp04lpUtWK5PYsOPG3xhP+MzEbMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745409206; c=relaxed/simple;
	bh=umcSsde7lMOsV88AHw/pm+1E0/etWz48a1O4LCwehlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKnxE1ePf68Mql7oQVDPe7SyEWH7WloRXLGmHr8ZG9Wd9aILu+RNIgO4baLE1o/Ox0MAh/JOgjjpDBwfo9vBCOwQOPVVDBf/Qmp8FIX5iDt1x8qRQ1KXcXl8NcJqJ3/f1zrk9wSg3+Kus2NzeWuhV3harV0qsg2iJ3X11UKvwlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ErFPZxPa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=idTjWVbz; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ErFPZxPa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="idTjWVbz"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60A8011402AE;
	Wed, 23 Apr 2025 07:53:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 23 Apr 2025 07:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745409202; x=1745495602; bh=9e4Gokht3S
	svKGPlD1YJLW+MAS5/ua14tE4dytqDd6I=; b=ErFPZxPaEjlJtqShb46C1COkv+
	R3BrJ7n4KxNfun9ln7rDRRgndJFHaGMgNJeTVSG4dUlmqcxo633aU0zicqJsLcmM
	50/a99FlBT9mb2R6PT93PPAXz2kg85GT97hm4bEsoHi4aL08DDBl2E/SYiTj2p0M
	Avw4zWrk0F7zQ+xumjsYOKpmPyr0AjaUlGyETA3HXuMd2LlExwSkF/u0nA/b342r
	PyGUIy9EA/EneqMNPRBSfixtJP6Nn4ot0J0ps6q0pjKstdL/uHljrIfa/IgGKLWR
	qO4SRGXmg05OKvLAzbAVCP6G2Mb63+jV2Op25+wmSZNG7mPG+KqwT+gB8Ztg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745409202; x=1745495602; bh=9e4Gokht3SsvKGPlD1YJLW+MAS5/ua14tE4
	dytqDd6I=; b=idTjWVbzO4q3xnNdp8W1s3jObdmFCDan1Ve45hNeRYDUmeEofza
	w/A7QQT1mSP0AiHbaonrGWeyQPjvnFzXOgbdW0gsgU9Ti8KOhBKbcNempDHeTf3V
	rwY2wdCweOBOqJ6jrpoQ708g+3snLoNoshfddVweKsLc22YYy5wlrhmo3caKAzCC
	qI50FciRVvVK5zwbaukzyzk0HMX8NAvDo4eb2Wt3oG84Hev4j3lEHhJwzF9C8d3Z
	uSvPGZg6EEu4147AHqth/feaJ8QggC9goYfbomiGGOQDgkn7JXPuCevO4Myj2ujm
	/5n6NPoRZeuRppH7oUYXbBfFxkkkeZ/Bo+A==
X-ME-Sender: <xms:stQIaFHoDk3NDZDXkDHAoXHDXfZOp9jUqNacCAfhwCQ2LE5_d_hEpQ>
    <xme:stQIaKXMs-R_1SQ1N2qrQ_BXjp-JrXGPstY6vdgdb6f9ieE5PGJjX0Wsw15Qp4QbL
    oxZZ1LqQunEp8Jttw>
X-ME-Received: <xmr:stQIaHK45p_oCoqA3eD0etGC2URMry5nncMFrBnTWE2EuqEA3DZ37n2eqM6R0k0m4WMOgvSKfEktu1yMl2JEFGBZkpRXOeJDiIjyrM_bJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeiheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgv
    jhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:stQIaLFg7og1THHl6Hstfvf6c-clIFkdJAx8K3UKwv0TH0FIc7m7Xg>
    <xmx:stQIaLX1zVUKYYSGIEXXZMdNh3bWV81IO5Zqooz3RAsbLUgvT6wVTw>
    <xmx:stQIaGPYNI20Vt6Tfu_Or2Eya5lj1rDlkgImRNH5vPdR5xPoTC9HAQ>
    <xmx:stQIaK2lymGsref7A_1WPfHb-rGQZjqIAO_QeqD5eL8J44J1s_m0BA>
    <xmx:stQIaCwbAyi49VTKCElmyAMTTl0SKiCIw3EqA9l8SIRac_ayJeAUB906>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 07:53:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a469480 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Apr 2025 11:53:20 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:53:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] u-string-list: move "remove duplicates" test to
 "u-string-list.c"
Message-ID: <aAjUr5AY9gTCpVlS@pks.im>
References: <aAetW0dan8S3Fljq@ArchLinux>
 <aAet23peGs2OZUcn@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAet23peGs2OZUcn@ArchLinux>

On Tue, Apr 22, 2025 at 10:55:23PM +0800, shejialuo wrote:
> diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
> index 262b28c599..6be0cdb8e2 100644
> --- a/t/helper/test-string-list.c
> +++ b/t/helper/test-string-list.c
> @@ -1,48 +1,9 @@
> -#define DISABLE_SIGN_COMPARE_WARNINGS
> -
>  #include "test-tool.h"
>  #include "strbuf.h"
>  #include "string-list.h"
>  
> -/*
> - * Parse an argument into a string list.  arg should either be a
> - * ':'-separated list of strings, or "-" to indicate an empty string
> - * list (as opposed to "", which indicates a string list containing a
> - * single empty string).  list->strdup_strings must be set.
> - */
> -static void parse_string_list(struct string_list *list, const char *arg)
> -{
> -	if (!strcmp(arg, "-"))
> -		return;
> -
> -	(void)string_list_split(list, arg, ':', -1);
> -}
> -
> -static void write_list_compact(const struct string_list *list)
> -{
> -	int i;
> -	if (!list->nr)
> -		printf("-\n");
> -	else {
> -		printf("%s", list->items[0].string);
> -		for (i = 1; i < list->nr; i++)
> -			printf(":%s", list->items[i].string);
> -		printf("\n");
> -	}
> -}
> -
>  int cmd__string_list(int argc, const char **argv)
>  {
> -	if (argc == 3 && !strcmp(argv[1], "remove_duplicates")) {
> -		struct string_list list = STRING_LIST_INIT_DUP;
> -
> -		parse_string_list(&list, argv[2]);
> -		string_list_remove_duplicates(&list, 0);
> -		write_list_compact(&list);
> -		string_list_clear(&list, 0);
> -		return 0;
> -	}
> -
>  	if (argc == 2 && !strcmp(argv[1], "sort")) {
>  		struct string_list list = STRING_LIST_INIT_NODUP;
>  		struct strbuf sb = STRBUF_INIT;

I'm a bit surprised that the patch series stops after this patch given
that the only remaining subcommand is "sort". Is there a specific reason
why you don't also convert that function? If you did we could declare
victory by deleting the whole "test-helper string-list" subcommand.

It seems that the only reason is p0071, where we benchmark performance
of sorting. I dunno... that one is of course not a good fit for our unit
testing framework. But it's a bit sad that we cannot remove the whole
infra only because of a performance test that nobody ever runs in the
first place.

Patrick
