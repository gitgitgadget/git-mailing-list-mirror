Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763B2E6CAB
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400581; cv=none; b=giGyMMId3fqQLXmrkCSynzZSGkeU6+n91RWUZMq09sT2hIykHFkp7xIA1v33XmoAA7xb5l3UMzztSHLRTG2OSV2UkNBoeXY4E8cpgjXTmFGAl+4vHz/VW3+PFAtTKCzrbfNqSofYKc3y7HrXiwcuT2d6vNiSGMvmG9yb4V/wtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400581; c=relaxed/simple;
	bh=Bdg+flNAhEHU/+plxm57bu1oop+2Ur5uACm1IrFSL+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ATtUrrMZ4l/5kvDcF76e9lqWQM6MG1Pap3a4LZrU9W7hOOzLxlHa/wkK2+UPgQqv3foym7uYMzxW/yY2pZks1FE1uV0GZ4zLH6/1lpMsXnuieLIOeKzByb/WVwFSwWcHeABz14MrDZPUj1GyciCuctUJV6yrIBlUtk0TUVB+SBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F/xPMrxX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LEzprloU; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F/xPMrxX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LEzprloU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B37871D0008F;
	Mon, 14 Sep 2026 11:42:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 14 Sep 2026 11:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789400578; x=1789486978; bh=SPL38qs3p/
	UuEODjxhXpOdR5QNnnTWCvns1ae7tP1Z0=; b=F/xPMrxXF4df4VZnI2GndAddku
	Z+V2pOO62wHPg/Y4RKTE5XfmoilpG0WE5PJ9xvaKvjBmYpossldAmlgsmNFtrH4u
	GzgN6V/MIGBytIVK99CTZ7w1cuPuH1Wb0J6JYWfkZTjEsxYL6q13pQd1+obEgOHZ
	65UIlIhBfnaFUSnxplvhssh1D8wZLp4F1TvEpvoh4O+JArp07sLZ+Pz0Om3qPG8z
	LIoJw8Hbt9b6YnQC1s8RAZhC3lNXNYUkhUeVqTwbng9rySzKUBzKWy4HZhFGo5gG
	c4QKdJbMz212MQDeMWtt/wig52BLuVQk/2PF5Uv+pimwvqPA8qv6yxSBNGAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789400578; x=1789486978; bh=SPL38qs3p/UuEODjxhXpOdR5QNnnTWCvns1
	ae7tP1Z0=; b=LEzprloUWJg4tlBu2cvxcmhRMRHVxiKbH/5naiYTydFQ8YO0hL8
	x4QBf+XsehUiVHWAPgjd3JkZHL/55J8a7PV+4VmAqWyuWJOJb72vrKIZ4l6vgjf2
	O/lis+lQteB/O5SFfwEV3klmNn+x7uCfApS35RPbNhC0Nejddr0z6iatyCdYnzhS
	MDDXKZ/zH5MOEPx8LOjAYTa2Wl8iz/z0ge6K6xYaQBF/KrHu6LABwpn9oiIztQ1n
	v6j7u8lBGxLxlaETSuTKQvfVDloP66LLsxXmtITR2Tq6Hm2P0p6CaEF3Jbwg1qbD
	PFzxirs+2j5esEIaLRzUP2Hydd7MNhSTZtg==
X-ME-Sender: <xms:AhaoaijXWwzXeBwdZApyUHU7ln3U1EKQTH-hFVFA6RyUP0r0JqS9ww>
    <xme:Ahaoap5ydeolYHmDgTipFh1PGjbha7L3hUFRejW-zPcnfkRZzgR4VJsOz0TUvIpem
    gAdFepfbhqDj7z0tmU4vvMwhFO500JT2337dA-bIkFLe4qnOfObh7g>
