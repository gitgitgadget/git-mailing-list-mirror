Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3144F1CEEBE
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571517; cv=none; b=gJZbWr/BzZ16qRnhEp4NpE1A4kBaZU1tdZAP2jdXA6/scQgZl5Opmpd2el8dr6Xne6t0cBnKzUzjSCBtIiU5LuQDwEfskaHfFLLPjhurf7sOdkEo4snpZyyaldXs67yZ/Se9CS11uD7REbLHdEjtC8Ze1JX9AcOJqcmCyXzO7oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571517; c=relaxed/simple;
	bh=X3ZQp+jJNXxs6R8cHuVenhl5tmt72DcGu5EXDtS2gD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OQzsRvjnqQZNSdyn8IlMIb9D0xMwX2OjfadP/a5tlhrlcRvUpHRj6hL8y7omPHbzMZ8YOfY7G4zrzuY2uP0DDVW1W3o3B24sNjGpgS516cAZ5wjifI8SjEZC56Xb32EmKBq12Fry+p88z3vicFqnlD4Mfr/Nn9A3nIP8UCMf2Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ei6vRVsX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B273i/2Q; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ei6vRVsX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B273i/2Q"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 307E113833CC;
	Fri, 21 Mar 2025 11:38:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 21 Mar 2025 11:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742571514; x=1742657914; bh=pOdZ7UjywQ
	fHSuqcK9ivFWAHXC9BiLaczeciDkGJW3k=; b=Ei6vRVsX40wucGrv//IQRncb9H
	z+irAP3AhPhtjMhBbAdcBdPRCoIxxkGfG5Z1zKeY06ehXR6eeq0lMPZXjsBI9rWg
	u3cL4bVLlA8lR1FlohZ0fR7eHQXQgxndqMKh3DbPrdXcBK1nYErZhhfGihNPwwVb
	haLEeVXawirLXan82E49KH78ymLbaYvyuuHgm91IYguTT8wo64oKvIA0/MNTtYG/
	c39LNBPHbS5Lhuhdlfkzltq9NB5DlbChyx/0JFP1aU4MlTKNdrEsVAMjC9PXe+Uq
	bqRivDs1NWO+bGQMUxbV/bB8dMbVx9XqW5hMbv0JFBtMVLSA2sWWP4CxRTQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742571514; x=1742657914; bh=pOdZ7UjywQfHSuqcK9ivFWAHXC9BiLaczec
	iDkGJW3k=; b=B273i/2Q4W7HKcxBDOKn2lwlHn4Ppusc/U86f4IgRi0BSA6BGXC
	CblKOXLlIRWcQ8HicPQ/Sw3fqaX4q+dSYQf9+xSSYn7P79CIagIGgtQxSrcxfyjS
	dPv90XfrDlYZNgD+HVHkOxW+4BRXqqoPmmspCJJAB6EdCVsJrLnakUpWC7BeFDMM
	TQ3U5xPrQtoo0BtqELeasAHKrOOdL3kF4xTdqbmh16yMmVAgsEW9GbIkg0Qc8B0l
	kh/WfpuAAREFA0aCwJF+pYIBbCCfoo/GTADP008hLNf5hIbJU7JIRDb5YIyR8dNu
	yz4lw7ZBEqUl2CxO5AR3bZAzHcOQzbm1gWg==
X-ME-Sender: <xms:-ofdZw6_z7hMpwzG4iHLsXzhMyOsqN09K4STAu98aipI5fCITdms_w>
    <xme:-ofdZx4J-eLddyOlO2nKxmrpmWGWv5yfKywOFzo7NsBrS-YsH-nrVpDCfTimt9Mdy
    mi8CD_26PDDfQAWGg>
X-ME-Received: <xmr:-ofdZ_ctQsWhVsYCmnm8QbU62xAl5eZiehpVVToQenl5dWcJI7q0-mwyYpygcIbwGSF7P3gywLywh52DHa5wWtahb3LUUx6Zmmi59Qo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopedtheiihihtfedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvggvthhsohhnihef
    tddujeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:-ofdZ1LoEEnWiFoNJ4bRqtsdfbhz1pEoCCqSLpokU0mNvfuNboOidQ>
    <xmx:-ofdZ0JbyNC6dnEER4rBksGAIVZWHnIzbbqqSIHmuzr3nSiYHF1TEw>
    <xmx:-ofdZ2zDCsWHoRea67Vm4_8LI-Re2YcrzC3znelF_PdAQWVlTK3jyw>
    <xmx:-ofdZ4LOVdMuFvwT8m-3g9dIpC20V5yn1rFjpb7WQTnPY5q2Bon35w>
    <xmx:-ofdZ5HrDXXE_FGuXDkNWc2GkXmBr5cOQD8MERFKv7afWJeB6xoLeXK7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 11:38:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Zheng Yuting <05zyt30@gmail.com>
Cc: git@vger.kernel.org,  meetsoni3017@gmail.com
Subject: Re: [GSoC PATCH v6 0/2] send-email: improve error capture and
 status code handling
In-Reply-To: <20250321025128.68463-1-05ZYT30@gmail.com> (Zheng Yuting's
	message of "Fri, 21 Mar 2025 10:51:26 +0800")
References: <20250319020221.2160371-1-05ZYT30@gmail.com>
	<20250321025128.68463-1-05ZYT30@gmail.com>
Date: Fri, 21 Mar 2025 08:38:31 -0700
Message-ID: <xmqqo6xutmvc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Does not pass t9001 when applied to Git 2.49.0.



Test Summary Report
-------------------
t9001-send-email.sh (Wstat: 256 (exited 1) Tests: 215 Failed: 169)
  Failed tests:  4-7, 9-10, 12-13, 15, 17, 19, 21-28, 31-35
                37, 39-60, 62, 64-66, 68, 70, 72, 74, 76
                78, 80, 82, 84-91, 94-99, 101-112, 114-127
                130, 132-135, 138, 140-142, 144, 146, 148
                151, 153-167, 169-189, 194-203, 205-215
  Non-zero exit status: 1
Files=1, Tests=215, 24 wallclock secs ( 0.19 usr  0.02 sys +  9.31 cusr 10.44 csys = 19.96 CPU)
Result: FAIL
