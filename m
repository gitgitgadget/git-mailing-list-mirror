Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2FA3009D6
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771943; cv=none; b=WHQZlz0mmarPwYpqzks8f/Pl9vFLAYNz/tch9l3W/TkpS+2Gz53HBN//S8mYo0y5NAQxVxagZqAJTGlNHUZ84dXzKIlPWeUG22BE8JYpPZNUe2ZKTurC6l3MIa29p+f8yqgAEEmEeQpgbybr1aoxDq2uXK3pnK4R1WmyIQ+nLOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771943; c=relaxed/simple;
	bh=i0GuTPCfr10ZGtGItPks+L2HJGqRdcbji4I9mSXyldY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LTucX2yPDN74GA92UtEcYagG6yxWweIa8c+BbG3sDvsQct6/406mkHAH3XDeGE3ZgbzOAmTErR/ZNjtxFIwqQiuwNc9xGsGA9ZJ0IuTXF9i6pcaFiSnWovuRzd4eKLZ2ULm73DAmVr2p//1Tj569u73eXZ1iRE8DttAdKloLlyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c3ioGCn9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TO69WlOV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c3ioGCn9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TO69WlOV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EDE631D00115;
	Mon,  3 Aug 2026 11:45:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 03 Aug 2026 11:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785771940;
	 x=1785858340; bh=BF7iAWgxJGcriW5TxiQUfj6cANrTwZmAXPDvH6oa1WI=; b=
	c3ioGCn9LT9kCAaRGSjFKsQYbQ0O0AUGoZRrTtBl/vUnwQBZwyUZ7KzpbrHIR556
	oYvyUsaeqr9hu0rXqrPV4Y5UQG+EY7kS9f/hkehWO169sTARXTZFWAKRxUiCEGOb
	CuE6YODu5+oPwverOKBBtgcb+ThM80Rc6odr9bBO3/QPJT9o2Os6H8UiSrvjrzgH
	PA/WzUTfMLy8juOCp3clHGdieWLOTmbVCVOg9oL83Rmz9irw8tkb99qoOW9r62PL
	PS1zmCO7e54FOPsVJ3AnCZO4PAFsL5UocvKXLA+hv47nk4QOFF23F9PB6IbXfM4h
	59Otb+Is8YZfTS5vcSnzHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785771940; x=
	1785858340; bh=BF7iAWgxJGcriW5TxiQUfj6cANrTwZmAXPDvH6oa1WI=; b=T
	O69WlOVXaRf5WqzUQqVOX8IP30da6yzVqCN3pxqXcMPLa9bndQzy+cs6LCWX6dZB
	AQPjlKpull6Hqpe4gjwx8G64tAcjFh1NslsYaYzTgrkacRNpzdUv4ELWIWh/J77Y
	MaN2FU1Ah6SBuEITMdURCpGMrNwBXXOMHeSXNBMD7ljSgjEuasvGM9++Z1/5zvgf
	AGKCDBYP98g/W93Iuo0kh78hTXxuiXSyT/4wJAQu6os/7CM4jmY81yuLedKjDLiB
	Hdg2SAyQoNNQXWv/Ox8+653qPFY+cjCLWLA6Xz6QznxKi3pHnswTOg1gN1dVcZXi
	ErSMBVUfWojk6qqFJ2dbQ==
X-ME-Sender: <xms:pLdwatO5t_ihF9jnh-qM4UPgyT-UIH-0R0ndHwVWrJoyfKeK5uFNyw>
    <xme:pLdwavCrGs4NZcxTPza_SWtIJFlxs_6LfIP-G-r9U6jI-3UXnI58IWF4C96u05VUD
    MBkfWXguw9-bJSlZGq0q3K3tWu5vz06VvRaYzOclFKMroVUrjQ8>
