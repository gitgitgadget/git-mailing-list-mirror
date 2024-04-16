Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F85A84FDE
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255998; cv=none; b=Uo4fR6yqAoNmZbGQm2jmJeCgy0LpozkjQaCPJ3ktXm+KJSvv1pXLwek8h40HP7dtXflRkN0NmR/ydCm6sA4SxwTAvZ3yEwzVtTPe5Ihu4vbQjS6CCGb2/etRYtoZCtJWoOwaQogpKJhmle42fEcJ8XiNmMdRYqkjmaz57eN4jdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255998; c=relaxed/simple;
	bh=aQ5ZWDEsjEy0Kui4DbZmRefWw6ALkn+JcNL4Ij4kDDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eSwyWXZ83Oxm4h5f5ihrSAEI3+c1fcQ1H48CKHDxaQ4u1eCQqSULN0tWdT53UfJoIC6yeX1udm2mE2qHY/k0zS69nvRV4m4+868cRWu6hYfqT8uFKadPnAnBfbRTYrlVq30BTZ20fODzgr4TA0Twplf4fLgZRgP6Sb44oX2dczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=n0ZN2PFr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n0ZN2PFr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC1D41D1525;
	Tue, 16 Apr 2024 04:26:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aQ5ZWDEsjEy0Kui4DbZmRefWw6ALkn+JcNL4Ij
	4kDDM=; b=n0ZN2PFrrrzXG1vMmLEVCHL4LhfbmY2RBomrNQAS3aE4JjK7/baY3g
	snx54dRg1y69PhKzYtVT3breWurGQDIdrr3YR0pGPejEOoE2uXytEbUv6oCJbJU1
	Wo/G15fO0HRJcbEhFl23BWUqdG3PCrCNTT9U04PZ557Cx0hhQyGZg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C40611D1522;
	Tue, 16 Apr 2024 04:26:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 276E41D1521;
	Tue, 16 Apr 2024 04:26:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #05; Fri, 12)
In-Reply-To: <Zh3K3aDxWMPCNlOA@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 16 Apr 2024 00:48:29 +0000")
References: <xmqqfrvqhwlg.fsf@gitster.g>
	<Zh3K3aDxWMPCNlOA@tapette.crustytoothpaste.net>
Date: Tue, 16 Apr 2024 01:26:33 -0700
Message-ID: <xmqqbk69hfwm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 08ED22BC-FBCB-11EE-80C4-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2024-04-13 at 01:36:59, Junio C Hamano wrote:
>> * bc/credential-scheme-enhancement (2024-03-27) 12 commits
>>  . credential: add support for multistage credential rounds
>>  . t5563: refactor for multi-stage authentication
>>  . docs: set a limit on credential line length
>>  . credential: enable state capability
>>  . credential: add an argument to keep state
>>  . http: add support for authtype and credential
>>  . docs: indicate new credential protocol fields
>>  . credential: gate new fields on capability
>>  . credential: add a field for pre-encoded credentials
>>  . http: use new headers for each object request
>>  . remote-curl: reset headers on new request
>>  . credential: add an authtype field
>> 
>>  The credential helper protocol, together with the HTTP layer, have
>>  been enhanced to support authentication schemes different from
>>  username & password pair, like Bearer and NTLM.
>> 
>>  Expecting a reroll.
>>  cf. <ZgSQ5o_KyqDaxz1m@tapette.crustytoothpaste.net>
>>  source: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
>
> I'm working on a reroll and expect to send it out a little later this
> week.  I believe it's currently finished and I'm running the tests with
> `git rebase -x` now, so assuming that passes v2 should be out soon.

Thanks.
