Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB211865ED
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107429; cv=none; b=S0/RJP3KGvXF7Nl1oib+9F+qoEG0DnP7apHO09DCi546wpstw41V9h03DGohaUDRkAM5HwQeK3/KTTliqLOi8Ps6rc03LUYeDHICHGwIzGlHuVjTJ1WkAep9Z2g4z8Pm1rP3HjA6N7XbKnXd6pE9LjN1/nK4n5vN0ZPlHVb0Y9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107429; c=relaxed/simple;
	bh=N99VhD9MSWjguNT/KXLyktEadAhO5UvKk1Zfye6ktec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmYnJzDeJOxevuL3+nupgVOFnWf11yV6rRlFaJY777mUBGXP+QDYVV2lwFvMinIBxrvcOJZfvz8C3oEWI9X+mRq3D0laFEIk3b8xvHheuq6arvdyY4SDpMYbCkSJx2v2tykIJfIsdjCqKRbK8NvHY7yuu77/7dSj5UFzgKOTSgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=Vf13JfH9; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="Vf13JfH9"
Date: Wed, 16 Oct 2024 21:37:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1729107426;
	bh=N99VhD9MSWjguNT/KXLyktEadAhO5UvKk1Zfye6ktec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:From:Sender:Reply-To:Subject:Date:
	 Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=Vf13JfH9mldTnYMgWUauxppvzMNnuX0Jmjay4UQr2x1f5Q5fC4skQkKHECIOKAwWn
	 MB3BirkAvdK+jCtqOEJQAGKBXfmOj/Nzpaibavr1i3Trb3J7ahIpJ9i6pqSFOUGo81
	 IAbrZfNN2fX53sdcy9ecCOfpYeSL65wfJ4RVE0yD1Uvg9cRCRiQEfZZv5ri06ZLCUO
	 uIWmMH1DsdinqFg2Y6/g9j9Sq9q3KNYEjmjVQ/zPkx9rcM3dFwuMNPQON8cM8hBW35
	 nJzgW5p7JUv1ZcsCEkOsdY9vfsRpdVv1TSh0X+bFXQNe0anLy6DzmIh1UBFHVo5+7J
	 g6O1jHnfTq7QA==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <2b6k5bhqqs7ce4glglmqccsrr3wftggyj6nnltrkkmho3xbdvg@noiq2dpkfqqz>
Mail-Followup-To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241016182124.48148-1-wolf@oriole.systems>
 <20241016182124.48148-2-wolf@oriole.systems>
 <ZxASXLz4lA+E9MuQ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxASXLz4lA+E9MuQ@nand.local>

> Instead of 'echo |', I wonder if it would be just as good to write this
> test as:
> 
>     nongit git shortlog --author=author </dev/null

Existing tests seem to prefer </dev/null overwhelmingly, so I think I'll
change that. Shouldn't make a difference to the test itself.

-- 
Wolf
