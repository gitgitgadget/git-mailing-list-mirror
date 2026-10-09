Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A07842A152
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558839; cv=none; b=edudWD82DLulsxNpdfR1JkYVqSJqp8Fp0vSzGNJjel56EQiGhOia1J+g0zAdpQq1srv1tH6fbmSeuv7TJ7RS/Opz1PN393hFboDBlaidwEgM+A2rp3QdxuuL/5pocaEruJnvIT7TRc6ZX7l3aT5+12LUMuxvhJuA4SZiRG2WOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558839; c=relaxed/simple;
	bh=yzLA6Fomzj8UzIBv0IR3CLilXhyUwn7XPcneswkJpPY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P33Lb8IYsAw1xLOiKMvt93vIXh5tbZ5no3Dn7h5SPTc9FZVSr7L/9zxQ0OobqBlvsEwdS6zjV0QJmed8EE2i8OUvx0E/gFB923/GSf6A3V0S1yGBbSrHoUj6cNguJAUBf4vfG98wQuAYUXzhoKVBoIByRXxe+pj5MEyNkN8bPqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=YhwBEaZQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cz8jPZmP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="YhwBEaZQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cz8jPZmP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 754AFEC0906
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:13:56 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 09 Oct 2026 11:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791558836;
	 x=1791645236; bh=rgq1/eedo40j6Wo1iSAEU+Db3Y/Cz/wWCNTBr94PfHw=; b=
	YhwBEaZQGQyfVYF4W9J29Siks0eroitsa7Lqkux/zq0cODhPTl1pYv3GuGd4adEC
	c0yBbQNqfHIEmB3agFrLgvwoMyPPRYyy5/Etbag//IDpZaKtqxxhCP/7ZlcUfdUw
	nfvg6XCP2w3K0j/RvsfJznS11LxvilPQkDb05dazc1OwPs4aN6g1dG/IAOraemhJ
	w0BCd5HdahMjhWoZPiTaP4MRi0IaWEbjX4CN7CST458u2Kt6quULcjFX7kL2SGf5
	lRMbamcUtGJyuaoYDk8jzKHmgKrfaj1PRFtEsl7aPmehxbfrY4X5M7lpY0IrH5a7
	HpesCdfPd63mSjjkfPVdzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791558836; x=
	1791645236; bh=rgq1/eedo40j6Wo1iSAEU+Db3Y/Cz/wWCNTBr94PfHw=; b=C
	z8jPZmPjQkjmeV/1crJwRBjU5FTPQUC76heXObCE2qM53nhtorK8E2PdDCVmMtcg
	LRBPJtklhQD4mSS+kU0dchlA66z4swQLouriLqT6UcEmo3Zqmt0rga3fXmeMTnAB
	q1+fRrk75W8XAw1Ck5eaQlfkZekpyCoSg0FbloWMTE7jpKvprLRdX79jbs7iLMPR
	giu3CXz6y458zoXGsDT3vnjOY2pI3dZGgBozA/jpiP1UfD1q2NAe9UlN6kezpmlU
	NcoI9x5PSC2lx0BWPS6fl+tmyYKT+rAFSzhtMNQxK0R/yBU5Vi9pBFCNJIq6VMmp
	AwhR472zJCrhtan4t/Xwg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791558836; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VfHhajmDjUtgs9pJvRNV4CRjf6ti3lT4yW/OTr9qAAiuiIv
	cuEeGLloj+eqg+kRJLO5b3tMEI7t/VRu3MH8u569Xy52zH+XRXaZfwp5aO7DY3R/
	VVhqQywPdmT1WFbF1rps4DkuEw9mQyNdIWWMNw5LxAGPWTjxEWdsPoDMd1Y6/qcf
	4VVWVE5DigXbv7lHNmeRm07homguwfuEmq5SpwdZB39mC/bFGoQlrasZH3795EEp
	gYrvoZkOs9+G7E5GTMHZu2kopPX626wdbabvwpEU7MLIj9vGzGQO3JcQUGdZSRSS
	uT3TB1VdWaveh+AwmeXPsc5ifB7Sos6dRXjCJtA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6VeI4PJtCEinDsRUC2DFEnacruRPhjHrLp0c/ycnQ80=:yzLA6Fomzj8UzIBv0IR3CLilXhyUwn7XPcneswkJpPY=;
