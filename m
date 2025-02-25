Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBEB152196
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472024; cv=none; b=HqKxbbBDKBEtnnTK/wRsgDkfJWO2ZCst+Cd6FE6Yv6zkJT1OGsD2MHbCXj5hhDgCSToI2eWYNJZZ1n2MrwHwNduMY4nHJDhGCeoVlmxq0/YVrLgnXw0YT/foY+xbXhLfA0xPWwCwCulmPy7lj7b4uenqwa+HKeoCcQ2lhsjephM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472024; c=relaxed/simple;
	bh=dv0nU8WWzdlG0bYZQSRnxJh/E9B9cShfDREdsMeyg9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVSkCxTV2xCsTYTH6H8jtSmFFj2lFchoAGTDNBwPwH3wj96s7nFzhyuGbdPkLKj5oauDTYWkRpIBpLlhq1OLI/xwobosHqx5eZrYEPCM2bmbNRXcCo22f/dLHb9pXjsnJNEwST8w3erIsQl9998QB2Q3ad3rMZ8CokARJAqlrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UDCsysKa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MKlquLeS; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UDCsysKa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MKlquLeS"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4F6DB1140155;
	Tue, 25 Feb 2025 03:27:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 25 Feb 2025 03:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740472021; x=1740558421; bh=45a0GEo7fE
	2LBYo6B1zY+OfqiK1ic6wdEXmXrFH6i7k=; b=UDCsysKatYy0opFrCVLNbNb73g
	B6NdnjsnFNeMJrF+rNsAae4WITkGoSmnAsPapTRvyGDPir44AoxqDIL/3+rW4bTX
	oSoltsINm70UxOJGR0jC6S+NQXF5zOEDM8nkDAxY5EpV779Mwi9p0zTCYivPviAx
	I+RFChBT4lIYuo1Lslkcf3myIzU2iDAePOkYQpVYBYwpHva8EeHGqoqLQd0H/UYL
	EU+yLFXriSOe7pMSj6qKlk4MmqEZ0AMt8ZE5zrQ0CiQwlilve6+hYOl0kmAQ/uVQ
	+IEY6NPHQ3VFpX5UryjWUXb7pthu95WOfnzDC2JjiYe6yAh1aWL+iPoTqzNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740472021; x=1740558421; bh=45a0GEo7fE2LBYo6B1zY+OfqiK1ic6wdEXm
	XrFH6i7k=; b=MKlquLeS4t5sv1b7OjI2QjZApldTKGV0+2QSpblYTx+5KQLDWgh
	+0GrI7YwoYZ/G9T7LJkwU6fBumYvWrr3Nt9b9zZI6yHDfOKbXiRlJTsBYe0AMC8B
	fgfRDM0k/GeovB8WjbUgSgGLUdzNDkXcZHVxU0HVtgQcKs+pKryRKda+kEuk5yiO
	j8xrZHY40kXtnrwKOJ1YGm0QNcKVD11jpKap/h6yRyfBd/PQ52Ve1fIyJFjXv2Sq
	yenQlIbCaN92/N8bOj6FZpATG4tLq8kwzH2LgloX+u6cT8XJdQGtG6+qpZN1pVjp
	4JSeTCf3DNQiXmLjQ34QcO3vf0/ua4tLCuw==
X-ME-Sender: <xms:1H69Z-kHEdJg_3FqO56zJdbvQZiipEEbcec3qMW24luz26MB7SpItw>
    <xme:1H69Z13QHV-RfEB6ALFb7afsd0ULRwHNitPwKQVrqB1IzI_KauDY8z6kbNbgM_HY9
    pkm8tKnSFL3kPf8AA>
X-ME-Received: <xmr:1H69Z8qdAfzmetlAciYj-SSJeJvgNlEChI6NrgXAzwXuVvreX2d3CY3S_Ghbeiwfwb9gFk0B0YVzcc6rzaDYt1HxZ-bk-My66Nvug6nLe-ngbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrg
    hluhhmrdhmihhtrdgvughupdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:1H69ZykXj6dIyL5OoPVw9j94RHkUCz92AliMMc5piw9yLwi-_XPVAQ>
    <xmx:1H69Z812ywoN59YVT3MLtv9c2E87THVa2jDkqlDYBDhzX2ytxQhIjw>
    <xmx:1H69Z5tfQDFQL74w_TAzV3hm6M8uOiFB77eT0gzeGbRAnCUioVx1hQ>
    <xmx:1H69Z4WIz80HevY9GGGK9_mj9jk7QZuTsDJ-QPWtlCdjvnztSOkGwg>
    <xmx:1X69Zw8wxFd0gPmpcdJkyo8W93Wk6fGsVMOdEwJd55CeVCrkyjrtIdXh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:26:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3dbd35d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:26:57 +0000 (UTC)
Date: Tue, 25 Feb 2025 09:26:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 2/8] builtin/refs: get worktrees without reading head
 information
Message-ID: <Z71-zV-RL2niBdrn@pks.im>
References: <Z7NU5fZfc8vfSvZ0@ArchLinux>
 <Z7NVZvAlNJ_00WX3@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NVZvAlNJ_00WX3@ArchLinux>

On Mon, Feb 17, 2025 at 11:27:34PM +0800, shejialuo wrote:
> diff --git a/worktree.h b/worktree.h
> index 38145df80f..f7003a9c12 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -30,6 +30,13 @@ struct worktree {
>   */
>  struct worktree **get_worktrees(void);
>  
> +/*
> + * Like `get_worktrees`, but does not read HEAD. Skip reading HEAD allows to
> + * get the worktree without worrying about failures pertaining to parsing
> + * the HEAD ref. This is useful when we want to check the ref db consistency.

Nit, not worth a reroll: this is highly specific to what you're doing.
How about: "This is useful in contexts where it is assumed that the
refdb may not be in a consistent state." That would also include cases
like e.g. `repair_worktrees()`.

Patrick
