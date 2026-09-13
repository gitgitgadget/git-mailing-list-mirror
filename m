Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483E25B094
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789340225; cv=none; b=Xuet3LhCMEwpwhp9+y2XvH/q+jGTOs0bWdqsWPTY4nmTSe6K0uqWUBKod1hhlyN+zofuRNsgaLIv6/3OV0493+Mz/2PdsUZayWoeLQcuuqrrBzS7NCDXVWm6OBJ6IwaTC4HUw7579EzZmErpwxf7xTW7FB7eqHXdAx9c7qyLiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789340225; c=relaxed/simple;
	bh=F1EjDJ6PR3Ygh2P22jIYDWQSAMeIUxsTCxkcKsvatlw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ifpr56DnQoHY7Si12cg0QvSd5tA+YitRE/zTNaDs1ltFf6h4Fd8YF/UcqoVbY9sr1C+wI8yCMQbLGDay5+JwUGEMMXQ/ohKPgmQfsTuq9XdzmwZcq8kveYUdo7KYH0/WqXU5JuoxAeiAgwPctYmFjEEmSSXOFYek2vbK+LUu1gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YvXXEmE2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MITtZh9W; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YvXXEmE2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MITtZh9W"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA39B7A00DC;
	Sun, 13 Sep 2026 18:57:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 13 Sep 2026 18:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789340222;
	 x=1789426622; bh=FpfAQswHqZLWwy4s2fw6JwpiyV3muuMhctCbPD1SOes=; b=
	YvXXEmE2KEV9NOFZsZUlp2N1hr80eTg1xGm7IcVKwUz7M1yWDLfSwz7Yfm3hDGmR
	k1P2igHMdk0f4SHKkYfUrvIKTrcV/2TPkP9ULlvkpeDuZ8qydbQg73qO1HEvEp5x
	8UYziizDS1tLpRiRjQwGONRzYOV1CHUuQ++I/17jamKmMwePGan8G1HAKdGWCE/c
	zuAFBCVegeLHMMnOV4PLnhbEeMgTuRGaqqfyXOFtN3upIqKZoJ+tmmY+G+k8U1/J
	PeFdloVJ3Z4aQEgUCtOaTCD9cqsIwTqZNUIVjV1ekRPZNUkF2Im6VLMRhF7sUkht
	xU5nTYl4nBffQNutlWw44g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789340222; x=
	1789426622; bh=FpfAQswHqZLWwy4s2fw6JwpiyV3muuMhctCbPD1SOes=; b=M
	ITtZh9WA7OvX4cBhOlFOOsB5XnSfIXs2FucMh17XTRiw5j9KeN2fWPcWFfEXnGEa
	eIFrtPalGJ07AoOIi8PsO7h3FZJJpjjKkUbXy/sE+kIV9M+dyMygkSuWSyIKIEdm
	KdhKIZGqqYWlEjo/yEgZEZPtLJNT3x1El6OTgpEGQPdMSDnncsf9aM6Q1wHln791
	p+BHpdtc0lFmjxYL7IFXu0Eko/3gRbdtWMAAluiL85N+hr1OTaJg5w4xUGaCUhLI
	mv1NbxvrSpsRdaP9d8p7pDcGK2KXEYK2w1WXX0SpgoFO96J7P/VQspibLO6WY9oc
	A1EJfRiou12mYmw7EonkQ==
X-ME-Sender: <xms:PiqnaoVnyyamVCh1iz38ipnWkyOKJOlmcTR1bNiJNWjo441gXXnmRQ>
    <xme:PiqnagTTqf8Ca-fTmfeRv9pZqe4nRs5pNkctzMK5kWugZU2-bLgd1KvjMpdHmd2vo
    9R92nhENgOu_rbc1ADBz_ysLY60czSdZoSx1GX1YnLTWfdFa-KNmJWe>