X-ME-Received: <xmr:pLdwaieToeza4LcLe6vxRK5D7N9I3rEgfmGIvnKlt1Sob48-frbjTkw_IywqiSIOpZuGUcfTEf4vcRx0kai1qOdVbQZ7Dd4-rw>
X-ME-Proxy-Cause: dmFkZTGHUhKOhPc3pDudwFtGYucpeFjbrXLz3xBn5IZVvjWTxpt7atNoMkemhydzqXBA1F
    xjlSyS2Y3PdLKQP7ZhYWbLRHlUYhCMmH4sEThCyAGrHGN02oWnnA9PVWhxOorDOpvwpnzR
    /kpUfsGI7PcFj0NaBiO3Bl+aB1sqNYnmcj1WbD32Ns5Uu2m64yCipsFfqEP2Eczgl9neCu
    9DF+kxOL0ZL4AcP4Ag1MyOavkBIrpHgNmlkovIAvbXqPfe12ukAiB1KcmrTCQHwFaEmUCo
    WitiN3mFf3sh6s4PVslsItiCwwQPWUOT+jdajP1kw5c8qOl/8liQtYyavoRPDJcr63aksN
    xYxDLq/dorjNPxlRClqaMk6X9zve9KU8A50ftVBdtJjWLrP7xTJ74LxiKD6t7F9SJOFGha
    VdLrETbGx+bePVsS2ukvBSkJtIcq9n3pvWB9xZeTvjKs/NyStN723pVYa1rEmp9z1G1G3Q
    x7hM+QbnxhK9lMr7qmndN1sbCwOJiW/mJZAIPPOU3FIDze20pNYiJiHhTknS95uXcr+3tC
    owiTPw0iux3I2indQg9ebDcSMRYoAHkjIdeeBY8C6ELeMLKxMhHO8Q2tXqOWguFO8BwVZ0
    VBw2nebWgBdWdB2JJ5agN/3GJVp5QYJH106xfstrjVz9entn7teW/uct+ZCg
X-ME-Proxy: <xmx:pLdwamPP3dm9MqVQDjnOgAJMkMWiXDtZIodgCv_SdhtqBp4674Jchg>
    <xmx:pLdwaqLNRj2yvqhQtEJfyzOQCICQfpGi1zcgMobGCMu-OcV09aA9jQ>
    <xmx:pLdwauIX9aEwVp0Ev1AJX_2Oa40KWatorJ7mjXSNFNn6thtyj0gNnQ>
    <xmx:pLdwas6H66uWSq-5q5kph3--4AZN8kOyo3LXvbuuSz1Gcj7hV-EC1Q>
    <xmx:pLdwasv738sKsdCVDR0agYADf6UQIwExbEyQ99IDA56XQXhQWl5MwOEg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 11:45:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>,
  Britton Leo Kerin <britton.kerin@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH] completion: complete tracked paths for 'git diff'
In-Reply-To: <xmqq33wv1fts.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	03 Aug 2026 06:41:51 -0700")
References: <xmqqcxw010me.fsf@gitster.g> <anAqfqcEueSKmAH+@szeder.dev>
	<xmqq33wv1fts.fsf@gitster.g>
Date: Mon, 03 Aug 2026 08:45:39 -0700
Message-ID: <xmqqpkzzyzq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>> I think we should check whether the '--no-index' option is present on
>> the command line, and simply not call __git_complete_index_file() if
>> it is, to let Bash list all paths; i.e. each of those calls should be
>> protected by an additional 'if test -z "$(__git_find_on_cmdline
>> "--no-index")' condition, perhaps.
>
>
> Ah, I did not think of the "we made 'git diff' work without Git"
> mode at all.
>
> But I would avoid scanning the command line for '--no-index' for two
> reasons:
>
>  (1) "git diff -S --no-index maint master" would not give you the
>      '--no-index' mode.
>
>  (2) When run outside the working tree of a repository, you do not
>      have to say '--no-index'.
>
> These make detecting the "'git diff' but not Git" mode tedious and
> error-prone.
>
> I have not tried this, but if we arranged the code to fall back
> further to Bash-native "paths in $PWD" after the completion code in
> the posted patch found nothing, would it be sufficient?

Eh, isn't the code already arranged to do so?  With the posted
completion script loaded, I do

	$ cd $HOME
	$ git diff [--no-index] w/git.git/C<TAB>

where (1) my $HOME is not under version control (dotfiles are
installed after getting built from their sources that are version
controlled elsewhere), and (2) ~/w/git.git/ is the primary working
tree I work in.  I see

	Cargo.toml  CODE_OF_CONDUCT.md  COPYING

offered as choices.  As there is no index or rev when I am in my
$HOME directory, naturally the only completion that kicks in is the
bash native "paths we see".

So I think I do not need anything special to "arrange" the fallback.

Thanks.


