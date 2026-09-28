Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04685453A4F
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577849; cv=none; b=faPW1TJqCemrDlWJXdo2x+ntSqMUJLD9ONKcrGXUZpw5cAHtg6+D/113fClROeTiBYt/Pf4ebsXfl69VLa29dGvlJxnjloogFq+uaXOx4gQjo/moa7PYNj90//y/nCcg4dhDnkIL9QiP5p+UosodrczlmO9lSWIbu6OOb1YHQyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577849; c=relaxed/simple;
	bh=dMEfaaX7LNw4Qa5lXn7WHbJWxg1BuTJ5SWcSwoiqDvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LURlV26jeHdE05X9OgVO38ukugYl/f5ef5oQUphZkXY3mLWojPOTejYGyvLmCI4rMcRJWaoxL7MtyZ6q543WZTZ1KxrdeGVkFbz8aGSBRW73RtVcmxqmygBhilcWbf/ggm74OCu6xEJU1V2vffc52qjVcVtIOrClGvGbBsfsk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NnSzvCCZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E8zar3NK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NnSzvCCZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E8zar3NK"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 09056EC00D4;
	Mon, 28 Sep 2026 02:44:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 28 Sep 2026 02:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790577847;
	 x=1790664247; bh=2Xbb8uIkx6mpKqaTeIAE+aXLe0r9EkOSUfPYgrCglcA=; b=
	NnSzvCCZSVTR9/LDQQF8Hl8LjCRFCkO5wefXmRfgdKH2R8/F4tYp44IHZjy/zKcD
	bihGOQHKTiCPXuk09WYMPbYp4Tka0XO8EZc4VKQUPBhZbr3FC4f80iq5x+j6cdC4
	Puijl5y4i1/dBEBN3tkhhWbjjfGO+8gBcsUsH5gz7t6dLd78wlD/INuCibIYLe9c
	4X+sRtVRlDXJ7cuWO64eQwgfaa7EJn1Z+3ck2QVDg6lx2FMdwyWbkXOO4ILwzQYS
	VkENN2cBY5wGFeU1oPj4ROj6Sqde3HM4Q6ZAa+aNaZc9Ek6yKCnagaU6/E3LkYr+
	bFyJA4bV86wPemH9UfKTbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790577847; x=
	1790664247; bh=2Xbb8uIkx6mpKqaTeIAE+aXLe0r9EkOSUfPYgrCglcA=; b=E
	8zar3NK+NYV9ELjETDpp0cvvW7fthea3NQRbtJxD7eE+e70PvsuXusqsmZ4hY/Pb
	XbV0sMnak0FDenevmTiuiFcHk68TW9Dmh+ynbdAtrxWBfES9wW6Islu8Cwdpu/ba
	eTfWxzB6PSaZ+1hbvl2wb1QGIcJ26flOM1yuAc6srzWXuLS1w9p7DwcwRdqmhfva
	lVgm52q0j3aAGHfH8+nBMstVcH0yWjhqamTbMFPn6D13HSDwvhSzxBfKDwy0Lax6
	+2kMQvTiixd8/fkJE66xug3k/fSF5CTL8CyI1KEcvwVOCGj2wE4ko8AX/OsipZYM
	v3F7CfWqZd0bZYPggBhtQ==
X-ME-Sender: <xms:tgy6ahSyXavi5Fo2L441nP5NsvZERQOeE15fxnuj-tsn8Uo6vXvHmA>
    <xme:tgy6ap3FuzX3-bN9wOAXwWphr-jYkDUwDYmSGUkTQ8-VeqfEAfR8cd-mQ6VlukyZi
    vuZBIoKMJhkHi-OX120C4YKgoL7W0XmA0Hb38woSnrAwWEZmqWYWPo>
