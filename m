Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACBA2D9EED
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159414; cv=none; b=t2AhQtB/XGMh75je1jwIW26e4t8RbOLpEtIZAFSIWPLQUkV6XR4K3A4Y4p6fvEUVFJYSryG5fp0enQVgupJklQcVjmt7TOJ221zvRoJIFdEwGufKzhLkLkBsmS36ZJyEuevmuFvPcPh3YfvHJLMdMYcab2OKaG0h2sazxXSY4mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159414; c=relaxed/simple;
	bh=f7iW3R3wddhdoYvl7bdUti9SVLx5zADb4Zi6ntoVjDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzhBvwWq0YpsQUm3vRy4vNKH5Dkf0sHCiZ2gymhVio+YEjgiTAafcMEwgqoWuVDnzHuSZG/Rzp2wmV2H2EpSwIF++q9WvxKigfY+HgN+yY5WT9oCIBGrrnaruG2YeEmeYcZ3wObh6SHDXk0umRoUBA2dOapWzzdS2OV09k9bbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K4NHm4LG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Onwp0jQw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K4NHm4LG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Onwp0jQw"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id D2D401D00015;
	Mon, 31 Aug 2026 02:56:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 31 Aug 2026 02:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788159409;
	 x=1788245809; bh=bKJUudTo2mWihyqV1TZhKHYEI35Ocq7VgPWv8UJJ1rU=; b=
	K4NHm4LGOrdBcQKp/q1BJVCZLonmshNAmaTIw2rYc2/LTFixvExt1dBMCyoLvS2T
	oV70wvL3M9VzYI8RYvQIK/N8gIfLsF0ieutsHPu6opQda+m6LvDu5l/xxuN0Uetg
	BwqCkRH03Fw5XZi5BsfPDZ/0fqiDbwj8uLk0VSeg4LVXKRJZn3fKLjDanKU2z27W
	lWNQqS00kK2OfyLcSBGoS9OpxwZMBo8lw9KLERf6yG12yR6DN6SgDtbZac4gXjpg
	3T8GG8yzDSeqklkBd7LZAOZqd5FSLRc3iK0fJOEegbAnxhvccJvZ81qJbfJFb+r0
	uje+qTp5LNH66jVIaEXfHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788159409; x=
	1788245809; bh=bKJUudTo2mWihyqV1TZhKHYEI35Ocq7VgPWv8UJJ1rU=; b=O
	nwp0jQwpl8Njos64gm9hcOEJPu/9sQC2AyzSqk+2lBQC8G9Bl6NkGDnxAjLOl4n7
	TyoKqrjFU011L4pgA0Kh7taLehpPi8PegiqR2RQNELPIkJbdkmO4TIbCU1bmCren
	vwY8ljM05Wpwfcl2MLC6xZJbluT5i/dKV3XSBj//ccE3Y6IS35IFRn0IUgKCV0xR
	Y+8F7kTcfR/KHjOKbnaRnZOsNHSpotI4AYZM4LnYtZQfZCTNFL5vbxiSzuiYxcPB
	S5wCakiXsnbTBhb11EvEMzVk9OW4+MSGGuHa8USyQgOjpfbsUle1z95mmpS0GqLs
	Gh5sIpO8YSfVq021pJ5uw==
X-ME-Sender: <xms:sSWVarrEiHjkJpaSmAcRBlX6tPmjd3-BEew7OYMo4vbVRGFy4Voxfg>
    <xme:sSWVasjFn_XzNMml1JVTFCWHlZDZhJX50o2emD0OQ4E18ikn3NSrEgPRKO00d-YCf
    50H_p7_yTzUDvKIeHgmlYziLprNOz6RnD06wNlWcfLZ0fxKI6gn_nE>
