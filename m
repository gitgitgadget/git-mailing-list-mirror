Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E942BC3E
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300378; cv=none; b=YfW7Pcw0l27UcYuralL597x/sUUk//Sp3IzRG21Kn0zriCU7nnKUXLNPneYWmxSsvbxEOGdDfst3p3gQ7sHKYBBVIICkZbOVv0VqhweYOMUjqXVqm4oP2fwUBlL85nSwog0hl/oZXagWeE+jciiutADqixe3wdXZnTeioXYVZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300378; c=relaxed/simple;
	bh=eFKEqTIxX42ODi/dhv1GQlDzU2o7/Kv/3+r60JCq1i4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f3s4cFcABiWXojXq2im8eR74VnFfSIL6mGfaveJ4/wHXLk4HUZQ3GPTD+uX1p6cstgRrn53jZriH17fYS7Xq3QWpzwkmMT+HjGGRrTEQY4M1G0SmKwSpXvi6F23LnVuLUE0hyBoZCCYgf6DDfylaNR+GdLDqPe4r/w9eQSA3D64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DJT2oIV8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jrKlel0k; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DJT2oIV8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jrKlel0k"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 887F0EC01A2;
	Fri, 17 Jul 2026 10:59:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 10:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784300372; x=1784386772; bh=fuX2v795yP
	8htnE2saqN3ywZZ3xUv4/kOI9z+Kg+wFg=; b=DJT2oIV8WizaLrACaBzDu23pEo
	Bts50kYtSGqjoGIbeooT0WWKHURODMJuH71H8lqQRlvBnIGMttFcWfUmHopakoSp
	f5vkY7XbHyzSJXTXwG6NJu2svwH2jnzIzZMePpuHlHvQANQlPv3365vroJtSsDjt
	39TfI89GCB4q7WcNlQW43z7zEVyoYNU7QuAMRNKVVgk3x4WAh6NdZLQh4p1mI+xC
	uaaOFg4WfrIMSaEgHNC4tZxjA8sUdLUpN5yLazCwVCh7xLdWg827jjTbgq4ter2f
	LChV2qmGl7l7HhWiV8lH6h9cOrqy90S/ybpKLmzzKPM8QsoQMGls5p/vgypg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784300372; x=1784386772; bh=fuX2v795yP8htnE2saqN3ywZZ3xUv4/kOI9
	z+Kg+wFg=; b=jrKlel0kFn5aDgwevJCnwtAFRAOeZuD9hzxlzUkpGJcMup1X/L4
	KO6WuD1QvsiKZazGB4sqK2tuXa4LDEWgiQFZjBTiw4FACBp8K0VO8gFQQl7Wy5g5
	Sau6Q60sYJyepwqEpeQi40NR1g0LW1NNKb1Tt4dE9emH+fI9GU87Qeq6ZypH0OWW
	45oYptQ+qm87U2nIFczlnvDsqMRNCntG9kKc+LH+v2pW1eZvk9M6zcVOYSgtMff+
	fifHHybnvEMx7SIZKzJXkMMQ+bCoM1hunHwGFqmhBW7BgESbFyVHZ/u+Jm+LBer5
	ZAlttvnrzLmSvWImwTBbB9qIVdf3C1nlgHA==
X-ME-Sender: <xms:VENaakdi6jvkYznZvFmnxZGfd2WyvBvF2Hllx1CNLPlzZa15lQcmoQ>
    <xme:VENaatqZXfRrS3hpvsltDaPCn48_ueAPRYsus3sB4P6bCfq_SgRfo-TDh9FGkLAK_
    ut-ViUaFR84CGScLtnfFKC65RUDDyMAyLeWtbLIri1piNFnxVQx1A>
