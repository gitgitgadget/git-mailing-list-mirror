Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E843876A4
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667822; cv=none; b=bMbqzigurxCpvVc0mTZWD5ZVMj2X1CTnO4SuFS2Ns4rWEqOjttVL3jUkNkuOG/AOSd63k/BU0YV5xV/u3R3RnQmHaWpU8APjuE5Bf+zbLBRuqxkbQe21DEk1oRUOGmRNwOQ/oL4qD3TR0fFLpL9cqy/nVOJZU0cWn35t5iQwsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667822; c=relaxed/simple;
	bh=huiOc9v6pfDEp9zqgKBOFYjEGJPLYNFTptqSmcy6eU8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CvimlzYLxJZVcc7vGrIoUWxp/t7ivb9yjvd+N+4zk884UD/GMiQzLIskXt5ukqqziQmh0zn53i03vTTAbUpNyX9BNY4ETWlZFj/Iye0cDKmCmOyO2Lce9wxdT0pBAkPvZ0AFrNDLXoH3hAuviiw8zBpXH2B4Fv+kGCpRDhBqfC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VI2sPjCE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TM58ptO9; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VI2sPjCE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TM58ptO9"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id BD19A1D000BC;
	Tue, 29 Sep 2026 03:43:38 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 29 Sep 2026 03:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790667817;
	 x=1790754217; bh=huiOc9v6pfDEp9zqgKBOFYjEGJPLYNFTptqSmcy6eU8=; b=
	VI2sPjCEiCEcHpG37aHsCwTNDwKlNW9WUq8lH/AJMsbUgCCX5H90x8rs3QADIGA7
	JovPOS04W5TV8an1ipExZmLIMQSzBdkahzO/VzNMXLp7zpi+38jRY2hxP2f6Kg2C
	KARpK4QSlv3cS2w5+DbYAIzNjERYFuU+zQReHWBxFjKdHTTozh87dcL9T87187Cb
	Q1q25cqgDKuHQVaZ5Lj2APfrVBaYz656RmpzuQri6ysU2gyYQX1taZVprBjHTnvK
	29hgh3Jj35qF/PvyCIumXRyELGFEiBII5/UxtmKJw36w3CUsEnenlj6oRW2CXHg2
	3m/BNfsla+VRrOM6bEiv2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790667817; x=
	1790754217; bh=huiOc9v6pfDEp9zqgKBOFYjEGJPLYNFTptqSmcy6eU8=; b=T
	M58ptO9r185RpvirHdU+lCknHHM0zVXlHqDEbTG6T7aLMzWf21zLjMuBD+DOjNXy
	UaEkAwQbIKiYjsCcq7k8E8yBKlCARUtpCvPgSVk43FdgRzbSLhVlbbsY5vcDkR1I
	T/1p+BLMprNkZ3mMJCwvOJa2h8wnMV9NwhABxA/0hw7S2hK4AEpEA3IpFSZSrBTS
	/T/ovTKdfnNLa0j6+zdzoiuVqQFh07U5D3rM+nQtT5ar1XszqiChnTEYGItYike0
	EI+ou4Qv6JOyjEu8dhSUAmXfzGQq+VX1sBZ1xiVg7hXp5MDsJtnPrjJXJnhlq7lf
	Ee8PEdyYcNbXgZ56QvS1g==
X-ME-Sender: <xms:KGy7amUUhPoHHjPnKTDsUmlqzO3jQlWfhSoY8BBzc2ETsgh166_Itmc>
    <xme:KGy7atZAOpPrRT0XHTlJc4QJJ_omf5Gyv_cQBDEHXIEsTHRFv50ljPre8ax2iltAU
    UYgtm5Lz9iyfo1G1GZnfgvjeWIZrIEJlLg9HCczQX1rUeBpTnFXlt8>
