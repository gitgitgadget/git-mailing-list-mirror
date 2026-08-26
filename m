Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D239902B
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787777711; cv=none; b=IkOUk2iPAUdZcqkiI13GEnjlt/kD3KCZxSMXGUewgn5JkPZo5GRrscgd2JIBbxHNFUbNuv9TcM9XPLSjGLayS3hLLLIpBIRKnDMYAKlfFs/cPmvU/SWOayIf1sdgMF6FOybbTZxZylDkEP7gXioR3u0wmZuRL+9Ji2yvsVlyjZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787777711; c=relaxed/simple;
	bh=yvUMCUnqsYAY0RQOCc7PUzG4YD+pQ6da4+6YNhG1kqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UOY8HOBQCxmBeoU/bRsj34BO/4gn+zKP95X+G3tqwiw0EsuM/c4JGs4h+x0a7u/hpXcZXXR1IMw9360nM7Sp0VPh5gs8EacQCf3hnU0lHzQkEAPtJpSt30jN/oZPQpjvNYT3B+eE+JzJYE0X48R93rDlQ6zhURwyRND3m1v+tM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h+2sWI/c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K+2Xq5+C; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h+2sWI/c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K+2Xq5+C"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D3F361D000DB;
	Wed, 26 Aug 2026 16:55:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 26 Aug 2026 16:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787777708; x=1787864108; bh=QFNzBDaHGc
	rbEUqQzXcbWnEIcMHNgIDTFBth/DPBQrA=; b=h+2sWI/c5PwdWWwttWufmXO8ZY
	BNJhfd+Xlz8JZEv0KIaZ7RdP04LwOa9FfQxznbEb7jY2IpImkG7pbbi2IdtwnNxK
	jxuRHxkBvBOhlV8viYuw27lfA4BojKL5f8LeFjKh4mdIKZt2QdWRL65hpTg61e/w
	QF3rNqQYE1NT6uXYd5sc8W6hq+YMfQWo5iIIr0uTfCalhVitF/kHRfa75pDbDuth
	JuOLb4U9aa6hikCS17fW0C/ix++9dIC5Ktl8r4TBashjpcOkcqecRwx46m8L7ty5
	726bJHXSt0sD4Cf4NDy0yHvR57O9+1aGGz7/P926fjNKXE5A7EYYB8O/SW0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787777708; x=1787864108; bh=QFNzBDaHGcrbEUqQzXcbWnEIcMHNgIDTFBt
	h/DPBQrA=; b=K+2Xq5+Cg7BnyZiPBZN9VlntdLLAZ9xPQRC/0LB6GBx+fCMS8+B
	VdNnINHzPi3J6TKISIldPkb9Ph+deyzSsnhLzd9fAccoYIvAma2jQ48vdL5OGRqz
	5uiEINi5WUJECBjp1b1ThdEHiC1wCilVbH+tD8KMRFPdsC47ZwY0YDsuD7McSKmy
	sqYqQQ6/o93Jm9m7lEHHZBbQq6NoqK30QTEqKNa8vMceiSEnwS7WQrm4L1YFvcYT
	XXgXfFYdP39yOq0egE/8yjk0s/paxZy8NW8yc26VbLQNN+Gevb7vN0pC7/qJLgS7
	nbQsvRIDthUZBI0YTWiu1Fu6bX5MytyQdDg==
X-ME-Sender: <xms:rFKPajL3X6RlQue8QP1AEpeoiuIZohVUMTY_hd3uETCRrvfMruseMg>
    <xme:rFKPan2augFevPkJVYa-KEuxU1sS9f5R2ZvZNluWoX-dAY8TNyGk2fGcuFvwyCVOY
    nSDjbRBBFAvAV9hbRzYKg9yhgTRdnDLzrOgfW8Dj4OZNvdUXcQDFQ>
