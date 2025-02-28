Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0A1EF398
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756719; cv=none; b=dPboXN5HP/3KY/xZw0o69OFt0+caaW69R8znju0ILwD1P709nn7MD74VTgO8REmUpS9iGwYJa9cJZfLduVvVFg3QlC70KYgmcfp6NIBer8gTRAb5EoonRvJ9CyNsKCSaEwj2p/n1UHaeTgE8ZkHxMiOqn+wo84F7zdCqOrgfkkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756719; c=relaxed/simple;
	bh=onQZJkxZtLp3CmI4MgxPV1GowmDHfh+E3ejwKavBOdU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f/fJWdQLOY/sgmALK8/FpB1pfAZ5u4M3IwGFphC1GYP32pfslltKlQN1FX2cU4h39cwVqgFpbLov1plmwu1nZu84E7S8y6KfTCiQg3JpHb3c9f1k9eijWmr13Y21ysgr+4RlnGlMvI2Kei0M4L8MU2I66LPBWmhhDQPmJ6wu8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tvb56ZYh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pztETSs1; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tvb56ZYh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pztETSs1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD03625400AD;
	Fri, 28 Feb 2025 10:31:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 28 Feb 2025 10:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1740756716; x=1740843116; bh=0g4GhEZD2aS4y53eJO1YLPNuu7vHb+Zx
	5ekLUk+VyYY=; b=Tvb56ZYhB1xDSeOPB0C2OKteI9/j9UWt9YKM6kXjUjwc5ZoA
	pTNB7FeWGTgu7d3oHSCpm/vHj0q8XadOMwhO7a6Hkg4y4i0MVC5oCGG1zwrYhyZW
	6t6b15afGkP9ei/sZq3m6k/HzJ5KG8bbvor5uBGbIAb6ssJ6+8JnqrVlEXQ7PE8s
	THDseUmPZFPvRApslh25HO27rQ6VKygXz5R2UYkZPX70E1mcK/6eRj5hsNsKypag
	NwrxsSR5ym7gM7eSHCj7qgRO8OYwNhkoHKDsMdvv5cuJyGovrvkVour2ET0bf6j0
	LMaR0N9zlz8xAEaVcp1bEgcRfc/EYfN+tt8NvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740756716; x=
	1740843116; bh=0g4GhEZD2aS4y53eJO1YLPNuu7vHb+Zx5ekLUk+VyYY=; b=p
	ztETSs17QMJdcLud7vWidOfckwym6UyXYT/NxG5fYvqnW/5oE8NHH57toLE8HBPt
	72I8d6qgFc9YtABYmZysQdWeAYoS5Pvb6EFzCFbkRLirreY8oqsl+u3h46FOMsX3
	N+YFmlni2T9VFTurdh3SBB4WglxftewUnOIMJrPmdZneQh+U9CX7gTb4wJPntqbg
	53BrKuEKLfWoLAGDGBcaAy9BKA9t2j6DkzKMmXVMypLCQuVWL8rb9ZsHjpJKDGKt
	HTrjUekVoTIIImw5+tL+NjagLfnQJqYX41qVqyF2IFXNuEeoLVirW8XSroh6w+r+
	9V+1uunujxkvbY19ii6vA==
X-ME-Sender: <xms:7NbBZ8jA38P6_jFi5nj-mr5iOZ5MmkYBFZS9Xzc8uXAEyJ8dTCg3zQ>
    <xme:7NbBZ1Dhzt3qMmbdYVKxnKdnWDtyoQ9s51LKPNplOXFCEXOngcMiEwzxA8Moo4WcZ
    JX03DSMKSRQA2k95g>
X-ME-Received: <xmr:7NbBZ0EnpFz36N4SixdPV8sQx5pIGlSRM-tNcwASdSj6ePkunEWvgBKdBk6YYRMqZG9C7W8t1N9dXPPdinsRXFl4hsBemuS7foQgCBKS6YzZvWdWHAv->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfggtggusehttdertddttddvnecu
    hfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtohhmqe
    enucggtffrrghtthgvrhhnpeffudejfeeiueevieejtdeuiedvfeeukeefffdtudelleff
    hfeilefgudejieeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7NbBZ9SI-L_CnPyfKBD3TWvZxn-dImYoCOfg9JkVamd-XUjzWqt3xA>
    <xmx:7NbBZ5x-dD_zsTBf3niJkvxo17HWfeQcanOr3Y-2mbNyLa8mpzxsqg>
    <xmx:7NbBZ76sEC9qj7z0K5Zgl11_rLNC3rCKjHJA84cf5sLA_JfBl8JZbA>
    <xmx:7NbBZ2zSEXvN3Isetgkk_iN2uRSGh95x92ij4itIfPCliQ-pWoXnqw>
    <xmx:7NbBZ09D_nXX8SJOLZKyCUHjikciAK1eZksn2PVWHJZgVbyGyd_BsM2R>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 10:31:56 -0500 (EST)
Date: Fri, 28 Feb 2025 10:31:54 -0500
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: t/t5620-backfill failure on s390x
Message-ID: <Z8HW6petWuMRWSXf@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I see a new (and consistent) failure in 2.49.0-rc0 for
t5620.4 'do partial clone 2, backfill min batch size' on
s390x:

expecting success of 5620.4 'do partial clone 2, backfill min batch size':
        git clone --no-checkout --filter=blob:none      \
                --single-branch --branch=main           \
                "file://$(pwd)/srv.bare" backfill2 &&
        GIT_TRACE2_EVENT="$(pwd)/batch-trace" git \
                -C backfill2 backfill --min-batch-size=20 &&
        # Batches were used
        test_trace2_data promisor fetch_count 20 <batch-trace >matches &&
        test_line_count = 2 matches &&
        test_trace2_data promisor fetch_count 8 <batch-trace &&
        # No more missing objects!
        git -C backfill2 rev-list --quiet --objects --missing=print HEAD >revs2 &&
        test_line_count = 0 revs2
+++ pwd
++ git clone --no-checkout --filter=blob:none --single-branch --branch=main 'file:///tmp/git-t.sYdo/trash directory.t5620-backfill/srv.bare' backfill2
Cloning into 'backfill2'...
+++ pwd
++ GIT_TRACE2_EVENT='/tmp/git-t.sYdo/trash directory.t5620-backfill/batch-trace'
++ git -C backfill2 backfill --min-batch-size=20
++ test_trace2_data promisor fetch_count 20
++ grep -e '"category":"promisor","key":"fetch_count","value":"20"'
error: last command exited with $?=1
not ok 4 - do partial clone 2, backfill min batch size

I don't know enough about the backfill command to even guess
what's wrong, but hopefully this is helpful to those who are
more familiar with it.  (Stolee, party of 1? ;)

I don't have shell access to the s390x host, but can run the
test suite with additional debugging if needed.  I have the
test-results directory from the build as well.

Thanks,

-- 
Todd
