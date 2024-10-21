Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881D1E3797
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503688; cv=none; b=QQASSbWKkIyOanf0oVoyev1i/U/8oRX1qKHV7Wjj/MDhMclHTxNv+Whoi8GwluB08EIeSuF8ghsCFXkYp5uxXoXbUUr9LQTar1Bo9LsnvBom5q6nzj4kel7uBDSMf7LxMn0LWa8rEjXizXoV0WFYxMrmKojcgZRyFLLJmO+Q1Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503688; c=relaxed/simple;
	bh=pbqNhfk17aSpAtf2orG6y9njhhx55NKoAm0sX9Ja5nc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ghesxWC9dymCXNNWZRgX1FupFmJ/NicfWAWvdrOqcgTLNgJJ1i2V7tUE8Dk7Jqj7sTIA7n9wi8r/59IqAD6hSYS7FPtQkeDsGx63PZ2M3zgdtLhg+m2U54YFe4rzfKreyhMDTLjXz37ARFmZTcdKsqcq0exj8RWHi18btzjv0eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=rfF1lvC0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bV0rKiGA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="rfF1lvC0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bV0rKiGA"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E2C5D1140092;
	Mon, 21 Oct 2024 05:41:24 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 05:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729503684;
	 x=1729590084; bh=pbqNhfk17aSpAtf2orG6y9njhhx55NKoAm0sX9Ja5nc=; b=
	rfF1lvC0SOMuwwoTflXWfaOgxh0KLVT0dUoPjrwMP5OwDfevYgD8YOWyzFnVi/s5
	jlvu5D5grV5UHzq+ebxvOcb7CwNt5gt686plolpD/maLZSb3Pa6LOtjeNQP9brbW
	VJIAapHHtd1+josQq2kZy8bwHNbxvzdiJC6fhGRhgRINqSIFmS7a+xWqyQUo/PUi
	7tNaKJ6oTYbaBDp+3JKWuXsc5i1G7eHRQIJcm8S7JGMNTRA5rgdINEs0LHdvyXU8
	IhF06IeWJ5OBY+qS+xw9a115mkJ1np/LW3KwP8Szr/Flw4U+I97PHIMSrvcMwHAI
	v8UciqfB76HLa/tT6mdTLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729503684; x=
	1729590084; bh=pbqNhfk17aSpAtf2orG6y9njhhx55NKoAm0sX9Ja5nc=; b=b
	V0rKiGAPQnQ3X75TGO/yi9BK9RGOo9VEiSyo2SYvdtt38EzwSWNudEwlimlzwheY
	+OyUZzdv1aRinzycmMvvCsRjiYAOUFxQ8zNoW3WyCaw0V18CQtvtig16PCFICX+4
	LOABh8cOp7tcoVQrGR1mKbH1d3JxEK6YP4OleJbT8+v5Yh+zHXazeKbw8f2aJHyP
	u/5xOHufvZnHmrgDNe4oy75nWsc14j/wJFIXUwuefS/vm3LzUFNzsKLWsOsiXrXI
	qlPAvi6oZRV9NFKUjJWUjg7R7OSuJnbBxftARAt8BZj8qMuN4fmOSAbN+Q3IMrtY
	NS+Yg3UeWPLKYVfDmNBCA==
X-ME-Sender: <xms:xCEWZ63QkrtxWjU3UmU-SC3vqriPINYtFekWoAlt_Dbr6Mf9YcG2m3g>
    <xme:xCEWZ9FjcHLXaMH6EOqG3AGt0O05egyM9MHMq2iLgmOy6-fb3H0b11W1RCEUgwWwY
    I8MMRbNVQzaEYsoeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhes
    ihhothgtlhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:xCEWZy6elO3Gz-sDrvYQv7Gl9AE5Xa8I5XUdUYuESpSZQ9QwLfZvFw>
    <xmx:xCEWZ70ZsKl71FcBoQXJ2xGZgFoBGqcUXZrugcY1NfdcxW2IDDWbCQ>
    <xmx:xCEWZ9GHmlNGEJnx4J5VrLG6kZ16fba1InZkamevJObS8YM_bS-LHA>
    <xmx:xCEWZ082ZGKtThpj4FDHTenNjQosh2gQN8eBqSWAlS38qePf0p6d5Q>
    <xmx:xCEWZ9B2ubx-qQW1NlWy4UJ9A9wksZkjE4UCPTiF8TfTH8OQNIJ18Deb>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9BDE0780068; Mon, 21 Oct 2024 05:41:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 11:41:04 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Taylor Blau" <me@ttaylorr.com>, "Toon Claes" <toon@iotcl.com>
Message-Id: <8beb4948-7a6b-4c32-b768-d3ecf04407e2@app.fastmail.com>
In-Reply-To: 
 <5e243f9ee530da417beda9230f65ccf18ae21a9e.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im> <cover.1729502823.git.ps@pks.im>
 <5e243f9ee530da417beda9230f65ccf18ae21a9e.1729502824.git.ps@pks.im>
Subject: Re: [PATCH v2 21/22] builtin/merge: release outbut buffer after performing
 merge
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Re: [PATCH v2 21/22] builtin/merge: release outbut buffer after performing merge

s/outbut/output/
