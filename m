Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB28399365
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963423; cv=none; b=ejtwK4At1Vdkxap84WJcLfRUDvAzDx0QRNegYYShLuyQyqGIcBdossvZFWmY4Bl8K9vKJb2btt4HbMzGHczLkd+JfT96/rztLlkQY8YBxEi61m+UMZNBNolqsIISmfzFVWnsqtmZtOKg2yVAtz/szY76RkxGl4xxY6xR5GuEWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963423; c=relaxed/simple;
	bh=N2iFHL0RclX6kIz6ol2AUNq1seNkdVyRjgfID8NXP1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SacNBQjw2eKpzvM8VBKEF3lHOwSzrq0roGnQAZ4fz8hUQ2uTIEAU7LvlsFcTf7MPmaB/dBtGGo/LcLhbziJMQ/YBOU/owwxl0tYXSDgkiFvab1ZzqbWuLYrLZc/H62kgPkMxrkjIzBYrRS2Pk+5I2YnqbtoFqyfE12quUHNgkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KZNO25A7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qCLyWbbw; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KZNO25A7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qCLyWbbw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5CCE91D000D7
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:50:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 02 Oct 2026 13:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790963414; x=1791049814; bh=DuJORuJk6g
	t7YLa58LIFG7SeBUYHxpG+sRRMsvnNJVQ=; b=KZNO25A7fDKyco4N4845wxJhGf
	9AFPPd5P3I2kF3m6rhG+xdWHbcF68z1k7ktZoz4wPqOcUwYF+Dmg2gpHLnt6P7CC
	AyfN5gtYB17DcRLegPZ4QOA/upUFHBlkACnu1xGcor1AG+lXIEWEUA+grrxtNfML
	O7hW40HNKLRN3CMht2YCMmBk+Co6Whc7t4oMEnhZaKWSdCI9hV5nE39pL+xpapq1
	porFHptR+YgEjyyZ0PLsEfkjwK1L1aD/3L+q11IGTHzLAuqDi1G/BbuXMKg8/0NQ
	vSp5a1e+htnwVoIOOWBKeJ2P7FqsIaUvggoar/Y0vG0656A7DM/YK2AkRrXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790963414; x=1791049814; bh=DuJORuJk6gt7YLa58LIFG7SeBUYHxpG+sRR
	MsvnNJVQ=; b=qCLyWbbwCpb17ruN0YHbCGHePD6cQDFaUO6t2uv7UplSnEKrSm4
	XnNQT9xa74wfxzl88dVRb6nMv7Xa+1cDw3EEFvWn0m19TG/HeDhTpgCkEm/oTmPF
	P1Lf/rTnkHWjhZj/Iq/V9sBTQemdQtwbrhVRAJC26vFyNzd1nNiSRU/1HB8ffcBc
	79S9sVXSttyRFEaUD6qkjwnCr7giaJo/XjvZkrmpKpNcJjqxJMux/41WPRSokE2k
	HDUp59zaE7SQjDZG5LjwPiDpeEa5ouCGyoqogJu0sXw+8KnnDN7QB9Jm2a8xUYFu
	28/wogC3zsbeu+IISq4+NQRYhF9ENTzFwsA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790963414; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:SoW5spXMnXuiNkb9B1aEoHkMBht8vSnViVB7BcLTNsXp+A2
	UydQADZP1/AY/1/a0nRr3XyePguujCfXS7givoN8ap8pauGL8tktoLzvPHuspJ3M
	IXxMf0XzcLmsUQlXCZ0q3ZmUiKVes1xZB4w1uo+/+5YF63zhLxtsQ2Jx8RnXZJBf
	d4ZUEVtdENka9908eKDmzlmGDvgX9Kce/lfL87HRRyGbx0iPiXo63nuW/2cIDBxK
	Glef5usNVbIHDeU5k7t44UMZRdtzIiM3349a5pN55941Hr/UcmexX5my6athoZk8
	95gKfLLdKmH7dX6E3Ihu+ebq4J12tzWTJGyj1WA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:va90/F8KGQ2MEClB95vWq671wy2FPQaoyUA86y412y0=:N2iFHL0RclX6kIz6ol2AUNq1seNkdVyRjgfID8NXP1c=;
X-ME-Sender: <xms:1u6_ag_AIfSTFoCmgVqg4PFB9FqKg6GD7FKA7lzfbrN6ySJShyxlmA>
    <xme:1u6_asaBMUyi_dx1wlHKSEHp0hYh4eoRntcFuTRQ_PhXFYoMaourxZH7tTI6JgyKj
    J6g7c5MumNMkSOlgbzkqF8__p3OCZ_jAIc3ywSb5UvjXwobrni6-nU>
