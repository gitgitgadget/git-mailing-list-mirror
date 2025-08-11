Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191E22DC353
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902482; cv=none; b=sMJN6yjxhYhYcMXlk2pE5Lxy3qDkLzCG1deVUqAceAZP7TX4EkHBCVYkXt0LvjqG04d/sSTH2g20BaF02NPZhDOAhjb4dpr/G6RsMFGfOfy0jAumh1Nv3sZDJ2zAYMkcpIi3WKkeVkZvN112nYgMM76X93bTdT5Ui7VDI5nRmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902482; c=relaxed/simple;
	bh=eXmeoYvD1gPhKBTiILOmRiamZGsEvptAdUeaMBGOlc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgbbdq44klPAw8C70xdp5Mc3db4EGzam9/TTr64veZ6EpTmbZqZdTjig0JOlTlqROH5FbBxTG/AxtaCsbgQced8yT1AO4rR9MbNaRMP+sma5f6zQ7Cgb+QoqTLQ8DFT3kfzW+5Un2Ijjk3STBWmEKiGArDUz+CoyWJF6jZFjvFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RBU8/4rX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQzXmSyr; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RBU8/4rX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQzXmSyr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 47D0F1400043;
	Mon, 11 Aug 2025 04:54:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 11 Aug 2025 04:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754902480; x=1754988880; bh=s2leZVZaR8
	vnKznR/MmAA4xbpOkTVl+LHzixZR6GW/s=; b=RBU8/4rXZBZTsVmdqqxLGZTxyw
	/3nPS0GvkiBl3T3H518zAuBISvYAzp3YiF3zrSQU78H2tP8FMj48Qn2JFSLtK5ii
	MHayq7tNl1ryHLJu984KXGKtnO6xQQ23u0yjl9IB73MNakgZ50Yi6d8cU1LLVInJ
	NlOOOZX7oM0UDTXqk58wvUrXgt4WbpjY+CyYArr0DNs9Uhe8gDAFem6FyySpxyGe
	vbDs+wb5U09xwmhLN+KlK477EsYqDHwmFCYfMbEOqdZIZrQO78d7lKS+tK2qj8rU
	wuKA4K0T4zE7EwQtswsepTo1XEyiDxz8GPj+s1+DDA6TzlN12tqUUbLStAQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754902480; x=1754988880; bh=s2leZVZaR8vnKznR/MmAA4xbpOkTVl+LHzi
	xZR6GW/s=; b=DQzXmSyrCj5qs1SmVryhVO7H0EINByMvBjY3P7M9olenxog+ELB
	QAGKy/3VgN2WFdCjSDDoEOTKJWW9vn22oe11EPxqr/MMamwlvLay64zZqNKBKh5A
	4vwsuiyK4bHnNs8/5GuKlKX9twYQ0hx1nwgJNhUOsxRpKYWi2CUY1bd7yYm51tq8
	Hk8JDCcq5bnR/Qh9XSOk0ovTUTDi5w0HBB2/+LYRdpklNE8KBba2wPITUoQ68XvG
	PUBnmVQJAD4hpN3B2qRR8r+8yl358l/SvXv8y4GbK66sEpTo6kjehc4LWEkrpEPp
	mVIAl/hPCLcbYFJQYNjpueSXalM6zmkKxtw==
X-ME-Sender: <xms:0K-ZaByBx0_z25Dv5V983lzoiCKg_ADiC0U1QjRawYjSs30fJv2pIw>
    <xme:0K-ZaBcXCrij47lr5-B8WVuA-Zw29pD-t-PYarMa1BK-Jd8VDArLQ_37hGy5ymBZM
    NXIO6ub3aMjVaYe1w>
