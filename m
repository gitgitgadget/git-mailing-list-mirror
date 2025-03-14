Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60D282F0
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741971736; cv=none; b=G9gyo0vsqRx2xOG3PHd3FE3A1V/b+uYaZ/wfNHFYXQvSp8H99e71zKVATDoinDZM5+3WITixL5uOicC1xB95CcfliByg3PmuhRNtzGMlP381c9nEjw1Xv89y4ii+SpFsyL4gbMsS+2Gg9/zfp+yHlEmbmeivxyMXSpuxdKWygO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741971736; c=relaxed/simple;
	bh=R9XgLbrHfdJ78Ryt357G2ZVR7soPj9NS3YbjpC4RC00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EF4239+MVYPhiEBdy3IObb8LGA0djjKpaSuh27rqUQ5O+B+scXW0YReOF7P8OUjSvd/W2uHeKPkxG8dIj2FtpGjwcdcHRv8mcfF41Q47r+CV+nisQNvwFEy65PzAzm1ygghR+qUKIch8CiQfgMGnj+AH4JdjpayD/OnM8IOAsUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jZkmANwg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CAo+IlCR; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jZkmANwg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CAo+IlCR"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 81E7E1380891;
	Fri, 14 Mar 2025 13:02:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 14 Mar 2025 13:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741971733; x=1742058133; bh=GcbtfpPhT8
	nfZr+HZ0VJ+HBSBo8tJ4+GY0rO2dpSR5Y=; b=jZkmANwgycGC82mWgm9uWcP9sk
	85I4wYhRLymYFGzzxicXqbl4HpFErD+9qd6j3w2FhoiqEyu4sxlpKr7SjSZyG0Hm
	1oVw6Vxi63/lCm804wplQyx8alfDgrCfNI0IOGQQ4GedN4Tenurv7+AHM1XB4Kuk
	K0w0DTX+bdMx9WTWPE4Z8JvQs1zJU4QuMuZx0BngUB/N5Q4fwkR6dQIkgsAhFZqV
	9gYnGHptnho9OKpfU4fPpwEDwY6ReQAK4SgK0424d1roJYGnsKKzjPcY7tDn1nCm
	1wWOPrpUz9peDCOa/KcwQrDw8Li9UNu1n2jG6gGhKSLg2pcPK7fhLBpFy1tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741971733; x=1742058133; bh=GcbtfpPhT8nfZr+HZ0VJ+HBSBo8tJ4+GY0r
	O2dpSR5Y=; b=CAo+IlCROiN/LM2r73YEC7GV8H48rqPWj/M4VMbfdGlFi3wobOz
	tW5Nbi9xMesrm+g3EZXoCKha+Y3ol+q/VJAPrmJIIDe62SJHNABejchO21K8WcAi
	ev3v/2gNgOdb/156qZsCl7dUfv0AGE97067ZdTfGt/NHO79VlSMdacbOSWUS/wEx
	bBx5bHYB2H+WH4UCT41fTpk4uJlYzAz6xm5roYMStHKiwJWurUxSbf4DXgx8DsVv
	ixWEac8PcodWhrsLwbXhcgC/EMdaTKbLn46KSXC4QXOHppieA6nsR5FfqKKjGUnY
	Omie9d+uEmpRQ5ukVr+/M5BAdX4ZciB2kpA==
X-ME-Sender: <xms:FWHUZ2-2KznHX544Vvq-cjZ_Rw5R05frHiUPeFKUGPmvq5_iQ8O3rQ>
    <xme:FWHUZ2uDzlXDrsDDwRYm77__nNSffNSqsmEgSYXVcVosIiFwhtxDMlgRvGeUUkzaq
    wNB02u8KXXNzpUSlg>
X-ME-Received: <xmr:FWHUZ8BuBPv0yw5rctLbRNwX45d87R4k0AfHM82FX_EsaUSD9Dp15grcurrNH1hlNbIVlQeP0tUvlJdfJfagUYrNGy50b3vL6rSX2Sk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FWHUZ-cTR7rglHVIbpA770OWkpJ4AKceM3twRdvbu0LVgI9oHkXYkQ>
    <xmx:FWHUZ7PHXBOFoCACItjwguKY_PI69u9qa2wI-932LKtnZox176l1_g>
    <xmx:FWHUZ4l11m0AX5NCCz5OUaIiYzSZDesO9OVmAAZy7thlZw5QlDay9g>
    <xmx:FWHUZ9uy0gxt_0kxC3VVrnnp52usDmJuxrrX42pM81ZCaHCavNOC_w>
    <xmx:FWHUZ3CVP9FSxnzGe4l5le8j_Qsst08Bgm-5ypwDhCyKHD3hSTEE45Py>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:02:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
In-Reply-To: <20250314024929.GB114103@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 13 Mar 2025 22:49:29 -0400")
References: <20250310192829.661692-1-jltobler@gmail.com>
	<20250311235720.GA73755@coredump.intra.peff.net>
	<sm5xvh7bipyrlpw45bptlctbuhey7v3qktpskal5dzexomt34f@wgfziyhcf3t6>
	<20250313053329.GC94015@coredump.intra.peff.net>
	<qapd7sijizopaefpxh3slgn7g2ecwdtyhzqzufcypciyv6n3qm@turmldwzipwe>
	<20250314024929.GB114103@coredump.intra.peff.net>
Date: Fri, 14 Mar 2025 10:02:11 -0700
Message-ID: <xmqqsenfk0ks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Mar 13, 2025 at 11:41:56AM -0500, Justin Tobler wrote:
>
>> > Though that does mean that these two commands
>> > will behave differently:
>> > 
>> >   git log --stdin -z
>> >   git rev-list --stdin -z
>> > 
>> > which seems...not great. My earlier suggestion to tie "-z" to stdin
>> > handling was for consistency with other tools like grep. But if we
>> > already have cases where "-z" is only for output, maybe it is better to
>> > stay consistent with other parts of git. I.e., I was worried about us
>> > painting ourselves into a corner with your patches, but we may have
>> > already done so years ago. ;)
>> 
>> I think to some extent Git is already inconsistent here. IMO it would be
>> preferable for both input and output to use NUL as the delimiter when
>> machine parsing in git-rev-list(1) as that is the behavior I would
>> personally expect. I also agree with Patrick's reasoning else where in
>> this thread[1].
>> 
>> I'm open to discuss further though :)
>
> Nope, I don't have anything further to add. I just wanted to make sure
> my suggestion in the earlier part of the thread was not leading us
> accidentally down a bad path. ;) If the inconsistencies have been
> considered and we're OK with them, that sounds good to me (and the
> option handling in your v2 does seem to faithfully implement that).
>
> Thanks for all your responses.

The developers who know that the revision walk infrastructure is
shared between rev-list and log may wish that "-z" to mean the same
thing for these two commands, but the end-users do not have to, no?

After all, "git log" accepts "-z" but "git rev-list" does not in the
current system and nobody complained about the discrepancy so far.

Having said that, at the plumbing level, my preference is to have
two independent options "--nul-delimited-{output,input}".  It does
not prevent us from starting with a single "-z" that works as a
short-hand that flips both on (and is inconsistent with "git log" at
the Porcelain level), but we can make "-z" only for output for
consistency.  As long as we agree on the design to allow us to
control both sides independently, starting with "-z" that is only
for output may be the best way forward.





