Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E534224AF3
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748954422; cv=none; b=sIByDecQLDZBPG9M5Ye3rZavTcwPfdPQT0yd3JnBoPvCNc6SqlOIeOkR859PzlYBPYHUjy5GBrN7ifogFHVEp8a0s+wG8UtHG1UY/UC+wZCxa06ecXiJv+qirld5ZIhVy41R5jZlBcvk1Qxunbs98o+GWBL9QmMcLoDyNqyGF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748954422; c=relaxed/simple;
	bh=ltpz01u517xB4dnlthjRegBzRpOiANwvUrwZsxk+3Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8i9Akh+Wb2Z+rhZ8YSLGAgGR2xq3hsodUm/dmD4dR4Gpfq18Jni5RGF/TkD6OAn6GS2RDp7H2UW1uBmf/IVU68qAULZ+YdDqSlLH5wUgKtOzPZ2jPlyjZ/xPd2UtPu/Lb//fUDBeeiDDIopCAlYz8PlDX+K3pHkNvjK94zPQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YESUneeq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uu0BnyLu; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YESUneeq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uu0BnyLu"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 06CD4114012B;
	Tue,  3 Jun 2025 08:40:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 03 Jun 2025 08:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748954416; x=1749040816; bh=jiv/gdWDv5
	Bjd05H6dMIo4ilmDuXzaShr4A/Lb9z26w=; b=YESUneeqehid2+WCqhwQjMJHfK
	Sv5MQj4k/ouqQC2B8flEpDic/MUo99bSfXk2p0iR2fGH2FDHh4FxSptJERNSO47P
	roViv5O/6QlJ8+luCrVR4Z8dVcItncA0mQIoQ394H1L7k2vOuMmN5HdhjFD3W6Jq
	AirUixZ7WmEuAE4OqA9L05cdnpsl11uLLccT8hOJ7GwFzsWef09PPkdt29eL30uI
	fW/na4EP7ytLQv4GyE7+s+EwybcEnlDEp7PNipRi2H5j/kN31FFl7Ar+sDX0eG94
	8S4o7QyqVcdqjvNbJC/42CHojt89BkZPJ3AKJr8MoehSkgJcNQsmTr/7tvaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748954416; x=1749040816; bh=jiv/gdWDv5Bjd05H6dMIo4ilmDuXzaShr4A
	/Lb9z26w=; b=Uu0BnyLudn7mxgayA9sQZMDaMFbyFpGn1qV0vWC3+mcu6j1APdV
	AoSDTFdssc/MK4TiF2jb3zRgFAkq1yNGYQAx8z/HVvm0F3l4UmSd3RsQC2ApgXMQ
	D9a/b/QQ85XsTiuZR/M+b34aRfbGwNDbHjVXVnwXLKSiFn6W4X3eUcCLrEv6ZNVh
	vjfxfYOzdty8LKS9GahtdzPAjtBFlOP8O23JQgWsGKoae2sXU0QHGCkX169Yw67b
	+mzmXUhHatv50GwLdBX45O5OzqqES0P4fWiUTDFKKC0ofcm/CaPvrjyD4qisVE1R
	MTme4d5AHlxn5SlVhKAvMptVnSml+M3+FsQ==
X-ME-Sender: <xms:MO0-aLNJhHv5S-qoow9cjOXMZLh24Btiq5NpZK3WoirbnBakRBinEQ>
    <xme:MO0-aF9PhOT7N16Y8TcdV00Zv9aKBdA8vWSYWbDWjDvvjsZRY_GuwrgyRnajw4oN2
    sXAs6HG-eCqYlx79Q>
