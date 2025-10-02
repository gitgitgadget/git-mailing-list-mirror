Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF602D8362
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405494; cv=none; b=b4uAclgys7PaVqeCdpfvFgsHErPWJ0D6x642G50GXXEqbOmMGhmbWNRSlqAxcWYQ7FymNmM5iSyej66dfMb37qUXuO+ghr/QB+UcAnUo+n9cicJa5ZBGMzwjDjssexQT+Ac8x9bNQwntmKTHdVy+Cq7cN+XXHA3+1wMDN0RO6eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405494; c=relaxed/simple;
	bh=vmAcMFj/tnkv062C/aC1EY/ff2ijp3GBrA7hFDqFuEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TunQU69f+VJGZAs2CiAZo6JBrgl10GCe6SY2deH7EPlNEaR+CuFz9F5xBLKBOBlTrl6rSc42TmEpZthizT532Nopun2TF4H73iXG/V6mEHs2kaUjDlZNnA0WHobSz6aTI8q8H+C0EbIYQrcxYc6Roi1xD6n7PEttzAGFq4D5kPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FsH0z3xs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MJIp0Zet; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FsH0z3xs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MJIp0Zet"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EE2367A0158;
	Thu,  2 Oct 2025 07:44:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 02 Oct 2025 07:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759405491; x=1759491891; bh=DqZDjf6mr9
	jXKN7wT6McOCviuMMAxnnQO+NmW5sEKmY=; b=FsH0z3xsGCxBILiFs31sal+Ebu
	PruZxIMn2qJKya6xzsiloVl09xiu6bW2cU3J6zJebTnYvCqiEgfg8HBQ5AlwJb52
	8Y2JT61KyN644aFBFZdbkMvRuIVSxa0D3bsPfOfkEl8STDPjT/Xsn9n8Z0h3+SzQ
	9fgViF6pLFOhiRvwfJNO75VATIR46n+Kh0PByAxxq43ROvy0JrROePGaGdzvyPo3
	z2h2b1TBCynuV2A5aUvxugYBqxblHkVNawmojOCY/qZ5PnFx+Di1eTZF3i+EZICe
	fQf37wryp55/CfMlDgjwhh/UW64FwRlHow+qSAA2pPV91d5a10AbcYKuYc8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759405491; x=1759491891; bh=DqZDjf6mr9jXKN7wT6McOCviuMMAxnnQO+N
	mW5sEKmY=; b=MJIp0ZetXdTHl1Un8GsFOAIaNVbtGJ3+pbKrbsf5Kv3YplsFUJa
	5QXIjlNTp5bH4N2ye8i8I4i/O0oxKZRngklzbJK66EUpQDqllYmKOxTiMHz9Z88i
	Vk+/HpAq79NrkwqaC4N9RMQhjgipm8s0AjBK041dXFUFd4xYxIMSvmOYWPR6eV+/
	CcCaA94qdxexS+RgHgONd0QvokSJtGbkUilUNQzOwmDPI2lJaSnj6BrgN4G0q7bc
	aRWv7GupnlgKsCY+k46+0Mq5irdZnLRfLnURVSMrGFagA2CkK6NSFhTZk6hPijoV
	JeH133415jYaWc12ZLBacapoLFuA/PKYfBA==
X-ME-Sender: <xms:s2XeaCE67LsisiArmS-1U76pCbjCRlbCKKXjFN-JhH2OFiZppZ81PA>
    <xme:s2XeaKUmaddMKUq3WM2BnFKCnoGEqaj8I2vxKuTYuGanvLJsHcYPGxk1WrzRya71a
    yu6crez891BE0VC-OmzeeVGifMPfJ_vfut4UeHoHKwRWdUobr9RCg>
X-ME-Received: <xmr:s2XeaBLAg1T0qsJol_5yjhNhXyqE9vaM1cr2_I575VbnHk2BJq8vv-r9FmIfxXiZKJjr1-2WFDAMBjxcN6LqsFQbuG2jiWzrdqjjvB4-eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:s2XeaK8BYeB9_dbyHEcpXGYPViDNmwVJwEu75dfTYYBsrFsRoaGtLw>
    <xmx:s2XeaEInZq2CcrEC_rgn53F0LvKZflpWndZ12v6ek-8iMRz5AS14Rg>
    <xmx:s2XeaPlQMlevRfxU-zHzqz1sfoZ52k-JNJ6W_kjlF-WdT3j4mRaLFA>
    <xmx:s2XeaINDo3CS0k7rA8mhotpAXVhi4l-2FTL20Dfpn47i57uUehyVww>
    <xmx:s2XeaMrw_mGdkkI4_1zNGKgNwbgV63LPiN3DZadtZQ_7TbUlPbkTS8dY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 07:44:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f83caee6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 11:44:49 +0000 (UTC)
Date: Thu, 2 Oct 2025 13:44:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Subject: Re: [PATCH v4 7/7] refs/reftable: add fsck check for checking the
 table name
Message-ID: <aN5lrhCLQFnw7qUB@pks.im>
References: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
 <20250926-228-reftable-introduce-consistency-checks-v4-7-c96fd8551c0d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-228-reftable-introduce-consistency-checks-v4-7-c96fd8551c0d@gmail.com>

On Fri, Sep 26, 2025 at 09:25:50AM +0200, Karthik Nayak wrote:
> diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
> new file mode 100755
> index 0000000000..250d244e66
> --- /dev/null
> +++ b/t/t0614-reftable-fsck.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +
> +test_description='Test reftable backend consistency check'
> +
> +GIT_TEST_DEFAULT_REF_FORMAT=reftable
> +export GIT_TEST_DEFAULT_REF_FORMAT
> +
> +. ./test-lib.sh
> +
> +for TABLE_NAME in "foo-bar-e4d12d59.ref" \
> +	"0x00000000zzzz-0x00000000zzzz-e4d12d59.ref" \
> +	"0x000000000001-0x000000000002-e4d12d59.abc" \
> +	"0x000000000001-0x000000000002-e4d12d59.refabc"; do
> +	test_expect_success "table name $TABLE_NAME should be checked" '
> +		test_when_finished "rm -rf repo" &&
> +		git init repo &&
> +		(
> +			cd repo &&
> +			git commit --allow-empty -m initial &&
> +
> +			git refs verify 2>err &&
> +			test_must_be_empty err &&
> +
> +			EXISTING_TABLE=$(head -n1 .git/reftable/tables.list) &&
> +			mv ".git/reftable/$EXISTING_TABLE" ".git/reftable/$TABLE_NAME" &&
> +			sed "s/${EXISTING_TABLE}/${TABLE_NAME}/g" .git/reftable/tables.list > tables.list &&
> +			mv tables.list .git/reftable/tables.list &&
> +
> +			git refs verify 2>err &&
> +			cat >expect <<-EOF &&
> +			warning: ${TABLE_NAME}: badReftableTableName: invalid reftable table name
> +			EOF
> +			test_cmp expect err
> +		)
> +	'
> +done
> +
> +test_done

Nit: we don't have any test that verifies that `git refs verify` doesn't
complain with a well-formed stack.

Other than that this series looks good to me, thanks! I think we might
want to have one final reroll, but once that's out I think this should
be ready to be merged down.

Patrick
