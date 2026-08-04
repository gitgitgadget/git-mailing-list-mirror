Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A466421A15
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828082; cv=none; b=A3e23LSXh/clitKPuwuPL8U9m7kZ4gCYPkjsCavQ7OCOB40sUGpyqE8lUCHYNz+rfxBXIfqwDKESXfE86brib6EAVh3y11AUwg8pWbI0mLzepPPGXzI/8cWnHbV8rNs3g/JOsXY6re+jfl30oMkzuqnHbAUT+LVaH/1z21yiq2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828082; c=relaxed/simple;
	bh=tBbyT8hi/HI4ieT4uItWNOwPglKN5GvMB3KwqdCR1+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cstHIYEb4YAZEfpwHsOzW7Yf5vvsiRHs9bjsnP67k+TTMCKchAjOFTtDx+usqEdk7wpyK5Wfs/zuLOKfiNVvXzG3XZuXbeoLEyjCCXz3MmLMIAjekQZYIBvxu8K1/ceQF6x55FtdCgZ11WD1P70I4sDpXZq85v14Dgghijny4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NZ7rbQnY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZXZXc3Ii; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NZ7rbQnY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZXZXc3Ii"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 688AA1D00187;
	Tue,  4 Aug 2026 03:21:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 04 Aug 2026 03:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785828080; x=1785914480; bh=HT69mV8ZvH
	8eZUfOnW8aBg+MV6/fsoZrI5p5AQ/3MF0=; b=NZ7rbQnYkEGhHWcfBB03kiE10z
	y0WXA5WXgXCiKzNkyCui69/wAw28CQtBYXmNyqEH+cSz5FKtr6L+1gQnSyWtOJwN
	kR9iRzr9CjTAMzpmcMw85xFTOCkmV9irRhFeR0HmQD5+W/GNua3J3a2i/rc7okum
	VcQcdeNMdRKMJmgdH+IDe6VrD3dpuiFUXnLuip321Kt0fRs8mQk8DlioVL/4EfPx
	1STFVhr/mZ2yu8GQTAB+PakDeXlVpT3EyemJzTJSOmRkPEa7g9uyV4o8KmT83fpV
	JPlZKuoBjjwXXheL/YxIrDmpkxWr5Jt+ZNoFI5TRb9prMxVFugk6fLatqQhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785828080; x=1785914480; bh=HT69mV8ZvH8eZUfOnW8aBg+MV6/fsoZrI5p
	5AQ/3MF0=; b=ZXZXc3IiZRDY7+/B2qTbITRn/wAX6Su4LZ5d8mXQScjmPquRUZ5
	FP6pUokdvudhl/3sD0vijAzBF1zFK0vEZdEQd7VFd0O14rixq+GJK+ltBZ0pUPap
	Cr4/+DJmLGUP8NhPDZw4Itxn76hzJ/vr4VYwuaBoANGt4ZbNHhk5Oh/1fgBRkf9B
	gOO3glTqNw0lK+cR5nRGVKnhAHRpR8Im/PJEvQn5iNjelK2HzTVF6ot440nQU2H+
	wU1Dw+UwN56dslac+ej855+Psvcz4ITlVUmaeFfkS+Ho6W+4pOgUSBN0RH4DLa8u
	WtyFnqxz6Rt5B0xECrNJcdYLzVrVHMmUTMg==
X-ME-Sender: <xms:8JJxatzcYYUopjLXKCM32RGmWrGEI09Ry3Jv0_l2gdknYKuPB01XgA>
    <xme:8JJxajRRfPIYs4aZNshGKQ9m2z1DVCFDNqeyxX-qkYPCiETH6-4Cw6kvgZJCRYGJS
    y9f6ZNYSLJYwoWUB2qMnuTttU10AVTuuHCLZ-pixLEdtNMr6Qi4CA>
