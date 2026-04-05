Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6B433B3
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775415937; cv=none; b=Cb+4QOOXutJ7AuExhQMxReyrYWl4L6gSYaYXS+sIVpurY97xL+gsYg4Ce35aHS1wllXTJCDLASetyR8WzQpHSNMewvllHF7IdKQI0aPeHh0bEh43HA7Odvt1h32wL25acBixQXinf6VwORqNdvdPMzjFRHXVGPollhOZwAvkjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775415937; c=relaxed/simple;
	bh=GESiEI3LGsWbZTMFExYPYUqmllIt478wKZSQ6PUzwx0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J3M4iGAfAel1qXNGSvo85bJXU+e5l5Fvs1FYN2Vx25VUjA8gN0+cu+8V7C6xwwr9n5xkU7AVp9HBOapg/MPy5hpVYh08JeuF+roERktxLn3NgvgwH/IGcgZrCC/6vy9628C3RTct8NEqZlPaPs2tNHA1Lb1RmvvNkEO1td5GL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-227-184-75.cpe.net.cable.rogers.com [99.227.184.75])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 635J5XbN2318833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 5 Apr 2026 19:05:34 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: Git 2.54.0-rc0 Breaks on OpenSSL 3.0
Date: Sun, 5 Apr 2026 15:05:25 -0400
Organization: Nexbridge Inc.
Message-ID: <029f01dcc52f$2c8b8c70$85a2a550$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdzFGhm80vhFr2KuQHKLYaWj75aZ3Q==
Content-Language: en-ca
X-Antivirus: Norton (VPS 260405-6, 4/5/2026), Outbound message
X-Antivirus-Status: Clean

Sadly, OpenSSL 3.0 is still out in the wild for those who have extended
support contracts with OpenSSL. The following errors happen using =
OpenSSL
3.0 when built with c99:

"/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/imap-send.c", line =
274:
error(252):
=A0=A0=A0=A0=A0=A0=A0=A0=A0 argument of type "const X509_NAME_ENTRY *" =
is incompatible with
=A0=A0=A0=A0=A0=A0=A0=A0=A0 parameter of type "X509_NAME_ENTRY *" (aka =
"struct
X509_name_entry_st
=A0=A0=A0=A0=A0=A0=A0=A0=A0 *")

=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =A0=A0=A0=A0=A0ASN1_STRING_get0_data(cname),
hostname);
=A0 =
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =A0=A0=A0=A0=A0^
"/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/imap-send.c", line =
279:
error(114):
=A0=A0=A0=A0=A0=A0=A0=A0=A0 identifier "ASN1_STRING_get0_data" is =
undefined

Sincerely,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.


