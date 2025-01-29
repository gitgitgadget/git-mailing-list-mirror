Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566072FB6
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168481; cv=none; b=fGSEZDS4OAQnFmd7ZBtCJNhF4/9YsnoChM6EB3xTQpouvXZ8ZsRnQRSpSVQqEC7stYYn/VJDcGwu7kbmPUbIfvxDmC3a6XWKAyxUSmdHrcKoKWYMn0AsfaNi/EOWgqqar/OZiZ4J1x1Kzxx3AxruYPhpBum/289k9Y7cpkwuvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168481; c=relaxed/simple;
	bh=pyYSghp7QNA2OXJTZIz0o8EjWs05vy4AwjN6wrpkR8U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uVEQr970RZZE4aXRB7OdyZYBZ2o1XRBOp/NY4iGQlrN5fGQgvIR5CU52iYpY5bqB9PQutJLLYye5KNYL/nrgpmP4hNsdgBcXR9QcFRTs96+oBRkXThZZn81Ek8PPXlmwA8FrJMm+bs+NfSSCPi643nNSDSuKbVBsntZCtklHGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50TGYU5N1958789
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 16:34:31 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [BUG] PREFIX environment variable ignored by git config --system
Date: Wed, 29 Jan 2025 11:34:26 -0500
Organization: Nexbridge Inc.
Message-ID: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com>
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
Thread-Index: Adtya29Z2issOTzTT2GvBJLJbtz4+A==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250129-2, 1/29/2025), Outbound message
X-Antivirus-Status: Clean

Thank you for filling out a Git bug report!

Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
export PREFIX=/home/randall
git config --system --list

What did you expect to happen? (Expected behavior)
Git should use ${PREFIX}/etc/gitconfig instead of the build location to
locate
System configuration items, per 10.8 in the git-scm website documentation
on Environment Variables.
Git should have reported:
fatal: unable to read config file '/home/randall/etc/gitconfig': No such
file or directory

What happened instead? (Actual behavior)
git used /usr/local-ssl3.0/etc/gitconfig instead and reported that the file
does not exist:
fatal: unable to read config file '/usr/local-ssl3.0/etc/gitconfig': No such
file or directory

What's different between what you expected and what actually happened?
The directory being used based on the PREFIX variable.

Anything else you want to add:
This appears to be a problem on all platforms.

[System Info]
git version:
git version 2.47.1
cpu: NSV
built from commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
sizeof-long: 4

[System Info]
git version:
git version 2.45.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



