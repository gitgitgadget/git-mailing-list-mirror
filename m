Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DC225DD0A
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822269; cv=none; b=PL5wJeddLAzION+Xo98ntAIS35KvUOHdv8HTdPUSGxXGk3Rn/mIE/mlKOkGcmkNRuuN+SNFoSBhf1otFzgT86Ck07c216bCXbDUwDXiKE6MLcySfk8Ude+SfVnQkXMD7vjjxCBUPDguHuXS8wus/n4ikMBr3BGcXq2wabEg1ZC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822269; c=relaxed/simple;
	bh=jYS5pAGwS0GiVSJcW9AW1WvLrOg+mQeRdczGcywnagU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssjISu/q3XhmdtS9E7fFAzaonucM6fbJ/s7W/DTVFlFFLcc7iiQcXF+zmWXcJhCmPqcOM84VOCYj+6Y+lkNwe192SxT5g3ssBxkb14FT+sCMO9Pkr+HbWwGU1ISnlWmV3q23ubw3xPQIkCJIzRPBO2zsUuSj2NqfMtnrmfOZVz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nxbzSkWs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oLrqGAzW; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nxbzSkWs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oLrqGAzW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F82325400FF;
	Mon, 24 Mar 2025 09:17:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 24 Mar 2025 09:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742822265;
	 x=1742908665; bh=jYS5pAGwS0GiVSJcW9AW1WvLrOg+mQeRdczGcywnagU=; b=
	nxbzSkWspJt0paxknGAByV0a6w30ydH0rMJ+vzwelW/gYdjCbAZ87DY7yPg6gg+P
	LJ1A9JULHE7qj57OGpwRwx68hMPF0kGFbdM5JljJPGCMVTDP3re8AxoKWnw8BrTI
	sWM6JrYZyakuq1r4pZz3C8/KCFjotgWM+38pKDEnlZZpJZ7jLOpX8M/uevjzAiBc
	8EFdshVkZ+Gy4IG9leOUzfTZrwOl+qFC7Df6eyJonFHPAw7fnhyTZ1wczEuQdL0s
	XLr9UQeMczWxPcT6YYV2f0T/Bnjv+t0sMxGklCMKfxYJjrroeyDR1SVcjuWVrlbv
	EfS8ap3cWIowH2UZczFkaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742822265; x=
	1742908665; bh=jYS5pAGwS0GiVSJcW9AW1WvLrOg+mQeRdczGcywnagU=; b=o
	LrqGAzWAT8CAg54WD/nvT8vNmmeCZxyEuiXUFZcJOWtIo3qyD4PD/uXHPbwGMdsQ
	/Zx9OXhbraXLVBPDe4jKkB4u5jfRIMpsxauq7hPBP+YJKdGubSHDW9OSHxCGxmH8
	IXxrKJcNhA0xoATyjrWKzR/Njp9poX0y4kGttt7zTf7ZGRzUXVed96zlutTRiBVH
	gMdIU0GQh6R6oSEjzrPll8EjeH8GnZIXHWaJMsTvKwruR97yAHf49W38iEjc8Jvj
	gLxRUna0CjYdCOM6By0xMg+CK48UZcMwjDpxhu0sUIaUEYDzWn9NBIxDbwsfn57h
	uNk3ocXERe8hWUO77/xnw==
X-ME-Sender: <xms:eVvhZ0tJO4qEMPElJxqOd6P6JP4UEDPn9WES4PZZUZvLDGjzMxPRsw>
    <xme:eVvhZxezMQIWi_paHTGg4mL-B7Akxn6Tb-_U1irQNVDw5IdbLplTi7k7ifLfWvzqL
    YZAyP4E4VkmEH9wiA>
X-ME-Received: <xmr:eVvhZ_xCpJifEXMgNwyg7YzhSrurw0d5Lr1tIuZicPvp0USHkfjEmn0pF_OCSPF4UKgINuI00hV_Skdgmk5MFdGB98rhCXjAhwIHYfwP8Ct2eX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgoufhushhpvggtth
    ffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedukeeuvefgkeduffetvdehgefgvdehuefgtdel
    ueekueffteejteffhedtgffggeenucffohhmrghinhepghhithhhuhgsrdhiohenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhitdefjedukeeh
    leesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:eVvhZ3NZUh8biD4-TrzNZTxlQTFQgJ99lS0KQV3Oakckq-AJfejIEw>
    <xmx:eVvhZ08stb6xodfvGdcEveCa1N-WyMrODCHflZ8awLFRES5O5wfmeg>
    <xmx:eVvhZ_VzrdTX6Mvb9oXV-s8GgDmfj6FN98ttlQTdVYSKz3WeWcJyeQ>
    <xmx:eVvhZ9cOgjJyB8HL8dD70RznzHzMZQ_0eVrRsFVN6-QenG8RYPxisQ>
    <xmx:eVvhZ2LUFVHPyG4aWPUntdx5VpnmYZC5zhM_FxbO7lnHUWayM-O6Vp0b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 09:17:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 80578791 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 13:17:43 +0000 (UTC)
Date: Mon, 24 Mar 2025 14:17:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: li li <li0371859@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [GSoC][Patch]  Add more builtin patterns for userdiff: Add
 builtin patterns for Verilog
Message-ID: <Z-FbdgY6ZU2mQGY2@pks.im>
References: <SEZPR01MB5486F5B360F1DFA607C69F37A3D32@SEZPR01MB5486.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEZPR01MB5486F5B360F1DFA607C69F37A3D32@SEZPR01MB5486.apcprd01.prod.exchangelabs.com>

Hi Li,

On Thu, Mar 13, 2025 at 02:23:05PM +0000, li li wrote:
> Add Verilog built-in to userdiff.c. I read the code and checked the previous mailing list. I found that if I want git to recognize Verilog syntax, I need to add Verilog regular expressions to the userdiff_driver array of userdiff.c and modify the .gitattributes file.
> Yes, I did it.
> The next step is to write test cases and submit patches.
> I am not sure if this is in line with the development process specifications. Maybe I should make some adjustments. If so, please let me know.

I would recommend to read up on how to submit patches in
"Documentation/SubmittingPatches". There's also
"Documentation/MyFirstContribution.adoc" to give more background on how
things work in our community.

> diff --git a/.gitattributes b/.gitattributes
> index 43fa883a84..8aac8574f1 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -6,6 +6,7 @@
>  *.pm text eol=lf diff=perl
>  *.py text eol=lf diff=python
>  *.bat text eol=crlf
> +*.v text eof=lf diff=verilog

The gitattributes file is specific to files stored in this particular
project, and we don't have any Verilog files in our tree. So this change
should be dropped.

>  CODE_OF_CONDUCT.md -whitespace
>  /Documentation/**/*.adoc text eol=lf
>  /command-list.txt text eol=lf
> diff --git a/userdiff.c b/userdiff.c
> index 340c4eb4f7..9f7e4c427d 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -336,6 +336,13 @@ PATTERNS("scheme",
>          "|([^][)(}{[ \t])+"),
>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
>          "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
> +PATTERNS("verilog",
> +             "^[ \t]*((module|task|function)[ \t].*)$",
> +             /* -- */
> +             "[a-zA-Z_][a-zA-Z0-9_]*"  
> +             "|[0-9]+'[bdh][0-9a-fA-F_]+"  
> +             "|<=|>=|==|!=|\\|\\||&&|<<|>>"
> +    ),
>  { .name = "default", .binary = -1 },
>  };
>  #undef PATTERNS

I cannot say much about this hunk as I've never written or even read any
Verilog :)

Patrick

[1]: https://gitgitgadget.github.io/
