Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310D240604
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766848933; cv=none; b=iMy7wbEgw824My5gf9jXVc0ONdnzbs8EOaeZV+l+mw6ZxFnGKs+z8E2O02c4TrlesudyeUrNFVvt1l9wRDxuDFE5awCd2xynxW4N+DsVmO25ZMSojiw+ckIb1Z2QL6jcKYZ8k5fgEEuxcbfKPrLg9s57YDjJkd7k8fQq3rrjqNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766848933; c=relaxed/simple;
	bh=LQzfKIl6WQsO5+/zfajGeKWTDjnWW1gli5z5AttyGIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IlXqqDb8OlJ1ptT0tXHM6vrcN3l3orNB2FL1lz4w18NjOZqYk8/K6xKmQ6KL3SAMpv1KurznuUxzwifWoIAeeMg2xA/PSHnlYqWLQ4n6H+MRJWhytjivxfQRXqRZcEFM+YjDFtDTFxWrve/X+0g0pQbt9k72QT28rEFO1VBVIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail-out.m-online.net (Postfix) with ESMTP id 4ddmFc3Pvvz1qsPh;
	Sat, 27 Dec 2025 16:13:08 +0100 (CET)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4ddmFc1CNxz1qsPc;
	Sat, 27 Dec 2025 16:13:08 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4ddmFc0dNvz1qqlS;
	Sat, 27 Dec 2025 16:13:08 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id rL1j1yt7EKfB; Sat, 27 Dec 2025 16:12:59 +0100 (CET)
X-Auth-Info: bmTvfHtFkTyfSloSRcWAlXXNocV9XvnO7s45bt8BMppzgkBPli08tD0sN4h53fZ+
Received: from igel.home (aftr-82-135-83-135.dynamic.mnet-online.de [82.135.83.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sat, 27 Dec 2025 16:12:59 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 105852C1999; Sat, 27 Dec 2025 16:12:59 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Hadmut Danisch <hadmut@danisch.de>
Cc: rsbecker@nexbridge.com,  'Michal =?utf-8?Q?Such=C3=A1nek'?=
 <msuchanek@suse.de>,
  git@vger.kernel.org
Subject: Re: Git destroys u+s and g+s directory modes
In-Reply-To: <74793560-49ae-494e-afff-9b833dd25d1c@danisch.de> (Hadmut
	Danisch's message of "Sat, 27 Dec 2025 15:40:11 +0100")
References: <eb36360d-f539-4f77-b175-57330ef05eac@danisch.de>
	<aU_lqe2Z47STv68O@kitsune.suse.cz>
	<008901dc773c$f05508c0$d0ff1a40$@nexbridge.com>
	<74793560-49ae-494e-afff-9b833dd25d1c@danisch.de>
Date: Sat, 27 Dec 2025 16:12:58 +0100
Message-ID: <87ldiovtz9.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Dez 27 2025, Hadmut Danisch wrote:

> Am 27.12.25 um 15:27 schrieb rsbecker@nexbridge.com:
>> There is an option with ubuntu: Access Control Lists (ACLs). These provide
>> override security for directories that might assist in your process without
>> having to worry about git security settings. It might be worth looking into
>> this option.
>
>
> This does not solve the problem, since ACLs do not propagate into newly
> created subdirectories, as group ownership with S_ISGID flag does.

You can set the default ACL on a directory, which is then inherited by
all newly created files.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
