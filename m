Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259C3C5DC3
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538816; cv=none; b=UxUSO66MSsQjDouD+w4D6xoMCl2sTusP/VLUvCgh1v6mQ7qJMK3/lg6y2GnKuR7UeGfmdBBpKKiWzjbnDxXlfJxM8awk5XyfpjjOsNW9KkYAJErYxN3FBxFDtjHrDb3FyZHK0FTuzITXEh/t2Cp9lGntkvStCDRQrn1XwkX7WIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538816; c=relaxed/simple;
	bh=1FylBeGQrFF7PiZFX/qycAKtW5i75Uo0Pv63Lpv6SFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WsX/7gQnATI9P0X+GGPXZbQ4ArWPL7fvuzKqdX73eFHUVgDE1EV956AqE1aUlXaKTag6FafexUPNKZIM91/D5Lzn8hP0ohP1pnyIpTVJFgCqmVKQyDesF0XKSYFz2ecNWNOZ76MJ6SYc4z8ouKlsIWAm/jF9zMaf6Dub7F+iMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qQZOXnkv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q/Rk+uaK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qQZOXnkv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q/Rk+uaK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 51EA8140010F;
	Fri,  4 Sep 2026 12:20:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 12:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788538814; x=1788625214; bh=6dOx8SCEyk
	ltZsxHIHi0YhVmMeopsDLLW+8tnQjwhzQ=; b=qQZOXnkv5BiGu8eL0yf1o8Qf68
	cph/jWpZ/UXGtoOOF2rYHf8EI0lnhDSFPzQTXFRwvWptmrG1uxBanQnIbOEFCUpO
	7sAYTvZsx7oEQSZhe0P00xSdanM3XyHMwQYEaoamxi8EAlCMFBY9qQehF4Dg4eIS
	9h4ZQdTKNbOS5GAchlv1IGXf9J5XUv6RNnpSiXtMT8gNXv4r15gUQ2YD90Vr9Gxt
	A7KXbPYiyBcG+zz4HPKUjNL5vBSTpRYrg0wVQu1rsegabUw3BdHLGlaYI+5cs2EY
	UNvZuciVLnH1gvj4p36mH11p+pZ7UH+I4J5Z6/JzbdkULoMXrl5Lqfcs3RJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788538814; x=1788625214; bh=6dOx8SCEykltZsxHIHi0YhVmMeopsDLLW+8
	tnQjwhzQ=; b=Q/Rk+uaK1hbnqjNKbp0jVGNftuPbxL54HMfrLu7QGr/HNTysPrL
	IHFNR0d9Lude+3+dYJIHaY6OlV95f6Rn1w7vTye25hKOtiaExylvxtLxcooujNEk
	dzJndemgExAcY2015ThU+ZD1BwAdsMKWwTpArOZo9a278m7bwesglwKM9gUGUigk
	pDEtyNAPIqjXho5jDSq9e6AbBmALt/04VEy8b5j7uhAKJwU/yowuI0eWnYpJ6ktV
	I+E7orohsGyWvCXOB7CoWxVUmqzkW774KphGQoaZtMBTf4RG5Qwc6XpXPeT+dMMV
	vVa+5aeC8CaoqQQ6XFBv+KCH/MGblL8vWBQ==
X-ME-Sender: <xms:vu-aarbAUoWPjIbUfuqUf0bo0fZ2u1C2X1RBqAaBoE9Vp3yHzU_Rgg>
    <xme:vu-aahZSVvy9t73QeeciMyMoXpTl6oVTxHr3jIWu7gnQGtTDDwcPQxRLsRz04glZ5
    tabOFIUIktqZ7JMl5OeTXj-qToBZ9e3MHYuyjTnpDMmWATQMGO4zyY>
