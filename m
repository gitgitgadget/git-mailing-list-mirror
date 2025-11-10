Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93F32E738
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799359; cv=none; b=f7vfnySBgJIN0JW4v287p/Nuo9zw/2a+Y8cj2hH+PMcBTGHjWBXH3he3fqQmw5j5wMGRRk85hx+7i8YVSIfmprj7sq1JcXWOuuO0/8t/NJYt08bv0V743LfWmanb9C9k6szlC2nqn9uk4k0z+PKveIqQggADGmqG12c9lNvtmr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799359; c=relaxed/simple;
	bh=DIM3PdUkYmDT1OYDf1YMarbifgy9uJMC+k1xFDCv3OE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gpQBOHXWnI0I+1yox93Jh+2bsUeKNVqit48HImPZEH8QBEjz1F/xrXFEpGV0UO2tZ8jqQx1zALpFDaYGGi5mPRd+AGFE3ZG88KAOe72+1A4CHm+MfCYtI0XsGmN803zX5pm7RPqRIbAF7e8ZpumgVDI6axZovg+Nj+4fKzF5+Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BpJhyW05; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uXPo2s/M; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BpJhyW05";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uXPo2s/M"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA5BE14000CF;
	Mon, 10 Nov 2025 13:29:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 10 Nov 2025 13:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762799355; x=1762885755; bh=H+Kt+8MdAV
	Uc5iFUP0NbAHhQQ+9dhn43EaOFmjcHMtI=; b=BpJhyW05sIe3JtBNusyiIQTg3B
	M+LNEj5D6j4N96GPkD7wHKNowdi/vM/k20d1rV8KAp/0LKs5qVNTLsV3zGz+ZfMj
	K+ZFnlZQLt2axKacKR8CyS+vzo1zEfA+LkTvHS9ArOT+VT3DaliMGiLZjERilh0B
	tyUHdj8aYQlJmEuMHMbo//HOosN8V5lhGVByKnc9UZzfovoHgZiz3NKiH6zphclI
	3RXbpiLEbU7THhe3xFoJgta7tmOA7o0mMz1ac4eeaxE02RdufxQWaDbJ2jPaDC+M
	QhQ+qlD3y7BbzowpvFxUatap40dpE5Uz6vSTKE7C9geqKcjDNi+4mVoCJNgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762799355; x=1762885755; bh=H+Kt+8MdAVUc5iFUP0NbAHhQQ+9dhn43EaO
	FmjcHMtI=; b=uXPo2s/MxZPYMf6toC5a/c15IV/VQ2oA87myRL3dqhQXp1h1VLW
	C3zJJEVjq8XJASeUVOuP+frWhP5vdOdqVqW3zFBCliOZe1tUvxV/IEKyuB6nI4mA
	UPa6SyNDyCttOH+RjkPoP6FFXrhtT0QaESAzAZf0ypHcOm8h1F96SbtNlFs+c3/P
	PkM6frsCFNkpCzzvgNxZDubRYxJuR7bTewSMFuhSCi6kIa6HE1duIJ6DYm13Xadb
	pOF+WpDg2+LzR0Z+sHEAQ8D+lKOQc1L/wHLfPmaVWuGiXy0ufXE3lPB/SMum8o6o
	Ud/auEUGjhY1kYroEJy0ZfIDFb1CIBfJxPg==
X-ME-Sender: <xms:-y4SaRVkmJ-voC46xB0j58zm-5t0yg4Gedsp-9j4XiaZa06z9FzS0g>
    <xme:-y4SaYk7WLrsLCHpGvLNBfdgySK9vdXp1HD4I7qfG_YaQ1ZbwUQAFE5Zzt3NATCcw
    zDIhrroS2ZJOwDIn_-F8btzFSx6ufKixTTbcrNi4Efb2cEQ8uor-g>
