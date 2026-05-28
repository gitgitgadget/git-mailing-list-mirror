Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5021BDDC5
	for <git@vger.kernel.org>; Thu, 28 May 2026 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999982; cv=none; b=Mo8kA3L5ac7gB+V/7nF+BHlTBv9+UaN39273Z59JRPXXbchKloTj7wCpAVAZXlTvpKiI17CFQCxQqg2hL9MtNAPdzEXNMgEzBHwFIhjtcAD5hn1plrdG4oDNSN9+1ehZxLmMQv2W0arydU5h0QDI50m30GMjAXVV8+3VSryNgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999982; c=relaxed/simple;
	bh=zralfcTMNCbvnsnrn5hs77Y+FcLZJtpn53zOwDnP9Ns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ld6NDzzvUFHk3gYf0Cb49TaABIM2nmNJgZnEZmp+D8xb/GhL/I1g1RYm8wrEhE1Hq6kD/Wxf5wN5QlwjeDY1m6G6X2btxtPAwGl4ywAvxegcs07aufVExxHfcW51K2e5oHmivmimjnigMJouO/TRApEGRQ/vOvLLYkmhcaGMP4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qhasmCX/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nEqu22H7; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qhasmCX/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nEqu22H7"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ECA7814001C0;
	Thu, 28 May 2026 16:25:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 28 May 2026 16:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779999936;
	 x=1780086336; bh=8aiAlX9DZmO3k+lUGT2IcqIJytQFfp868q66+PU00PQ=; b=
	qhasmCX/x63QT/yT08WIXI+v6+3+gLRqt6u2c+noUW8mV/Lo0epgjV7krpgfGD71
	JFNoaO6FbVVa1Xuh/n39k6g/BHDJodZ2fBSzk1N600EIE9g/l9fEWpYuC8Co+b/U
	ZXyy+feF2L37kYZeLwwf8IdPif9p6v04ukv0CnZ+9qSSIhIe6a7llKlY3oxM103n
	elilp9EDiRWGjHL6s02pYnSeIUrrLx6wGi4rFTd1Cw0Y2ofP6rYn/N20LWh41b/z
	G39Zlth3s/k6JzOaoBfBKua71Gwsww89BWLYpo7tpzLiueSy64+XFcPsteCsiub1
	YMlRjqm1cJZYsezEZFrN7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779999936; x=
	1780086336; bh=8aiAlX9DZmO3k+lUGT2IcqIJytQFfp868q66+PU00PQ=; b=n
	Equ22H7i5Y5AmuICAEp5TTxel1p5JYar2qiJea2oQXcmeRv+TX7tHdsdrf3Q8yTX
	P8TpMBfVrgaaalX/BSVIVTXD5wNIeCk0YGo3CD9nGs9XsRCdy7HJq60CAlub2Bie
	NWfF0qokLjvprF33hfu+/uTLM48iTzAp/L3SWrmYRAQXYXORA+QodvIbat+F89z6
	zKdUyWKm24Uyvn+T5keVkjoyX8/lQQ2SJhHJH9qxwY5QYE3qkSNwYWK20k3gq1S5
	qUgbgiDG84f6oJXTHCzsfk5bqr1tmo62Ui9TgJx4i7X0jQex+fbn58vs/b7ZWLPP
	rEhN+zRrFjXrWHgdASSwA==
X-ME-Sender: <xms:wKQYamaiC0n3ETfdAJu0PcHPkioBim1PCKLm01x9ukxKOn_-W6BgUA>
    <xme:wKQYagSwENN3zh0HfaeK-kSTSnwbN2chbeeuPVdnDcV-c9QJjeTvKxcqKC_5QR7fn
    zIZsRS0OwFJmqG23aGJMLZVdvG8-P92a2Hyu6L4oW4x79w3Yo-wbQ>
