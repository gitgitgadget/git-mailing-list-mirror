Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523C37BE6A
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653690; cv=none; b=Kn3DH6CFUP823+yVXpFC/Yl8c/uelU4DEJu4f+wFJ8m2jCb/zc+8YfdJYUMwMGyLu3/mvEmJGTyHsK1yGHJJIi99K4tNhgHaRAMOjLvgAGlhfUWed9E606obrv+TX/4y7nxU88fCfvCxMFQrrZ+3G8yEMqF81jtnIue+RgA3S14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653690; c=relaxed/simple;
	bh=CBVKDL+sAH9uCuLW8xt8S9RHXp1UBlur4L5cuJr2UVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3NQDGkN0qrd1jHgD5NacHS1IfBnZe3a2duXFK3kbqwBRd1VhSOgnO91S7HeCwEz3HdeS/1YmYt5ace6O5DVHPVFXMtuxdQ+mGhDpFfPZEx4uu3sQhxFyaopEGYjkWqD0BQfUODd5Z21i4QXIgveYW7RXi6/4zrlBR/Hbl5nvmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MTrGoFH3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4SJSCgEY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MTrGoFH3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4SJSCgEY"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E46D7140019F;
	Mon, 16 Mar 2026 05:34:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 16 Mar 2026 05:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773653686; x=1773740086; bh=LEVD1ukQMc
	aIA90MQDRsi0hD3DU9/8E9AQ4/uPtF6+0=; b=MTrGoFH3l5PzHMo1JzfwFYC2YW
	SBFRMt5TpJwfXGuO9efRqzbzo733dSbOux4PCKAEkxvNGmTYHaerhE/uVrE8tkqf
	oSUkmq1oVGrb3G39TpR45HQztauqkdb7gpLi6qrQqIhrBvuk2XweTynWZNyFns/0
	Rz5ZE0h04cE+OhKLEFID19WhbVNzV3eTcciP6VrgDghsrT+anZ06QAgH0V4ylcyd
	9bKFwW9Bqq0ap8K6q2uw/bEe/B8Bl2TRDYlmVIwQUpnmsko2maxVeNE7QAua9kj/
	L+mpnIdtZkfyWbapEqoTK7lnJpkcywSpLdqb9sniVxT+o9l41/3smedboafg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773653686; x=1773740086; bh=LEVD1ukQMcaIA90MQDRsi0hD3DU9/8E9AQ4
	/uPtF6+0=; b=4SJSCgEYW+zTsUAd1Oe3Qq+khBqpa17YBvZDe2VgYiY61WgWjO3
	t4dKMYUIxbzPu0x1LTn06Z7AHKQl/pLyVuJF3ll+SgvH5RsbCRM5S7M2yEuKfbk+
	okRi+Nn8eLplDXM2QuQD7fuWuiPRnwCxad+0LSxgsIrfhb+CfWCm36K1RgrCxncT
	vuMcufy08ItyXkLDEbxXgcydPVAFK7dLWjuQSBx5Ck2o7LMQlWunoqbdljA3eGja
	gej+QxnKcIz5/5A/Yg9YpPGKnLkuiNa/NUD2M6nlYVRLkBjhqxESrJ55f9zm7tfT
	5NIvbCXRowq9RpQxxyMb7dlMJUNAX6wsSog==
X-ME-Sender: <xms:ts63acqDsEbD-wuRoHWOjGOGYVsCoY_H3EVGRGzxvN1chhTC_ykTZw>
    <xme:ts63aYo4WzIOgIpq5-PZkCh9LbQ_x_MXryUfdHSwdG8Syl27hlrsQ0vH3n7ZHZvDT
    3G0UH0f7HBtNitnAOxC2yWW8gWSN5GTvHTSKPbTDzVoHP2YcZaxABI>
X-ME-Received: <xmr:ts63ae0EJGWNH-kw5xpii7Z-5Mirjxf66aLv9d-r923mH9N2NDh33GWwx2EFffaXGitdQ3febqozsKpCf14f9WJ-VZ6DJDpBEFMyc4qYVl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ts63afBPGaWIoBWTWwZWxy2H7BDsDGRTV26VYWjZXfK5dSX4ZcYJ6A>
    <xmx:ts63aecmn8TqVUhbo10LDVBM98vYgfmXFPURo4G0Qq7VYUunT3k9Vg>
    <xmx:ts63acgFQ4Eto8ki7skh93jIp7XethPXOQ3eX5DLNA9qQxSf958KGw>
    <xmx:ts63aerYr-BFLe4pKl6fAczKCMLLbTyYyjVPSMFZwj2x1eBQb7UM8Q>
    <xmx:ts63aQA_lXXO2YOtJYbN265rXGBvdoDzVUU5OctpH9Dp3-Np-370dR2Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 05:34:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5735a3b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 09:34:44 +0000 (UTC)
Date: Mon, 16 Mar 2026 10:34:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #05)
Message-ID: <abfOrAPmDJ2vmqS8@pks.im>
References: <xmqqh5qka8so.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5qka8so.fsf@gitster.g>

On Thu, Mar 12, 2026 at 05:10:31PM -0700, Junio C Hamano wrote:
> * ps/object-counting (2026-03-12) 7 commits
>  - odb: introduce generic object counting
>  - odb/source: introduce generic object counting
>  - object-file: generalize counting objects
>  - object-file: extract logic to approximate object count
>  - packfile: extract logic to count number of objects
>  - odb: stop including "odb/source.h"
>  - Merge branch 'ps/odb-sources' into ps/object-counting
>  (this branch uses ps/odb-sources.)
> 
>  The logic to count objects has been cleaned up.
> 
>  Will merge to 'next'?
>  source: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>

I think it should be ready, yeah. Thanks!

Patrick
