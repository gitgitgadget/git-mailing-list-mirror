Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC627FD5D
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080819; cv=none; b=RLYJElRDwdi5gG4g6WBfIfgd38E3nkUDodX4vBl61V2ms6bnbIWfxb3PWrU/MpLQiQTBwGrwnqg4kibqEIvNzmxHRA8h9CQbJ2F65twvyCHHNArDrlWg7+DlVD16ka9F8J7i2i9tEIrxBsFX6Ox96rxUhAUCxRmIoe69ghmJx3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080819; c=relaxed/simple;
	bh=HW1cwn4c8ysNSBv0SNSaJewZKHxXNxu77S18EBJayhA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qCcYDj9CnZOUw0UrwIIpuMureZPgy0jBZbUqiWCDejS+tnd+0NN5QCNam/pqja8QON0gxc5NE0EG8MaTt4Rv0pCeYcEcvqjlh1bobRGi+UfXsnv7XeDMNsVF2lYH7WPFxHxVHQlzhjk3LJy3xHeJWyR84RJScjY0FoIKE1Ly8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 59LL6tjg108699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:06:55 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [BUG] Strange git notes completion behaviour
Date: Tue, 21 Oct 2025 17:06:50 -0400
Organization: Nexbridge Inc.
Message-ID: <012601dc42ce$a1adcb50$e50961f0$@nexbridge.com>
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
Thread-Index: AdxCzelgpE3EoENiSRKfXz1vGNBfgQ==
X-Antivirus: Norton (VPS 251021-10, 10/21/2025), Outbound message
X-Antivirus-Status: Clean

Hi All,

I tried the following in git 2.51.0 on NonStop (big endian x86):

git notes add -m "Test Note" HEAD
git notes show HEAD

The git notes show reports a completion code of 037777777764 (-12). This
gets
hidden by bash, which truncates negative results so it shows as 0, not -12.
This
only seems to happen in git notes show, not any other commands or
sub-commands. I checked in gdb and this is in fact happening. Anywhere I can
look to try to find where this is failing?

--Randall

