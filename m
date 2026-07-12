Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA730568B
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783844547; cv=none; b=O6Y/P5zlwONlGhPmsxQON/NQcCZBzAWtps2VwcR6AqNRVNsaEdflqxg/kImT2hrdnUzrsCUzADsmkz4C3pL+B+M3x9ntDnWAHs1Y3Lli9wWzkiQlljPG8M60GYkF/3zmNwLudRWtSv+I8s8iAlOPHFf/7CxWRlfE9FqXP7fz9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783844547; c=relaxed/simple;
	bh=MXDfACnLo6eoSN0HUu9vr5XeQ2r69212U9cPQlJRc34=;
	h=From:MIME-Version:Content-Type:Message-ID:Date:To:Cc:Subject:
	 In-Reply-To:References; b=Aeej8hvkj2ynl2Fq2tNhacdjU7xDfuPN2XjGP0PnjHQXoSKBoE7KWdnyoVvT0+szVlg+F7MVm93Nm0rRVuGmbd2hxm5CR7SPbG6PGAoOTVGIRVFaMPZKeCBX0sBMa9zgd7lXFecO3wD2qe03/wet25Vtcbf9TlM0sPjShZuvCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=qiELoZhO; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="qiELoZhO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=n.chiark; h=DKIM-Signature-Warning:References:
	In-Reply-To:Subject:Cc:To:Date:Message-ID:Content-Transfer-Encoding:
	Content-Type:MIME-Version:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=pPvaQM1IAtZjts5HcOZ5Ffu7Rs/j5hNMbRmAJUUqY4A=; b=qiELoZhOFVhm
	ePLSObLlzlyjel92WM+pupBv4lx2uF0DVLSsPcbr0cuYcli/8V2l0R9gA3pSrxr44sxnG/2yaBwTx
	QnshWAT3gOtPpnQKeW/9+J+NX3KVIeKF9syNdAjbmxwFm+K5DzC74Hs46wX5ljdjZQBdylYdhfmwy
	Pt1UB8/XgIDb41no1V9giebntceaSQgseIqf8x+5SjSAnhCwi2e6lduFdbIXwovga5GmwIrKvZW18
	Z98TbO2AnhawMd3YCeU816sGwouQNCYanx4J5BnitKlz9kawA2VTvx9tN3tds11i0TFOtvo4UXvpK
	kye5GrxummQmTy0djWt2ew==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1wipS8-00008f-FW; Sun, 12 Jul 2026 09:22:20 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <27219.20156.438730.881821@chiark.greenend.org.uk>
Date: Sun, 12 Jul 2026 09:22:20 +0100
To: Colin Stagner <ask+git@howdoi.land>
Cc: Junio C Hamano <gitster@pobox.com>,
    git@vger.kernel.org,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite [and 1 more messages]
In-Reply-To: <a8c72dcd-f8d7-47ce-a4b2-ebcd4188875e@howdoi.land>
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
	<20260706115816.20267-3-ijackson@chiark.greenend.org.uk>
	<9ef8cfcc-ab47-479b-9f23-71ba99e1e56b@howdoi.land>
	<20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
	<f557bfcf-ffd2-4903-8015-97fff97dbe09@howdoi.land>
	<27215.27575.968985.583226@chiark.greenend.org.uk>
	<xmqqmrvx86wi.fsf@gitster.g>
	<a8c72dcd-f8d7-47ce-a4b2-ebcd4188875e@howdoi.land>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/82/820edb0643f8a4e1bef75ddcdc7927a1.pem

Colin Stagner writes ("Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust rewrite [and 1 more messages]"):
> On 7/11/26 18:04, Junio C Hamano wrote:
> > So, is there a conclusion after reviewing this?
> 
> I think we're expecting a reroll, but this looks like the way forward.

Yes.  Please bear with me, I'm travelling for a few days.

Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.  

Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
that is a private address which bypasses my fierce spamfilter.
