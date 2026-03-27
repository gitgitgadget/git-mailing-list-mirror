Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch [109.224.244.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7D3A7824
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774610464; cv=none; b=FlFEE5RDeHkhlCsduOMrCm2469Mj8x7Ys+qdFcqx+7nQ8nkCLvjuUL47QGZQ6ufBjwKJ1ld3yQxE6eng5lLxW64PJzjV0SXqGqHlpN60qfwH/K9Jv0LzKvHPvHg4qACEpeSQ5U4mqszeF3s/EtidjK2JH8s7gb11BZerg/+bo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774610464; c=relaxed/simple;
	bh=31f2FSufr8t11ueeneL0CkqmCqXXgRdzjokzmDcuLIw=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=PBv54uRmeEDvnbqblt8LDBcveOYghN8rybF5HqvD58TYv/NmQkxfPQLOINQSMObyjVadmexQZyu0tsONxlkPjRhVijb5bil3cZAXHMWdaCrT703ehDNM4bucqqPB3L7pvYT0j1+gwhwlTRrjl+iCI28ySSQ8QQi0qxILjaS2eOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dandrake.org; spf=pass smtp.mailfrom=dandrake.org; dkim=pass (2048-bit key) header.d=dandrake.org header.i=@dandrake.org header.b=EEiwHL9E; arc=none smtp.client-ip=109.224.244.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dandrake.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dandrake.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dandrake.org header.i=@dandrake.org header.b="EEiwHL9E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dandrake.org;
	s=protonmail3; t=1774610444; x=1774869644;
	bh=31f2FSufr8t11ueeneL0CkqmCqXXgRdzjokzmDcuLIw=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EEiwHL9EHlofft4axBSjaV1oouxjT8Gf06q4kKSeRI6LzqcVrQdCFWvfDGW4bPvME
	 r/gxxciWmngNcshLqaPfYCrkT4o87zOmSA4vwPFQ7w/EvPnwDCHuoVyfXQy9uHLHtj
	 6ht+4QNpUJZSknGn2NwjkENchZ2YOrH8aoFGQ5y0Ad8sC1qHaDb3RFh2A+I/Gy0zCJ
	 haiYB+/o/w3udqkgj7iy/F3W9JgNpUNjdpgJqmZoLCWtyL8oSOIAbGXnin6PYt6IT+
	 HPxr8y8OJhyesxjLTp3Jvw9d+e4fFKozIrMF5UF0nQYS+xhIsoo5J5IcoztWm3JRS+
	 8QhTRtkbILarw==
Date: Fri, 27 Mar 2026 11:20:42 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Dan Drake <dan@dandrake.org>
Subject: gitignore documentation for info/exclude files and patterns with relative directories
Message-ID: <Qdk5yVH_yWgKl_bjCjdasusfe3PuzHCZ2rKgKIn2Xx5rcw46jmQDfA6K2vkv3V3XLSy4aqwyUlfVEmF5VlIv3EVEOlZLEnf-paw11tyhZKE=@dandrake.org>
Feedback-ID: 125823937:user:proton
X-Pm-Message-ID: 41b628d7cb4c60e5bb9857929a2d95abeca4b040
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

In the "pattern format" section of the gitignore manpage, it says:

> The slash "/" is used as the directory separator. Separators may occur at=
 the
> beginning, middle or end of the .gitignore search pattern.
>
> If there is a separator at the beginning or middle (or both) of the patte=
rn,
> then the pattern is relative to the directory level of the particular
> .gitignore file itself. Otherwise the pattern may also match at any
> level below the .gitignore level.

For a .git/info/exclude file, the above makes it sound like the pattern wil=
l be=20
relative to that .git/info directory, so that you would need to use this ki=
nd of p
attern to match files starting with 'foo' in the root of the repo:

../../foo*

However, it seems that for patterns in the info/exclude file, the beginning
slash anchors the pattern to the root of the repo; the above pattern
in that file should be '/foo*'.

The documentation should mention this behavior for info/exclude, as well as=
=20
the core.excludesFile.



Dan





--
Ceci n'est pas une .signature.

