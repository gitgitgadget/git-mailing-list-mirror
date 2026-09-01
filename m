Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA644A418
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292655; cv=none; b=Z7QL6IdyvHr6XUjiuBM2PGjM2D60IjJPkudJTIupzOfV9qllrJXUxKZwf5fgBgs4X1iFzwMxDNAgK9MuWwRy5g56ez9ERVURJHy2IzKBIMKJidqBE+fwD9aj52CbtB9SPF2CtMBKNFUjyMGgb9h9JBrhQNBTstLFfGckVljt4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292655; c=relaxed/simple;
	bh=PesAM8OSiztoqk2LlSZTJ3SfCffJEX+t4IMwyEwkHQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HjT0I1YAqjRV70vt7kp2fD6U+lGb3eC0FiIs/ZsDOCZSLHiHsSH9pom7zNEdQarDCAI6k7KInd2N2yHh7/KdHJJ5rKcwmOdi/kX0RvEmBlCFaqboIVt9ZeFJO82/SWoz+JkxwCKOvqTCEQd1bmzWluo4HWRaM4UyYwcVXOIB/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CqQgZR6x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y/QnSbHp; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CqQgZR6x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y/QnSbHp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C488E1D0004D;
	Tue,  1 Sep 2026 15:57:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 01 Sep 2026 15:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788292652; x=1788379052; bh=vHRObSNZ0l
	i9CaL+gdaeJOH2Raibonw5Rpx70L8M0yk=; b=CqQgZR6xGqx1Bolwei9A7NplKu
	/4TrvzCOZDsY2kySbgZcJD0ufKZYdkgrKS+GLdg7siUOPI5O/ZYIHUk2q7/oMIEw
	O2L21exNmpfp2lyVaWLmhlabii6letNbvmbw9XOmWFjE6FHRtT6Bdleh+GpZOyZ0
	8ITCSrrkvMfucBBKzTKjCb0/bp/7iUPb1I8uzTEcKZXP6OWOayhmB7hJAVICK6sw
	zAjQ0ydGdqVPfOlBMb0UPqrnLNIwXggFhM25FS3GqrgSj7d6Jy9cUGmrpL00uAEw
	xQcKAxdEtufJMt+GBaaHG0MnfSc6XXy6RkwuYjKF8uHryVCCJz88cVUg6yBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788292652; x=1788379052; bh=vHRObSNZ0li9CaL+gdaeJOH2Raibonw5Rpx
	70L8M0yk=; b=Y/QnSbHptBCybvQnQJvGRizsZzV2Ys6mBqIHCUTLWbNgFhAmxXa
	+tViP21DcfC8Ih+NOi+oDpxSxS5Xus2at5hkyCWdqnkqa3oxKnbHMiwUb1tBSddq
	QzEQ8X8hBhmdbErjOklpBprho+9tU32kTAQEPGcaB2g/0+zeTcOR9uvlr4EZQkoV
	cH7OXRS/0mFLb3Eu0wkn5imsj/uony0V49CkGoorXugzA3MtbRRsyIF/k7qsd6Ur
	8G/yj/JtV4FhJlDT745rJVZNNHk1QwZ/NDct9uJUg4wuyVLt6GKSyvE2NdUMYrcP
	IZpa0dKiJDKW/vZ+upGN1eiBanc4U9N7kuw==
X-ME-Sender: <xms:LC6XaggV_yZP-HAfHsb649wqg2gxbqrRuKExG1bDjlPLCwUzlRklEg>
    <xme:LC6XalkLrZIc-Emu-bMndRU02-1kpsKcjYSFTfNKTuffopYnRRvBPUuoUTXDgoOjc
    2qrp4mg3twvSqNtPlINIDiNk2llvk6HTIHCP9vTMkHNW6l7Qxx4GCI>
