Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098C5349C1
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190431; cv=none; b=fNXQ6em9uIGWL4zwy/W2KaX5H4nJ3f7I5lAqKuJFAtoAwMw55ppxSHKKX3WTn9kkIIhcInpgl+gs7MGuH17Jr4j0nt3MkC+OhSb4CGmVwq6o8+NON+aVQrHGsHNqhcJ31z67rTChlrO1iTx7Tjz1J7ZIjD3DIuwvGGCJdWwrlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190431; c=relaxed/simple;
	bh=dbLo3zluSHPEU5/VKI/MfzSf8Hn87403RVfyVCVgX64=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RuigqxnOHzNeAgRioLuZBDLZJ4W6B6yCpP/XGIGgiK6cTJNGuLEi80B+PSc+f/iCydAajjJ9XHsJu8QkV7jAmQ6g+7S+A5HB8iv8oyrWrl3fjEVMXbY472rROd0Bpt2qTjZ9YCvTf6RtEv8iI2/qyNDp9nYqiXmGN5la4OV3q9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=amts2NwR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h8mOBhhD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="amts2NwR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h8mOBhhD"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 108E4EC010B;
	Wed, 23 Sep 2026 15:07:06 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 23 Sep 2026 15:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790190426;
	 x=1790276826; bh=dbLo3zluSHPEU5/VKI/MfzSf8Hn87403RVfyVCVgX64=; b=
	amts2NwRiMud3sE7BkqeAnrAQ0Gzk+miWdLv11bEMGdwgM+ULKtBdRkAj/0s0kAk
	mSvYacPNy6Mn7zKFb4Y5dfRuECLGpNgPfcrIpm8sXUrtY9aNRemwT7XwxxwUyrfJ
	NXP20tdwhv8Tg9SxXetXf8JWcoFlvgni29ni7JB5wqNZ+4GFn1uyzz6ZL6TGp+3S
	SKFMqaoXVvB5VC1wrr00DZXusbVluoWF3lk3DuBfd2bK8DSvPP8CzH6RDLzWEYsV
	G3xKeS+7T1KwL0GNYz7LeOnxfVooP8c4MdJEPinH7rF55fwPwUoOShzgT7CEJdZa
	RICdodkJhN4thkknl6wBug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790190426; x=
	1790276826; bh=dbLo3zluSHPEU5/VKI/MfzSf8Hn87403RVfyVCVgX64=; b=h
	8mOBhhD9S0Cauyh6s2WlwRKhOAo2+LKJqM36Yk8umeapMp6JN7lOvu13Ecm8bTdA
	kezRpUY9iVC5k/BRLxlYhPBcY0fd1IblWLTSRhz2PsFi01TUglYxncvSxfYPw9f8
	fRN5yxxF7EGMISbRBe+EGWdPzbJ0ruQ3NjfUFtvlY41lCNP1lI5mcDbzwVU8d2uy
	q/+8nmTSlcS+jcxgJgnWtLrJGdWYjHZG8dIzKuA7NQmGXwOih5B1sw3FRNI7e66n
	wIe9MBTDeNvnA22mwfKXv13potJyR5lgJj7HwOI28vhh9TZxwZXVfmRjz++G1GXT
	uNRY82PBnlrTrwupzqi9A==
X-ME-Sender: <xms:WCO0apRWjQ3_JlMiNUUCcCn7fT5bfGXGwSC6WOTRYgWSN16ChTz_4qs>
    <xme:WCO0atmo9cRFrzSc6a7FCiWcjLIbehe-3n9BF6xq8fv0fTVv6Nzns1vKq7SXvqNW9
    wB-2HG5n5RxmlCwam32WhGlG7Dwj1mEmwT4R6Ul_VES5brpp83RdoA>
X-ME-Proxy-Cause: dmFkZTEO0O8PjrNFp6IdMIl1JjaPHID2Obpip2CNqAxro7td+OJRf//S1i14bQ5OU5DTIH
    C+aSNXAMroSeJ3KftbebYVNsmvTCQUuv7464US28UPTP9l7iQYdtKwLD5AE54c7Hv1uYUn
    aVn/s03sCD1OusptnomWr1eL/sN2AA7oZsV1nYrFOky05OjdGWHSLARp/ksSWSML9GYUKX
    VLq/yyLn6NGmDX7g9Y8tpJLpmSxO9qg9yJr/1gYiYalAnrDTv2nnkvxYi48EpcrseRV7hY
    LTQFvmxZbk/bmJjnbNdtq+32LsuJKjyvWIC0DH+k9LsWltqy4Tbr/f3KZn0Ay80wp2NEga
    EctJYEDoStUBpJFDDtbYcrExoLhVMP6IgdOGuYSCNg40nXPGXSZD82Or9l9uftpN3gJ0KY
    A2JLbSaFwoj2wxkzWzBp1mzNRDKGgK5c9IAngHELodMPj3W3TXK1drcYG1kgkXcr0MwPsm
    6HQ82P2DOfVy45cvH+dKSVAGcXqY+NEgNys0UFzDPFwh3U8PuTiuKOoXzW3Ce+vsYJFKrB
    6GZYMLpcbh3N9FPbBQDeDcklNsV+BhDTunCm9Duwj+xMdt1KRCvO9QaYVIfk6mNbvAz7nF
    DufwhJ8TJs3b5no/01F3uKVOAjwikHXzwnGlVNgSlu8lv9qN1xZssBrHYSiQ
X-ME-Proxy: <xmx:WSO0akuUkCNYLB0DlU6Fx0nIhO4GQh8flrvqkWOmN20yk4gByf535w>
    <xmx:WSO0apMJubFQID8KOwm1UANYy2U3aW8YAgmQ7Y3Ju7mguA75qxN1nQ>
    <xmx:WSO0ai2hSKKXjWJ_EtniGicLTxce4zPGpRqOBljdO_Awcqo9qIzZQg>
    <xmx:WSO0alOPyP9vPw_4lAAJENrUwZ1oHjPNmTK2R20Z1wxoVqqTFeGd2w>
    <xmx:WiO0ahI5UST6C4Dqf0G5w4Jt1cczdV9RUSxGAN7ip4aJqZnjJuMwuM9d>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A72F222C0085; Wed, 23 Sep 2026 15:07:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYSJH7Okn4v-
Date: Wed, 23 Sep 2026 21:06:44 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Thomas Bachem" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Julia Evans" <julia@jvns.ca>
Message-Id: <7532313e-4705-4e2f-b36d-f2329d70ac6a@app.fastmail.com>
In-Reply-To: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
Subject: Re: [PATCH] doc: add more AsciiDoc cross-references
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026, at 21:29, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
>
> Instead of saying "see EXAMPLES below", say "see <<EXAMPLES,EXAMPLES>>
> below" to make the man pages easier to navigate on the web.
>
> The reason for using the more verbose <<EXAMPLES,EXAMPLES>>
> (instead of <<EXAMPLES>>) is that if the header that `<<EXAMPLES>>`
> is referring to is in an included page (for example `REMOTES` in the
> `git-push` man page), then AsciiDoc will think it's a broken link even
> though it isn't. So it's easier to just make all of the links use the
> form with two parts.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>[snip]

Now that I=E2=80=99ve read this commit message, it seems like an obvious=
 idea
in hindsight.
