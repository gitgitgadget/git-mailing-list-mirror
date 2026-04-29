Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B02401494
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470118; cv=none; b=DPDHF+jj5hIqGWm7yZgU3qxDEx5o4Ikfptn1RHSxTZUPF0S2SWubOfZnh6LlrUKIAyz+2CYbytVQP8ActhIw2+4NhaOXxkqbyIi+9fCzowqZSI2ZICUAeciBP/LZQOdTLBYlkJt7MIIiDS/14pXbMsArOMTPMTR+3tgGf9QiYGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470118; c=relaxed/simple;
	bh=ns8xtv3oud6MD99xy390AAI48+widJFnE1sGkwbJ+IQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ir7QA9awAvgmW9UvUhWh8YnR5k/GCBEFeXKos4Qxi7y+hNGgG1tjhtnPWbYbGEqlpGBC9Zqrq+YipXKuMwkrFAIs3/Y6Z3qByHDru91bPyimLwZvOMxgJD1ZNk4vj6S+1AH9+73LR08qIBDX/NRTqiSBnjDnHI2OyZ1Q3zKudJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=E+KKJMn9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KAYlqyrS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="E+KKJMn9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KAYlqyrS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CCFD1400069;
	Wed, 29 Apr 2026 09:41:42 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 29 Apr 2026 09:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777470102;
	 x=1777556502; bh=/xykLJ8TbQGNHy/DKeueLJXeyvknKPFDpQ6CMGbY1RI=; b=
	E+KKJMn9bUcSjjziV6lvH3+WVuCVLRFSRAU1qD5daqkbrIzErulrSv42/NU6nE/2
	CgF+oOed2tzk8Iik6TWYyjh5P/NtgkaK+TyyRYtZelGoo/tj7U5kTo2Il+s2bW98
	Gk1fFnP+Yh42uoCNkQ8xoBKN8n3dGaKZmKMIaycuFL3It2pjYwWHPIZBzd5n8pbB
	fOfta6eEIOHEwRaS1XqF7BmXGpS7nomHUWI8pA8cpECP7sbI+KHgjOL19mCvesyU
	OwoSLUSYHZWoLh8wiA3h4YMHsBt/QGAKAGm4yV5VpxPD2JKRlN77BnU5LPf4LCZG
	AFmO/dxA0OKcNF3dzC1UYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777470102; x=
	1777556502; bh=/xykLJ8TbQGNHy/DKeueLJXeyvknKPFDpQ6CMGbY1RI=; b=K
	AYlqyrSfqmjv0iNMrIuYEfR2HkBLrb0G1NCmHQWx3+NJtCOx/HdofwaQjVEZT4Ma
	Xs3IOC2jQsXx6yuZYNKUSCeOTzHnCVl3P7d8Qvwqk0DNpbkTLRutDNp4UdFsfhuK
	1I7YMRzvkJGXHLC4n4FXiXfSjl4FlbPj8wGX/heMgtZL1IBbApaQqzzH5SfHk7uO
	lrFZnG43Azyy/7kKLzsTpoeJ8tvi2W5PC8Vjd/6BQbo+JFLGNoBKdK4FNi6ARBjc
	g6g7I9ZUBKif/WcFmyjkNdRCaA6fBarGQsXZnS/+Y0nW0KKC1xLtOmXms4R0aX8T
	yA+LObCmadLOB0ity7kpg==
X-ME-Sender: <xms:lgryaTKpipY19y-Odo85hgHIVGhIdnslAWtsHY7SSNQbuzgnmqHiWNM>
    <xme:lgryaR_Ks94ZQTpcM0jTKhrrtpU3Qps2NOU2M1fiizjCSsEDttiaOAbcDG2WdjdmQ
    cyFfe_Ze6BHfbAEnyhgIUloAqKJItI3w0_KUQzTlrXBGiUFccTGdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekgeehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lgryad3AebRACE1M8FHJK2v81kLLA55Pu16xEExtVP8_OWhdbDEh7A>
    <xmx:lgryaSD1s9TTu-cx2XnyhUVVkuR6mdMhh1mMSxpqxmdi4njQCyFgEw>
    <xmx:lgryaVecIOImGTcGuUh_UlKeRN2a25tNKK61AsGO2wne57oz_lgBzA>
    <xmx:lgryaXimJMRiqLKxvj3lepG7kZzUx2b33mWzWjut42ZGu0cSGhTxfA>
    <xmx:lgryaSvH4OxkqeDmm5XhPOr-BCGZx6ALaKsgbYRYaN1HtYxqaTH1tbjT>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B3BC1EA006B; Wed, 29 Apr 2026 09:41:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aq0cXLUbXG1o
Date: Wed, 29 Apr 2026 15:41:22 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <374661c1-4676-4538-af24-0564f38469ca@app.fastmail.com>
In-Reply-To: <V3_format-rev_new_builtin.66f@msgid.xyz>
References: <V2_CV_name-rev_--format.51b@msgid.xyz>
 <V3_CV_format-rev.66a@msgid.xyz> <V3_format-rev_new_builtin.66f@msgid.xyz>
Subject: Re: [PATCH v3 5/5] format-rev: introduce builtin for on-demand pretty
 formatting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026, at 00:25, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>[snip]

CI returned an error.

    builtin/name-rev.c:893:25: error: =E2=80=98commit=E2=80=99 may be us=
ed uninitialized in this function [-Werror=3Dmaybe-uninitialized]
      893 |                         get_format_rev(commit, &format_pp, &=
scratch_buf);
          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
