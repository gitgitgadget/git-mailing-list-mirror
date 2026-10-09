Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4F3F20F9
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578378; cv=none; b=BZ/pRyBJuhn/l6xsHlAJEe62S9A7SPNebRfFO2vll9+2eMFwfh5poyWaTMnbriSTFF7RWWLx1bY6O7B/VSRVIvNq2ohxRcBajkucAUDQUC685QPm72joh06lWGMd69j4POcwalA/IvagddLu3MrQc9tIWPJf+oBEh1yKbrOQieI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578378; c=relaxed/simple;
	bh=wVlyUTiNXvJgFz81tfG5KMtVYQ+mT6aMJHI+pltgtp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i4H6yodqaOuWZimCgPgq7h1cCsftwT84SrEtEe3rHyjULeyveBFtTssUvqUPe48r8s2OOLqrCy1lN+AEsuGvf2VLPW02e/1awTW4GYewI7XKvGUBwilWAiR32zgc385gmgsB2684n0E5eiMT0XuoFbInRBFyhIyzdzL137alaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CjTCNe5Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yFcmOSb2; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CjTCNe5Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yFcmOSb2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 61A231D000A6
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 16:39:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 09 Oct 2026 16:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791578375; x=1791664775; bh=J+LeZO1Q9C
	xm2FWY4d2tLHK1Hii/QubZanzXHBn+NB8=; b=CjTCNe5QUBxQI2Ws0d/0xUi7iR
	EXPmeFIfjFkNaOhlC9DU07qDAJh8BlWdgbsXoHfg/W4MgOoHz0/dq0uKCFbF4BaH
	leFiRC/9YLqNuqD5cuPHkfe4BtUAujZw504IKFBpXXo7mSspTpUG4TxWnwpJtvLb
	hA36bm2afxpjUOm10ww72UB/eOd3b0QH/0slc5bv28bxbpPtRXiGvJj8AH4WiA5I
	felawJWzXmNwMkg+7CcLfQk9s3jJm1SjXhHgkUr4XOSLNd7JAMbsy7A2j4JbDhAc
	xPkA+MLIGlWPY7Zka0KveXONDfiVBxNssUcuab/aYwnizS535OJUMnHa0gDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791578375; x=1791664775; bh=J+LeZO1Q9Cxm2FWY4d2tLHK1Hii/QubZanz
	XHBn+NB8=; b=yFcmOSb2nM9m0AQdufj5pOW9HoGv7IhOMawkuvIflWKnG6aKZE7
	XrR3Rw/eC1/qPX4oQJtbXsAsLFQsaw5iS7bzplJ80oaBx0lZPf4HMN5YqvUooX4q
	OFg9hQiYMT7K8THUDStfJZOxgpdbpfh3rBBLUJYy581+aqTueS9fXs3OXod0k4Zj
	atV3ButlV4ojsZY7dJTjGXczCE9UB/hfZ+BBmbFO9LDrZcWaFsgcH7L1U/X9BYbL
	E+yEJOJzU+bwpreMTvHHbmNQQEOFkWrkEnl78mHZ9L+hjcDU7hQFNPBSkVpU6PYx
	DXNXxjog0XDMzu3WVYepJlztKIaPyt8ZbmQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791578375; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CVrmZspHkAgmZfho0DazQ0FCnXTq90beofxyLXhkuwvTGqT
	dJL+ePyzdaQIKrSp8qW6y1JfSs8mHbn1xxkUI+pj1QLBl1X3ru6ciKYkF0ymP2lI
	C61vFliEhI3jOU8+mEhEMD+hHNkZ8Q/Pv8sbCs3CiaDkRMbpvJUBU+wEKq1wFiEZ
	/77pc/N3SCnyV83FTqgNdHJYYa1J9l62CPREcFAQanP1G+XMgW+MIYXto9G7OPt6
	U3cZIualJqQ7Xs4uM7M55/MdGZ0PaVBOmia4CIhhAEz/zbyMvpy8ZW6iR9whaQuH
	TY89akDPiDOlTInT8RxBMyyxHVbtmT9wWXQyWFQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:axPrxqXB0M4KPyPkA3BvWD2JkWjbciF+vJT2hS5muK0=:wVlyUTiNXvJgFz81tfG5KMtVYQ+mT6aMJHI+pltgtp0=;
