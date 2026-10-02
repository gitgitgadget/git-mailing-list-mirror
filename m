Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885236D9FE
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967222; cv=none; b=Fkypnd9+4JjE9Ckz7oMP7YIYwNdQdolDlMFFZIJ8/J9UJ/FNxOIKjcpzU3b48kgsClhQIPacfAUPi4zuxI9e1bXkt/K9oAjXiPPxRm5jc9VmMoyKNq5lwwmro6Sy4zN+vLmOjrbcgHCQ/ytlz7JcolIpPlNypT9rehX0oZjozfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967222; c=relaxed/simple;
	bh=NmjuMm47shT4MkRlDJ3UfIHbIwxeMFRSkgoNXIlL/Tw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DwZ1w+vxNqayKTLYk5KIFwLHkp2fXI5KJsad+VLU/0VRI9+ZYNLrSQPlS4oX4+tVh4zR8ykmLBtQqfOLIJPFJaTvbDWKu6hHV0aSZp5JiYkilj02KN4wwm0LImCSmdqBpChSs8KkEz0qjEfeXoyZsIvX1IIYDda1e7pEx8hHSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=B1h0n6iS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Avta/cZE; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="B1h0n6iS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Avta/cZE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D567F1400098
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 14:53:39 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 02 Oct 2026 14:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790967219;
	 x=1791053619; bh=DTd1VcDz8mFmtX569dhNgsSTaBEFKB8e3afaX2NVQY8=; b=
	B1h0n6iSWGN4lxTV3J3OLs+bdeFHgQqi3I3Lcd5S5ieXfNXr0Aw5X14Dcclw4Uxl
	9zVfZiWjRLkFUiJCRQOwuY7bjfMb7UISBdiS6xI1yonIfVnWfus8D8qt82zDBpfO
	uk/eJ77f8XPM8s+NnNweAdlPVyqLD66W+5E4ktHkgIq7DL5Mr4RMRnWjRhofKlwZ
	s8UuwtiaUpQSyhuCgDNtDd+8Ik2LRZdlr4TYGZkmNSRo4FeT18ICUTiJUJo9fKoT
	/0TVCFWIEp/P5UcutPnSXF9Lb+89e+YIAL/1lpbWkkJ1GxNILUBjZRjHFF16Zl/P
	Cnk+1iNZz5fNLwCB9mXvFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790967219; x=
	1791053619; bh=DTd1VcDz8mFmtX569dhNgsSTaBEFKB8e3afaX2NVQY8=; b=A
	vta/cZEE53Ef9v097awNsLyrjJIxOVkYCIeTmRmGOADX7dAumZy/PHnMeBPFhmcN
	oeh/rLvx+eWy8JpT6ITWYh7FXDNvY5bdAuo74MvQv5F2ygKzSATQW9ZYdhA3e769
	0ZUJY+299Os0g3+CNiNRO+239dzom3C/HuIhjdHgD4Y5tcTnvaOLupAWnT4R8YJR
	IhmwNwdC5sf/6XsEtO/1BAnOmzbSj3AYYkN85yRoiBwfCtYxD4tSgBIgwuMNGo02
	2yq56Hlter9/dPnq3rQguhFfc5qmwqP4pJhFTsmcwTs1BpRrJI+4p7mSMDTaTMDA
	M/3NfYL8ygGtK6apRs8cw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790967219; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:sxsT63qBsN8Nj+Y9sAgdhaCKwCpID1VEMCVc8aXddiVpxqe
	rM2114I1pQhcuTs6WcL9M3QvPVBiLZF/yS0yeOuq5t17jNO909LNwu6ZdCxsWq4h
	vyCYRInSR8gnWkaFC++Mn37GHzZwsAm49ByqhkjhP61XoVPpaYC7zAS9YGfcHmFT
	LcNjexRO/j11zO4j4hsEAviG8hyvoG4vS6G+6HGusuNXdTfL7O/3o7NtOpD4BP/f
	5f2up+Gq6Q38rma3vcmN6NsVXdPEmtIBl/mvii0nlbvjDdsuLohNRkvlpHEYm7zt
	PweSUiJ1XOCyGp0T1XccH/2jzjHODqH6t8aYzkw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:c9i+83ffMEEolZPK5KNXIXHyw2cHRGi5VyoeSTP9gTA=:NmjuMm47shT4MkRlDJ3UfIHbIwxeMFRSkgoNXIlL/Tw=;
