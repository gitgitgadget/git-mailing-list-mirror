Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD442E6116
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775712182; cv=none; b=Bp5PdO7jXaJlRN1/vOhgd/1B3dO4d+1aZdXVqerZdQJ7mVBgogRKORqkaF+7hs0V6W171OTHLRSg3lbwnMilMDCBzx7wh0R69ndds2lqGjccIoUC6UldYZuX67z6/GhW/o3bTwPTdP9tcF9ACXMvnP0LT8KF+1lJ+qXubg4PF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775712182; c=relaxed/simple;
	bh=VwkhQC6d1mlWMcYjCPzQgzuIsScaojNBw1Sf9tdidDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8yrdkA7mowcK+4/XspDr8PfKGrhn8jPD5uPc0GSnW8cYdGcIwF8wkH+svKn3zYyqtARwz4kidT+lwaB/80GuFZ9PhZAb1dbBLT/ksWjENEQaD9Fo8DnCYlUY7YpOvJqE0FUgfLA9ASuRnPMYm/gkuPX7vxWYZYfyRQHI5Rhze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tjsp9i86; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p+KGto8c; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tjsp9i86";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p+KGto8c"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A6EAB7A01D9;
	Thu,  9 Apr 2026 01:23:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 09 Apr 2026 01:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775712180; x=1775798580; bh=a41e+Zeozq
	jF2/F3zIiXak0zbqBTsKQaUTC1dD/HnuI=; b=Tjsp9i86OcxqEUSLG77ogyRdtQ
	j+VESW62R1kW2yd0cqS6SUUS1uAPM8s8C81XSSu+49lzY5MwgZe7mWf/oFQzE7Mf
	wKhS5OC1tqnu2kx8VNqzGAxLxbKP3o5KpFnZAKVFib4Ga56PJfTR4Uk5wZB7/2MJ
	tCmHNXgnDuo3vT3xS9XvfaQsCo0ZQs7fk59HeKUWAZTwDXD+ArmgwyReBC1AoeFZ
	Ehjm4C3JtIz81KOWaD1rrEncry1B/1qk8eagVrNQLntngt33ECa2nmUypX28UacT
	iQsB+h3WbF1/ofXjRoexk0GQuEKZszgRGZZ9SCRrzwnukP+MZRJ4mEIZIrYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775712180; x=1775798580; bh=a41e+ZeozqjF2/F3zIiXak0zbqBTsKQaUTC
	1dD/HnuI=; b=p+KGto8cwy85wIxShv+DifH7t9WW2NRZg1V1iS5o9Zm/tqpnYzH
	QizP49YmqodAAxFMeFeKZFTKfPiuewK8f0GviUaYTb/L2Kjn5H+hDQNIHzbA8MnX
	x9P/+dr+kkqK7YAArGqP29/rtMmnaYfio/j3MtANTR8VBpwjh3KGe4Asxhui82IH
	JXjsmgvJaBwGyI5EFBYyt5RJvC9PBhlL7B3g8HGf40bXorSbbiQ9/PkFZDAMzr8D
	5YUBIZfjGuP+AxJSOFKTZ2l5rhuojLVvIoMGoBI8FS7yg4JN1ftK45Fo6eRwBtaG
	6caURFDBg79D5fdqFnl2Or8G5Uyiz2PXqDg==
X-ME-Sender: <xms:tDfXaU4Fgl4pLuMB5f06A239EtC-Z_CEertTJ2bvrAkeYDsVE4CLKA>
    <xme:tDfXab71m26MavZrJrl45MnVPkysZqkhaUCe920NkrEphRoA-ChrDN6-rM2sOEUgY
    1KmmefXEOsRtvCMbvdspWJjH1RfgRDrwRarJJy9o95hH31vxnVF2eM>
X-ME-Received: <xmr:tDfXaRFMobp4_XDE-r5bhGKS6l3jRaRJv1HxXZjaTctgi7TwImtW5L75Dx5pUMAimThm0RS9NZtadSo9-kVxmlGe94fGtdKSbxUfou-jH48>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tDfXaUTyimZaPbeP7NWZ0FnZJJy4ty4ruLjTl0XJgrNU6g8WYct2tg>
    <xmx:tDfXaau8SLflzrWls4fk3fqQ1Ygc_ebHSTcGfMvaHBJJH2jo3_kJnA>
    <xmx:tDfXaTzitTheFMNOkFFN9YCq-Gn7IKiuxYQ0H-K6mXQ2vjXlKv8-Fg>
    <xmx:tDfXaU7ulwE-8XXUJzQajI0EVOa_hj6VzVEFnkNmSw6gJYGux5xF-Q>
    <xmx:tDfXaSol_FQXi0dUoBioaP8tws6fZ2tzoffMs0XBP1uw6nES7jn72gCH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 01:22:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e5594ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 05:22:58 +0000 (UTC)
Date: Thu, 9 Apr 2026 07:22:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/16] odb/source-inmemory: implement
 `read_object_stream()` callback
Message-ID: <adc3sHcAj3OwhxUy@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
 <20260403-b4-pks-odb-source-inmemory-v1-5-8b8d1abaa25e@pks.im>
 <adbG1gIAALhMINlv@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adbG1gIAALhMINlv@denethor>

On Wed, Apr 08, 2026 at 04:24:13PM -0500, Justin Tobler wrote:
> On 26/04/03 08:01AM, Patrick Steinhardt wrote:
> > Implement the `read_object_stream()` callback function for the inmemory
> > source.
> 
> Hmmm, if the whole object is already in memory, outside providing a
> complete ODB source interface, is there really much reason for streaming
> the object in practice?

I cannot think of any, but wanted to provide this function anyway so
that the backend is complete.

Patrick