X-ME-Received: <xmr:1u6_av1_94ranSdFb3znuSK0mr4JHMmQVq2X_bx6SsZNHPPXWnY-tyiVR2px568ed13xAlyEUP1MVIOei27dV1Ulh_8wAx6yiZ0O>
X-ME-Proxy-Cause: dmFkZTFvWQGqTpCdwOYf6fN7j2g8yLrHXlLAdSEJmG80eGwC+OgUKww7I0J8wfVzLDSq0l
    wCykespv5/7FH2Xk/8V/YLwMveRXieFzL+sH6Oi8dxnF5wGKoB6aU3q6tEHAoYxn99Tsdp
    /ce/OmCgWdpZrrDj3DwYPMoRWBCtgEWzxMqCMwyguikaKkJ8/50e/4t2OsqIg6c4q9HA0v
    e2BjqN/5zlT02SFUSn01WoC8ooSXPvxfILV5J6Bx2dio8uOkdSA9kcep5p8Ow0G1CVIPBF
    mCevRNsRjPKd2858kGp51AJpM20lR5c5P6Cga3Uvc4tX8F2WPh4xWRJnSEAhVDLwB3xzdm
    /bG5jeoVd535f8yTSpcIHS/v2kSwycAbsrreVodzwXO67NB778h8uAFqGfEV7rVoiuVjJS
    H525yhHzB8fw3ECIqVa/uAUaJF8RUQ1tenALgICMNYPBfs/PsS3am/tCiZPg+EqjCsrlzt
    vlYhja3XOmHvLSB9NSn6cpOEsw6r3XdLQH8WEyFWi/7YhiWJkZLtYlC9etFx0tnrgZA9VM
    dmPWmc4DuFaiZxj3eKnejsTKJ/jvyp1fPY/SX0y10Op737SVO7b7mUzwme0RqRFWf2hisG
    331Vpqk8x8sksINGaf9yf4PXSoto6Nz8D7q+LSMrvTpSTPvIPiCqOHb+f6lQ
X-ME-Proxy: <xmx:1u6_anY8iM-l3-31W2quPSZQKGkUQ5eFHyJAoQdVjDK3vf9ayfg5uA>
    <xmx:1u6_anKRkTovqs7idsLqvVyOlgIF7Qk_IRKDdtFU2LSQtyHBDoG7Sw>
    <xmx:1u6_amF47zgRzJazvMuC0Rx_1QJzRXN60ckgU5marZGngRWQ8lvNIA>
    <xmx:1u6_auvdkYkQ_azsQVQCjfti_DlkGyLrJsG7cWk1A8WOyJxA99QHkw>
    <xmx:1u6_ahi4wiEuc6wTVvnsS7EYlw8okPjoaQNG2ABJ6MxbpTrt8VI_fN5K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 13:50:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Patrick Steinhardt"
 <ps@pks.im>
Subject: Re: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
In-Reply-To: <4e579181-e93a-4746-8c2d-b127cb0e053d@app.fastmail.com> (Julia
	Evans's message of "Fri, 02 Oct 2026 13:01:20 -0400")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<a1686a2d82ef9357ecff07c1247092d3dd5ecf95.1790261062.git.gitgitgadget@gmail.com>
	<CALnO6CDdoqE2hyZMJg6OZkzNtcnjNXRz=HO4q6cZVpF_wbTXyw@mail.gmail.com>
	<2f71028f-d58e-400f-a02e-7a25c032d889@app.fastmail.com>
	<4e579181-e93a-4746-8c2d-b127cb0e053d@app.fastmail.com>
Date: Fri, 02 Oct 2026 10:50:12 -0700
Message-ID: <xmqqh5j4vvor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> Like I mentioned before elsewhere it takes a super light approach to
> introducing the 3-way merge. (there is intentionally no mention
> of "since they diverged from the common ancestor" etc)
>
>     WHAT IS A MERGE CONFLICT?
>     -------------------------
>
>     When Git merges two commits together, it looks at the changes that
>     each side has made and combines those changes. For example, if one side
>     edited lines 1-5 of `hello.py` and the other side edited lines 20-25 of
>     `hello.py`, then it can easily combine them.

Some immediate reactions.

 - Is it obvious that the reason why it can "easily combine" them,
   or would it help to be more explicit (i.e., "as there is no
   overlap")?

 - The second "of `hello.py`" forced me to go back and look at the
   first one again to make sure we are talking about the same file.
   I would imagine if the latter were "lines 20-25 of the same file",
   it would have read better at least to me.

>     But if both sides edited overlapping lines of the same file (for example
>     one side edited lines 1-5 and the other edited lines 3-6), Git will
>     not try to guess how to combine those changes. This is called a "merge
>     conflict".

 - "cannot guess" would be more direct than "will not try to guess".

>     When this happens, Git shows you both sides' edits and asks you to pick
>     how to resolve them. It:
>
>     * Stages all of the files which were successfully merged

 - "merged without conflicts" would be more direct than "successfully merged".

>     * For the files with conflicts, it leaves them unstaged, puts both
>       sides' edits in the file, and leaves <<markers, merge conflict markers>>
>       that you need to resolve.

 - "unstaged" sounds as if somebody ran "git rm --cached" on the
   paths, but that is not what you want to tell your readers.

 - "it leaves them unstaged" -> "it remembers them as conflicted",
   perhaps?  This hints that Git has a mechanism to remember the
   conflicted paths even after you removed the conflict markers from
   the file to your readers.