X-ME-Received: <xmr:tgy6atDvxnr0sIMuj4qDdxX3710LtE0VjOv4m5niY6N4Xei_V0pm3w>
X-ME-Proxy-Cause: dmFkZTEWiSYKmfwzFhLnyFYEhCHRLlPw3VP7N+FG6QQHA4BZ/bPQNMcBUBPXVN9azxVqmt
    UewGANeiRE/409yr69e4qf9DkFo1wGwhHRxlptYz0Q2KYtJse+avkFLldauiqS1R321reD
    hGwfatrMXuurS1IGkn8Lv6fGlJzNcCbKEGZ7AJLEfBR8vEeD7jpoPv2YEFBY0sGBtPyCDk
    0eA0CF0sbEUuRQtQJXuZGP5pmjKOJoxmbCKKAgdyRjoofSWH3Hyc9icWLmFmD0G8bQ4eEn
    aUxTnyt+eWKToeE9SnuksqS60qlCB/SdVX/+5crSNSWdJHuvFA6rJhfBgFRnJkJ4frDnVD
    elprCjAMr//FXWupoGAR2+aiQotmyZIRsHFpm0SqPzA8SjMYfDii664xUpJcwLhZD/JXZ7
    1iCNi+PnRo1JxQotqcWisZFHUAPvnIi5xn9VSX9MwNOQnNkNFGsJ1YU4y6dOivdtPWdTiK
    HsfcNuxX5kXPcqMlGMONd2sK1kYUfuzs6Y3pqQ1oF0FD3Q0l45oLdArEfVcoJEFLRIXaTi
    FfVFHzsUTSH0TPwdXZ6gf2Ks5Sz07eULGrx70LBdfitWhLHiEzrYa5+T+l9srcONbLb2kO
    /iq27D/xdCFjr/SH7DMupbvMhee70HnBkromYv2inhGmQ9Fi/DOkA8p6q1PA
X-ME-Proxy: <xmx:tgy6algZ0ur1urLLPPudWUWZ6cWEZ66iKASQYpvfNIKgAtWbHlcADw>
    <xmx:tgy6avNomJOYr08A4nswrztKQSH5eHIJL0mPEbnyXcTITpgX_pIW9g>
    <xmx:tgy6al__6iCp7lfVlBGSHUkwMgG8wWYo6x-AB28S_450MozLAH-1xQ>
    <xmx:tgy6agdm1XVfyVvsw5RVyDq_rkdARss0Xea3M0MHOPQqxpXf3QjeHQ>
    <xmx:twy6akR7n9UzjWzHpyoaesm02261z7yHxdLbWr6yHSW87PDSEFUFrsyM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 02:44:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3bec0a23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 06:44:05 +0000 (UTC)
Date: Mon, 28 Sep 2026 08:44:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Phil Hord <phil.hord@gmail.com>, Elijah Newren <newren@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v5 1/3] refs: allow callers to supply old OIDs for batch
 deletion
Message-ID: <aroMsk9VdUm8u8nb@pks.im>
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
 <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
 <9b76cc2c40a2b1fe727677a9400e3b26ec1ab437.1790196627.git.maciej.ciemborowicz@gmail.com>
 <arUEhkuC448hUTCw@pks.im>
 <xmqq4ife4mzc.fsf@gitster.g>
 <CACQ=SRGA5j9ChJ0uM4=5iCwEDgWQEdhhrD8OF9=RJ7XBxqb0dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACQ=SRGA5j9ChJ0uM4=5iCwEDgWQEdhhrD8OF9=RJ7XBxqb0dQ@mail.gmail.com>

On Thu, Sep 24, 2026 at 10:13:33PM +0200, Maciej Ciemborowicz wrote:
> On Thu, Sep 24, 2026 at 6:45 PM Junio C Hamano <gitster@pobox.com> wrote:
> 
> > "callers cannot preserve", meaning "after deletion the values cannot
> > be read anymore"?  Of course, but then callers can read them
> > beforehand and use the stored value when calling hooks later.
> 
> I meant that refs_delete_refs() has no parameter for
> the values its callers have already resolved, so those values are not
> carried into the transaction and are therefore not available to the hook.
> 
> Patrick's later suggestion to resolve missing old values in the common hook
> layer seems to avoid this API question altogether.

Yup, exactly. All users of reference transactions would always supply
both old and new object ID to the reftx hook without changes to any of
the callers. And I think that's a sensible change to make.

Patrick
