Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A025E834
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821702; cv=none; b=LlGV55K04GAlj7cNNVTfqHWrDhUpxOyU2Zl2nQCi7xSpsdM+B8dK+GaEHVP4X0AHp+W3yCj8VO/dXwLDEFCoYeNsxyoMu7IZrmEohlMAC27BipCNgrBQC3a713Z1iQvJLN+06nY0+/idzgxIO+dJ5lFK6/3h6nSbg6dORUVjSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821702; c=relaxed/simple;
	bh=dGMWL9pJ4dW/7woyWvLE7/xYoWbErj/09oqWAijJ72o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8gJf7tuCUNqRj+P0tQxRfhgSUdR8ih65vag7jVvz48cu4qisVacZAvdNm7JSb3LzowPCJVMNEymNly9u2cHV+AqytvC0ei73LnxYxkPqth2TyB8fQuXOkVC+2vnDLgPB0uvZfafSSsE8/k136YjlXRqTQot1Dc/uxjxtcflaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PBH6nM4T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJe81Yz+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PBH6nM4T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJe81Yz+"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7377D25401A3;
	Mon, 24 Mar 2025 09:08:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 24 Mar 2025 09:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742821699;
	 x=1742908099; bh=DuRL5+vzJmjJu86hYa+yBkH0qawR7rva1ZvExlWVYUA=; b=
	PBH6nM4TKLiGh/Elq5FIIrzpPVDnKo5dsUENqrq81nadB56ZpKalYD5tLALn6AQS
	K2HuEjN4RNWmJNLIQub/dWtPRsQZ6wT3vZ4BDS8FPy0ovVO0FtZm5dtjkZ2jz8px
	J9/Q9oRa6p0Jp9EAhYTVisTBm9WVWJ9bk1Xb151ZY13AlkotRck0OCQ5PSDiN29K
	7p+LtLiubZjwUITGdZNbiDSfYzUjfCyTbt0DQBv/49bPIGpJkjfRlwbmUZFizSO7
	tsksexsIjQkTrSn+i/Difu9Mi3zXBisl5FkkCeVSNyOh7dXDztk8VIIycG5UsMuX
	Vk4eBvpmPO1uEo1C90vdGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742821699; x=
	1742908099; bh=DuRL5+vzJmjJu86hYa+yBkH0qawR7rva1ZvExlWVYUA=; b=b
	Je81Yz+LQ2MWqFa6RjYuif3tSCy5L8/YdXX0GLA9mFxQu6yxuGPyDuHY5RQGEnBm
	FVBupgBx1I7IyPPmxYO4UAS0bmupfg80eWhsNhG01wij1AlpkTO49S1TmEpRwJtO
	iBJtiMgAzMPmWO66tqZqe7sYH9ENUYoaqNlgn+QLocDjwJhGh5xq9vPC4iS5qMZm
	BkRink2R50P2XJvX402wjNPmlGHhQfVZo3IX87gtP4VTYeaQI+Kzv3OWvhyPGK+f
	YcN9vQ1GwAyrzmK1cxnn1cHG0CMtLolLt2meZfu+aaCqLfmoiuUYRgqqXBMOOmAl
	rucs96FgB5qFHEBL2ylKQ==
X-ME-Sender: <xms:Q1nhZ7qFGxyv0wDGWMamKBk26hRLGAoF-xjCLzZ3s_a9Y1Xten0SEQ>
    <xme:Q1nhZ1ooS43BiglS5jIXULCXfKC-AIWodr-n1ea4Ft5pqIQYrGNbPmSiyVzSrEDbL
    0J48wLPoNB2WxOzPw>
X-ME-Received: <xmr:Q1nhZ4NimeUfneH-5jBWpcGalOfvj-uNteekvofsxx7mkfWLf8r3cs93KsVz6W_MwLBPBLh0LwvSQbCrz2_xBShUzvjP7qfyXjkUxQOu6rESsiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Q1nhZ-4PeEBZixndFUG3x9VDSgxbpyqCMh3YsFISK3wp4OtzpdPY-A>
    <xmx:Q1nhZ65gGqH8LUTfqRufJj635mLk9sOJtl1PTjLNXOrh660v9IlkhQ>
    <xmx:Q1nhZ2gaZtBBYPhIg5ud3jTJW4IbcmCdMsjG7VowxIdMu1gqx7qYng>
    <xmx:Q1nhZ84_sHGk985Qa2A9vHRT_BvZ1x2b8ig6w9UPLj1d7fJory15rw>
    <xmx:Q1nhZ126EJ9PMOJlLlhRVn24zmGrCQpX9o5SdWRr405XLksKK8cSWar4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 09:08:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9252f231 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 13:08:17 +0000 (UTC)
Date: Mon, 24 Mar 2025 14:08:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 8/8] update-ref: add --batch-updates flag for stdin
 mode
Message-ID: <Z-FZQOYGPIuB2h-t@pks.im>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
 <20250320-245-partially-atomic-ref-updates-v4-8-3dcc1b311dc9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250320-245-partially-atomic-ref-updates-v4-8-3dcc1b311dc9@gmail.com>

On Thu, Mar 20, 2025 at 12:44:03PM +0100, Karthik Nayak wrote:
> diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
> index 9e6935d38d..5be2c16776 100644
> --- a/Documentation/git-update-ref.adoc
> +++ b/Documentation/git-update-ref.adoc
> @@ -57,6 +59,14 @@ performs all modifications together.  Specify commands of the form:
>  With `--create-reflog`, update-ref will create a reflog for each ref
>  even if one would not ordinarily be created.
>  
> +With `--batch-updates`, update-ref executes the updates in a batch but allows
> +individual updates to fail due to invalid or incorrect user input, applying only
> +the successful updates. However, system-related errors—such as I/O failures or
> +memory issues—will result in a full failure of all batched updates. Any failed
> +updates will be reported in the following format:
> +
> +	rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF
> +

Does this support NUL-terminated mode? It probably should, and if it
does we should also document the format.

> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 1d541e13ad..97e14b279e 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -735,6 +787,8 @@ int cmd_update_ref(int argc,
>  		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
>  		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
>  		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog")),
> +		OPT_BIT('0', "batch-updates", &flags, N_("batch reference updates"),
> +			REF_TRANSACTION_ALLOW_FAILURE),
>  		OPT_END(),
>  	};
>  
> @@ -756,9 +810,10 @@ int cmd_update_ref(int argc,
>  			usage_with_options(git_update_ref_usage, options);
>  		if (end_null)
>  			line_termination = '\0';
> -		update_refs_stdin();
> +		update_refs_stdin(flags);
>  		return 0;
> -	}
> +	} else if (flags & REF_TRANSACTION_ALLOW_FAILURE)
> +		die("--batch-updates can only be used with --stdin");

Nit: formatting, the `else if` branch should have curly braces.

Patrick
