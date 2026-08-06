Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FB23C943F
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043203; cv=none; b=WfM/biAmbcCSVSa0Xgnr6v45oMzuAC84zG6N5Cf7SRGCg4u6WAUYCREGKPTwV6m0Q++PXR8tprW9Sjih/43VlmMHJxuqq4RG20h3Ih/OqPOTnlnLGLbOi0/W7l6+bv4npmC18tvS0nCAaHthstCoWloE8BN4SXHrk9FLttb7bxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043203; c=relaxed/simple;
	bh=JTEsflXGrlk8taxo1JYyy53ziz2ZiXq3orfb4CbXYfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K5Lpk+YVg8snsdMW9gSm92tVNyyKrGI58FObWxwxAEcaBrxLmJLMjWfVFIoxtO0K6nKVxKDV49b9AmO1C11TqrDDYumQAk4U/LX8Fhw7IvezYgGlYLkevM3QjYgeyMowUYGQeo/ytEprlUHKA8BIhBr86acAzUKPEo+N9NQuIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jNax5qpd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2m4HImd; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jNax5qpd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2m4HImd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 00B591D000B2;
	Thu,  6 Aug 2026 15:06:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 06 Aug 2026 15:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786043200; x=1786129600; bh=Xm6ZCVzznv
	07aM3Waw+GStk7bLK43xoceom0xy16PQo=; b=jNax5qpdpNNfnEsCPMQwHErz9x
	+GzRcfOQE+DMCyk19QHy9V/kJ8MvijjMhlxUV7ML8NQ+HuFdKZ6hsQ1/KxwX1UuH
	vv6LSvO9ARvlyUXgkcUZY/voyWmUEJRCgfBPHkzjqhDGEHN8Dd9zyXkO8qs+wuE9
	UC5PesbcHcOQi5pBY1OMXHM5ru9+a81TTl2ctiuDsT0Yc6/2v9dZG5X59s+m7Rwj
	qW5Y91j4QgTeNzIxTkeb5ShsXoG+G9R541RyYQWb2GbgMj36T/VasKd2oSNtKo6H
	d/3r1U3Lv3KUZbglBRBYK3MCY/vzzRIaQ2DTqlz5wl5JF+P2e9k6c8tI2vag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786043200; x=1786129600; bh=Xm6ZCVzznv07aM3Waw+GStk7bLK43xoceom
	0xy16PQo=; b=Q2m4HImdOIOprJ838hYyJzPxTCpBjriD6yfBba/D+TqckUc7ykF
	C7ZBAZNjaMsK8Pmc+JE7eYzIXeU8/HXyFmaAJoZXRWzNwNzrzmnmx5XQVjpOsJQ6
	HbaILIW6Gmtgcppo6Oh/FLiU1ssXQFH2SrQfBIULx5z7XJ8jrQKCbKAY0Q+qoDct
	1W0vF+Y1YbDurnK8N1QZAsX9CKfx/YxkH5KpLdKdeVAhuZoXm5NfLZAHu21TUoZB
	qOQkLz2kgIy4V0AgfWCM3UVqewxpITYNikwo9uJUdfAFQ8QKQmrs1QgOLUwYI8YJ
	h94Q7q+IC6f7gquthmNoZSAoMe/eRUmSyHQ==
X-ME-Sender: <xms:QNt0amDxabsZa8d6OdC462QPK_2iVMoMPDpP95MHD7aOSCcCCSqDcA>
    <xme:QNt0anjGpiJCijGT5n4y3wlcs6reeH7sauP2qir3dk82EHMQaUdB_yo5qywmtp7o0
    IxVgWzIh98eEIRFu6N8BX800WdI0igS9trtXdeBMh-Vbxe1pD0oHag>