X-ME-Proxy-Cause: dmFkZTEB0VqoVanY+yp3WtrkNlEMmMoNRVl70ZMOXBM22zWOcL1THggShoH0yIOvlnD5Zo
    AdbcaegOHTquDhzbty5e7BpH1vTP/ebZeK4Gv/utWPu7wBL+GkQYqSkKJwEogrkUv4Ti/I
    InMsNQSTlwgLDVkTXt/FxPGpW4PKqIHyaeVp466+A/VkrIvRtSdSjAoRvTA63ZxCT1yzEv
    f3tEiQHCUS9NjMhpqAx31LG0GstiLny3a3hv5CvCwsnIMgUm6/vHIy+jAY4u7Cpf8xcGPZ
    O+SnPeVPxJPYR1tvVZGm8N04+PMfD+dLnnhQEGM0bZ0spnZlhwpG9WDt8Qa7HNi5OkJiVZ
    IA5Y1Fo1FqQKE54GPoGqxyc32pCBS1/wmgOI+1XoWH/T5/gnMdSMIM/0S9oNwcDmhxixux
    TCEX6zW6YVqA0dWcKm/wxwnTbYZht9jKmkFJTqoWlHVE/quYILnPI8GAflmdIrr+9UaFyJ
    C7mEP7AlcMTK0Goa4a4UzpXxydCv4XHLTQGNqzlCbOgBRIWcicDCNxO5vx3CnXRqT23bIB
    hZRrNqpe6LWEZFjq+YphlK3mXidschS1X42UFxxZ8w6goU9X1f+OsPiZhU8zbYQ2KSDQuK
    Gg8M3yiSNLG0ynUTA79Lw4hBAQlGrYwVGt9XQdvOl5qOou+C10/KFVpYxnRw
X-ME-Proxy: <xmx:KGy7atBewLxzJqesRHrqVgVJpPqDAykVk8zhY8P9ox25DXLJE4608g>
    <xmx:KGy7apeHsSKUZz1qVM3U2JDuegczrMEqdoOGVea8ZwV7x3x2L-WF_Q>
    <xmx:KGy7agLjYiC1z8w9W2uBzAjqexukAeoH5rgTa25zkqqin1GDGVU0TA>
    <xmx:KGy7akdffkHTc5ux-Yrzk15uEz0OH9U6BYXU2Ja6Y_9juwZoMbNDCQ>
    <xmx:KWy7av3l3QDEB96oVsrD9OY3Ic9oJx7-I_x0wlySwFWJGaw5saQBaRdA>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 16C4222C008F; Tue, 29 Sep 2026 03:43:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A112ALcwTyqk
Date: Tue, 29 Sep 2026 09:43:15 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Message-Id: <7ffbbf0b-4954-4ee8-863c-4ca89ae662c6@app.fastmail.com>
In-Reply-To: <20260928032553.GA493672@coredump.intra.peff.net>
References: <20260925203359.GA1506705@coredump.intra.peff.net>
 <20260925203958.GB1544493@coredump.intra.peff.net>
 <add1abaa-5d51-43dc-9907-d6d3851004f5@app.fastmail.com>
 <20260928032553.GA493672@coredump.intra.peff.net>
Subject: Re: [PATCH 2/2] revision: handle argv movement in parse_revision_opt()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

 On Mon, Sep 28, 2026, at 05:25, Jeff King wrote:
> On Sat, Sep 26, 2026 at 11:00:05AM +0200, Kristoffer Haugsbakk wrote:
>> I ought to send in a `.mailmap` change with my canonical email addres=
s.
>
> We don't mailmap trailers, though. [...]

Yes, that=E2=80=99s the reason. There=E2=80=99s no dynamic remapping aft=
er the fact. But
with a mailmap entry you can ask git-check-mailmap(1) if you have the
correct entry while writing or normalizing the commit.

I had use for that once when I was collecting `Reported-by`. One report
was from three years prior. But in the meantime, this person had changed
their address. But they had recorded it in the `.mailmap`.

But for such a normalization to be workable at all I would have to try
to add something like `--evaluate-all-cmds` to git-interpret-
trailers(1). Because `trailer.<key-alias>.cmd` will not evaluate trailer
values if it is just reading in a file without any `--trailer` options
(as well).

***

Which is an itch that no one else has to care about.
