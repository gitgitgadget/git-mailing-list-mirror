Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DED3655F9
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349079; cv=none; b=pzWqS6CNHNfGONRsEjVlw6awIH9u4gVXw1gcV0VmiC88mGmC0qwhyIVq9OPbBHm+50N+deZC/vziZDAVRKIjCwq38m80Gmgi77AIERg5oJgW4NgWUPBFXui22XXspVr/1AxEw0QBNd+RugI6wUh+99UNJTABFHBqnn6xegShCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349079; c=relaxed/simple;
	bh=x94SV9z/lwfZot85u2SgvUdhunpUWRIRDu/PDiXxXvg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cf8VEnTcjCR5Pn3N0TqfGqOrDEE/K8gjxRRw074MCTBA9rYJjIrfj0TPdje9RDM56MU5TbPEXV06qCbacifPZcDSfRrqzkuz1rGUZ2TCOLaV0mzUVbatxE/1cvLTn4k2K8+JFpOyGDi/B42GrZxXsSdf6Ybzt6KKKwXvRVLHkEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=rcalyW8R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHbvZR2D; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="rcalyW8R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHbvZR2D"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 77C1C1D000AA;
	Mon,  1 Jun 2026 17:24:37 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 17:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780349077;
	 x=1780435477; bh=x94SV9z/lwfZot85u2SgvUdhunpUWRIRDu/PDiXxXvg=; b=
	rcalyW8RVtVgJsQNPMFELByQTuGi2JAs2BbKMze8uVgvWmZeKk0z+yBmFQCq3n6S
	hGUrEsVUnm2QCBn5EGtAf7IyJ3w4RGU580qTqGN/b5g4xlcLyC9JX1ThxNKefDqo
	ilECG+Ob9+6vWodMLnIo9TlNPypsFRauOOfyB6FSTh9tUwrDHIOZjYHy6XKfHdID
	Lq4iDN6/XuIhZXN1q9nLavCZA+gRNEfSEWBYyje2GqUUpwa8ApBKBRGWNFOQCZMV
	SqRJMjIxn05HrQE7b7IBWwF9cEBNjjyaRJhKgYnfQ/27i68ecdzrcDDAEgKE0ILM
	PRx5vBgCK6/zNUCeapUfqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780349077; x=
	1780435477; bh=x94SV9z/lwfZot85u2SgvUdhunpUWRIRDu/PDiXxXvg=; b=C
	HbvZR2DGlJYhZ6xs47PevGT43RtLk2pW0Qf2HT5v4ZDkmr0QteFHwv0nLoS84Gmw
	heQO2CgHqn7FEN2FZBDfX6u1do6BT3HKWzOU/oWF0N4R00kd3wAlt4zwPsAgFHq3
	Pko6kZLDpQVwp1dIjsbuSoLubIK3TJOQdK6RTGTpAYPVwsLCz1PYt8B3MBIXlq9K
	GuK7f4pCK8fJpV5rOn8VhjItt+2ZyngvnVOgfpp/uDhb18ohr65LqRL1oozoR9IL
	TF2KrXQT1gKdeIZphY0y0XTbmPNUtl4K6mfYh6his7xECihTFFhkoLRJlstlPfrU
	K9BBdBotKjD5GXcR/5CIA==
X-ME-Sender: <xms:lPgdajP-J01TVPsJispqxlMORf-5O2UAKbDURVLZJDqeI9EAz247UkY>
    <xme:lPgdaozh-zTlUsAyQP1wphRCVTqDh79NpPAr-gR4mCJEOZK_kCx05SIjsdjWXwpAN
    dyIAuHabFH189JliROwKnriuOGX6VRC1BPguy93yhpDi15LzIPL>