X-ME-Received: <xmr:VENaai5mijmr8QXnesVYgVTqTmXEd6_q98Es5wE2HOs6rgzD5E22hR45rdNJEE__RYhiv3B73HBv3iGT6LRiFT2d-qX_PWGRYLUJ-4A>
X-ME-Proxy-Cause: dmFkZTECbzuPpevVBGq6kn/V+/asmPB+myr+f8U+h6OulIHj2Mo6Ua8V+8rMMnPZ0aVAWQ
    ldIx5gj4cR8hfxFAVgMthA8kclY00lOGJLNfx17JFZYceWalX0CIsdsb5sQ715nr1TAaA2
    Pc1bxVrfv/fE7S9E6rcyp92FmCET+jDLoJiACZxa6fWnU1dMiOM3ivfDTymWsZFa89wv8l
    lTucB1RqNMCQbDUKyBkqt7wpFHH4Ez9v/+aphHweV+XWLqd60Vrw8CiP741UTS1F/LRkzC
    N2F0nCVigZYBj8j7jjIolIhUZ8Ocdlkfk/QWXY6Yom/28Ytft6/iRyD+FvUnA0tN2dOrtY
    uA8Tbk01PTXSZ0v++UTPB9piAC/yZf2w1enhmGgHxb4zx/hj4HROvqtvUkL9Nnr1TZVSpG
    Zq7SsD6Lc5KTUYGo6xcnNBIf7VTJQ4yio6mj/Qhb3wlyaE2QyQAxTyYIAjFgl3g6SUL9IF
    CxGUc/frz+2+iCSCDygMk6cFqYZ9Q1p+jwD6YpXFu03KRlL7NHRcBkX1m03dt0c9RIAHdm
    l72SfsKWdEtUPjF7JPo+AQ9lITAGn8M0IeJ6xxW+1cARlAEf7JRWxeeoRTCYN75khRH7o1
    MOInpQAVqzcjbpXUD+TiOBDhRQeCj3dlTQIWAAMY6GNJ9ZIzZSGal6cF/42Q
X-ME-Proxy: <xmx:VENaajpZ7dbgNEIR_DFy00nEao9JxTegce1QOCn8LMs8P1PAXaAUcA>
    <xmx:VENaakiVErnjbOXFzPydWIARwf9DlJeoqw-mAfEE4ljNAUC2x4Fwsw>
    <xmx:VENaatLA-ZeTeclXPGeTAGOEQqEeblbCkapB_eow-uctChvNcCAY1g>
    <xmx:VENaakDP_mM6hvt5Br8aj9WQ67zpEjQr5NGlHkTsd-uToxO4junORw>
    <xmx:VENaatz8PIqyUX7jAdxGSb5Hz3ePfUNiqkUdBYwqKyvhc_O7IcZ-Ohko>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 10:59:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] MyFirstContribution: what if I don't get a reply?
In-Reply-To: <aloOAwOtutgPbJu2@pks.im> (Patrick Steinhardt's message of "Fri,
	17 Jul 2026 13:12:03 +0200")
References: <20260711192650.2417665-1-gitster@pobox.com>
	<20260711192650.2417665-3-gitster@pobox.com> <aloOAwOtutgPbJu2@pks.im>
Date: Fri, 17 Jul 2026 07:59:30 -0700
Message-ID: <xmqqwlut64rx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Jul 11, 2026 at 12:26:46PM -0700, Junio C Hamano wrote:
>> Tell readers that pinging is a perfectly sensible thing to do when
>> they do not see a response.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  Documentation/MyFirstContribution.adoc | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> 
>> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
>> index 4832e5bad5..fc2ce2e785 100644
>> --- a/Documentation/MyFirstContribution.adoc
>> +++ b/Documentation/MyFirstContribution.adoc
>> @@ -1438,6 +1438,19 @@ substantial rework, and mention which parts of the current series will become
>>  obsolete so reviewers can avoid spending time on them until the updated series
>>  is ready.
>>  
>> +=== What if I don't get a reply?
>> +
>> +If you don't receive any review comments after a week or two, do not
>> +assume your patch has been accepted or merged.  In the Git project,
>> +silence does not equal approval.  It usually means reviewers are busy
>> +or haven't noticed your contribution.
>
> Should we also add the third reason: reviewers are simply not interested
> in the patch? It's a bit brutal, but that's quite a common reason, too.

Yeah, I agree that it would make a good addition.

