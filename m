Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47F1A2398
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738194579; cv=none; b=DepkiRAkxLPcoQGgwPaeE1vopfUnxm9bsM7VV3u4fVX7LF8L1l8IpLP8o7roR8HJusDAORNrx6qmANyo6GKqiDAkTuA2ypHUwY1AkLYFj/SispRfEZG40J1CavQhOgxKQbhy/fYZHzyG4bfa7iW9D1mlYw16naT0OTPlMEwGlAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738194579; c=relaxed/simple;
	bh=S6LtIeba8l2Y5pAth2wRQ4CSReWYSvmwFG5Sm7jD8PY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=AFJEbGdBu+aGWidvzYafu1/n5gofoeU5H+9LSF81ftSvM3gkz5+JnNVbbZOrU6ej+V3msqS5GuOXLdP06/+JvzuKrrmZ4ls8NJUmC56AoJCQ5FC/9UNPO7xsdomNTL/o4yIK/mvwy+A6Skei40qfxyeozdBDXfydKifxFuC6jq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50TNnWDn2037475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 23:49:33 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com>	<xmqqbjvpk1wo.fsf@gitster.g>	<008201db726f$6e6990b0$4b3cb210$@nexbridge.com>	<xmqq5xlxidh6.fsf@gitster.g>	<009c01db728d$164a60d0$42df2270$@nexbridge.com> <xmqqwmedgpkf.fsf@gitster.g>
In-Reply-To: <xmqqwmedgpkf.fsf@gitster.g>
Subject: RE: [BUG] PREFIX environment variable ignored by git config --system
Date: Wed, 29 Jan 2025 18:49:28 -0500
Organization: Nexbridge Inc.
Message-ID: <001201db72a8$72719480$5754bd80$@nexbridge.com>
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
Thread-Index: AQN9fsp86lG5K0M4uVvG8mjsU9to7QHrUQSBAdADBhMChc+5BwBRHwqvAunZ6BSvnnHbUA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250129-6, 1/29/2025), Outbound message
X-Antivirus-Status: Clean

On January 29, 2025 6:37 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> On January 29, 2025 3:15 PM, Junio C Hamano wrote:
>>><rsbecker@nexbridge.com> writes:
>>>
>>>> The documentation on the Environment Configuration page seems to
>>>> imply that
>>>
>>>Sorry, I am totally lost.  Whose documentation on what software are
>>>you
>> referring
>>>to?
>>>
>>>  $ git grep -i -e 'environment configuration'
>>>
>>>comes back empty.
>>
>> It is here:
>> https://git-scm.com/book/ms/v2/Git-Internals-Environment-Variables
>
>It is news to me ;-).
>
>    $ git grep '[^_]PREFIX[^_]'
>
>does not have any hits in the source, so I do not see how we _could_ be
paying any
>attention to such a thing.
>
>The description seems to originate at
>
>  https://github.com/progit2-
>ms/progit2/commit/c24f22d6a6b0572f5756afd64f0c2e9fa6f804fa
>
>that was more than 10 years old.  I do not know how reliable the
description there
>is.

Those of us who have written documentation for much of our lives, really
miss accuracy. There are companies where a wrong bit of documentation
is considered as high severity defect. Regardless of that...

t1300-config.sh has the following line in it:

GIT_CONFIG_SYSTEM=write-to-system git config --system config.key value &&

Could it mean that GIT_CONFIG_SYSTEM is actually what I am looking for?


