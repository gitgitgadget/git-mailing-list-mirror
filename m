Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7F737B41B
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477943; cv=none; b=o6IYGacps4jEBu9PqpsjaMzwhUnQ9nprca2MbHJ8DmyBoED4lzCCFp/mACVL87TwxnN/bvpveLrAq2jlz8ET60hlepkscKb8fLBlZFWRXSpBHiAF8ZQP+HdofyonmNQWD7alGxUFVTxE3/leZZV/rSy9E9kgQCfnV5dNJBMcjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477943; c=relaxed/simple;
	bh=Ub47UPIqteOFGjP/aebJ/8Xj59MXq7qwtXOfk5xhLow=;
	h=From:MIME-Version:Content-Type:Message-ID:Date:To:Cc:Subject:
	 In-Reply-To:References; b=D0jQj9XeOGsjIh9ay0q9JR2cdbdS0PAfmDGoQBepAkOk2wtEfJ9JBrLbAbHaHjK+fMhXEdgPL7T1ynoOtEj5sr6i/ezJ8rTSimClDQMlHhof4nqj3KMlUjM8o32zmh0xB2trwSQW1sg5t0sFg9HrhbPasUx/GPMzdXqVPHnde2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=t6I8Ogd1; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="t6I8Ogd1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=h.chiark; h=DKIM-Signature-Warning:References:
	In-Reply-To:Subject:Cc:To:Date:Message-ID:Content-Transfer-Encoding:
	Content-Type:MIME-Version:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=i4OD2x4q8IqwoML6oBux+K9Y8nrWiJNbfK0g+1/676k=; b=t6I8Ogd1pNYu
	du+D2uTsVLtjkHMJY/Zv+YzhHRTwZ6kCm3O7rPFDI62nKFV/aFfvWBqX6PDkYnL5rb35V+M2qAyKZ
	0azOoBbLXGmFTQ8k9SHXud+/huizenYNH/QbXIoobQa39BdhgG1sYP7Tu16SmAmfAKXUhRRzad6on
	A6b1ohI4jTVOQCOnUUGj+Xk0MyUv0ujFbhEHknQFw4dSJKENCV8++veLcw2v7w+1narP/XWrPG5iX
	sbeMDhhEuIwft65L3kr1Zzpl6NQMuU3lv9Iw8Zx22LMbmc8v/tHwbqsf16uUlKPomimZtEBqOKDzy
	rLhwYuUgdKEOIUVTedsPYQ==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1wUhdx-0006Ip-PO; Wed, 03 Jun 2026 10:12:09 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <27167.61417.729973.579902@chiark.greenend.org.uk>
Date: Wed, 3 Jun 2026 10:12:09 +0100
To: Colin Stagner <ask+git@howdoi.land>
Cc: Junio C Hamano <gitster@pobox.com>,
    git@vger.kernel.org,
    Christian Heusel <christian@heusel.eu>,
    george@mail.dietrich.pub,
    Christian Hesse <list@eworm.de>,
    Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
In-Reply-To: <0915b5cc-5cbb-4cce-a832-147f85d4ff1f@howdoi.land>
References: <20260215201748.889866-1-ask+git@howdoi.land>
	<20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
	<27104.58166.993109.63505@chiark.greenend.org.uk>
	<a1a07433-224e-4477-ae8a-3875fa98faf8@howdoi.land>
	<xmqqv7c13o5l.fsf@gitster.g>
	<0915b5cc-5cbb-4cce-a832-147f85d4ff1f@howdoi.land>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/81/8104ed637c14bbaffc5e235d8d481f3e.pem

Colin Stagner writes ("Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split"):
> On 6/1/26 17:13, Junio C Hamano wrote:
> > While I do agree that avoiding bash-isms in the main part of Git and
> > sticking to vanilla POSIX has merit, this particular one seems more
> > like an artificial limit imposed by dash than sticking to the POSIX
> > as the common denoninator, at least to me.
> 
> Correct, this topic is a workaround for an artificial limit. The limit 
> is Debian-specific and was introduced as a downstream patch in 2018 [1], 
> [2].

I don't think it is correct to say that this is Debian-specific.  The
limit is baked into dash, which is a non-distro-specific minimal POSIX
shell derived from NetBSD's ash:
  http://gondor.apana.org.au/~herbert/dash/
I don't know what other distros use it (or can use it) as their
/bin/sh.  I also haven't checked POSIX to see if the question of
maximum recursion level is discussed.

Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.  

Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
that is a private address which bypasses my fierce spamfilter.
