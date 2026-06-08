Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5DE3A7F5D
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958198; cv=none; b=V2Z8tfM3QkvJPHRVlPs4QOgmrqfAWVWWKhk8TNlDSBMtBwagK1s5otecGDfhsG0vhk5zpnUniGTGHQs6iz4Ps98xOvgMqul6tZ+WZrfkCt+0pXEYrD2wPyjb20cUHjc4CrHNSkfU9aUpQPF4OTcXF9jX45VwKib+ygge2WmAQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958198; c=relaxed/simple;
	bh=38oyJm89f+opIH8Sg110tuXOsbAhex2BqOovL3a0WiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K5x/R02WMvYntFLcqNZy8zsa3LpkmIw5xcxyEJEqNEoyi15VlAARjtF4YJKfXytN5FAmIDHqk0ekUmZa6ueOtFP2fVorF3pE3+PIcCpFlIGYBQpkf0V4TjmsRIaoHTG2RCMsfWKh8a5+S7YyLtZQnalNE2FnDghrzFq88WTvBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k5vVDbI9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ecuInsHM; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k5vVDbI9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ecuInsHM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B51447A011F;
	Mon,  8 Jun 2026 18:36:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 08 Jun 2026 18:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780958195; x=1781044595; bh=hxRfiq4x2b
	SjDkxxiQbFq6IFUJhABLTHw3Mc+1v/3dI=; b=k5vVDbI9O6kaIJ3aHyq8FF0e20
	bBOSi9YhVYdKgf15FMF6MWbW3Vjfz5AbYh/swvo4GCm+ycCk/AM0NN7PtVe3CtYJ
	yKHvSfAcrhYpRWybB1MnhDuxJmuSYslB4l81LT0AyzWNk0gnpmbmDbpyGDVjnlWO
	BipIUaxybDb5qRDW/2uAn+6ulju9/GAk/I5c6wu6OBsbcNRdVzJj7sL1xncMcCRu
	EqhVjYKy249QkhVzS9ymG1cyxBcMunxpFewi4pzK9j6v3tZt36LWvVCH7Z4+wfqF
	da9B7Z0k1vWHCIuDmc0mLLNRLNytD4QSy9vu1BpFxyA/uLZVfKoyH/8bCL8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780958195; x=1781044595; bh=hxRfiq4x2bSjDkxxiQbFq6IFUJhABLTHw3M
	c+1v/3dI=; b=ecuInsHMi/69lFVOlUSJWUiERno7CoE0Jl+alrlw/5bm+T1L57T
	A1mpDexqWK5CYlZv874TFPjWsGBF8n9zGPRAVOvvggsUeNO0Qo2qphUEpWJlpq0B
	A8YS24jgHyKhej9g9aV1TnWQbr14IxI4jW/dEEm6+HkqXWo0L1dDHqKSQEIHFIev
	/IRi9Mbuqc73gYtoVEzliU6e+Qs4bo5GHGs1YH8JpTgg3+7EmMrMcjVGNFDb+nPC
	wMEWSZK05uny7+3WaEE0HWtFb2B5E7v6axQEkaEDfv2O02m+WfZZ4e7jXDqCWHE3
	g72wfe+IWq6jqOb54MgbpIXgWS2pJy8m+2A==
X-ME-Sender: <xms:80MnahzXOB7Noj_fAoKGnhDLJgDU-XcMZGlQYlOqz9suef8P1zfoEg>
    <xme:80MnamN005IsSwu8zuHwELrhYaHpcrnlGUJPpGJjYj16L1BV2M7KIVLgLcEwQOAdu
    jVdd3gOMsORpuXOnYPMBcKLdMuj3cG9B8BXqWnCvo9AgIePmZEJ>
X-ME-Received: <xmr:80MnavmvXSXRBwVeXcP-3jQohSYI5tIrBESnUiv5e7n6aITuiOJ1fubBanHNPIHhRK_X9LV8kxwdlWPJ0F5_28r5yHu3bMEdBFpT>
X-ME-Proxy-Cause: dmFkZTEFnHBRuAdvTqspRnC194z0/UtJPQYvw+OXodkxf3YAzEdSU9nzPmanaphnkSycnD
    baVdGojXIerSbH5NyZZOmcaTez5wdurKR8R/S+Uf30s54hyW6lsGg/MN35ShlUw5bArysR
    SUtyUb71A7xRgh1acsL5nyT1xvgYZe58wm3+yIwlFbkBTLoztNpp7hbgZRIr39gsz24i80
    Dw8aWmAXz1O3fI76fXYfFZsh7iILshT5W+PmWrMG5HjndshObtwrnSrgsdBbyNmRY5aUiK
    0+KkC2txgnrmlzifFj+YL5Gjm2GDmWdzVeqHwTeZjqO1uXUtKwGiS/ZSYYNA/Vwr/DbffN
    Tf2rjByZdQ8sOBEYikCIMypO2AdgRewo0YegkwlwfIA+iE1XQKel3hoioDB3aonrIK5SNU
    vROOkSdy7K8KsS2vYUIzdzrUDhGkh7bBMfZIfbZKhR/U3kPBy5QG229UFw4/5ZwRuX1dDT
    qgSkWgsaDiZqaAdM5AZr8gdUMA1ZSP1Q9UuQYRNqBnzj+mNZvwbCvmzGCfRwgwoxs2J588
    TRvszZlYgtp5ibd090UJHgmSJXor8TAqUULkfrkTeF4tED5L+x7FkPPenWU7pn3wd58SaQ
    VDzR5Ru7pboZ8K9wkqOoLuzdd7AYY7YWwVEF1zsOsrbQJDMfw6zujTGYtXhQ
X-ME-Proxy: <xmx:80MnajRZK078xZeDAmAqKf9MJoRLW2xbJyYBgWV7aJhwu1mCp2ZWUg>
    <xmx:80MnamWvkFekFfsFEPODfcI2lx8qeZOJSSV54lZLsStXFW__VdJa_w>
    <xmx:80MnavJSFwVQTaREYnk4obeD1d7L2DhBM-oG7vCp8YqIcCKJxZE7Ug>
    <xmx:80Mnau31Meb3h2Hbyh9Y5n6BTu8fvd8eGhfjSDYq2oaAAhnbJ7qkgA>
    <xmx:80Mnaru9Gw36JFi8Kih-BUc7qYgjIFI_ubjW2Wo4Qm6IKmbtXlsGiY1K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 18:36:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  a3205153416@gmail.com,  jltobler@gmail.com,
  kumarayushjha123@gmail.com,  lucasseikioshiro@gmail.com,
  phillip.wood@dunelm.org.uk,  sandals@crustytoothpaste.net
Subject: Re: [GSoC PATCH v2 0/4] teach git repo info to handle path keys
In-Reply-To: <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Fri, 5 Jun 2026 22:00:08 +0530")
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
	<20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 08 Jun 2026 15:36:33 -0700
Message-ID: <xmqqcxy0vevi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> 2. Should we consider a default option?
>    Currently we have path.gitdir.absolute. Should we consider an
>    option where a plain `path.gitdir` returns some default?

Probably not.  It will invite folks wanting to tweak the default
between absolute and relative, rendering this feature useless for
robust scripting.  You do not necessarily want to save typing in
plumbing interface.  You want to reduce ambiguity by reducing more
than one ways to do a thing down to just one way, and as long as
that one way is not overly verbose, you are fine.
