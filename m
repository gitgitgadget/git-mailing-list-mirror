Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630914C9C
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317524; cv=none; b=II32MEoJjLcUCDOc+yHcYZ1juLtTQmbgfnawR5pZBrmZaLexJDMgbD7GDG1QaNu81k+7+4j+MikQYTUKYYvLfvvNQxdIvoch4m19V+2n0QvQrK+0oyI8/FQT4r8mj2hdLmTOlwPzngiasvo/G2dLiQwy1eLjqdTp3MbSOcmIyFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317524; c=relaxed/simple;
	bh=it2yvnMhePxz4WmIxIvTbb631iDi9ymmkDe6IybRd3Y=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SGUSpl5TPVoQgKjitgh/ICljo72EzsoSQ1yuEcKKHqF7pSg2KwWP0hGSOXyCOH9C91MZZ3f/OgNxqo9gb+HAdfZDXGMaODRoh/LnX9fo7rEH74vup3GHaEoFKsbpXXf+M23QdB4CVO1u90Cz6SscNJghNfdQ9adRkyILgVW+vHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 421IP81P3099165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 18:25:08 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Haritha D'" <Harithamma.D@ibm.com>
Cc: <git@vger.kernel.org>, "'Kristoffer Haugsbakk'" <code@khaugsbakk.name>
References: <pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>	<pull.1663.v3.git.git.1708841439516.gitgitgadget@gmail.com>	<xmqq7circevo.fsf@gitster.g>	<B3775704-6FCE-4994-8682-309D521FD2CB@ibm.com> <xmqqbk7x6cox.fsf@gitster.g>
In-Reply-To: <xmqqbk7x6cox.fsf@gitster.g>
Subject: RE: [PATCH v3] build: support z/OS (OS/390).
Date: Fri, 1 Mar 2024 13:25:03 -0500
Organization: Nexbridge Inc.
Message-ID: <04df01da6c05$caaa5dd0$5fff1970$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQI5d59hLvxrIypYcVJYySPJjkAF0AHYl5wZAfFi0AECatGi+gKrkdFcsB4Y7DA=

On Friday, March 1, 2024 1:15 PM, Junio C Hamano wrote:
>Haritha D <Harithamma.D@ibm.com> writes:
>
>> The win test(7) test case failed stating the reason as "The Operation
>> cancelled". I saw that it failed after 5 hours 59 minutes of running
>> the test cases(build). How do I handle this?
>
>Those "win test (n)", at least some of them, seem to have been somewhat
flaky [*1*].  If you are certain you did not break them with
>your change, you do not have to fix them yourself.
>
>I am a wrong person to ask how the test failure that may [*2*] block GGG
submission can be circumvented, as I am not involved in that
>machinery at all.
>
>Thanks.
>
>
>[Footnotes]
>
>*1* Also I've seen osx-clang job time-out from time to time, without
>    failing any specific test.  Re-running failed jobs from the menu
>    often make them pass, which is why I said "somewhat flaky".
>
>*2* I do not even know if GGG refuses to submit a series with a test
>    failure, let alone if it allows to override such a safety if
>    exists.

Which tests have been hanging on S390? We have occasional hangs on NonStop
that end up being attributed to our CI build system not supplying pipes
properly to git. It would be interesting if the same tests are having issues
on different platforms.
--Randall

