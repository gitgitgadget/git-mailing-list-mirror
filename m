Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA713C8F0
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805532; cv=none; b=EIi4lL9o4zSSwrLd8IiZhmBxtcg9h050XL45lCVP/5tGmOpLhScJTN8UlmWh1znNkxqsiTaY4Kgnkut5CHI01FtABN0OuUJ6BPM4U5OfQN/EEx/WpXfzfEIcTnxocDCAkutmxNOmKF20X2fHR+kQvlac7JNNTmi4PdABZ0hWq5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805532; c=relaxed/simple;
	bh=dq9O04ndsR0+5eReh4Wv4ryKUK+WFnrbyKIENbzI+hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdIBTnIWD7gueqG44+xiHiyn+Zh1od8TULB0S7wGveQWrbkrCoIOWKGGjSqrC1DABZ8Dbit0UywAyJiKqxGnC/yicVzmqLDMPNEC7WdkCi4KvfgvxIL5/03G9GZfS7WFagb5vsvOxKmhwvSeM+TYnZudCaH5RIKHiBJt+5K8t88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IzPILp72; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ij44tPFT; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IzPILp72";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ij44tPFT"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1E63F138FE6D;
	Fri, 16 Aug 2024 06:52:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 16 Aug 2024 06:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723805529;
	 x=1723891929; bh=iGrGAlI/Y4bR88l/aqUMsGFwWosLBpz7PezY/LBDuHI=; b=
	IzPILp72NyJfcSwYx2w1ISnTcR4J6gNehseKyAIULT3R+gwJfQ1TuOKyWMFN5Pmp
	CCT7joQkP2+vxQl0gK8lsiJNYXtaO2yejc60OG7xnijY/lJcm+QvLdvwzK7/ZNVs
	IrAGO8uLAik2g0ySs3zNG3siqw9EtY+W0GD+KG6UyTsTqeWJD0AfnXL1GPs5AmZW
	PAiHH6YKznoQcBA+QX4MdOujBLA5iHlb12vmmBksdyZ7Ns9CR2hpelC5JHNWG8az
	WU8xwYmrP4FawEotjrYPcqAbijQWMIBy1wiQf/9wN/0bs9kwGYpqlL9d5x76eTRG
	KRAlThtyHrobUZSogqd0dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723805529; x=
	1723891929; bh=iGrGAlI/Y4bR88l/aqUMsGFwWosLBpz7PezY/LBDuHI=; b=i
	j44tPFTSAsPbDUINYkX5s3rTVXx0T4hnLgkBspcdTjDgS4HJLKBm5D3wAmFVzLIm
	hNwktByif+PpPnABya+CMyAhVLCsZnq7gKvAvQs7sCmErvysgYYNuC6Ct0j9TBeF
	fzAYlT7e3pCoP0XtgV7hCCOqy2EDIE6rml4cXYuD8u4Jphb0sWwBcjS37qjcIlq+
	dbiR1oV8LOJSSxeWWcOUX2vKQSn4jT1ZgCgtkqlikMdODDkQHmKc6UlaehV9+drG
	gBlHL9vUBdFBLmNU2iR/p1tz2ZBqUc/yTFXgaO6FsYMjljliBVwsVxamrQZOzvPh
	vLkKrPdMCl0JTZ75lmEew==
X-ME-Sender: <xms:WC-_ZtSlBqWt1xPHKglNig4nIuEhRM7anYIZKMbWCipCl9x_C4LcIw>
    <xme:WC-_ZmwvNzw69AQ2U27_eZvn5RHranqU25K4T9Ep-Ob9v0rvFAk9HTFQaLvywAHub
    EB1aCIzA2Dp5Forhg>
X-ME-Received: <xmr:WC-_Zi2RCo8muWofTWo8kGqgMXd3Tsc2W5qUd6b8UdH_5XX_wWlg4Yl-P9VJoUz9GN-JIevYIUs2ZxD95m9JoE2zXu7881919KqjQDwtvghOmTU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrvhhihhhpihhtseihrghhohhordgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:WC-_ZlCqTYYAj8TyegGUBPnckBLvXNkIjTG4q-8P80QvMTqXJkiyZQ>
    <xmx:WC-_ZmgoGZTJj4pVCE8_-4vtU_d9MAC3_F3zkBQp2kvHKuAPEh0vyA>
    <xmx:WC-_ZppAypmUqeOwcXhjPDV7bCVfT1ggeS5S13-sps73Y3Za7DV92A>
    <xmx:WC-_Zhhvvb3-BRSuzyn-ZYizf_YgaB7N7s28zYCXtA4JRYT11Wcwpg>
    <xmx:WS-_ZufI1Gj9CGcjEscznfTMrwjFfqqY4h9jsvAjRcPx1Cn1dHxeLmXm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 06:52:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 39bd4573 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 10:51:44 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:52:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: avih <avihpit@yahoo.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/8] git-prompt: use here-doc instead of here-string
Message-ID: <Zr8vVQhfRqG90H4U@tanuki>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
 <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
 <9ce5ddadf0bb13229461d67451094a373348771e.1723727653.git.gitgitgadget@gmail.com>
 <Zr8Sv9xZrdf6rHgg@tanuki>
 <1407516636.4490130.1723801035574@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1407516636.4490130.1723801035574@mail.yahoo.com>

On Fri, Aug 16, 2024 at 09:37:15AM +0000, avih wrote:
>  On Friday, August 16, 2024 at 11:50:12 AM GMT+3, Patrick Steinhardt <ps@pks.im> wrote:
> > On Thu, Aug 15, 2024 at 01:14:06PM +0000, Avi Halachmi (:avih) via GitGitGadget wrote:
> >> -    done <<< "$output"
> >> +    done <<-OUTPUT
> >> +        $output
> >> +    OUTPUT
> >
> > I was a bit sceptical at first whether this produces the correct output,
> > because I wasn't sure whether the first line might be indented while the
> > others wouldn't be. And that would only happen if we indented with
> > spaces, but when indenting with a tab it seems to work as expected.
> 
> That's what the "-" does in "<<-". It strips leading input tab chars
> at the content and the last line, and was specified as such since the
> first POSIX release in 1994:
> 
>   If the redirection symbol is <<−, all leading tab characters will
>   be stripped from input lines and the line containing the trailing
>   delimiter.

Oh, I know what `<<-` does. I just wasn't sure how it would behave when
"$output" expands to a multi-line string, where subsequent expanded
lines might or might not be indented.

Patrick