X-ME-Received: <xmr:8JJxak9BHBjqSvXR_5rQDpu4Ma2We6UqWjyhKlQTykO-0bllufFkJu6fNkiM0jiRabsgfNjW-MgRl4MbrOlsrdZpb1qhOuSmkZx8ApDl>
X-ME-Proxy-Cause: dmFkZTGdM6jpBGZhzGMeQuy374uz75V+gHLRV9Ekqz689qKkzsSrlSeOAdb5ajEbF1ADvZ
    aKHz+UqItg9eOBUZzQLX30I+y8dByine6J+JuyBCqa5+dApg1SLbjKwh7txknVAHrnlb1o
    vGTi+lkqwLGopOwdnxxGdhw6JxwTAczw6VYSB/5MBvYYIXm12wX+SB9/WSHHWgtVJnIBLT
    eIeb+2VKNnQINhFj5bHPozqcS6IFe+HaWy0gZTjRUVXWwZuP+eV/kfasJtvQdwktRwCQGj
    fGWnparXTfRW6OIicMtsa86HUHe3Nqr75cwUYC5cG/RNSylYzj57UR1LbMCDqbDxsRX/rz
    RNhV6Scm6w/z1DaqWEqibtI1iRsFp8D3+OD8pRCf3DXw5mMUEzvbCwESMSLTHbdNKtiXNF
    uDoM68Y6pK3r52HqICLSxu6aNRt4Qhrtq2SF9WzwsY6RBHuoSuMNSCYg+H8qsTviOd8p3A
    6iTcHFUoGzqV4qQiLlin0n2Qx383or1bzqONH0DjHBteUZpQPxknJJC7T9TXJPHeWbxz9G
    PZ1bUk+MfX/4j0zfKT12m5V2GAiirnnx1oytbU9iTFL+YKOGVmfkC7eCeGpQ2cNyZ0ToLb
    VbNgWAQg2lspMRPhfGaXPwkgNG5vHkWs/vJvp0JIc3HnqbQ+7CcaPhNZdeIQ
X-ME-Proxy: <xmx:8JJxaqoRY4WAz6dJMd-TTkh9d25evFcM9qcqQ5BFNEInEDDZKdxRow>
    <xmx:8JJxahm_i2tWLJ9WQ165RX3AoLwIOhD2rzlaQtwmF2lclpIHD1xwxQ>
    <xmx:8JJxahK_1M6CKC9Mmw4W4jKsAKq3DO27eGvwCsVULwwmOtwrQm6iPA>
    <xmx:8JJxamw5bNAkxSmAt9CkCFUwCZfYXvRUXzh13h0qKKYUYoepzB-n-g>
    <xmx:8JJxahKJkpFvuR_TatdmQmVEBrkScAui6Q4zQUzctsGxpcJEoAkss6xw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 03:21:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49bd3f19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 07:21:18 +0000 (UTC)
Date: Tue, 4 Aug 2026 09:21:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] odb: make creation of on-disk structures pluggable
Message-ID: <anGS69L4vh3TsDlP@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-5-3b3d265d979b@pks.im>
 <xmqqbjbtv5y6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjbtv5y6.fsf@gitster.g>

On Sun, Jul 26, 2026 at 01:42:09PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > @@ -271,6 +289,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
> >  
> >  	files->base.free = odb_source_files_free;
> >  	files->base.close = odb_source_files_close;
> > +	files->base.create_on_disk = odb_source_files_create_on_disk;
> >  	files->base.prepare = odb_source_files_prepare;
> >  	files->base.read_object_info = odb_source_files_read_object_info;
> >  	files->base.read_object_stream = odb_source_files_read_object_stream;
> 
> If we are going to write a brand new object backing store that does
> not use an on-disk filesystem (or a network filesystem, for that
> matter) but still requires some sort of "initialization", for
> example, an object database in the cloud that needs provisioning
> before its first use, would this virtual function be the ideal place
> to do so?

It would, even though...

> I wonder if we can give it a name better suited to its purpose by
> moving away from the '_on_disk' suffix.

... the name is admittedly a bit misleading. I couldn't really come up
with a better name though, and the `on_disk()` suffix is what we already
use in the reference subsystem, too (see `ref_store_create_on_disk()`).
So I'm inclined to leave the name as-is for the sake of consistency.

Patrick
