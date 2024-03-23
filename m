Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DA42CA4
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711235210; cv=none; b=fyJAQmOAvzj5eAVpP81C4eUslPsxU08CsuN4rHoBz4SUc8CrgJwR06neKrlBE35/a3sW9Ev2XPoeoajZH8ZOYal8hZcv2lQeswh5i4bnCZDUyPEoopLIkp38xUZ2hXcMDuVDiZiAAYq4QyMSAibWxdp4YF0CcDyBBeBjeTCvKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711235210; c=relaxed/simple;
	bh=yjsMXXnNr4gxlwDWHFs8EH40WOvwRN1yIiP0ZuGlBtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZmZy8flYmF0B9z7UXAZ40q/L4EhiZnCVklFUdEmopWkuqcuMdZLX/+EiSbts7d3HCRrDvhAU6ri1epnFl506NWE8DqbsjVKoB0BlzJt1TmPNfZXiCOFcJeK1+kmWteMZS91vpY1feDd4a8k+zO4cBcENnm97/dezQBpcZ51l2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=dr4zz9C4; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="dr4zz9C4"
Received: from localhost (ip-109-42-177-242.web.vodafone.de [109.42.177.242])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42NN6bkU024212
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 24 Mar 2024 00:06:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711235198; bh=yjsMXXnNr4gxlwDWHFs8EH40WOvwRN1yIiP0ZuGlBtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dr4zz9C4DB2FUh1TQK2MjzzfeK/XE5mUnEXPZb+XBTIGouFrtorCEhcZyeIeVNnUA
	 cT2wq6fhj2GCMXDIVU3wz4bmHngt76TkZjVglJoXPhXgtTbcv+yvT9YH2OQ44WFCbj
	 /jSfnSFFAS7fMhY5lcyJpEF2XPQBT1Ax4DiLBQDY=
From: Dirk Gouders <dirk@gouders.net>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer
 <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
In-Reply-To: <p5fii3tmfb6l7dgc2p35euwv4cp6ag64qqhb63wfu75iphqknu@tdo5ru6modr3>
	(Kyle Lippincott's message of "Sat, 23 Mar 2024 15:00:42 -0700")
References: <cover.1710192973.git.dirk@gouders.net>
	<cover.1710840596.git.dirk@gouders.net>
	<p5fii3tmfb6l7dgc2p35euwv4cp6ag64qqhb63wfu75iphqknu@tdo5ru6modr3>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 24 Mar 2024 00:06:32 +0100
Message-ID: <gh4jcwzgxz.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kyle Lippincott <spectral@google.com> writes:

> On Tue, Mar 19, 2024 at 12:23:10PM +0100, Dirk Gouders wrote:
>> The second spin for this series.
>> ---
>> Changes since v1:
>> * Added Emily to Cc in the hope for a review
>> * Remove superfluous tags from [1/5] and [3/5]
>> * Replace bashism `|&` by `2>&1 |` in [5/5]
>> ---
>> Dirk Gouders (5):
>>   MyFirstObjectWalk: use additional arg in config_fn_t
>>   MyFirstObjectWalk: fix misspelled "builtins/"
>>   MyFirstObjectWalk: fix filtered object walk
>>   MyFirstObjectWalk: fix description for counting omitted objects
>>   MyFirstObjectWalk: add stderr to pipe processing
>> 
>>  Documentation/MyFirstObjectWalk.txt | 36 ++++++++++++++++-------------
>>  1 file changed, 20 insertions(+), 16 deletions(-)
>
> Aside from the small comments on 4 and 5, series looks good to me, thanks for
> working on this.

Thanks for the review -- especially for the detailed explanation and
suggestions on 4.

Dirk
