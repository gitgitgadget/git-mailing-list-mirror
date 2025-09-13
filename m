Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36622DF9E
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757793758; cv=none; b=N818wKQEFZMaWPQ70+SuOTB7FoQfMATLa+52gUv3yd0MQJnSt9hwvnK9e7CeFTFHxzZfS5cB2rvaGBQ3SXREMfCXd6swLUHqeu9sQYflxC9/hVreEtWm88pdMvvF7E6O+Y+heRummIbPqeJW2qQ1S1OE6S1Qc6yzvSzvdBZxSig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757793758; c=relaxed/simple;
	bh=P4ZNG17kgi7EyjxtVwTxyWuSnLCA/wdBdxG80aRpGUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPDlCCxsFM2cPQvC2WfpeOk5oZnI6g1FESUAlVSGVNvVQZFrDsqZQ7LmzPR67GZ4sRJlsTR9aQlhfQFcgUGmIZaY95RgBY06d8F47+zl3PuUBMZfIKIJV/dj+Hft1gXxt3ijxH6DOW3LxXN62X5i8XQvYjv/f8bSpXuHVmXwjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=rylrFNo6; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="rylrFNo6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=exnBYMK2c/KgvHlfNZrkI/5T/GrSbO7xeb+EQA6763k=;
  b=rylrFNo6Iy0VN9CCMJAejLToqwf7hSlYYZDIW0NZNVnkFZL9+LelNkzv
   HRb18mtR1P6/DFVAHmfwFTf/AakZjixTXvWy57/89jt3Tu/uVv1WtaqgR
   yu/WAmHK0AA7QAKL2qLJs73Z9nMhBidt5g8lb+vBkRTfxywWXkFRXZB2t
   A=;
X-CSE-ConnectionGUID: FoYqpJ+UQXW+VBwL8vCT4Q==
X-CSE-MsgGUID: NY5LTsIoS5mDF/RoZUjHoA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=gabriel.scherer@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.18,262,1751234400"; 
   d="scan'208";a="238917334"
Received: from 91-168-152-151.subs.proxad.net (HELO [192.168.1.16]) ([91.168.152.151])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 22:02:33 +0200
Message-ID: <a8874cde-cd00-41b0-ba41-ab2fd52ce45d@inria.fr>
Date: Sat, 13 Sep 2025 22:02:32 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] extend --ignore-other-worktrees to 'rebase', add
 hints
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
 <F7295141-49F5-4013-911A-7730C130F8CC@gmail.com>
Content-Language: en-US
From: Gabriel Scherer <gabriel.scherer@inria.fr>
In-Reply-To: <F7295141-49F5-4013-911A-7730C130F8CC@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for looking!

On 13/09/2025 21:30, Ben Knoble wrote:
> I’m eager to see further reviews, but nothing I saw in this series stuck out as a major problem. I saw we updated the rebase test cases; should we add some more for checkout or worktree?

There is already a check of the --ignore-other-worktrees option for 
'checkout' in t/t2060-switch.sh. The test only records success or 
failure, not hints; but I checked manually that the hints are shown as 
expected.

There are code paths in 'worktree add' that call the same 
die_if_checked_out function, but I did not touch those. They seem to 
support the --force option to disable the check, and we could also have 
a hint to make this self-discoverable. (One could suggest also having a 
--ignore-other-worktrees option in 'worktree' for consistency, but 
unlike 'checkout' the --force option currently has no additional effect 
than ignoring other worktrees.) Please let me know if you think that 
some changes to worktree.c should be included in the present patchset 
for consistency.

