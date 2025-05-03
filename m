Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA04C85
	for <git@vger.kernel.org>; Sat,  3 May 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746260582; cv=none; b=k0VjAueFM0dZrWvoVPZeZiE/gQ2MRB2y3N5qlcQDUyxagvKZcG9jQsDNdX6yPBFR0Dret7lSeKacGH9bq+Cg89PotTxAHCoRioI1L/Ss2Nc9S5BpIoeZMt7YCQw2UczY49kXXMyTt66Fhprl9BLuCXqjUqbBM/k+F9KgVxOmQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746260582; c=relaxed/simple;
	bh=Pq7x9o+2+wKsr/FdcPPhcJ3joXBkKXDxxkPS2LDb2N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kgf/L+sBmiWbWBSCfzIoHtyYbxBO5Thv8kNLK+59IMZ/bxpdk3S0DrSqU+1cErPZGex31TtZfFBfxZILt/Ok/1w/bhq2ggMIbOgnUKMYLpoNrTuKzhZdKxO4ZMgeAB3iJITi0g2hU7xF3stEctgbM4HIcCYCgVkEtGE4RL+as94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=zzWxRc2J; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="zzWxRc2J"
Date: Sat, 3 May 2025 04:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1746260577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LwCIoVE1LK6MlbxyXK1TNaL6IjbugwVUO6jn9SHCT78=;
	b=zzWxRc2JJyFzIJ7yNVB2RlN8xZfRUf/Xtua9qTiLQREci5Mz72Z5tjq8OpPTCBmbnH6cQT
	neMUGiuMr7aH1so1p/j9DH4KWHCmstHxHE5/4LbpI/Plt6rLinCntnsM5Rx3vAYCddWmvT
	J8HSiQpVKqYq7u8fzBLqYFcEChhkYmg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: Ryan Hodges <rphodges@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Jason Cho <jason11choca@proton.me>, 
	"git@vger.kernel.org" <git@vger.kernel.org>, "aclopte@gmail.com" <aclopte@gmail.com>, 
	Ryan Hodges <rhodges@cisco.com>
Subject: Re: [PATCH v3] apply: --intent-to-add should imply --index
Message-ID: <5xsywkqp5nctahl26yb6hrhv5sytbzwvhxqvs5y74e46xepmxq@j7o5kxivw24x>
References: <93yuUC_Wn9lQIDzJuvAWbCQ35kz1YxeNhsLLX67x9VzoPtRugVLNaHC_p1sWBzMxWy_VVRRl8av3Dx5PHw4_Cch0gmWs40DDrZRaezLVkGk=@proton.me>
 <8a61dc13-0b7e-437d-b060-c17bff483c7a@app.fastmail.com>
 <xmqqmsbwxpfn.fsf@gitster.g>
 <ED60E13F-F9D4-4261-8C85-29AC771B5D54@gmail.com>
 <4e2szrowd43w6lrzawqtddamdxvp6ke65jkzmdoru4gjin7xhn@kaqe7skrktgt>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2szrowd43w6lrzawqtddamdxvp6ke65jkzmdoru4gjin7xhn@kaqe7skrktgt>
X-Migadu-Flow: FLOW_OUT

On 25/05/02 11:51PM, Raymond E. Pasco wrote:
> However, the code appears entirely correct. The combination of --cached
> with -N doesn't work, despite the message claiming it does, but it can't
> possibly work because it includes the file in the index, so it can't
> include it as an intent to add in the index. So this just merits a note
> that --intent-to-add is mutually exclusive with both --index and
> --cached.
> 
> If the original author (Johannes Altmanninger) isn't around or doesn't
> want to, I can clean this patch up for resubmission.

In fact, I've just discovered an additional issue that remains even
post-patch (it tries to apply the whole diff, even parts that are
not new file additions, with ita_only on), so it needs slightly more
work than implied above to be complete.