X-ME-Received: <xmr:-y4SaSZ9RLvBiRRz5m0lt0KWaU92AcjOgq70boeAjnjoV5kg6oZNGD0I7I1G62SKpFxd66Ume49ar-qzVnVGsWU2DbweMMkBszw6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:-y4SaTN7wXA4IddpPO_H2dkZb4GiO0q-aRzlnj0UwGhMDQu8mifPlA>
    <xmx:-y4SaXZ8VlHaL2JwdR4aAlp9ro49CGBx0wyLR1sRMjkC74iBsH1dyg>
    <xmx:-y4SaR1QA7V_ma1BTG-OcOeYl2idXEYdGyxvKk3lIrRPSYK3A_FwfQ>
    <xmx:-y4Sadc9CpVsbNG07VN07wj2Z5hfQ3O8VYwUKkKflbk-E1SWDrpH_w>
    <xmx:-y4Sad5Ok-gIud7vlOC3lMKbQebpK2-DRScQJX1or5J7mXXbcbIUE57d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 13:29:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 04/12] diff: fix incorrect counting of line numbers
In-Reply-To: <c41f3c65-d7ef-4e73-a1e0-03540df0b212@gmail.com> (Phillip Wood's
	message of "Mon, 10 Nov 2025 14:54:23 +0000")
References: <20251104020928.582199-1-gitster@pobox.com>
	<20251104020928.582199-5-gitster@pobox.com>
	<c41f3c65-d7ef-4e73-a1e0-03540df0b212@gmail.com>
Date: Mon, 10 Nov 2025 10:29:13 -0800
Message-ID: <xmqqjyzx213a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 04/11/2025 02:09, Junio C Hamano wrote:
>> The "\ No newline at the end of the file" can come after any of the
>> "-" (deleted preimage line), " " (unchanged line), or "+" (added
>> postimage line).  Incrementing only the preimage line number upon
>> seeing it does not make any sense.
>> 
>> We can keep track of what the previous line was, and increment
>> lno_in_{pre,post}image variables properly, like this patch does.  I
>> do not think it matters, as these numbers are used only to compare
>> them with blank_at_eof_in_{pre,post}image to issue the warning every
>> time we see an added line, but by definition, after we see "\ No
>> newline at the end of the file" for an added line, we will not see
>> an added line for the file.
>> 
>> Keeping track of what the last line was (in other words, "is it that
>> the file used to end in an incomplete line?  The file ends in an
>> incomplete line after the change?  Both the file before and after
>> the change ends in an incomplete line that did not change?") will be
>> independently useful.
>
> The "\ No newline at end of file" line is an annotation on the previous 
> line in the diff so why are we incrementing any {pre,post}image line 
> numbers here?

No particular reason ;-)  As I said, I do not think these numbers
are used after these lines are seen.  At least this change makes
these unused data incremented in a more coherent way than the
previous one, which unconditionally incremented the number for the
preimage without even checking which side the "\ No newline" is for.

> Thanks
>
> Phillip
>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   diff.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>> 
>> diff --git a/diff.c b/diff.c
>> index b9ef8550cc..e73320dfb1 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -601,6 +601,7 @@ struct emit_callback {
>>   	int blank_at_eof_in_postimage;
>>   	int lno_in_preimage;
>>   	int lno_in_postimage;
>> +	int last_line_kind;
>>   	const char **label_path;
>>   	struct diff_words_data *diff_words;
>>   	struct diff_options *opt;
>> @@ -2426,13 +2427,28 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
>>   		break;
>>   	case '\\':
>>   		/* incomplete line at the end */
>> -		ecbdata->lno_in_preimage++;
>> +		switch (ecbdata->last_line_kind) {
>> +		case '+':
>> +			ecbdata->lno_in_postimage++;
>> +			break;
>> +		case '-':
>> +			ecbdata->lno_in_preimage++;
>> +			break;
>> +		case ' ':
>> +			ecbdata->lno_in_preimage++;
>> +			ecbdata->lno_in_postimage++;
>> +			break;
>> +		default:
>> +			BUG("fn_out_consume: '\\No newline' after unknown line (%c)",
>> +			    ecbdata->last_line_kind);
>> +		}
>>   		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
>>   				 line, len, 0);
>>   		break;
>>   	default:
>>   		BUG("fn_out_consume: unknown line '%s'", line);
>>   	}
>> +	ecbdata->last_line_kind = line[0];
>>   	return 0;
>>   }
>>   
