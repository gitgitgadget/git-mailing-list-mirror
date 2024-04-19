Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01314B669
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543708; cv=none; b=Cu4bCejWs2OQm18nn63XKTYRIqhJjYNINoWUpK+SWmLXzKpeps2bG1ZhnYwTEKaIFJTdyY+3Ftr1PPVMJB6QT3NLY9aah+GzavyJMTftvbOg7yEXdznYPqVqpsdrYg6sUu00L7Zc8TH4tqeIQTij3el8w9VNXXYzAuOhFKVdOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543708; c=relaxed/simple;
	bh=xOxfUWEVhBzvyYzlWvuHoQbPVbGVaDemHF4gT8VVa8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QRVt0orVJnK55RxziwV1gcay9UNIpB9EqLIu5vOw2KDkhQyY6X+Ina3BJxbSMMcuLh+XY37H71m3rOkHvStkFLGHqExhVyMOaRN3a0eKZLoT8k39CdqAEfLCcPssXOYojnh6qM2TTvG88A7BLOK0/jh5uunGtZOeMBGHiFeQGh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xw9o4J7e; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xw9o4J7e"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E74DD1F3DB3;
	Fri, 19 Apr 2024 12:21:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xOxfUWEVhBzvyYzlWvuHoQbPVbGVaDemHF4gT8
	VVa8s=; b=xw9o4J7e+K4q6H+/CvQ3SeIcjv00KFiKnm3JoqRUte3ATiz1vqgDpk
	S9K9uVEFs5ZUldyjDIFZLeoNshjjVagIBJiZVl6DQm9l6C2iqL5crWuH3OaAq8sO
	7Ptqy1LAfZFvgUgZf/u57cu5HrTaTtQhd0KDwwM0m7iLKpnxCOCqw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF1E31F3DB2;
	Fri, 19 Apr 2024 12:21:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45C1F1F3DB1;
	Fri, 19 Apr 2024 12:21:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  Phillip Wood
 <phillip.wood123@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding
 "RESEND" to patch subjects
In-Reply-To: <CAPig+cRpxvYAJpHahsWxRP=ekr9wwWoxK9_c0vRehDiuzgP72g@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 18 Apr 2024 23:07:12 -0400")
References: <cover.1713324598.git.dsimic@manjaro.org>
	<1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
	<154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
	<xmqq7cgwau1v.fsf@gitster.g>
	<c2cb9268c29ae4a5cac34383b7443763@manjaro.org>
	<xmqqle5b66sr.fsf@gitster.g>
	<19d5f3d4c99fc1da24c80ac2a9ee8bf8@manjaro.org>
	<84dcb80be916f85cbb6a4b99aea0d76b@manjaro.org>
	<xmqq5xwepafi.fsf@gitster.g>
	<CAPig+cT9A9N=zGZDXuB+c17L8hZ-h5zvZgD5W-8VYqiM9QaBew@mail.gmail.com>
	<xmqqedb2nlpf.fsf@gitster.g>
	<CAPig+cRpxvYAJpHahsWxRP=ekr9wwWoxK9_c0vRehDiuzgP72g@mail.gmail.com>
Date: Fri, 19 Apr 2024 09:21:44 -0700
Message-ID: <xmqqsezhl3vr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EA1F51B6-FE68-11EE-89C8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> ..., but the value you seem to be missing of the separate "--rfc"
>> is that there are folks who configure something other than "PATCH"
>> to "format.subjectPrefix".  They do not want to keep typing
>> --subject-prefix="PATCH net-next" on the command line, so they use
>> the configuration variable, which is "set it once and forget".  The
>> stress is on the fact that they can forget about it.
>
> Indeed. I was unaware of that behavior.

The very original --rfc did overwrote --subject-prefix and did not
have a good reason to exist.  But with the relatively recent update,
it gained its usefulness.

Thanks.