X-ME-Received: <xmr:LC6XasgDkgP_h7KhRoa5X3fUEQMPJzfhchMnfX6Z7_tPzFg0hhzsLUVxEszICHkLaN9HoJc0kV0cU6ZUAuUSP10TO6DhMVd8Fg>
X-ME-Proxy-Cause: dmFkZTEHgtJQA0fjV6rkcQmx/6Yz5GQrX7gCloQtJGc8B0oC9GyvjvafJEnwAUKqHw/xld
    d8GCpIkfthVtT4tF2DRMnrtSqtfJ85/yytCWGnYnheIBXvG1YKBZiTWprv6fGoFg9TfjPY
    /FVEqr/gHOAkDyNjk54WUXEY2LyZInWXg1S5nubaGXynzCOSxfLa1g4KUlfsMNisiUWNga
    c0XhgPz9aXtlNFrb/WqysPFpEt0N8XkYkUmz6e5SKWiKSsFKhd9n5hZ6BRpkYgD4W5BvJ6
    1hVoUTD+nc71y49w6sBxD+To0Ap4bajPCL85B9WVYPXv5NtDYHmSv8O3GcOZvE16n6tlFy
    C05hcNmdi129HvgcqVEdlL69HiBAJaQjb2jVbvONZ/VcwXTW6hhsNmuZFpym4ry7kiXODZ
    /bEwTXfxwfaM8Y7ZUXUhiayN5G87lGqGvyL9Kw9+u7zcE7z9qFbZb98E3uqZq6eLgMhoZ1
    y5IWJUafUKu4Kn9HzcrBJ+0bGViRFCR4xvVwHUQguI/OOp5ZPEU3ptLrMb6W2L+hXQKJGe
    WICd0To8dQ9tuoVwJv0oIhphCPvM+wuP6AZvrJ/F+fDN2lx1LeC/zh66bqOz373lRXCFpU
    UXR0ULRi8Mzu2DAQp0ALGrEAtDbuNi/r2lKBMPDPiW76yWDrU4M7Ci6FTr5g
X-ME-Proxy: <xmx:LC6XaoFNZtHl-L2PmwcrNEXxiLbMKCxpl5g6j6Egqf42Oz9laXxIkQ>
    <xmx:LC6Xauu9Or8UBY-paFwcvsjacp33fFWWmnqwS3j2jn4e9VYDbjrxfg>
    <xmx:LC6Xapd2Suo-PXZQuR-QejEjjICcGYUbm8HsfZU3xDfxqbpLOrOBTA>
    <xmx:LC6XakmRNIHV8YQ8sT7CGZqffx31EzsHtjyiYC7AuwFdO4OdJ9qxBA>
    <xmx:LC6XaqWSBTC5UeyYuQTmyG5uTky2MDcnlkzEFKREX7_WMsanABTRCGl5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 15:57:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  chriscool@tuxfamily.org,  toon@iotcl.com,
  ps@pks.im,  karthik.188@gmail.com,  justin@parity.io,  peff@peff.net,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v2 0/1] rev-list: add --missing-only option to filter
 output
In-Reply-To: <20260901185100.33948-1-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Wed, 2 Sep 2026 00:20:59 +0530")
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
	<20260901185100.33948-1-siddharthasthana31@gmail.com>
Date: Tue, 01 Sep 2026 12:57:30 -0700
Message-ID: <xmqq1pbcsq1h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> At GitLab, Gitaly uses rev-list --missing=print on partial clones to
> find missing objects. The output mixes present and missing objects and
> prefixes missing ones with '?', so we post-process it. --missing-only
> avoids that.

Not an objection to the feature (as it can already be done with
post-processing), but stepping back a bit, how is this list of
missing objects used?

You know what objects you currently have.  They refer to other
objects, some of which you may lack.  You can get a list of them,
and then what?  After fetching them from 'origin', you will have
a new set of missing objects (e.g., after fetching a missing
commit, its parents become known and missing; after fetching a
missing tree, the blobs and trees contained in it become known
and missing).

Fetching missing objects a batch at a time sounds like too much
back-and-forth to peel the onion, if the process using
'--missing-only' is trying to find out what it wants to fetch,
and would be a rather inefficient way to backfill a shallow
clone.  So I wonder how this fits into the larger picture.

Thanks.