X-ME-Received: <xmr:MO0-aKR9mbDwtet3yauXS0VeTd5bU3w9E5tEdJGolXejQ2gNMWMDH2Lt76f5n_7iFCoK8w2QdsmTVlQtTFK4ofq4PfHwGv2Hvhslup4Z3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeelvddtudehhfejudegudelheelfeduteekjeffhfetvdei
    gfeutdeftdehheekgfenucffohhmrghinhepghhithhlrggsrdgtohhmpdhgihhthhhusg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:MO0-aPtCT2jQ8nH5MgVSE3NwNwyo6d4dsRhvaUJZQIAgJ2Q05IRZsw>
    <xmx:MO0-aDfLlEWki47dxQsgGjqafNhqrjCOgRv_vJiQbdt5_IG6oP4kJg>
    <xmx:MO0-aL2MiNjTGDSOHJG74TWH0NwurCkXN_DAxQ75Dvh8tatrvkN5CQ>
    <xmx:MO0-aP9Lb_ccNs4M0DUaz-2Qm1meeZ5TjnFKlmwZ1ugLFsFjHpt-xQ>
    <xmx:MO0-aK0qV_MmFHMTDTIlHRUb7hJlVMPX9i1KmCmBt7-_dGzZYAL9u-8a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 08:40:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fb6a2db (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 12:40:13 +0000 (UTC)
Date: Tue, 3 Jun 2025 14:40:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,
	karthik.188@gmail.com
Subject: Re: [PATCH v2 2/2] builtin/receive-pack: add option to skip
 connectivity check
Message-ID: <aD7tKfXD7YxprSZh@pks.im>
References: <20250520014920.201736-1-jltobler@gmail.com>
 <20250520163218.263921-1-jltobler@gmail.com>
 <20250520163218.263921-3-jltobler@gmail.com>
 <74668a00-5b90-2450-52c5-d9f00dcb42b9@gmx.de>
 <gw6j5enpzcit2zquafoaiujreoa4kbv3n6feq6yeqylcfynqim@s53ctnlg7tmm>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gw6j5enpzcit2zquafoaiujreoa4kbv3n6feq6yeqylcfynqim@s53ctnlg7tmm>

On Mon, Jun 02, 2025 at 10:59:53AM -0500, Justin Tobler wrote:
> On 25/06/02 05:01PM, Johannes Schindelin wrote:
> > Hi Justin,
> > 
> > On Tue, 20 May 2025, Justin Tobler wrote:
> > 
> > > diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> > > index 9afea54a26..f76a22943e 100755
> > > --- a/t/t5410-receive-pack.sh
> > > +++ b/t/t5410-receive-pack.sh
> > > @@ -62,4 +62,26 @@ test_expect_success 'receive-pack missing objects fails connectivity check' '
> > >  	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
> > >  '
> > >  
> > > +test_expect_success 'receive-pack missing objects bypasses connectivity check' '
> > > +	test_when_finished rm -rf repo remote.git setup.git &&
> > > +
> > > +	git init repo &&
> > > +	git -C repo commit --allow-empty -m 1 &&
> > > +	git clone --bare repo setup.git &&
> > > +	git -C repo commit --allow-empty -m 2 &&
> > > +
> > > +	# Capture git-send-pack(1) output sent to git-receive-pack(1).
> > > +	git -C repo send-pack ../setup.git --all \
> > > +		--receive-pack="tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
> > > +
> > > +	# Replay captured git-send-pack(1) output on new empty repository.
> > > +	git init --bare remote.git &&
> > > +	git receive-pack --skip-connectivity-check remote.git <out >actual 2>err &&
> > > +
> > > +	test_grep ! "missing necessary objects" actual &&
> > > +	test_must_be_empty err &&
> > > +	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD) &&
> > > +	test_must_fail git -C remote.git rev-list $(git -C repo rev-parse HEAD)
> > > +'
> > > +
> > >  test_done
> > 
> > This test case seems to hang occasionally in the "win+Meson test" jobs on
> > GitHub (I tried to find the same failure at
> > https://gitlab.com/gitlab-org/git/-/pipelines but couldn't find any). See
> > for example
> > https://github.com/gitgitgadget/git/actions/runs/15383915635/job/43279134837#step:6:627
> > 
> > Note that this problem afflicts only the "win+Meson test" jobs; The
> > corresponding "win test" job seems not to hang.
> > 
> > Even in the Git for Windows project, where the `win+VS test` jobs are run,
> > the t5410 test passes within a dozen seconds or so, see e.g.
> > https://github.com/git-for-windows/git/actions/runs/15383945895/job/43279689086#step:5:143
> > (confusingly, the subset of tests run in the matrix jobs differs between
> > the `win+Meson test` jobs and the `win+VS test` jobs, but if you click
> > through all of the `win+Meson test` jobs, expand the `test` step,
> > patiently wait a few seconds for the log to be lazy loaded "enough" for
> > the search to work, you will notice that t5410 is not mentioned in any of
> > them, and the only one that times out after 4h37m11s is
> > https://github.com/git-for-windows/git/actions/runs/15383945895/job/43279753911,
> > likely while running 5410, too).
> > 
> > Do you have any idea why this particular test case, in conjunction with
> > Windows and Meson (and only on GitHub) acts up like this?
> 
> Thanks Johannes for the report. I'm not quite sure yet what is going on
> here, but I'll dig into this a bit and see what I can figure out. :)

I've been banging my head against this issue for a bit today. A couple
of findings:

  - The issue is specific to Git for Windows, I could only reproduce it
    when working with aa550efd0bb (fixup??? survey: add command line
    opts to select references, 2025-05-08).

  - When working on top of the above commit the bug is consistent. It
    doesn't only happen in GitHub, but also happens in GitLab CI [1].

  - That being said, I still can't reproduce it locally?! This one is
    quite puzzling to me. I have tried to get my environment as close as
    possible to the environment we have in the CI systems.

  - I have a fix, see the patch further down. But I don't understand
    that fix just yet.

I saw that all other sites where inject a custom receive-pack command
also use a wrapper script, so it's not the worst thing to do. But it
would be great to understand why this issue exists in the first place.

Patrick

[1]: https://github.com/pks-t/git/actions/runs/15416185892/job/43379399861

diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
index f76a22943ef..112da408d45 100755
--- a/t/t5410-receive-pack.sh
+++ b/t/t5410-receive-pack.sh
@@ -49,9 +49,13 @@ test_expect_success 'receive-pack missing objects fails connectivity check' '
 	git clone --bare repo setup.git &&
 	git -C repo commit --allow-empty -m 2 &&
 
+	write_script receive-pack-wrapper <<-EOF &&
+	tee "$(pwd)/out" | git-receive-pack "\$@"
+	EOF
+
 	# Capture git-send-pack(1) output sent to git-receive-pack(1).
 	git -C repo send-pack ../setup.git --all \
-		--receive-pack="tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
+		--receive-pack="${SQ}$(pwd)${SQ}/receive-pack-wrapper" &&
 
 	# Replay captured git-send-pack(1) output on new empty repository.
 	git init --bare remote.git &&
@@ -70,9 +74,13 @@ test_expect_success 'receive-pack missing objects bypasses connectivity check' '
 	git clone --bare repo setup.git &&
 	git -C repo commit --allow-empty -m 2 &&
 
+	write_script receive-pack-wrapper <<-EOF &&
+	tee "$(pwd)/out" | git-receive-pack "\$@"
+	EOF
+
 	# Capture git-send-pack(1) output sent to git-receive-pack(1).
 	git -C repo send-pack ../setup.git --all \
-		--receive-pack="tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
+		--receive-pack="${SQ}$(pwd)${SQ}/receive-pack-wrapper" &&
 
 	# Replay captured git-send-pack(1) output on new empty repository.
 	git init --bare remote.git &&
