Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3331282E
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924975; cv=none; b=Cqnmv3z6zPALKpFX/vHZq5BsuR5+k6sEslfdlKtF0BssLLQTY+3e3dT/xB6BCW/tmXGsqUgfxWXy+v+wO4A2VeTRAcE59zeugr6PADzr4YRO9vnKnfx+2MJnta7W4Kyb8V97bHlOFTKQSjIUTtGBRlRNSgp/qBVIX1Hg6YSzZto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924975; c=relaxed/simple;
	bh=9scD7N8ndP5icjBDd51lNdVxk4PyTEcVDFi5XR6m1Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q34xV22XnA6wL/QwVumqCksVOEcWRgcRwZ9sr26LjHrqFzME27+7J00TyfsoEl4OTZ9EATI+Hoykdg+61ArBSMYINEK6IvvzC7Zui8kWcFa3iSmAUieF4P6/2jkBFyoY3Y2pbjpk9mLnGpZe1eI0THyrtJHYMyEYSybFb5uL0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4dwXCt2MWFzRpKn;
	Tue, 20 Jan 2026 17:02:50 +0100 (CET)
Message-ID: <509acce4-d1d0-4c18-8c42-7ebe84594a92@kdbg.org>
Date: Tue, 20 Jan 2026 17:02:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: use config settings for head/tag colors
To: Shannon Barber <sbarber@dataspeedinc.com>
Cc: Shannon Barber <sgbarber@gmail.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Shannon Barber via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2030.git.1768285721660.gitgitgadget@gmail.com>
 <f55a85a0-fb57-4911-bd60-cf863da5436c@kdbg.org>
 <SJ1SPRMB0003BF77E3500DF7C96E3042D18CA@SJ1SPRMB0003.namprd20.prod.outlook.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <SJ1SPRMB0003BF77E3500DF7C96E3042D18CA@SJ1SPRMB0003.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 15.01.26 um 07:03 schrieb Shannon Barber:
> I think I can simplify it to :
>>  gitk: honor the headoutlinecolor and tagfgcolor config settings
> I pushed a fix with a corrected sign-off.
> 
> These settings already exist but the code ignored them.
> 
> I do not understand your question about a high-level summary.
> There are no structural changes.
> There are no functional changes.
> This is a cosmetic change to how the head and tag refs are drawn, to use
> already existing color configurations (that were inadvertently ignored.)

While the effect of the change is just cosmetic (in the sense that the
visual appearance of the graph labels is changed), it is not a "no
functional change".

Consider a user who has experimented with the configuration file. They
may have found that changing the value of these variables in the file
doesn't work, and then forgot about it, leaving the modified value in
the file. With this change, the value that was so far ignored, now
suddenly has an effect. It is worthwhile to analyze such behavior and
document it at least in the commit message, so that later readers of the
code and history know that the case was considered.

You should think about such effects and note them in the commit message.
Include the expected behavior in such edge cases. That's what I meant by
 high-level summary.

-- Hannes

