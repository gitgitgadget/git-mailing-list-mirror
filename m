Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C216F3C10A1
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370434; cv=none; b=TTSXErZ8ZrajNXblso6oAHCgrUrEuqChbcFn3DaWBf0hJsni32StlI+X/L8vN3kAddgyB5J0JoQ37JWF5//8Xs18UDj5dQlG5g5Xh2oSBm+gP0NMHhcJ834gSya72//PADf5SipeW+PkNdAGQiq+ccATRltT0NAm276+rGP1nxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370434; c=relaxed/simple;
	bh=DJn2zSUoa1FcTJEewFYfCl+94hnLohV5Fk3YsyQU1wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaiCia5/K4TDhUNYWpa81gxg+Eas8kTu3VWGnP4nNg39eG8UlRp7k8GPg8llgkJ4S4Q44qKy3oci45IwAV96tIzX/ddvE5M6ocOu9X4Bl9Js/9n4YFzRKdcytjFddBqw46HC5iono3xgPVU2V9AbDa3TtPau348n/sNIVTTWom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=ATcpVwG1; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="ATcpVwG1"
Date: Thu, 25 Jun 2026 14:53:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1782370429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvKAONwYk9H4cDyxdMUNmCIfKBb5zlMUgX7wTfL7uPs=;
	b=ATcpVwG1Mzd5E1BJ+JrVqSgxb78rrEGjgJFe2qiOCRj8vs/7crwi3ob2f9bqvvQRtA27Mo
	yuMfaC+HR/8vd5oDafHeq+Ba1Xh1KnWFOKbYun4cEDCd0NwP9KSQIk8dRGK7CDVrzyS5SJ
	CXHpJU87SGdFouUl1mnUoVKZUK7D2tjfkEqIPGYVqv70MaksGCyNlt2bKX/ZVNBEekDSHu
	srEEDfqMft5JEs2J2ZNxyB/72vMp/e0Lhfa1WE0eQQyCcvr0FiNfHqMKS/guNOOsp7bImR
	SUPsNHDCdp/Y4r9BlvwRWwBIWF/WTNAVKrM3b5ahWlRzDoCo0y6s+AHXiNijpA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] doc: advise batching patch rerolls
Message-ID: <ajzQdgkjGi4y3M0v@wyuan.org>
References: <cover.1781358364.git.wy@wyuan.org>
 <cover.1781714757.git.wy@wyuan.org>
 <496a08c74ddd9368587d032da7117520af1478ae.1781714757.git.wy@wyuan.org>
 <xmqq4ij1vywy.fsf@gitster.g>
 <ajVCD51lLvHreyJB@wyuan.org>
 <ajvDrjk-bTvYaQtU@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajvDrjk-bTvYaQtU@pks.im>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 24, 2026 at 01:46:54PM +0200, Patrick Steinhardt wrote:
> > But here I think Patrick's original intention is: If your series is
> > *close* to be accepted, (while I'm not sure what the precise definition
> > of this "close to be accepted", does it means: commented by Junio with
> > "Looks good", or reviewed by the community/core contributors with "Makes
> > sense"?) and this time there happens to be a small issue, you can
> > re-roll quickly to make your series more "sturdy" to wait for
> > maintainer's final examination and further merges.
> > 
> > So, I think the situation you are describing here is that this version
> > of the patch has already been declared by the *author* to be the final
> > version. (i.e. waiting for Junio to do the last exam)
> 
> My "close to be accepted" feeling is when you've had multiple rounds of
> design discussions already, everyone is on the same page, and all you
> got on the last review round is a couple of typo fixes.
> 
> But all of this is highly subjective, so it'll always depend and it
> won't be easy to codify all of that. Nor is that necessary, I guess. We
> really only want to provide some rough guidance.

Agreed, thanks!

> > Therefore, I do not think the two situations conflict with each other,
> > or are directly related. One concerns a patch that is already close to
> > receiving the maintainer's final verdict, where a minor issue is
> > discovered and the author quickly rerolls it. The other concerns an
> > author who, without realizing that some issues remain unresolved, rushes
> > to send what they believe to be the final version and then waits for the
> > maintainer to review it.
> > 
> > For the latter case, I think it would be better to add a sentence along
> > the lines of: "Before sending a new version/the final version, check
> > once more whether there are any unresolved issues," if the existing
> > documentation does not already make this clear.
> 
> I think that should mostly be clear with our documentation. And
> eventually, we should also expect people to have some common sense :)

Agreed.

> > That said, I am not familiar with how patch discussions have played out
> > in the past, so please directly point out any mistakes in my
> > understanding. I have to admit that, by this point in writing the
> > message, I have become a little tangled up in my own reasoning.
> 
> I guess that's kind of expected, mostly because many of these things are
> highly subjective and will depend on the situation. The guidance does
> not have to be perfect, you'll probably be able to find counterexamples
> for many of the cases.

Yes, setting the rules too strictly may actually reduce flexibility of
our project.

Thanks!
