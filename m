Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB3227B83
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187353; cv=none; b=tmvzWNdsBedgDeQ2SklC7XLdNSfsJdLEaTX4Y0kh4L/aezuR31Zwiz5BHIn0hRQo19sBAOXyvcOc0ede0cHIkDkV82W4wI/tBasxCwwdHRxFVoVYEYhQUp9Mrx+Iux6xP2HMYSZ5VgEP0qokjIJnhpIh6jkAVuu47iGiH048DTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187353; c=relaxed/simple;
	bh=I3cQpen3sbg9LarS5CMKr+W05NZ2nGl5NPgpcLpzdbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7hWVN+yFwcMCj43WXfYriSWL2o+4mhLIVWb7owgVJSqFs8DAQEStbHrvTPnGBMGdrUAwOm87864JHCsIVx1Kh0IoZsp3P7UmlH+0I9/QqwiUrdJmIIEHbfWKKAmw+6vVOONcXzTSM8Ge+sVOalHpOOYsk24CAXkUwyHu6Rbo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn0DHsYL; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn0DHsYL"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c537b9fcbfso263457685a.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 08:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769187351; x=1769792151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W379m6zKEvPsVkzuvBZcBlKDhfG9gRcBK30+Try2NFk=;
        b=cn0DHsYLxiRG2kt3CRl2Fq5dUj/tvZoPTWiSPAsIm5nNtjdLpnDA06uYNHibXaeTJj
         FXypB5/GzerZX+n/QWhXqn7XkrMerdxB3eogzW6OC8C2ALvLj3SraDXqKp6D8X9O9/xB
         /FVTI7J9y/2/36tzH4uSfWRXR/ofgVgMIUbN8XvrJacWrC2qBCm1Aw/K1oZV9Ym5Qzcw
         bm5TpD5Efn+XCQfOlFMKPh78loRMnL8YlhELUpa0DwBvFqmvznJ97RNcuHVIH8j/7OYB
         rhdbNbxXju0VI9ODX/ikxHPa4dI4B9HUZYGQSm6CTZR3o045rokNsNjoN2EfTD47ha0B
         HU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187351; x=1769792151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W379m6zKEvPsVkzuvBZcBlKDhfG9gRcBK30+Try2NFk=;
        b=FYOokS8VSDZHWns4veCKFkCykZ20sMsqL/gs6rl5OM+FIsrzd5SJzTTLTtBwfo9wo+
         aMlFF2kE9jFqpazEKF5etXMCHVxRYxWUcCvGKrN3bcMCDDOdekKYIdKmIuRDW5l/2DcC
         A3czKKJXq0MAdpdAVG8lTiPpR/Rwsw9iYl3Fc1MqohnT/+15VAW+Vjyno4NO+tWmYOFK
         UXkKOJ49C5z/iiQlgROr5qX6ni9z0k6+56AutI+yivOzDEeTiy12gCdPJ+2jx5weerUO
         Q9NbsUrm8yFNieoZDfYZyHY5KPLaCeDyEJDkF9GuP5ZjcBxC8TOhZyfvza7/18rus4kj
         OodQ==
X-Gm-Message-State: AOJu0YyF/NRvmWXZtSi0lZPFIkRB+SDnLcJZwqC6SmIRCofaGx99MBJC
	Q9HV0XCZy4t4zegULkkaJPad/HycLPPCZwS/Obl/wJPLTcHSjuBApfXD
X-Gm-Gg: AZuq6aKPDpadotrELaMv0n3qkDH5V0NSn+D5knRNr8H/H9AoCVMhCYu84mgls1HeMbz
	SMh3bb/JMe0Sz/7/OtJRMSZdTfwWWYT40KxE2ZO0PxSjm+lM9C7EQ7ECENvtfdirgFXxbgsgqTP
	hed1fNvfOJP4GsHt0v72+S7y8pie9FJSQUHg8awekvVI3ucZe9expqBOXgYwvPfy93spfCNWkEg
	PpkC+bQ1HgUl6Bm5AmzX7sB3dpUVxWA6WlHC6yDJ1RQh/0z7qZiBAXMQQ4/MyRXuhY8+IwCJjn9
	z5D8RjiFUJXFztU7QvZdjRS0/DJ5dH4R5zScoQlMoIx83rJqjSodDoqbXG1CIFm20Oe7kn91tMu
	DIRshNJkpdegpoPThmFwKo7dFuESXtHdb7a8+2IpcpVHJ2adEcPguh5qSlV6exGTtjg7ihp6OZB
	Vf9buwYir5B3qSg0sMeLGRCXPM1S2BU5R5o1aiE+P17YGCug1K2yhBUkVEnDBkCRZANDVF
X-Received: by 2002:a05:620a:7105:b0:891:7008:f2e0 with SMTP id af79cd13be357-8c6da876333mr951761885a.8.1769187350860;
        Fri, 23 Jan 2026 08:55:50 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37c61ffsm212997785a.7.2026.01.23.08.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 08:55:50 -0800 (PST)
Message-ID: <f363c16c-1c36-4485-b1e9-22abe32b3a25@gmail.com>
Date: Fri, 23 Jan 2026 11:55:49 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] revision: add --maximal-only option
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
 <pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>
 <xmqqikctl3vj.fsf@gitster.g> <7daff220-f93a-463a-b586-dd876b51edae@gmail.com>
 <13ff1d94-401e-4fa7-b247-fe8396ca9970@kdbg.org> <xmqqecngjp87.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqecngjp87.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/2026 10:58 AM, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 22.01.26 um 23:15 schrieb Derrick Stolee:
>>> Unfortunately, it also says "print a minimal subset" which in some
>>> sense is correct by "it cannot be made smaller without losing
>>> information" but we actually choose the maximal set there, not a
>>> minimal set.
>>> ...
>>> You are presenting interesting overlaps of terminology and needs.
>>> One thing that is different about 'git rev-list --maximal-only' with
>>> a list of starting commits is that it wants the maximal set from
>>> the _union_ of the histories, instead of the _intersection_ like
>>> 'git merge-base --independent' does.
>>
>> I don't quite understand how a union or intersection come into play
>> here. The difference between the two is that `git rev-list
>> --maximal-only` permits negative revisions as input, but `git merge-base
>> --independent` does not. In the case where the input is only positive
>> revisions, the result of --maximal-only should always be exactly
>> identical to --independent, right? Even if the revisions are on
>> disconnected histories?
> 
> Ahh, it is an ancient history that I forgot how the command worked.
> "merge-base --independent A B C" does not do any "merge-base"
> computation over the commits A B C and shows the ones that cannot be
> reached from any other.  If it were to compute merge bases across
> these commits and then find commits, among the computed merge bases,
> that cannot be reached from any other merge bases, "intersection"
> might come into play, but I do not think that is what the command
> does.

Interesting. Thanks for the correction. So we _do_ have a way to
get this information for a range that doesn't have negative refs
or other custom walk modifiers (and this implementation would be
faster for this case).

My patch includes test cases that are not covered by the
merge-base command. I don't think it would be valuable to extend
the merge-base command with even more cases that don't actually
output merge-bases / intersections.

Thanks,
-Stolee

