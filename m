Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43754425CEB
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012750; cv=none; b=XP67bzKmCHHgz6UhqOM9G1Gnll1f8cdeIY4oeYLTSTZ73lLDAa6mn/nm8PTcldkb3l3fDrzrJiW/eLZsDw5BJcAz7ICmwrpDgvJBG681DpsETOuA2EhNrfK0aGY5v07+iwynCZX8cBztZoiXYBN/EVf5RhavjXCN4bz4z3zGV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012750; c=relaxed/simple;
	bh=qg6KR9BPqriIidiDz1DEAWAB0neEeTTmwNYVt3mzOYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ttktOx7uhyaPgsUVP9DryZFabYaneHlZcYA4oXAF5Nn2Q56P9vdKmNvVPDxslP9UJdA3+MFNp1UQAzcPnnNIH9ldtyUdlD2sHhY5xmWtbvw5NzBH0iid/C70RlB9S/s9zI3rOA7sT9FAtHa6kWPQk5w0mzrTwsOYR4CqA2q/a+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZnFoL8+g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ExcurEYs; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZnFoL8+g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ExcurEYs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 127F97A00CF;
	Tue,  9 Jun 2026 09:45:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 09:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781012747;
	 x=1781099147; bh=8RQ3KBhPBUlgr4BvjUTvMaiVtHp6NOQHt/wqETO2TiM=; b=
	ZnFoL8+go7gUsPM3rYVvrBYG+r3AOgy9zcRpDROXZg77hO6QBCBsC9ZJdat7wtpg
	GnTGbX7JSbOiUlSvCiEkMmLWVcA8wrwKosmPD9iaa/8RIAE5353ePN3i25i5Y/gm
	Beiry1l+o5NfGc+sm+Tbl6pINJtqicWWF7a50QcUWLGVu4lH8PN3mzZB2ZxIkCDC
	VzismVS8l7E3zve+fv+kP5BimpqNaQoc5+NByZsBSPrHakoEYaP6sH9z4pop6lN2
	T4PfCJ4nUaFqYj64+AzBySEBj8XsQAuSTxhVCJyRCPqVC4jVw/25aYQ2mLf+fRW4
	8R2JEGE24SdSy4GJwF+oSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781012747; x=
	1781099147; bh=8RQ3KBhPBUlgr4BvjUTvMaiVtHp6NOQHt/wqETO2TiM=; b=E
	xcurEYsFLhHs3/XsMlsPBde8BrjOCejX440gFwLON6lpuXf8Gl1pwW9I3cv5A06Y
	U7eP347FkaK2NgImVkiNoggVusJ1vqbcNsPqwkbjk0GdMyKs1vuKVl6LTgUwPGh2
	VUd8cJbN/72FZNrx74nH5fG0Nh6en0qlbVN9+PyuDC27t5h6QEdzgX6J2N1bQhwW
	S1YzQdGUO0rSn3ecCEXe0bPx7Dy98sOHUws4uCYnEpyqppP0FWTVzfEGQoMsddJS
	pX86F31HXpmav5v8GwjAszvRVgSQKwbD4IsU5cs5jbr2AeqMfMu7vhMIG/mTCskG
	prrimQabLCAM1x8hC0SGg==
X-ME-Sender: <xms:CxkoanZRXQagEqWb_GjRn-fz3elV9svembSPORRccquT0QBrLaXYNw>
    <xme:Cxkoaoq3gfgEdo9HjEcMavRjoYVZtZhkuvW3pRcaida94XU8jPgcatP2wbY2FsEl4
    dfWUnzzGUjcitTCNpSRgqJl2kxRWFdP6iDrLgaOpHmppf0qLh7hIg>
