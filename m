Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED3C37703
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738871; cv=none; b=RPmxsFYrFYyub2lKzGF8ACDzA1mMyQbWuN3W3H9ysVrbUdQ/qOLKNTB27uicao0Dzq+hwWKqlkmwDlpdghMz1q05SWbAyXtoXw6yLZNbukt7NeQkAbxjrpGQ0SXE4W5pUXrvkRf9rwKIl7sm8mky906b3yYpp39Z1oyGZH+DPD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738871; c=relaxed/simple;
	bh=ajIl/763g2XhXydu9Hl2vZ/qJq08TTCZxnNor7NlYYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z+bbGOC3680ADoAoT4YCHLN9YhnY+o2uB6TNDz7OiLbT7kh7v8miBkkvgE9GaKUaF6q2r3q2sTpbyTWU7/IpbIKoVlgcoO83wx2/sj0RxgVGt74exE1Z+MwaA+heYYzeA19E6JyC/pGGTSbeOzlX2luM82SGBVp0LreAjoH2vWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jBzhnoIz; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jBzhnoIz"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4787B1ED3E;
	Thu, 15 Aug 2024 12:21:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ajIl/763g2XhXydu9Hl2vZ/qJq08TTCZxnNor7
	NlYYo=; b=jBzhnoIz4PBxskphuHaRRFUaMuXFefgTv4ECYptYN3f96DrNn3B1s9
	6tZrXTCmqg+ra6NPeZ8jTX4ee73vugl/mD5OXSRhYot7gn85ZijQbxmEslTIBZ9X
	zpXwO3qDeSpdH0SBinZ0rh61m4cMTOT7wQFshh1QS9OoOElfqV+EE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE61D1ED3D;
	Thu, 15 Aug 2024 12:21:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD0CF1ED3C;
	Thu, 15 Aug 2024 12:21:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Kyle Lippincott
 <spectral@google.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Josh
 Steadmon <steadmon@google.com>,  rsbecker@nexbridge.com,  Edward Thomson
 <ethomson@edwardthomson.com>
Subject: Re: [PATCH v4 0/7] Introduce clar testing framework
In-Reply-To: <cover.1723712012.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 15 Aug 2024 11:47:31 +0200")
References: <cover.1722415748.git.ps@pks.im> <cover.1723712012.git.ps@pks.im>
Date: Thu, 15 Aug 2024 09:21:04 -0700
Message-ID: <xmqqy14xu58v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5FE26864-5B22-11EF-AB4C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the fourth version of my patch series that introduces the clar
> testing framework for our unit tests.
>
> Changes compared to v3:
>
>   - Seeing that the overall feedback seems to be rather positive, I've
>     now dropped the "RFC" prefix.
>
>   - Fix another whitespace-damaged line in the clar unit test. I've
>     adapted the upstream pull request accordingly.
>
>   - Fix `make hdr-check`, which failed due to the missing dependency on
>     "clar-decls.h".

Similarly, lack of clar.suite still makes "make sparse" fail, it
seems.

$ make NO_REGEX=NoThanks -j32 sparse
    ...
    SP builtin/help.c
    CC t/unit-tests/ctype.o
    CC t/unit-tests/strvec.o
    CC t/unit-tests/clar/clar.o
    CC t/unit-tests/unit-test.o
t/unit-tests/clar/clar.c:209:10: fatal error: clar.suite: No such file or directory
  209 | #include "clar.suite"
      |          ^~~~~~~~~~~~
compilation terminated.
make: *** [Makefile:2762: t/unit-tests/clar/clar.o] Error 1
make: *** Waiting for unfinished jobs....

The NO_REGEX is there to force us to go check the compat/regex.h as well.

>     +@@ Makefile: CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(LIB_H))
>     + HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
>     + HCC = $(HCO:hco=hcc)
>     + 
>     ++$(UNIT_TEST_DIR)/unit-test.hcc: $(UNIT_TEST_DIR)/unit-test.h $(UNIT_TEST_DIR)/clar-decls.h
>     + %.hcc: %.h
>     + 	@echo '#include "git-compat-util.h"' >$@
>     + 	@echo '#include "$<"' >>$@

This is a nice addition.

Thanks.

