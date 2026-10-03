Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CF1F3B85
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 04:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791000758; cv=none; b=EDSQ8yMBqeQ67HeNi/PIy4fF+hAK2maSU/AJ5QvSWTzY41cPifX3ExWQHndeF7puUNJN+9TUrUQOTOlFh7TpgyB5l33+/Bp9GqYWlDIrOiZ/4lVBgeB9Tl2kN/laA+8S1hQSArU8AbriUaIAbMTcCbPcA+sXknx2kw4N2xcfR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791000758; c=relaxed/simple;
	bh=WDUR2NWS1+Nh+QvEGPHn3065O0t96sXw0GsnFGjSqus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LYtRppi2wk4iKG5KWevJbLqSXkF38nH04Q6iOQJvr7W0axHZ4tlurzFdT5Zjr6f0stwJCd0ydYKBwHVTrZEVDMz1CpHsA2o6JRx+steaoVqnhO8SiAabay+q0yxUAsS5oKhR7qlEAhjGWQACr9bLSB5byZFKrKQ4IIjnYUCAn0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eskjfIQ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=thcfAC6i; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eskjfIQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="thcfAC6i"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC809140006D
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 00:12:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 03 Oct 2026 00:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1791000755; x=1791087155; bh=qEpm19dTKQ
	RgpuEkn3eGg+VXooUYG1ngcntGo+pbCWs=; b=eskjfIQ11Uu/duws3mQd8eeZfF
	1prtFoy1GO52zkaf2OQXQz6jJraK87nJ4u8kXv2BhyB1cWEolupxZwaYoS3Dbu7+
	BuJoWCOe4sjfJIj7jrVFfSkFbDmTDdGuI9ie0kDOdCElMROwlfgmk3T0xy0nXsxo
	9WLUUuRa8LNNlZ7/+DTplZq5HZtFC6Ud/XU49butFoGQZqVtUUyk1Q0DJfoDD/e2
	M1lHrB6DgmR8jW84wSrYE57YlpN5G+4ZhK0RzdAlIISHOPc2Avwt4nLP5HQBzYJQ
	H2r7UwHhMXYUK3Y8rXCn66nsV/xhefyiYQs8uI5YiK5bm7kBokKPdKTg6sQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1791000755; x=1791087155; bh=qEpm19dTKQRgpuEkn3eGg+VXooUYG1ngcnt
	Go+pbCWs=; b=thcfAC6igfQJ9txirD+IgJcGV6oKsTgUm+EDX1EPs7pYS+Cfnzh
	hCfBQ8R49mT5fvuFaBIk10Owz4cX0I1hzDSQq61gGb8rTpV8O0qsQ2/+4eAPyuM2
	PQ26IFQsO44EBWzZH9diaml9nO5YiZ7DBRk7RF/ReX5sHxRlNZpRDfCNyxlSKJdk
	lBNeSmKVdcTpeVD7XInKt+XhKlJ6BCJH19XAANdKnJ/i6jjyUfxQ5ZRofNx1+ngM
	uenE+/Twl7qK2oCBuTG36RIXgbHdR05CDvuK0COKC2bt70xZSiPrCxjnx3fHv5Qd
	F9kOf5WNYXs2XkAiDeZdqmKE+TOlxZDsPXA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791000755; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:dSPUALL9HPx7c9U6F0mU8WOb+o3IADo1PWvIacwnApi9qnO
	OBckw8tQGs5tXw43BkvAS5eXyrqvw5eRQmjQdfoOyG7rR9yh6SaILdmBQBTayLwG
	86qbZp/BRAI0E1m0UUn+ALlNoHAB00boJHp0j/PQqUllJe4TBBilRCEmwmWuzW34
	gswUTF2PrMxqFX22t0R8Ni0gE3U08chymzH1ByjcFdPBEve2+6lN+vDtP1R4+IZ0
	u4KFiPRuJgUuNWRPtV9uMMc7dEwA6guTCPpfsJ6JJBT3C6Ng9wxQ8lg8ZGIm6CQ6
	4f/bTdtn9P+YOwqEN/S7alm8zNHtRYj7J+7+KsQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:X+2XiinmLqUgc9UTTBIAqPA4amoHnHcbmCBsu9J2wFc=:WDUR2NWS1+Nh+QvEGPHn3065O0t96sXw0GsnFGjSqus=;
X-ME-Sender: <xms:s4DAaroeuUlR2ID6aaDdY9WCglUH_uyEzE-2MWVxZ4Rc9H6xHossNw>
    <xme:s4DAapVyVkw4fRDBFDH1PE_wClwfb9sIrI4W5Q1I5u74hmd-A9UQIddvPMMpEPABt
    ujf7Zv-4Oi1Ycb7597VT9zGuuvp1Z8_qtaV9toG-sm8ED8l81vhVj4>