X-ME-Sender: <xms:tATJajBbl3UCNqDT9Aa1jsM688GzOP-WOwidzgQ9Qs--NETAx4TGzQ>
    <xme:tATJakXHLZlhKzcSQfPp_tYE9939BjuUHzlPfBKjECG4RMs6ZWm0HXzSswjJHVG9b
    uSpY_rG1QCiZlk4Qvac4SZD7YQZTmolh-KGcyyauGPA3mItTWTnseU>
X-ME-Proxy-Cause: dmFkZTGfuH+QqnipwWB7YzJCqqJJh9FvY6Kr//cJWR3aQFakA8Yri3Rr9aErGFkYBm8jyM
    4ls1kOleIcJlSvkOcrGE1PZQ7IVeiD+WBsXRrIi+R2h3a5HR9VK9PGRlA7wwxJugLEGyPd
    EMt6pvZ+3hmWa5d6exqo9ja1AyclAaIQe0R3SALNprGsa5NBc46QN13uh4/lnK5YH2s+AQ
    VmGo1t8mh9mLy3n0OhzDe6lEy+lW2Mv5FNQDBBGb7sV88CR2xjBGQwdAeubo00/wUOTrFp
    nvLWmHvPuvjr1GcpYXlcMzuQB/oP/VaOAp8K7JSrdtzDxHmY/Yl3xcN230qbcgkCwzSaps
    LuGtXczMjPbEtZHVvYta6mMeW1trln6bHpItQ68EHt6g4zwP6Cod5GIeVnEqA4jG8Fk3c6
    TZcDHi0bEnU4mmREgeh0qfPyamsnVBRSiGl1D73S5vSgwUWGsuWPaDGueF2BY8EiZzZjv9
    2f2u4LHQTlKvyzYq5AWp3LRXv9qD4KcaxAc006wvSHzvIRs7JWr5GxZOdPwFbIHwvChphR
    umNMkVFLJuPFGDxJ76gxcyzeSXlZlCFoz+VtpXsKQRvdiG3LOR704xldk+AQQDi0DCB4ms
    JBTl57hme4YTA/vihOuth5pSUigMcc6r3JXI0pd9sgz6ynurtZBgZ1BrY73Q
X-ME-Proxy: <xmx:tATJagHbnT2nuA1XJY_RUIUwiamD5foKEwtEF4BJ5t7h16WusrgnIg>
    <xmx:tATJaq1Phldo62PlZPu_CcmZou7Jk8jtuajtiGWsRkxv0BrIcDBGvg>
    <xmx:tATJaqMXV57EfiGXDJB4TErVIiRA8XVeAAXyrZ_WJQ3lJ_dCZpqUxg>
    <xmx:tATJah7ckdJ4IRKD7XgvwTDDpNagIyTYyPYpUfQK-A6ifE_SmHIGAw>
    <xmx:tATJasanHoHfXsJHhIB79XbojceVDOf_UHrjChx_pFcVuPKivWmc_NDf>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 41138780075; Fri,  9 Oct 2026 11:13:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aisr1WIbeEPB
Date: Fri, 09 Oct 2026 11:13:36 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "Julia Evans" <gitgitgadget@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <e3227098-5f12-48dc-8c21-8d2388b1a8eb@app.fastmail.com>
In-Reply-To: <3e26cf00-ce81-486a-a6a6-720d22b8f118@app.fastmail.com>
References: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
 <pull.2249.v2.git.1791551486318.gitgitgadget@gmail.com>
 <3e26cf00-ce81-486a-a6a6-720d22b8f118@app.fastmail.com>
Subject: Re: [PATCH v2] status: suggest `git merge --continue`, not `git commit`
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> On Fri, Oct 9, 2026, at 15:11, Julia Evans via GitGitGadget wrote:
>> From: Julia Evans <julia@jvns.ca>
>>
>> During a merge conflict, we suggest using --continue to continue the
>> merge for rebase, revert, and cherry-pick.
>>
>> Change the `git merge` advice to be consistent.
>> Commit 367ff694281ce569edd8f6e444fc770f92f5d215 says that
>>[snip]
>> Signed-off-by: Julia Evans <julia@jvns.ca>
>>[snip]
>>     Changes in v2:
>>
>>      * Use git show -s --format=3Dreference to format the reference i=
n the
>>        commit message (thanks to Phillip)
>
> But this isn=E2=80=99t changed?

Oops, I was so sure that I'd changed it but obviously not.
Sent a v3 with it changed.
