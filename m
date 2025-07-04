Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7572EE97A
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.148.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625222; cv=none; b=ZHt7RIfvTC9S6ZtvsfBn3Ee46sWVNsbaO75lpIrcQUp4vlq9cd6RsxlVEgBPZ5Z0yf+ZiwCxuwvMzUdZxP984KI/iuQNiIkIyT44wvOLT+hzTcrVjEXKSyhvA4FlaZFTtrIp9+gkTywEBY1UJyIdGs5lxD19YIb3LwPz5qXF2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625222; c=relaxed/simple;
	bh=uFDp/9T5F6LIY5MZeeQxgHlgEXPa6kKqS5XuaVMn1Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRD5mKUM17xHRA+/v41Y1XTj34t++xrTrFQKiA4OSQ9mEWeyC3wm+pdmL7tF6d1XH2jhOIwYF3CZc8ldPgqM5mJwfvVsdX6wMyPCbKoiQI/qL3wEYsSzwhW8m3VagfYdVmRwUbkNlLk0fR/ofh37XADDZ/SYNlL1O4iPxovjQeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codesynthesis.com; spf=pass smtp.mailfrom=codesynthesis.com; dkim=pass (2048-bit key) header.d=codesynthesis.com header.i=@codesynthesis.com header.b=PA4Qnrx2; arc=none smtp.client-ip=188.40.148.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codesynthesis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codesynthesis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codesynthesis.com header.i=@codesynthesis.com header.b="PA4Qnrx2"
Received: from brak.codesynthesis.com (unknown [105.184.106.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by codesynthesis.com (Postfix) with ESMTPSA id 8ACE55E65E;
	Fri,  4 Jul 2025 10:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
	s=mail1; t=1751625215;
	bh=uFDp/9T5F6LIY5MZeeQxgHlgEXPa6kKqS5XuaVMn1Co=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:From;
	b=PA4Qnrx26RJ9Vl7asJOPEBSWlUy0WD+RC7Ova93e8zmg562ssE4MOTeiz6ScVz5au
	 l3zYiOY0xO6dESPk4/5kF404VSjJH91Mao5KsuyqtPPtaUZ94NkA+KiJ1ge2NJxtLy
	 6OFqElDyAUOYLpdNBR4Zynxuo2ttTJvgqMEPGa/hJCsijO6Tm+iB9W07kfjyifOXx/
	 gZq5kG4oRUy/mam92v6xHfoTCNEoui/7cPj9bvOH1kZC6Ec4EkBTDcaASsWcmyv5NO
	 cwDAKewuypwK9AMiCbl2h4uxdpClFAcchz8IDlbL0G4R2jOgH9yhqnTqiM77T5tCJ9
	 P4K19FsCj4nzQ==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
	id 50E221429C5; Fri,  4 Jul 2025 12:33:31 +0200 (SAST)
Date: Fri, 4 Jul 2025 12:33:31 +0200
From: Boris Kolpackov <boris@codesynthesis.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org, karen@codesynthesis.com
Subject: Re: [External] Document ability to disable template directory in
 git-init
Message-ID: <boris.20250704123013@codesynthesis.com>
References: <boris.20250703161436@codesynthesis.com>
 <CAG1j3zEiD341X-_ZdR2puaEmZZ0ZBWSmyboyyGZaDXcDTcmAeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG1j3zEiD341X-_ZdR2puaEmZZ0ZBWSmyboyyGZaDXcDTcmAeA@mail.gmail.com>
Organization: Code Synthesis

Han Young <hanyang.tony@bytedance.com> writes:

> Digging through the changelog, I think the feature is added in v1.5.6.4:
> 
>  "git init --template=" with blank "template" parameter linked files
>  under root directories to .git, which was a total nonsense.  Instead, it
>  means "I do not want to use anything from the template directory".

Thanks for digging this up. So in a sense this is an obscurely-
documented behavior that people could reasonably choose to rely
upon. I think only more reason to document this more prominently.

