Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB341F5CD
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784207896; cv=none; b=ih33XUkIjD++DxXs2Z98tAEhrdli7mwLmjQ5ooOCGqpEUT2F2GSttHyQc6Q98Cc9BdMYHUGYPNH83hNHpOXoy6veIjnUrU2s8PTIPeNwXzeFYaZrr0aszvwKIZJuFynMw3oGK+shF9cXPk3kdD/TX+DKaX+BDIu5jFsJe2XYbw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784207896; c=relaxed/simple;
	bh=GZ0X+MCyI30dMbQxcSYGU/XF7HDSRI2WNcXRZpmQyPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i43aT3ymxe9V6zmpevAcXSlTWvSdBoiMV2gAJcW9I+Ry28HV5VklKqdRvjt7D9x5rXpL7MvyFK2P6Q6H55TQ4TC5cm/B6I0Z9z2gZ2cAiRwML0UFaPpxerSPUj2uBykEAplhcXXsBfWWYG9wzoVkmTrK134ot5RxZwxlfqLI8TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iXCRLNSI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WYdwW9IF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iXCRLNSI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WYdwW9IF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 62EE9EC01BF;
	Thu, 16 Jul 2026 09:18:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 16 Jul 2026 09:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784207894; x=1784294294; bh=ZN2zerriec
	c3j619qxdqX1ZT3FU+f17RuYr8wUbVh5s=; b=iXCRLNSIE9fGZ3EklCQdfsYic3
	FrYnCNDmqR26eW9/u9B8skAYEACys1YdbTfS97zAxGzHC6Rpv8hpvfuI9cBjPEeH
	DB3u4JO6hJ4wtZuKTXk/IDd50BvyiFrVZBrsUqoSUqlOV8Q9nS/3A2+Q3J6vlSG8
	pudj4ezSkwUPtN1l16Zxi+gJIkVwoKjlSATU1iBzpx0DC+C1nVMc35Ru5H7w41re
	2Y6dkt+XwJl2gqpsSMjwbCb7kp24b5RFHIGNphXughtAodFYahPOZd7kg5+QLpR1
	T8YO3EusvZtHkQABUyL4oHZ2cf5SOWEl92F12Envs87ViMUmtbbl8MnC88hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784207894; x=1784294294; bh=ZN2zerriecc3j619qxdqX1ZT3FU+f17RuYr
	8wUbVh5s=; b=WYdwW9IFxUQ6ZnryzAb1vKBw1Y1esVx0n3tIufuS8sm8unFJDOh
	tQk9W3EW1Xp1oIgZWR0cPHiRrqtTSM2EM0Xn/yn7kl1aZGoPFJPXCTHSfZB5w7t5
	dRIG4h6bYECNx91zBjG/4yhCWjUdrvIUgSAiuucqOpy9oXoY4SofzR2p4ZL4oSfj
	pczz6vNUp196ry7Am1ZAjyN3cUVVsXkWNWh6gwzNPyC3aIPsD9gKALMVz9EmtzoA
	yZCQdTWJkpnHXZ5A9fHk7NyHh+OsEKnWjb2LQyFY4ifUIev2QAqXmG8K/ADi1Rcg
	B/4/FHhapE84hf65S7DCT6yCfkS6uejznzA==
X-ME-Sender: <xms:FtpYaqhKLsyh92E47pq6QoTCArBjfj1pNWdnKeDyVMTRDARB3-Q30g>
    <xme:FtpYaiexersv7C836cJ_1pIutWsVKGg1RbZr0t_3PWxnfTht6Gmbbs1Vlvw3cXOes
    Xi9Pdyz2GpEhDPRxnNKeW9S6WEHpRQBz9K61zxQ4X3oF2HDX-d-Sw>
X-ME-Received: <xmr:FtpYavd_2GRH-S9YCYQVUQd98jHkhdKZpyCn1JT07IVM7olkN-yI1KD2b3MKbOM9kqwd-eqz1L6QfiKzk3I9TIGQRraFwCc6KZrdVpM>
X-ME-Proxy-Cause: dmFkZTENWC/DaWBoihv1K2/UXwFpYRoFN7YtOv6qym4sswsaARUV5owBDlmjyVF68syp+N
    R6zizGlqC/xScE1J/r2JEsDkq0MjKX7zV3PRI5JTvN08qryKmhrl3I1GF3wmO1PKDXWIrV
    NBdt3v8N9fjdPVKTnIB4ztrTmLG7ZmNubsmupn1Doq2Tc4OCwvIf3QUfiW2UneZ/Mcx1a2
    LY4qjEyw1/d3l1nbeWtUQ8xuwwzFvdgkb3ENkvWH6IQg63kB+JY8Axhnth4JNv1AigKkzO
    zASR6yswxC0W2w4BcaN0tL3t1wfGBX1qUGTI4x4Gd1JIMRhV3gN2mv6nCdQHYTqwpUuHNU
    q2Rc4Tqnjas/uHuWrOiYjv+VfOT5C4PdpUNjtLiaBYFon8nisfYGAH4V6dhhWYbEui51k3
    vOAvF2j0Oq6OmfUxMpdZFLQew/fOT0HNt26ptwJv6PX8Yop+8fv0OOQu8gzSrtZXHpV6mW
    oSuoxB0oXPvguITD9cTv7dB29jSw3zpQ9cmMmsayDR3hrXFrJbu9uhFkMJqQ1YFcsm7Own
    yX7BsFfJe785w+hMRG2++gyS7e5pvghNrIQAl6uxThhkQ042ibvbSYfEkkNCF2LqOJxJmz
    7hmPMdoy770jb4Ba2aY4jRsrVCB0YlhAVh8mjTycF+eMso3CIHMVEYJgHEEA
X-ME-Proxy: <xmx:FtpYas_ppIUJ4GNVAYMeodEh2sAvEXr_LbS_UDPA6KJ7ChC4XYUlMA>
    <xmx:FtpYarkCfYi96FQWAnb9X0kAGcm-memvJ26eHym-f71VQlP70j_GYw>
    <xmx:FtpYau_fyWhrMrqbLsDYMFu1ZKzJflvAkslHYB5VuoCZGeXMfAoVUw>
    <xmx:FtpYapkcTB1VbP3pm_0i_NnFGkMr_OwRiAqIkup05tC3t_FHecRprw>
    <xmx:FtpYaoO3olH0vDZWwa6mGgObyaQYp6iaWOP3Lr9v_DB6P7FRZYYJI8oC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 09:18:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] submodule--helper: avoid use of %zu for now
In-Reply-To: <87a4rrxg3r.fsf@gentoo.mail-host-address-is-not-set> (Adrian
	Ratiu's message of "Thu, 16 Jul 2026 15:40:24 +0300")
References: <xmqq4ii0ko9t.fsf@gitster.g>
	<87a4rrxg3r.fsf@gentoo.mail-host-address-is-not-set>
Date: Thu, 16 Jul 2026 06:18:12 -0700
Message-ID: <xmqqa4rrjcob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

>
>
> LGTM and sorry for not following the guideline. :)

Thanks, and no worries.  We all make mistakes.
