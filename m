Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A962E3F2
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339021; cv=none; b=ItbtWKUArWASwxWBJm3OdD8gY6Na225oe69+dShwcG5n18l4Jqiv4XqhY0uWTZ1gwuaYCfcnuNHvs51x0iCWCEF9rCnD8vQGtPqZ6PC1TO6hm7HaGVF/izlZpiGi6hbCSncp5gHkG19l8yFVKpiF+vwUsBEqeXUASzXfXfEBCF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339021; c=relaxed/simple;
	bh=M1ToRUg69P5JIj+cO9dWLuirp5oo+1j3+2BOoK9moHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E0KPkOaEpO5664kbk102Ao1Ko/6HE9M2p8VldZRI9ObkQSHgBwo+aF/rxrH857tMSZABJhA6DGFj6tGfkXy8CR4HwJnzLwTbjArB+khWVuxihv3R9A8hhNKbYtEitGTbGsy4XapxFFq90Go2e3cvHh4kDu1wu3cLdsh4w3E/C08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=scsxEMfA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="scsxEMfA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CE7C82EACE;
	Wed,  7 Feb 2024 15:50:19 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=M1ToRUg69P5JIj+cO9dWLuirp5oo+1j3+2BOoK
	9moHo=; b=scsxEMfA9Ktg4wv3JW/ISM1C4KyWmvL57MhiVH+ALdKKgZ15vvc9sm
	Y6UjcP2Cc5syvxuAgrYH7gOCLf3XWkOdeaHH+TxX/YG69MPuihXvkforE0VXm20o
	GWgNEUHeuNbnad1rtmCW9LrPAHef5Wa2fF2JVvDukwjuKWRpg6QA4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C77FD2EAC9;
	Wed,  7 Feb 2024 15:50:19 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 77EEB2EAC5;
	Wed,  7 Feb 2024 15:50:16 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 5/6] unit tests: add rule for running with test-tool
In-Reply-To: <f2746703d554d65d41afe0e41b1c9757427cda26.1706921262.git.steadmon@google.com>
	(Josh Steadmon's message of "Fri, 2 Feb 2024 16:50:30 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1706921262.git.steadmon@google.com>
	<f2746703d554d65d41afe0e41b1c9757427cda26.1706921262.git.steadmon@google.com>
Date: Wed, 07 Feb 2024 12:50:14 -0800
Message-ID: <xmqq7cjg80e1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F682B0A-C5FA-11EE-9EE1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> +unit-tests-test-tool:
> +	@echo "*** test-tool - unit tests **"
> +	( \
> +		cd unit-tests/bin && \
> +		../../helper/test-tool$X run-command testsuite $(UNIT_TESTS_NO_DIR)\
> +	)

This limits us to the tests that the Makefile knows about, which is
good.  Of course, we might bust the command line length limit some
day when we have too many unit test executables, but for now this is
simple, clean, and readable.

Thanks.


