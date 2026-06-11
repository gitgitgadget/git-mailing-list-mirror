Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADBC33F589
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196301; cv=none; b=a4q6tSXR/FfC+5+F54FmDAc3fQYXpcdjpGc/YQH881ArWZKZPn4I/S/aJe/yvecI5PpMncmFBxnr44GyyUAgumcQr4zQ8U625zCAm4AXbKUuBHvp0J7cQ4idSr+t5R/eBDlWlhmMee0GPNhhcDKt439B34um6r67XSgk4/VBUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196301; c=relaxed/simple;
	bh=DviM7Zck08kEUIBwZpQz912zGPhzRT570VXfjMS3MyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OYp3PePBFXO0kl/eyX0ePHTbER0uM8RBiaru0ccsrYrokLtLlzboZOI1zE9vs1a3nQxfxg+5xZRigSe7+pPHS842F+c/TEYuc0UqA58bMCCtb8uG2NQkKn4dXp4LFoKvpW+IT7sEDRVt/ItQcMD9mw9MeDfhUwGBr1y07SU/0Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kRJqotPr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KRnAQV5S; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kRJqotPr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KRnAQV5S"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 404E4EC01CF;
	Thu, 11 Jun 2026 12:44:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 12:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781196299;
	 x=1781282699; bh=Q7Y3cAqeW0jwGKBeKEgFuYsZYiuMpNHcRdGkSqQG59s=; b=
	kRJqotPrOzwN0QllBOit4gDFSMy4p6TUeEkVJhoXVCXcqN9iwZeyOEApBwWsHvn2
	jeqLPExVBFUCOvm5ZyeYwboAEpK5iiVgjDlt3rzq6JwdHGVXAdVZ1+aZFkBPMusZ
	Iujq2AiNV/zLmFOjx6m1pJ0OmhoTvzxYVPAIzOnYx7QyxlQW2I0mAPxzTrNuCrD7
	wGIlJGmQnmea7CSNeF6izpmua4Q7Py+FWOv0PSg0FZh92n+jPmU5sIkqxTo2CWuc
	CaS1WAS4jbpAR3592L0poUqJxKJ4l9z6cmAtsgp4qjI9DMkqeU06Nye0Z8EB0CHw
	QJsv6NqaW20DzFC0Mc630A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781196299; x=
	1781282699; bh=Q7Y3cAqeW0jwGKBeKEgFuYsZYiuMpNHcRdGkSqQG59s=; b=K
	RnAQV5StOtrqisRcilTY6nKHNqYBqmacPml5lLIcvJnfZ6ioF/0hRH3cG6TZUSNB
	yL/MqkyUqFYvhX9D/ilRC1trkay2/boPVFmb0IM56Z4/I0FAHhZnLuNT+w12EKTT
	q2ChOKtjvDH+b2hxU5GeEMVh5nMzqIXkdEj5lPLt3y2dMbbd9YAqqNFTJw1LqFUV
	eyHemmwPlG843rfSMzsGUp5NF1JnJ3p8pUhZH09lu7+3hqYRONizI5JXAK6nUOME
	pjbax4zCUwjeXca/v+rBuj6aJxtW9P0nSIKCa35WT0ESrEY93hQqlztoA9V0I0NT
	xIwbnFKm7qdPfftaw/gwQ==
X-ME-Sender: <xms:C-Yqak_NvMv-oEP0jbuGp_wS3CIknE6AAfY91iY2amw9vVGL-bShbA>
    <xme:C-Yqajsl24n0l3RFFpw84PYv7U7S2RQn6a51EgVpuRJpMW-On3IosVSxAPpRXXhWG
    RbqA0S6diRyuffcleNYZaSrZZmEI6T0JTGwl4vjHArdhYofl0NLl5A>
X-ME-Received: <xmr:C-YqavDpD4Ac1YPjm2lqlhB-c5lKDSvKe64RRsT5A5Dg8Em-EcW1zFQJjUf7p9vkEAPLw-8hs_jPA-cTG3U8a9n2Ukb8NtUmAm3L>
X-ME-Proxy-Cause: dmFkZTF7qwc7IdQlhLXksQY/6LixHtxNCjZMFV64MijkLwYXvaRgnKogLgS+riR3uSxhs+
    aCJVisuzf2sFsDeygwuo+UrRFaq80cf9kiSobavUnfoBPV03NXFV6LLLCv5uJmbQRjnP2S
    /QkH565pibD4gDe2e/sBIG2KDpQLMND+xogKblbLO+KbRyt4AjnezIF4XQ7b6Q/JKcoCoI
    QNu3HW8vTbRBjSyRPFGHaaTNlERSlP8q9n8Ui2k4LxnJYEsH+29S1/3veRUY2XhOdD0OVX
    VnuBPKdjJoQn1MGf7IoPcW3LilfAh0TdvYaxKGw/fxJHcyVGA6qmBa3+l7VTar0DcffOFH
    menk2+3tNJj3+Wbmva96olaG873aPdOkwxVUM5GDZ/SZHIXI9NYSIMW5vVVXdW/pHh/4mr
    7EnYHZIeFc7oRrOmZcZe01skruc+2neL6oO4OLX8SwfPo2R6ZdPTlQMYykLU+kWWZJbqhE
    SNoKYCeY9bl/0Quhy6Gn1V0K52t+MephcOARQazn3eqe7w7pFne9MIlJYntIeiWxUTk6e4
    +mN/hLVvHFWd9eATfzM4LwLsp1CGF+xexa8RF3CeL1VfDP8rIIhxy6bH9rb8exWd6AkO4y
    NEqHzoaO8+qKEY7kUt8Oz1LBVxIJQLB1ACvY4WAYI3i2DgudQbrcAr+rPgQA
X-ME-Proxy: <xmx:C-YqajVJVHXJ1WnU4L0ah8_JYbJwpH9PuqOjFdj9Sn-39aBPtawprQ>
    <xmx:C-YqalD_xc6b0hMg1QmE9n_FM_49DKEw6nEEiz8U-Z5Llvqjox7FMg>
    <xmx:C-Yqau_iBfprEbSuyArFuyUjbhNfYVGt5MfBi6hdDHOp2UJp2O4Ing>
    <xmx:C-YqakFto7w65E64YweE9zVAwUu-DN-m7Jim9ZmCcrD--AxmVx2C1A>
    <xmx:C-YqaloWWVccGZQurOCL_pf2Bw1aUo5uRd0tw32tvE_PlLmz0czG2A9y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 12:44:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 1/6] SubmittingPatches: encourage trailer use for
 substantial help
In-Reply-To: <encourage_substantial.8f4@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 11 Jun 2026
	00:22:44 +0200")
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
	<encourage_substantial.8f4@msgid.xyz>
Date: Thu, 11 Jun 2026 09:44:57 -0700
Message-ID: <xmqq1pedowl2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> Let’s replace “If you like” with outright encouragment in this section

"encouragement"?

> At the same, it is important to temper this recommendation to a sign-
> ificant enough contribution; in my experience beginners can be eager

"At the same time"?

It is a bit unusual to see a long word split at the end of a line
to line-wrap in our documentation and commit log messages.

> ---
>  Documentation/SubmittingPatches | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

The patch text itself looks great.  Thanks.
