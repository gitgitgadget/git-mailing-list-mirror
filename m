Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC3C1DA5F
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455327; cv=none; b=Bs12uUdNXKNtLrC7birSmIlXDpHgwXG55UD/zVyp78UT/IuxMZzGVrECBftxIXtGrbN9fvd+H6Bfj6HtweZzFocvkCayMZrQknRNMPIcfX8gl0CfdmyxOQwaYYqJFhJCDeK1xm738PhIz3C+n5MF1kYVBIBM6o5TtCnNr1txtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455327; c=relaxed/simple;
	bh=98JEBZ6xFMj011OI1Bg+76pMOqm+q3oiEVVoq8TBLrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFyfD8aBfQ+Ae5QIATltNJWcRjQRS/sT+jicsvK/hZ+LHU3y7RAv1IYQGxz6yNm4CQc0XiraRCYk1kjK0UwbuwBwo34TV0/1NM4Cys9jExoHCSfTxuPArJMNSkGm0kgJJ7PbfP4aggvpFYyQUxrPE1BQ5+l2IqMM4J7qFyLiciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IqYfVW8f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+iNgKoG; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IqYfVW8f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+iNgKoG"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 97DD21380696;
	Wed,  9 Oct 2024 02:28:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 09 Oct 2024 02:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728455324;
	 x=1728541724; bh=JYSHOvSgE9UXVMBvaX5Gp8RASvyncylZEzpjHOM57ak=; b=
	IqYfVW8fDIYnLHAcI4CHYCFEqP82sZSI3awUHXr1YjdOLD39/hdF/GKqgwFgvkno
	6b1H41/j2kDs7hBtDOg+GgS3dM574hJ1GaUmBl5y2B5ino5HMHFMiZqgmqmxcf/M
	1COU5FhuyVwx4NbeFZqlLZiC1/WLD7Ewhlg5KEsGVBOZKkpJuQpAMoxxn5zn/flP
	LG6FVvfVhl0cOFPve1iB+2MaTaQxirve9AZxxzflnMh8A5BoYvuJ/ZNrmgQQ9Ocu
	004jcLUnTgAZz0jb5bd3SaIsrqNHCvMB22B8S2tRim1hHZ/D1SmmBW4BARD4oLyL
	178hYlB2dWptG28jxP0HUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728455324; x=
	1728541724; bh=JYSHOvSgE9UXVMBvaX5Gp8RASvyncylZEzpjHOM57ak=; b=a
	+iNgKoGMnFsD3gfpejYXxfHLgufREtGwxCtx5PgI3sxfedyz20kr9JTujY47ce8I
	HmFNggiHQNo00KWuOYJBtQMNygfLt/Tqd9yD2w09oqhbOzDmqFNG8XGLHzS2neMj
	GwiT9uqDPlPqnnrFlmBlxrAwAPiB7tIFgqp+AjcziWjx096FzCPk1MHkydkfbnFF
	DTJfdjnwAOO5sJX4dAYU8RQxia5EHb/JOVXiHCuI/g7IEqngi4uh+FbcFLd7RVg/
	phEh2FmN7aTw0bBR9dz1SFEwjHO1GaWDezSlexf4CjXkn+dYCHhEBUMvSxUXhkiT
	qBCdwBqfkxq76akol9/cg==
X-ME-Sender: <xms:nCIGZ6yJc-1UP3Tq5c2r8TjvUSRzfy87J8a-UO_KQKdf0NxecjCtJA>
    <xme:nCIGZ2RCaEJKYNB6o-zfVNkjcm_1z4AzDrT29vfPTcWOKhtC2WXzlMQuoI4pr1yf7
    fDd9WZZLW7fu9argw>
X-ME-Received: <xmr:nCIGZ8V0mtWDiIA6EbumjPNWSClnJFMBAfyLlHXhKSAbP5gtPdvZ4IUYu8B31KPZuD3P6vZu6PJZEEm749zmqrirc-A8s6Bm15LlhZ0YvELc_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhhuhgshhgrmhdrkhgrnhhoughirgdutdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:nCIGZwgiLHjnrFKhuxMYKrho3-_blT3vhijkMnAUXt5BC7zENEQtbw>
    <xmx:nCIGZ8BxAV1nwvnVCdRETO_PxgXR5fU666Fj5sC8Bse_OiPMKVOJ5Q>
    <xmx:nCIGZxKLtsP8yqei2OmC6WO20-7rli3LrP9Xr6efR05ZnnbdgFQ9ZA>
    <xmx:nCIGZzD04Jg2nggBhaDEoZT1al9vJI6Azn5lXADgXxEgfrMeHzqN5g>
    <xmx:nCIGZ_OAKsht638JRO1NYA5-FizmOVKxJZLsQn_plplEiulr6R07-OGP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 02:28:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 11e8aa01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 06:27:40 +0000 (UTC)
Date: Wed, 9 Oct 2024 08:28:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Shubham Kanodia <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH] builtin/gc: fix crash when running `git maintenance
 start`
Message-ID: <ZwYij4t5eDgy23iw@pks.im>
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
 <976c97081af7c62960bd71d1b70039657e7cb711.1728389731.git.ps@pks.im>
 <c1271bf6-3648-4eca-916f-67a8518fe4e1@gmail.com>
 <b4d75b35-bfe2-4950-b2de-b56d95918b3c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4d75b35-bfe2-4950-b2de-b56d95918b3c@gmail.com>

On Tue, Oct 08, 2024 at 10:58:06PM -0400, Derrick Stolee wrote:
> On 10/8/24 2:30 PM, Derrick Stolee wrote:
> > On 10/8/24 8:15 AM, Patrick Steinhardt wrote:
> > > It was reported on the mailing list that running `git maintenance start`
> > > immediately segfaults starting with b6c3f8e12c (builtin/maintenance: fix
> > > leak in `get_schedule_cmd()`, 2024-09-26). And indeed, this segfault is
> > > trivial to reproduce up to a point where one is scratching their head
> > > why we didn't catch this regression in our test suite.
> > 
> > > +test_expect_success 'start without GIT_TEST_MAINT_SCHEDULER' '
> > > +    test_when_finished "rm -rf crontab.log script repo" &&
> > > +    mkdir script &&
> > > +    write_script script/crontab <<-EOF &&
> > > +    echo "\$*" >>"$(pwd)"/crontab.log
> > > +    EOF
> > > +    git init repo &&
> > > +    (
> > > +        cd repo &&
> > > +        sane_unset GIT_TEST_MAINT_SCHEDULER &&
> > > +        PATH="$(pwd)/../script:$PATH" git maintenance start --scheduler=crontab
> > > +    ) &&
> > > +    test_grep -- -l crontab.log &&
> > > +    test_grep -- git_cron_edit_tmp crontab.log
> > > +'
> > > +
> > I see why we didn't catch this immediately. This is a good way to work
> > around this issue of "mocking" the scheduler.
> 
> Unfortunately, this test is broken on macOS and Windows. Those platforms will
> fail when asked for 'crontab' without the test variable.
> 
> Here is a potential fixup that will make your test succeed:

Oh, indeed, thanks for flagging this. The issue is that those platforms
do not make `crontab` available at all.

I think we can land at a better fix though: the systemctl-based
scheduler _is_ available on all platforms if the systemctl binary is
found. So let me adapt the script accordingly.

Patrick
