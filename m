Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A50D2D3759
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021823; cv=none; b=uUGwHqijmu7QdAjrisaLWSNsCJ84I0pWPiLLRXrL6ZnkNjG/f0L9RujfJH1zOjupF+Obv2bYCe7eQxTtdxUdS0bsb6sKdSqs1RZhbQwiPyPMVvIWoLoY65VKTACI0usDs4bEKiuR+WtwKv0bVfD6OZRRO540gGx7UHQ7TrDM1Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021823; c=relaxed/simple;
	bh=Y8LYtHARKsBAFBhBzsSTefr5rVe+geN1Srq0frXF8Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SN62qkGtGbhQyJ7+ZSeWxJP85FFqVN9IXv7hFqKR2ie0LqxWrLz9i2lyLZXzD6uGd6acbmLNLR3jq7BTqJCk2WpP2xZEo4pi2LQeONlzngKU/i4q4iSQw32LMFiavHF3IPK/w3+ax4Zfc+K/UKByMudCXIIehd4P54lJkafWCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=ZvBzMayA; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="ZvBzMayA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758021810; x=1758626610;
	i=oswald.buddenhagen@gmx.de;
	bh=aWkJt9NzExglEpUSgER/1l0O87oeqTou4XYijuC5IJM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZvBzMayA7XhfcGSYcsZsalbQN7k/C5q/1mvBFBNFIp6FS7wUcPexNGSeXFofLIDW
	 2Uw+9+I+cd+3jwnetwjU8klxZxgLtY/ViTjAW65+qNR8ZVMSupROOjxE5KEPyfGay
	 6XWdGehV+x/eHcYNFVHiGeVUhuzRn/Mzy23xdeWHXIfHUhlQ7BxtI6jxCRQeBMBxw
	 rbDjipzWyIwAtuKOhsC5F4gtNy+ro1ruCLWtGqXBAIFF5lfG9UWV7z3Tip7kaY+f9
	 OrDoML/KL2ZKrgVlncV8tMBnwKub7Mr0akRHZAI4SahC2oncR3kZEivA4Sxmd6uAs
	 1Zy6DrbAw4fSPs8hoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from nubble.lan ([185.149.202.45]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9gE-1vAcr00IGK-00CckR; Tue, 16
 Sep 2025 13:23:30 +0200
Received: by nubble.lan (MasqMail 1.0.0-plus, from userid 1001)
	id 1uyTmT-KHK-00; Tue, 16 Sep 2025 13:23:29 +0200
Date: Tue, 16 Sep 2025 13:23:29 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v3 00/18] Introduce git-history(1) command for easy
 history editing
Message-ID: <aMlIseiqlfslrh9_@nubble.lan>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <CABPp-BHeXtJPq7BE1UZ+zH0C-9VzQcSYRo+t0P-KWth68Zd94Q@mail.gmail.com>
 <aMfdh8NxUj1v89Uu@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aMfdh8NxUj1v89Uu@pks.im>
X-Provags-ID: V03:K1:ZlX5OIADn3LzoG/DG7s44TTrtwf1L+nIJqwGUZ/SC1h5qUqlzQ3
 ipNM2gYj0+4nxDxp0out6lCiqzCtB8djognpbWvhm8v6s+mAybHiIo6noQJorcExYH3nuW/
 Tc3cXN1WyFcjHQKlBvrsdaPl/RF0EDRHaniwGiM0eZzqnLxA6G89vrBhwXVwacBrolgX3Ia
 OD9uM5tzJwJuBPHyN4Gsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d0VPR1u9Rz8=;p62F5Rja3IH3VnRJzG/83DzEzkn
 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

On Mon, Sep 15, 2025 at 11:33:59AM +0200, Patrick Steinhardt wrote:
>On Sat, Sep 06, 2025 at 11:46:48PM -0700, Elijah Newren wrote:
>> So, this brings up a question.  Should we have git-rebase &
>> git-cherry-pick & git-replay & git-history, or should we consolidate?
>> [...]
>
>The main reason why I propose to introduce a top-level command with
>different subcommands is that it helps users discover related
>functionality.
>
i think this is better addressed with proper documentation.

>In the worst case, users can still create an alias for git-split(1).
>
it seems backwards to basically require aliases for efficient use. this
would also lead to a mismatch between what people write into how-tos and
what is actually in use (aliases are individual and therefore
inconsistent, so one needs to use the full form in writing).

>My take in once sentence: git-history(1) modifies a preexisting
>sequence of commits.
>
the details of this definition are arbitrary, and you already noticed
that there are grey areas. we will find more when we start looking for
them.

so, obviously, i'm in favor of atomizing.

>I was also wondering whether "git history" is too broad with that
>definition in mind. At one point in time I though about "git histedit"
>instead, which may be a bit of a better fit?
>
a natural name for this would be "revise", which, not coindicentally at
all, is actually an existing 3rd-party tool with a quite similar scope.
but then, see above.
