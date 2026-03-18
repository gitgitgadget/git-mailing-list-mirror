Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002130EF90
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870481; cv=none; b=QqL7CHcCV2nP9RmBPEQ/Dma47Z1Oer9OkPFobY2ztIDhsGWzXyR7RqSXAvwbfjv1WTw2r10sRHoI/eEF2VzRDfxwUnPdfSO2XLosyXZpjl7/RZeqVObZymQ2gldpuTW/nMGtAAZS1ftTieikS4R+Ul5nekv1s1XEcjW4pvFGaBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870481; c=relaxed/simple;
	bh=c4MYaWUVt6whBnBhaRIPEIVpf3tO4GcwquaH9VfOH9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikhcZgk47qyNmmKpGbW7BI6qJjz8tCKFqH2/gpHY1/Cbq3xNoxE13q09VByyJaPk/57dhSB63uBJN0SCI15xKvRKFlLhyvhi9EPpe+MQurgzXx35qf18kT+2bv5Wj1aOVcRPwGdUfZS5SmqA8dioUv4NmqH98bxCKv5plHABz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OctXrGDW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZDFphaY; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OctXrGDW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZDFphaY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7DF7F1D001DF;
	Wed, 18 Mar 2026 17:47:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 18 Mar 2026 17:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773870479;
	 x=1773956879; bh=rt0EIeVfe08KlVcwFRNhiisZPgqDJFOl2Q7vEqrI63s=; b=
	OctXrGDWZKfl6CE60jhPbLR2hJIdxi0T3eNmikSLcky6R+hyXFJkr5D6FaCxFbei
	cPnAUmzuLPxCcmS81GMsbA6mlSBVOmRWWb+4c44Y7kiMOwD7KTmPMJ0PE7of25PH
	qLn1OzPTTyv24HH8WtH+kPc5fh115xG3vBhkIHeJoBkEk+RH7RPCt5YysprOLHWR
	MmiWSpWtu6/w4J7qQyMSHQjaizUbxcVm5/RpadJEfRBz3rLOOvl1GymSgFPNm0nj
	hROoCGp9MHMOQI96aaUNeIGJPFls2agBghM7QQksuf+cJeijwAVygggDNBJoAVqo
	V9e3bOI63/nqhptjGXSkuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773870479; x=
	1773956879; bh=rt0EIeVfe08KlVcwFRNhiisZPgqDJFOl2Q7vEqrI63s=; b=T
	ZDFphaYsMzmFvZnyHbFimJZjTgEJnYym9OYlLevNqEczdWmvU/40QiLtTvutO80G
	jx2t4TosCE4P2rCh4nmRhx0rVD2lWY4oCy3yprzlHgZSH3S9CTCQUp368wEzj6VZ
	VRCXISIry+uVUdKgo+4YEHntocFwtKt20FBtrJGVDFw7ARGi8tCktA8gVspJOzI2
	WVYeaQWEv1sfFzsYpuCSdPGVk9TR/lTv0LW79/qM9kraIJ0xOk5o134nppPaTCvg
	5WZFKes405Tjmdi7LogmmDbb0kyUcapjH6VmN9+Ug4pWx8DXJlKm+LdImcptu7Yr
	E2SE3ifoQHAP6kifDFbpA==
X-ME-Sender: <xms:jx27aW2mrdlWis-GEO-uS-8fgGAtp457rOut94rKH_Rdj-CTml8qTQ>
    <xme:jx27aQjCw1ZGYwx7lNOWZcwdnV353Ekh-hVtCLSh1wArH5pvIRkcEBDUrKW9UxVBB
    ouew4UM6laSBbGgPgBb228syfzP-5-9MIRIafte28Iq-0dZlomw>
X-ME-Received: <xmr:jx27acTVitV9KTPxi2I3eEp6shFkdhvGhouUNnEtXfk5XTMB2Lp6mGsnWWvPMgQPIKsyuMOUxt8wILVLYn3KaMIEtmxi3txxsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    gvohhrghgvsehnshhuphdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jx27aRigpZkcXY6pK6fBw4mz01Awg85kuO4-0yJILSA50e3waOTnfQ>
    <xmx:jx27ac413AllLCQ_VVSrsms1MSZeDTewJVjT8AIVjA4w1ndDfZoV5g>
    <xmx:jx27aeB9k1PxpSbH8EIz6e6XHEFLv3EfZU5FPAA1qxLTpnXHd3PGOw>
    <xmx:jx27aTbiNtEQtS6wa8vKoWJicYWjFxkYXd8MJKOjoGxked2weejsxQ>
    <xmx:jx27aYPFe6YrhkBErOUexJLThDTMIXyPcIeEU4o3d286Gkoc1fdzJWs5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 17:47:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nicolas George <george@nsup.org>
Cc: git@vger.kernel.org
Subject: Re: gitweb bug report: hash mistaken for an option
In-Reply-To: <absJmT_S9gGqbwyT@phare.normalesup.org> (Nicolas George's message
	of "Wed, 18 Mar 2026 21:22:49 +0100")
References: <absJmT_S9gGqbwyT@phare.normalesup.org>
Date: Wed, 18 Mar 2026 14:47:57 -0700
Message-ID: <xmqqikasq06q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Nicolas George <george@nsup.org> writes:

> Hi.
>
> We have a web server with gitweb (from Debian), and we observed git error
> messages in apache's error.log. I tracked down the issue to a request that
> had this:
>
> ```
> ?p=…/.git;a=tree;hb=-c
> ```
>
> I will not bother giving the actual URL since nobody else can check the
> issue in the logs or our server, but the issue can be reproduced on any
> server by replacing the `hb=…` parameter with `hb=-c`.
>
> I tracked down the issue further to the `git_tree` function of the CGI
> script:
>
> <https://git.kernel.org/pub/scm/git/git.git/tree/gitweb/gitweb.perl#n7200>
>
> If `$hash_base`, i.e. the `hb` parameter, is set and not `$file_name`, then
> it is passed as is as the last argument of `ls-tree -z`, and since it is not
> a valid hash, it prints an error.

In other words, garbage-in garbage-out?

FWIW, this also gives an error message

    $ git ls-tree no-such-tree
    fatal: Not a valid object name no-such

and even though it may give slightly a smaller error message than
"git ls-tree -c", it would not stay silent.  So I am not sure if
there is anything to fix here, short of redirecting your standard
error to /dev/null or something.

> Second, that the error (be it “unknown switch”, “Not a valid object name” or
> “not a tree object” gets written into the error log: it is an error entirely
> caused by the client that has no repercussion on the server, it should be
> either passed back to the client or ignored. This is more minor but harder
> to fix.

For that, you'd need to capture standard error stream and relay it
to the user, I guess.  That does sound like the right fix to deal
with any wrong input that comes in the web request.

This is a tangent, but I actually think "ls-tree -- $whatever" that
forces $whatever to be interpreted as the tree object name _is_ a
bug.  A double-dash should signal end of revisions and beginning of
the pathspec.  We may want to fix it in "git ls-tree", regardless of
any gitweb issue.

While I do not think it is a fix to force the end-user supplied
parameter to be interpreted as a tree object name, if we wanted to
do so in durable way that won't be broken even after we correct the
double-dash bug in ls-tree, we probably should write

    $ git ls-tree -z --end-of-options $hb

instead.

Thanks.
