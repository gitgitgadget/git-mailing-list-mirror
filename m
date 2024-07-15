Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80250224EF
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721065185; cv=none; b=aPJLgo1kXbeR0fHmXXUocgIdDuUj6Lrhm5bav139TGQYsAeD7mpLdMTAI/yw9QWAuA8NUyIOXhgWCOeREaoM9Tc/ipVmJU5dypUfeMN56rnFXfpr3apUmRaf6H+OrQ1gR+oiYz7ragvpUjrFRH0oKYalLEfClUg92bGK8Ky3lf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721065185; c=relaxed/simple;
	bh=ryoaSr8blJ3OSfNx1v0XvvToYEn85pFoSmWPGyxedvw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MXONTiKHz5mZGahWHoG25x8NbsATJxSjME/NKJHy7VYAQPGNRmRhzNQ/DIhY01DiYbN+8UT3pAx251rjGVlibByQvBMbttOngiy0VFX98yBoe0r7irUb6DBvMZpKl9UPZggHn0Ctf3icIWVsYcEa3NjZMmObS+Jna1RjEYsbbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46FHdUbD446238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 17:39:31 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>, <git@vger.kernel.org>
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com>	<xmqq8qy4adl4.fsf@gitster.g>	<001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com>	<xmqqttgr9aeb.fsf@gitster.g>	<ZpQVwyVQT8Wf5AeX@tapette.crustytoothpaste.net>	<004501dad61b$b35b7f30$1a127d90$@nexbridge.com>	<ZpRKu8Xsz70xNHFp@tapette.crustytoothpaste.net>	<xmqqv8167kd8.fsf@gitster.g>	<00af01dad6cc$41f10d40$c5d327c0$@nexbridge.com> <xmqqh6cq4ngc.fsf@gitster.g>
In-Reply-To: <xmqqh6cq4ngc.fsf@gitster.g>
Subject: RE: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
Date: Mon, 15 Jul 2024 13:39:25 -0400
Organization: Nexbridge Inc.
Message-ID: <00c001dad6dd$f336c3e0$d9a44ba0$@nexbridge.com>
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
Thread-Index: AQLxORQfyENxav+zmXZW2AfFrMp2ygG7wSa1AglWfbcCCOoxCwFeXAgQAPqT5zMCVerbsANm6pyfAUDhh9oCbYW5kq8+uBPQ

On Monday, July 15, 2024 12:42 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> What is strange is that when running on NonStop using ksh, t0000.1 has
>> never failed. I think the situation is subtly different from what we are
solving.
>> My take is that there is a difference in the local vs. non-local
>> variable set semantic, rather than just accepting the keyword. I would
>> propose that we need a more comprehensive local test to verify the
>> actual expected semantics rather than just testing the syntax.
>
>It is possible that I may be misreading that first test, but as far as I
can tell, it is
>testing not just the syntax but tests how the variables declared "local"
behaves and
>should notice if they are not localized.  It checks that "local"
assignments in
>try_local_xy does take effect, and (more importantly) after try_local_xy
returns, the
>original values are restored.
>
>As I speculated earlier in an earlier message, the breakage you reported
may have to
>do with interaction between "local" and use of a subshell, and perhaps we
can also
>check that pattern in the test.

That is that I am also suggesting but did not say it as precisely. Thanks.

