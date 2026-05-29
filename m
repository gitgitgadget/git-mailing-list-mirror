Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7C186284
	for <git@vger.kernel.org>; Fri, 29 May 2026 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068792; cv=none; b=cXiVKPvzyFzGp3bNJltbQnhlPqte48Ue+k9FqgDgaCJCI01TX9cQ6Tm7Um30dreFgUwdSJhARyw7yN7YxpMZN5TcR++2rSPAi+CMAlhHxj5W9NeqKABpKFLXTWwCt0R3aQ89sBCmKQrrNn+GrfPH2L5o5XDptHXrwjRNWmJor8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068792; c=relaxed/simple;
	bh=Mcwfrg1YtZCzIcRN5fcH58ePY7lvqDArDlt54czirkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hW6riqoM7AkArtdcBp1JfwlENAqXSsAl0iwr359NjSYf0OocT6vjhMwFC417R+VapsDfnTXbmeH6qbBeeQMqFT53gPKId6L48qEfvPG5Hcr2yORyz5aZdw0Sg101GAKT9c5U0X/9ksoWBhTyYf+zr35cMn7rZB9EsTsf2k8A1hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=XDdsZdq7; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XDdsZdq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780068779; x=1780673579; i=l.s.r@web.de;
	bh=uUqC0ohKN9nHUcgsQwy5vS93WvdLW5t2jxTsL/Bzbig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XDdsZdq7SFMLlh/cwNI+smryaWUNo6d5KptYq/8TOPIShjQ2S8XwUlUVC9D6+R2h
	 oCwUo+h9AZwa1Zz8t9bPy/wi/ApMsI92P5lCVVHgpYAOP2T7bvMF5rDNGiDMm1OJe
	 ziMF4nIwrEW581Ue8PL3GwL2Wn5+M9b3RhKl027CaCEGm/DjYxqLlChQLIlWt0pB7
	 SgSBDx64WpO62XtEIxp0f6xgPsTxuyx63Q57UOPPovksW5Z1UN+QXrCnrS61Tx1pK
	 WoBRFCrBIm6QtLC6tRP/HZzSes/5Q13Cw6WHcrKhQqNX1f4BEHfLgKEaOBgOjKi1e
	 6HstEsIsC98H3JKh5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUl9H-1wt8vL3sNF-00XliY; Fri, 29
 May 2026 17:32:58 +0200
Message-ID: <107314f5-0057-4ed3-9bee-9dca4f424bd1@web.de>
Date: Fri, 29 May 2026 17:32:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit-reach: stop sorting in paint_down_to_common()
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <450163b0-82c8-4b57-baab-a269efe430aa@web.de>
 <20260529084325.GF1106035@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260529084325.GF1106035@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MxnA4TCzeL+f5pVzs0y7z26KXUCt98IhsuBWhoBj+VbnLQ/eeDF
 gdm0tO6goEC0TF9ZO5OghIMtL7fTqKE3snidkEzsU6KztD9WQbnkCP0WQuSiuuDbIKzo3/8
 kJbhdiR3R/49yW7k7gTqjripOLVJaoXhkMFsnz7sF9sXAa/a2S9tvZN3Fq+cOuz38F3Auo8
 kcU0cI5NqEPqCxaWygW7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rLlDDIidED8=;j7DsRhlvB22ndnJ8v+0pKOZeQcr
 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
 bzs95bs9T9dsY7jZTqnpXzUBvMA=

On 5/29/26 10:43 AM, Jeff King wrote:
> On Wed, May 27, 2026 at 05:52:17PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> None of the three callers of paint_down_to_common() care about the orde=
r
>> of its result list: merge_bases_many() sorts it again after removing
>> stale items, remove_redundant_no_gen() and repo_in_merge_bases_many()
>> throw the list away without even looking at it.  So drop the unnecessar=
y
>> commit_list_sort_by_date() call.
>=20
> Seems like an easy win. If some of the callers do not even look at the
> result, could we avoid building it at all in those cases (e.g., by
> passing in a NULL result pointer)?

Yes, at the cost of adding NULL checks to paint_down_to_common().  Which
is probably worth it.
> I guess there is not much to be gained, though. The result is a list of
> merge bases, so it should usually be rather small. The benefit in your
> patch is probably not performance, but just reducing the size of the
> code.
True.  The list can be arbitrarily long, but should only contain a
handful commits in normal repos.

Ren=C3=A9

