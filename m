Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355E2C11FA
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787777641; cv=none; b=L7FVVD/kfcbKHQ6irCbwzA4TI7hQYZHRjd4R71Dgf82Cku52oAmYsoHu7XA7zlXwmjqMjBNu/YwCZmUoBVHnXK0fYNYvd1pkTnbdWCdlWGSefs6Ugq8QxfJ1rHrXFyxXwebp46SLslbG+KmbCSDtI4n9b+QZbKN2X2p36n58R/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787777641; c=relaxed/simple;
	bh=OsBiCvzvLC2CaLmgpC2f7rqthxybBzt442JdxzkLArU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AjxoxMvUDcfd4U5F5YJfJFCHrztimv5Waxk377F7XTEgXafRHZZ9nQQiGsfHk+0+SRc8CsmXUfZx7pEeEUuHJ6mGLdKzEPKqmUoSlDA5+MEdv/Fv9psaYe6o0B3V5VhelT4OuvyWqe4QUrBjiid/dSz83uudvZXpfuVO8WqNxWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JWGleTew; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cAD/iW+c; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JWGleTew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cAD/iW+c"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 314DE7A0073;
	Wed, 26 Aug 2026 16:53:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 26 Aug 2026 16:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787777639; x=1787864039; bh=grtU4ferYV
	gNM8AVfF5FUAK1JZgNsUfPs3Da/8pj9cI=; b=JWGleTewkHB2wEEsAPzMGAv6Zd
	gxhAYGnFvqyqFxpAEXfyK7CxNlFZoX3uj4QHgz0Flae4E9445lyp84CC7ZlGx7ks
	n3Q3HWNP7KAmoirDuagJgcEdTwdZeqgBROw4C+mTXjnzpdikNtZK2ipcBWspwJIB
	5abLFEUWaI7Lln0DuzFxn1WH9LJO/Q8oZNZwP+WapiAybwkfoRx82u5ztcwaTRWB
	6BcG+Av3DN8zy+QtIvd2hYJtCX76ZRu3ZQmoSm6xAi/LET/FeG8t9TrkKUUItCK9
	egfjfQhxQENSOaAV3AK8UZ9SxLN1+LHUvCQPy/0vWzWL9mf9g0C//ujNF5og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787777639; x=1787864039; bh=grtU4ferYVgNM8AVfF5FUAK1JZgNsUfPs3D
	a/8pj9cI=; b=cAD/iW+cZI5hnTBqNhUyXvUXy/AaABbtT6x12+cfyBgTDR7rGNU
	zxgRgyDX7Qx45/+sBOozoYDHohb1YoXGvX81WN3w9IN9MfYIrfQ92t/t7yTMCfBH
	riF2lGJ/uiBJm+jIRwbirz/kTuqxtpLKipzHTXecvyAmJx3bgnktXzDDtZFsK6AP
	DlmshYuDkWvqC7Wb8tcOS+ETbMBVhGnnFbT3gq+5GsDdYGle0qWWB5NEnb8bkk3B
	yyqpXY0K0ybbXHvUW1DU9ENk2/7CBwf9T6Gc58mzVbYxA+Wz0YW3DVK4QIeE2jpe
	RuKtp2zIWHlhHoBT29E50Jl5LD1l8UeyG3g==
X-ME-Sender: <xms:ZlKPaonMqF4mmfLYkVg-lSETiRRphGA6JDFZDVCEejC6004ePv3nSQ>
    <xme:ZlKPagyG6lXTzq1D4mazciyk-49dJ2CjqMkzSz0dAzdbiBOp0IWYyzqm2qA6vX8I8
    dmx9ww5ZpmvaVsvYjDkHzcvblCDOuUsziHzrH7lYMma74wiKSsGwA>