X-ME-Received: <xmr:wKQYapQcATuf680cHnDQXOoxhwMrApGObgE4L1CpaC2MdEv3aG-1EBb5Giqb5Cl93q90mU2CoIBYRvWw_YqtHhD1TVskdMad7ltT>
X-ME-Proxy-Cause: dmFkZTEe4BhHqfoO1i9nW/LyYHj11G7LoLX+3s/opANjpG73UMVuZB8hWF6ftLMMH527cu
    t+BGlbr6bVl6cAQytCyCmW1KAKVElBeqJrjC4shFeqPzp8nHP8hM219MmNztNpHUarpnPs
    LmVnVEU/oqqvD3mKyetRSmxggUKMXkX9Ij+3ggphoN0neaMxnSWtlWnDJxqqAb0eLV/Muq
    gHFsB2uyefCPM1VQifR/ZSqrsuSqptREdvXI+2gsxTP6tVsPJnVMtvMa7zb9FhHRYmJsmC
    NeJ6wpvp+EM4YKGLScIEaEEt4Wx8qz9IeeYFpYDVK0+g269XL5WDFatZ9jSoyR5Y85FCTp
    8vAKpZa6sjnZEL0UZbWNsfnAK0GxIKhP3bC+ac9jCy2fa8AsCac/VZDwGbwN+GHMlUuwS3
    dS12SGJrewPRxz4moJJFE1x/rtwLG1xG/Fz7kvelRxw/f+5pXFRxKjcmyTyw4OgsYOOZL7
    AP0BsgjDt3misfzkVCSfdbkfQpq06/zCWgPANETr+sZY+iWXOVRwFdx+SzkRZ8qZuFIbhu
    7hv8cJz+BmjiW8Ff9J/UhR93DZn+vPyyYsUlOybxltAffbhY48dJKH1O0yhko89P4W5jTG
    legB49nHmhpw8ls7+0v/4DDJLCLAGnAvUmh6c2Z4RB5lYdaWoMF4swDzRJkg
X-ME-Proxy: <xmx:wKQYakRNN1XoF3GEuTcisnjZF8nCW1v5zYAYUgDmZvR_1IXXvmcN4Q>
    <xmx:wKQYau66vF8eI2ggnNYlemyzWx_JBtxAQwYh0-bwt4Dp7ly0Tzerww>
    <xmx:wKQYag3FsQ5_5h_fJqtEQ_GgxnanIwx0ZAfmBsMbAVTIKJrSh8d-BA>
    <xmx:wKQYapDc7zycrqM48FO2vyUxvD63tiCHt-q4Wh-Qb-Q7egh3784rXA>
    <xmx:wKQYaptqBSKl0FrX0bGurE8LBxC088R8RB-xXkZTxLQK6xogtgDDoZGd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 16:25:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] t3070: skip ls-files tests with backslash patterns on
 Windows
In-Reply-To: <pull.2128.git.1779958849319.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Thu, 28 May 2026 09:00:48
	+0000")
References: <pull.2128.git.1779958849319.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 29 May 2026 05:25:35 +0900
Message-ID: <xmqqecivjn7k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Kristofer Karlsson <krka@spotify.com>
>
> On Windows (MINGW), backslashes in pathspecs are silently converted to
> forward slashes (directory separators), which changes the glob semantics.
> This causes 36 test failures in t3070-wildmatch when the "via ls-files"
> variants test patterns containing backslash escapes (e.g. '\[ab]',
> '[\-_]', '[A-\\]').
>
> The wildmatch function itself handles these patterns correctly — only the
> ls-files code path fails because pathspec parsing converts the
> backslashes before they reach the glob matcher.
>
> Skip these ls-files tests on platforms where BSLASHPSPEC is not set,
> which is the existing prereq that captures exactly this semantic:
> "backslashes in pathspec are not directory separators."
>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---

Thanks for noticing and addressing this.  I think we fairly recently
started seeing this in GitHub actions CI, which puzzles me since
neither t3070 or wildmatch.[ch] have changed for quite some time.
8a6d158a (doc: document backslash in gitignore patterns, 2025-10-29)
added a few lines to the test about matching with backslash to t3070.

Two questions.

 * Has this been broken on Windows since October, or has something
   external change on Windows recently?  I do not know.  Anybody
   knows?

 * Is this change a workaround that sweeps ugly breakage under the
   rug, or is backslash inherently unusable as an excape character
   when handling paths on Windows (which I am afraid would make
   wildmatch fairly useless there)?

Will queue.  Thanks.
