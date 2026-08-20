Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA6437876
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226025; cv=none; b=BVBMrj07iAgj97HiFy74bGLP3SptJGgPMTuQRKojeK8qiSMfUt5qUNc2mJ3SP3vPo9HOS5UZ8+n9fDXL036rWwmyl8NVUwIlw62G+D3221CpO6PUIXQpH4gDySft7984mj2YecgsrWnBwdCmqmcieNeCEMvCIedr91LaJHk3Fl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226025; c=relaxed/simple;
	bh=9K5X7iPmjkkSHcpx5Jc68kte3LBve+9nK66vIoHMPhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o87lxYpqEwSiMfi2pwBJgEPs3jSXuk0GJP3ZG56/Mny/v+U8vjzHl7zAZ5GYXNQdYxk9k8f1DsAiyU7LIj/mq4Y+DXKNyejowxskEUEeMJ//ztWEq1MNgAlNtpmEN4Z68zM0z5/g1xYPaptxeHOhk9YSrBEyoDPXSet8uTnTqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B15SaLCM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fzWfZAme; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B15SaLCM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fzWfZAme"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D327EC01A8;
	Thu, 20 Aug 2026 07:40:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 20 Aug 2026 07:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787226023; x=1787312423; bh=XZ3CWFmm4g
	x2fap1RTHSxxTPDFD4RSzBeqlOkzLu0xU=; b=B15SaLCM2vM7LeG5GPTSeKVjY8
	kwb0gVGW1hJcS4CgMqBmbvT1drwfWFiKCSYgb3ysOhL+KWo3DRkcZgKnM4rbuUId
	qt5sXZJFbeN3m0DraG/WjZjXCJv1qbUuy5wZUcZK7hu6zskv60T7/veGi4YNuxtq
	pV7NtIoHtVMVV1Vo1XI+oHsO6+SIA1mp1jupOdz6o6LcpQm0lFYbNQJ8047UJVFI
	/SsyfRD9Fo3KGwDt3sWqDYfcKccEQ5MwOuCJ4HVFHtgyTkqegz8zL+/pVL+av+/Z
	7GthMolMtGTqHm7JwF7dz3vhhKmboZLNmmuoT9GV+i8nygcLX/srzAPpGSQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787226023; x=1787312423; bh=XZ3CWFmm4gx2fap1RTHSxxTPDFD4RSzBeql
	OkzLu0xU=; b=fzWfZAme9UQi7nUJDjdpfRTbTZaHcJhbpjT7RypeTp0mF04153j
	Fa5xErebx9ah0Z8ASY1EvSNTy39bvxQfb/fj4EDXpcLQu4yyJckj7b+z9z1NMoUT
	K9FhDiYiTFsoELIj9mtAVQXWQ8WRj5Uq+9bFb3DypQitfAQ0RsWlI7VskO0ERnmH
	p/PkpDYesbjT+MY5xBnqEO38ObpZqvVnOBgX/IImFCai+uUXKsgfsRss3hVShxKh
	uOga3wb7I5A0nkp2fmY0+jJzUCJjkZogErqCVcE88qQ56R0C3jcpPszj3zwwd1mU
	q5GnC68g11MyngGlLzyDDN4JwES0DU8KLbw==
X-ME-Sender: <xms:p-eGamcl0iWXc5JpbxNroFKcD4CNshDG6oqvfcDdKIcO_D3Pz8oHlg>
    <xme:p-eGanFdNdCVX7vfVR87Mv9T2WkoxiQcRt2HbAsDQcY0uq7r_-FXZVj0BsLSVU-75
    pfIScQtXHvRmDf9oG04GyFhAlVZXXwWzra61umX0impnMKsKnr-yQ>
