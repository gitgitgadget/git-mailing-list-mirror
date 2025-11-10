Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B95031E110
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798449; cv=none; b=uE/ntUQymTZOEt4RIt2qia36JYXLg3JudCMw+Ql/2KcpcnHXP2ou/H67+D6nVyKcBfrHsHbslmQNsMtWCEzGNYsN4sgF3BMNpogjNgFQFRdgJuffx7/ptI1lNpHq2j9udpkqYcZZRBRXCwy6LXT158+7F6A7sJM4uJj7LS4J3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798449; c=relaxed/simple;
	bh=50P6wzDqnzWH0/g2pSGANCPNMZdZ+BX1mutwD3z3L/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ope21xFR/Rd+kztTTUaXah9uttvkaeKesWb9OCrUUlMlW9T0GtEsfNkhU+USujlI80zGI4mX8e1Bqx3lSVo/iXzzHMyuvUB+Xhyolx7uivjaryCEMcafsO02idXnv+U70XsaBtq1yI6inlzCJNW5/0DZQboikgHpsi8ryh230mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l+shw3Iu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eNrjONil; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l+shw3Iu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eNrjONil"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A7C47EC1496;
	Mon, 10 Nov 2025 13:14:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 10 Nov 2025 13:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762798446; x=1762884846; bh=Y3N47nDqB5
	iV+302bmknEwM4OxHrWz0THfZ+eIwWvVc=; b=l+shw3IunLukLiuAwQ5+wG6GBv
	cwbwmdC/EMZL7he50Qm3fODEFGzDbrWW4c5A9e9vleWI1EJOnDTyOnGQSGWyfXKF
	7Ppqato9vGKlumQC0MUL2FOgzvLY+CZCxENrvF9Hnbtrty3I9wtXpJZjnnh+BJvO
	cyPKECoY66+myXpxUUuzWJU0mqKTaLCxruBE8H8pmKb5NcfsPY5s1wKS/LI0QYwi
	ORGSuDKq6c346QSRlYhsOzW57Bu0dO+WHS1Sx1BbNJhi13OrPDJeUxsm0Z2xYVf4
	TlaP234wbf6GWsVz2S1W1qZVhFvmaW6+kzuLGtWseA9TgcbFOjDTbd47Xs0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762798446; x=1762884846; bh=Y3N47nDqB5iV+302bmknEwM4OxHrWz0THfZ
	+eIwWvVc=; b=eNrjONilWge9Rz6fCwpub/c1eASbGDR2BGO45gd2J52j1dfVIgK
	AZcYFuqLbZ/mwv9+R4FGmzWiDL81oeG+jKVTizMIAe2UehHirxt98G0eMRMVbT06
	r+8FxJZ72/zqSX3pi6DoTgvY4KlL48uIrdHyaZL8oUyOOXo1uVYEUBIrYU3FlCjo
	DZpu53ZGpc5/8lWmyHtESCFlRqakMlY3EyvCL4gvJaP21Ugl/dFZzUgdIXEHIkrj
	CxOZHuVLxi0eRNycv0cZIM2RZfMehAHPRh9R1D48vBrtL7EjvGuf1RsNx+96YPzq
	jhFFRGu8lHKsYujmw4BBrfGAeHUxurUhe/Q==
X-ME-Sender: <xms:bisSaeWrvhEo3-ouSTDc95wJnR9Nlu16KIZ_wIN5ohN02xMQjs1-Sw>
    <xme:bisSaSDmjJu5tAfpkmKHfSgu2Mhisf4dRfOYgVCCXevyGYhCAo9Wku07F5TFWzLpR
    3aW5hxHtaasNqy9fwy2vmRksnXkC4k-Q2y3BUu864aEmMqGIhSI>