X-ME-Received: <xmr:s4DAaiAC4EuBUqu_kUw0eepmkdGBA-8jneNk4THl-svNjLFXK9cq87cKzUZkF2SIm1tOqdzaH5wDbr_UHXCEMBB5aNtd0raATFeO>
X-ME-Proxy-Cause: dmFkZTERlKI432JrzyJqBRyAzidNckaPg46UgmKPGUFSLG4ghnPWD8qvvmKmFBjm072Cge
    yhYREtUW8L5bRo0VmfUYb2bCt4TC1yGL/hGPchZx+NiR0NfG4I7V4VROPd2/IQKAqXiXLe
    29TijdIUa4ebMgrc9LbjrAEXb8eGCqn3N2dZ9kYjxoSxX4gJTi3G5AHI04lgdRXNqZKGrd
    wwmi3AR+rdg0Gsqw+S35WL0GIsIQ5pPtCJ7Ua7gB2YJna2nx/n4LFxSNKKptv1Q9pAsdsv
    aJ1yFbToISwgLv7E6TosuATGBah/3+F7zyWR1sJgvDdrLdj/IcvRGCDY+/0V0VKDrNVDbl
    gwUuBKHWn7+9rrkiuL6cVKARdT0bgrQSin8wWC7Mh52mFPvNZ2BBX48yUxQ+EbHMSJ+Jay
    DZFdsVJfcM9YESAWWY2UsUOMi/y5RFHaEbuXw15zecw4uejWuWXVvuhiTCw4bb6x9zxmMb
    VJnaIfw6TPhq8PqbQR7OErBLJ+OLZV4+6H8ODRzZQ3YoYQuUzJKIrYzkCmggZMvvbrD8M2
    1pSegjXXgANSzL4O8O4WUvEEMwyuLMipTuDJIjY+tu22/JPzY246Ht416TkSlYvZnDEtUp
    mD1nATIOIzPIXP+momv0MNo7wbVXNrGslUUyLPwz5QTLoWJRDj3Y+Iw0y1Cg
X-ME-Proxy: <xmx:s4DAal0XtykzM7AXczezRGPlQmLSOv3vmB4qX_sSGiD0goWihLmRzQ>
    <xmx:s4DAas1PJNi6hBCIDrLBnOXuCnaoYuB-qc7s6EeUpCYhF7VWeZ-XPw>
    <xmx:s4DAaiBHVI3MO1VJwQB4dllsnF_vOJKa4bvyoT61zSCfs3BLEi46bA>
    <xmx:s4DAaj5_UUR5y346C0kaHiAAKaAZ6kEBU8OZ6LBuvJO-X3XWHCyIjw>
    <xmx:s4DAajPWld33Ot7Ja8Snb8KTAB86zeOTVgeXh5macSPXDG0OLjvcmshO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Oct 2026 00:12:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Julia Evans <julia@jvns.ca>,  Julia Evans <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
In-Reply-To: <CALnO6CDoMTtyPJyOiXVPSZvFGHgGkFT-u_Qk1km+XYn9BR0OHg@mail.gmail.com>
	(D. Ben Knoble's message of "Fri, 2 Oct 2026 22:25:13 -0400")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<a1686a2d82ef9357ecff07c1247092d3dd5ecf95.1790261062.git.gitgitgadget@gmail.com>
	<CALnO6CDdoqE2hyZMJg6OZkzNtcnjNXRz=HO4q6cZVpF_wbTXyw@mail.gmail.com>
	<2f71028f-d58e-400f-a02e-7a25c032d889@app.fastmail.com>
	<4e579181-e93a-4746-8c2d-b127cb0e053d@app.fastmail.com>
	<CALnO6CDoMTtyPJyOiXVPSZvFGHgGkFT-u_Qk1km+XYn9BR0OHg@mail.gmail.com>
Date: Fri, 02 Oct 2026 21:12:33 -0700
Message-ID: <xmqqik3jtob2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> PS Unlike Junio---perhaps due to my lack of older Git history and
> terminology, despite using Git since 2016?---I would never have read
> "unstaged" as *deleted* from the index. Just changed and not updated
> in the index (i.e., not "git add"-ed).

I agree such an interpretation is certainly possible.

The verb "to unstage" would be the opposite of "to stage", but it is
ambiguous what kind of oppositeness you want to express.  This is
unlike "to stage" whose possible interpretation is fairly narrow.
You register the contents that you consider desirable for the path
using various means.  On the other hand, "to unstage" is undoing the
result of your earlier act "to stage", but it may mean reverting to
what is recorded in HEAD (i.e., "git reset HEAD -- path"), undoing
the fact that you added a path to the index (i.e., "git rm --cached
-- path").  Neither interpretation is what you want when talking
about what a conflicted merge does to remember the three stages for
a conflicted path in the index.

Hence my suggestion to avoid using the verb.

