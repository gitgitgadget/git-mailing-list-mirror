Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E2A55
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 00:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738195669; cv=none; b=MhP65Aj6qtH9dYSnkk5ecmd5R62K/dg1TX1p6zDqNhT9VvJjq/SZguUeko/KId1i5PuZHyk40oKJBCdKB27rxg4KbqpOCYsT6BEoiYPOU1jGCByRhk+wm7tKhfLwYYA262FLcGzB47ghFJqPyGUqov5yxn71SiLvER6+JU23z2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738195669; c=relaxed/simple;
	bh=rZDQku/H4NnQFlVcRH/GmRiPPJUt6IzpUsxolfce9tI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=KLT9JTTDB2i8W5Z8zQzXnR3MW2BJ6qStXyhk0RxAEidQkrlx4daI1by2p50xNggX93lphDC2K3Dg8dlapPPiG9973W2gNeX6xKqC/9PmftS4aWb+kXoW8cpyzixIkXpv8nEaa/QP9qWgo87VGs6rrghuwAwLsoZ2MGjopshcHNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50U07hkK2040047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 00:07:43 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com>	<xmqqbjvpk1wo.fsf@gitster.g>	<008201db726f$6e6990b0$4b3cb210$@nexbridge.com>	<xmqq5xlxidh6.fsf@gitster.g>	<009c01db728d$164a60d0$42df2270$@nexbridge.com>	<xmqqwmedgpkf.fsf@gitster.g>	<001201db72a8$72719480$5754bd80$@nexbridge.com> <xmqqfrl1gosc.fsf@gitster.g>
In-Reply-To: <xmqqfrl1gosc.fsf@gitster.g>
Subject: RE: [BUG] PREFIX environment variable ignored by git config --system
Date: Wed, 29 Jan 2025 19:07:38 -0500
Organization: Nexbridge Inc.
Message-ID: <001501db72aa$fc812350$f58369f0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQN9fsp86lG5K0M4uVvG8mjsU9to7QHrUQSBAdADBhMChc+5BwBRHwqvAunZ6BQCaak4ygJoX8Lsr3fmXAA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250129-6, 1/29/2025), Outbound message
X-Antivirus-Status: Clean

On January 29, 2025 6:54 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> Those of us who have written documentation for much of our lives,
>> really miss accuracy. There are companies where a wrong bit of
>> documentation is considered as high severity defect. Regardless of =
that...
>
>The association with that "book" and those who hang around here is that =
we could
>contribute corrections to them, as they are open source and we are =
friends, but
>that is about it ;-).
>
>I am reasonably sure that they will appreciate a well researched pull =
request (and
>"well reserached" does not mean "somebody says this is incorrect" but =
needs a bit
>more than that).

Well, we are all friends here =F0=9F=98=89=20

Be that as it may, the following seems to work:

$ GIT_CONFIG_SYSTEM=3D/home/randall/etc/gitconfig git config --system =
--list
fatal: unable to read config file '/home/randall/etc/gitconfig': No such =
file or directory

This appears to do exactly what I am looking for. When I create that =
file, git picks
up config values from that file.The question is, is this environment =
variable actually
sanctioned or is it just coincidence? It does exactly what I am looking =
for.