X-ME-Received: <xmr:ZlKPaiMjk5ppKIzzrFA-Sz_8bn0HOFdocFNH2mLIE4gJzGLYT6QtLU53AZnZWG2xkfxlbYIFVRXVBEiOcAROJEpVS6Mzen9Xfw>
X-ME-Proxy-Cause: dmFkZTGOVqw9WGtNBl3COnZFCYyRKX7zYxjzgQ25ZCBrTmJr/nG+lKqz4mcBlubu1ACZQf
    vI1coCmoOh8X5WZdFc6Wvuo/wlPdaLCJ9x8UjAfDzYzJHXHj9w0ACFWReb+KuR+JUTpKcN
    4Qe2xFco3HbAgKLPgjInZabJkhgh/1McqB17IID0UrIxXF07b0eLu9ce4r76U2aZrp9Zya
    VCltEYWSjxhp/k1HSrmmvdnXKwJ0GH8LePN1BkhLN4jfPmjgbs3hz6qVEbB8VfsDYIiSFe
    y7RHzM5cg0x8DhwhkhCJ8g6dUtoI073ouJCSw/fkvNEAcKSh0CJ1iH/ifM4kgJGAUWmXBb
    YqDlSoUfacZVO+oEcBw1IWefwk/7ChILVljeTcIO8+ucrl2PS8jI6zG9voIh48axyUtpI2
    KRvpXlB7qSonU/6cWUjaUcq905hGjZAm7hgjRA/wNnNOOq4jOii3Cb7SLzuasdmyt5/LuN
    +b24E5PCNFT+1gN2eqwni6l+bVRcwywNTpK+wzDKY9MVkw6heIgwJvX73F7w/eILA5nIXs
    qKCQ1t+s1AjygPyCVc3/CcWceZPozbjSwKZC6dgOLoxZWCwrA5bZQlUpPbglm29GmV9U76
    MLeGnVt2K97cqCvKULza9fRPUZ2iUEmHd+R/F+9MKgUFFm1ZE70O+MA/YpBw
X-ME-Proxy: <xmx:ZlKPakqp7LeYys-qciILyFhcjZDRwE_aiEp1dWgQmkCdbAW8lNOLBw>
    <xmx:ZlKPajHr13SncsHCamTeT49AulE7Q5m-BlVGY3E2dqbvkG5-_mI9qA>
    <xmx:ZlKPapqZVvDf6km48FQ_qWBz97sdI8feJY_VGH9aN22JyIwb7bUMZA>
    <xmx:ZlKPasaRTa_4fWNu2KxjHsoisoZlZ7J6T9T3YJFEDbdw9FliXjVBOg>
    <xmx:Z1KPapzav-5vb1OPT8AgvLDzoSs8bPng2bKlRpKqRWmf5ayZY90lj_Zy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 16:53:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: Colin Stagner <ask+git@howdoi.land>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite [and 1 more messages]
In-Reply-To: <xmqq33xo729i.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	12 Jul 2026 06:42:33 -0700")
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
	<20260706115816.20267-3-ijackson@chiark.greenend.org.uk>
	<9ef8cfcc-ab47-479b-9f23-71ba99e1e56b@howdoi.land>
	<20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
	<f557bfcf-ffd2-4903-8015-97fff97dbe09@howdoi.land>
	<27215.27575.968985.583226@chiark.greenend.org.uk>
	<xmqqmrvx86wi.fsf@gitster.g>
	<a8c72dcd-f8d7-47ce-a4b2-ebcd4188875e@howdoi.land>
	<27219.20156.438730.881821@chiark.greenend.org.uk>
	<xmqq33xo729i.fsf@gitster.g>
Date: Wed, 26 Aug 2026 13:53:57 -0700
Message-ID: <xmqqcxv4eh7e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Ian Jackson <ijackson@chiark.greenend.org.uk> writes:
>
>> Colin Stagner writes ("Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust rewrite [and 1 more messages]"):
>>> On 7/11/26 18:04, Junio C Hamano wrote:
>>> > So, is there a conclusion after reviewing this?
>>> 
>>> I think we're expecting a reroll, but this looks like the way forward.
>>
>> Yes.  Please bear with me, I'm travelling for a few days.
>>
>> Ian.
>
> No worries, and take your time.  I was just updating the status of
> the various topics in the "What's cooking" draft.

Any change of plans or situation since then?

Thanks.
