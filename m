Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC4D439345
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786449751; cv=none; b=Fq0u7yn7lQrT0iYtj/bdJtJE7YqosC0jl9oweknMIgKBhAOm2rrbtFvZBIRyI4KLrnEMAqaRgR7DPIrhVKQQZhSFlBBgpQ/Sn9ftw+lqwjpL6/AAU0vieG7Nno2r12u7MJcP9UTNA/FqozSwGlMuXDbGFmagyw69+k1O5iKxk3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786449751; c=relaxed/simple;
	bh=ihE3kgReZ2zlMWhgPXLnQSl2h76NPmmcu75qYB2eTMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neir6orzi9kV+3cR7CZsImZB6iGRMLwEsMcx0L2pHb6oWUNUW8k8pf5glei2TZXHtVJg9HPAD/c2i1Sh0T8KcprPwtbwNXzWFv3UB1sxqwSS9xQahc9N1FnhhA80wTw9mMpttsH6mucPCgML35kZIplfuG7Ns5I0pBVCMWJHEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aklzAg+g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NT2op51i; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aklzAg+g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NT2op51i"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6575AEC0122;
	Tue, 11 Aug 2026 08:02:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 08:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786449749; x=1786536149; bh=pOkJ1Zzw3b
	qwSgp2IP0FiCYZcHb6Gm2tOvkSrdJspXE=; b=aklzAg+gMbNVwxRztXBfHsXlE+
	3jldgOUKpPxa3c0vwxa7oXIiZnww6ZEYRQvP8C4KgWn9LwuHWFAcQZm2ZqTEfdkl
	eFB6MJ13SGr3RH1ctnz3nxQbBLal2PvKGG1Ndh3NXmO++uyzf6Kv6F4OPWNR760y
	rC/VObkTYUnBEC7kWoAJ/62i76nlZ7crfdVg8DpS+6fDLpqCFvC3s5h+eEhF2Vga
	cVL1dxLas+w6O3zJeLrKiJ4HfHRZTXKOVN7UvoFUl/zenUG9uv7vklCGGJS9EISe
	GLv4VqslyrtSFMdXes+r9YdbT1DY04oxasJ6HBrow1kS8IAjQHi/zFJ7u4bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786449749; x=1786536149; bh=pOkJ1Zzw3bqwSgp2IP0FiCYZcHb6Gm2tOvk
	SrdJspXE=; b=NT2op51i3W5APoBAXDiIykUWE7LnmiIZdKUz8SmppV5XiHNvzVK
	gKBRA52kbDYpZVdx9fKX5QARMgn/qKdFKt5Bj0GC+9zR/MvSwUVQKnRnODpx1UEv
	lN3nngDqndbvcA8zg2V9rWpHGdQV4k7goztRu7pC7g0zU+ITflYIFQhl7WjE9cGh
	7aGVrPWcSoUbQ+cH7vFPB5cWHjvdZUzk0lMXfE+OdjKa4pVT90O3thiO4eKV9M0O
	U+tQq0pvM2bFx3gz/P2OEC0y2JEAJZ01oQb5cdKvaz9Lb3jGXxRBOLvd1TTWGMqy
	vj49l9WjYH9gT30to3a6fBxmC4T+hcCuzXw==
X-ME-Sender: <xms:VQ97anjMBOBPCLe-wYvwMcE5orQShFTTk8ghGqUD9Wih9D8uqcrseQ>
    <xme:VQ97arCfjaN6y1gzJq4SSDKRwzDTL2O4cTrylsuFmtuu_QBztedDZaFv_5Jf2pAEN
    EiIrYehSQ__5YJmD3-BMtdhhLCGl9mvnNPAZn0edcZ-I0fJXRcg>
