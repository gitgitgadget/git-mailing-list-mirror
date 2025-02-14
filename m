Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BE9193079
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508850; cv=none; b=GQelYfmVmwY5Q66sHvlcf3OxRWjRerPVSDd6JF8SS5TrXgzakwPqCUzl7ztJBxXDlou4oLjTm3Be1G56qnbR2PSYSPRyPMMdpK4m4uc0UWE4sIoyZ9sJsycJiUIbJaAU6+fh9h8GMipVrThRQjgSFsFSYi7JuynRYDFI6ef4Pss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508850; c=relaxed/simple;
	bh=Q66cFecVFDpn4rG7i5ctY3bleMWZYMGd0/fQHL1IZCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f66+3DQNJlXGw+uosRFtvALn9vLqzcCnQC54BbZWvuG8LGYAUM1dlys+dAqvokDHsy5pvUEPyw08j2E2Y+zjQtgIvb07PlNBYUhckU1+P3aAFx4vafgC64VQoR9IUWICb40Q+nVAjleRyICZs3yoGCDemBRBZddf/876Tj4qBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=snnEJZqj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1fGGZ3j; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="snnEJZqj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1fGGZ3j"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 09D4D2540193;
	Thu, 13 Feb 2025 23:54:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 13 Feb 2025 23:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739508845; x=1739595245; bh=Q66cFecVFD
	pn4rG7i5ctY3bleMWZYMGd0/fQHL1IZCg=; b=snnEJZqjx79z4skWj6JJE3On+6
	i5jx4Xcb7dDRFFZt7OetrJ73xM6yPAAERI5T/uQxhpWTSisoZBzpJ2E3ou6a2CJA
	0pPjsBGK2Ir1nAZok4MikKOzqstfM0huc/iyWad7qijF983ZwjBOxuAt0s1t486V
	42CLN+c/TfKx4RGtj7rtm3qaJVx0Nla5XGnMiUBSGU9pl12O1qrWp1KehmYRrLDW
	9EQdgUW1J06nzNxXFY+2g+zUDs9QEWQcqBv+d+9rf1wWYeEk9yQwR6vuJBxTysJ7
	DEKhtLZ5D+U8x/alwOQyOvm2fE45Yj9v5Uo0rX3hgixDsuW4S2dASOpTKWbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739508845; x=1739595245; bh=Q66cFecVFDpn4rG7i5ctY3bleMWZYMGd0/f
	QHL1IZCg=; b=i1fGGZ3jDjTapOip6+VD8CyjdpPDYvU9jTb/62hx+N3DLEoB/KA
	pBIh3aKxzwKUKZpyPpowCFTY+gcJsOIuwyZNUvVEpDn/Zx7Fmt7JV9EcuNrMJAt1
	jkh0zo49JCxG1NAmNKAqkCnVwd+v6QegslWo1UPDXzJTjqiOp1eoRPoyfaQTHsJ8
	XM2x//xv1QvpSWlzThzpo1uv2Z67t3yGdsqPB365XQ2+PaRtwehbHYH//KzZfjWu
	LItPv2ODpD0dS/ZBMzCh6+ufebXkzad1MgDIqpT3SZGCVUqoRE9SdaIsxGnO9ph8
	Y1G9FHM1zcGqDSuEgMaqj2+FYOQh55aDeMw==
X-ME-Sender: <xms:bcyuZ5JAofZfdCeX9mdq1cwnMdqNOHazi3n0zmuy-eI339aUPeMaFA>
    <xme:bcyuZ1LGOU0MEpD4Hv9Ca9c7BCXFqgzqq9i0oWI7tqJ7e67J-OL8yX7ebt0f5-imK
    SYmXZyA2mjcwkTxAw>
X-ME-Received: <xmr:bcyuZxt1v7DpKadcwoJAlnaZqinxc03ek2wLJsm910XByfaSHrJUlTb44Evqm_1R0Ia_k696bufsjAego2a0KZJI1BradtMdbP233f9VC-woQfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegkeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bcyuZ6aKguhf8FW5Ds2vVzbwLKX2PHFOQWpktHi-Dlgab01MfE4hiA>
    <xmx:bcyuZwbxcUmHZcSZvVzoMkurosXqABGMpNKpEwiN31-rsWP2EZMbJA>
    <xmx:bcyuZ-CffYqt6iBA9RNKn6wWiOfZ9noN47acdybgzOdXI-QYUKo4AQ>
    <xmx:bcyuZ-bjPepORUNVw6u80ggfJZgc0pEPtcvsGavqFtq4r-C5OVzflA>
    <xmx:bcyuZ4EhhgHl9m40RW_YIkrebViRZ0xt3lslOfizpg2BNN6IV3L3DFqg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 23:54:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 94818e11 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Feb 2025 04:54:01 +0000 (UTC)
Date: Fri, 14 Feb 2025 05:53:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 0/2] meson: wire up contrib/credential
Message-ID: <Z67MZJbGr0EqOMqT@pks.im>
References: <pull.1859.git.1739471859.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1859.git.1739471859.gitgitgadget@gmail.com>

On Thu, Feb 13, 2025 at 06:37:37PM +0000, M Hickford via GitGitGadget wrote:
> It would be neat to also run test t0303-credential-external with
> GIT_TEST_CREDENTIAL_HELPER=wincred but I couldn't figure out how to do this.

Thanks for working on this! I have a patch series sitting locally for a
while that wires up all credential helpers and more, as well. It also
wires up netrc and fixes its tests to allow out-of-tree testing, which
doesn't work right now. What I don't have though is the patch for the
wincred helper.

The patch series is currently still blocked on [1], which is why I have
been holding back on it. Would you mind if I picked your patch to fix
wincred, but we then wait with wiring up remaining credential helpers
until my follow-up patch series is unblocked?

Meanwhile, I'd appreciate any feedback on [1] to help move it forward,
if you have the time :)

Patrick

[1]: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
