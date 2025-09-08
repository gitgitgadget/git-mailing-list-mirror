Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C352C859
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351780; cv=pass; b=Qv+4OKFuCpdHYTq1yF3he2/72KnVIzu+QMmJX6Z/rTkrRl5sVcG5cLkKBAKiGqygJtbXXWFScV7dtZWNIM3I+H+An+ooHgk4E4TsWomD/UMQKPpJ00/7cGZCXuPKumb8Rr0Kc9Ckk8yszfClVS3DDCQ84YjnvovS7lhvBblxmDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351780; c=relaxed/simple;
	bh=13GoLXUPA5NZQDVnvYblVIm/wxBcdi915QZGHEF3WKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lBbL3u3fHRJy8Z/tSGOYLmojFTkGK1Yr67IWvtaju38eYcgxt47UzYttXa/vJ+ktpWXuV50zymsa2RD9UpDPjW3mkPyI3A7hy2bfeb2NW4FQRUGpmVG9NbZUl5pKzGncRqsPGJMmzAadkMZGPoNq/OobW1Q74iAj8vU67LE5KSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=hXVI4khE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="hXVI4khE"
ARC-Seal: i=1; a=rsa-sha256; t=1757351761; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UZ1O4G2l4LHlyM/B592MbutTl9ksCcaLX3aM+Ms+3hgWFRXpntp/P8qFYckDw/sO1IYb5XI6qqGxL1Gb+7vza1Zlyqw14J74Pf7aZngw+xCXRs1etCNvFhRKs0AKnEoOE4jMVVkTNJOFOY1BOoXFSPH+RDGTlDBjWOpQcqYN/ds=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757351761; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RPdnQfkVNYdn72HURkZZe+yZmiYRHcmHR7slbF+sY8k=; 
	b=YydKvp1KJIkmN3dobGECzj5gQOnibTx9UJ+h3PhlZexeWeEBCOR9V8OEa/9Ef//pVpcmDstuUVpRggyRQUlOPaG4I9IGCVP5/wbA0MsX0dlHn4ksuEqO/gxatvY02fiD0CeU5AamwCpTStCwEkJTPwbdIhe1NYCDE+89soC4dDw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757351761;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=RPdnQfkVNYdn72HURkZZe+yZmiYRHcmHR7slbF+sY8k=;
	b=hXVI4khEIMrEN+bMOhZCuCmPpFFIcsrVM3JSWDzlOq2jpX7S3pJjl2hzLhpYXbEX
	yl0jXIInafBJ3EsO2bvZU6Wd/DrFElCpqTnTChBkKf2PQBFc6yqwtinrZ/SYr7OquzH
	Mtwstqs68ElaWFVM/0Aiom28VcAWl6TCD5zfG6ms=
Received: by mx.zohomail.com with SMTPS id 1757351758309633.6855853229439;
	Mon, 8 Sep 2025 10:15:58 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan Nieder
 <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 07/10] submodule: error out if gitdir name is too long
In-Reply-To: <20250908155146.GA1308482@coredump.intra.peff.net>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-8-adrian.ratiu@collabora.com>
 <20250908155146.GA1308482@coredump.intra.peff.net>
Date: Mon, 08 Sep 2025 20:15:54 +0300
Message-ID: <874itcoofp.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Mon, 08 Sep 2025, Jeff King <peff@peff.net> wrote:
> On Mon, Sep 08, 2025 at 05:01:14PM +0300, Adrian Ratiu wrote: 
> 
>> Encoding submodule names increases their name size, so there is 
>> an increased risk to hit the max filename length in the gitdir 
>> path.  (the likelihood is still rather small, so it's an 
>> acceptable risk)  This gitdir file-name-too-long corner case 
>> can be be addressed in multiple ways, including sharding or 
>> trimming, however for now, just add the portable logic 
>> (suggested by Peff) to detect the corner case then error out to 
>> avoid comitting to a specific policy (or policies). 
> 
> Thanks, the compat logic here looks reasonable to me. 
> 
> As somebody who has not really been looking into or thought 
> about the topic at all, though, I wondered how necessary 
> pathconf() is here. That is, I can imagine two alternatives: 
> 
>  - just try to use the path, and we either get an error from 
>    open()/mkdir() or we don't. This would end up with roughly 
>    the same outcome as the current code which calls die(), 
>    though it would not help with eventually fulfilling your 
>    TODO. 
> 
>  - set some arbitrary but sane limit (say, 255?). That would 
>  make the 
>    behavior consistent across platforms, though it does mean you 
>    might be prevented from using very long submodule names on 
>    systems that could support it. 
> 
> I dunno. Like I said, this is not a problem I thought a lot 
> about, so feel free to ignore. Mostly I just notice that we have 
> lived for 20+ years without pathconf, I think mostly by 
> following the philosophy of the first bullet point above. 
> 
> -Peff 

I can go either (thrice?) way with this. :) No strong opinion.

1. Just let the OS/filesystem default do its own thing: not doing 
anything is the easiest and perhaps the best approach sometimes.

2. Benefit of hardcoding: we already hardcode NAME_MAX in 
compat/posix.h for platforms which don't have it and fallback to 
it. Might as well use it and print a nice error.

3. The compat layer allows us to at least try and detect the 
corner-case because we slightly increase the risk of hitting it 
(say you have a module name with length >200, encoding it might 
push beyond the limit).

Right now it's worth it mostly for the error msg telling the user 
why the command fails because a default -ENAMETOOLONG might be 
confusing (the plain-text name could be just 200 < NAME_MAX), 
while also opening the door to avoid this situation entirely by 
addressing the TODO.

Again, I'm fine either way.

Since I split this logic into a separate commit, we could even 
drop it now and bring it back later when (if?) we decide to tackle 
the TODO (series is big enough already).

Thanks,
Adrian
