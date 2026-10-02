Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354BB3D76
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960504; cv=none; b=mU9wS+tQRKoXbQvGDNpsQE4Jij6tNhWn6bVqXRRbCsDt3cZ7e1C5w6ATYMnvDgcmYQzEfJnBNOzcrDoRppMXaYPn083b0XTMu7/8C9mYbcjGm+JhBwfYo6loo+Paj3hMt0Z3fZzyjDgfnjUe+xLsm4xNbufO/lsWLvGmpoQ7aqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960504; c=relaxed/simple;
	bh=/lr53tRJzEj8UMmFUQIDpTCh5bzcPUXXfmRR2e6CbAw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Btl9krFi8u0/uNokVC0JklJZRDUP06KvabLzoCt6jBwUVBs3RMEKyRyeVLLTBaVbL94PJf+UEbz7cb+X6pA4sX7/FFawvsBjp5rORvUga6fpWJ5qtrPk4jngMUzZYz7MMH8sgK2FBvQkulGO3tujMn8gMbbyZG1CYYYHIdI5djU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=4E0SMl3i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m8QbcOY7; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="4E0SMl3i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m8QbcOY7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D977E1400041
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:01:40 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 02 Oct 2026 13:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790960500;
	 x=1791046900; bh=0ueZ2aGXlDG//3ZpLZLf722oYMW2aSQc7NPpHYob7tc=; b=
	4E0SMl3iVxn0puKUyrYwwMwGhZucK7uL/hotoB437TxwxinC2WsDZ0O1+RyELTdD
	GfQu5jSUNgrxofoX0KpAc53Svb3KySsHSkCh7XPEKx8iFjtKdHgp2dQmM26MwEbN
	X+zq+mXzuYPmIEdSQu/Q85YBfuUg1B8lVR+4ETgtyDIfsespy/q6IfZe0WTC8Zb3
	+NiFNHDErkzI41Z6fDgu9ZiMeWJ0xe46vOldKBnB3fEkB3QlMEI1bzrkOOdk16CT
	L4XPIQPOI6vjHto2v+5eaXEfoe9IRweEuDnD9TTP7iCvxc7pE6n0Zc1QhyGSoOQv
	Uasbrq3+VEgE1ah0JJy9GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790960500; x=
	1791046900; bh=0ueZ2aGXlDG//3ZpLZLf722oYMW2aSQc7NPpHYob7tc=; b=m
	8QbcOY7nDud+DZZzpgucw013zW8uiTbMdvjymPxTuesFfMRDsij5XSDrwKiI8fji
	xWTq9P33HTKa5PYfvCDBX5OHxZPiypYceB7VyzW1MKTDFI5F87Ba9QIwab815Hxt
	+vgNRu8U8L00CTGlFeJyADWl32Bn239TMUUFLPG1UtV2kG1VykRliX41rlm97w7L
	GV5bhQs9Si8bUQ88wgv12EaX+CvAwcASUl46lZoVngGB+xzw1swrdH9/qc7AbgYp
	ZHmvytEhUfosLcmCwT1QbfDffDTOVS37tIG9P/EIkhU8BCecOOF1H3lEqzzwpT4U
	JCxsOIvEwAO/FSo5qxekQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790960500; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LBQO+Z+SHoKFU6Nxdt2Rws+sFZi6VDnEcZ/lbECVY1VG2RV
	iEf7muAdSS3l0w5vACIbKe2IdWlQvNCrpUgexTsD+j2qM78HGMoyM8loUXc8nria
	EDa0QBg1QylpW6kpsxy3Ag2eYl90WX4yics7PxEJWxHwiQurOXAWKn0ZbB5KpQPV
	bruHUKpZyOc7U1b2x5OhsJDDGoZ8QHY84T2NXtRh8OHjYAbM9OaJhfSm5BJL7C+l
	9EqbbAyaYfyHoIKKjWnhTwVSY1LSqiFYwiZl1I/sppS4vnrCIPGazSHOWZHB3gY2
	BNMyUIbycJciw9yvvRnId0y53GS/AxrjetLO5Nw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GooPIT7H6VNwzbyPc7v3Ky0wwzWyoa5mhFFM5yT7Lvw=:/lr53tRJzEj8UMmFUQIDpTCh5bzcPUXXfmRR2e6CbAw=;
X-ME-Sender: <xms:dOO_avn_CHfko1LOnKtNl-Gcv7wU0rUmKLw0uGYgtQrPLl2K3iyvRQ>
    <xme:dOO_atqG6YeT1QBIzx89D9dAtuEDAGF5skWclpxqwyzCBk-VH2RUh_TbaJ3m6LSmq
    7jI0-RzU2uZssbcjx2nQ7mrGhmoP1oFH24CQDmXJYviG0FIJHZuFXs3>
