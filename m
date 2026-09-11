Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F347FB16
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142198; cv=none; b=fMhWNfYUbBd9sJP6QMwftD7OsPm3CxU1NXprw+UiB9OuQwW4wFg+5uXu4Tpd/K3XxLu9sZFaulAhu+6K97KJgPvNmNy+76jBj/J44xFniysSDrvmwFEeL3+jy2r66lD8c4oTq2rCFRNiecQWRSyOpsDv67cALBE9Ima97ne0Htk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142198; c=relaxed/simple;
	bh=ZePHqQ94ssYN834nNBPvHaeyVCo94OOPkSCV3mQfXvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dHh6mY/bKlv3eDITIa6ZpDXZyXxImW7sc6NLUYEETtWD4iCpZFO3amdNFZ8nR+FLcOhgwnPt2xZwLwjrtDGKgaqfTdBVzPdMerX/narscXWV15Y1Q8GafinKer7IkNZmZU+9qFmYDKHOSzDUOz0Cb59M+UiFawSRqA+NaS5AeFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bwMZhQPC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YvC6aqT8; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bwMZhQPC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YvC6aqT8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 382181400096;
	Fri, 11 Sep 2026 11:56:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 11:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789142196; x=1789228596; bh=fjI7WT6xFS
	FglHwi+2YizaP4Kdf9LfkLoBRTDspz7Aw=; b=bwMZhQPCb8SqOyo/zc350QyJk/
	CH7f6h/Bk7fc8vuPnE2rRxXrfEekXt78Y2FdBRpfGlWJxC0TK6lo1DB2MWIOxC5P
	kLcVgOAvQdbBnOirwD+/4X2oE8VhtJthYyT/NF0BlBBCutBomxK4zxLclBVEbMkl
	SIC/WgNXVXazuhNeKTIBmZjOAJQ7xU+uW6b57hJ++lkwu+5JvZRYn90oWxMBnsqh
	DT5oW+C6BKjhqJFG9bV9YIZTlVnDtTUX/v2XzXBB8s5ZLjKELXk6GLaJgAq5gPwZ
	gJAVVrBHGvVRdQeiH7IRaY6C/FUW8yCFDetxWoRGongJgCOy8IjZE3cECA4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789142196; x=1789228596; bh=fjI7WT6xFSFglHwi+2YizaP4Kdf9LfkLoBR
	TDspz7Aw=; b=YvC6aqT8wpD1q2c1LMkZ1Xj8YlEdsvaKKSIaDLCMx0BhvhlbUhc
	T6ITMYGa0oXnRbxbbOP/pJ+YLIJM9CoA8udvEHRQoygN3YdiwIrNdfsbzJLM/j8c
	43F2Ou8HuJFx4KdW5eNjLYu60+SXs7w/xS8HkK3rjodPW7QhKYVnJSwO2bMxIM5+
	7ifT8eYrNycYsY79/L4B9h6uwqzx7gud46GUAfDFFvIKILfGDEDVhX68XOB9dUh8
	uunfvDeaF4tsaEHblfhH9SovcKTet27CjupWDCgp4tJpITsHaHJIvTj0ukVu4s4B
	KoHQJmOThPRCE5KsVWyBkptB2D/m6embqTQ==
X-ME-Sender: <xms:sySkasB4tcgK5Lyna-fvFvXnB2XOIypCV4RzHPeYg-I0sqpm_CfUyQ>
    <xme:sySkal_hkgJDRKcK5AHNgbLG1wNWesWP8MqUyiKetjCe9nK6_bVLmbJNjB7Qa69Of
    _HLidOfG54OAypadvvrN4pmOUSIseGzvTpchX7Zz1ndik4ZkmqleCk>
X-ME-Received: <xmr:sySkas9XF2mKPK88XvDp7A0aeiAQ9GU2KrJiVTMk1tK2dmK6Zyiip5TdwAVghuojmZ7nwHjQ0FtuQMVhIH8_AWM5Q_8esdifkx31>
X-ME-Proxy-Cause: dmFkZTEQMl9A/XdE2/s/FRTvIvWfHpSL+ET7i5znebxEgCNTaIrzMF+NboMJA0IqBL9v6z
    79qlnb/UwB8GpBuwkvYigZE/Df5PtT5jtslBA8eCp4iXHhUudXKKZVc9zjrnMiRvahlflu
    6/UyIOotEZMqLkpXCK05e1SJgNQIMjslBQ02M7Rqfar91k4E3LQ7zM5+nVpet6s0H9QeO1
    MyMr7DvDwSFzwh1ofNi9/TT66iqjbRH8wUitYavlflnD1D/tHxPkwrWxY8psyhDwMtUo1f
    ARvu7sgVEY/IMfFARbQ0ndpzXoWhgtFl1STHORsxOeIBQdQ1GXqcIv42mk1d43/+wsUFEF
    SPPJNYCXAnST9F4nW/1B58otFeBahtV/0hjA5BDjyW9Tz5QARQKjF50u2CdpNsMjB4fgi9
    7VQ8ixHRv8rxnkjv+jyUkQUjh/hohXJLM10QJfpBu/092KiCkHYsY2cKjIbMCOGm6nexIw
    av7M61EYPWTOkNOLFHqdvlhNY5A9dCSMdc+0v3qoji9WYPnoXbvhkxSlGSy39WQmxXt3Ph
    jR/nR8FMznHwIusRqrZh8JPbyb92dv063RPLsl9Ix8KJI4x/piNBHmR2ixW5qg+00aXOwd
    3RFBMFr6pl9Saw8ex6WuyJG4+w4dc1KFl5eWj2I4B5gM+d8J15mFXLc9ZFsg
X-ME-Proxy: <xmx:sySkasfgchXdTH9-V1sYDqlvvbrQZxGdDHC8b6ublw3JBF0GoFZxfQ>
    <xmx:sySkalH6sYvjcHI_3cGhDYsZ_b9MT-oaEZMfTLVhM2Y7I3tSLVmO7w>
    <xmx:sySkaqfb6WzRxKW0lFK5Tay7o-MMKeLz3rmptlAhFLMTwBmvwisylg>
    <xmx:sySkavGZsTgYnoCKIi1d4bPXrPv5OLN8HcsMNdLN4fMBm3Y_esUUIg>
    <xmx:tCSkaqK9P64c4jHCw6PLr92ZWu_wQH8ruevb-wsgN_OuTcgzZPxG1t1t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 11:56:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>
Subject: Re: jk/ci-use-system-asciidoctor
In-Reply-To: <20260911065043.0SiOV%taahol@utu.fi> (Tuomas Ahola's message of
	"Fri, 11 Sep 2026 09:50:43 +0300")
References: <xmqqa4ppf1l5.fsf@gitster.g> <20260911065043.0SiOV%taahol@utu.fi>
Date: Fri, 11 Sep 2026 08:56:34 -0700
Message-ID: <xmqqh5jvdbnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> * ps/ci-depends-on-ruby (2026-09-01) 1 commit
>>   (merged to 'next' on 2026-09-08 at d0859510f8)
>>  + ci: fix missing Ruby dependency in "documentation" job
>> 
>
> This seems to be duplicated...
>
>> * jk/ci-use-system-asciidoctor (2026-09-02) 2 commits
>>   (merged to 'next' on 2026-09-08 at e7621b4bad)
>>  + ci: drop ALREADY_HAVE_ASCIIDOCTOR variable
>>  + ci: fix missing Ruby dependency in "documentation" job
>> 
>
> ...here---perhaps we would like to fix that when those topics graduate.

Thanks for catching.

> It's always good not to immortalize typos in 'master' if we can choose.

;-)