X-ME-Sender: <xms:B1HJajHYX6JueZpqiXpz1H-y8H1a8DsFhIO6XHD8mnG6erRV2jslSQ>
    <xme:B1HJanP5YyW9MlR7QB17iMUP5-qTmRibfjUlekwt9GXbiW1mg7Q0rQjzu7j807tl8
    ZY_lQVKy1qyVOVV1y3AFTe8v70H76BbgnYtdGqNZlnxHd6L_Ci84vA>
X-ME-Received: <xmr:B1HJatcaxRBpA-xWvuK2L2i-iRlraSKC6JQs4zzsyPDn9U1h5daLI1Rbqv_L7QZHjvTvb_U9yu1JtH63h4rFmWbYV1x9kPyY1b0S>
X-ME-Proxy-Cause: dmFkZTFBm9hM3YgNQSkjItsZcpxvTsCAcKI8/Eze4/q150KkprbMcbUF+sOBFSRbdBiVua
    tP5PrAhLPzWrNPa4fjSG/n7NYSTJGaaFFLFF/H0AHeayKtyBZXs3zfkVPSpKRbzcqKKsm+
    rcbWea8YP5Ix52M0U745tfo4l5/NC+YNG8wvWZgzPO9XYSnNJ2jyiWWlNYgZejQY5aac3V
    v6A+114jLCaO5IPYZHG6qoR3dN6eyuja5ClV8aNt0I1Ja0zcE4L/ycfjNKYt5Zd/8bTfNl
    oT0UWTK1T+0Z26Wo3iBYRvbiwVAkZoyTggru+gbKb6BswBpo8qEv8N6KKfHKjedGCGnRbt
    Y9SxQX47ssCHETZIropn6vQ046g/8bgSgLEpHxqVdBB7/jpsEyR/1AGl9iNG2yuvd6DD8S
    /01bSEHnSsBlccgcoj9ZHT4YrzN3SBfg6dxJMkBmK/s5t/UBQ1Ci0FrkRG4CAzQo6bejvI
    /E5RCcHf/SvD/SV2k+wUrrlq8WhTUXmrkuAX1ylf9PtU9X1ODzXiM4kNYfxOfbBPiq3o/9
    +J+MLm6qdNkqlsazH+fcR9K+LfOVHEgAC0Ku3cnWLgr87rlzoQBvGWw0as+kLBPkj00sBP
    2xyi2102+u4DDN6+rBb7MjLkhTbNEcyI5cfHraAXtfYnzrXl737GkHmbW7HA
X-ME-Proxy: <xmx:B1HJasvB3u99A5Dg8U862RN2aJyKDH0hdVOjEyeuFBvOVwEjvoPmfQ>
    <xmx:B1HJammiLiqiEdgzdcaOZ53YllthY4bB4uO4T5yUY5S57qOnZQmHtQ>
    <xmx:B1HJamzWjaYKtwUW4685p1ARh8b6bHFgyNMHoBM3KgqAf1R7IElcXA>
    <xmx:B1HJagOc0gKab-pHL1vFeKrJERxoBTNKyjGJRX2exKPg0d-SRaMu5Q>
    <xmx:B1HJapIjT5jDQLZ98SRyxlmGVEF1eKfhUmjEIQUARKQH1mlrkNKwQOVo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 16:39:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Scott Chacon <schacon@gmail.com>,  Scott Chacon <scott@gitbutler.net>,
  git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] SubmittingPatches: allow responsible AI assistance
In-Reply-To: <asjAVQD6mFnes00l@pks.im> (Patrick Steinhardt's message of "Fri,
	9 Oct 2026 12:22:13 +0200")
References: <20261007142954.31761-1-scott@gitbutler.net>
	<20261007142954.31761-2-scott@gitbutler.net>
	<xmqqcxtl3zda.fsf@gitster.g>
	<CAP2yMa+o7zv=8bzHUa8FRkTaU46BQ3w_ZAr6zQ=rFC_a4cg2yA@mail.gmail.com>
	<asjAVQD6mFnes00l@pks.im>
Date: Fri, 09 Oct 2026 13:39:34 -0700
Message-ID: <xmqqwlrqmwvt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So I think loosening our AI policy shouldn't go without finding
> solutions for this problem first, because otherwise I feel like we are
> just going to make a preexisting problem significantly worse.

Well articulated.  I have nothing more to add.  Thanks.
