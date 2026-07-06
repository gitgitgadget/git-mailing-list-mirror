Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493383DDDAB
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369016; cv=none; b=V5hNCLBMnXVEGU8OWCWgjyhnk1ghMH4n8sMQorSoFpriiboUOmONVBtMIQVG9XiIR+/Ui1YD92moF3HGrbFEufIBir5Fetfwm6oG7fjnrGos2S/muu0/WCrqx1QfVZ44gKBglPIe8w7m/FG8Pabgmc0ItW35cMcepsQDCK2oyu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369016; c=relaxed/simple;
	bh=0SzDHKzjSEe8qoy9eiIplNxthWqQ7Nw/ru/2Fikwm5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dmCKvEJtSXov3efEZth1iiybSwhVFU4Ugn64GoutB6tLhPhsskPJtqC9Fio/ZJpBXskgi/o/dod9Dfy6d1xA7j2f7p3SRzDB/QGHt4Y1DbokvBGBfen+YD/1Lg2VvX+MRkiDNclqjgO+0ZOhXIrxhrTiRc3ZR2eK4cQ23KPWtH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fi2L9fzb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gse6UecQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fi2L9fzb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gse6UecQ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 84416EC010D;
	Mon,  6 Jul 2026 16:16:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 06 Jul 2026 16:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783369014; x=1783455414; bh=LOb8f2gDO9
	y6efwd+UoUnJblPHwuqaO9Powo6c6GhUE=; b=Fi2L9fzbMjgibwYHXlCImmOuqe
	IZZ1n9n0yZQ2oi9mIxV0+4is7tlrFJZjJzD+5z3M2KYbHWdldhJnm8x/PjNQiCDT
	c/6GcKGWRtu4HbjzuwQ+DIAWKaagPgjUhiFfrn98kKOsTArVguDRgRkpBPRrjghk
	ybfGi56Q+XtbF22rW8ygqmjiuY8YcsUgx0/vEBLzre4r499rHhYcPhyFBruftY7E
	wFG6P42TaOOLm8CxXqxRAdna0RMrEWM0AE5hsJCwp5O6ViBLWulDTX5qB3SW84v4
	Rg632yJmax/+rfqZb9t/pKX4c9Pvg+ioWYKq8jhMaTS+afVCcrWvfrvR9EWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783369014; x=1783455414; bh=LOb8f2gDO9y6efwd+UoUnJblPHwuqaO9Pow
	o6c6GhUE=; b=Gse6UecQWS0OCsWYGovgX2IKM8oEFOLMYSN3qG2+1eHvzi+D3zY
	+fRT10Fe3WKQfn5rABFZ6G/smbkYaQigWO5XYQy7QgVHN31BJfAm0KYk8xixd1lG
	GKs7BfeBlJ0gm0nH7anvGxvJZE/KW6qrNWrsObpHBv0qoOXJazZZpoj2MLmo8Jvq
	dKxXWIXOZEmpxr3W2BsV6YZ6dAxwrYSkHXlfXbZcDmZtzgVrJNGhzRF79K3zGHl0
	whAxnHx2R8Y8v7RGuoa+wQ2cew+AY5/sO5DHlOU2xojcV+yFYAIfYsknTBRkKjL8
	52WmpBOjHOOkaOOroxmLU7bPG+G8Xo0qobg==
X-ME-Sender: <xms:Ng1MamSQt1TUmlSem5iLPtM3tIIgH6qRwcasd5Gb0CqaZd4ef4Z7vg>
    <xme:Ng1MakusDtaExBD-EvrtpJSmgTLEbgXcbsORvBQBODcMUin627hBPaelfuq4eRwe8
    GgKcX8hWswCpN63AZXkFbo4ZetcwxLK2NHIpyPjM3Ij0Pc0IxA-1F4>