X-ME-Received: <xmr:CxkoasP9nCQZh3N9jogReZybaD4EIwbT62ko4jI9CwKU4QnyW99OTH-u0Zp-YrDgexm06ueuwVOqYXznnpF-qbQbg5PfoVI1XTUu>
X-ME-Proxy-Cause: dmFkZTGpNn/+eNgd91ogFC1BO3sxqEJJ5m1ib/ghiIK7G0fMg9YNe5jLUBEU3mO5CDXUlQ
    crI5Qfm6OklI8hUyqGxAb7EfCATRh3481WwDe7KtKGVwyS1yvnRg8webLTOWJC8RGQMU4G
    bamSMVbj2PWbjSZPSrUb07A9j7ObA2azzPjH8XIg724zxU8vSuzR9XVBX0OgBaZByV9O7r
    3nG59lDiNlTycYfgets2F+IOYy3mjKB84g3xfIMWirx9skE3/C3BEKGByalEJRgdUEltj7
    bzhnaKexWi5VJOiVRdBUSJbJP0O54usPfFT4n4r63FeD9dlMVYBAEtTBqDOdYtvyeUsjAO
    hPMkg7O7/WPxrMTx2soroh9lc9iq+dKzMOboj1A14T52H1LznzpfgSNtYnoT8Gam2mAAIo
    OTmEw4SXPACF9vMu/h3In/M//Ie1yZp7Rw7qT94XQDxowCZ/8m5Il4HcgueRBIOWmIAlsz
    0xXxxE+SfIyJKgfbo8cHgBYzqiqMOzNSK1gflTLnlsqOpf2OaU9+XRYUDVslZLpb/v/8RU
    hjU7SToKS4mhqSRYi9zcyZY+1bY+nR8zmh4TXXNzq0h3NxjreUBxn4UWgATJ3KnfdvCG6I
    uEZBOYGOACfOtyWhtDqYzZ/HjkJyk3OCICb6JhkJMvMgMG8wFpsnp6kQYq4Q
X-ME-Proxy: <xmx:CxkoajqsSDvBpMPHnomLAnY52P8dTc4iNs6j642dDK4ME48dGOeRBQ>
    <xmx:CxkoahdF2uGFl2a09xFpcdmyaaMWWHoodt0wfR8IUgVskaAJ3vDEZQ>
    <xmx:CxkoapR0gzkSiIrYq6SDmg6xX2kwYGu6WSf43-q1vQGyzqeJKnjy8A>
    <xmx:Cxkoaqb2_9vSe-sMY94s9OF2yWLKQ5hYRFhHR3MZWZZz_sBckNAD8g>
    <xmx:CxkoarVNP8JDCswbQLhlHVdKcnfg721W1WHdjIivBfCECQP-KKu1Mv16>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 09:45:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v1 3/4] environment: move 'trust_executable_bit' into
 repo_config_values
In-Reply-To: <8083b217-4a56-48ee-b34d-b4596d45e382@malon.dev> (Tian Yuchen's
	message of "Tue, 2 Jun 2026 02:03:15 +0800")
References: <20260530160520.77859-1-cat@malon.dev>
	<20260530160520.77859-4-cat@malon.dev> <xmqq7bokebct.fsf@gitster.g>
	<e0d5b1af-b040-49e2-90f9-d8325682826b@malon.dev>
	<8083b217-4a56-48ee-b34d-b4596d45e382@malon.dev>
Date: Tue, 09 Jun 2026 06:45:46 -0700
Message-ID: <xmqqcxxzsu7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tian Yuchen <cat@malon.dev> writes:

> On 6/1/26 18:10, Tian Yuchen wrote:
>
>> That’s true: I had actually planned to start migrating has_symlinks as 
>> soon as this series was approved. Since you think it would be better to 
>> merge them into a single series, I’ll go ahead and do that ;)
>> 
>
> I’ve found that migrating has_symlinks seems to be quite a tricky 
> business. Some callers in certain files pass very few parameters, and 
> the call stack is quite deep, if I am correct. so I feel that adding a 
> repo for this purpose might be overkill. Perhaps it would be better to 
> focus on trust_executable_bit for now?
>
> Regards, yuchen

Sounds fine.  Thanks for digging.