X-ME-Sender: <xms:s_2_an4AlnktaqXNOS0EuLxWJR4_l9_m7sfbWSdkk4IOmBfBQZ5Riw>
    <xme:s_2_ans9Bh167xBxMuFGfOktp26aAzir3P9R3m1f14DPVfGp6khp5cmHapbACq_6H
    IVR3-wlPkt70RlLrgdZPG5KkgpSCfdsk_tS0jyAJLcD4dTxhpo9Dex5>
X-ME-Proxy-Cause: dmFkZTEDWXhH1nly6zamKC3+JTfD/OHbAkMlq3JLeWiuqhA07/QwKNAZzSbXJoejCX/uSZ
    n0Zu4uC9aIufktO0cBqvG8Y9GGNkOMZxNkcD0rmGtWOWApysHrDO3tWg8aV0vv8ggYZV0l
    4kK8z15pu5MQAiNyvtos/Emswvk3uEfKCEEmsiG4Uw8p7Au/8DY5wwO+/1YTjy98Artk2W
    MxmSl7dVH9t980fUcCsjGbpBTszwY5sm4hQRawj774U9FV9ieQSAUPRA5kSh4Sdkf62MbP
    K7E1T9gy/sO8Mmx6/5/iX1LAmFVI5vHMEz8vMw4x4455W4cJ+9jctKZ6Wl0T1ifBVeu8CV
    VrWhrcqzbrQFrpXW5AOaF4rW4DWdSs/BRG70L8Esf1gsa85TUoI9jl3f6a5Ul3mKozKkJk
    t6VNnmH5PftlqPX/vemdjcU0kNYLQo2jM1g+o/LPT6Va5/cB3FS0OwET6a2edFJvOt+/cf
    gLwLv5Y3jcFRm6Ok9dbzLxIdfFFaEGGjZAXC/I86II7ccLVzFC/CqMIDdQsH/BhLbKQ+qP
    79FuxXkingijMKPud08NB9xV20oGYoFDj1BoxK9pfL5iRr46zLzw4NTFS0gSznJPYi+sI9
    TgsXVCDwFipGLZ9GOZmIjU5Tx6jW4vS5FUZtTlclgt8RIkOseGPFOjIfeGBg
X-ME-Proxy: <xmx:s_2_av8KS5RPbu4DL-rDzhvC_hkJYF8dcFDQXiOOOhzg800Q4gyHyw>
    <xmx:s_2_atPyiVpdOanBRaT9CKz35XVaR7miJnU1nuwwspowyfbNwVTkRA>
    <xmx:s_2_atGyf4aBTvsyVc9apAm7ccRIdChfie8dOFFAU49iHlssPrvCPQ>
    <xmx:s_2_arRCrxnu6loDEXIz9ScdIUjaxbuLefXw0w9InYLEx4MNgh6s9Q>
    <xmx:s_2_akSBapcPCK_3CdQdbfNp6z2Mi5h1XGEhBjWkigYDOrtcczFGSPEm>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 96B66780070; Fri,  2 Oct 2026 14:53:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ3yMKGvzUL-
Date: Fri, 02 Oct 2026 14:53:19 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <7861e492-6fa4-4768-afdd-65cd346b85be@app.fastmail.com>
In-Reply-To: <xmqqh5j4vvor.fsf@gitster.g>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <a1686a2d82ef9357ecff07c1247092d3dd5ecf95.1790261062.git.gitgitgadget@gmail.com>
 <CALnO6CDdoqE2hyZMJg6OZkzNtcnjNXRz=HO4q6cZVpF_wbTXyw@mail.gmail.com>
 <2f71028f-d58e-400f-a02e-7a25c032d889@app.fastmail.com>
 <4e579181-e93a-4746-8c2d-b127cb0e053d@app.fastmail.com>
 <xmqqh5j4vvor.fsf@gitster.g>
Subject: Re: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>>     WHAT IS A MERGE CONFLICT?
>>     -------------------------
>>
>>     When Git merges two commits together, it looks at the changes that
>>     each side has made and combines those changes. For example, if one side
>>     edited lines 1-5 of `hello.py` and the other side edited lines 20-25 of
>>     `hello.py`, then it can easily combine them.
>
> Some immediate reactions.

Thanks, incorporated a few of these ("it marks them as conflicted",
"since there's no overlap", "the same file")

>>     But if both sides edited overlapping lines of the same file (for example
>>     one side edited lines 1-5 and the other edited lines 3-6), Git will
>>     not try to guess how to combine those changes. This is called a "merge
>>     conflict".
>
>  - "cannot guess" would be more direct than "will not try to guess".

The way I think about it as a user is that Git takes an intentionally conservative
approach and I appreciate the conservatism. Compared to a more aggressive
syntax-aware merge system like `mergiraf` which has done merges I don't
agree with.