X-ME-Received: <xmr:Ng1MavYFaIjGKIsXRgQM8YrtNVvAowDCSodIeFkUDZevWVfrLE1T3GJLtO7hYEnj1GBXLSwRaeY8fWyQ0vpzVywxma1sYOMNJ4Ycphk>
X-ME-Proxy-Cause: dmFkZTErZAkCQk8V5KXvkOGuond/lGlkCBRZ61byjq44dVlWIlky9djva4M2yeuFGi/o1A
    tUVtw66ufGMAdUI964uF88cpZV+YKTgyX/JBALstfB3/eMO1NmgBdz72bXZtX/BSFpqkrz
    d+mTj5VXYleqy+lRNP6NApOBq75TbQfoJVu4YeTfHfev0nqUHpu1ZMwUaWKo5wGJ8BPins
    +vuiDsSqL8cAgfN1NRxe4BzlrRpriBc8ZbQnAIhQE+BiqrnqRKJjHXUaV2skC2fbc1oZA2
    t/G+nXRkVcZHA/woVQviTF95fnJ4oEKzGnqBV/T9WzK7B6sw7EGcqlX8OzivGlesMiMZoW
    P1iYXCPMD1LCyD9KbNjXypwQ1pRz1xIHL4il/gFGbVqNNSjpwStZ9M4pJhLM1FV+aEnped
    plAiHfaWDH43QlLzGgU0EFYQAvLSiKVAikkIULSKdh/rzRDCKkJlNTLL9gZ1E/Pdbevp2N
    DsxxyhEW3yhRvoOCuBbBSDoWMOcjIdP+uNnZg3YCwPo8ISjTUId0pxSeGZye9vRdYLeNbU
    O0jlGLD45kbBb7Mm+d7uh9A1Nc6cYTQbpFqJN+qdAo0w8yWT1D+ftLmljCtWjE4BTk8tHV
    Hpb7JGwYuG3u6L9P0vmGisxF1WirTSHxDsPMRy9IktiL7C+icF9VuOUP1Bhw
X-ME-Proxy: <xmx:Ng1MaiHP3lP3sHcxYlB2Y0G05eYUxM4bZWeA2d1iOjzmkVJ43mfdYg>
    <xmx:Ng1MarwxJb0wReRqnDYh92udCpQpk_hTF34vI2JGFaqPqmN81VlLsg>
    <xmx:Ng1MasmEwrht4OvZHam5qSGsuLIeMeT26LMTptYvBDi2AuY_hrcViw>
    <xmx:Ng1Masnu4Ivvdtl2wHwHBoYJ4t90wnOg9KIvbCocbAugutZOLt-YNg>
    <xmx:Ng1ManMvCRCzch8t-NBhtD5CZuRXHySffPODxq7CdQfnpkUsCXQgVfHJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 16:16:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: git@vger.kernel.org,  Colin Stagner <ask+git@howdoi.land>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite
In-Reply-To: <27211.50096.133710.528147@chiark.greenend.org.uk> (Ian Jackson's
	message of "Mon, 6 Jul 2026 16:03:12 +0100")
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
	<20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
	<xmqqy0fob2kl.fsf@gitster.g>
	<27211.50096.133710.528147@chiark.greenend.org.uk>
Date: Mon, 06 Jul 2026 13:16:52 -0700
Message-ID: <xmqqik6ran63.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ian Jackson <ijackson@chiark.greenend.org.uk> writes:

>> 	if git rev-parse --verify -q "$1:$config"
>> 	then
>> 		die "fatal: tree contains $config: has been processed with new standalone (Rust) git-subtree; use that tool instead of this one.  See https://codeberg.org/diziet/git-subtree https://crates.io/crates/git-subtree"
>> 	fi
>> 
>> Overly long output does not look very easy to read, but I kept it
>> the same as the original.
>
> I'm not a great fan of the long error message myself, but it seemed to
> be what the rest of the script was doing.  I didn't find any
> multi-line calls to die, so that's why I did it this way.
>
> I'm happy to reformat this to your taste.

Nah, it seems your plan is to deprecate this script over time and
move everybody to a newer implementation, so as long as "die" does
its job to stop and prevent breakages from spreading, that would be
fine.

Thanks.