X-ME-Received: <xmr:bisSafzDvOsPwlXKYLGqfinvhKDW67eegmhlZW4HxJDsmh2j5H1Rjpk77IF7zibrZ3IUzfJ5OzcDu_N9XUIsuiTgr7eWR0inBTW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptefggfevvdehheeutdfhleejveetfeelleekteeufefgkeejvdegfeehhedv
    gedunecuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidr
    tghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bisSafBdjhQbI19F1XeLqfxritIA3DNT8XdP_h2650CzNsnoTmOqLw>
    <xmx:bisSacYapcwfurOi4oEY4Dd9S3vJPeBtqkW3sJ2X95rfO0gqez_lCg>
    <xmx:bisSaXjLc-U4SOEze7qkGrkkG0K1nC827uzx8VTtl77zPfBVWvyDPg>
    <xmx:bisSae57jsviz7WFJHZAX2bBR6mtdg155wDDA-00Yiz_IkzB1S_E8A>
    <xmx:bisSaSLk1VM3E4S7MvgjL5xxD1-zr_Hmpfa9t0BuCYNvQD4DJZnchLDb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 13:14:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 07/12] diff: update the way rewrite diff handles
 incomplete lines
In-Reply-To: <aRG5NSvzeie_J3x9@pks.im> (Patrick Steinhardt's message of "Mon,
	10 Nov 2025 11:06:45 +0100")
References: <20251104020928.582199-1-gitster@pobox.com>
	<20251105213052.1499224-1-gitster@pobox.com>
	<20251105213052.1499224-8-gitster@pobox.com> <aRG5NSvzeie_J3x9@pks.im>
Date: Mon, 10 Nov 2025 10:14:04 -0800
Message-ID: <xmqqo6p921sj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Nov 05, 2025 at 01:30:47PM -0800, Junio C Hamano wrote:
>> The diff_symbol based output framework uses one DIFF_SYMBOL_* enum
>> value per the kind of output lines of "git diff", which corresponds
>> to one output line from the xdiff machinery used internally.  Most
>> notably, DIFF_SYMBOL_PLUS and DIFF_SYMBOL_MINUS that correspond to
>> "+" and "-" lines are designed to always take a complete line, even
>
> "complete line" as in newline-terminated? I only recognized that this is
> what you meant in the next paragraph, so it might be useful to clarify
> here already what you mean.

Yes, "incomplete line" is a defined term people can look up in
places like POSIX.1 [*] but I do not know of an official word to
refer to the opposite.  Would it work if I rephrase it to say
"...designed to always end in a newline character, even..."?

(https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap03.html#tag_03_172)

>
>> diff --git a/diff.c b/diff.c
>> index 347cd9c6e9..99298720f4 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1786,22 +1777,36 @@ static void emit_rewrite_lines(struct emit_callback *ecbdata,
>>  	const char *endp = NULL;
>>  
>>  	while (0 < size) {
>> ...
>>  	}
>> -	if (!endp)
>> -		emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
>> +	if (!endp) {
>> +		static const char nneof[] = "\\ No newline at end of file\n";
>> +		ecbdata->last_line_kind = prefix;
>> +		emit_incomplete_line(ecbdata, nneof, sizeof(nneof) - 1);
>> +	}
>>  }
>
> Okay. I was wondering at first how this would get executed for both
> pre- and postimage if it's not part of the loop anymore. But this is
> mostly showing my complete ignorance for the "diff" subsystem, as we end
> up calling `emit_rewrite_lines()` itself once for each image.

The idea is to make a "complete rewrite" patch (i.e. what "diff -B"
decides that it is more confusing to express the postimage in terms
of "here are remaining pieces of the preimage, many lines around here
were removed from the preimage and then many new lines are inserted"
than "ok, we are removing everything in the preimage and then we are
replacing them with these lines to form the postimage".

This function is called twice, once to show a bunch of "-removed"
lines for the preimage side, and then again to show a bunch of
"+added" lines for the postimage side.  The loop iterates over these
lines in a single image, and at the end, the last line of the image,
whether it is the preimage or the postimage, may not end in a newline,
in which case we need to append "\ No newline" after it.

I just realize that emit_incomplete_line() may be a misnomer.  It is
not used to show the last line in the pre/postimage that was
incomplete.  The loop gives all lines, even the final incomplete
one, as if each of them ended in a newline.  What the helper
function emit_incomplete_line() does is to show an additional "by
the way, the previous line was an incomplete line" marker after the
contents of the line gets shown.

Perhaps call it emit_incomplete_line_mark() or something, and it
would make it easier to follow what is going on?
