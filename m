Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F372D1474AF
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732696227; cv=none; b=PqGdHRkdcN1YDGGM4EDfJuedj5UJQTMk8FjbsumH/kFp42zqNojSzZqvT0pBsztIC0nKfdXDoCZjK4435irTziC5w/rcPxGieM/6DNdcfX508fRc9mZJR107dAEU0oJNoPmprj5L3F3NfyjPEVutQLRsh0b9YWgba9Vr+pvk9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732696227; c=relaxed/simple;
	bh=gVT4Odw+e7ug3SNParKmUGWkGCQsIMbbiovb2D2jFyc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eNDCH1w+Zrk4me7FXyP9FOrLIlytFcg6o5+Wk32uia1qMEoBXf8l6ivW0BGP3t7qaUzriMkK8eqLDu48jTUtDsDebCFUjwgcSUOX2xFLSR+LuLsp21nG9/gm7ZDgBxn6SRl5Abn0QfGHo/bXyKhlB/rd8rBFdjkttOBU328hMnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cLomvPER; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFXEcN6K; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cLomvPER";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFXEcN6K"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D784A1140192;
	Wed, 27 Nov 2024 03:30:23 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 27 Nov 2024 03:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732696223;
	 x=1732782623; bh=3KlgXYUPHtxv8dP/q3XRMC5SzGq/JLlcmd4wAxK/Kng=; b=
	cLomvPER0pPvoR2kxu+8nOUdPBLrL7SOPcRCTKJLwBDolcyfQdfywpbiU4L2iY5S
	hrTu7Wf/mgA3v1R4f6/QtKNy0ncynJzgZFDLCmDd7L8JXptr/YSKC8A8vQcYNYMi
	hx2nBf69DOtoYC9STaO5r3W0Ei6hYi0EAREDaeTzTKPZBn190tyy6GWfE44JKMvY
	ap0bROEmKTzFoM5/SGSNzfr6E8b9kzLAhpsiV8xk8wvhf/4mSq/sh2swiuXfbb6m
	AmpoGmzGiP7i2m7Kg/oomlIgmoDq1dzR8yW7+SkWX0lEfKfqqjIUBeursWO1mCPl
	s52EUIVdw+si78jnwLEwDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732696223; x=
	1732782623; bh=3KlgXYUPHtxv8dP/q3XRMC5SzGq/JLlcmd4wAxK/Kng=; b=T
	FXEcN6KYtaRL+2OEaSDVZ1nH/jxsAjYEauwZB8r4yUSW+sMMUmdcprKq6WhknKJv
	PKJjU+qC4PynkTddzCLJtQMMopEwz3CHWon2hWqFM4uWVWWWTUJ/OHWdzr+cDCHS
	IpaTOq4H/fFdmRpqRP3YBcvROThFNYwfiML8FucuVGuWEFq8btdxt6uGydZlfLpn
	CEpJo3FalFCX/LRh0gX8/yQwSwktP1WydB/lSQXIjfJrWgyWu2hg3kWFZRoiEq49
	zBOYI6i4hhNiJyiZZTRBkcv7y+ym6A3ucx9mC0KM5gyP8jGyZujb/N4hs2L0m6I4
	+J5eAVjLgjxBH9sXXcoZw==
X-ME-Sender: <xms:n9hGZ_yZMwS_uuFMDzLJh-aXYkT3e7a6tyiIUvk3Cjzwo7lfOAnuYlM>
    <xme:n9hGZ3QUl-qe3YdvCbf59XZ9xffc51zFTFdosZbpsmVMjsk7ZB_U90DRPnG0sFT4e
    BQlxj_Lq6Uo3YJOrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeekgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:n9hGZ5VFBAkZHByTYvooEzsql-gnLxdiz9lU_b_jJUn99-ROlF_qiw>
    <xmx:n9hGZ5jqlE272GTcPvmuEr4_pZsch5C7_Lk8SMqJs-OMA6diinxv3w>
    <xmx:n9hGZxA3kCNHAY1ChQxMHv9k0-dM28vlVsEv1SzgTipe6XPdKIx0_w>
    <xmx:n9hGZyJuhtmRBRMuUQaEg2zy0pdew5nEAaaFSG1A82lv8U3BoNhrDg>
    <xmx:n9hGZwO2TXdGVcDDXb0Fe0kbjriS1lgDnbvbkR4CRIC5EYUWYiYfhn2d>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 85D86780068; Wed, 27 Nov 2024 03:30:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Nov 2024 09:28:03 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Eric Sunshine" <sunshine@sunshineco.com>,
 "Elijah Newren" <newren@gmail.com>
Message-Id: <79f6027b-123c-40a6-975b-1c6053b9391c@app.fastmail.com>
In-Reply-To: <pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com>
References: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
 <pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] fast-import: disallow "." and ".." path components
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.  I see that this is in `next` now so the following might
be irrelevant.

On Mon, Nov 25, 2024, at 20:00, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> [...]
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 76d5c20f141..995ef76f9d6 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -1466,6 +1466,8 @@ static int tree_content_set(
>  		root->tree = t = grow_tree_content(t, t->entry_count);
>  	e = new_tree_entry();
>  	e->name = to_atom(p, n);
> +	if (is_dot_or_dotdot(e->name->str_dat))
> +		die("path %s contains invalid component", p);

Nit: single-quoting the path seems more common:

    $ git grep "\"path '%s'" ':!po/' | wc -l
    17
    $ git grep "\"path %s" ':!po/' | wc -l
    4

>  	e->versions[0].mode = 0;
>  	oidclr(&e->versions[0].oid, the_repository->hash_algo);
>  	t->entries[t->entry_count++] = e;
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 6224f54d4d2..caf3dc003a0 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -522,6 +522,26 @@ test_expect_success 'B: fail on invalid committer (5)' '
>  	test_must_fail git fast-import <input
>  '
>
> +test_expect_success 'B: fail on invalid file path' '
> +	cat >input <<-INPUT_END &&
> +	blob
> +	mark :1
> +	data <<EOF
> +	File contents
> +	EOF
> +
> +	commit refs/heads/badpath
> +	committer Name <email> $GIT_COMMITTER_DATE
> +	data <<COMMIT
> +	Commit Message
> +	COMMIT
> +	M 100644 :1 ../invalid-path

Maybe the test could be parameterized so that both `..` and `.` can
be tested?  Like in `test_path_eol_success`.

-- 
Kristoffer Haugsbakk