X-ME-Received: <xmr:QNt0aule3Assj7KKMiieIIMt2x7xbxOdFzHswUrK47P8lX4bSZ86XnXgaXFt5sHSdfwpY_jUBj9aobc_EhoccXbNbhzq9f1I3Q>
X-ME-Proxy-Cause: dmFkZTEBEzGqig6TvgaEAo498HkBdiQFRt4oakgig+p/N0NCNNQuDvHCLZDVPYHhZLUmcR
    RX0YL80UGIy/faPLaR04lgw+YaVZZwsDoCYSq1EJUNbBaFZWh906iofg2LMq4N0DsbsCjN
    NfZwEWdC5TpYqyehxsQK7viPgopcAmF5Yg4EbkMSViecy6t4sctDXWKoj1vF2g7oR95Kzv
    MlhpZuoFPZLSBWKdsFO2a6u5cv6xQEFTPnzD8EHyFCwB9C3+goknvi+sqpmx7z+l+Tr/Sb
    3Vsh7v3RJVcVpqGxYxnneEb+1fdfTuQz8Dqk+ogXpR1iQ3u1lDLG3f3Cec8CKFljuGX3rR
    Vsd1YlKjxmEZqAADQd8vY6ElGy/jjuuWiXQcOExQmV0YFNUuzVCXQ6gvTJ1hcmC2p8iExK
    a2Hcmi/O1zRaV1c7vxhW3765/efpKFffEiVRgzA8RbRTGRF/oQXTd47gS1X61HWQCB2/DW
    OFeLBJLOIrUwySWXR7mF6kkqS1iOLK/mJIcI7VlKFST7wwnO6mhUronBE0gEF1rXwVpKUN
    2+L9cQU/kp6zQ9yAdSMFuhNM2eH5IEkgwqnFIiCiYxFbpnA6/Wo1ci9N1phNOkIUjjTrP7
    BJJEGl6j1pNUj7eJkUvwH+81/N08+k78YgQQakm2/x/gYfEk1j6+yoSzhV1A
X-ME-Proxy: <xmx:QNt0ajrNBXCTVo3DexR8hbO84IFSjYEeovrcGAqh3_FVzace5AwsJQ>
    <xmx:QNt0anGzkxOq4Z7GlgJaAsBxQWe-m7_pWItZhIykAKsCWR6dTYr5cA>
    <xmx:QNt0avw63cEGJBWqyRIAoK7BVVKYwDU84GqRWTUdKwQkEsDTpZpKTg>
    <xmx:QNt0asqYa75AhcWjaI00Z6cRdPzYGCYJtnmZBwt0H21vB8X_xZbBVw>
    <xmx:QNt0alsA2XU5661RH3u4TKT3M5kzP8x8K0U8pHv23hnQHs_ou-TenqNQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 15:06:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v7 04/10] t6099, t6600: add side-exhaustion regression
 tests
In-Reply-To: <CAL71e4O7HXmNOPJr=RBRRkFgzg04JUWE0qD_Gx3_24d2P-hY7g@mail.gmail.com>
	(Kristofer Karlsson's message of "Thu, 6 Aug 2026 19:20:11 +0200")
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
	<e8565ce0203e7f94f3f1ac193eb1fd703fe50463.1786013982.git.gitgitgadget@gmail.com>
	<xmqqa4qzmdp7.fsf@gitster.g>
	<CAL71e4O7HXmNOPJr=RBRRkFgzg04JUWE0qD_Gx3_24d2P-hY7g@mail.gmail.com>
Date: Thu, 06 Aug 2026 12:06:39 -0700
Message-ID: <xmqq4ih7jcg0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> On Thu, 6 Aug 2026 at 18:11, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> The log message and diffstat contradict each other.  The addition to
>> 't6600' happens a bit later at step 6/10, which presumably introduces
>> this finite/infinite distinction, does it not?
>
> Oops, you're right, that was well spotted. I am not quite
> sure how I overlooked that. Will fix for v8,
>
> Looking back at the history, the commit message was correct
> at v4 but when the test commits were split/reorganized for v5 I
> failed to update the commit message to reflect that.

Heh, sorry for nitpicking.  Maybe others can give more serious
reviews on the topic.  This gives us an important optimization.

Thanks.

