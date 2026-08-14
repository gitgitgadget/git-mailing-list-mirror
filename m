Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CBA494A02
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734848; cv=none; b=jyumSUoZWVr3eZMYaHajffnk0VJXd3dF2eE1ftpA9DdOdlHbrEr3rsI93+K1eTcy9H766irA3uGzAhuL6+j5FsC9IGMYlnDjMe5M8altPaLhTtNyfrt/mjHb4NrS8SEymMWWcJa7wSCRltNFh6/O9CCsCcd6xrdWRWU7RJ4YhEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734848; c=relaxed/simple;
	bh=59TQyDZcFmIL80o5Kvbeg4NhVHtXCCXITQuBYTAnkvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KCJkTlFb+RiarNMUaqkTBZKqp3ZgPGZPm34cTbCL4sXGVNklq+7D3IJksa2zMcW3pXxUrTZCdGg5KyHnP1Bw/PsHRLxyRNk7N/F4rYzX/kya19b9bgpmTc2gTgJqQUfZRww7vy9UxyizOjmvht2Wfy5xhx30jpWtSGudtw1N+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nAnQN48e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SMySEyun; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nAnQN48e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SMySEyun"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6493140009A;
	Fri, 14 Aug 2026 15:14:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 14 Aug 2026 15:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786734845; x=1786821245; bh=7nRr7R/NrZ
	wbdmThbNNnUhWQXsqiurFB6jNfpkIMc+8=; b=nAnQN48eCYiXbl8CK4SThm8iwJ
	vWlBFKfjfd2Va0aw5leuarsQR7iY3xhqks6ZAsS1P6A2/Iw4R9Aq33eO9qzyAZPq
	UGe4o6f/JFFlqs0fLlmgvpNnu9OTIJjJOVP3sE2WPE8IBfR3+bjYklFjL4gqRjiN
	JsCljbvXByBxzrLi+hC1tKpjcBYgt9AdEoowCQq5nGfIrAkBLPWT58NXVyLjIe7N
	vNoW51GG4QHSS+PqUasHGsy+kyvoApq2kRszm9dc2XYn2GX4Y9AkjhU1RhYDVCmP
	vlf9r4rofAeeG/YrEmxOvKRnzfj1oJ2GRw5kVBkNDriedj/8bW5EMVGvwnlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786734845; x=1786821245; bh=7nRr7R/NrZwbdmThbNNnUhWQXsqiurFB6jN
	fpkIMc+8=; b=SMySEyunp4S8jIVKUpAoRp+uu5uC9sYardWi3TlkJGSalh60gad
	inBBXDyWm6aJ6Yf3Xy5/eymEhknqTyEXDgWTMv73J2g8FFwByhe65miWUT6kaigI
	CTW7O/DBjup4go1emmCvExJs4emh41NL12qiWdNUiqecteojK3263+Nohv4lpDF5
	w8XHTgTk9XSPNx6W2bW8qI/CAUyYR4UprBXT2h2TM3ryDQxnPDfQSyWZ8K6AfSbV
	+rE6kHU1Es7ubHZ5FosA6IszMuKNHuEf0Qxv2i0RSAvDDfEucAf93PzpCJAXMA1o
	SIpv0Eoi27eme4DQhBC2t2qINpwYIpYdLTA==
X-ME-Sender: <xms:_Wh_alAzEaop_Q8S6TSUCwXuuGsphQPWm58X-fCmaYu76YcVz7e6wg>
    <xme:_Wh_aqh5W-6kRGzhZpImiFHg7O4uVFAkeZWlqwSC6PpDXltre1tgfEcgHWdwT7r3V
    yS3g1dJPLgcism5HkPav7l8s6w1rbv5pP7uE46vDX4vWrlzYD4ciQ>