X-ME-Received: <xmr:VQ97asEr7yQsxzuxxoopyYljHmAVQK0D2MpvpgYJF4tynwx-6Xhq6Lu5JiPOYTv_oqe6TmcuyiD8wwMxndH1VzRempZbI6WCy2trdN2HQA>
X-ME-Proxy-Cause: dmFkZTGnBLXtE8AJOnleg1yDxbzLaNlnwDT2wohKXxIMpeS0R2H2uWFZkp9geLJOTo7TGF
    Scr9HtAlrZQvLu3MwbUEHDkrIIcQpYJusqfQHQViSxqRtgIWOGKeae2W/5ocJC/hWZe/bg
    rhzp7uy0lVslGHoh9f4gMVIpW4cPsFXyMH1ZhjreIvtnyPLvSce+dM0vnqdv1QnRcP/BiI
    GQYOq0IFtN8u3g2YfX+2G0w7gIMexIdtrslSvQoJ0adfcEi/xNqTB9QRAgUHVu0shhlTvB
    Wq2PeZSsp6lPI3cNoZaO3Dp39ZT9hz4+RR8B/fmzu+pF2Hq8i4azeJt4bVHXkj/BrPU7pR
    2kcjzaW4hJkidjkqMuVU7r5ftHsFUR720D3OBY8ha88wkJANpc90IPfQaXBDMnPbGWVCzm
    g1AQhURECmSq/uxZh6q7ChZ8aVauhJ+BjUeVIGpyYqwZ1HFApO9X1rmaWhhot6VPLVv4i7
    68rw3sGHHvofRdh4geEqAbkPzUQYhJ/cvU0VhB3dwR4H6JFk0zoTvZeIdYrxAJ0YhBuJqE
    XNL6eUAvmRzt7R5jKQm9liYRsXXSAOwqX1ZujvKaIHHGT5Wa1FuW0MqnLiJGhkRmwyhIBW
    7ee9TAlXKzTZulYXqzmezRH4dnd4Uk0sjmAlj6NjdtCr9SJ3piXN3+0bxtkA
X-ME-Proxy: <xmx:VQ97ajIVMSiTAd90hkAki1ZgmRL1KKtUHpfUYJxB7gog65zjLf3YIA>
    <xmx:VQ97agkoSskdIc1pIshePSoU-5W4tofjRA6nE2b6dvnuXv3oRYFWqg>
    <xmx:VQ97arRvbVmFf-30DDD2qm2AbZSEVkMPo5j2NxCXTNWogJssjxxf4g>
    <xmx:VQ97aiJbz__n1H3dSQrAzBHgpUGI3F_39W8C12WP99e532a7b_-vuQ>
    <xmx:VQ97ajktdevVZiXxBqwhWiFT-RcBXKfl6OiUNDyzeDUdz9k_Zbcw74q7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 08:02:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a3b7714a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 12:02:25 +0000 (UTC)
Date: Tue, 11 Aug 2026 14:02:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/8] odb: unify read and write streams
Message-ID: <ansPTZ5oV9JiFx2h@pks.im>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
 <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
 <CAOLa=ZTtn4kpQq6H8gJpEnC9RRbb=eFgKjxGEQyeJGYr5CcW2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTtn4kpQq6H8gJpEnC9RRbb=eFgKjxGEQyeJGYr5CcW2Q@mail.gmail.com>

On Tue, Aug 11, 2026 at 06:13:05AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > we have two different kind of object database streams in our code base:
> > `odb_write_stream` and `odb_read_stream`. While those are used for
> > different use cases, the provided functionality is ultimately the exact
> > same.
> >
> > This patch series thus refactors these streams so that we have a single
> > `odb_stream`, only. This allows us to reuse the streams for different
> > kinds of purposes and makes them more generally useful overall. For
> > example, it's trivially possible now to create an object stream for any
> > given object and then write that stream into a different source.
> >
> > The series is built on top of 5b2471720c (The 10th batch, 2026-08-03).
> >
> > Changes in v2:
> >   - Use the correct object type when hashing in-memory objects.
> >   - Remove a stale comment.
> >   - Adapt a commit message to mention that renames will follow in
> >     subsequent commits.
> >   - Add another commit to rename `struct input_zstream_data`.
> >   - Link to v1: https://patch.msgid.link/20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im
> >
> 
> I went through v2 and I think its already in a good state!

Thanks for your review!

Patrick
