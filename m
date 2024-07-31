Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC3186E4F
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445308; cv=none; b=HW8SoduNeDzgHMVFAZJzXpqZ+KGhPXqp0gYCnBX/BwnsIr0XGy/RqgMoIlfUXHP4G+cLWtliKViuGgFPU+2J099bzAeuFYR4zo1jHwnJQ/0DwyIIJOo0/c0Y4rz7y9SHaNdh1pcHWiYaMZ+AoMxNK8WsHgaQvt/R1iDxhNWSxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445308; c=relaxed/simple;
	bh=L8z3e0prSr19DsrEPkWk40LwSwbkgQeZvSpaB9VXvSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BVcKNnaYyMQFc2zS5kiD1vAE4xy4Hmsyy0iWPeQyfmuEwQJBiPoOAOy0KCnmS065YN8TRCjhFc09L/ADEJ9VOdOAb/TJZ7++5whyuNpeywiZizrAoARCU+uTT6JAxeU82FLnOVJqKFCdQ19pjJ3ZVSgOSW7o0qM/O9bwysQ5fvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vwvcTHkf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vwvcTHkf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 155911D013;
	Wed, 31 Jul 2024 13:01:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=L8z3e0prSr19DsrEPkWk40LwSwbkgQeZvSpaB9
	VXvSI=; b=vwvcTHkfFfXZQ07rUUE/GjWj0JdfSWPs/4Q2++wjb+bZ3ulyn8WSks
	vlt/wlNOgrzVsx49/G6EDbudjg013dNnDUcBz4vV4e+4A6zrIaSlNRwffAfkFt9A
	jJTFjJ+lIYrmONMDWA+yjyRiLZxr1O0nEcTYVvZMdnTWgUtV6JnAA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C7D61D012;
	Wed, 31 Jul 2024 13:01:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4745B1D00F;
	Wed, 31 Jul 2024 13:01:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Kyle Lippincott
 <spectral@google.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Josh
 Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 2/3] Makefile: wire up the clar unit testing framework
In-Reply-To: <5195d084d3c1bee76e7e424afec2c09bff8f5dde.1722415748.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 31 Jul 2024 11:04:21 +0200")
References: <cover.1722415748.git.ps@pks.im>
	<5195d084d3c1bee76e7e424afec2c09bff8f5dde.1722415748.git.ps@pks.im>
Date: Wed, 31 Jul 2024 10:01:38 -0700
Message-ID: <xmqqbk2d7ax9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8E344748-4F5E-11EF-A20B-92D9AF168FA5-77302942!pb-smtp20.pobox.com

A trivial fix-up to be squashed into this step.

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git c/Makefile w/Makefile
index 8ebcbdc95a..d561789582 100644
--- c/Makefile
+++ w/Makefile
@@ -3735,6 +3735,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
+	$(RM) GIT-TEST-SUITES $(UNIT_TEST_DIR)/clar-decls.h
 	$(RM) GIT-USER-AGENT GIT-PREFIX
 	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VARS
 ifdef MSVC
