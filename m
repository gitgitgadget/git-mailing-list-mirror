Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B11B148FE1
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892106; cv=none; b=brXtwLJFXL83ER1zGiyy13dmNV2e8R2W5NH2aQ6Q9+nO6Q5Jx+zPGhJwDUkPDtjqP9Nmrra0nu6hvX3tdT+q0/0zhyX12MPedGiOSQ1qHwuCWUsYLAZvbk8Kh+hKYYFeM+h8GAiYFgM6fdgP2qBF798cA87b647R62qTULn7GXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892106; c=relaxed/simple;
	bh=xJdb5PNOhp9yOQCWiLQ49Y2JJGS1YzYi7HR+6FxOPbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sqsRtYZigIwb2KaaAZWtvEIugwkxeEXdLrAzgExakNZ41BVWe99lVFhaBpKb1dq6Y+uOWlAXgEcasUX633AUVd2Dn2/pBWjy8CNkfkck01jSEDh4Dgs3+QRQUShYouUAJPHWhObh8W66/FdLleLXH7Qax8UXOOg4IDgK9hOtuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lf8AKNj8; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lf8AKNj8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A38C41C216F;
	Fri,  2 Feb 2024 11:41:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xJdb5PNOhp9yOQCWiLQ49Y2JJGS1YzYi7HR+6F
	xOPbw=; b=Lf8AKNj8D8nGX42fo8fjYYDwGZzri7rCxWbRbjbqlcim30bNsUUQiO
	ilewTYUkuKN2CBdMspRzOKZNEjr5fPG4tFhecLnUfxeM6kJ1kTW8igLhdazx8Gwb
	vPy2qtYSh+JChb/CIxQ+3gYeUk6ngMfYuN0qIxErBLEcnwTBrnnfI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B3931C216E;
	Fri,  2 Feb 2024 11:41:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 139101C216B;
	Fri,  2 Feb 2024 11:41:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Sergey Organov'" <sorganov@gmail.com>,  "'Hans Meiser'"
 <brille1@hotmail.com>,  <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <008b01da55eb$9f3c36d0$ddb4a470$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Fri, 2 Feb 2024 10:22:18 -0500")
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
	<AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
	<877cjm53bf.fsf@osv.gnss.ru>
	<008b01da55eb$9f3c36d0$ddb4a470$@nexbridge.com>
Date: Fri, 02 Feb 2024 08:41:41 -0800
Message-ID: <xmqqcytevmwq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F240FCCA-C1E9-11EE-B690-25B3960A682E-77302942!pb-smtp2.pobox.com

<rsbecker@nexbridge.com> writes:

>>Did you consider to rather read the list through gmane.comp.version-control.git
>>nntp newsgroup?
>>
>>This way you get only very specific mails in your mail-box, those where you are
>>explicitly CC'ed, and you usually get more support for structuring from NNTP
>>readers than from mail clients.
>
> Google is dropping Usenet NNTP updates on 22 Feb 2024. I would
> love that idea, but it has a limited lifespan.

You do not have to read NNTP newsgroup via Google Groups, which has,
but will be ending, support to gateway between them.  The suggestion
was to read these articles over NNTP instead of subscribing to the
list, which does not involve anything Google would (or wouldn't) do.


