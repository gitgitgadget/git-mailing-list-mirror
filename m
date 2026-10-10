Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7D13A258
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791646647; cv=none; b=YU3e8jx328cm411JdMRwxhINm1ubmWYFNzSdnxm0Hjp+aX/M98+92/PmnUcfI4BK29nRJDmKtJNxgOVCIGP4whsx4ibBh+IluUlozX7qzspwgCyMBPJRs3Di8bSLxG4Bhd8IySVCVO6maKEPJMqkGpHdg6tQ6DWbDQmaUFQfd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791646647; c=relaxed/simple;
	bh=3P0HnwOXnEZX3Fm7CLrHePSlzE61OvM+PZDbMERrojE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIDRfzjHEpzafnuuZhQoQPOguHMK0EjShq91z6dEhoRdFVkUaPlPCwTIuplbVQa0I/T2/reiqkJy5i8S3VMQWpeybXAlo5VqxxgBTXgXad3fYSW3UJYig3RB9SGckeo5NHCDI33lNG7UlpVUlSomZYulwmyHRknzKELegEKjcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i0Cy+OzH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FTFTnhDZ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i0Cy+OzH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FTFTnhDZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8809C7A008A
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 11:37:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sat, 10 Oct 2026 11:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791646643;
	 x=1791733043; bh=RHUSNZ3joo+6SyZXQW3p1I5rFW4ZPyRNFpRPvvzShVg=; b=
	i0Cy+OzHZIEE0gpgRZt/t5lGjtHVeXy8+hylyjRnwr/WbYrZdIjWr4KcDxLCg3be
	hiPhCmynxncNHqETc79rl6CVAswjPAHAm8VWMFrEIBW5SJzbyhwvNFTJkPTQ4JpS
	28mB9q+5hBBtKJTn2eelMJfM+eh6mDxQeiwfC6TKmX5MPu9EluMf/SOgCgk0fV/h
	RwBOmb7jxuyd2z4VLtBNjMHMa/w7jtfN3fm7CY2osGURuysIV+GmCQHapxclZnG9
	WmZZaQPL4MDuLkiPWuRCtBsGbtzDp2EtaJexjFejSFLx4wGTAtWx1+TKo+ZleXVv
	ZfFyYkyYpOqJZL/xBafr9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791646643; x=
	1791733043; bh=RHUSNZ3joo+6SyZXQW3p1I5rFW4ZPyRNFpRPvvzShVg=; b=F
	TFTnhDZilikCSsYxO0bou2EI8wFlGOme/cMy/fq0zJpGS3zxRZKPFn5+7tn/Lfko
	a7ZLf9VhAmo2XNreCph7VhyYNuRhX+lxYPQzsnbJVqOaM5sRpxmQVL307qnrumRc
	zXNevmmgz0I2O3ALARq7QrubPuKT69x0HSNX5BPdnWNAehwlUIJD6a1f+r+QI/x/
	xouK48ELTzZc93KCU1v58AvCA74cGNOVHQUgdU8LL1iaeoW9giufbe6ZPjYyOv5y
	KjVU1MAhYQ2mxwcv5rhPkiA1R8r34y2yp20lq7eBnB4wIZ1wRXxtlqNLMxuFhmXt
	zu8vicvjqL2B2PZdZ02yA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791646643; d=pobox.com;
	mf=PHRtekBwb2JveC5jb20+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Vy/emV96LM0U3WeaetK+G4nOw95SvMQl2yMwjPV8HhINM8r
	CGl+vz+lspWUk5Hq8hJvMwD/PAo6PAgFXqMxRZ2vuQ1yS+lisvtrSr59V4+VuKGC
	8biwmMqYpNakgQUl0kmcNYa8C+zqE1I9HTs0ZDCrd0MF2VtASzg1RdgrtSMq/A+f
	d0Vla/jcaZ936n85fq+Gy2T8bmO+xD2DNvlHBXp/Q4cYzsIaabzQEYO7TJHyt6fd
	sptyDBbnJqXOqSnlPw4z9m+SAPHud+SvePQIJ0Dk+9Zncl8hvzNZenOtVNYdKdo5
	2h6zg96X3EII90KrAsIxpUq+NWBwispmYpvqJ6g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Szz5X80UkpajNm629XJLN2GLpbST/hilttaR4WgotJw=:3P0HnwOXnEZX3Fm7CLrHePSlzE61OvM+PZDbMERrojE=;
X-ME-Sender: <xms:s1vKaqsLhWp1093W7wDgRTm79wBCJ0wClNXRWcy6K2J_MFFA03tghw>
    <xme:s1vKahuek-0kj6hcX6OhE8SY62PLqgJzFgeAs4P2xSE26hKNvVHI9cMswCKwfQFwM
    o9kS1qCP-1CbMRmRwobzc5Z2AOA5We_xyGxQGLmXBqgxwUmLr9XAME>
