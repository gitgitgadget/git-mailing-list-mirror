Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC02DF128
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785620436; cv=none; b=puW/u94q6Or6szlGNo0jLcC5MJlVu/GO9GW4qizKI8YVS7p9B4YYW3F+cZqZN+hcpUTzsEXs31JwKehCh6NoX76WW3RqtsSwCGvpGSz9vG6OGoKxurKmmPjnECVtRvYz8M30YKxlxsY1YbA4JR9rF5ccfVN2B3ckFxovTgCX9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785620436; c=relaxed/simple;
	bh=jTBDUX9xdghOLER0+tvv0LYokLWiTahMyJWYHpqP4o8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gKsCavGKR4iz6j3TXd0XHBoonSqPpjRJArPa0dLcFwrXmC8Fwshwpg5FQ+R+d5SxKyt1WTFUnPRYbITCU6moE36UWcKS0EMUFOUFrIcVkqtgPHo4vl3+XJb7oItVMXBFIFKXry7ib2q9+0z56kx7LKQ1am3lTT3kIbLE9ZyQ454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O1xYg03F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dusXypD8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O1xYg03F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dusXypD8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 309A0EC0230;
	Sat,  1 Aug 2026 17:40:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 01 Aug 2026 17:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785620433; x=1785706833; bh=K768qyNLAD
	duBj6JWrio/3cZf2/9k2WVFHoNgHWjfkg=; b=O1xYg03FJPQuMNRR+V9+hNEaVF
	bgIkRh7QmiXkhV6YkC5Pl9omFNjhaR+s6sz26ckQgRWRrIsrd8+/xIIId+BEivZP
	MuxHOo3Vx3m1bZweRoNG590xaIdVHG6wukvu/dZKTKZkqD+n2foipkcv5Al4hlSW
	erFTl02oqogI7RUHznmUxgEP4KgagZ0btlgh2n/JKbgD6J7oE5AU1rHVJZ5krTTN
	ngHPb8maIS/dTisMLur21euzXXVvmFb7P2tsNgS9/0JEgzxAxnl7ikIntXEMtxWo
	EGotF2LzgKLfKJrshjTJIqANbiTh6FG4b4SwQmzEumaArhESgUbXJr1LkGIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785620433; x=1785706833; bh=K768qyNLADduBj6JWrio/3cZf2/9k2WVFHo
	NgHWjfkg=; b=dusXypD8xd3qJYzlIockqsd9tjGiPvNqheX7Hu72B7fdSeSdeas
	4uwXqJHMVrAUvgzhNhxpssgf1+oUjmhYNIhMB5b+2IpG4QY0ISv26C1aQ2GKXirq
	4m9dnsd1OIaxPFqNf2tZKiAmaJk0T6S0DXK2zQzcvv8r5vWJ52m4BIowAETxg16k
	588OKfshfZtuM/nGnD+NSahZKyiC6IKhkXyTR3VD02Mwqb1N9WmRalrxoxZFhCG0
	ZUPTjlvj3YoTj5lSVDr66sHMICfP83IbQZU3DCLR6RFKlR2Hhj7ALXFDJ01U+eUS
	iy5l17gsYQv6kUwKGdAriFEJk1FIF1oad9A==
X-ME-Sender: <xms:0Wduarm3RMqjEx-7zm-aNNUx3xZtuRwxGs0LSuB2nrInC9IC15HtwQ>
    <xme:0WdualtWC8QzhRZzeqDw8k9wpBYwpWOqIRatAnrlkPWG4RFk9A3ZrLwMqLyF2rViS
    ISakBBekNvs6TQD-1y03bMe2IOosWkM_iBNGbB1ep8GFti_Y-R-Gw>