X-ME-Received: <xmr:vu-aai_FsizdkJa-v98wrW_3W4cF1cC9xT_5iUyq-BXvXy2S0Qrb_8h0zLPDPeClAvIvPhp0CxYTBM1fYpMWsBnWdMK82-zH_g>
X-ME-Proxy-Cause: dmFkZTGdIRWgTKCTUnaj5HxbTWZjrKyaemRAzNgtWQewrBiDum37Jt2iVjQTTZP5k9GKHc
    ZgdAp4YVgJdgXqLAUzgMGu0+rs5k5ONdZt6ihS42Sk640eQ7q34DQKgpgJhMWREQdnLrh9
    1UrSHs02H9kckLJVzjSjvZeuLNjKriGILcC+A1q/fK3mzF3aepnFNNLZru2hbKC/89fLNQ
    fUi803JNoYagAGHp3z5t+gTXxB6qDRrbG2aV0pHH/Sy7kgec8XciK8Hj06jT5jmelEzx/p
    ZZO2OXwLEnC7LNX9SOK86mP0fMUTjPTrfJZ6Y8W/G6gVIAwqgKUum1TLIE0sDBWztRsReD
    lvsl1uI/N2ZUbMwCrsbHw89l+K6554QBq+UA3rR3+9TA7yQKUj6kxiwbnOFuCzc7dbrjCQ
    VGrA3i5KfZ4kGHE9BI9AXJDUeExuR4McYVLYyF6kEPvWmNkxtOEN/Rd6Tb7EkusWIfaIgP
    VuHSUKxGCX9ZAeQMsDvYeUXVgxSq35kUIN5o46vJA+iBIO3ZOFhJ3KDBBKtiafXFMayO77
    K+UMxrfGHflvpUtkf4IF0wAiQt+cGcFK/VnEFWp7M8xZzbE7unOrMucZLyR6deMPxWLfAh
    tW8lFMGs8i6I12NQkWZGWpKOqDCwWyXYTfEjWiFCGVVOd8LSHXNuzmySb2Mw
X-ME-Proxy: <xmx:vu-aagg9ugeXVVs5y60xyzJvosDlK9Wuj3YsjI2ByD08kIi3wDvlTA>
    <xmx:vu-aaidiwn27PRkjQ7LYndiPl-ZCDYdmSuWJMvepYtL4F91vDAcRPg>
    <xmx:vu-aanoifczfbo0t6OlrDuzgp0IW7wtdVRPMOL8sryU7W9cPA6FNQA>
    <xmx:vu-aanBdpJq9rB7I7wiYeazonIzAX1q4NLokHYJPaos86gOxcoI6ag>
    <xmx:vu-aatdV8NVINrz7aeHI2_8MnbhQ4PGMetQqz7x2XIzfuoguZWrcoCSV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 12:20:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Aleksei Sviridkin <f@lex.la>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a
 conflicting --no-commit
In-Reply-To: <5a5c7552-8fc8-48be-abf6-063aa31f7711@gmail.com> (Phillip Wood's
	message of "Fri, 4 Sep 2026 10:53:29 +0100")
References: <20260903125524.67889-1-f@lex.la> <xmqq7bl29g2p.fsf@gitster.g>
	<5a5c7552-8fc8-48be-abf6-063aa31f7711@gmail.com>
Date: Fri, 04 Sep 2026 09:20:12 -0700
Message-ID: <xmqqcxut56pv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 03/09/2026 22:32, Junio C Hamano wrote:
>> Aleksei Sviridkin <f@lex.la> writes:
>> 
>> I shamelessly asked an AI agent I had nearby to guess what your log
>> message might have meant and got the following.  I am not sure if
>> that matches what you wanted to say, or if it is totally off the
>> mark, but at least I can follow what it is trying to say, even
>> though I do not think if that matches reality (for example, when
>> "--no-commit" is in effect, we probably do not want CHERRY_PICK_HEAD,
>> even though the version of the text given by Gemini below claims it
>> is needed).
>> 
>>      When a cherry-pick is run with the --no-commit option and halts
>>      due to conflicts, Git must still write the CHERRY_PICK_HEAD ref.
>
> No, with --no-commit it must not write CHERRY_PICK_HEAD.

You know that I know that ;-).

My point of asking an AI was to show that it was so unclear to
confuse AI into summarizing it down to a complete opposite
statement.

> I agree the commit message is confusing and could be much
> shorter.
