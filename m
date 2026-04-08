Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29C38AC7A
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683666; cv=none; b=CQC9uYK8oh6GOZdKV7VOZRacMAO1dXfWYLhOU6EBIp6iXkJ7wAJhw7kcCf3PfrgQhta5ZrlE5g/6H1RGZY5nCMaopvGs/ln0OA+f4UxnGzBsofoRy0IUTb9vgOmBcqpmwMWr1cb4Ag8YlODiohM7KaB4DX2pl/Jgo7InBFXsisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683666; c=relaxed/simple;
	bh=Q95gwVg/BqHV9r+GvAqONC8kSN97EHU3mSD+BJWHZm8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=j+PQrR5RICxDDOU0yIw3rTlfla05Sb451wd4H0N8ZLHV76ZtMxQuQcrhzeQkYZN9rBA6z/EgQpjPQEeD5WqLansXnVF5QnmuhSDMDEe7fBWZe+d8L5brJqkGZEnBQ5Jd9/9ecIGKhgStDWUkSZufEWl5Y4q5Ef/IXeTHBhLfwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 638LRd563370468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Apr 2026 21:27:40 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>	<20260408041716.GA1324339@coredump.intra.peff.net>	<011701dcc767$8c2ab400$a4801c00$@nexbridge.com>	<013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>	<20260408173949.GB2850002@coredump.intra.peff.net>	<xmqq4illz5g9.fsf@gitster.g>	<014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com> <xmqqqzopxkxa.fsf@gitster.g>
In-Reply-To: <xmqqqzopxkxa.fsf@gitster.g>
Subject: RE: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Date: Wed, 8 Apr 2026 17:27:34 -0400
Organization: Nexbridge Inc.
Message-ID: <016b01dcc79e$87472860$95d57920$@nexbridge.com>
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
Thread-Index: AQIImllt8JGdGqh7Bu9hfV8wd5a54AFtvwh7AomCUMsCTyy1LAGZ2yzlAlGDzHcBlyeC0wIgPQjWtQ65z5A=
X-Antivirus: Norton (VPS 260408-8, 4/8/2026), Outbound message
X-Antivirus-Status: Clean

On April 8, 2026 4:22 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> On my box, I have the following note:
>>
>> Specifying  the sum of the iov_len values in the iov array greater
>> than the OSS I/O size limit for that open causes the  writev()
>> function  to return  -1  and  set errno to [EINVAL].
>
>That is unexpected.
>
>writev() may fail if the sum of iov_len would not fit within ssize_t with
EINVAL, but
>unless your "the OSS I/O size limit" is the same as SSIZE_MAX, what you
have above
>is not quite the same.
>
>Does your build work with NO_WRITEV=Nope?  I think I saw it asked a few
times
>but I do not recall seeing it answered.  At least we know
>xwrite() seems to work well enough on your system, which is what the
>writev() emulation is written in terms of, so I suspect it would.

Yes, NO_WRITEV=Nope does compile and execute. I am including it
in our CI/CD job for now. Can we plan on a fix for this?