X-ME-Received: <xmr:PiqnamPLV7f_5gteJAZO9h9gJspJVZJDpjlyvqOT8X3LNC5F5Sbj0d6Df4KRQXT8que6qGG9GjTLt1NXSJicvR5Oy-S5xPpgaE8H>
X-ME-Proxy-Cause: dmFkZTELeQJM2qBvTbTQw3A5r3TUZUQ+5P/QGQKnDAxfeL/g4jAcfKzs0jStF3wrGbbA7f
    p+WHspiDSRGwLM4u1/6WqgQ46FC3xdFaKeOP2V5nxleMMIkfvyX8q1Md/n0eyf+G7UhmAJ
    BFtIKEDGEi8kPv6LVieIw3h7f0JVAVRzXR6yOWw49S2WUsaWAcPjHblx0x5Ygr+peG+fI/
    IgU/fkfoKi92mpUCwCt11fize0pYPtoYBweimcNv0rifb3oS3KFTr0EP9xJci+VGfsQLFm
    nTkP+mD/GnRHt9bCQXn7WTsoxcrU7BCq/9vVDx3IXMAsiva/5cNHPfTvmRV8CWc2B5uiWu
    dE2HhKuToP5FOCK117AzIOMrSsg6rDXt4ekCTRaBvkKoAUnE/8Of9bsTO66VaP0Z+oKwxD
    tD/UzIwZtMCAl+UUIIwzC5qqb0YeYN3liwwRalFfAvEGkIYbiFVE59j0xVfIvZsgg7t3cZ
    UDyEQnJuGL+Yh8JzTtuFfp8vEOTSOPcp6LQ8JwRz+Hr56tccdu3v93MQljRGB3e57Dcm6N
    mdj1GhIcN9xv/jXVgbOqY4DCETYmQS5ERACR72bAZz0M50j+ijIO0kQkl+OIBHDTZVBy7b
    HMT68HY/2wZLw4amnzAH2FtvvBIIJeUglJMWJsNjGJbQcN6danFAr36OesZA
X-ME-Proxy: <xmx:PiqnauT6TS4GBhSyfR9MXPSMMMimAFKmnI-U5tz3weWNbvFsuWO7JA>
    <xmx:Piqnakh6Qi8BOKVxZQk6JgTHmo8wv_RBMsWX87veM_pAfEwl2j5C4g>
    <xmx:Piqnan_fupLT8hGYlki5LJa1BmW0BN4h2XG_I59dPEXFSy6SP2xiAQ>
    <xmx:PiqnarG5eZf7nQOuPA8yqHbIs1MZLI5B-OSgy5lOZ7bJiSXOsIYvfw>
    <xmx:PiqnapLID5djEFndZm1LaCeNrOYrpSBWYlhgbR-NVRJvHPnBz9cA7fkR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Sep 2026 18:57:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Orgad Shaneh <orgads@gmail.com>
Cc: Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  Orgad
 Shaneh <orgad.shaneh@audiocodes.com>
Subject: Re: [PATCH 2/2] fetch: clobber existing tags with --prune-tags
In-Reply-To: <CAGHpTBLvZGAaqkue47Ne9DHPSwxx4fPo5KusP5=sh3C2AxgAMA@mail.gmail.com>
	(Orgad Shaneh's message of "Sun, 13 Sep 2026 22:03:43 +0300")
References: <pull.2200.git.git.1771187016.gitgitgadget@gmail.com>
	<b444fa7af9f39960652209143c9845a47efd58e1.1771187016.git.gitgitgadget@gmail.com>
	<xmqq1phdavik.fsf@gitster.g>
	<CAGHpTBJKaTURMJmJ6W4iiCAy3-M2YWb48rF8GMoEPCfpGcE=QA@mail.gmail.com>
	<CAGHpTBLvZGAaqkue47Ne9DHPSwxx4fPo5KusP5=sh3C2AxgAMA@mail.gmail.com>
Date: Sun, 13 Sep 2026 15:57:01 -0700
Message-ID: <xmqqy0d47oaq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Orgad Shaneh <orgads@gmail.com> writes:

> On Thu, Mar 26, 2026 at 9:57 AM Orgad Shaneh <orgads@gmail.com> wrote:
>>
>> On Sat, Mar 21, 2026 at 8:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > None of the steps we see in the added test do not seem to check that
>> > --prune-tags does clobber existing tag that no longer exists on the
>> > other side.  It only checks the "git fetch" command exits with
>> > status 0, but does not see if the tag actually went away after the
>> > operation is done.
>>
>> In these tests, the tag is being replaced rather than deleted. Existing
>> tests for the pruning mechanism itself are located in t/t5510-fetch.sh.
>>
>> Would you like me to add a check for the tag content itself to verify
>> the update? I suppose I should do the same for the existing test cases
>> in that block as well.
>
> Junio?

Sorry, but I do not have 6 month old discussions in my context
window, so no immediate comment.  I'll respond only after I swap the
context back in but not today (yet).

Thanks.


