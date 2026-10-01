Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05653655E4
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877535; cv=none; b=T2h1HZfQcGgMSx6zwOAu4LsVUnaCmEtlZted+8HYzBq9IGp4Cs0yl8JMxj4SSD5UPvFzohOHyllGELJlv3JEJj6zip8euJrdBu1qtzZux+2Pg19x50tn3LTkT+0kl2mCn30ieJIzjnP+96oSns1hSvAaVl2YRNCtB28qEyFr5uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877535; c=relaxed/simple;
	bh=mc6Ts0eoi58PmlN6/kwU1ilpbcbiCL3WxtF8+AvwHVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L0ZWihqsdZBjfK+3rw4fafeYnjjgZn7qV+QKOvyA9EEMSY+9yC2CAki+fxmLDBfeIG1OVqoiQ7nf3UOW+FpevArXxT4wELZqcwglM/AykVMgEUV7AiymdcuS2yC5Vm1XH9xkMYqCpl9agcBBjH4t8g+gGtDRHVda648WT84rLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NX11aO9r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iECt64MB; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NX11aO9r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iECt64MB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDA191400164
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 13:58:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 01 Oct 2026 13:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790877521; x=1790963921; bh=C30a/YxyVf
	ZrVNr9xIKESnuDmxAGk4KBOA6vfaK5T3k=; b=NX11aO9rp1BInHHSxntZIgXlF1
	ZDJKelI9OLT3ypmFdjLQ8+KBf0X2fQKc/PfmgvdAbHIoDmkE0EedLBAQ9+OgBYto
	UyIVS/TIA4grlxD1ISM8+1QoIm761QDO9VG+DrqMQeG7o1EA995YwV3KCYCl4++A
	oze0yQK6tHO4THQC7auGKVRZjrwHD6kFlViYbG3JnzC60k6HkBgHiVKHUR+UiwPz
	cg1r6Bhz6eGvO2FQ7BKLrW+8k6HF6RA9tXU7RPjdBeBtCchkfePm9zVI7Rn0lMeo
	4PDeJS4mmU/Os4G0lfbgB7Spwlf/kfAC0hHh7M8xu+/iwC6XBx18C8oasQBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790877521; x=1790963921; bh=C30a/YxyVfZrVNr9xIKESnuDmxAGk4KBOA6
	vfaK5T3k=; b=iECt64MBfyoTNpBW538c6hslYq+2tJsShOzAM+lyi9+gSu3KeyK
	di2CswY8n2ErfAOQe9cFtByQ9vsMoZa1yQ+uNlDi2lIoTd/fjYkPnBvzKDyxzSP2
	BWEdtg2NOxFlA99lIrCYf8Ke77k5CimKBOd2QkcyIsW3pYUShj47nyoSeAwZEnlq
	ivoi3IVBeb78w7Lq2qa8RV17L+QAXO9UsKq+NKlCzmlem/txQUo7HW4lJ+2s720F
	PZ0kZg1Wf2soYEybL+sBYaQDXych6RiQQAmlf584ZuLSuRpnsdAkjXQunBsU/OjU
	7aECYLhppry+kue+qkRIOgUPziIX2C2hQ1g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790877521; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:uft0vvQFCB5rG0MumkmenI+jdDR/ZHAvaXgFZwBZmzZZwhl
	ZwGV+90gg5FMc4FxRRyeoft/0poadSMDTJLQdMwnzJ3evN2OOw1YQOqN5qBd3k3R
	qb7X7OIhrKVOER8XB2B2m/yUsnRezE9Tk3tBzhLJun6znIDI8ge/xTyqAiXBEf+o
	d6DM3Y6ntxTiiYkVHax9oD6H+WT12+t2DOisg89dTDMTQXbO+/i+uxV8Qxv8Q6K+
	cR2RLIE6toiSK7eMcwz8VJigtHIfs6zfipfqeQpfNfB3zj89p+/3xdGTxooLrFGb
	Clz/0zL6yObTUfcNK5jOyW+qWiDL1zQc26LDu9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dtdpIUxQTVh++5oNodYj20+ahLeJxCjM/rrRn/GrRuw=:mc6Ts0eoi58PmlN6/kwU1ilpbcbiCL3WxtF8+AvwHVA=;
X-ME-Sender: <xms:UZ--agcOlppVxphgNpfk0DQ3iEth6jlCFE0cVZeIoo5H7sESffk_Mw>
    <xme:UZ--apEpH77oPHFe6b68KazHulllWSOPrgWkUldWoT6Hx2ZUtYW7JG5UuTFJ_lW9o
    fx4czpcywNen622LgTmJEv_ZkcQBoH2eVTMLEe9-oAaTsmSfnvBP1U>
