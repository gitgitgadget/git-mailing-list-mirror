Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2211EDA2A
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104355; cv=none; b=KLADTfuqLQQI7UaHZltYSF4guBL8wRWTWvySD3clTsoZmt7YOVoK12WAVVGdDYRP1vkTAfSF/njEctORCbRKihwO6UtThAhyz5aqJ4swPgLmJAYp9pHZ/+8eKOzKagdqF/QzqzcuEGTBG7phDp5v0+t/v9uX87HxqE1a3gnlzu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104355; c=relaxed/simple;
	bh=qV/PDHwXqll3P7OSjTai3UHOp+YQh5ztT4/19ptm3gA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uA6zCFLQWXyTSz2YoYSLfzshVU68fVa/WXBZ86nD31NtWKrDBGxr8gtO1RjhcirYLl4DHFjWxLxiJta1QacA4q1iex6jWgWGjuF5bHnXwP/WKaj9ERXZM64neM5wteytxT14tcm+XnbfEXIjLtjz3NglTQ2OcfC6YDCYdHzeI6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=lnM+++6r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8XBYDPF; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="lnM+++6r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O8XBYDPF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 55FE0EC0198;
	Wed, 13 Aug 2025 12:59:12 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Wed, 13 Aug 2025 12:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755104352;
	 x=1755190752; bh=NgU3xwY0AVIexXbf3BZFrfoKpsQVot78lWt1vv0kpss=; b=
	lnM+++6rpzMqE3VVGWMANhOjGm2x4Q6CsT+quhZv+cGF1UkdaqjjlXiHS7fn1LCp
	A08GMc1VlKc9wAx/rvdWwE9pmWmUN9va8Y2WNW06gJRGvThqzD3/mx0oMeobHofM
	Wz68oVYLCY4JZqSS9249aLJu7OuutPfULsf9LE3QXskAfApggtAFdOUXh/DhJ+Hy
	9b/Ve8t9R9o7ePNvQETU+wqc5XjkirPM8rK2tB/rG/M+dTRHyjwqVo0nNYqVOpvB
	vze2WiDEz7FZoSsPZNCwbrSY13VnMgtL++O71/oWLFWBhpbEwVAxoA/pM2Biemjg
	ZLdVRPGwJHAw5KJfOveKZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755104352; x=
	1755190752; bh=NgU3xwY0AVIexXbf3BZFrfoKpsQVot78lWt1vv0kpss=; b=O
	8XBYDPFFiU7fka1m4t6m4K9PTfn/Ke60hyGDvLdzJHel27nMzYhKbHhNlTpRyl6i
	mf8ctXzs+fvYRVvLDcj71/XiIHvKddifsIhQudMZyVJuxSvMRR5KaSgvnRowoWkt
	19J68K9Q6TkbWmsBgY2mXSsM+lTCmXnl3uGZZ6kOWlrNzT6oCXkcpWAjwZWB8Pc6
	/xmlN0s4vE/0fwb8Fr7hnULrvXpMMEQ0eHDcP92YgDpqgtlZfvtjLUCMgRWUxRrj
	5NBsvwKvMzYSyHnppzjHLAMsRzTn0nNgvhlJQARUOlraUTV8zEIW/AYr9r3Jitan
	iU2hyLOPUjSNcQlC4isnA==
X-ME-Sender: <xms:YMScaEZ8FHyow6sE2NzJ_QXea1ThvEPAOFjfg3xHg8jd4CD5i1yxFQ>
    <xme:YMScaPbp3cjfPbAG4iobKKzIviNJ2haigWm73UizLnd64DAb2_NgcZgMhde2hbF70
    uwkRKSPpNYOjUhRTuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhn
    shdrtggrqeenucggtffrrghtthgvrhhnpefgveekudeviedvveeuhefhvdetgefgffdufe
    eguddtkeegtdeltdevhfdtuddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggrpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YMScaNjUqfoA3YFhEjE-XD2gQIEDzFHzKeQlTKthRpwYuJCafMknqw>
    <xmx:YMScaI4rC0GpUrg1YcqquFHu50OVGpOCdrhvpgjAYO1bCTgQRXW6AA>
    <xmx:YMScaKCgXBAevlq6EYpTQ5GKG-J-Up0KwqPysBD8EbWtWGLLOk6nKQ>
    <xmx:YMScaPYtE3HGiB7cw6D1E2h5syfN1uzUjUN2LoYhQQsJnGUDRRFQ6A>
    <xmx:YMScaAitDfaTx0G55KfkH1krp0fq4YQ5jus9gdrstO0jMf5mymUyNYN3>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 169F17840B0; Wed, 13 Aug 2025 12:59:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T053d32575eef8f0a
Date: Wed, 13 Aug 2025 12:58:50 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <d027b0cc-a2b0-4b73-b7e0-410fc559fd51@app.fastmail.com>
In-Reply-To: <xmqqms84s276.fsf@gitster.g>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <3a2cc38b72fb0f6ccc0ec9cbefadb7576cd8b934.1755029249.git.gitgitgadget@gmail.com>
 <xmqqms84s276.fsf@gitster.g>
Subject: Re: [PATCH 1/5] doc: git-add: remove options from SYNOPSIS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks for the comments. I think for now I'll just remove this patch
from the series since I don't see a clear way forward and I think it'll
make it easier to focus on the other changes.

> Note that in general this is not necessarily a good idea, when a
> command works in different modes (like "git branch" that can
> list/enumerate or create/delete/manipulate), as not all the options
> can be used in all the modes the command supports.  

I've been thinking about that as well: I have some ideas I've been working on
for how to clarify the usage of different "modes" of a command by giving the
modes names, will share those when I get to a command with modes.

> Except that you have to scan a lot of text, which is quite
> inefficient when you *know* the general idea behind the option you
> want to use, and are only looking for the exact spelling of it (e.g.
> "was it spelled --ignore-removed?")

That's fair. Something that I hadn't considered is that how easy the OPTIONS
section is to scan depends on how the man page is formatted: some man
page viewers will bold the options (which I think makes them easier to scan),
but some won't.

> While it is important to make it easier for new readers to learn, we
> should also keep in mind that nobody remains to be a newbie forever.
> Have you considered folding lines and
> simplifying "[--long | -s]" into "[-s]" and see if it makes easier
> to follow?  Documentation/git-commit.adoc may serve as a better
> model.

Hmm, here's what it looks like with the long options removed.
To me it doesn't feel like a big enough improvement, and it's harder
to tell what some of the short options (like `-n`) mean.

git add [-p] [-v] [-n] [-f] [-i] [-e] [-A | --no-all | -u]
	[--sparse] [--intent-to-add | -N] [--refresh] [--ignore-errors]
	[--ignore-missing] [--renormalize] [--chmod=(+|-)x]
	[--pathspec-from-file=<file> [--pathspec-file-nul]]
	[--] [<pathspec>...]
