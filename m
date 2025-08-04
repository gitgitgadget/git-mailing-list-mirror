Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC8522F
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298813; cv=none; b=PrA3rYMT9063+3Vo2mdm3GlfCGcppTcUCf96mStsGRrkpv7LFLuLIbemfIpuHZ3zYM7A/fhvmotcdB2QOzm4G+OoERwZ0XXsAH/T623huN4ny1qDzZjuaU5JHZiVPaWl6rG83/fNXo0pJrafa0V7qqK6PON/5j3q9ubI+K6zhB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298813; c=relaxed/simple;
	bh=1tIa7FnBQlHAkspqS39Srqn5JcUcEoCOC5g7Ste0E3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIhzM2+mSLCjmzSwz5mixrha4x5CZab7LuhYCX79+A/eOhSHXO1dGwEs6ZJ7g2+rqOspq3UBjemuKg9jm8XYZVwoKNYJSTxEonldphn2JCEFCiJC1btOZzUtDkIDImPZd5N8PuC91w8lA1nl9JpCYo/OQ3xz6Jmx0/CmBR7qgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=IQfgZUrm; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="IQfgZUrm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754298808; x=1754903608;
	i=oswald.buddenhagen@gmx.de;
	bh=1tIa7FnBQlHAkspqS39Srqn5JcUcEoCOC5g7Ste0E3g=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IQfgZUrmyMVwrSW/0lfb92xjPeIFgkWXqUAOH6EcgYJ4KMLHlWITvRTysQDuZfVc
	 OBm7loKMrXKI9uRUE69ShInXd+y/iHtoB85+Nd5Ckk6Ybo8u4/Wv5WubB9zGUppm+
	 fsk6df/rbmxUDyH7Ytm9o9jWWWhU9nXxZS51Dt85dfpUTVyyxvDxnhXeQu042ZGTV
	 OI/lCyLkQSjWFJTfT6VJWOgHkMyrG1odLVr34pnuv1KnnpEAiTGUFOhpEyKGzgvrp
	 5U9lrquW0h16eP3z2rMIz+E0l4mcBQMEH2vYx94RrMaMNIzULRdZzb6U967XWxhCv
	 q61v5O5dV35t1ZL6UA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.126]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGe1-1v9ymZ1xtj-00PE9P; Mon, 04
 Aug 2025 11:13:28 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1uirG4-rkn-00; Mon, 04 Aug 2025 11:13:28 +0200
Date: Mon, 4 Aug 2025 11:13:28 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
Message-ID: <aJB5uKFdGybf-IbN@ugly>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
X-Provags-ID: V03:K1:cPH/VyrRdXHXSXL0SaqWzjc/czQudEPYgoPR9xnTePd6MhI0Wez
 br7mUT9oYZv0Ds2vfA05aWIgbiqNFSfMAMmNIEktJgj47WTVcP7hwBjjqLtgj3VpDNaeqm1
 FkZFC08Xvrij5vHjSBYEJblbRdUuANLHtK+Zi1ACLUPZzSCX92y36t6l6WzCmvD3Ak1kLpD
 9vSnvBWgK7Kt+zu+R3Yfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2RhcEHHOpY4=;5RBjciM91otaq9p8t+1CLr/7ylM
 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
 DRISWUWyKu6pSKWVFAujzKw=
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2025 at 10:17:18AM +0200, Patrick Steinhardt wrote:
>When writing a new commit graph we have a couple of counters that
>provide statistics around what kind of bloom filters we have or have not
>written. These counters naturally count from zero and are only ever
>incremented, but they use a signed integer as type regardless.
>
>Refactor those fields to be of type `size_t` instead.
>
mind elaborating on that choice?
it feels like abuse at the semantic level, and it increases the data=20
size on lp64 platforms. is it even compatible with OPT_UNSIGNED (in=20
later commits)? that would be unexpected ...
