Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B97928691
	for <git@vger.kernel.org>; Wed,  7 May 2025 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643010; cv=none; b=lSPElsO1yIEVP4n781Q5swSWIyrctHBuowgVIlBLjNYFhW9Unww0/sFgt4OWAQ7QLQkW24xYHdlvu9kbYDfZrRatK9bhygD6Sl3kBEtHQLc3pasDUos06T4xuAAyZvlpI7/eJIzux2I+RYPZgnVF9zogqjUs+SkZMHgfQYb92rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643010; c=relaxed/simple;
	bh=1dAZgJwHLEQ6fAmuf/FjlazarjUGrN88vZmAIG+gc3c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oby+7D09uGpLWoP9oHwZco+YRn2Md+LNC3U+LCCNivuYCOl7yHDZP8+m5PBPkYQz3RsWR1M8y6Lzcjq5WzoyXeBCCYIM+CNy9x/7Jo3R/72hOdpcRCpZcRSWdBev6Tm0ChvRLQmHSW80nO050MRZWgcIlkY4QPpqoVSTRBwHBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=xfTZgQe9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JjTzwg8r; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="xfTZgQe9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JjTzwg8r"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E0C3C11400E2;
	Wed,  7 May 2025 14:36:46 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Wed, 07 May 2025 14:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746643006;
	 x=1746729406; bh=aUyCjuiASciXla2J7jaGTtdbeZsk7WLzdSdRvqiwNvY=; b=
	xfTZgQe949hWlIMI/WfaT5NvW0tLg0EpVTNvRbdimpcJ84Ys8c4CjBM9nbtOxpt0
	/FRMjZA9XF8ykS+VmGpbx+hqLVAxKxrF1ZxOnRknktuD5yyBJMlf+1t+WgOW9CRX
	+Ym3kiSSyt4Y25RcQ6+dmZss30mCRDNfISWiF97yjjmW9Qb/T8eSq8/5SqGgF3wF
	NdMTPbb1PEgcMgrbI+LQbLbbJ1vxUrNnb8LKecvLa16GEIykVH0jWNNpXJB5IwVA
	yZ1vs3upCpkgdqhcV4LNsJAEJ0NW7aR4JfFmf1rQcF7UAOwY47fVmmAapNRaev4G
	CF0qEYctCmvBmA2SCssrnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746643006; x=
	1746729406; bh=aUyCjuiASciXla2J7jaGTtdbeZsk7WLzdSdRvqiwNvY=; b=J
	jTzwg8r6+b7zSXYWx4zlDqfsqupLQSndGx5l8wXZdxdNg7ETPltOyyM6Kh4cIScr
	tjUpe22OZMY7zQz1YG3aEZqdxo4kK/O7xFUZDwSta1xw0IOaXRMiw/GMlxRM2H3X
	cBTMx64nAf332eyI+tqJIkZB9IO2RSSgIKjnHfdKOIVFMA8aMafYbOZttLVek0uv
	atJOnJDDCtFZj0M3TWDvAqV+aVlKgKkvsqhduMTb0KE9FWyjZtk4GZduis8c37ci
	aN4AbGosr/7D0C9laQAQ6d0pYjIv7H+rrZW/ceIHqNtxczoFgYTEkVQnfIR25bEi
	EJ44eI8BjlpYUGp61e9zQ==
X-ME-Sender: <xms:PqgbaMxS_FDzyZw7vKykTqlH0Bj7RXIfvvVy3evjMYq8An8RnNCgHM0>
    <xme:PqgbaASl2LH551np8eIA-Tm-9ol8bky1eh4rX-Ipduzn2PJVLGRINpE3ARmQjYHi3
    rMkme2OGBx4JRsM3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnhepgfdtgedvvdejuddvteeigfeutdejleetueeufeefleevhfevuddule
    eifeekjeefnecuffhomhgrihhnpehsthgrtghkohhvvghrfhhlohifrdgtohhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PqgbaOUykOw0da63NUr1xU6LO8d2h-VlImfh5RzOvLMiYKUXo3aC-A>
    <xmx:PqgbaKjVHg17tOOtiOvLEhPmb43alDHoBgRK_NpCKajzHMapTU4s5A>
    <xmx:PqgbaOCsOS0gcPZqAQ42CNaF3Vfj8Mptv_ae019D94YyK2vR9oeznQ>
    <xmx:PqgbaLJ3RjIWeIkX-W1tXKp6Awzr4WvGvuCI39Sw2rJ4_F3C0mxh6g>
    <xmx:PqgbaAzDbrDvuvnc1wVWC5cDQFZs3XHMV5g8u7LkEpGwnXslNIGI8DfJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 86397780069; Wed,  7 May 2025 14:36:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1842cedc60ad5f96
Date: Wed, 07 May 2025 20:36:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <3fff50c2-d36b-451e-b324-aa00f8548bf5@app.fastmail.com>
In-Reply-To: <xmqq34dhijnq.fsf@gitster.g>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
 <20250506-pks-contrib-spring-cleanup-v1-8-e6d5ddd79a72@pks.im>
 <xmqq34dhijnq.fsf@gitster.g>
Subject: Re: [PATCH 08/10] contrib: remove "git-resurrect.sh"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025, at 22:11, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
>> The "git-resurrect.sh" script can be used to find traces of a branch =
tip
>> in the reflog and resurrect that branch. Despite a couple of global
>> cleanups, the script hasn't seen any activity since it was introduced=
 in
>> e1ff064e1bf (contrib git-resurrect: find traces of a branch name and
>> resurrect it, 2009-02-04).
>
> A single-purpose thing that is done correctly on top of a right
> abstraction does not necessarily need further updates, so I doubt
> this paragraph contributes to the decision to remove the script in
> any way.
>
> Having said that, I would not be surprised at all if large bugs
> still remain in the script.  The reason why we scarcely heard
> complaints about it is due to the fact that people simply are not
> aware of it, people do not lose branches too often, and when it
> happens, it is crystal clear what needs to be done with the output
> of "git reflog HEAD@{0}", once people learn about "git reflog".
> Even though it may be tedious to inspect "git reflog" output and
> pick the right record to use with "git branch" to resurrect, as long
> as it is a one-off thing, it would be more assuring to end-users than
> some rarely used script with no correctness guarantee magically picks
> a commit to place on the "resurrected" branch tip, I suspect.

The top-voted answer here has 3029 votes:
https://stackoverflow.com/a/3640806/

Which is in fact to just use the reflog manually.

The git-resurrect.sh answer was added two days later and has 16 votes:
https://stackoverflow.com/a/3653931/

Given this vote-split,[1] it seems people would rather do some manual
reflog work rather than figure out how to call scripts from contrib/.

Also the answer was by Jakub Nar=C4=99bski.  (Not a normal user who happ=
ened
to find contrib/)

It seems that many people delete branches they would like back at least
one time during their tenure.  But they don=E2=80=99t seem to want to st=
reamline
that process.  Which makes sense considering the previous discussion
here.

=E2=80=A0 1: Potentially popular answers can get buried on StackOverflow=
 if they
    are posted much later.  But this does not seem to be the case here.

    Also a 337 vote answer was posted over three years later.[1]
    Although that=E2=80=99s a more advanced answer which goes into using
    git-fsck(1).

    [2]: https://stackoverflow.com/a/22303923/