X-ME-Proxy-Cause: dmFkZTFElMlmDgn0y0kygmSybScsjByZbdsF8XaZ5MxcEsV9WKrwwXBajF/MOmXyUPbFU5
    /cxH9q9XmXBYzc4tJh2c7wPCrNBxlBAXyEfNXahe0+LdV15ZVulaLT2TQF+wlT0cWRdGWm
    UVPf1PbP2u8VSRsbdvYzct8NmWYgOAdWxMno226nCrbbDvRAErgFwTwgUHGB5CKtJlqIrW
    j2FSMmgdcWrNA4JZHxDGEtQatB4g55x6k1tFN0LLTFNuaI1y4luKc20x+sti+vsewJ3L9u
    mFR3GBA+4g7Gw6T991AlIvYyTSr7cuK/L/8g/rm0qI1zLTnuBjxn2qJrNMdpKCsZysqLi5
    y+0VliCNldMtEqyjz9m6XeiEs9gNm3tsdzYto0iVOAB1MYgYd9B0VRok77PWNqkQgimqXT
    M2w1waGH5fCJEzGQeMPWCBObvZJzUaSnKnQwfta1m26MDkEEgVaYmUxPakc9VCDMlg+jst
    mRBBgIAp2GqMx1BoGe1NUfUuJbtqCPRHjbLx+yriJ6h/MlxgwZjl96NmPLgEY7Ebc103jp
    JQICm8ScEvx+BI8DeGNUTcRwKSGT/KOkAS0iLhAsr3tG/aMSZr13EBbzqgYi+9CQsyH8xx
    uDis3CWJkcNIukZPOFzZsvDj7YY64AXKacAfWLzRbTrkvVusbpguz0IfIJGg
X-ME-Proxy: <xmx:lPgdamwbK3ZQ0XLWw3dGfWyuKVhpJQvCGInZbuFCZ-kpCX2LBBoDZg>
    <xmx:lPgdaiY2HwV2lKRrgi_L2Fuls-xjL5Q7H31ko0qpVAnaYQWSYOoSCg>
    <xmx:lPgdagQ8y4WXXWUVYsmU8yodPlC0vwNG9xe0l9wzj_dcDNhWPfnDUg>
    <xmx:lPgdakzmUr73FxDn38Z792dr4yGyt4LdYY5gdnMBt8_EF8F7_ZQc-w>
    <xmx:lfgdalWQ4MlUgn2_uxobIY2KIX3K7k-vj1gzsh6pcQjPHph9GcEwSXPF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6746F3020086; Mon,  1 Jun 2026 17:24:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AjWID8gagZ8N
Date: Mon, 01 Jun 2026 23:23:44 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org
Message-Id: <2e266786-4ccd-4300-9b53-6f13fbaa2933@app.fastmail.com>
In-Reply-To: <ah2VL-ftCQelNoOc@pks.im>
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
 <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
 <276a92ac-b2cb-4a89-96d0-9071ab6200be@app.fastmail.com>
 <ah12uk7IFxS92OR1@pks.im> <042e66b5-122b-4c86-a9a9-f75f763666a7@gmail.com>
 <ah2VL-ftCQelNoOc@pks.im>
Subject: Re: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

By the way I tried to find user mentions of git-init-db(1) on the
mailing list. (First git then I tried *all* but the results did not seem
dissimilar at all.) All I found was from last year[1] but the command
was used as a bug reproducer, which hints at some finger memory.

=F0=9F=94=97 1: https://lore.kernel.org/git/d8c1df4e-a4d7-4c4c-be44-b13d=
e3d9ffea@markus-raab.org/

On Mon, Jun 1, 2026, at 16:20, Patrick Steinhardt wrote:
> On Mon, Jun 01, 2026 at 02:48:05PM +0100, Phillip Wood wrote:
>>[snip
>>
>> Deprecating this command seems very sensible to me. As well as markin=
g it
>> deprecated, do we want to print a warning when it is run? I imagine a=
nyone
>> who has this command in their muscle memory is unlikely to be reading=
 the
>> man page on a regular basis so wont see the warning there.
>
> I was wondering whether we want to call `you_still_use_that()` here.

As-is that will arguably promote the *breaking change* to right now
since it=E2=80=99s a `die(...)` function. That could be changed to be wa=
rn/die
modular of course.

But a simple warning message can just tell them to use git-init(1).

> I found it to be a bit heavy-handed as it's so trivial to replace with
> git-init(1), but on the other hand it's a trivial thing to do.

I imagine that most potential git-init-db(1) uses will be buried in some
scripts that haven=E2=80=99t been touched in years. Then the Git init mi=
ght
fail, you get errors about git-commit(1) or something not being a thing
you can run without a repository, and it ends up being a headscratcher
since the original failure gets lost.

All to say I think a simple warning would be nice. ;)