X-ME-Received: <xmr:0K-ZaNLHGNBDJbppZ-OqZHWCXehy0HkSuLnJO58s-UMjGCimXTt1BUgHog2XdUjNG_P4kr4OT_BwDIHPTPts9xgF4FoEm918UWEWKK3S3Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehnohgsohiiohesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0K-ZaCE-chmqZUb9ND4YMSmTFHviuAQd4w7AK77wkLLVZjuzwEf7BA>
    <xmx:0K-ZaHoFevvG8gtc1W50BS5umyR7szXDSfasfMyagZ34RKFEbi1wew>
    <xmx:0K-ZaLSj7GfvbgDSZBUPHNlmQSHlhBsnS2a63ei1xbQ074MT_xCKtw>
    <xmx:0K-ZaENjl45tygJoPTb22pF37N4yjv4ALoGZuS6w-V8_Sc5FOy9zRQ>
    <xmx:0K-ZaLC_oULdPKCc9OWMBv55l6lKZW45CENrD8_m1F4O4_Fu-NgYIpOf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 04:54:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9c9df359 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 08:54:38 +0000 (UTC)
Date: Mon, 11 Aug 2025 10:54:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jon Forrest <nobozo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Minor Bug in git cat-file (git 2.50)?
Message-ID: <aJmvykqFbsBJR_xk@pks.im>
References: <b37629c6-b730-45ce-b839-e782aafe238d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b37629c6-b730-45ce-b839-e782aafe238d@gmail.com>

On Sun, Aug 10, 2025 at 07:52:42AM -0700, Jon Forrest wrote:
> (Sorry if you see this more than once)
> 
> I'm using 'git cat-file' to show the example. This is probably not a
> command-specific problem.
> 
> The problem is that using a deliberately ambiguous object ID produces
> surprising output. This is a minor issue.
> 
> % git --version
> git version 2.50.GIT
> % uname -a
> Linux fedora 6.15.9-201.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Aug  2
> 11:37:34 UTC 2025 x86_64 GNU/Linux
> 
> % git init
> 
> # depending on where you run the test, might not be necessary
> % git config --global --add safe.directory /tmp
> 
> Initialized empty Git repository in /tmp/.git/
> % echo a > a.txt
> % git add a.txt
> % git ls-files -s
> 100644 78981922613b2afb6025042ff6bd878ac1994e85 0       a.txt	
> % git cat-file -t 78981922613b2afb6025042ff6bd878ac1994e85
> blob
> 
> # All is well so far.
> 
> % pushd .git/objects/78
> % ls
> 981922613b2afb6025042ff6bd878ac1994e85
> # create a new file with the same name as the file that already exists,
> # except change the final letter to something else.
> % cp 981922613b2afb6025042ff6bd878ac1994e85
> 981922613b2afb6025042ff6bd878ac1994e86
> % ls
> 981922613b2afb6025042ff6bd878ac1994e85
> 981922613b2afb6025042ff6bd878ac1994e86
> % popd
> # use an ambiguous SHA1 prefix
> # why does the next command produce two identical hints, both of which
> # are incorrect?
> % git cat-file -t 78981922613b2afb6025042ff6bd878ac1994e8
> error: short object ID 78981922613b2afb6025042ff6bd878ac1994e8 is ambiguous
> # this is correct
> hint: The candidates are:
> hint:   7898192 blob
> hint:   7898192 blob
> fatal: Not a valid object name 78981922613b2afb6025042ff6bd878ac1994e8
> # I would have expected:
> hint:   78981922613b2afb6025042ff6bd878ac1994e85 blob
> hint:   78981922613b2afb6025042ff6bd878ac1994e86 blob
> # using the supplied hint doesn't work, which is no surprise
> % git cat-file -t 7898192
> fatal: Not a valid object name 7898192

Hm. I think the problem here is that you intentfully corrupt the
repository by copying the blob to a different name. As the object
contents itself remain the same though, and as the object ID is computed
by hashing the object, looking up that object would ultimately lead to
the original object ID.

The consequence is that `show_ambiguous_object()` becomes confused. It
_looks_ like the object name is ambiguous, but it ultimately isn't
because both names refer to the same underlying object. We then use
`repo_find_unique_abbrev()` to shorten the printed object IDs that are
printed in the error message, but given that those are really the same
object we abbreviate them to the same shortened object ID.

I'm not really sure that this is something that we need to fix -- the
repository is corrupt, and git-fsck(1) should tell you so. Did you hit
any real world scenario where this has happened in the wild without
intentfully corrupting the repository? Or given that you explicitly
mention Git 2.50, has the behaviour changed recently?

Thanks!

Patrick