X-ME-Received: <xmr:_Wh_alnKCfFCdFLQlY8rzcGJmOdpreTyhsKsj1JifixvJwv8jT76RtMLYwq8DwKrzWQadeGnU4kF6qjnPV89ZTQtlWf1Hgfymg>
X-ME-Proxy-Cause: dmFkZTEys2s9zcE8bCItMjyhbe404HQ96UEa1yAO3ISZ+FLFV9AajJf8nDf8qV7C+L0983
    GKxhuBP7gVYaPwj7+3r1jOGZrxG6b24la5szEUe//h19b+RnjuH8VAQKYvsXi+5inasfWb
    fwDBXVjyFzGuikTYDADWR5lILL7/rUbswNwC6ZpSxndGLJX8qDbZrq9dBqD5bhpMrI8x5c
    6X8LoeAEL7cxoOTqwZxNES+55NGq5tcBW2/LA94VWR7mvIqINawcQXt3eRiqzWv9MX1E8x
    LqDUSlI22SCqxDWLlCxO3+sRn+UglYhR0q82HinM97Ded0s2kIoNXwMAShYaY2aW2FD2nZ
    s9dQGRsjnDvpLT0O6hSEiZPmw/auYMXZYGYvgWPoMp6C2xqBeb7PqtE/2NgYrc7Yz5NqmY
    HrwzawcknYy8zobp2yCh2VZgB04yMnXe3az32g24axu/XCJ7uX7DMpKXl8N4PlXdEs7HTi
    qBRkViQ78ZPJaKhZDeV3CSsbVldioHClcrpemSrWHgq+9GK9u75mwLgddCPwirZvW5PFVH
    uxzFzozkFxP2SUzmHBSgo3uT4sfT353rx+oNE9T+ZG7YyGysC4A7LSaf9+2MLrA1pcVdwL
    oZfLYayIy3HRRa01tbuarPmWT/Ep3aawv/5XBLisVSR3C7JyZw1l+XFMe9HA
X-ME-Proxy: <xmx:_Wh_auorI_4vj7mxpW7k8N6lKdrsodaBLRofysrkOtlCv-1z-4FKTw>
    <xmx:_Wh_amEkZ-O2VP7aBzDOl9BgjoUepT6IBFfmTD41tpTWZFMC4nUgww>
    <xmx:_Wh_aizxm3Nd5LWwSdvJx-W044lwDBOjZgVMsRhM9SLXesRiG_-xKg>
    <xmx:_Wh_ajpLjlh2NekwW29he5v2_7_OHGBP71rgjM6DcXmolNqcxW6vkA>
    <xmx:_Wh_agl3RymH6CAjdbRfyTvEaRofja6IqbNjDBTS98VfZvpSMUhPQCTp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 15:14:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tilak Raaz <raaztilak07@gmail.com>
Cc: Weijie Yuan <wy@wyuan.org>,  git@vger.kernel.org
Subject: Re: [GSoC PATCH] submodule: warn on valueless active config
In-Reply-To: <CABB4Jh1fUXKNn483FjD2S6U4cYVMEP6z+fjWMi8XRT+NQdNnYw@mail.gmail.com>
	(Tilak Raaz's message of "Fri, 14 Aug 2026 23:34:54 +0530")
References: <CABB4Jh3UUXvmAJpefaiP-xVRQfGRdTF2jW8GkdhbA1BXe6Okdw@mail.gmail.com>
	<an9W4XwY8X4ZFHpA@wyuan.org>
	<CABB4Jh1fUXKNn483FjD2S6U4cYVMEP6z+fjWMi8XRT+NQdNnYw@mail.gmail.com>
Date: Fri, 14 Aug 2026 12:14:03 -0700
Message-ID: <xmqqecg0ms5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tilak Raaz <raaztilak07@gmail.com> writes:

> The config parser previously threw a hard error if 'submodule.active'
> was provided without a value, causing commands to abort.

The standard helper to use is config_error_nonbool() when you need
to report a section.variable defined this way

	[section]
		variable

without "= value", and section.variable cannot be a Boolean true.

The patch seems to be heavily whitespace damaged, and cannot be
used, though.

Thanks.