X-ME-Received: <xmr:s1vKaoBvDt4QDmCfvhLKNtYKxTbr6egU3U6wmBbxRFzkeehdbyvRTiPjlM0lNui04JJD74i9ozAshGtRfcTJ1rUaVD0Nk6ujdQSLXlOBTGuhHXda_PvmKx4>
X-ME-Proxy-Cause: dmFkZTGFHvrb4Ot/LcOhAoAtCmUU4H1Teu5QkF9kId4lLtRriFxSBQcvsXKHtPSwtUYv8T
    9ooAthIpyv2guRocZDLghDe6Vza/SpDcTrdA72hmt1a06WJdmBsbQnbj5mAqykTVOZDji4
    wA4QT4QsPoGRl3PYKUJaP5YXngYDc8eO/yhvDlFR2qCOB/fXb907k0kL3mZr8T1wREP4SW
    O2cbcJgrkYs9MapL5mtsMClog2vEeCosEPXB8IfhPKQDw3XAgD5GE6aFxFasnS04oVOAz9
    MrkiHCaSPh2bKNMfROookbpbsNkS8yq+Xodq3w0esATKJPHj9ao82FRI8p5N8zKul5G6kv
    UDrXUFqMdLNurGEOUgyg+1/rpxSYP99eClXKHY/xHgqfmezyPi+9n1SpDF/8greeoEFSpH
    w/EG+p6FDvbgpg2vPfunl6KsNFSlJ1xFSIFHzFSLKCocT5SNZ8TBPXGF4+O5ddNAkmPTkx
    uLNkcNTclyd2w3lbgAgfcJZw3ir/ZpO/UUSa7cdnnSyEQzzSQQGi7FIUP5f/g1gbSHeBg9
    JUa3HNMlGH7k0/4lle8KRMOknx7gcWrgU8FhnE+L+W5ts7n8NtuYKu7lHjj796gzlu/ZdS
    PYWmJbkGO0WQv6eoUrlvvkdHnXOrc+JbTdOhAELBMp1EdPDYuODTIA9ZZcuw
X-ME-Proxy: <xmx:s1vKarPnAd3QdDUXN_vEic0tZZPqx0UuxRyDanXhPS3LZWA8NKVTMQ>
    <xmx:s1vKapxNs-oGH3kuqQeHo88q1nNmx3tOUJdPdyyJXZ4daDBTIswGMg>
    <xmx:s1vKajWTLyyBL_a51-NUAjHiTyNK6JnFk7c6oa1CkfXCbFpG8SUhdQ>
    <xmx:s1vKajOnOa1c8fuYiS-clIrWhuDDD5KH3isQ-8Ow560_exceKd7j-Q>
    <xmx:s1vKaq-RPzhf6xgzzampDkuu3W7T4SRs8K4wIBADT4UNozyNle7qaqSL>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Oct 2026 11:37:22 -0400 (EDT)
Date: Sat, 10 Oct 2026 11:37:21 -0400
From: Todd Zullinger <tmz@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Sam Reis <sam@opencanopy.dev>,
	Sebastian Thiel <sebastian.thiel@icloud.com>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
Message-ID: <20261010153721.943RqWnW@teonanacatl.net>
References: <20260929112544.86511-1-scott@gitbutler.net>
 <xmqq5wzda0h6.fsf@gitster.g>
 <CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
 <79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com>
 <CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
 <CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com>
 <20261009203749.x4V9kN18@teonanacatl.net>
 <CALnO6CAEcjieW48DkA9Pt1eqZ5hctwihmTXMxZ29YBrmzrp1QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CAEcjieW48DkA9Pt1eqZ5hctwihmTXMxZ29YBrmzrp1QA@mail.gmail.com>

D. Ben Knoble wrote:
> On Fri, Oct 9, 2026 at 4:37 PM Todd Zullinger <tmz@pobox.com> wrote:
>> Fedora's Git package has:
>>
>>     BSD-3-Clause AND GPL-2.0-only AND GPL-2.0-or-later AND LGPL-2.1-or-later AND MIT
> 
> Oh, curious! Where are the (using Gentoo identifiers for the moment)
> BSD and LGPL-2.1+ sources? I guess I assume by looking at our COPYING
> that the GPL-2+ came from contributions that said they were willing to
> be 2+?

There are various bits of code imported that are under
difference licenses, among other things.  The code in
reftable/ is BSD-3-Clause (using the SPDX naming), for
example, while xdiff/xhistogram.c is BSD-3-Clause and/or
EDL-1.0 while most of the rest of it is LGPL-2.1-or-later;
ewah/ is GPL-2.0-or-later; compat/obstack.[ch] and
compat/regex/ are also LGPL-2.1-or-later.

I used the perl licensecheck tool¹ to generate the initial
list, then reviewed it and filtered out some bits from the
test suite which are not shipped in the binary packages for
Fedora.

The command to do that is (without the filtering of any
code):

    find -type f -exec licensecheck --shortname-scheme spdx {} + |
    grep -v 'UNKNOWN$' | LANG=C sort >licensecheck

A more complete analysis would require reviewing all of the
files which are UNKNOWN to ensure none have a copyright that
licensecheck simply didn't find (or isn't in the file but
can be found from the git history).  I was a bit lazy and
didn't do all of that work. :)

> Anyway, thanks all! I'll assume the Gentoo maintainers knew what they
> were doing :)

Yeah, I've found most distribution packagers try to be
diligent about this.  Though it can be a somewhat tedious
tasks and can change if the distribution switches from
expecting packages to list the "effective" license to some
other method.

Fedora used to do (or allow) that license simplification,
e.g.: boiling down our distributing Git to GPL-2-only, but
clarified things a number of years ago to not do so.  It
ends up slightly easier to just enumerate all the licenses
of the code which goes into the binary packages we ship.

¹ https://metacpan.org/release/App-Licensecheck

-- 
Todd