X-ME-Received: <xmr:AhaoaiZUtqnSq_OrsDYZJQ82mC5rcTqJ3hHfeU5WRIyyOyRRO1yJ4diAOBEQs7ddPoW1P0H25bPJXK8XnVoSW-XnEsnTPHSRfAx6>
X-ME-Proxy-Cause: dmFkZTFTZzd+L/bF3evu5xgewHFyfjHWBz7gSZreTBsVP4ud/As04rDrpdShjk82EKxx5T
    cWQd0SGElTGcl63W46FCuM4cYTn3ZNYqBGe4px0TPiW94nxvqMIFw2z/+9J0QRCbE9r7b8
    khHVDvESfiVDObXrknZGPmjEEW7jufB02UAm3uaf2g1KK0QiAQF201mIqeue5vN5sdUvBp
    Y7j458ZCdx8EOR3JbvE2HuFgiyB617sPbwRhGX088z2LA8+nNsq1Zczt2ZuTMURCn69NVi
    fDkT96nedeS8UR1LdDhqRpga8II6QNGe/ZS1pTr80SprLzQWQf33RI2KWBbJMokyC9ZfrF
    aBWVhESzqea9i2Y1zMJKoViQyhnOKXKDIPnVLAfLuqlcLu9y45LLTG8Td5z0qMeG+ef2LN
    aGSz0u8SCA54Mn2urNEIi0Y8/wvl5zdt4gvGZxcm7CfWCB9YsErN00MmIRVjXb389iE5rf
    BI8oWNdlUBcE3iivFV46UPQgPZ++1PlUunmbN1C1Gweh9k1zpAp/1DD0KChiFv9bXYQAq1
    O0QuwoxSYy+j6TdvQcUDbzuv+HEJWBF2b3k282+qP1AxnlwMartS3xxN6kxiH4aGc9sXmX
    HOeOvMDEcfPyIwrV0568sLWlKFkPEXXhOGWYok0b8KVAIm4ejMJJiRs3cNzw
X-ME-Proxy: <xmx:Ahaoam4i5R6tf2u8Za7Ll0SKRw2U6yqwkzx2jXtPFNSGPKTQAMrscA>
    <xmx:AhaoatA5_Fr3LGgSRXLjL8DOEYIvfVik81LgJjOSJ7m_TehDXy1vcg>
    <xmx:AhaoakfXEQmiP5qN5EG22rFieg_6qJfnXsAItzOiJprYQNPOU00FjA>
    <xmx:AhaoakK7r0GNlMO_o0MGrvhaZRD5VURkKF3pk-4pi7qHsl5vb-dOEg>
    <xmx:AhaoakIW-Z12qfcgW9TIqFzidis5lHOd98_0GyZ-IQtwVZL9X8RpMmuX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 11:42:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tanishq Singh via B4 Relay <devnull+hello.tanishqsingh.com@kernel.org>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Tanishq Singh
 <hello@tanishqsingh.com>
Subject: Re: [PATCH] t7610: use test_path_is_* helpers
In-Reply-To: <20260914-t7610-test-path-helpers-v1-1-4824812314c7@tanishqsingh.com>
	(Tanishq Singh via's message of "Mon, 14 Sep 2026 20:19:48 +0530")
References: <20260914-t7610-test-path-helpers-v1-1-4824812314c7@tanishqsingh.com>
Date: Mon, 14 Sep 2026 08:42:56 -0700
Message-ID: <xmqqy0d36dq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tanishq Singh via B4 Relay
<devnull+hello.tanishqsingh.com@kernel.org> writes:

>  	echo d | git mergetool a/a/file.txt &&
> -	! test -f a/a/file.txt &&
> +	! test_path_is_file a/a/file.txt &&

This is wrong.  Consider why you would prefer test_path_is_file()
over test -f in the first place.

The goal is to be much louder when the expectation is not met,
while remaining as silent as test -f in the happy case.  This grabs
the attention of those running tests.  We want to be loud when
things break, and silent otherwise.

test_path_is_file() expects file X to exist and will not complain
when X is a file.

However, the test "! test -f a/a/file.txt" in this case expects
something totally different.  It ensures that such a path does not
exist.  It is an error if a/a/file.txt exists here.  You want the
helper to be loud when the file exists, and silent when it does not.

test_path_is_file() called on a/a/file.txt, with or without a
leading !, behaves incorrectly for the purpose of this conversion,
even though the polarity of the returned status may be correct
(i.e., test_path_is_file(), just like test -f, exits with status 0
when the file a/a/file.txt exists, and a leading ! negates it,
making the test line fail when a/a/file.txt exists).

If the expectation is that a/a/file.txt does not exist, use
test_path_is_missing().  Please read through t/test-lib.sh and
t/test-lib-functions.sh to familiarize yourself with the helpers
these files offer before going further.

Thanks.
