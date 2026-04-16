Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03C139A05F
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349424; cv=none; b=DSYUQoMIU6S3OvXTZV7SRGmn8zWFBMjsWzP0Vrv24Mvk+mzHfEiDXCJK4MrC82PUtiAZzpcBEkCxbwk304mUc99+TXIM1EXYqwip6Yvj+T5fi20bs7zzwZbr70FNspu47nO2Gp0Pdg+RoLvvYyTuq/lCWO6IWDredU2i1qzuBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349424; c=relaxed/simple;
	bh=ZOBNlZ2MOYm7W1vYT1J62JgkQTe6p1iQ1apra2wkYA0=;
	h=From:MIME-Version:Content-Type:Message-ID:Date:To:Cc:Subject:
	 In-Reply-To:References; b=EFN/J+/0KgaOVHJHJUryvA2ItqJ1fY2u9k0gCmxVvDbiAiQQhYOgyhTHoR22lLzUo+P4Evk4SKvJdPpD77+1+bsGisQd1MDMql6xxYAG9qWxW9uVSLRlKJPacRWtJN+wMsYfWMEzn02Tem7qocG8uRYTWywKkqov84MqpX/oi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=Lf9BA+y4; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="Lf9BA+y4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=e.chiark; h=DKIM-Signature-Warning:References:
	In-Reply-To:Subject:Cc:To:Date:Message-ID:Content-Transfer-Encoding:
	Content-Type:MIME-Version:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=OuIjALvUj4pWZ3oDYHXW8vjwyOnVQ5OWqvvfUBlCGzM=; b=Lf9BA+y4fe+u
	VMk2Po0ESrNWpDby1ryKaQzYxoSkB5IJfgN3w0EvclW4xMuWB1dcTga1PcpSnJ8vX6JnVu3K7IQO8
	fiqC72VCKLxt6VZ5WLYFaXgTkhqeMmRjkB5IrJGVP0aDa1c4Dgif2CfGaxwA/aVJS70REBcI+ELHD
	UyUKdWQjj03wkXkdqRl8hpVuJYDK9G/QVrlz25cVauuq7D1tQ9aXx/JhLECxjE5OuiFC6oKoelzfF
	D2D8bKPEeivR5+AuK77/rZoV1fA5BB3pKa6ga2x98/xfUEjWv0MzHVDHh2QJCN3/K7clayhHgr4Ts
	+Wox5cTgenDjHlN8KEtDvQ==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1wDMiV-00069b-1U; Thu, 16 Apr 2026 14:25:11 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <27104.58166.993109.63505@chiark.greenend.org.uk>
Date: Thu, 16 Apr 2026 14:25:10 +0100
To: Colin Stagner <ask+git@howdoi.land>
Cc: git@vger.kernel.org,
    Christian Heusel <christian@heusel.eu>,
    george@mail.dietrich.pub,
    Christian Hesse <list@eworm.de>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
Newsgroups: chiark.mail.linux-rutgers.git
In-Reply-To: <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
References: <20260215201748.889866-1-ask+git@howdoi.land>
	<20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/63/6398e3c18559ae9fcc00a4cf06dd3d8f.pem

Colin Stagner writes ("[PATCH v2 0/3] contrib/subtree: reduce recursion during split"):
> On Debian's POSIX sh, shell recursion is artificially limited
> to 1000 calls. You can check if your sh has limited recursion
> with:

FTR Debian supports multiple options for /bin/sh.  The shell in
question, with the limit that's troubling us, is dash.

> Depending on the history graph, subtree split can recurse deeply
> enough to encounter this limit. Rewrite the rejoin-deepening
> algorithm to reduce recursive calls.

Hi.  I'm a git-subtree user and indeed I was the one who reported the
bug Colin is trying to fix.  I would be happy to do a code review of
these changes.

However, before I get stuck into that, which seems like it will
involve some serious staring at shell code, I'd like to ask what seems
like a logically prior question:

Why not run the script under bash in non-POSIX mode instead?  I think
that would sidestep the problem.  If you don't want this program to
always depend on bash, you could have a little snippet at the top to
re-exec with bash if (1) it's available (2) we don't seem to be
running under bash already.  (Presumably the Debian package of git
would need to Recommend bash then.)

TBH I was quite surprised, when I reported this bug some time ago, to
find that git-subtree was written in shell.  If it had been me I would
probably have used Rust and libgit2.

Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.  

Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
that is a private address which bypasses my fierce spamfilter.