X-ME-Received: <xmr:sSWVagh5K4jMQINDgluAAccArT053nSDCx5rUAQcr4ZpvOvgclgnSApuN5QyyU1laPuYng>
X-ME-Proxy-Cause: dmFkZTGHmg99h4TEqeOQFfRMGmUbo3kJAva4nwuxfggDbLD8ZXDJy2lw7wZdsraWq7VjXz
    GsABxGbnt+h/Yc6eP/qX2EJhf8L6W+45KLnIULB5/9s2qdpOhS3iMUHU71TmZfZ1lZHSIW
    j+pNzMZ9fGq5WQzHzgDLYOVjzTPrHwB/+jCpZIKoyXPj3BAH6+nykvzOsLveOXrV7cRNsQ
    nPSQAWqgBO8PJNYc4AopEL86usA+yWRM8zoAOXI+iJCkBFYMAtAaJdW4fR72TLSYTo/ml8
    J6Vs7b37ygQCDw6O82NOYuMzCyKPUPgyKmuZ7ZS/pF5pDs+0rMQp7qjUwuHzMxKtzTP8qM
    GFh2euJLP1jP+bYyx7f73ko4ksNt+HMEWNTbCNRVxOqt0PmYnOkPBfkAMiVyjFH4QdIy0y
    k3/BrktMg1pGLh8hgADcFgGAy2C9nyGXqHUdVfoO/BMbkMlQXFSIeYwBp0CQ0pLr/+83Dv
    qU1UarQippOo578aR3T/MDymYuX5S1HIxknLJHnRyI46t/b37+XmOABrhFUIcVFCsivXnu
    h8HSp7PDL1I3PYifwuL8DzO6nTihYs/NkbESMY9EysBkCRcbKlvfDrtq5g9gWyJGY8vDP2
    kzLzF4d7DBqE8IOaGMLb/VixLxar9WDMl8yuopsX3I3Bz5IvoHglra3/607Q
X-ME-Proxy: <xmx:sSWVaqjiQBKCfs4A21_YMpArNl06tmrYLXrnKfMaGJedcvdI5bKBEQ>
    <xmx:sSWVaoIuOekS8HHGPQ5NpvRQzWn_H9i3-2XtUrFP_aiwJiVHwsSEHA>
    <xmx:sSWVahHz9UwQBX42lBmHrpVltIuEKd-ec6KncYg9EceTtjG4e5ldLg>
    <xmx:sSWVakQM_-SVkjwIXHubHwahNCLqxasnRyTKyc8ley6ca4vqnjXtLg>
    <xmx:sSWVarDrPNrWpkGckkP8hTIwU9z5nwlQcsqGPddsZ4hEHdqlFmSqRZHG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:56:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4b96933d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:56:54 +0000 (UTC)
Date: Mon, 31 Aug 2026 08:56:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Grayson Gordon <graysongordon1@gmail.com>, git@vger.kernel.org,
	peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v6] http: add http.sslVerifyStatus to check stapled OCSP
 responses
Message-ID: <apUlqvXgChMeCUkp@pks.im>
References: <xmqqmruqt36l.fsf@gitster.g>
 <20260818214858.65122-1-ggordon@gitlab.com>
 <xmqqpkz4czhu.fsf@gitster.g>
 <CALgUfNjd_y-e-zTKJ31o8_bQuRw8wFWe=sdsf2KJ7LOmmO21aQ@mail.gmail.com>
 <xmqqld9q40ww.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqld9q40ww.fsf@gitster.g>

On Fri, Aug 28, 2026 at 10:20:31AM -0700, Junio C Hamano wrote:
> Grayson Gordon <graysongordon1@gmail.com> writes:
> 
> > Junio,
> >
> > Yes, I was hoping for clarity on how thorough we wanted the testing to
> > be. Patrick added a lot of great stuff that I’m happy to use if that’s
> > your preference, but we also talked about wanting to keep the tests
> > succinct. Please let me know what you feel is most appropriate.
> 
> If you can keep them succinct but still test the essential bits,
> that would be great, but I am not sure if that is a great question
> to ask me ;-)  Patrick?  You said "not 100% sure given the complexity",
> but which parts make you feel iffy? 

Setting up OCSP is quite a pain, and that is what made me feel iffy.
That being said, given that this is a security-focussed feature I feel
like we should probably bite the bullet and verify that we indeed know
to reject servers that respond with invalid stapled responses.

And given that this whole setup is now getting more complex I feel like
it's worth it to also allocate a new test number for it.

> They do look involved but seem to cover the situations we do care
> about, except we seem not to test when the server does not explicitly
> say "this is still good", or am I not reading the tests correctly?

Isn't the following test covering that scenario? Or am I misreading?

    test_expect_success SSL_VERIFYSTATUS 'fetch succeeds with stapled "good" OCSP response'
           with_ssl_verification git -c http.sslVerifyStatus=true \
                   ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
           test_line_count -gt 0 actual
    '

Thanks!

Patrick
