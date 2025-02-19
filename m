Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D01BC9F4
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739946239; cv=none; b=rvxyKYgai/rqfbb5sx7JAFq7EWvFLijxkPt7SIos2TYNdYsTQAEB8rmxctruxVXoWK9stuLZShRJo8rr1uVBwrymeD62vnua/lcfUlRO68n01ZDa9Qwgil4t70LZzBuHf5hLsCJjcQfTsNMR1tRl4i+PADuwBIY9ejhLIGhicdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739946239; c=relaxed/simple;
	bh=8/lCPoZT04BTWK0dl5qnhbX+3OCFlISWgpy46eyNEbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPrRSSXBFOs3GJpw45fg7h6CBgbc/nbzyxXTI8Ppts38R6T+6kIm7oE25m4nYgVr4L3StVBTUc8eR/l0COo4PbK39zzFhbVqQsykr3oF5j9QWdEvmNkzm97L00kwZUw/bgrqRyQ/R4ZMUTphHIZrVABwcYYQH+r+zSapg5zI5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E+wpvb/m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BSe4kV/O; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E+wpvb/m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BSe4kV/O"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B6CD11400AD;
	Wed, 19 Feb 2025 01:23:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 19 Feb 2025 01:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739946236; x=1740032636; bh=5A1EJTLURU
	N6JbKIZezEf4WwoumXtFIAok4/q/QV4Qg=; b=E+wpvb/mgrWR3lRwRkNfaICbix
	XfLUyzsJKWrTOPExixiR2HDYIrK9K9AgSDdca8ZoVdkuxilckwfhAreVEoctLSNM
	aJE53X2OIbloBgjqB75PDYl6cHyKVrc35ig5CZWI+l5S3lqXrNlSe3ePULzoMIuN
	e0AzfSrt7rWsx1cWwIdzCKAYyPF4XgF8kJz3GzyT+dCIDUOvWNkIAKhmvhZugdZ0
	Rx9rzZSVa7nqW63MnQXwl8LOPzGAa53yFmxkMMpIh1256uKFa8BE9yrl7y38rzcN
	3oOav483fQ2DSjj6zOi7hMaaYML7wuJ7BQcupa8ljp/r4/qvX1HEXqiM3LkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739946236; x=1740032636; bh=5A1EJTLURUN6JbKIZezEf4WwoumXtFIAok4
	/q/QV4Qg=; b=BSe4kV/OG1ras7RPMYJswxatuUAUoe+ws5rivlrbv+eKHPNjuwR
	YB9PSRMMyvqM4EPEKH0XpV4uu90+fBviUfBqrasHbBkLn1QiRtETWyBOJOxAdyMV
	ssytZurFBJ7yAPsH/2vclIkB5VJvHg3ewf8EbGrrHERcZb+G7h/j9nYuZvj3dUEm
	DbTMQA5TH9nsEkEEg0/1bmVcKohpyXiiCKzmQauPks/s3RRCp+1DvsxXePxOG8PR
	LZ6K+syOa+yKwSgHAVgQTadkQKqCB+9uVccI8QyO7ru+BJx7OU+ExmVHT0EClNib
	kyYRNcFIMV+E9iuBs3YuIIp7m3ObtR8h/aQ==
X-ME-Sender: <xms:-3i1Zy3VnwSlDY733b78YejUwXjkKGbVtNdYyJFSvzEGaQyR45NYYQ>
    <xme:-3i1Z1FOBmUKfr9-0PSAn1EAEMpDAcmVZWmmROEMi6aih-FGWSNkPW0lRcWn7WZ-0
    u28jnHH_0KN96HRGQ>
X-ME-Received: <xmr:-3i1Z652GBZatI67rO_hAZNw0SIeFPNCzt1AyNqb61OjaVTzhk_JbIRvN9NGWFQZ1DEiVN6jBtREAbl3tpPlQRFaRI7H5F_Uo-cUOeR8vRbipgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:-3i1Zz1IVvQyoPXtd4LSer7-akbEgKbhf6KmeiY_EA-GbhSG5n5hww>
    <xmx:-3i1Z1FUI0gwgeymRLs5NBcGXrtHqSQsRBEV7GRY1db9CaYaPucfmQ>
    <xmx:-3i1Z89IXu465dV0P8NaA5Ts989yLcIqqvviNIOpotj5LkDYcP0JZg>
    <xmx:-3i1Z6mLAEf1OWqLms4GyBYtqRQbqqYsGQHVgYSFipvOcOgrG0uppA>
    <xmx:_Hi1Z-PUJP4XDBn6iqXyvWqA08FtQ-POCUa1sAD8l2M8yuysJws8tc1u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 01:23:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dac580db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 06:23:52 +0000 (UTC)
Date: Wed, 19 Feb 2025 07:23:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/5] merge-tree --stdin: flush stdout to avoid deadlock
Message-ID: <Z7V48_q3Uu9d0D3Q@pks.im>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
 <pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
 <3b3179785098580f3336bb24bdbaf0aa1366bfcd.1739895879.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b3179785098580f3336bb24bdbaf0aa1366bfcd.1739895879.git.gitgitgadget@gmail.com>

On Tue, Feb 18, 2025 at 04:24:35PM +0000, Phillip Wood via GitGitGadget wrote:
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 9a6c8b4e4cf..57f4340faba 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -18,6 +18,7 @@
>  #include "tree.h"
>  #include "config.h"
>  #include "strvec.h"
> +#include "write-or-die.h"
>  
>  static int line_termination = '\n';
>  
> @@ -623,6 +624,7 @@ int cmd_merge_tree(int argc,
>  			} else {
>  				die(_("malformed input line: '%s'."), buf.buf);
>  			}
> +			maybe_flush_or_die(stdout, "stdout");
>  
>  			if (result < 0)
>  				die(_("merging cannot continue; got unclean result of %d"), result);

I was briefly wondering whether we should rather move this into
`real_merge()` itself, which is responsible for writing to stdout. But
the only other callsite doesn't really care as it will exit immediately
anyway. So this is probably fine.

Overall the series looks good to me, thanks!

Patrick
