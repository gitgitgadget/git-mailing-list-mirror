Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01949F12D
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355955; cv=none; b=PhmesmOFOolQe2kDe3myxheWjISqIb+Hu2hZCDUkh4rYMDm38UNfgXnnkT6x7v1V/obQQSCEwlPx8HH6dHaHyjGJarzPfcwhC32rdD5jjPlsUckfruAzEuUtT41v7l8oqC0t0qj94RA6lgneJ7L/9uXES3aOh0NWFcPa1ktPnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355955; c=relaxed/simple;
	bh=+frQP2mOXwhKZYKuvEmcKeZjO50iqL3SYKahh1Pf2J0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qY2d69Yig1uLfa8MvouBbKQaT75dWNaNAf1bhgdku63vld0jc1p1TSb+h2+bc5tIriek6CDzqXUkVEWvKclf1r9Y6EXhvVGl1LXNHnLCIDR62AwxoQImKaFwjG4Lor2BWBeSLyg0WbcRaaYdUG6ZeBx1Ah/hBgH3rktNdOzCB80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=XdagQyH7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qTkmIKRp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="XdagQyH7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qTkmIKRp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE064140012F;
	Wed,  2 Sep 2026 09:32:31 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 09:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788355951;
	 x=1788442351; bh=qskLf+R5mCW36RIrwdjv7O9dwpMLOyOVNMB+btqwaNw=; b=
	XdagQyH7Pn4bGis4wlKj3i0fzoGTeAF6Mn6Bl/MelcvgRXmlOGSXlE5M+FCriEdm
	FvNXM4LVVK0g4oz8jtzPDikLBx2lTcbPGEG17A6E5h++F2a5N07Q09S+L3NBL31g
	J9OMQT9JsyYWAm/ITQqI3MzGJLjI0scsbRPPWtXQFLwY1arCBMcV+te+a/TvTHnt
	LwpJcH8WdIXXvSMj+PgWvXgXVSmY+96TbjRtVWr1EVQdtbu1oNfjCllj+GbkviBt
	6Q97dljskVtzbJn7REwOgFpAQDR7bqGAff7Rgkb4N7Imj1Qf4X7DP8fJnU0SBwkh
	g1AS4cYDS9XhfXq/1JGW4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788355951; x=
	1788442351; bh=qskLf+R5mCW36RIrwdjv7O9dwpMLOyOVNMB+btqwaNw=; b=q
	TkmIKRpVbdDb2Ets0RpCCC4K3gSGYoo+zaUv3FD3g3tnAE/YUBvRPwDpPViZoe4q
	bT0MwrYWrPvh3aMjRy8LMRMSDrkCwDuBbhkl2KWhGBRYtaSionIuga4G9aTFLsmH
	9rf6Bag5P1rNRvA7Gfl5O7w3gteYIIuwazTp3jZxhB3VMkeVvVBHGPAIpgQiUOR1
	uQtJqPuZAVpomz52Eb6lfkL8bHobSnb1iQQVmQjglVEg9OJ1QItnfmXYLTsznKWC
	MN1FA4IUHIM0t6eJquOtfbfGtT04JiTiggsuy1gRS+qLn1ulJ0sWKdOoXmeHBpBt
	6afFqBU7VWdA6BwVz7img==
X-ME-Sender: <xms:byWYau5ASLcuSQNd9AhQjlKaTacdfOacukF3_oaoibXzjyMZDzMd_g>
    <xme:byWYaitNEA_JFX4-I6OUCdmbrqB0vCH-6R8wq0wviLsUvtL6M5Dur3cP_XcG5wGdN
    CVh617pX0FeU8mUkgZ_gI7c-AjGUdG9EkIlkazkA4rK6jRwOT6oUQ>
X-ME-Proxy-Cause: dmFkZTGTb17VSbRjfZ7ihISP43yTCCwGJrLGjRjPhha9f+MoyDYtNaiuoMw3NU1eoQ2r7x
    /3kLu8DoUATjppDJaDY/WIO+d5QNIS/jYnyY7hujVphaVGK4iAUWhZ4976QlmEmDRGhipb
    WaP6xUaQXOhpd815wH3eiPx0VYSWhC1OsdCdtfBPQBZ303sjFErmuzJ+rOXgRDnDi3Gm29
    G+/86dWotBAHOSCHVPlWns3S7dHwM5t46RzdBva9Ex4vC/e7iuglhQCz0LT8F3FdITOicJ
    u1sR4uWuxwzfUftprp4lcBRxxnzTfqgcI31aV7VimOqRhR3wJldtPmqrzNrLDn/5sshHjr
    PMg84JfYcHqKE9XZZRd1DDzaHMTQyQFgZHyJXaUSDrulNfclXM1ZSqvu1/ys1onqhNltx3
    YsVkja1ULdOceeNn5sqGz84j2i+xiwnxdvU8+hpXWIRdYo7vRBJy78zbtI0PMgAUoX+Fn1
    HeyMF+MvUYHXbfreN+H0AHtzRQIvIn5z0432wdIjYC5olNQ6Vqik2Fadpwg5015NsjfcNG
    NitwGxyW/asolib1Sday9mFfPLo76bcCxxW8YoiZoH7/A3LY78DmmvSrl8tG1tfeFnrtHz
    MFUPr43MmVbQD6kdJh3Hn+c2xxuFaAKqB5itBHWSgqzHqDUCdx9f3P82qhUw
X-ME-Proxy: <xmx:byWYargiEByEyQaOhy10AV61dWvMmArnwdreNrFX5SqrI6qLDoI8Fg>
    <xmx:byWYal0m0NyvLN7N1O7TjGrvPykwW1Y0WdMMgJ8doKLfVv2jg5_rYw>
    <xmx:byWYalgZFbhLyo1138u9KHmsrZHRneMd_vyaEUFynpOa5msO6_Aowg>
    <xmx:byWYalcod1F8VedEMcjm5inwQ8-OwjbyOBZ5zDIU0XklfHObZaaEVQ>
    <xmx:byWYapDevfSTC4HBXz3A8o1kVXCN6xly8GkTQieZ3BPGwsOJLFVJU_g7>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 978E87811F0; Wed,  2 Sep 2026 09:32:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ankacsc59pRc
Date: Wed, 02 Sep 2026 09:32:11 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <954865cf-5984-4e0d-9e8c-7c874896a1f2@app.fastmail.com>
In-Reply-To: <V2_datam_to_glossary.c24@msgid.xyz>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz>
 <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
 <V2_datam_to_glossary.c24@msgid.xyz>
Subject: Re: [PATCH v2 4/4] doc: datamodel: link to the glossary
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, Aug 23, 2026, at 7:32 AM, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> We linked from the glossary to the data model page in the last commit.
> It can also be useful to link the other way for readers who might want
> to reference more terminology.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     v1:
>     But: maybe the See Also link is enough here?
>    
>     > a comprehensive terminology reference
>    
>     This is descriptive or aspirational. Either works.
>
>  Documentation/gitdatamodel.adoc | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
> index dcfdff0346f..d588630e633 100644
> --- a/Documentation/gitdatamodel.adoc
> +++ b/Documentation/gitdatamodel.adoc
> @@ -24,6 +24,8 @@ Git's core operations use 4 kinds of data:
>  3. <<index,The index>>, also known as the staging area
>  4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
> 
> +See linkgit:gitglossary[7] for a comprehensive terminology reference.

I'd prefer to put this in SEE ALSO instead. 
Also "comprehensive terminology reference" might be a bit aspirational
like you say. Maybe just "terminology reference"?

Thanks for adding these links! 

- Julia