X-ME-Received: <xmr:UZ--ap2LW6XG-w69YLAKK0k73rw5RHG5TJ0BntLBmRC-YG75JzDNcYmP6HY__v5vVcBePNDHcryG5votp3NzPhTixkfMIs5G6Dtf>
X-ME-Proxy-Cause: dmFkZTGiflNQEmqq2Rg03nVSAeyLc58yRe84mEnt5jFLxWYHmGULLx/6B4Iq/EIrDEwBmL
    NXkdZigMC8WmzHviTSfKtdE8TUxBiP3mj8iCJsedPAg8JoW8NLoZLKApUZnKWWeYpXsMOX
    6SA8ZFoCXVxepfAKCZmDmXcOj7mAx5eiRKN/sSA6a16PRHH4dkSnKD3+R/4xepPLWu9b6g
    WJBV5fVCmXGzRrrbmYkQwWYIvIUcDM+8McTayTaOD2oEsg/XgbJ4ROO/nBJD4X75ugZkiI
    Tpbo6orBbwuy71cs5zjaSBd5nvjBePbLEPqZZFSbgDJkEohAFl29vloZyZHOpvocUSITUk
    beGfECLx6uxSrGPe5Zm2CloWQXrFnqNYmUFmbItS4xKFkXswBDxL1OL7u3G4nYxBcCrSN/
    qmYUbdscA6P4/VIgkROIQYRf5ytKNNWlVqaPsTq0A5D2ImUrIVPEcIna05RsssfAi9hw2w
    L1d9Iz36pCAYzfXLF56J8iy0H6DC3btoHL95STrHf/LBkJxjbEjOWlXJdfi95rge5s8GeV
    B+J8Z6qsiMyzmfNbLKrrYT63gUS6rbtzN7TCHXW1OP63BbYVm4+rpHZIHC88ABIoxYJI9h
    3Fdl10Y/cm6dYjcW2oI7qTlkZrs87qnjySfhu3TLm7wII/9f3o6ic7CPPuRw
X-ME-Proxy: <xmx:UZ--ahmqxgfIjIgTtIJgLCeYVlbFgStpmzEnpQAfZAnJjNkW5wyGYw>
    <xmx:UZ--ap-fin7DRglF4seuekFyeEJZG-Mq4mTSqDkacc7MLkpvo_hVvg>
    <xmx:UZ--amoq_3jPVj-MjIStRFvoTYoMC-09jEYZbBwzB5JHRxo0hWibJg>
    <xmx:UZ--aimTsSBhyM-7H41Z1odsD_Tt-YQYiBGhv9SsGHwgCGUP1S54cA>
    <xmx:UZ--ao1FXDItR0--0VTJ0MgBodaZI_JroaOdw2qE3o2ySTHxjt_soG2N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 13:58:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] stash: allow custom conflict labels for pop
In-Reply-To: <93321573-2164-4bbd-b884-7d6287c400b3@gmail.com> (Phillip Wood's
	message of "Thu, 1 Oct 2026 10:47:52 +0100")
References: <pull.2430.git.git.1790801929375.gitgitgadget@gmail.com>
	<xmqqfqyq8lwj.fsf@gitster.g>
	<93321573-2164-4bbd-b884-7d6287c400b3@gmail.com>
Date: Thu, 01 Oct 2026 10:58:40 -0700
Message-ID: <xmqqy0ch481b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 30/09/2026 22:33, Junio C Hamano wrote:
>> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>> This is not a new problem, but is it just me who finds this
>> "feature" more about "because we can do it", not "because we need to
>> have it"?  Stepping back a bit, why did we add these three options
>> to "stash apply" in the first place?
>
> So we could have meaningful conflict labels for "git checkout -m".

Yes, I know (as I already written in the part you quoted below your
"Thanks").  What I didn't realize was that we spawned "git stash
apply" as a subprocess from sequencer, not as an internal subroutine
call, in do_stash_apply().  Of course, with that calling sequence,
we do need to expose these options to "git stash apply".

>> If there is no good use case, perhaps what we should be doing is to
>> remove from "git stash apply" these three options, not adding the
>> same to another command.
>
> I think having better labels for commands that are autostashing is a 
> good use case for adding labels to "apply" but I'm not convinced there 
> is a good use case for "pop". As you say below is anyone really going to 
> type out the labels when they pop a stash? Scripts should probably be 
> using "create" and "apply" rather than "push" and "pop" so are already 
> covered.

Yup.
