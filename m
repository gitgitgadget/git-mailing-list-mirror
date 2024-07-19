Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3691474B4
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721411343; cv=none; b=Zf/pWZCnxxFs/uttxBSmRA5CcsM6cka3e0tyoU5/4XKaLsnaU4iqdZnOT145bpMwFx/ed2EMf2/iLjy5m4FbTKBAHXEI5rX7KHUyq5WyghglQMynhCXNHjllfzHChzFeIb/NBREZzyZbi/6wmR5eZ1aatwWbVQcCXn2qgrUoxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721411343; c=relaxed/simple;
	bh=YVTFVIm2+5AcVs9Waq4tOmKBlSps/To5RztSOM7wNFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sxWNRTIKfgxseDH38cwJ2gXwLC65CwvXCmMOW5V7IGoRRgtZgz5wtRdNNC5LoGi5/ocnLp18tNixq5lxcH5BnPhyAh1Wu8fzsV0IykawZdAj7ero5Q3BZKTL/3BGWML2aWgazlRHMOg3iRYROyqM+J0NgWI8F5TYaOM9iWab82Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Ez0kpCuZ; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Ez0kpCuZ"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 8B4A0240027
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 19:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1721411332; bh=YVTFVIm2+5AcVs9Waq4tOmKBlSps/To5RztSOM7wNFU=;
	h=From:To:Cc:Subject:OpenPGP:Date:Message-ID:MIME-Version:
	 Content-Type:From;
	b=Ez0kpCuZ//17MZemryzCKeh5PLrPF2/aOz6nHgAHixoCCh+luLJy2TSrCmAwGEUnW
	 wbimtXh0H1Mhutl5hBCFUMKUHCCNrajakKnccG79O1z1UVP0sptraMhC8mEr/4oj/+
	 c+h3vg9/t8y9CDTg0+e1l6qxcK9NM4GAsV9pqyTIKvVcs41JDbP/LmtFzvbPSRM2Xt
	 Tu7zbCvnv1SOQV5S6QNniL1XleD/xNJOjt2T7rygbAP4UK8H2DblvrqV3L0zrJ7QOd
	 iRW5B+Dyiy/VtfjW+SoqiGF+9QLoFDlYWo8NY42ywxbdoAnCPhuOWE+a8D3BMx2kOa
	 Ru20xlpTyYP3w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4WQcc402H3z9rxD;
	Fri, 19 Jul 2024 19:48:51 +0200 (CEST)
From: Philip Kaludercic <philipk@posteo.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Best practices for indicating what address to send patches to?
In-Reply-To: <xmqqh6cmzspe.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	18 Jul 2024 07:21:33 -0700")
References: <87msmfrn3r.fsf@posteo.net> <xmqqh6cmzspe.fsf@gitster.g>
OpenPGP: id=7126E1DE2F0CE35C770BED01F2C3CC513DB89F66;
 url="https://keys.openpgp.org/vks/v1/by-fingerprint/7126E1DE2F0CE35C770BED01F2C3CC513DB89F66";
 preference=signencrypt
Date: Fri, 19 Jul 2024 17:48:51 +0000
Message-ID: <87msmdmfwc.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Philip Kaludercic <philipk@posteo.net> writes:
>
>> Hi, I was wondering if anyone had a good suggestion on how to indicate
>> where to send a patch to.  Ideally I'd like to have "sendemail.to"
>> configured on cloning, but that isn't possible IIUC.  There also doesn't
>> seem to be a conventional file like ".git-email" that would list where
>> to send a patch, without having to look it up.
>>
>> Is this intentional, has it been discussed in the past or is there the
>> chance that it might be improved upon in the future?
>
> The usual convention is to have the patch submission address (if a
> project uses e-mail based patch as its workflow) together with other
> rules and guidelines the contributors are expected to adhere to in
> documents like README, CONTRIBUTING, etc.  As an e-mailed patch that
> does not follow established conventions is not necessarily useful to
> the receiving projects, it is a good practice to put these pieces of
> information crucial to start contributing in a single place.
>
> It would not be an improvement to add a mechanism to make it easier
> to find "here is the address" to a reader who hasn't even discovered
> where these contributor guide documents are.

But is that an argument to prevent projects with mild or now contributor
guidelines to make the patch-driven workflow more difficult?  I've often
contributed to a project by quickly checking out the source code,
changing something and then sending a patch (this is easier in the
context of Emacs, because we have the a `vc-default-patch-addressee'
variable).  My suggestion is by no means to mandate this kind of an
option, but there are situations where this kind of configurability
would be useful, e.g. for Sourcehut projects.

> Thanks.

-- 
	Philip Kaludercic on peregrine
