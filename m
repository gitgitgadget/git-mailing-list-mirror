Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0D32561D
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712482632; cv=none; b=S9gDEwLcmrttfICdocaiyEENU2hadC5l7YIlBdPnoGVyEu5xna0aLbWhVm9BP0WQPG2tdzXzyFmfUM6zm70Kq5jI6vUCSJdBe+0Msx9C3nHZOS00BIF+yJAO0Avpwj+7HLXxxmc7UPs9ekWFA2Vwk1t3FKrW8ju/9MjeWpdBNpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712482632; c=relaxed/simple;
	bh=AsBc7Pt7dlwKYTS951ZJLyL+In8nbkow2SQuSqyU+C0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tp6nKhuu8NWqq3dkXYuqEAtP9qSFRcbfJyzybXqokAtcfec/3mWsD7jr1WqkmshGhyU4dR5cUWzwvhawXOc9COS6RWBgGbwluME/EAJyqxLyqi4z95NyyGBb0YOYoV+ZHjP1lvGyBqjBT1gff0H4NljXKLN5GN33Udn/PUJWMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=w2YoHNf5; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="w2YoHNf5"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9ACC1F44D;
	Sun,  7 Apr 2024 09:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1712482145;
	bh=AsBc7Pt7dlwKYTS951ZJLyL+In8nbkow2SQuSqyU+C0=;
	h=Date:From:To:Cc:Subject:From;
	b=w2YoHNf5pd4busozab96cVUvJ7/+1tRIp5gBYCNwL2yPazZV9BcMba3Qp9SIQ6wTY
	 xKTOmPKAo8SEd+Bkocx8H5hPx7b2Me0rahfM2FPJZLsGkUcXjaeMGRbgt1r9y7xL2G
	 LlBlRW8CmIwxkMG78z4pk4arzXsnF1ishR5W6c2Q=
Date: Sun, 7 Apr 2024 09:29:04 +0000
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Cc: meta@public-inbox.org
Subject: public-inbox.org/git/*/s/ endpoints struggling
Message-ID: <20240407092904.M799327@dcvr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The blob reconstruction endpoints (aka the WWW version of `lei
blob') have been hammered by bots while I'm gathering data to
reproduce (and hopefully fix) fragmentation problems in
dlmalloc-based allocators.  The data gathering is silly
expensive all around and I'm on old and slow hardware and
intentionally ramped up bot traffic to gather more data.  I've
tweaked robots.txt for now, but it will take some time to take
effect and I'm also distracted with offline crap.

AFAIK, nobody else is running instances with blob reconstruction
enabled, yet (the feature has existed since 2019).  It's a
PITA to configure but I've been doing extensive work to make it
easier to configure and use.