X-ME-Received: <xmr:0Wduap8ZYNHMvdzklmonfpaEyCqepyK89VONDHvdbJyuKKflxYCoLzVTsRTGGejJQs6tSKIBfHOmB4F401rka0Q1RLnsjD0CJw>
X-ME-Proxy-Cause: dmFkZTEiGVHNlk9la1fv7u7Hu5D9HTroUZcY5JSo5/28eAQEbdWnmq2/elgbbMoexEOAMp
    8n88LGjhLCflEG0XfARLy4wRROzAVLd8IIBkXQvNBCizjAnm05eyL3a9YP1Vx6QMnMFThY
    SVk/tvpLp5P60R94gG/UsqPSH7n7m7PRBK0Y7JTgitioyYXvOjkp3DX9CgkulJg+JK8rcb
    3RY4mDSyr1UUlRtUBWrYo20V6IoPzT0FC5Zu6Y52G2ZMIgMj3T8v8jEtVLbag+NAyVnY0u
    mG1i4HF8G8XPlyyG6g8Dxpk/0LITl0evpHQgIZdB7Of0ty8fYwQlrL4VD1OFETYhfpU2Pv
    CS0VdrF1aQCp/euVD1DPf6yw08vrY2RVwxOXD4WU6W0kHyK5w+cR9CuvukftctsMEs5ts+
    wtwlDk3S4yIASIVxCYCarfGPdnEJdA+Arrze/uHM1GkJ4AImKdEvNRyVb49gvRltOsiLKQ
    mQviw4SKfw3cp1x/N6sGXHrrOWh0kl9OW/nS+0cgbktOlRDcFM3Xv80kTDnH5E8FkzGQsz
    8PHPVGnE1wJ1hbV8xAZMUGHP2bci9uDY5ouf0AsCXEF5z5OgxvK5hCV/97jAi3f61KqcFi
    WYO9p0KGHtA6yejCvb2EsRTlxjNEAXd+/r/Adul75JVOOuV2LV4NcFgQK18A
X-ME-Proxy: <xmx:0WduavPsJIP4JKa6OnIVin5-DHeOdn7ucWynpWFkDfeQH98VTnj50Q>
    <xmx:0WduanHytGLMz1E-iYfKWMjrYzYY8YlD3ovUNrzuSpZaPUCmbqn15w>
    <xmx:0WduatQZBRtbtG88inDEibM6CB1PvZ0ugdqu6_rgpkzxWASedJrt7w>
    <xmx:0Wduaku_CRT0gTTMA6BRCxCyVIL0RRKPGR6dDU0iXHmH8rcUk-4R-A>
    <xmx:0Wduaq_E229WxdGbF3mpRrWNo0597uBtmtoZFJg7mZIA_kIuPEaYQXVt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 17:40:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 2/2] bisect: add --reset-when-found to leave when done
In-Reply-To: <xmqqwlu97h1k.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	01 Aug 2026 12:54:31 -0700")
References: <pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
	<pull.2335.v4.git.git.1785577445.gitgitgadget@gmail.com>
	<f5f370df1bab91872e32398386935d71d48a831b.1785577445.git.gitgitgadget@gmail.com>
	<xmqqwlu97h1k.fsf@gitster.g>
Date: Sat, 01 Aug 2026 14:40:31 -0700
Message-ID: <xmqqo6fl7c4w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> The defer_reset arrangement looks somewhat ugly even though what it
> achieves may be a worthy thing to do.  Is the only code path that
> passes defer_reset==true down the call chain the bisect_run()
> codepath, to give that single caller a chance to close files that
> bisect_reset() would remove by calling bisect_clean_state()?
>
> I am wondering if the result of solving it slightly differently may
> give us cleaner and easier to follow code, namely, we stop calling
> bisect_clean_state() from bisect_reset().  Of course you would need
> to find different place to call bisect_clean_state() to compensate,
> if we go that route, but how many code paths do we have that depends
> on bisect_reset() calling biesct_clean_state()?

Conceptually, what you want out of this new feature is:

    Please run "git bisect <anything>" normally.  Make sure you
    notice when the command completed and found the culprit, And
    when you notice it, run "git bisect reset" (or "git bisect reset
    <oid-of-bad-commit>").

Stepping back even further, shouldn't this be doable *a* *lot*
simpler, given that existing code does not locally exit(0)?
Wouldn't it be the matter of

 - Add --reset-when-finished option parsing to the main command and
   the subcommands that want to parse it.

 - Make sure all indivudual cmd_bisect__<subcommand> returns the
   result code, instead of calling exit(), and the result code
   includes those INTERNAL ones.

 - Tweak bisect_next_all() to report the found commit when it
   returns BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND.  Perhaps
   bisect_next() can leave it in a file-scope static variable.

 - Instead of doing

	return is_bisect_success(res) ? 0 : -res;

   at the end of cmd_bisect(), if "--reset-when-finished" is in
   effect, also react to BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND and
   use the commit bisect_next() received from bisect_next_all() as
   needed and do what bisect_reset() does.  Presumably at that
   point, files that are problematic on Windows would all already
   been closed, right?

That way, almost all the changes needed to cmd_bisect__<subcommand>
and below will be pure clean-up changes.  

Hmm?
