Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DE36104
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 01:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705802195; cv=none; b=DdiYWlChV+1KDzIWHhCRp+1H6RM1p8IKXR3jJkKD4WZS7xmdENItYU2rfS22mdZNEZjAIWQCYX2AdpCPRznayt54e8Hdfzgm589RyeXgVPMj6D5isfK9vajusaw+JAXCf8petrcheq0uBKTaj7BDgWmd8ccAKeFzOhYziB6e0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705802195; c=relaxed/simple;
	bh=NW+6NcyameNBo/+gzGlHnz7rdiD/yDYKH/YyB+pIAIw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=BBM7HztiWd/4LdPmNXWgmoLrAy61thUeIkIFpd7zyyTkykz85z6rj9PGaAhAkGJEEjcI8YRqeRgHCjq+VImF53ecFTDAEF0NINRJDFkbKcjNB5y7uJxZ5+rQuHfFVVTmWp/RInXWFQooaXpOrmyXL2s+HnGzJqrNcOFNa9T1p5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mccd.space; spf=pass smtp.mailfrom=mccd.space; dkim=pass (2048-bit key) header.d=mccd.space header.i=@mccd.space header.b=Hq5Q5I9Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f58+7REH; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mccd.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mccd.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mccd.space header.i=@mccd.space header.b="Hq5Q5I9Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f58+7REH"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id F379B3200A04
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:56:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 20 Jan 2024 20:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mccd.space; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1705802191; x=1705888591; bh=EVojh7x1P6
	5itfe9CqDphRS1Ewxiz9G8jICJBhI577o=; b=Hq5Q5I9YqDl2y/HKPVDCPg4ddb
	68HMciabqEnNH7UxYzovC3HQT7v4trP5Rbjyebss6f0NIfzcgI9L/+IWzTXtQlk3
	ugnJaEwazzgxMDBTmH5xglZVqCp1LKo5aFfN2bRCQapx+UiimzIRu7aDWZcE2sDA
	mfnpOPcNJTVlIqJ8HglZu+H5uGS3cCyXYwhO4Hu/ebol2y/XYOq5/aYGG/f8ZwEx
	JYDwGO9qPHsC7olx7uaQlk0cq+FVDsl9Eg1hzyTgYbJ1FzM0HRWrjD/LaIf7ONS/
	D1BRBVTn0WFGQOXsFgtJz53WwN8edtbBBLWLqkTPRsFtMwp4+cwmJac42LKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705802191; x=1705888591; bh=EVojh7x1P65itfe9CqDphRS1Ewxi
	z9G8jICJBhI577o=; b=f58+7REHLQwjOa83OXOjEyXgT8K2XW+dd2hqnTPprONP
	PkuFS7or25IbO+lNbcjjDyneN66pHLO/5Ie9QlGrdpefkU7zTlrEvheT6ajqTP5Q
	pAeE4HF3tNpse9T3dxKk3bVcavjCqEplYqUrO8qVXIJqGkbraEYI5K2EHG2jDUEv
	zEbq/qgT+oLe4yuIs92FKF+XGpAy+0vvy1kbrV55XNHr5s6KJINi63RtIThsiAYy
	M8v3Jw3DOVCzpRGqCYzBuvIKrcQRkY62XRGFiA2c/DqEKizgkUnx8Rw/EzJ8ixtY
	zxUfW9Gd8g09yLp7PdCed4eHxvTCb11Kb8yAJ2z/NA==
X-ME-Sender: <xms:z3msZXSRqQeOJVK5wGEQ8hMIrzmijFdeNt87eG4WdK4QOJFiqgJM7g>
    <xme:z3msZYxCx5K-AcgOq3fozcU9WKDyEaFjCHzedd-7UpcRd7PZj4kAyHSMbXV1JH_Ly
    s9zJTbQvCk-_K2Vois>
X-ME-Received: <xmr:z3msZc11ET3D4e_cfCqos3Lp--niglfXxm4AF5M5QuXOrOVBhn0-1OdE0YdW-wjXUE-OtuJCRVwuwUiJgR-lJ8vUT-vnm_fz_lVtWf9OLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekfedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegggfgtfffkuffhvffosehtqhertd
    ertdejnecuhfhrohhmpedfofgrrhgtucevfdcuoehmrghrtgesmhgttggurdhsphgrtggv
    qeenucggtffrrghtthgvrhhnpeekueeiueeigfelvddufffgfedvheelheetkedvgfffvd
    eludelieegieehueegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmrghrtgesmhgttggurdhsphgrtggv
X-ME-Proxy: <xmx:z3msZXDCJFQ37z2PLHPDSqtitDMQ09bXP4UiGQZw0rOaop0Z-ZMovg>
    <xmx:z3msZQgu23WlTd1mZmZe9n7eIqRq3PDQtt1BInjyH0VLsYbmlpTZaQ>
    <xmx:z3msZbpl9PkpAsHe9p_8t3K-eW5t0q4gJHMxD73cqXyTu9gVuKOLig>
    <xmx:z3msZee6BLBgG3CARIODAVivRBfwNqAob8YolcaZw964fjxqnTgQ6w>
Feedback-ID: ia2d149fd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Sat, 20 Jan 2024 20:56:30 -0500 (EST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Jan 2024 19:57:28 -0600
Message-Id: <CYK0FIQPVI22.2RHKOY4L00FZS@mccd.space>
Subject: Git pre-received hook not failing with exit code 1 correcly
From: "Marc C" <marc@mccd.space>
To: <git@vger.kernel.org>
X-Mailer: aerc 0.16.0

Heya!

I am trying to understand why my pre-publish hook does not exit with the
correct status code.=20

I have a pre-publish script

```
#!/bin/sh
set -euo pipefail
echo "Testing nixos config"
nixos-rebuild dry-build
echo "Success"
```

Running it directly in my CLI, it acts like I would expect and return
exit code 1.

```
$ ./.git/hooks/pre-receive
Testing nixos config
building the system configuration...
error:
       =E2=80=A6 while calling the 'seq' builtin
       ....
       ...

$ echo "$?"
1
```

However, when running the script as a pre-receive hook, it is not
running the commands correctly and returns the wrong exit code. I get
the following:

```
remote: Testing nixos config
remote: building the system configuration...
remote: Success <-- ????
remote: error:
remote:        =E2=80=A6 while calling the 'seq' builtin
...
To myserver:/myrepo
   bffa94e..a14b3f6  main -> main
```

Any clue what I am missing? When running it as a pre-receive hook, the
failing command returns exit code 0. Running it in the CLI, it returns
exit code 1. It is Schrodinger's exit code.

Thank you so much for your help.

Sincerely,
Marc

