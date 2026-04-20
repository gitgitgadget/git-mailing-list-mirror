Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB05346A1D
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679048; cv=none; b=G1obiLGq07WuZVHMbRvnBx66nXL9Q8ld9by1Es3X4n/wrsT6o3ktfJogeCAS5bDyCqtY9WQT13S2IWyEUQQrgxzlcCdL5YwRfOl1cN6UdKnuX6bYgg2/FKEMRUKyFKOlolMcjgE+SXGl0cChmu7N7VLpoPT6e0sYc4ht0qAQGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679048; c=relaxed/simple;
	bh=iXLfnUtdR9AVEc5NPygsv7cRqhxz0Cf4MbnVj0I3V4Q=;
	h=From:MIME-Version:Content-Type:Message-ID:Date:To:CC:Subject:
	 In-Reply-To:References; b=X+f1tva9aY98mxn9V7GbW/PvE3tX5KgYwQB/IGtWEuNW17vs6yrn3x5zNIlqEx0x87o+8nsxGJPMNc1RIi/u/h+IimLFq6EFjZB6xbC4hGUFezfSmuaKenuUO/4xv1ozIoJL4/mM1DzeQiI7EW+W4xNHCoY7mXnQg0F1cum6OlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=P3LflKtx; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="P3LflKtx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=k.chiark; h=DKIM-Signature-Warning:References:
	In-Reply-To:Subject:CC:To:Date:Message-ID:Content-Transfer-Encoding:
	Content-Type:MIME-Version:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=v1kuHroWNwB0+GF6xes8zLCTuyRuwsakfExPveEhpck=; b=P3LflKtxr1n+
	ywLO6ouMtsXwG3vwTLMor/uA5h9P8mRS2Ch08gLEGXzy4D4kGRm6IoIHqKT2+uG9mFJQoHB6HQM3/
	Y+SAMyKKXRbV4bAvXKwFnPabnMgUNC/TpCbxVwK+vFNhHf9fnyigHScKkRARjDgkKK71gZW9bumUi
	6LA/Xm3Xtu4LVw2o9Ab/KLn5SCB8HK3aB4POKlDYyTt52TUzop97dHkldK/BNDnCbTgMIEdO8BSDy
	ZObtLXyjTzD8EHbS13JEJDQBtsx4iivvfYM4uu61cMXlK0SryO8m7DRIW5HWlgFbo8RfOHv+BpSeR
	WqEPU7b8XDtfAvCAdHjsuw==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1wElNb-0006Ds-4r; Mon, 20 Apr 2026 10:57:23 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <27109.63619.90318.366157@chiark.greenend.org.uk>
Date: Mon, 20 Apr 2026 10:57:23 +0100
To: Colin Stagner <ask+git@howdoi.land>
CC: git@vger.kernel.org,
    Christian Heusel <christian@heusel.eu>,
    george@mail.dietrich.pub,
    Christian Hesse <list@eworm.de>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
In-Reply-To: <27109.13129.424068.382997@chiark.greenend.org.uk>
References: <20260215201748.889866-1-ask+git@howdoi.land>
	<20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
	<27104.58166.993109.63505@chiark.greenend.org.uk>
	<a1a07433-224e-4477-ae8a-3875fa98faf8@howdoi.land>
	<27109.13129.424068.382997@chiark.greenend.org.uk>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/67/6720eae2c8ba1e796437a231277957ec.pem

Ian Jackson writes ("Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split"):
> Algorithm
> 
> I don't think it is going to be possible to precisely reproduce the
> output of the existing git-subtree split.  Indeed the existing
> git-subtree split is a bit cavalier with metadata (eg `committer` [1])
> which probably ought to be changed in any case.
> 
> Even so, it should be possible to avoid foolishly rewriting the whole
> history of the subtree, since we can stop at all the merges made by
> "git-subtree merge", which are easily detectable by the extra metadata
> keyword fields in the commit message.

This last part turns out to be false.

It is only `git-subtree add` that puts this metadata in the commit
message; `git-subtree merge` doesn't.  This makes it very hard to
distinguish a subtree merge from (say) a merge of a branch that
predates the subtree add.

I need to think about this some more but I doubt this can be made to
work well without more significant changes, including to the data
model.  There would have to be some kind of compatibility arrangement
to handle existing histories.

Colin, is that OK with you?  If you would prefer, I could choose a
different name for the resulting program.  My preference would be,
with your consent, to continue to call it "git-subtree", version 2.

Regards,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.  

Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
that is a private address which bypasses my fierce spamfilter.
