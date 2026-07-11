Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325328B4E2
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783799913; cv=none; b=tKXgWsn2tb8FvsO9Rp/QQ0uqBAP0sivE1bpqpEBFJudLrg4U6fPGFe9rpuOrJkAuyA5Ikd3dw4vBJA1zG2doF+w0cJNQYDEP6lLa6OK9GRV8t6UHhIIkbp7DP73pYfQ+ecQwtMQelD2BanmlUosz0B8xrLqi22NY7PIRwbQF9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783799913; c=relaxed/simple;
	bh=AiWBlOBa+wcLeK1/fGileVAPmVhj+2FrmjdBHVsxfNw=;
	h=From:MIME-Version:Content-Type:Message-ID:Date:To:Cc:Subject:
	 In-Reply-To:References; b=RsGx8s1zDeE7GXCORRoGOmp405zvUfPth9ZmucbJcjXOLjabFTXlIlfDLDpqnNkDwPxkFpheEy53wmPmM8dEwye4F5lH0Pkh3XI8M2USHpBZ4dxo1qqACkurWBIyI/pBwoW65eXtbKuwEbj2SMTRlBpenLiYSp1exacsob3R+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=DifJlxyJ; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="DifJlxyJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=a.chiark; h=DKIM-Signature-Warning:References:
	In-Reply-To:Subject:Cc:To:Date:Message-ID:Content-Transfer-Encoding:
	Content-Type:MIME-Version:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=Xnp+sOoCHZff8t2lV3nEiu5zFECSK1fxYTqo2tp9KrU=; b=DifJlxyJYDvn
	KJks0KClYKQZqHzOLu1CkJOM5hk00VcG8/N1byNuDLFu+YrfZGwyme3EhKVqbg8jaFCl5ZYe7TGDi
	mfruuYUhYinpKZ0wBdiqvm0oshUj4CevG6X0ixhZhxMTiSNGcDE0PUitIxDWMacxm4J5DWBRwXt5P
	Jrn5pDf+HvkqH0t7l1v2iHKTHdBlrMZQl0VR4+awJJINPjQ/ffHMavF0VTqKhoSI0NjxP2WghC3eL
	W7yYddUZtOIrVkE+UTq8SUDmeIV6Xub2s5mqPcS+xX5SoZe9NvkUOAPI2WAbyDh6oyK/ZRNXkUAy0
	gKRhrbqqnH34YjdplDtr6g==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1widq8-0006Jj-BS; Sat, 11 Jul 2026 20:58:20 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <27218.41052.331367.161844@chiark.greenend.org.uk>
Date: Sat, 11 Jul 2026 20:58:20 +0100
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Colin Stagner <ask+git@howdoi.land>,
    git@vger.kernel.org,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite [and 1 more messages]
In-Reply-To: <CALnO6CAPMEjVsj-5X9VyUtGM1JipXj6g_0JrC5gk37s178G02A@mail.gmail.com>
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
	<20260706115816.20267-3-ijackson@chiark.greenend.org.uk>
	<20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
	<f557bfcf-ffd2-4903-8015-97fff97dbe09@howdoi.land>
	<9ef8cfcc-ab47-479b-9f23-71ba99e1e56b@howdoi.land>
	<27215.27575.968985.583226@chiark.greenend.org.uk>
	<CALnO6CAPMEjVsj-5X9VyUtGM1JipXj6g_0JrC5gk37s178G02A@mail.gmail.com>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/53/5357aa8c73097c9c5d99f0fdac692996.pem

D. Ben Knoble writes ("Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust rewrite [and 1 more messages]"):
> Just to make sure I understand you (I regularly use -X subtree with
> one project): the Rust rewrite won't support -X subtree merges, but we
> don't intend to discourage folks from using -X subtree merges in toto,
> right? Merely not support a mix of the 2?

Precisely so.

I think you may find my git-subtree rewrite superior in ergonomics to
git merge -X subtree so you might want to switch to it, when it exists
and supports that transition.

I haven't yet thought about how that transition ought to go but I
think it might look like what I'm calling an "unmarked subtree
merge~.  I've made a TODO note in my working branch to remind myself
to consider this situation.

Regards,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.  

Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
that is a private address which bypasses my fierce spamfilter.
