Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C519ADAC
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708802; cv=none; b=PGe2loVeJyY4v4x1kET3SQLy4pRYVPq16HiaLrjk1x0VU9sFLK2ddvG3qdZeUk5NtlrFH7trDOukWnAK2H6kd7XyJf6cSoU/YeuGoIU92QyQHZjjTNUFJmbtU7LW/ZSQlzhkY0ADgFs6ShJMYHO+2Ygix1Kn720NAn3P833DHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708802; c=relaxed/simple;
	bh=2JepzHcC1LCn/bkERx54WJA9dUsMW6vH5Dhv82xx2FM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZrTCG/qGHUCs4SF4taHsbiqsEi091JdLI9BeqoFdEnv1/PS2FJnBC3p+w2tMgRvyLBJo7ujCbIrcwBls3+Gnz4ywAyFboZEvllYmz+Z51qZ7EPjkzXkOcpW44vP1bgn9QQ6+CoVoX+84mNmTVn9ZJpTnenQ8Rnx40mR+4jr/7Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pVMn0dGk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VqtuDVmT; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pVMn0dGk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VqtuDVmT"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C593C138FF6C;
	Thu, 15 Aug 2024 03:59:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 15 Aug 2024 03:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1723708798; x=1723795198; bh=O0FZaDT2mRNCcyfBX/fa7lFXtLSgrt47
	kN41QucPnrg=; b=pVMn0dGkWH/qL65owuojNCnVhC691aJMvBA32h+iVc7SsWji
	dUWE2ohLiSFHHsM+YbMDoufJejKK1DdHcYGpDkRaVNXTQKI41MqQQRQeUZ1AXuxn
	JIM3UOuq4zHJzTfs6Exn8gGR53FDpldThlFAEnuPzPL+uc3NGYbfwvDSUgntaVL9
	r2ompk8gYjg4r4KGqsyoOHFT8nYjoX7CPQOhJprgXAXYfwoV9wHS+7hoyCqmqAlO
	eXem011frw1Gg54/i2Fmig1BVbXZOBbzMpmtdr/VQi1eUFPQfS+PJ6sGlKIe4HOS
	AojMqg77RgtqKWtPrBpxgySqb1fsFlkz2hA2ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1723708798; x=1723795198; bh=O0FZaDT2mRNCcyfBX/fa7lFXtLSgrt47kN4
	1QucPnrg=; b=VqtuDVmTXPQZ7V6tgVSnfe8MFkJo/WYDGz2UrOK4nB1jlFCX4qK
	BGGTp3z3KbCtIYSEgqDdy4M7XDjXaLBUUZckYz2p3KskF+1Q/p2+/4i/RiAdOhmQ
	o7RiDAMRDfB8s4QHPGH40PmB2ijFQ4zsooieRrC3F0rDDLwc7d5uHyzpTEdLm5ka
	IoW0G2E/djinjPxOZEsa5FVGV20scx1hrPknoRFfnZ8eVPbg013NDB/ashnh996n
	2Np+b+qN8yYGG3lh9XpNBQUW2CUGRitX4v8dDUBZNU1/qk0dqisAK6pt8PSRQ+e/
	O3RJioimnvPqJfIHGNAgPfmcA7hX2Q4vYpw==
X-ME-Sender: <xms:frW9ZimmdigNEaFEvd45wSx3epBvYZu5B3aLY5sQkmaG2W5MRCo9jQ>
    <xme:frW9Zp2xj9eYhoQRS8h5y8bumJoXYoSVyC47p6Fb1mWZLhYGxxnQmBl_6cyDyWfEx
    KEsDzrdmfXIKIF5yA>
X-ME-Received: <xmr:frW9ZgoG3rsP6JRc1cve-0EIKLu2T87TP32KdeyCTPqnNWuwGWmlgjDvlSiYkKlABF8qesfGQu5VY8Fn-OvgS37OYyOoEdb-rKOKsb4wIyYwYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfggtggusehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeiuedvhfetteelgffhhedtvdehlefhtdffhffhgfeljeef
    vdetfeevledtueeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshhstghhuhgsvghrthhhsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:frW9Zmn6EPmlrl63xEqNYzzNKPKtldfRXzElRg-hGeoT2oTi0Hs2wg>
    <xmx:frW9Zg25RHCabtNTcbn1uKxxNeUL-9VYBDmAv4G8fH_aQUPQJTG7cQ>
    <xmx:frW9ZtsUZ-pKBgXIpv5ta0XzOCr4EX2O3CzZGF0x36kW_gH9ImabGQ>
    <xmx:frW9ZsU0IgF_XMTXDKyvlncS4HIvkNKOg9r7Xf5JMMUYHndzPzSMuA>
    <xmx:frW9ZuD6draqk6fqaOx2Z6TixNAqR_WzaQ7phu1wnmAJlGlgLzua3dgU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 03:59:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a3b9427c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 07:59:35 +0000 (UTC)
Date: Thu, 15 Aug 2024 09:59:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 0/5] Introduce configs for default repo format
Message-ID: <cover.1723708417.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

to set up the default object and ref storage formats, users have to set
up some environment variables. This is somewhat unwieldy and not really
in line with how a user typically expects to configure Git, namely by
using the config system. It makes it harder than necessary to globally
default to the different formats and requires the user to munge with
files like `.profile` to persist that setting. Needless to say, this is
a bit of an awkward user experience.

This patch series thus introduces two new configs to set the default
object hash and ref storage format for newly created repositories. Like
this, folks can simply use the global- or system-level config to adapt
to their needs. This also has the advantage of giving them the ability
to adapt the default formats via guarded includes, such that e.g. repos
in some filesystem hierarchy use format A, whereas others use format B.

This comes from a discussion with Sebastian (Cc'd) at the Git User Group
in Berlin yesterday.

Thanks!

Patrick

Patrick Steinhardt (5):
  t0001: exercise initialization with ref formats more thoroughly
  t0001: delete repositories when object format tests finish
  setup: merge configuration of repository formats
  setup: make object format configurable via config
  setup: make ref storage format configurable via config

 Documentation/config/init.txt |  10 +++
 setup.c                       | 101 ++++++++++++++++-------
 t/t0001-init.sh               | 145 +++++++++++++++++++++++++++++++---
 3 files changed, 216 insertions(+), 40 deletions(-)

-- 
2.46.0.46.g406f326d27.dirty

