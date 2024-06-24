Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3238C
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224258; cv=none; b=UriTQD5i89J5hw6W/3kceFK9JtcHNop32gftJuLMtKztdx/mWGseDMsZNiOm+GP2mTHlhJhNMyvxu7/+5YeHJVZiRm/ZNFLQkSRYsdcc1tEm4enYYe4in+Xl8Gfh55DM8PVA3NPyPoB2Z1T+Er2NjmtZhH6UOMMau8WzpculWtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224258; c=relaxed/simple;
	bh=qjPhW9tbJmYLQbTGcyGzqhAyyKj570jKSMXTzIm1beQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LwY6lMb3GOTZvfjBFr7mGAhqtE5lBIIFisD86OB9SYTxxOeBj8uF09OtRc8ImFl6rtyKXEMIEfqK41pGQERO+Vu5SffVw3qz1XdKaLHR5taNAmx5bYXAZrVxcQMLxk9N+SV49tT41FA7J2Ukf6XO6nFuCQXxt9mqEBVcH3BblsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xwrt+FLa; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xwrt+FLa"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-707040e3018so2889052a12.1
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719224256; x=1719829056; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0lhRUJ4XblMZkwc+LrEJfFR5LnHx3JwoEcX9ruzQYFo=;
        b=Xwrt+FLaf5OqP7aroS1xkwdr7Uzj9VS9lUadmw+koNjPxziFtUZpX4H5OzfSE1nbM7
         DAbzv9RxxirnxutVZO4B3F/uCtkDOC1j2aNIuiETgtHj6tBIjlSh5PCkhlyJ0m6omKJ0
         1nsxqKS1G3YNbCqU7k8ejemcSTaaDoOLySdsrwKNVrb3i8UvxopZIa1fTgnLuWFMRF2o
         btw2E8WYjVo5fNLYsgPOSR4EZBQb9EYEeJK1IWpn0nz1M3eLDsVrdwf/bk+mi1A73zoA
         11R/ViJj7OH/UeF8anHKR7WkMtH3DIJvCmGgTRWAhEpqstqUw8DE9tiIJrfX6WM24dj9
         EbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719224256; x=1719829056;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lhRUJ4XblMZkwc+LrEJfFR5LnHx3JwoEcX9ruzQYFo=;
        b=N3kCxHH67FARSPUzffX0PzNR8fX339t6gdP3WFPlIaFzO89hPesizXuBlNDKbUg1n7
         6TkAGwWUB/N4Ml5174ViCizSt6MVLBpXCga4Etuec8eYTw2Ex+IhXZcAfQXGo/uNq22o
         2bxJMt3g2Swk12a8XgzdncLue1c7+dk3d+qhTA8hWKLU57FcF3KIERfGC/1TVtkTbERO
         TMDq6lNX+vnuRQoy+VQkgBLYs37Y7sRSARxNcqsF9eaqddy+vlrhAh433IPbnH51ZUDi
         9TBq+rYevxdvR/Kkd1UdJDhRafsdV4RP0i3yxJktsC3N9yitLsJHIFRl7EGpmMlesnUW
         NINA==
X-Gm-Message-State: AOJu0YwOrYkUdQr1/8fE3soD0sUs91fV+R/Q7dCHW4RT5Cv8FggK79Fd
	oLJvIgnbFvpz5TF3+Mg20Ib7K+I4t2WCLhsFKmU9XbAvYRYTBuDAAlHYCkRNLeyG3oS6SxVbbTq
	zhJTjjYDeolAdELwOzK4Eru7THivjJrVszWo=
X-Google-Smtp-Source: AGHT+IFIq0mKQjjOAzQLAIuTOsYYzeLPqrX6Npcz3mjosCkx018Pw6qhofVsl8BdFfnV8aSeaCL79sYrpdugVv5x+KI=
X-Received: by 2002:a17:90b:4c0a:b0:2c7:b3f3:f2cb with SMTP id
 98e67ed59e1d1-2c861246c2dmr3264303a91.19.1719224256132; Mon, 24 Jun 2024
 03:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Noam Yorav-Raphael <noamraph@gmail.com>
Date: Mon, 24 Jun 2024 13:17:25 +0300
Message-ID: <CAO8o=D5womGcsVsGT4h2=3qry05mMrd9dFDkZHrLtPCDw0+2Tg@mail.gmail.com>
Subject: Regarding howto/revert-a-faulty-merge.txt - another way to revert a merge
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I was looking for a way to revert a merge, and found the document at
howto/revert-a-faulty-merge.txt. It basically suggests that if you
reverted a merge and want to re-merge, you should first revert the
revert.

This is fine, but it means that you must remember to revert the revert
before the next merge, which may be hard to remember. I thought of
another solution: In the source branch, add a commit reverting all the
changes since the previous merge, then merge again from that brange to
the master branch, and then revert the revert. In a diagram:

----o---o---o---M---o---o------------W-------
       /       /                    /
------o---A---B---C-------!C!B!A---o----ABC--

(`!C!B!A` means a commit that reverts C, B and A, returning to `o`.
`ABC` means a commit that applies A, B and C, thus returning to the
tree after C.)

Now the W commit really reverts the M commit, and you can forget about it.

Would you be interested in a patch adding this to
howto/revert-a-faulty-merge.txt?

Thanks,
Noam
