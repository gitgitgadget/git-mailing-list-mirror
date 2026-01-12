Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B530FF1E
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768206327; cv=none; b=gk6dFirVUl2+7lcdUs2E+qJwxgiKZ05ET7C5z1H29QoDpHACTeAVXzUj8FpFYdfsq8zvZ29MLHLqgX/TMzIX8/25Wvgp9oxgUb8Aez5rEQM/CY1cJESBRFZiDcJ3MaImsuwdRNWE3zHQan+XFMfjV6SBAenZm2JGExoLNUkoNu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768206327; c=relaxed/simple;
	bh=YLBmWlK3NZR1Wocq+cSf6xFn7+rQqEakQUnN4gQC/Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADyGGw2ngfi4ftoHJqqR0zASWaw6cXevykE3kEr/tL/EuXjOvNNBV+80O05MO+crdHpNhq8lyXHhstHuZLV6MRaUpLMzfUjebU47pd193juH2HqTj87I2I0n4L6yFk4TYvacV/BPrOoanbYD5udVea83r2u5Aiz/kehlTdNCL2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RDqdB3oE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YbOl/gfD; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RDqdB3oE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YbOl/gfD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 010797A00CD;
	Mon, 12 Jan 2026 03:25:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 03:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768206325; x=1768292725; bh=XJ4W+7sYtW
	FJZbq5KiIjzEIuNltQRnz3oWRjVk7VY0E=; b=RDqdB3oEKDIa/1r5SWPwlNKcBK
	74hDQsQyS3iNOV3Dk6i19vlNJF9Ot10UmlxOA0FR/wMvaBe8VeUf8YbONz5UZ+ma
	pHsN8WQdkr6eHVrlOPFxGRz4ENus3W6yMGA3xt7Rbc5558NaJ0245oLr+0WbYIL8
	2rygImupBuJaldNmpYZ8MfgDldVP5F/qt+27YrqSSlub/VSzAkh/aGvyIA0N7DcW
	5WeCOZuq2uO88FQ/qEcSLRMNdVMayKeuNlWYkcb4WEw0pazIQsYfVk5cQNg+q8fx
	kNRo3GG1g5rXOLW9l46D9zOqrwInt3Dv3uQigKMS76bVUgAhvJxFvlrq9kyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768206325; x=1768292725; bh=XJ4W+7sYtWFJZbq5KiIjzEIuNltQRnz3oWR
	jVk7VY0E=; b=YbOl/gfDrIhZem6mpzekvftE/nBSecrPVUCY9KC/PqwybmvupU8
	YgCI5mDWwyfLPmXQ9J8ETKW9kEAYuNeqIBLd+r69rIUN3/uIUwCGn3k+xUSaTq9b
	NQOS6gVbOSqPYDizkvyJSvtNmoB7SjRZxfvX5AsFxO6sdS3FLbRG4srCFkflQZM+
	dWVq819uZzqYlwXiVXrbjKYuFsr/tIy7b+Y0A71pwOMV3zgFb23LDMMWMhNRekDy
	Mvj2ZACgxSDxsq/DNeNZWtCZca6tiCw/5FXlRAp/ZzjsGxL7HgJ1BFwrB7x522Cv
	G0urTm6ma7CTJUQ0Sdcg6xNb8uRPAR8NpSA==
X-ME-Sender: <xms:9a9kaT9jEhl9qtx-z3kmCetSvQjHdM_VzLvPOKTBFi2AFDyc5fadqw>
    <xme:9a9kaXLT5AMlqnQgUSVxhOA3G7ltq1gVPFdmG-gB9G3rQmhT-MASp5qyDw5R2YKDq
    L2HkukApzbZpflZD7A3NRuamP2OYRf33I1XhAPDIC-travGvIXlTQ>
X-ME-Received: <xmr:9a9kaeZ7_DvxGgD5fIAyeWMfxYFb0Ix9wvebo78o3F5D5H-XFGEge7VoEgtMwS2wIwMgbGazxofMqeIJyW-6VRYoZvCZTGVHhCDXEAG-8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeileejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hshhhrvgihrghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:9a9kaZLoo_bxq5QpOwcFbb_nfShFUJLx7-rz2AdM0rDeXxj_spAtwg>
    <xmx:9a9kacCttrNONqKuEcPcXMYhpRo_g1tjyqRQg4nZQmyZJWweTwKlxQ>
    <xmx:9a9kaer7c1wTcMmtSMmOuLwkyi6wPW-TeXkTwO-qSM_n26BuuAnxeA>
    <xmx:9a9kaXiIQSdAYPC9Jibwm8M0fzVBwl3jnOi05NiCkwCTxnybRbCPhQ>
    <xmx:9a9kaTKAYDZkKWb7bGWxEwir6w9eZMg3y-CpV7JM12dsHjdxY7tETw7G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 03:25:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 91e200d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 08:25:23 +0000 (UTC)
Date: Mon, 12 Jan 2026 09:25:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
	git@vger.kernel.org
Subject: Re: [RFC PATCH] t5500-fetch-pack.sh: fix suppression of Git exit
 code in tests
Message-ID: <aWSv8dlt32xg14e1@pks.im>
References: <20260111202137.257405-1-shreyanshpaliwalcmsmn@gmail.com>
 <xmqq8qe3pxvm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qe3pxvm.fsf@gitster.g>

On Sun, Jan 11, 2026 at 02:50:37PM -0800, Junio C Hamano wrote:
> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> >  	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
> >  	0012command=fetch
> > -	$(echo "object-format=$(test_oid algo)" | packetize)
> > +	$(echo "object-format=$(<oid_algo)" | packetize)
> 
> The construct $(<file) is bashism, that does not work if your shell
> is not bash, isn't it?  If you used a variable, e.g.,
> 
> 	$(echo "object-format=$oid_algo" | packetize)
> 
> that would make the result more portable.

There's no need for the echo at all as this can also be written as:

    packetize "object-format=$oid_algo"

Patrick