X-ME-Received: <xmr:rFKPap7pMHwhzbSkIp02ZFSvyTE7NJMDOqzfNCHHBcTqudOlB5PCz3koxS3-jzLZc8u1LSzKENAXyb6j5FBSL-mHqeVAHmCx-Q>
X-ME-Proxy-Cause: dmFkZTGOVqw9WGtNBl3COnZFCYyRKX7zYxjzgQ25ZCBrTmJr/nG+lKqz4mcBlubu1ACZQf
    vI1coCmoOh8X5WZdFc6Wvuo/wlPdaLCJ9x8UjAfDzYzJHXHj9w0ACFWReb+KuR+JUTpKcN
    4Qe2xFco3HbAgKLPgjInZabJkhgh/1McqB17IID0UrIxXF07b0eLu9ce4r76U2aZrp9Zya
    VCltEYWSjxhp/k1HSrmmvdnXKwJ0GH8LePN1BkhLN4jfPmjgbs3hz6qVEbB8VfsDYIiSFe
    y7RHzM5cg0x8DhwhkhCJ8g6dUtoI073ouJCSw/fkvNEAcKSh0CJ1iH/ifM4kgJGAUWmXRn
    0fPqVpB5XvlUDNeqVRtGdXFN1IxXkT5Y6O5aNzTHi1H40xEBYCYiM2WGo6YxFNT6rouive
    STgNhnK1PLegrkoI0pDngP9QbU/biSV8c9FGLzg+bANIy4In36dPmowv47eK6iyijHw/VP
    g8HPxm2fvYvFMNZ3qTIxTG7Fti00kA5WfUJAt+gf1F6YoySiQQu59g+ldNKMSGEeVj3dRA
    9q8e6nK6qa7vHU8JUaPhr6s3D/p6nInJPew7u0jl7RE+lD8LJgri+vjHKvwT0vtmtasehz
    /GCIhubLByCptzrmkcnjXwloIVvDf/XkU1U0GX6vnhZcmkEC6YcbFEzKZupA
X-ME-Proxy: <xmx:rFKPag_MrIZ6aL8Hkq5xb_TQjeIohBlzF75ixSjA0Za38RFtBEe3ow>
    <xmx:rFKPagW4liqYLrsaLjbOCFLdJ_LFqS-JVFSrwsHyeADD80rY1FHc9g>
    <xmx:rFKPajrThRQRiCgMEhTu2MD8wYZpUtDYHceLlPOjuD6RvUvFkQkXpg>
    <xmx:rFKPaqnJxZEyt_QLToU33r66ssmw2gBgNPUufcos4y9ktQvbYfglpA>
    <xmx:rFKPakG7CNw4Y1-cS1DNTgQwvSFE_zM_dYj1zPcm9yDwBPCWJm_3d_gO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 16:55:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Farid Zakaria" <farid.m.zakaria@gmail.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>,  <git@vger.kernel.org>,
  "Phillip Wood" <phillip.wood@dunelm.org.uk>,  "Elijah Newren"
 <newren@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v3] sequencer: honor --empty when a fixup!/squash!
 empties its target
In-Reply-To: <DKJ2CZKJC6P0.VHLMCUDH6Z44@gmail.com> (Farid Zakaria's message of
	"Fri, 07 Aug 2026 15:26:57 -0700")
References: <20260711-fz-autosquash-empty-v3-1-d227b63eb511@gmail.com>
	<xmqqh5m494yh.fsf@gitster.g>
	<7a1e5111-185e-4390-afa1-c19908c9bd86@gmail.com>
	<DJXL4KSUEAD4.1EE4ERHJZ00TR@gmail.com> <xmqq8q6jhtws.fsf@gitster.g>
	<DKJ2CZKJC6P0.VHLMCUDH6Z44@gmail.com>
Date: Wed, 26 Aug 2026 13:55:06 -0700
Message-ID: <xmqq8q5seh5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Farid Zakaria" <farid.m.zakaria@gmail.com> writes:

> On Thu Aug 6, 2026 at 1:32 PM PDT, Junio C Hamano wrote:
>> "Farid Zakaria" <farid.m.zakaria@gmail.com> writes:
>> ...
>> It has been quite a while since you received a reply from Phillip to
>> the quoted message above.  Has there been any progress to share?
> ...
> Sorry I let this slip. I was waiting for the work to be accepted to
> avoid rebasing on top of a moving target -- I am still a little new to
> mailing list workflow & I have been using b4 (recommended from Linux).
>
> I will pick this up again soon.

Any change of plans or situation since then?

Thanks.
