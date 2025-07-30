Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455A22A817
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884933; cv=none; b=J+2XWlNDeA4bH+mmcbWl6hPjcnA1orWbGSKp28wzbvpWEhVc4nJAaHgJap5Yz+6gF71jJGPEsDYWi9TuPi3zdUzhbJ5PL6nkZzUFEieeB++46mrKUwJ+XSGoMYoUnIxqmCVQswWalWl/TAv6H6Yt6NzNnYElqJ4postwEha2oQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884933; c=relaxed/simple;
	bh=JISQMmMRoJLP2ikVaHlYPqG0KVHQzjy5zGNVm4xfVJU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PIoFAC+KdilJnLASjyFFZQwizI2kT8khED2V8ZYgLEoR6euZJnBm02PqPPk2Ej9eR65RoUb8JM32cBPoYVCHhVa49PpNVEDvUkSHMST4BWOn7uCNjEnSjLjM9r7Yg62wWWjW4TgLVdYcWTfOqiNVle2bBDxBbqMeal2Hsmfci+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TqFP8tRA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qfmz1fvh; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TqFP8tRA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qfmz1fvh"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D497EC01AD;
	Wed, 30 Jul 2025 10:15:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 30 Jul 2025 10:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753884930; x=1753971330; bh=uEOTksqshC
	yJzevW5zZoq4hq88uxYUgyUfmoeCzn4e8=; b=TqFP8tRAB0cjtReZFOaXqUu3Qu
	Q5DbcfVD3uH57awdo1VfPSe9NsFPxZUQmqq1uPeBLdMjuvjnf/Bguih4j4RAIn8e
	5j+gSIX3zPIaOcCWk8NhQ/gZzimJW0AiFvSKcI5whKmIOaS8NUMVa7MsKzkbxHfe
	9Ii7PklnYFgCqJDOoQowCx6iV4UIf2hSUWGf68Gs4QKnIq0gIgUdAHH/wHMCt1K1
	Ky2Q4Pl365Q6D0k6nPWNhzuXdANPCMt0UMkrSH1mcpEouhwANXCjHQhlr6W6iOfL
	LUXVA+jbf3YaniFok1OBgEvP61DiTJLmYfrgtxemHxrFSr7NEMIm7qHj3ODQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753884930; x=1753971330; bh=uEOTksqshCyJzevW5zZoq4hq88uxYUgyUfm
	oeCzn4e8=; b=Qfmz1fvhMYbGbSXGdzTVuNr2Kgn7wAe1zpPzzQBFDcpB8EZZxcn
	4lL2vA+AAsibQv4tBlhmBuQeTwP5ONr5oASk1grQjvBpAwP2WaeQwed/KUY/WNJy
	IArziN60J/WXXG2XrsUATCV65EqYcfEV3EnleonTsn0NXa10YbiI+k4TGmGAHlHz
	HlhVB6F+yyPK9QIj5t4daHGIgXbvNT0htStJduJqD/Px/FJFJGyI422fhyoQUMqZ
	R7qmfAjnQ4U7gW1fqmZ7FNva4RSBLMvWUtO3A/194duxW9/rXnFs5DNiwO54oEPj
	j9H6uzStmoX/tMMZnVws1NR1uKiXZwEDoOQ==
X-ME-Sender: <xms:ASmKaJTh3CKWthCQ976tuFRBQucDJzdG8Lx6swRSJADkDxBBslPNag>
    <xme:ASmKaGAMpcsKFisaOtDVae6KP39RsH9Ri-fRkN_smrI6JvLyfIHUkKAPdSy_VN4Mt
    d0dmoBcATTgwOohug>
X-ME-Received: <xmr:ASmKaIQIr4_s1ij4nFCY7o8eT7ve_3hT6Dvg1yrEDpfnghwRwQOMXNrmZ52vVU4kHXNLmHZFeT9fRYgAIZt2xI_zBK78u7KVljCqY98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:ASmKaMqzPitBm-SCgcxUfJA2ai3PEbas9jwlY_lXKohmu-kU-UtmVQ>
    <xmx:ASmKaCyKA7SF1zwLGJVj8e4mgBeMumJg2O5wFl5rYEq0_C4feHhrcw>
    <xmx:ASmKaJJmCMoHmkzInDlGRjo8Ul7M-o-POxLMGcBpNkYXUd2TKwXHdg>
    <xmx:ASmKaMKYgR8NoUHVYkMDido2UPATVSeqCNJeVQ38h7HSlNoAgV4YHA>
    <xmx:AimKaFmH57bfuibIbrpfPBpUrkPVOwcEwfARw-u83KMkYlkzsa9iH4pT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 10:15:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] clean: do not pass strbuf by value
In-Reply-To: <aImv4kZJS4CUqmZ3@pks.im> (Patrick Steinhardt's message of "Wed,
	30 Jul 2025 07:38:42 +0200")
References: <xmqqseieogkg.fsf@gitster.g> <aImv4kZJS4CUqmZ3@pks.im>
Date: Wed, 30 Jul 2025 07:15:28 -0700
Message-ID: <xmqq8qk5ojcv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jul 29, 2025 at 02:03:27PM -0700, Junio C Hamano wrote:
>> When you pass a structure by value, the callee can modify the
>> contents of the structure that was passed in without having to worry
>> about changing the structure the caller has.  Passing structure by
>
> s/structure/structures/
>
>> value sometimes (but not very often) can be a valid way to give
>> callee a temporary variable it can freely modify.
>> 
>> But not a structure with members that are pointers, like a strbuf.
>> 
>> builtin/clean.c:list_and_choose() reads a line interactively from
>> the user, and passes the line (in a strbuf) to parse_choice() by
>> value, which then munges by replacing ',' with ' ' (to accept both
>> comma and space separated list of choices).  But because the strbuf
>> passed by value still shares the underlying character array buf[],
>> this ends up munging the caller's strbuf contents.
>> 
>> This is a catastrophe waiting to happen.  If the callee causes the
>> strbuf to be reallocated, the buf[] the caller has will become
>> dangling, and when the caller does strbuf_release(), it would result
>> in double-free.
>> 
>> Stop calling the function with misleading call-by-value with strbuf.
>
> I think the second "with" should be dropped?
>
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  builtin/clean.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Good finding with an obvious fix. Thanks!
>
> Patrick

"Fix" is a word that is bit stronger than what is actually
happening, as the code is not yet broken ;-)

I notice that there are a few structures passed by value in reftable
(e.g. merged_iter_pqueue in pq.h and string_view in record.h), but I
only looked at the output of

  $ git grep '[(,]struct [a-z_]* [^*]*[,)]' \*.h

and do not know if they are something to worry about.

Thanks.
