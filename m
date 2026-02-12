Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE72264B0
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935639; cv=none; b=M+RLx5wyDdw6edEdppPFHJqNF2238eM44wujnuPb3gZY/JEk15sJGcoPUjtFpXSBYiXcEyM1fk85TVEQG80779mBlNDV5pFAHdDOrhAjPoUSOrH/SfPOizjJe7xs+mnAFCLgPqdgenHEs0+COBbvpnPabuLFLMrNh1EENcCQY2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935639; c=relaxed/simple;
	bh=a2AkdMNNoxIo+jBqZIRNEuEJgjAeYOu4t4qDdJsJdW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DJJA/XdwVEPy+A5HdpPtdgHo0v/3S7Ok361qtSnSnNze1KL2bR/HAGs9Uu7nTTOjsWUeidCacnLkwdGeS6yH1JVZb1cn0KuWFkzdi/F9WGxdxObDYMGGK97pBg1Pft/s9Z4wUG9RAc6vQ176kvZU4zaX7oI7VEMou4+XWP38MRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Edj1mfMN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X2vjCCmM; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Edj1mfMN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X2vjCCmM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 696047A0049;
	Thu, 12 Feb 2026 17:33:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 12 Feb 2026 17:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770935637;
	 x=1771022037; bh=D0147QJs5M8fUWJDn4WkdCdeGAlEVydDwf/706f/m7o=; b=
	Edj1mfMNEBf5tvtndu7dWKYcTGCsAfrPkrnjCWKMaAGhLtN156lgovkBPhyIl1Q/
	ZqemiqpRUhqzlSXF3PcP9LYwO7dz/vhjwJGNkg967V0kzhjRMNLDP72Ak7tkTu3E
	CUQghpSxfJrY1NcqmXTdWER7ZJCxRMk19jr2gVYkQRuZd9sonNApo3gvgislVgoS
	6vlGDOn/aRnQTGAzzF0q6KSny0kRU3XmpvLn+oBcwWNgdpSl9pcoQVKQxxV7DaJd
	nFBDTDP/ARoXmy1+0J3xAJYvHTljH5b6+BIdoJRRYOV5ApTxNlTymo+wXpz57nx7
	6qyKo3U/9e73Js7R5TfCuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770935637; x=
	1771022037; bh=D0147QJs5M8fUWJDn4WkdCdeGAlEVydDwf/706f/m7o=; b=X
	2vjCCmMXibNHACz1IRSX5V94CBY+Y5QGas+rlKw5SPBOVb3g2KRO6ACV7fiwgIgG
	GQ/z3YE10riWhgHaL8C8k38AmaPvaGM9z0hV9kbd6mt9uJMBoMqRma0eZZTb66Wd
	8tqnuf6nfvot4WfBFC0Fgag0XchXr/xl+Dpw0wQ9v280CCmyBwTd9UBH+fWFRYYB
	KsT61ZRMGY1P04SRT0nfbXIBn4WdzOWSgRPLG1CPqN/gs/g/0S/39VcMDCYcwJ50
	Um+BtTplT8vnFsjhwCWOQA7iYuKXAHya1b914SVVIQB4+K9E4FaZy5M9sp816Wj9
	tVKf9o9A2QdNqH2GoT7qg==
X-ME-Sender: <xms:VVWOaXqBjhvJe1p9lsHKHs8VE_faTygxcOvzGb_z4a15NXW59bqzzg>
    <xme:VVWOaYp9p08iWvSCeej6GST-sAq7fbmJCmolhTP67E7CJAUnzVNTmBMYH-RqWDlMX
    uQfJWUpyMpJAOTi394V24HJP0XJkkHI-BYgszmtNjH0p6xcKbV4aA>
X-ME-Received: <xmr:VVWOaZN9PDpd31ElLJaFT3Q-L3I_IXQAzmCNTkLOx87hMIAZAT92fFbCbT3yloOE47_d02nk0-HF-_mHFgFsv5HPOSimNyqeMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeiheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VVWOaZyXNzsrsI_BhQvVsKrAnS4-C5oVJNOUJaBijHFoWlhg3_tDkg>
    <xmx:VVWOaSvr8uGTiFo1iqAGrwHKyBZ8RSiVtrDXAoMRCVZtkGWSyyhteA>
    <xmx:VVWOaS4R8dfBWfiOJBrEQEOE9YBwQTnfx0XtP46NiB6nrXiSVJvN7Q>
    <xmx:VVWOaRS4ZskIYNTCg4jV-S7E8h0B5m9OS7Di4SvSVzwo28ksgwbzNg>
    <xmx:VVWOaYs52s64WOeRCPBqnQslG_W3pvI1GOEPs6DGffJkcicvK7CqO9GL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 17:33:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] CodingGuidelines: document NEEDSWORK comments
In-Reply-To: <CALnO6CAjd0vbi0S+giYBwsyQwFmSZoWUBQMKiUEokCEeaNTnrQ@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 12 Feb 2026 17:22:05 -0500")
References: <xmqqms1ft7il.fsf@gitster.g> <xmqqldgxmzbj.fsf@gitster.g>
	<CALnO6CAjd0vbi0S+giYBwsyQwFmSZoWUBQMKiUEokCEeaNTnrQ@mail.gmail.com>
Date: Thu, 12 Feb 2026 14:33:55 -0800
Message-ID: <xmqq3435mw18.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Small nit:
>
> On Thu, Feb 12, 2026 at 4:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> We often say things like /* NEEDSWORK: further _do_ _this_ */ in
>> comments, but it is a short-hand to say "We might later want to do
>> this.  We might not.  We do not have to decide it right now at this
>> moment in the commit this comment was added.  If somebody is
>> inclined to work in this area further, the first thing they need to
>> do is to figure out if it truly makes sense to do so, before blindly
>> doing it.
>>
>> This seems to have never been documented.  Do so now.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> The opening quote '"We might later…' doesn't appear to ever get closed.

Yikes.  Thanks for spotting.