X-ME-Proxy-Cause: dmFkZTGjNtiusw+xDEVKjeLz4XAtQUgELWSHc2M1NOCXUJKh+R7Dmv45IyHkCXlbX1u2cW
    Fw5/QBxbus0McdNmODcNavb+0gubmJLu18ZHZDwZLqn8cR3WtUiCilYyYv0z/1GRpJT3Vr
    KH1RVa6Cb0+D5rlYiZEzGC6mteDTb02JAohVlbIJrzQcaMjO1eUaoqf3WJUvr10Lmju0no
    CO9Tw8y4YlEa37AB6FyQ846vSlJvbYn6GWaHdg3SAmEORPpkb85qHamXrLuBzUSgDcVs+s
    5/C2BHfTFm9vxs3zB0fXzhhXK1QLFcpnW/ziWzaOuW/nUuvbshwSO28RC5TSkhHjB1hXLn
    P332xqv6itvqj41mVHk6F1JlKhRa6yMeVdnNOv/oHh/QlVRivh+ATf+ZFT2aUjbk3JUCnh
    sAuWfgbLO3v7CEFw1BMwGVEMn4bOj53nZnF2m8A8ziXBGU8N61xoKAA4EmjTR/f7CjqsZP
    qPGu98L+3hrEKaba8BIHzbTAwGWs4aYjOcx5SGWaRuGceNWqikpIG12oNms+r6Qiso/PXt
    r6mBibWkQgqkRTryvrzVe+d9Weh7lq0mQCjzo2IucaUNww5aFBS5lboujh8XJttG//tAOW
    dZpwpuhZTaBswvVVQBUgbBSUIbozMHgbgwkkOHa18+b9+35OVwhsJCBVlgKA
X-ME-Proxy: <xmx:dOO_apMgNKpG78D4Sw1Xbg8cdS-LmW2oLBey-8L_B6IQQzNV8CEhAQ>
    <xmx:dOO_apz-GajwRIJq0oWzZ-MlT0yZ-p-dEIxPGWPp00eiEuZ0riMYEA>
    <xmx:dOO_aivG4ppqQVRqNhIB8trKhUiT56caFWJTBvyai5TJLumEdRPT4w>
    <xmx:dOO_ai5Q0_jzF3PNbaLfxw0xSsNMq176-t-LVOHWser8F-3r_-WgOg>
    <xmx:dOO_anBrSO438ARrasrPklpMzEk15EH1P4m0ONd31Q8yWh3laHn9M6Wd>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9F044780075; Fri,  2 Oct 2026 13:01:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ3yMKGvzUL-
Date: Fri, 02 Oct 2026 13:01:20 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <4e579181-e93a-4746-8c2d-b127cb0e053d@app.fastmail.com>
In-Reply-To: <2f71028f-d58e-400f-a02e-7a25c032d889@app.fastmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <a1686a2d82ef9357ecff07c1247092d3dd5ecf95.1790261062.git.gitgitgadget@gmail.com>
 <CALnO6CDdoqE2hyZMJg6OZkzNtcnjNXRz=HO4q6cZVpF_wbTXyw@mail.gmail.com>
 <2f71028f-d58e-400f-a02e-7a25c032d889@app.fastmail.com>
Subject: Re: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Sep 25, 2026, at 12:59 PM, Julia Evans wrote:
> On Fri, Sep 25, 2026, at 12:36 PM, D. Ben Knoble wrote:
>> Hi Julia,
>>
>> On Thu, Sep 24, 2026 at 10:46=E2=80=AFAM Julia Evans via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>>
>>> From: Julia Evans <julia@jvns.ca>
>>>
>>> All of the info about merge conflicts has been moved to the new guide
>>
>>> Among the changes made to the common ancestor's version,
>>> -non-overlapping ones (that is, you changed an area of the file whil=
e the
>>> -other side left that area intact, or vice versa) are incorporated i=
n the
>>> -final result verbatim.  When both sides made changes to the same ar=
ea,
>>> -however, Git cannot randomly pick one side over the other, and asks=
 you to
>>> -resolve it by leaving what both sides did to that area.

>> I think these are both valuable pieces of information we have lost in
>> the new guide (unless I misremember just having read patch 1 :).
>>
>> The first explains a bit more about what a conflict *is*. Maybe that's
>> old-hat nowadays, but I think it could be nice to keep a statement
>> about why conflicts exist.
>
> Will think about this!

After talking this through with my collaborator Marie, we wrote a new
"what is a merge conflict?" section which I'll include in the v2.

Like I mentioned before elsewhere it takes a super light approach to
introducing the 3-way merge. (there is intentionally no mention
of "since they diverged from the common ancestor" etc)

    WHAT IS A MERGE CONFLICT?
    -------------------------

    When Git merges two commits together, it looks at the changes that
    each side has made and combines those changes. For example, if one s=
ide
    edited lines 1-5 of `hello.py` and the other side edited lines 20-25=
 of
    `hello.py`, then it can easily combine them.

    But if both sides edited overlapping lines of the same file (for exa=
mple
    one side edited lines 1-5 and the other edited lines 3-6), Git will
    not try to guess how to combine those changes. This is called a "mer=
ge
    conflict".

    When this happens, Git shows you both sides' edits and asks you to p=
ick
    how to resolve them. It:

    * Stages all of the files which were successfully merged
    * For the files with conflicts, it leaves them unstaged, puts both
      sides' edits in the file, and leaves <<markers, merge conflict mar=
kers>>
      that you need to resolve.
