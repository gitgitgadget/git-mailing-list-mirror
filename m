Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255C1605B8
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857910; cv=none; b=CbqCSbuTuEljagrkQ00A1DVS4YBvUgOhIgvZ3BTkD0qjKhjWqgWlcqEXcxQHjPyxHM/qiw9qTXpOtopoWy0Hn2O1BQhyQ/n4fI9ggIR1QJCJ9b9L4FU3+1R82yoJo8cnMgCzIwkfN8QoW4KKXOpMSe9NgmoUn+U+9beJHyJu57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857910; c=relaxed/simple;
	bh=H+u2bqJRcrH8jcFloGqwB7JMcoN77zN5YIO562yaHWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S2ToOhTvRBKU69GdlwVSffAzM3cR5nIeOskr8Gyx3Q/fjD89bJAGrRogBLCqQhGz73wTV9Vz29pXGKVLMRQSKHOblj0WurcDxCBoFA5hqZEiFjdtYqaNhK4Dhrw3LNbUbPpgoL0XthOREj8kG0hGxaWNTH3DC97St93PsiblAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uyARqNXE; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uyARqNXE"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B101E1C9575;
	Tue, 13 Feb 2024 15:58:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H+u2bqJRcrH8jcFloGqwB7JMcoN77zN5YIO562
	yaHWI=; b=uyARqNXESnVBLmLKwjiQGk2STNotCOPBXE45yej1QOWw0G0O3Ck011
	ulWHNDhhPd4IPSOPEsFSp8beixGCg8vvhku7oYjalAUVZi0inXaUYAXCeRIVIVHk
	yibrt9/5Jdeb2erOqD/WyslXm94PwpoqCBtGsEFhXWHHl8ySwd8z4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A8B091C9574;
	Tue, 13 Feb 2024 15:58:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C5DA1C9573;
	Tue, 13 Feb 2024 15:58:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  "Tiago Pascoal"
 <tiago@pascoal.net>,
  "Chris Torek" <chris.torek@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] column: disallow negative padding
In-Reply-To: <dc1be818-e793-44f6-98dd-b159e043da28@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 13 Feb 2024 21:32:32 +0100")
References: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
	<cover.1707839454.git.code@khaugsbakk.name>
	<48b96426-9231-4e80-b55d-628dd8847337@gmail.com>
	<dc1be818-e793-44f6-98dd-b159e043da28@app.fastmail.com>
Date: Tue, 13 Feb 2024 12:58:25 -0800
Message-ID: <xmqqo7ck3wum.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A2480AE8-CAB2-11EE-A93F-25B3960A682E-77302942!pb-smtp2.pobox.com

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

>>     There are not many users of OPT_INTEGER, and a quick check gives me
>>     the impression (maybe wrong...) that many of them do not expect
>>     negative values.
>>
>>     Maybe we should consider having an OPT_INTEGER that fails if the
>>     value supplied is negative.  Ideally, some kind of opt-in machinery
>>     could be desirable, I think, for example to include/exclude:
>>
>>     	- negative values
>>     	- "0"  ( may not be a desired value )
>>     	- "-1" ( may have some special meaning )
>>     	- ...
>>
>>     I'll leave the idea here, just in case it inspires someone.  Thank
>>     you.

Interesting.

I wonder if there is a correlation between "never negative" and
"handy if it took scale unit (like 2k to mean 2048)"?  If so,
perhaps we can replace those that use OPT_INTEGER to use
OPT_MAGNITUDE instead.

Thanks.