X-ME-Received: <xmr:p-eGav3h6l08cv3SPdY46Ii7CBBF4kHgT5ZiDGR1OjQFCflse1p2bS1kEIk_bFu2WkGu5CXFF1BHOEKXq8vV-O4YrWj5vIV76b8W3QTpzw>
X-ME-Proxy-Cause: dmFkZTEEeSpnvqleN9KchNS2UT41H+ZiZUyeKd6upFql4UfXiGeoWuG0McBm+s8i91Cbvk
    1WVsFcfnimxxEd8nuGQEBK5RlEND4rYc/79S17fhyxLJNmgNHuac5hRIrVesxOfmFNW0zF
    FyvOHnZRE7sD5BS2hvNfXSU2r1gNrdyY2twGPsr/820nLYHnJeBtwy3kZiN95zMw4BD/Jh
    5fK/+anYKlDiGklaOuaYTtcL4FGO9AvVJlDWVLvtr5QaG4wZZzLwufyghM/X9MjRd+7YJa
    TXBVHPt+TsBPs8BVsUoVhQ4Pb3al3XU5Vc7kNCetlQMnGYCp1joKY0su93uKu35kZL7UoZ
    HBj77v68IRimAU7XIq3NEyRtSl3KNQrwu25bvNAGSmCDOznO7G8zFtMOatRrSEdfKFSJrA
    /15ptJFv5tda0zGcDvi6GMG7XWea11EItH/vQsYuxal3S69w38sFtKZMSBtc3JfT7YVUWy
    7+zxmY0T8PlaqIqwBYfBOVRFmtzpiw71v9EYmeHCMpt7n03GzL9GbXGfIuunhftCoetfaq
    VcE78YLG6VX7wbK1x4OMoEHpGuW+VzSWZmnYmqb17LS0ZR0D0NR7aelpS+Rx9s6q1zNKIU
    2wZzrGfEeHQq+Gt0rOHJjjaG1DFExfgefsUhL0OTXSc4AI2oLxDax9UAzZcw
X-ME-Proxy: <xmx:p-eGavmw6ERqHnil2QYouxhCycKZwtab7_Qprc_ScE010YM32OCTAg>
    <xmx:p-eGav_MtK5bUjQpeXApVZaQZGDq1wy0o9IKJMQm6hBLJ1_k5qZ5kw>
    <xmx:p-eGakq8OPRAlVIDYKou-yfmKBi9WT7LgQ5rkIvBWlbVB_EYOQB-8A>
    <xmx:p-eGaonvwws5h_xtlqz0ByuGL3QSh8QnFRsqAljMuM0ZpZfoYsaezA>
    <xmx:p-eGam2k11gzMPdf-TA5HoV75bSJSVphkN7pZtROpIdHkax0j1qZTjEf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 07:40:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 92c28ce4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 11:40:21 +0000 (UTC)
Date: Thu, 20 Aug 2026 13:40:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 0/6] odb: make packfile generation pluggable
Message-ID: <aobnos_v8xko0w57@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
 <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
 <CAOLa=ZRsVjRrwzAf==SmevATf+OWoHdnHwUbvi1=M6foBRzLnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRsVjRrwzAf==SmevATf+OWoHdnHwUbvi1=M6foBRzLnA@mail.gmail.com>

On Thu, Aug 20, 2026 at 07:20:15AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this patch series makes packfile generation pluggable.
> >
> > Note that this series only makes those parts pluggable that are required
> > for the transport layer. The other parts that relate to packfile
> > generation as required by our repository maintenance is kept as-is, as
> > there is a bunch of options there that are way too specific to the
> > "files" backend to be portable. This should ultimately not be much of a
> > problem though, as maintenance itself is already pluggable in the first
> > place.
> >
> > It's a bit of a shame though for git-pack-objects(1), which still isn't
> > usable with alternate backends. I tried several times to find good
> > solutions for making it fully pluggable, but due to the backend-specific
> > options it's an utter mess. I want to eventually address this though:
> > same as with git-refs(1), I want to introduce git-objects(1) to care
> > about all things ODB. And as part of that command we can also introduce
> > a command that generates packfiles in a generic fashion, without all the
> > cruft that git-pack-objects(1) has. This is part of a future patch
> > series though.
> >
> > Changes in v3:
> >   - Fix a use-after-scope bug on abnormal exit when child processes are
> >     cleaned up via `mark_child_for_cleanup()`, as noticed by Elijah.
> >   - Link to v2: https://patch.msgid.link/20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im
> >
> 
> Dropping in to review the new version, the changes look good!

Thanks! I'll wait until tomorrow and then send another version with your
nits addressed.

Patrick
